Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12580C25B08
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiHHM4t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiHHM4k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:40 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97F2DEF
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:38 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 067E64169A;
        Mon,  8 Aug 2022 14:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 067E64169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963395;
        bh=QVylu6gNfEsMODExWXwK9K+Eje0wUkfJcoIUdDHpRKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oF/cL7mCPCA7dSSnjcT/OxKiQO6UQdQO9GCL0C2RGhCCCljR4tnbWytk0/RnFLONd
         gMxYhSJYwdnjuAoEdSo29KZHskHMUtaetPMaVCte6/QpS/hPcBLUfL2uosxNi6fF9L
         QuWbcO2aqvTZIJqUS1BYVsoNCEP4XEm8h7B02XEs=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 01/10] mm/memcg: Revert ("mm/memcg: optimize user context object stock access")
Date:   Mon,  8 Aug 2022 14:55:53 +0200
Message-Id: <20220808125602.97747-2-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

The optimisation is based on a micro benchmark where local_irq_save() is
more expensive than a preempt_disable(). There is no evidence that it is
visible in a real-world workload and there are CPUs where the opposite is
true (local_irq_save() is cheaper than preempt_disable()).

Based on micro benchmarks, the optimisation makes sense on PREEMPT_NONE
where preempt_disable() is optimized away. There is no improvement with
PREEMPT_DYNAMIC since the preemption counter is always available.

The optimization makes also the PREEMPT_RT integration more complicated
since most of the assumption are not true on PREEMPT_RT.

Revert the optimisation since it complicates the PREEMPT_RT integration
and the improvement is hardly visible.

[ bigeasy: Patch body around Michal's diff ]

Link: https://lore.kernel.org/all/YgOGkXXCrD%2F1k+p4@dhcp22.suse.cz
Link: https://lkml.kernel.org/r/YdX+INO9gQje6d0S@linutronix.de
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 94 ++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 67 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 971546bb99e0..a07e068989b4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2102,23 +2102,17 @@ void unlock_page_memcg(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-struct obj_stock {
+struct memcg_stock_pcp {
+	struct mem_cgroup *cached; /* this never be root cgroup */
+	unsigned int nr_pages;
+
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
-#else
-	int dummy[0];
 #endif
-};
-
-struct memcg_stock_pcp {
-	struct mem_cgroup *cached; /* this never be root cgroup */
-	unsigned int nr_pages;
-	struct obj_stock task_obj;
-	struct obj_stock irq_obj;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -2128,12 +2122,12 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static void drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -2144,41 +2138,6 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 #endif
 
 /*
- * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
- * sequence used in this case to access content from object stock is slow.
- * To optimize for user context access, there are now two object stocks for
- * task context and interrupt context access respectively.
- *
- * The task context object stock can be accessed by disabling preemption only
- * which is cheap in non-preempt kernel. The interrupt context object stock
- * can only be accessed after disabling interrupt. User context code can
- * access interrupt object stock, but not vice versa.
- */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
-{
-	struct memcg_stock_pcp *stock;
-
-	if (likely(in_task())) {
-		*pflags = 0UL;
-		preempt_disable();
-		stock = this_cpu_ptr(&memcg_stock);
-		return &stock->task_obj;
-	}
-
-	local_irq_save(*pflags);
-	stock = this_cpu_ptr(&memcg_stock);
-	return &stock->irq_obj;
-}
-
-static inline void put_obj_stock(unsigned long flags)
-{
-	if (likely(in_task()))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-}
-
-/**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
  * @nr_pages: how many pages to charge.
@@ -2245,9 +2204,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
@@ -3084,10 +3041,13 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
 	int *bytes;
 
+	local_irq_save(flags);
+	stock = this_cpu_ptr(&memcg_stock);
+
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
@@ -3138,26 +3098,29 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags);
+	local_irq_restore(flags);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
 	bool ret = false;
 
+	local_irq_save(flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct obj_stock *stock)
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
@@ -3213,13 +3176,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
-	if (in_task() && stock->task_obj.cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
-		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
-			return true;
-	}
-	if (stock->irq_obj.cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
+	if (stock->cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3230,10 +3188,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
 	unsigned int nr_pages = 0;
 
+	local_irq_save(flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3249,7 +3210,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags);
+	local_irq_restore(flags);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
@@ -6874,7 +6835,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	unsigned long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg = PageMemcgKmem(page);
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -6883,7 +6843,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	 * page memcg or objcg at this point, we have fully
 	 * exclusive access to the page.
 	 */
-	if (use_objcg) {
+	if (PageMemcgKmem(page)) {
 		objcg = __page_objcg(page);
 		/*
 		 * This get matches the put at the end of the function and
@@ -6911,7 +6871,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 
 	nr_pages = compound_nr(page);
 
-	if (use_objcg) {
+	if (PageMemcgKmem(page)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
-- 
2.37.1

