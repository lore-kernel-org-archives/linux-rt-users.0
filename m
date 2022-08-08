Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E6C25B0C
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiHHM4x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242678AbiHHM4o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:44 -0400
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF338BA
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:40 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 31A80416A3;
        Mon,  8 Aug 2022 14:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 31A80416A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963397;
        bh=BHiUPLrE1mzv83ZqhZcFw7zyE5c6AaSMp8lrSZr3YEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0S+My0tcVC6vcQCQkfDKwgNbfe7JHUuC3EpjNxLw0atAyU9LyoylH5GMPvFpRWX0
         ZIpdryXCl7q1TOUvlfrgQ62rgEDhkpKWRAqnjKhTgY7LUR/vAr3uUK2HYAgBmtuZUR
         fwMQTvVY1wSxVv3RmP7g9kfSStB9drj1koyBEQlI=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        kernel test robot <oliver.sang@intel.com>,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 05/10] mm/memcg: Protect memcg_stock with a local_lock_t
Date:   Mon,  8 Aug 2022 14:55:57 +0200
Message-Id: <20220808125602.97747-6-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The members of the per-CPU structure memcg_stock_pcp are protected by
disabling interrupts. This is not working on PREEMPT_RT because it
creates atomic context in which actions are performed which require
preemptible context. One example is obj_cgroup_release().

The IRQ-disable sections can be replaced with local_lock_t which
preserves the explicit disabling of interrupts while keeps the code
preemptible on PREEMPT_RT.

drain_obj_stock() drops a reference on obj_cgroup which leads to an invocation
of obj_cgroup_release() if it is the last object. This in turn leads to
recursive locking of the local_lock_t. To avoid this, obj_cgroup_release() is
invoked outside of the locked section.

obj_cgroup_uncharge_pages() can be invoked with the local_lock_t acquired and
without it. This will lead later to a recursion in refill_stock(). To
avoid the locking recursion provide obj_cgroup_uncharge_pages_locked()
which uses the locked version of refill_stock().

- Replace disabling interrupts for memcg_stock with a local_lock_t.

- Let drain_obj_stock() return the old struct obj_cgroup which is passed
  to obj_cgroup_put() outside of the locked section.

- Provide obj_cgroup_uncharge_pages_locked() which uses the locked
  version of refill_stock() to avoid recursive locking in
  drain_obj_stock().

Link: https://lkml.kernel.org/r/20220209014709.GA26885@xsang-OptiPlex-9020
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 55 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2cf55b3ab4b0..20bce9682e8a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2152,6 +2152,7 @@ void unlock_page_memcg(struct page *page)
 EXPORT_SYMBOL(unlock_page_memcg);
 
 struct memcg_stock_pcp {
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -2167,17 +2168,20 @@ struct memcg_stock_pcp {
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2206,7 +2210,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -2214,7 +2218,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2243,6 +2247,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 
 	/*
@@ -2250,14 +2255,16 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(stock);
+	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 /*
@@ -2284,9 +2291,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	__refill_stock(memcg, nr_pages);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -3095,10 +3102,11 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 	int *bytes;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -3107,7 +3115,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3151,7 +3159,9 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -3160,7 +3170,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
@@ -3168,17 +3178,17 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock)
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
 	if (!old)
-		return;
+		return NULL;
 
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
@@ -3230,8 +3240,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->cached_pgdat = NULL;
 	}
 
-	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
+	return old;
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3252,14 +3262,15 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3273,7 +3284,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	if (old)
+		obj_cgroup_put(old);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.37.1

