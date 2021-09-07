Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4F9C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 11:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4319610FE
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 11:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbhIGLJ1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:09:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbhIGLJ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Sep 2021 07:09:27 -0400
Date:   Tue, 7 Sep 2021 13:08:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631012900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gFUGa783Z4KZdl5WL57vOJZWePAmbsHjtIpmLn3G4Jo=;
        b=Z/GwY9iynhAqCKiO7P0CJCJAKgMncRBm106yjbt4y/kFaMBM4cAgQl9+hErJ6EYvUvxHTF
        gclmIBtf515jsraeUtEpxR5lmwRYP0rzv5XGHTsA8kuj6M6zV/SOjZBI2kizp2IUUHizQ1
        fYa2oVJR0rK9QNjM0fPuLga5GrH23O4PKvbg2jYCqZPBf17odDzOybcsTn52L+sbAP2rJu
        l3w0Q7LhUxOLLnLlnfEQBOMzEh5si727PeJyopPKtCa/vhg9oDEg3AtsH4GlDszlwcr4uz
        hIyupPL9rbrbFbHwJYZd35jtdATuoX6+lyPqr2NmQ1v33wAyn8AD4LgbWU7UDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631012900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gFUGa783Z4KZdl5WL57vOJZWePAmbsHjtIpmLn3G4Jo=;
        b=JTvjIxNxIK3sKytRQolKAHyMgusuavvY0J4Km+x5uKJ9QL9Y9utACUMPrEYWpQFDuBYasC
        x9hhPf4N6jW42FCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14.1-rt19
Message-ID: <20210907110818.3rev6v73njdhlavl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14.1-rt19 patch set. 

Changes since v5.14.1-rt18:

  - Dan Carpenter reported a possible NULL pointer dereference in
    rt_mutex_adjust_prio_chain(). Patch by Peter Zijlstra.

  - Unused rt_rwlock_is_contended() has been removed. Reported by kernel
    test robot.

  - The "play idle" timer was missing a _HARD annotation. It would
    freeze the system upon activation of the intel powerclamp driver.
    Reported by Thomas Gleixner.

  - Vlastimil Babka SLUB queue has been updated to v6r2.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14.1-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14.1-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14.1-rt19

The RT patch against v5.14.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14.1-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14.1-rt19.tar.xz

Sebastian

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1326cf3f88cae..3665583361c00 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -753,7 +753,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * other configuration and we fail to report; also, see
 		 * lockdep.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
 			ret = 0;
 
 		raw_spin_unlock(&lock->wait_lock);
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index d2912e44d61fd..839041f8460f9 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -246,12 +246,6 @@ void __sched rt_write_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
-int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
-{
-	return rw_base_is_contended(&rwlock->rwbase);
-}
-EXPORT_SYMBOL(rt_rwlock_is_contended);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 912b47aa99d82..d17b0a5ce6ac3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -379,10 +379,10 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	it.timer.function = idle_inject_timer_fn;
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	while (!READ_ONCE(it.done))
 		do_idle();
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
diff --git a/mm/slub.c b/mm/slub.c
index df1ac8aff86fe..3d2025f7163b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -417,41 +417,43 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 /*
  * Per slab locking using the pagelock
  */
-static __always_inline void
-__slab_lock(struct page *page, unsigned long *flags, bool disable_irqs)
+static __always_inline void __slab_lock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	if (disable_irqs)
-		local_irq_save(*flags);
 	bit_spin_lock(PG_locked, &page->flags);
 }
 
-static __always_inline void
-__slab_unlock(struct page *page, unsigned long *flags, bool disable_irqs)
+static __always_inline void __slab_unlock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	__bit_spin_unlock(PG_locked, &page->flags);
-	if (disable_irqs)
-		local_irq_restore(*flags);
 }
 
-static __always_inline void
-slab_lock(struct page *page, unsigned long *flags)
+static __always_inline void slab_lock(struct page *page, unsigned long *flags)
 {
-	__slab_lock(page, flags, IS_ENABLED(CONFIG_PREEMPT_RT));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(*flags);
+	__slab_lock(page);
 }
 
 static __always_inline void slab_unlock(struct page *page, unsigned long *flags)
 {
-	__slab_unlock(page, flags, IS_ENABLED(CONFIG_PREEMPT_RT));
+	__slab_unlock(page);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(*flags);
 }
 
-static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+/*
+ * Interrupts must be disabled (for the fallback code to work right), typically
+ * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
+ * so we disable interrupts as part of slab_[un]lock().
+ */
+static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
-		const char *n, bool disable_irqs)
+		const char *n)
 {
-	if (!disable_irqs)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
@@ -466,15 +468,15 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
 		/* init to 0 to prevent spurious warnings */
 		unsigned long flags = 0;
 
-		__slab_lock(page, &flags, disable_irqs);
+		slab_lock(page, &flags);
 		if (page->freelist == freelist_old &&
 					page->counters == counters_old) {
 			page->freelist = freelist_new;
 			page->counters = counters_new;
-			__slab_unlock(page, &flags, disable_irqs);
+			slab_unlock(page, &flags);
 			return true;
 		}
-		__slab_unlock(page, &flags, disable_irqs);
+		slab_unlock(page, &flags);
 	}
 
 	cpu_relax();
@@ -487,28 +489,45 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
 	return false;
 }
 
-/*
- * Interrupts must be disabled (for the fallback code to work right), typically
- * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
- * so we disable interrupts explicitly here.
- */
-static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
-		void *freelist_old, unsigned long counters_old,
-		void *freelist_new, unsigned long counters_new,
-		const char *n)
-{
-	return ___cmpxchg_double_slab(s, page, freelist_old, counters_old,
-				      freelist_new, counters_new, n,
-				      IS_ENABLED(CONFIG_PREEMPT_RT));
-}
-
 static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-	return ___cmpxchg_double_slab(s, page, freelist_old, counters_old,
-				      freelist_new, counters_new, n, true);
+#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
+    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+	if (s->flags & __CMPXCHG_DOUBLE) {
+		if (cmpxchg_double(&page->freelist, &page->counters,
+				   freelist_old, counters_old,
+				   freelist_new, counters_new))
+			return true;
+	} else
+#endif
+	{
+		unsigned long flags;
+
+		local_irq_save(flags);
+		__slab_lock(page);
+		if (page->freelist == freelist_old &&
+					page->counters == counters_old) {
+			page->freelist = freelist_new;
+			page->counters = counters_new;
+			__slab_unlock(page);
+			local_irq_restore(flags);
+			return true;
+		}
+		__slab_unlock(page);
+		local_irq_restore(flags);
+	}
+
+	cpu_relax();
+	stat(s, CMPXCHG_DOUBLE_FAIL);
+
+#ifdef SLUB_DEBUG_CMPXCHG
+	pr_info("%s %s: cmpxchg double redo ", n, s->name);
+#endif
+
+	return false;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -2566,38 +2585,43 @@ static inline void unfreeze_partials_cpu(struct kmem_cache *s,
 
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
-			      bool lock)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
 	unsigned long flags;
-	void *freelist;
 	struct page *page;
+	void *freelist;
 
-	if (lock)
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 
-	freelist = c->freelist;
 	page = c->page;
+	freelist = c->freelist;
 
 	c->page = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	if (lock)
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
-	if (page)
+	if (page) {
 		deactivate_slab(s, page, freelist);
-
-	stat(s, CPUSLAB_FLUSH);
+		stat(s, CPUSLAB_FLUSH);
+	}
 }
 
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+	void *freelist = c->freelist;
+	struct page *page = c->page;
 
-	if (c->page)
-		flush_slab(s, c, false);
+	c->page = NULL;
+	c->freelist = NULL;
+	c->tid = next_tid(c->tid);
+
+	if (page) {
+		deactivate_slab(s, page, freelist);
+		stat(s, CPUSLAB_FLUSH);
+	}
 
 	unfreeze_partials_cpu(s, c);
 }
@@ -2625,7 +2649,7 @@ static void flush_cpu_slab(struct work_struct *w)
 	c = this_cpu_ptr(s->cpu_slab);
 
 	if (c->page)
-		flush_slab(s, c, true);
+		flush_slab(s, c);
 
 	unfreeze_partials(s);
 }
@@ -2798,8 +2822,6 @@ static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
  * The page is still frozen if the return value is not NULL.
  *
  * If this function returns NULL then the page has been unfrozen.
- *
- * This function must be called with interrupt disabled.
  */
 static inline void *get_freelist(struct kmem_cache *s, struct page *page)
 {
@@ -2807,6 +2829,8 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
 	unsigned long counters;
 	void *freelist;
 
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
+
 	do {
 		freelist = page->freelist;
 		counters = page->counters;
@@ -4189,9 +4213,9 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = page_address(page);
+	unsigned long flags;
 	unsigned long *map;
 	void *p;
-	unsigned long flags;
 
 	slab_err(s, page, text, s->name);
 	slab_lock(page, &flags);
