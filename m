Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6446CCA486
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 11:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiGLLqR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiGLLqN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 07:46:13 -0400
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD543B1CD4
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:46:10 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 3566540AAC;
        Tue, 12 Jul 2022 13:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 3566540AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1657624968;
        bh=5nI9xc/OosiSfcDj6ofcObRVuyOqLCl1iPbDRywWHzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQ+6lKHIMfFObB8FOVoHnS7p1NocH/8DWA4PIlS7ii+8HVYHYouYPymIfrHtdK2Bh
         ZhGkUt0gm0ff2NXZqhs4J9XMQehkKu6XickOxb5ni+87yKS8WaFAbJuA/sHupILA/f
         CuIM+rqbjJLmxZqPz0gwNLpe1y5IzQcoQZBo3Sg4=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Date:   Tue, 12 Jul 2022 13:22:37 +0200
Message-Id: <20220712112238.18824-4-goliath@infraroot.at>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712112238.18824-1-goliath@infraroot.at>
References: <20220712112238.18824-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The members of the per-CPU structure memcg_stock_pcp are protected
either by disabling interrupts or by disabling preemption if the
invocation occurred in process context.
Disabling interrupts protects most of the structure excluding task_obj
while disabling preemption protects only task_obj.
This schema is incompatible with PREEMPT_RT because it creates atomic
context in which actions are performed which require preemptible
context. One example is obj_cgroup_release().

The IRQ-disable and preempt-disable sections can be replaced with
local_lock_t which preserves the explicit disabling of interrupts while
keeps the code preemptible on PREEMPT_RT.

The task_obj has been added for performance reason on non-preemptible
kernels where preempt_disable() is a NOP. On the PREEMPT_RT preemption
model preempt_disable() is always implemented. Also there are no memory
allocations in_irq() context and softirqs are processed in (preemptible)
process context. Therefore it makes sense to avoid using task_obj.

Don't use task_obj on PREEMPT_RT and replace manual disabling of
interrupts with a local_lock_t. This change requires some factoring:

- drain_obj_stock() drops a reference on obj_cgroup which leads to an
  invocation of obj_cgroup_release() if it is the last object. This in
  turn leads to recursive locking of the local_lock_t. To avoid this,
  obj_cgroup_release() is invoked outside of the locked section.

- drain_obj_stock() gets a memcg_stock_pcp passed if the stock_lock has been
  acquired (instead of the task_obj_lock) to avoid recursive locking later
  in refill_stock().

- drain_all_stock() disables preemption via get_cpu() and then invokes
  drain_local_stock() if it is the local CPU to avoid scheduling a worker
  (which invokes the same function). Disabling preemption here is
  problematic due to the sleeping locks in drain_local_stock().
  This can be avoided by always scheduling a worker, even for the local
  CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
  that no worker is scheduled for an offline CPU. Since there is no
  flush_work(), it is still possible that a worker is invoked on the wrong
  CPU but it is okay since it operates always on the local-CPU data.

- drain_local_stock() is always invoked as a worker so it can be optimized
  by removing in_task() (it is always true) and avoiding the "irq_save"
  variant because interrupts are always enabled here. Operating on
  task_obj first allows to acquire the lock_lock_t without lockdep
  complains.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 174 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 114 insertions(+), 60 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c2e1aed2e1fb..63a052483927 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -260,8 +260,10 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
+struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -295,7 +297,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
@@ -2025,26 +2027,40 @@ struct obj_stock {
 };
 
 struct memcg_stock_pcp {
+	/* Protects memcg_stock_pcp */
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+#ifndef CONFIG_PREEMPT_RT
+	/* Protects only task_obj */
+	local_lock_t task_obj_lock;
 	struct obj_stock task_obj;
+#endif
 	struct obj_stock irq_obj;
 
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+#ifndef CONFIG_PREEMPT_RT
+	.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
+#endif
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  bool stock_lock_acquried);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+						 bool stock_lock_acquried)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2064,28 +2080,36 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
  */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
+					      bool *stock_lock_acquried)
 {
 	struct memcg_stock_pcp *stock;
 
+#ifndef CONFIG_PREEMPT_RT
 	if (likely(in_task())) {
 		*pflags = 0UL;
-		preempt_disable();
+		*stock_lock_acquried = false;
+		local_lock(&memcg_stock.task_obj_lock);
 		stock = this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
-
-	local_irq_save(*pflags);
+#endif
+	*stock_lock_acquried = true;
+	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock = this_cpu_ptr(&memcg_stock);
 	return &stock->irq_obj;
 }
 
-static inline void put_obj_stock(unsigned long flags)
+static inline void put_obj_stock(unsigned long flags,
+				 bool stock_lock_acquried)
 {
-	if (likely(in_task()))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
+#ifndef CONFIG_PREEMPT_RT
+	if (likely(!stock_lock_acquried)) {
+		local_unlock(&memcg_stock.task_obj_lock);
+		return;
+	}
+#endif
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /**
@@ -2108,7 +2132,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -2116,7 +2140,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2144,38 +2168,43 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock_pcp;
+	struct obj_cgroup *old;
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+#ifndef CONFIG_PREEMPT_RT
+	local_lock(&memcg_stock.task_obj_lock);
+	old = drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
+	local_unlock(&memcg_stock.task_obj_lock);
+	if (old)
+		obj_cgroup_put(old);
+#endif
 
-	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
-	drain_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	local_lock_irq(&memcg_stock.stock_lock);
+	stock_pcp = this_cpu_ptr(&memcg_stock);
+	old = drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
 
-	local_irq_restore(flags);
+	drain_stock(stock_pcp);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
+
+	local_unlock_irq(&memcg_stock.stock_lock);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-
-	local_irq_save(flags);
+	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	lockdep_assert_held(&stock->stock_lock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2185,8 +2214,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
 
-	local_irq_restore(flags);
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 bool stock_lock_acquried)
+{
+	unsigned long flags;
+
+	if (stock_lock_acquried) {
+		__refill_stock(memcg, nr_pages);
+		return;
+	}
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	__refill_stock(memcg, nr_pages);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -2195,7 +2236,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2206,7 +2247,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu = get_cpu();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2222,14 +2263,10 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		rcu_read_unlock();
 
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
-			else
-				schedule_work_on(cpu, &stock->work);
-		}
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
+			schedule_work_on(cpu, &stock->work);
 	}
-	put_cpu();
+	cpus_read_unlock();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
@@ -2630,7 +2667,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
+		refill_stock(memcg, batch - nr_pages, false);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2891,7 +2928,8 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried)
 {
 	struct mem_cgroup *memcg;
 
@@ -2899,7 +2937,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, stock_lock_acquried);
 
 	css_put(&memcg->css);
 }
@@ -2986,7 +3024,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	objcg = __page_objcg(page);
-	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 	page->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -2994,17 +3032,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_cgroup *old = NULL;
+	struct obj_stock *stock;
 	int *bytes;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_lock_acquried);
+
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3048,38 +3090,43 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	bool ret = false;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct obj_stock *stock)
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  bool stock_lock_acquried)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
 	if (!old)
-		return;
+		return NULL;
 
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
 		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_lock_acquried);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3114,8 +3161,8 @@ static void drain_obj_stock(struct obj_stock *stock)
 		stock->cached_pgdat = NULL;
 	}
 
-	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
+	return old;
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3123,11 +3170,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
+#ifndef CONFIG_PREEMPT_RT
 	if (in_task() && stock->task_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
+#endif
 	if (stock->irq_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
@@ -3140,12 +3189,15 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	unsigned int nr_pages = 0;
+	struct obj_cgroup *old = NULL;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_lock_acquried);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3159,10 +3211,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -7111,7 +7165,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, false);
 }
 
 static int __init cgroup_memory(char *s)
-- 
2.36.1

