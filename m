Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0086C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D16664EC6
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhCCGXu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836134AbhCBTyS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Mar 2021 14:54:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D3C061788;
        Tue,  2 Mar 2021 11:53:36 -0800 (PST)
Date:   Tue, 2 Mar 2021 20:53:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614714814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TMJLKlXSZsG/05eD8T5kPkpVbSLm84LYq9TZ3zyeKmw=;
        b=BEvKaws4LvROwNdFHwV4Q6A1B7N5UQVoOMwuevDKiT8GymuEkgrak6OebNSKBIMoH7NzRN
        dSTqo8RfSqR8sE4kM2NJGW9aWDHm8EeRT/G1M4HMDSz+G4/BXyiBVDF1dage22ZignXIy1
        3LFutMeXeJytp2G/ij1gVOM6PaxBZyVFzidsrovJnHmlxaMX6w5pQNrCf7r59mtFeR0ac6
        lTfkSxVmHO77UrNgeMOKbqExJIgQhOJEdgstEEQ7w1tnlECX2OND2gLFG6QvxEWGs4b3Pp
        WE80JWECghTWivjzGG9QQDTB6FOauix/uTa96L6VaO+6w4/k+3LJtslXO/orDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614714814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TMJLKlXSZsG/05eD8T5kPkpVbSLm84LYq9TZ3zyeKmw=;
        b=yWsrQD0GvD4vurYpYM39f/uKIqQnzcGcGP1NTABSj3bpCtdkNcclAYCaqxl3i+XHrZlhJ0
        QGNwXDvaL1W5oyAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.11.2-rt9
Message-ID: <20210302195333.h6rjb2lgz5rr65sc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.11.2-rt9 patch set. 

Changes since v5.11.2-rt8:

  - Move the cpu_chill() prototype to hrtimer.h to avoid a warning.

  - Polish the sigqueue cache patch. Its doing remains unchanged with
    one difference: The cache is now used only if the task is a realtime
    task. Previously it was also used if a task was having a realtime
    priority due to PI boost.

  - Refurbish the slub and page_alloc patches:
    - There used to be a per-CPU list for pages which should have been
      given back to the page-alloctor but the caller was atomic. The
      atomic sections from within SLUB are gone, the per-CPU list is
      gone, too.

    - The SLUB_CPU_PARTIAL switch can now be enabled. I looked at the
      resulting latency numbers and enabling leads to higher latency.
      Therefore it is off by default on RT.

    - We used to split the free process of the pcp-pages into two
      stages and so slightly decouple the IRQ-off section from the
      zone-lock section. I don't see the need to keep doing it since the
      local-lock removes all the IRQ-off regions on RT and for !RT it
      shouldn't make much difference.
      This split is gone now.

    - The alloc/free tracker sysfs file uses one PAGE size for
      collecting the results. If it runs out of space it reallocates
      more memory with disabled interrupts. The reallocation is not
      forbidden on PREEMPT_RT.

Known issues
     - kdb/kgdb can easily deadlock.
     - netconsole triggers WARN.

The delta patch against v5.11.2-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/incr/patch-5.11.2-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.11.2-rt9

The RT patch against v5.11.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patch-5.11.2-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patches-5.11.2-rt9.tar.xz

Sebastian

diff --git a/fs/namespace.c b/fs/namespace.c
index 45571517b9c21..d02bd66933735 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -14,7 +14,7 @@
 #include <linux/mnt_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
-#include <linux/delay.h>
+#include <linux/hrtimer.h>
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/idr.h>
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 02b37178b54f4..1d0e2ce6b6d9f 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -76,10 +76,4 @@ static inline void fsleep(unsigned long usecs)
 		msleep(DIV_ROUND_UP(usecs, 1000));
 }
 
-#ifdef CONFIG_PREEMPT_RT
-extern void cpu_chill(void);
-#else
-# define cpu_chill()	cpu_relax()
-#endif
-
 #endif /* defined(_LINUX_DELAY_H) */
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0a42746..e425a26a5ed88 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -540,4 +540,10 @@ int hrtimers_dead_cpu(unsigned int cpu);
 #define hrtimers_dead_cpu	NULL
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+extern void cpu_chill(void);
+#else
+# define cpu_chill()	cpu_relax()
+#endif
+
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index fa25113eda0dc..77d356fa8668e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1972,8 +1972,8 @@ config SHUFFLE_PAGE_ALLOCATOR
 	  Say Y if unsure.
 
 config SLUB_CPU_PARTIAL
-	default y
-	depends on SLUB && SMP && !PREEMPT_RT
+	default y if !PREEMPT_RT
+	depends on SLUB && SMP
 	bool "SLUB per cpu partial cache"
 	help
 	  Per cpu partial caches accelerate objects allocation and freeing
diff --git a/kernel/signal.c b/kernel/signal.c
index b87178eb0df69..e40ed99a62a17 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -405,20 +405,20 @@ void task_join_group_stop(struct task_struct *task)
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
-static inline struct sigqueue *get_task_cache(struct task_struct *t)
+static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
 {
 	struct sigqueue *q = t->sigqueue_cache;
 
-	if (cmpxchg(&t->sigqueue_cache, q, NULL) != q)
-		return NULL;
-	return q;
+	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
+		return q;
+	return NULL;
 }
 
-static inline int put_task_cache(struct task_struct *t, struct sigqueue *q)
+static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
 {
-	if (cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
-		return 0;
-	return 1;
+	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
+		return true;
+	return false;
 }
 
 /*
@@ -428,7 +428,7 @@ static inline int put_task_cache(struct task_struct *t, struct sigqueue *q)
  */
 static struct sigqueue *
 __sigqueue_do_alloc(int sig, struct task_struct *t, gfp_t flags,
-		    int override_rlimit, int fromslab)
+		    int override_rlimit, bool fromslab)
 {
 	struct sigqueue *q = NULL;
 	struct user_struct *user;
@@ -451,7 +451,7 @@ __sigqueue_do_alloc(int sig, struct task_struct *t, gfp_t flags,
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
 		if (!fromslab)
-			q = get_task_cache(t);
+			q = sigqueue_from_cache(t);
 		if (!q)
 			q = kmem_cache_alloc(sigqueue_cachep, flags);
 	} else {
@@ -474,7 +474,7 @@ static struct sigqueue *
 __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags,
 		 int override_rlimit)
 {
-	return __sigqueue_do_alloc(sig, t, flags, override_rlimit, 0);
+	return __sigqueue_do_alloc(sig, t, flags, override_rlimit, false);
 }
 
 static void __sigqueue_free(struct sigqueue *q)
@@ -486,7 +486,7 @@ static void __sigqueue_free(struct sigqueue *q)
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
-static void sigqueue_free_current(struct sigqueue *q)
+static void __sigqueue_cache_or_free(struct sigqueue *q)
 {
 	struct user_struct *up;
 
@@ -494,11 +494,10 @@ static void sigqueue_free_current(struct sigqueue *q)
 		return;
 
 	up = q->user;
-	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		if (atomic_dec_and_test(&up->sigpending))
-			free_uid(up);
-	} else
-		  __sigqueue_free(q);
+	if (atomic_dec_and_test(&up->sigpending))
+		free_uid(up);
+	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
+		kmem_cache_free(sigqueue_cachep, q);
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -523,7 +522,7 @@ void flush_task_sigqueue(struct task_struct *tsk)
 
 	flush_sigqueue(&tsk->pending);
 
-	q = get_task_cache(tsk);
+	q = sigqueue_from_cache(tsk);
 	if (q)
 		kmem_cache_free(sigqueue_cachep, q);
 }
@@ -652,7 +651,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		sigqueue_free_current(first);
+		__sigqueue_cache_or_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -1895,8 +1894,7 @@ EXPORT_SYMBOL(kill_pid);
  */
 struct sigqueue *sigqueue_alloc(void)
 {
-	/* Preallocated sigqueue objects always from the slabcache ! */
-	struct sigqueue *q = __sigqueue_do_alloc(-1, current, GFP_KERNEL, 0, 1);
+	struct sigqueue *q = __sigqueue_do_alloc(-1, current, GFP_KERNEL, 0, true);
 
 	if (q)
 		q->flags |= SIGQUEUE_PREALLOC;
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5b1332e80dbec..36f314ae0e56a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -362,6 +362,8 @@ EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
+int page_group_by_mobility_disabled __read_mostly;
+
 struct pa_lock {
 	local_lock_t l;
 };
@@ -369,8 +371,6 @@ static DEFINE_PER_CPU(struct pa_lock, pa_lock) = {
 	.l	= INIT_LOCAL_LOCK(l),
 };
 
-int page_group_by_mobility_disabled __read_mostly;
-
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
@@ -1352,7 +1352,7 @@ static inline void prefetch_buddy(struct page *page)
 }
 
 /*
- * Frees a number of pages which have been collected from the pcp lists.
+ * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone, and of same order.
  * count is the number of pages to free.
  *
@@ -1362,55 +1362,15 @@ static inline void prefetch_buddy(struct page *page)
  * And clear the zone's pages_scanned counter, to hold off the "all pages are
  * pinned" detection logic.
  */
-static void free_pcppages_bulk(struct zone *zone, struct list_head *head,
-			       bool zone_retry)
-{
-	bool isolated_pageblocks;
-	struct page *page, *tmp;
-
-	spin_lock(&zone->lock);
-	isolated_pageblocks = has_isolate_pageblock(zone);
-
-	/*
-	 * Use safe version since after __free_one_page(),
-	 * page->lru.next will not point to original list.
-	 */
-	list_for_each_entry_safe(page, tmp, head, lru) {
-		int mt = get_pcppage_migratetype(page);
-
-		if (page_zone(page) != zone) {
-			/*
-			 * free_unref_page_list() sorts pages by zone. If we end
-			 * up with pages from a different NUMA nodes belonging
-			 * to the same ZONE index then we need to redo with the
-			 * correct ZONE pointer. Skip the page for now, redo it
-			 * on the next iteration.
-			 */
-			WARN_ON_ONCE(zone_retry == false);
-			if (zone_retry)
-				continue;
-		}
-
-		/* MIGRATE_ISOLATE page should not go to pcplists */
-		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-		/* Pageblock could have been isolated meanwhile */
-		if (unlikely(isolated_pageblocks))
-			mt = get_pageblock_migratetype(page);
-
-		list_del(&page->lru);
-		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FPI_NONE);
-		trace_mm_page_pcpu_drain(page, 0, mt);
-	}
-	spin_unlock(&zone->lock);
-}
-
-static void isolate_pcp_pages(int count, struct per_cpu_pages *pcp,
-			      struct list_head *dst)
+static void free_pcppages_bulk(struct zone *zone, int count,
+					struct per_cpu_pages *pcp)
 {
 	int migratetype = 0;
 	int batch_free = 0;
 	int prefetch_nr = READ_ONCE(pcp->batch);
-	struct page *page;
+	bool isolated_pageblocks;
+	struct page *page, *tmp;
+	LIST_HEAD(head);
 
 	/*
 	 * Ensure proper count is passed which otherwise would stuck in the
@@ -1447,7 +1407,7 @@ static void isolate_pcp_pages(int count, struct per_cpu_pages *pcp,
 			if (bulkfree_pcp_prepare(page))
 				continue;
 
-			list_add_tail(&page->lru, dst);
+			list_add_tail(&page->lru, &head);
 
 			/*
 			 * We are going to put the page back to the global
@@ -1464,6 +1424,26 @@ static void isolate_pcp_pages(int count, struct per_cpu_pages *pcp,
 			}
 		} while (--count && --batch_free && !list_empty(list));
 	}
+
+	spin_lock(&zone->lock);
+	isolated_pageblocks = has_isolate_pageblock(zone);
+
+	/*
+	 * Use safe version since after __free_one_page(),
+	 * page->lru.next will not point to original list.
+	 */
+	list_for_each_entry_safe(page, tmp, &head, lru) {
+		int mt = get_pcppage_migratetype(page);
+		/* MIGRATE_ISOLATE page should not go to pcplists */
+		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
+		/* Pageblock could have been isolated meanwhile */
+		if (unlikely(isolated_pageblocks))
+			mt = get_pageblock_migratetype(page);
+
+		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FPI_NONE);
+		trace_mm_page_pcpu_drain(page, 0, mt);
+	}
+	spin_unlock(&zone->lock);
 }
 
 static void free_one_page(struct zone *zone,
@@ -2984,18 +2964,13 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	unsigned long flags;
 	int to_drain, batch;
-	LIST_HEAD(dst);
 
 	local_lock_irqsave(&pa_lock.l, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
-		isolate_pcp_pages(to_drain, pcp, &dst);
-
+		free_pcppages_bulk(zone, to_drain, pcp);
 	local_unlock_irqrestore(&pa_lock.l, flags);
-
-	if (to_drain > 0)
-		free_pcppages_bulk(zone, &dst, false);
 }
 #endif
 
@@ -3011,21 +2986,14 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pageset *pset;
 	struct per_cpu_pages *pcp;
-	LIST_HEAD(dst);
-	int count;
 
 	local_lock_irqsave(&pa_lock.l, flags);
 	pset = per_cpu_ptr(zone->pageset, cpu);
 
 	pcp = &pset->pcp;
-	count = pcp->count;
-	if (count)
-		isolate_pcp_pages(count, pcp, &dst);
-
+	if (pcp->count)
+		free_pcppages_bulk(zone, pcp->count, pcp);
 	local_unlock_irqrestore(&pa_lock.l, flags);
-
-	if (count)
-		free_pcppages_bulk(zone, &dst, false);
 }
 
 /*
@@ -3245,8 +3213,7 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 	return true;
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   struct list_head *dst)
+static void free_unref_page_commit(struct page *page, unsigned long pfn)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
@@ -3275,7 +3242,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
 	if (pcp->count >= READ_ONCE(pcp->high))
-		isolate_pcp_pages(READ_ONCE(pcp->batch), pcp, dst);
+		free_pcppages_bulk(zone, READ_ONCE(pcp->batch), pcp);
 }
 
 /*
@@ -3285,17 +3252,13 @@ void free_unref_page(struct page *page)
 {
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
-	struct zone *zone = page_zone(page);
-	LIST_HEAD(dst);
 
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
 	local_lock_irqsave(&pa_lock.l, flags);
-	free_unref_page_commit(page, pfn, &dst);
+	free_unref_page_commit(page, pfn);
 	local_unlock_irqrestore(&pa_lock.l, flags);
-	if (!list_empty(&dst))
-		free_pcppages_bulk(zone, &dst, false);
 }
 
 /*
@@ -3306,11 +3269,6 @@ void free_unref_page_list(struct list_head *list)
 	struct page *page, *next;
 	unsigned long flags, pfn;
 	int batch_count = 0;
-	struct list_head dsts[__MAX_NR_ZONES];
-	int i;
-
-	for (i = 0; i < __MAX_NR_ZONES; i++)
-		INIT_LIST_HEAD(&dsts[i]);
 
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -3323,12 +3281,10 @@ void free_unref_page_list(struct list_head *list)
 	local_lock_irqsave(&pa_lock.l, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_private(page);
-		enum zone_type type;
 
 		set_page_private(page, 0);
 		trace_mm_page_free_batched(page);
-		type = page_zonenum(page);
-		free_unref_page_commit(page, pfn, &dsts[type]);
+		free_unref_page_commit(page, pfn);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
@@ -3341,21 +3297,6 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 	local_unlock_irqrestore(&pa_lock.l, flags);
-
-	for (i = 0; i < __MAX_NR_ZONES; ) {
-		struct page *page;
-		struct zone *zone;
-
-		if (list_empty(&dsts[i])) {
-			i++;
-			continue;
-		}
-
-		page = list_first_entry(&dsts[i], struct page, lru);
-		zone = page_zone(page);
-
-		free_pcppages_bulk(zone, &dsts[i], true);
-	}
 }
 
 /*
@@ -3552,6 +3493,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 * allocate greater than order-1 page units with __GFP_NOFAIL.
 	 */
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+
 	local_lock_irqsave(&pa_lock.l, flags);
 	spin_lock(&zone->lock);
 
@@ -3574,6 +3516,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	spin_unlock(&zone->lock);
 	if (!page)
 		goto failed;
+
 	__mod_zone_freepage_state(zone, -(1 << order),
 				  get_pcppage_migratetype(page));
 
diff --git a/mm/slub.c b/mm/slub.c
index 570c7e32f4d63..0e317cbb8c255 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1499,12 +1499,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
-struct slub_free_list {
-	raw_spinlock_t		lock;
-	struct list_head	list;
-};
-static DEFINE_PER_CPU(struct slub_free_list, slub_free_list);
-
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
@@ -1860,16 +1854,6 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 	__free_pages(page, order);
 }
 
-static void free_delayed(struct list_head *h)
-{
-	while (!list_empty(h)) {
-		struct page *page = list_first_entry(h, struct page, lru);
-
-		list_del(&page->lru);
-		__free_slab(page->slab_cache, page);
-	}
-}
-
 static void rcu_free_slab(struct rcu_head *h)
 {
 	struct page *page = container_of(h, struct page, rcu_head);
@@ -1881,22 +1865,33 @@ static void free_slab(struct kmem_cache *s, struct page *page)
 {
 	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
 		call_rcu(&page->rcu_head, rcu_free_slab);
-	} else if (irqs_disabled()) {
-		struct slub_free_list *f = this_cpu_ptr(&slub_free_list);
-
-		raw_spin_lock(&f->lock);
-		list_add(&page->lru, &f->list);
-		raw_spin_unlock(&f->lock);
 	} else
 		__free_slab(s, page);
 }
 
+static void discard_slab_delayed(struct kmem_cache *s, struct page *page,
+				 struct list_head *delayed_free)
+{
+	dec_slabs_node(s, page_to_nid(page), page->objects);
+	list_add(&page->lru, delayed_free);
+}
+
 static void discard_slab(struct kmem_cache *s, struct page *page)
 {
 	dec_slabs_node(s, page_to_nid(page), page->objects);
 	free_slab(s, page);
 }
 
+static void discard_delayed(struct list_head *l)
+{
+	while (!list_empty(l)) {
+		struct page *page = list_first_entry(l, struct page, lru);
+
+		list_del(&page->lru);
+		__free_slab(page->slab_cache, page);
+	}
+}
+
 /*
  * Management of partially allocated slabs.
  */
@@ -1970,15 +1965,16 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	WARN_ON(!freelist);
 	return freelist;
 }
-
-static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain);
+static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain,
+			    struct list_head *delayed_free);
 static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
 
 /*
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-				struct kmem_cache_cpu *c, gfp_t flags)
+			      struct kmem_cache_cpu *c, gfp_t flags,
+			      struct list_head *delayed_free)
 {
 	struct page *page, *page2;
 	void *object = NULL;
@@ -2011,7 +2007,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
-			put_cpu_partial(s, page, 0);
+			put_cpu_partial(s, page, 0, delayed_free);
 			stat(s, CPU_PARTIAL_NODE);
 		}
 		if (!kmem_cache_has_cpu_partial(s)
@@ -2027,7 +2023,8 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  * Get a page from somewhere. Search in increasing NUMA distances.
  */
 static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-		struct kmem_cache_cpu *c)
+			     struct kmem_cache_cpu *c,
+			     struct list_head *delayed_free)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
@@ -2069,7 +2066,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 			if (n && cpuset_zone_allowed(zone, flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, c, flags);
+				object = get_partial_node(s, n, c, flags, delayed_free);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2091,7 +2088,8 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
  * Get a partial page, lock it and return it.
  */
 static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-		struct kmem_cache_cpu *c)
+			 struct kmem_cache_cpu *c,
+			 struct list_head *delayed_free)
 {
 	void *object;
 	int searchnode = node;
@@ -2099,11 +2097,12 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), c, flags);
+	object = get_partial_node(s, get_node(s, searchnode), c, flags,
+				  delayed_free);
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, flags, c);
+	return get_any_partial(s, flags, c, delayed_free);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -2179,7 +2178,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
  * Remove the cpu slab
  */
 static void deactivate_slab(struct kmem_cache *s, struct page *page,
-				void *freelist, struct kmem_cache_cpu *c)
+			    void *freelist, struct kmem_cache_cpu *c,
+			    struct list_head *delayed_free)
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
@@ -2316,7 +2316,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		stat(s, DEACTIVATE_FULL);
 	else if (m == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, page);
+		discard_slab_delayed(s, page, delayed_free);
 		stat(s, FREE_SLAB);
 	}
 
@@ -2331,8 +2331,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
  * for the cpu using c (or some other guarantee must be there
  * to guarantee no concurrent accesses).
  */
-static void unfreeze_partials(struct kmem_cache *s,
-		struct kmem_cache_cpu *c)
+static void unfreeze_partials(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      struct list_head *delayed_free)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
@@ -2386,7 +2386,7 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_page = discard_page->next;
 
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, page);
+		discard_slab_delayed(s, page, delayed_free);
 		stat(s, FREE_SLAB);
 	}
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
@@ -2399,7 +2399,8 @@ static void unfreeze_partials(struct kmem_cache *s,
  * If we did not find a slot then simply move all the partials to the
  * per node partial list.
  */
-static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
+static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain,
+			    struct list_head *delayed_free)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *oldpage;
@@ -2416,21 +2417,15 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
 			if (drain && pobjects > slub_cpu_partial(s)) {
-				struct slub_free_list *f;
 				unsigned long flags;
-				LIST_HEAD(tofree);
 				/*
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
 				local_irq_save(flags);
-				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-				f = this_cpu_ptr(&slub_free_list);
-				raw_spin_lock(&f->lock);
-				list_splice_init(&f->list, &tofree);
-				raw_spin_unlock(&f->lock);
+				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab),
+						  delayed_free);
 				local_irq_restore(flags);
-				free_delayed(&tofree);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2451,17 +2446,18 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 		unsigned long flags;
 
 		local_irq_save(flags);
-		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
+		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab), delayed_free);
 		local_irq_restore(flags);
 	}
 	preempt_enable();
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      struct list_head *delayed_free)
 {
 	stat(s, CPUSLAB_FLUSH);
-	deactivate_slab(s, c->page, c->freelist, c);
+	deactivate_slab(s, c->page, c->freelist, c, delayed_free);
 
 	c->tid = next_tid(c->tid);
 }
@@ -2471,46 +2467,81 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
  *
  * Called from IPI handler with interrupts disabled.
  */
-static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
+static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu,
+				    struct list_head *delayed_free)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, delayed_free);
 
-	unfreeze_partials(s, c);
+	unfreeze_partials(s, c, delayed_free);
 }
 
-static void flush_cpu_slab(void *d)
-{
-	struct kmem_cache *s = d;
+struct slub_flush_work {
+	struct work_struct work;
+	struct kmem_cache *s;
+	bool skip;
+};
 
-	__flush_cpu_slab(s, smp_processor_id());
+static void flush_cpu_slab(struct work_struct *w)
+{
+	struct slub_flush_work *sfw;
+	LIST_HEAD(delayed_free);
+
+	sfw = container_of(w, struct slub_flush_work, work);
+
+	local_irq_disable();
+	__flush_cpu_slab(sfw->s, smp_processor_id(), &delayed_free);
+	local_irq_enable();
+
+	discard_delayed(&delayed_free);
 }
 
-static bool has_cpu_slab(int cpu, void *info)
+static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 {
-	struct kmem_cache *s = info;
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	return c->page || slub_percpu_partial(c);
 }
 
+static DEFINE_MUTEX(flush_lock);
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
+
+static void flush_all_locked(struct kmem_cache *s)
+{
+	struct slub_flush_work *sfw;
+	unsigned int cpu;
+
+	mutex_lock(&flush_lock);
+
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		if (!has_cpu_slab(cpu, s)) {
+			sfw->skip = true;
+			continue;
+		}
+		INIT_WORK(&sfw->work, flush_cpu_slab);
+		sfw->skip = false;
+		sfw->s = s;
+		schedule_work_on(cpu, &sfw->work);
+	}
+
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		if (sfw->skip)
+			continue;
+		flush_work(&sfw->work);
+	}
+
+	mutex_unlock(&flush_lock);
+}
+
 static void flush_all(struct kmem_cache *s)
 {
-	LIST_HEAD(tofree);
-	int cpu;
-
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
-	for_each_online_cpu(cpu) {
-		struct slub_free_list *f;
-
-		f = &per_cpu(slub_free_list, cpu);
-		raw_spin_lock_irq(&f->lock);
-		list_splice_init(&f->list, &tofree);
-		raw_spin_unlock_irq(&f->lock);
-		free_delayed(&tofree);
-	}
+	cpus_read_lock();
+	flush_all_locked(s);
+	cpus_read_unlock();
 }
 
 /*
@@ -2521,13 +2552,15 @@ static int slub_cpu_dead(unsigned int cpu)
 {
 	struct kmem_cache *s;
 	unsigned long flags;
+	LIST_HEAD(delayed_free);
 
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
 		local_irq_save(flags);
-		__flush_cpu_slab(s, cpu);
+		__flush_cpu_slab(s, cpu, &delayed_free);
 		local_irq_restore(flags);
 	}
+	discard_delayed(&delayed_free);
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
@@ -2611,7 +2644,8 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 }
 
 static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
-			int node, struct kmem_cache_cpu **pc)
+				     int node, struct kmem_cache_cpu **pc,
+				     struct list_head *delayed_free)
 {
 	void *freelist;
 	struct kmem_cache_cpu *c = *pc;
@@ -2619,7 +2653,7 @@ static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
-	freelist = get_partial(s, flags, node, c);
+	freelist = get_partial(s, flags, node, c, delayed_free);
 
 	if (freelist)
 		return freelist;
@@ -2628,7 +2662,7 @@ static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 	if (page) {
 		c = raw_cpu_ptr(s->cpu_slab);
 		if (c->page)
-			flush_slab(s, c);
+			flush_slab(s, c, delayed_free);
 
 		/*
 		 * No other reference to the page yet so we can
@@ -2708,9 +2742,8 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c,
-			  struct list_head *to_free)
+			  struct list_head *delayed_free)
 {
-	struct slub_free_list *f;
 	void *freelist;
 	struct page *page;
 
@@ -2739,7 +2772,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
-			deactivate_slab(s, page, c->freelist, c);
+			deactivate_slab(s, page, c->freelist, c, delayed_free);
 			goto new_slab;
 		}
 	}
@@ -2750,7 +2783,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * information when the page leaves the per-cpu allocator
 	 */
 	if (unlikely(!pfmemalloc_match(page, gfpflags))) {
-		deactivate_slab(s, page, c->freelist, c);
+		deactivate_slab(s, page, c->freelist, c, delayed_free);
 		goto new_slab;
 	}
 
@@ -2778,13 +2811,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
-
-out:
-	f = this_cpu_ptr(&slub_free_list);
-	raw_spin_lock(&f->lock);
-	list_splice_init(&f->list, to_free);
-	raw_spin_unlock(&f->lock);
-
 	return freelist;
 
 new_slab:
@@ -2796,11 +2822,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
-	freelist = new_slab_objects(s, gfpflags, node, &c);
+	freelist = new_slab_objects(s, gfpflags, node, &c, delayed_free);
 
 	if (unlikely(!freelist)) {
 		slab_out_of_memory(s, gfpflags, node);
-		goto out;
+		return NULL;
 	}
 
 	page = c->page;
@@ -2812,8 +2838,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			!alloc_debug_processing(s, page, freelist, addr))
 		goto new_slab;	/* Slab failed checks. Next slab needed */
 
-	deactivate_slab(s, page, get_freepointer(s, freelist), c);
-	goto out;
+	deactivate_slab(s, page, get_freepointer(s, freelist), c, delayed_free);
+	return freelist;
 }
 
 /*
@@ -2825,7 +2851,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 {
 	void *p;
 	unsigned long flags;
-	LIST_HEAD(tofree);
+	LIST_HEAD(delayed_free);
 
 	local_irq_save(flags);
 #ifdef CONFIG_PREEMPTION
@@ -2837,9 +2863,9 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = this_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c, &tofree);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, &delayed_free);
 	local_irq_restore(flags);
-	free_delayed(&tofree);
+	discard_delayed(&delayed_free);
 	return p;
 }
 
@@ -3094,11 +3120,13 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 			 */
 			stat(s, FREE_FROZEN);
 		} else if (new.frozen) {
+			LIST_HEAD(delayed_free);
 			/*
 			 * If we just froze the page then put it onto the
 			 * per cpu partial list.
 			 */
-			put_cpu_partial(s, page, 1);
+			put_cpu_partial(s, page, 1, &delayed_free);
+			discard_delayed(&delayed_free);
 			stat(s, CPU_PARTIAL_FREE);
 		}
 
@@ -3340,9 +3368,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
 	struct kmem_cache_cpu *c;
-	LIST_HEAD(to_free);
 	int i;
 	struct obj_cgroup *objcg = NULL;
+	LIST_HEAD(delayed_free);
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
 		WARN_ON_ONCE(!preemptible() &&
@@ -3378,7 +3406,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c, &to_free);
+					    _RET_IP_, c, &delayed_free);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -3393,7 +3421,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
-	free_delayed(&to_free);
+
+	discard_delayed(&delayed_free);
 
 	/* Clear memory outside IRQ disabled fastpath loop */
 	if (unlikely(slab_want_init_on_alloc(flags, s))) {
@@ -3408,7 +3437,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
-	free_delayed(&to_free);
+	discard_delayed(&delayed_free);
 	slab_post_alloc_hook(s, objcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
@@ -3994,7 +4023,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all(s);
+	flush_all_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4234,7 +4263,7 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
+	flush_all_locked(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4418,6 +4447,7 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	int node;
 	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
 	struct kmem_cache_node *n;
+	LIST_HEAD(delayed_free);
 
 	memcpy(s, static_cache, kmem_cache->object_size);
 
@@ -4426,7 +4456,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	 * up.  Even if it weren't true, IRQs are not up so we couldn't fire
 	 * IPIs around.
 	 */
-	__flush_cpu_slab(s, smp_processor_id());
+	__flush_cpu_slab(s, smp_processor_id(), &delayed_free);
+	discard_delayed(&delayed_free);
 	for_each_kmem_cache_node(s, node, n) {
 		struct page *p;
 
@@ -4446,12 +4477,6 @@ void __init kmem_cache_init(void)
 {
 	static __initdata struct kmem_cache boot_kmem_cache,
 		boot_kmem_cache_node;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		raw_spin_lock_init(&per_cpu(slub_free_list, cpu).lock);
-		INIT_LIST_HEAD(&per_cpu(slub_free_list, cpu).list);
-	}
 
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
@@ -4712,6 +4737,9 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
 	struct location *l;
 	int order;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && flags == GFP_ATOMIC)
+		return 0;
+
 	order = get_order(sizeof(struct location) * max);
 
 	l = (void *)__get_free_pages(flags, order);
