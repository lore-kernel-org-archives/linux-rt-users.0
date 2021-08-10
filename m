Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB6BC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A360C60F41
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhHJQh4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:37:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhHJQhz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 12:37:55 -0400
Date:   Tue, 10 Aug 2021 18:37:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628613452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ktg1Shk+pLNrsNJ1l9F2veXQjKzshvNUqpAAfqhOTeY=;
        b=yZBUv3ghD4PYtFNHAYtasDMP20A1cwQekirN3KODU4ZBRYz1erZBOmLwtcTGdH8HsCHG79
        gr5ursAlN9h1msNfDYPGCbmC33UcwT05oUous9Sle6ycOufm7iemrZiggwnnFaFLiFc0lJ
        +Qwb6OhY/fa4i+Orw2BDDkKyLTzlTS0D1I4XpQ9Y0AJ4hm9Ou6Te07ZJYd1oaVZR72GUpa
        AddwxaE1f+RyWIN5lDnNBlaTJt6xDvxzGzMvC308/q6fifRjj1YW+21LhMqyonROLdTggm
        Vhn8znZv646r43Cs5/HnpHGZX32XHJCXC2ymy8pU0fjGmePe+06TkxCQCyFtqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628613452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ktg1Shk+pLNrsNJ1l9F2veXQjKzshvNUqpAAfqhOTeY=;
        b=dxl/ueMLrIG6zojxEHfFEmau53PJL77Qqfelfz7DmKZWRf+lDfaAY5Cg/0FpxD5HHWk2PH
        X7wbPFLmw2hHS4Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc5-rt8
Message-ID: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc5-rt8 patch set. 

Changes since v5.14-rc5-rt7:

  - The locking bits haven been updated by Thomas Gleixner.

  - The SLUB series by Vlastimil Babka has been updated to v4r1.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

The delta patch against v5.14-rc5-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc5-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc5-rt8

The RT patch against v5.14-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc5-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc5-rt8.tar.xz

Sebastian

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 65fa7498a4d2c..531cb503d4c49 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -16,6 +16,7 @@
 #include <linux/linkage.h>
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
+#include <linux/compiler.h>
 
 extern int max_lock_depth; /* for sysctl */
 
@@ -40,7 +41,7 @@ struct rt_mutex_base {
  */
 static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
 {
-	return lock->owner != NULL;
+	return READ_ONCE(lock->owner) != NULL;
 }
 
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 7ed2a33df7cc7..4fc72199cc9d2 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -112,7 +112,7 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
 {
-	spin_unlock(lock);
+	rt_spin_unlock(lock);
 }
 
 #define spin_trylock(lock)				\
diff --git a/kernel/futex.c b/kernel/futex.c
index 41e3d63160a78..fcc0570868b7b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1357,27 +1357,6 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	return 0;
 }
 
-static int lookup_pi_state(u32 __user *uaddr, u32 uval,
-			   struct futex_hash_bucket *hb,
-			   union futex_key *key, struct futex_pi_state **ps,
-			   struct task_struct **exiting)
-{
-	struct futex_q *top_waiter = futex_top_waiter(hb, key);
-
-	/*
-	 * If there is a waiter on that futex, validate it and
-	 * attach to the pi_state when the validation succeeds.
-	 */
-	if (top_waiter)
-		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
-
-	/*
-	 * We are the first waiter - try to look up the owner based on
-	 * @uval and attach to it.
-	 */
-	return attach_to_pi_owner(uaddr, uval, key, ps, exiting);
-}
-
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
@@ -2134,13 +2113,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		if (uaddr1 == uaddr2)
 			return -EINVAL;
 
-		/*
-		 * requeue_pi requires a pi_state, try to allocate it now
-		 * without any locks in case it fails.
-		 */
-		if (refill_pi_state_cache())
-			return -ENOMEM;
-
 		/*
 		 * futex_requeue() allows the caller to define the number
 		 * of waiters to wake up via the @nr_wake argument. With
@@ -2164,6 +2136,13 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;
+
+		/*
+		 * requeue_pi requires a pi_state, try to allocate it now
+		 * without any locks in case it fails.
+		 */
+		if (refill_pi_state_cache())
+			return -ENOMEM;
 	}
 
 retry:
@@ -2213,7 +2192,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		}
 	}
 
-	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
+	if (requeue_pi) {
 		struct task_struct *exiting = NULL;
 
 		/*
@@ -2232,18 +2211,15 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 * At this point the top_waiter has either taken uaddr2 or is
 		 * waiting on it.  If the former, then the pi_state will not
 		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, ret contains the
-		 * vpid of the top waiter task.
+		 * reference to it. If the lock was taken, @ret contains the
+		 * VPID of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
 		 *
 		 * The top waiter's requeue_state is up to date:
 		 *
 		 *  - If the lock was acquired atomically (ret > 0), then
-		 *    the state is Q_REQUEUE_PI_LOCKED. No matter whether
-		 *    the below lookup_pi_state() fails or not requeue_state
-		 *    is correct because that waiter is dequeued and woken
-		 *    up and nothing can hold it up.
+		 *    the state is Q_REQUEUE_PI_LOCKED.
 		 *
 		 *  - If the trylock failed with an error (ret < 0) then
 		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
@@ -2262,19 +2238,25 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			WARN_ON(pi_state);
 			task_count++;
 			/*
-			 * If we acquired the lock, then the user space value
-			 * of uaddr2 should be vpid. It cannot be changed by
-			 * the top waiter as it is blocked on hb2 lock if it
-			 * tries to do so. If something fiddled with it behind
-			 * our back the pi state lookup might unearth it. So
-			 * we rather use the known value than rereading and
-			 * handing potential crap to lookup_pi_state.
+			 * If futex_proxy_trylock_atomic() acquired the
+			 * user space futex, then the user space value
+			 * @uaddr2 has been set to the @hb1's top waiter
+			 * task VPID. This task is guaranteed to be alive
+			 * and cannot be exiting because it is either
+			 * sleeping or blocked on @hb2 lock.
 			 *
-			 * If that call succeeds then we have pi_state and an
-			 * initial refcount on it.
+			 * The @uaddr2 futex cannot have waiters either as
+			 * otherwise futex_proxy_trylock_atomic() would not
+			 * have succeeded.
+			 *
+			 * In order to requeue waiters to @hb2, pi state is
+			 * required. Hand in the VPID value (@ret) and
+			 * allocate PI state with an initial refcount on
+			 * it.
 			 */
-			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
-					      &pi_state, &exiting);
+			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
+						 &exiting);
+			WARN_ON(ret);
 		}
 
 		switch (ret) {
@@ -2413,9 +2395,9 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either
-	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
-	 * need to drop it here again.
+	 * We took an extra initial reference to the pi_state either in
+	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
+	 * to drop it here again.
 	 */
 	put_pi_state(pi_state);
 
@@ -2594,7 +2576,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * Modifying pi_state _before_ the user space value would leave the
 	 * pi_state in an inconsistent state when we fault here, because we
 	 * need to drop the locks to handle the fault. This might be observed
-	 * in the PID check in lookup_pi_state.
+	 * in the PID checks when attaching to PI state .
 	 */
 retry:
 	if (!argowner) {
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7522c3abacb6c..44472115aaf66 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -284,11 +284,28 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 }
 #endif
 
+static __always_inline int __waiter_prio(struct task_struct *task)
+{
+	int prio = task->prio;
+
+	if (!rt_prio(prio))
+		return DEFAULT_PRIO;
+
+	return prio;
+}
+
+static __always_inline void
+waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	waiter->prio = __waiter_prio(task);
+	waiter->deadline = task->dl.deadline;
+}
+
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 
 static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 						struct rt_mutex_waiter *right)
@@ -356,11 +373,15 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 
 	if (rt_mutex_waiter_less(aw, bw))
 		return 1;
+
+	if (!build_ww_mutex())
+		return 0;
+
 	if (rt_mutex_waiter_less(bw, aw))
 		return 0;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
-	if (build_ww_mutex() && aw->ww_ctx) {
+	if (aw->ww_ctx) {
 		if (!bw->ww_ctx)
 			return 1;
 
@@ -775,8 +796,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * serializes all pi_waiters access and rb_erase() does not care about
 	 * the values of the node being removed.
 	 */
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
@@ -1045,8 +1065,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
 	waiter->lock = lock;
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1284,27 +1303,34 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 }
 
 #ifdef CONFIG_SMP
-/*
- * Note that owner is a speculative pointer and dereferencing relies
- * on rcu_read_lock() and the check against the lock owner.
- */
-static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
 {
 	bool res = true;
 
 	rcu_read_lock();
 	for (;;) {
-		/* Owner changed. Trylock again */
+		/* If owner changed, trylock again. */
 		if (owner != rt_mutex_owner(lock))
 			break;
 		/*
-		 * Ensure that owner->on_cpu is dereferenced _after_
-		 * checking the above to be valid.
+		 * Ensure that @owner is dereferenced after checking that
+		 * the lock owner still matches @owner. If that fails,
+		 * @owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
 		 */
 		barrier();
-		if (!owner->on_cpu || need_resched() ||
-		    vcpu_is_preempted(task_cpu(owner))) {
+		/*
+		 * Stop spinning when:
+		 *  - the lock owner has been scheduled out
+		 *  - current is not longer the top waiter
+		 *  - current is requested to reschedule (redundant
+		 *    for CONFIG_PREEMPT_RCU=y)
+		 *  - the VCPU on which owner runs is preempted
+		 */
+		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
+		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
 			res = false;
 			break;
 		}
@@ -1314,8 +1340,9 @@ static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
 	return res;
 }
 #else
-static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
 {
 	return false;
 }
@@ -1434,7 +1461,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
@@ -1616,7 +1643,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 3ca0f167df544..a077079e387ca 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -237,7 +237,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	int a_prio = a->task->prio;
 	int b_prio = b->task->prio;
 
-	if (dl_prio(a_prio) || dl_prio(b_prio)) {
+	if (rt_prio(a_prio) || rt_prio(b_prio)) {
 
 		if (a_prio > b_prio)
 			return true;
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1c673c323baf2..ec2bb0beed757 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -502,6 +502,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
+	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
 	s->refcount--;
@@ -516,6 +517,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
diff --git a/mm/slub.c b/mm/slub.c
index 5d775fafd2160..ef022fe159c65 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -463,7 +463,8 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
 	} else
 #endif
 	{
-		unsigned long flags;
+		/* init to 0 to prevent spurious warnings */
+		unsigned long flags = 0;
 
 		__slab_lock(page, &flags, disable_irqs);
 		if (page->freelist == freelist_old &&
@@ -2636,13 +2637,13 @@ static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 static DEFINE_MUTEX(flush_lock);
 static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
-static void flush_all(struct kmem_cache *s)
+static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
-	cpus_read_lock();
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
@@ -2663,10 +2664,16 @@ static void flush_all(struct kmem_cache *s)
 		flush_work(&sfw->work);
 	}
 
-	cpus_read_unlock();
 	mutex_unlock(&flush_lock);
 }
 
+static void flush_all(struct kmem_cache *s)
+{
+	cpus_read_lock();
+	flush_all_cpus_locked(s);
+	cpus_read_unlock();
+}
+
 /*
  * Use the cpu notifier to insure that the cpu slabs are flushed when
  * necessary.
@@ -4236,7 +4243,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all(s);
+	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4512,7 +4519,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_shrink(struct kmem_cache *s)
+int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
@@ -4524,7 +4531,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4574,13 +4580,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	return ret;
 }
 
+int __kmem_cache_shrink(struct kmem_cache *s)
+{
+	flush_all(s);
+	return __kmem_cache_do_shrink(s);
+}
+
 static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
-		__kmem_cache_shrink(s);
+	list_for_each_entry(s, &slab_caches, list) {
+		flush_all_cpus_locked(s);
+		__kmem_cache_do_shrink(s);
+	}
 	mutex_unlock(&slab_mutex);
 
 	return 0;
