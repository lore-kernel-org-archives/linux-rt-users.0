From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.0.8-rt6
Date: Mon, 13 Jul 2015 23:49:19 +0200
Message-ID: <20150713214919.GA27221@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.0.8-rt6 patch set.

Changes since v4.0.8-rt5

- No more "spin_do_trylock" in timer code. This is a functional
  regression vs. [FULL_]NOHZ. The trylock is wrong and should have
  never been added. We have a patch upstream which explicitely forbids
  the trylock usage in hard interrupt or idle context.

  There is no simple solution for this problem and it has to wait
  until the timer wheel rework has been finished.

- The delayed kmem_cache constructor caused problems. Steven Rostedt
  reported problems versus the signal handling code and Koehrer
  Mathias reported the same. The patch in question has been reverted
  and a patch currently sitting in -mm has been added which provides
  the same functionality (running the constructor with enabled
  interrupts). Patch provided by Thomas Gleixner.

- Jump labels are now only disabled on ARM. It was disabled because
  the arch-specific implementation used stop_machine() while patching
  the opcode(s) which led to large latencies. x86, powerpc and mips do
  not use stop_machine anymore (at least in v4.0) so we can leave it
  enabled. It is however disabled on ARM because it still uses
  stop_machine().

- The per-cpu rwsem implementation for -RT was missing an up primitive.
  This was properly fixed up by Thomas Gleixner.

Known issues:

      - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
        policy found" warnings after boot. It is gone after manually
        setting the policy (to something else than reported).

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 4.0.8-rt5 is appended below and can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/incr/patch-4.0.8-rt5-rt6.patch.xz   

The RT patch against 4.0.8 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patch-4.0.8-rt6.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patches-4.0.8-rt6.tar.xz

Sebastian

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6efcb2341599..91daa50256f8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,7 +30,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
+	select HAVE_ARCH_JUMP_LABEL if (!XIP_KERNEL && !PREEMPT_RT_BASE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index e17a47eae339..98f923b6a0ea 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -55,8 +55,7 @@ extern bool static_key_initialized;
 				    "%s used before call to jump_label_init", \
 				    __func__)
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL) && \
-	!defined(CONFIG_PREEMPT_BASE)
+#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
 
 struct static_key {
 	atomic_t enabled;
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
index 924c2d274ab5..928a05cbf94f 100644
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -59,6 +59,7 @@ extern void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
 extern void  rt_down_read(struct rw_semaphore *rwsem);
 extern int  rt_down_write_trylock(struct rw_semaphore *rwsem);
 extern int  rt_down_read_trylock(struct rw_semaphore *rwsem);
+extern void  __rt_up_read(struct rw_semaphore *rwsem);
 extern void  rt_up_read(struct rw_semaphore *rwsem);
 extern void  rt_up_write(struct rw_semaphore *rwsem);
 extern void  rt_downgrade_write(struct rw_semaphore *rwsem);
@@ -92,6 +93,11 @@ static inline int down_write_trylock(struct rw_semaphore *sem)
 	return rt_down_write_trylock(sem);
 }
 
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	__rt_up_read(sem);
+}
+
 static inline void up_read(struct rw_semaphore *sem)
 {
 	rt_up_read(sem);
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 2db0f42d5c64..652a8ee8efe9 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -84,12 +84,8 @@ void percpu_down_read(struct percpu_rw_semaphore *brw)
 
 	down_read(&brw->rw_sem);
 	atomic_inc(&brw->slow_read_ctr);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	up_read(&brw->rw_sem);
-#else
 	/* avoid up_read()->rwsem_release() */
 	__up_read(&brw->rw_sem);
-#endif
 }
 
 void percpu_up_read(struct percpu_rw_semaphore *brw)
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index 73c55089fb93..3482ce87ab92 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -319,12 +319,18 @@ void  rt_up_write(struct rw_semaphore *rwsem)
 }
 EXPORT_SYMBOL(rt_up_write);
 
-void  rt_up_read(struct rw_semaphore *rwsem)
+
+void  __rt_up_read(struct rw_semaphore *rwsem)
 {
-	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
 	if (--rwsem->read_depth == 0)
 		rt_mutex_unlock(&rwsem->lock);
 }
+
+void  rt_up_read(struct rw_semaphore *rwsem)
+{
+	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
+	__rt_up_read(rwsem);
+}
 EXPORT_SYMBOL(rt_up_read);
 
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 292eea0cc412..4b15aa0de862 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1409,13 +1409,11 @@ unsigned long get_next_timer_interrupt(unsigned long now)
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 	/*
-	 * On PREEMPT_RT we cannot sleep here. If the trylock does not
-	 * succeed then we return the worst-case 'expires in 1 tick'
-	 * value.  We use the rt functions here directly to avoid a
-	 * migrate_disable() call.
+	 * On PREEMPT_RT we cannot sleep here. As a result we can't take
+	 * the base lock to check when the next timer is pending and so
+	 * we assume the next jiffy.
 	 */
-	if (!spin_do_trylock(&base->lock))
-		return  now + 1;
+	return now + 1;
 #else
 	spin_lock(&base->lock);
 #endif
@@ -1424,11 +1422,7 @@ unsigned long get_next_timer_interrupt(unsigned long now)
 			base->next_timer = __next_timer_interrupt(base);
 		expires = base->next_timer;
 	}
-#ifdef CONFIG_PREEMPT_RT_FULL
-	rt_spin_unlock_after_trylock_in_irq(&base->lock);
-#else
 	spin_unlock(&base->lock);
-#endif
 
 	if (time_before_eq(expires, now))
 		return now;
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e..8fc605d80667 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/mm/slub.c b/mm/slub.c
index ea83736be12c..935ad58acde4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1314,6 +1314,17 @@ static inline void slab_free_hook(struct kmem_cache *s, void *x)
 	kasan_slab_free(s, x);
 }
 
+static void setup_object(struct kmem_cache *s, struct page *page,
+				void *object)
+{
+	setup_object_debug(s, page, object);
+	if (unlikely(s->ctor)) {
+		kasan_unpoison_object_data(s, object);
+		s->ctor(object);
+		kasan_poison_object_data(s, object);
+	}
+}
+
 /*
  * Slab allocation and freeing
  */
@@ -1344,6 +1355,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct page *page;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
+	void *start, *p;
+	int idx, order;
 	bool enableirqs;
 
 	flags &= gfp_allowed_mask;
@@ -1372,13 +1385,13 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Try a lower order alloc if possible
 		 */
 		page = alloc_slab_page(s, alloc_gfp, node, oo);
-
-		if (page)
-			stat(s, ORDER_FALLBACK);
+		if (!unlikely(page))
+			goto out;
+		stat(s, ORDER_FALLBACK);
 	}
 
-	if (kmemcheck_enabled && page
-		&& !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
+	if (kmemcheck_enabled &&
+		!(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
 		int pages = 1 << oo_order(oo);
 
 		kmemcheck_alloc_shadow(page, oo_order(oo), alloc_gfp, node);
@@ -1393,53 +1406,9 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 			kmemcheck_mark_unallocated_pages(page, pages);
 	}
 
-	if (enableirqs)
-		local_irq_disable();
-	if (!page)
-		return NULL;
-
 	page->objects = oo_objects(oo);
-	mod_zone_page_state(page_zone(page),
-		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
-		1 << oo_order(oo));
-
-	return page;
-}
-
-static void setup_object(struct kmem_cache *s, struct page *page,
-				void *object)
-{
-	setup_object_debug(s, page, object);
-#ifndef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor)) {
-		kasan_unpoison_object_data(s, object);
-		s->ctor(object);
-		kasan_poison_object_data(s, object);
-	}
-#endif
-}
-
-static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
-{
-	struct page *page;
-	void *start;
-	void *p;
-	int order;
-	int idx;
-
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
-		BUG();
-	}
-
-	page = allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-	if (!page)
-		goto out;
 
 	order = compound_order(page);
-	inc_slabs_node(s, page_to_nid(page), page->objects);
 	page->slab_cache = s;
 	__SetPageSlab(page);
 	if (page->pfmemalloc)
@@ -1463,10 +1432,34 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->freelist = start;
 	page->inuse = page->objects;
 	page->frozen = 1;
+
 out:
+	if (enableirqs)
+		local_irq_disable();
+	if (!page)
+		return NULL;
+
+	mod_zone_page_state(page_zone(page),
+			    (s->flags & SLAB_RECLAIM_ACCOUNT) ?
+			    NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
+			    1 << oo_order(oo));
+
+	inc_slabs_node(s, page_to_nid(page), page->objects);
+
 	return page;
 }
 
+static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+{
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
+		BUG();
+	}
+
+	return allocate_slab(s,
+		     flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+}
+
 static void __free_slab(struct kmem_cache *s, struct page *page)
 {
 	int order = compound_order(page);
@@ -2562,13 +2555,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 
 	if (unlikely(gfpflags & __GFP_ZERO) && object)
 		memset(object, 0, s->object_size);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor) && object) {
-		kasan_unpoison_object_data(s, object);
-		s->ctor(object);
-		kasan_poison_object_data(s, object);
-	}
-#endif
 
 	slab_post_alloc_hook(s, gfpflags, object);
 
