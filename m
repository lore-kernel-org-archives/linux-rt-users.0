From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.18-rt14
Date: Tue, 28 Mar 2017 13:17:17 +0200
Message-ID: <20170328111716.2vm3e4vjy5dhr7ci@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754856AbdC1LR0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Mar 2017 07:17:26 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.9.18-rt14 patch set. 

Changes since v4.9.18-rt13:

  - v4.9.11-rt9 had a fix for statically initialized PER_CPU locks. An
    issue with nested locks came up which was noticed by the kernel test
    robot and fixed by Peter Zijlstra.

  - A larger rework of the futex / rtmutex code. In v4.8-rt1 we added a
    workaround so we don't de-boost too early in the unlock path. A
    small window remained in which the locking thread could de-boost the
    unlocking thread. This rework by Peter Zijlstra fixes the issue.

Known issues
	- CPU hotplug got a little better but can deadlock.
        - The radeon driver. Probably since a change in the driver (or
          DRM core) the radeon driver can hang. This problem starts probably
          with the v3.18 release.
        - gdb. While gdb is following a task it is possible that after a
          fork() operation the task is waiting for gdb and gdb waiting
          for the task.

The delta patch against v4.9.18-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.18-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.18-rt14

The RT patch against v4.9.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.18-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.18-rt14.tar.xz

Sebastian
diff --git a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -120,6 +120,13 @@ extern unsigned int setup_max_cpus;
 extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
 
+extern int __boot_cpu_id;
+
+static inline int get_boot_cpu_id(void)
+{
+	return __boot_cpu_id;
+}
+
 #else /* !SMP */
 
 static inline void smp_send_stop(void) { }
@@ -158,6 +165,11 @@ static inline void smp_init(void) { up_late_init(); }
 static inline void smp_init(void) { }
 #endif
 
+static inline int get_boot_cpu_id(void)
+{
+	return 0;
+}
+
 #endif /* !SMP */
 
 /*
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -355,12 +355,6 @@ static __always_inline void spin_unlock(spinlock_t *lock)
 	raw_spin_unlock(&lock->rlock);
 }
 
-static __always_inline int spin_unlock_no_deboost(spinlock_t *lock)
-{
-	raw_spin_unlock(&lock->rlock);
-	return 0;
-}
-
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
 {
 	raw_spin_unlock_bh(&lock->rlock);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -26,7 +26,6 @@ extern void __lockfunc rt_spin_lock(spinlock_t *lock);
 extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
-extern int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock);
 extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
@@ -112,7 +111,6 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 #define spin_lock_nest_lock(lock, nest_lock) spin_lock_nested(lock, 0)
 
 #define spin_unlock(lock)			rt_spin_unlock(lock)
-#define spin_unlock_no_deboost(lock)		rt_spin_unlock_no_deboost(lock)
 
 #define spin_unlock_bh(lock)				\
 	do {						\
diff --git a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1562,6 +1562,8 @@ core_initcall(cpu_hotplug_pm_sync_init);
 
 #endif /* CONFIG_PM_SLEEP_SMP */
 
+int __boot_cpu_id;
+
 #endif /* CONFIG_SMP */
 
 /* Boot processor state steps */
@@ -2245,6 +2247,10 @@ void __init boot_cpu_init(void)
 	set_cpu_active(cpu, true);
 	set_cpu_present(cpu, true);
 	set_cpu_possible(cpu, true);
+
+#ifdef CONFIG_SMP
+	__boot_cpu_id = cpu;
+#endif
 }
 
 /*
diff --git a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -800,7 +800,7 @@ static int refill_pi_state_cache(void)
 	return 0;
 }
 
-static struct futex_pi_state * alloc_pi_state(void)
+static struct futex_pi_state *alloc_pi_state(void)
 {
 	struct futex_pi_state *pi_state = current->pi_state_cache;
 
@@ -810,6 +810,11 @@ static struct futex_pi_state * alloc_pi_state(void)
 	return pi_state;
 }
 
+static void get_pi_state(struct futex_pi_state *pi_state)
+{
+	WARN_ON_ONCE(!atomic_inc_not_zero(&pi_state->refcount));
+}
+
 /*
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
@@ -854,7 +859,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
  * Look up the task based on what TID userspace gave us.
  * We dont trust it.
  */
-static struct task_struct * futex_find_get_task(pid_t pid)
+static struct task_struct *futex_find_get_task(pid_t pid)
 {
 	struct task_struct *p;
 
@@ -916,10 +921,12 @@ void exit_pi_state_list(struct task_struct *curr)
 		pi_state->owner = NULL;
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		rt_mutex_unlock(&pi_state->pi_mutex);
-
+		get_pi_state(pi_state);
 		spin_unlock(&hb->lock);
 
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
@@ -973,6 +980,39 @@ void exit_pi_state_list(struct task_struct *curr)
  *
  * [10] There is no transient state which leaves owner and user space
  *	TID out of sync.
+ *
+ *
+ * Serialization and lifetime rules:
+ *
+ * hb->lock:
+ *
+ *	hb -> futex_q, relation
+ *	futex_q -> pi_state, relation
+ *
+ *	(cannot be raw because hb can contain arbitrary amount
+ *	 of futex_q's)
+ *
+ * pi_mutex->wait_lock:
+ *
+ *	{uval, pi_state}
+ *
+ *	(and pi_mutex 'obviously')
+ *
+ * p->pi_lock:
+ *
+ *	p->pi_state_list -> pi_state->list, relation
+ *
+ * pi_state->refcount:
+ *
+ *	pi_state lifetime
+ *
+ *
+ * Lock order:
+ *
+ *   hb->lock
+ *     pi_mutex->wait_lock
+ *       p->pi_lock
+ *
  */
 
 /*
@@ -980,10 +1020,12 @@ void exit_pi_state_list(struct task_struct *curr)
  * the pi_state against the user space value. If correct, attach to
  * it.
  */
-static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
+static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
+			      struct futex_pi_state *pi_state,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
+	int ret, uval2;
 
 	/*
 	 * Userspace might have messed up non-PI and PI futexes [3]
@@ -991,9 +1033,39 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 	if (unlikely(!pi_state))
 		return -EINVAL;
 
+	/*
+	 * We get here with hb->lock held, and having found a
+	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
+	 * has dropped the hb->lock in between queue_me() and unqueue_me_pi(),
+	 * which in turn means that futex_lock_pi() still has a reference on
+	 * our pi_state.
+	 *
+	 * The waiter holding a reference on @pi_state also protects against
+	 * the unlocked put_pi_state() in futex_unlock_pi(), futex_lock_pi()
+	 * and futex_wait_requeue_pi() as it cannot go to 0 and consequently
+	 * free pi_state before we can take a reference ourselves.
+	 */
 	WARN_ON(!atomic_read(&pi_state->refcount));
 
 	/*
+	 * Now that we have a pi_state, we can acquire wait_lock
+	 * and do the state validation.
+	 */
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	/*
+	 * Since {uval, pi_state} is serialized by wait_lock, and our current
+	 * uval was read without holding it, it can have changed. Verify it
+	 * still is what we expect it to be, otherwise retry the entire
+	 * operation.
+	 */
+	if (get_futex_value_locked(&uval2, uaddr))
+		goto out_efault;
+
+	if (uval != uval2)
+		goto out_eagain;
+
+	/*
 	 * Handle the owner died case:
 	 */
 	if (uval & FUTEX_OWNER_DIED) {
@@ -1008,11 +1080,11 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 			 * is not 0. Inconsistent state. [5]
 			 */
 			if (pid)
-				return -EINVAL;
+				goto out_einval;
 			/*
 			 * Take a ref on the state and return success. [4]
 			 */
-			goto out_state;
+			goto out_attach;
 		}
 
 		/*
@@ -1024,14 +1096,14 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 		 * Take a ref on the state and return success. [6]
 		 */
 		if (!pid)
-			goto out_state;
+			goto out_attach;
 	} else {
 		/*
 		 * If the owner died bit is not set, then the pi_state
 		 * must have an owner. [7]
 		 */
 		if (!pi_state->owner)
-			return -EINVAL;
+			goto out_einval;
 	}
 
 	/*
@@ -1040,11 +1112,29 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 	 * user space TID. [9/10]
 	 */
 	if (pid != task_pid_vnr(pi_state->owner))
-		return -EINVAL;
-out_state:
-	atomic_inc(&pi_state->refcount);
+		goto out_einval;
+
+out_attach:
+	get_pi_state(pi_state);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	*ps = pi_state;
 	return 0;
+
+out_einval:
+	ret = -EINVAL;
+	goto out_error;
+
+out_eagain:
+	ret = -EAGAIN;
+	goto out_error;
+
+out_efault:
+	ret = -EFAULT;
+	goto out_error;
+
+out_error:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
 }
 
 /*
@@ -1095,6 +1185,9 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 
 	/*
 	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
 	 */
 	pi_state = alloc_pi_state();
 
@@ -1119,17 +1212,18 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 	return 0;
 }
 
-static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
+static int lookup_pi_state(u32 __user *uaddr, u32 uval,
+			   struct futex_hash_bucket *hb,
 			   union futex_key *key, struct futex_pi_state **ps)
 {
-	struct futex_q *match = futex_top_waiter(hb, key);
+	struct futex_q *top_waiter = futex_top_waiter(hb, key);
 
 	/*
 	 * If there is a waiter on that futex, validate it and
 	 * attach to the pi_state when the validation succeeds.
 	 */
-	if (match)
-		return attach_to_pi_state(uval, match->pi_state, ps);
+	if (top_waiter)
+		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
 
 	/*
 	 * We are the first waiter - try to look up the owner based on
@@ -1148,7 +1242,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 	if (unlikely(cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)))
 		return -EFAULT;
 
-	/*If user space value changed, let the caller retry */
+	/* If user space value changed, let the caller retry */
 	return curval != uval ? -EAGAIN : 0;
 }
 
@@ -1176,7 +1270,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 				struct task_struct *task, int set_waiters)
 {
 	u32 uval, newval, vpid = task_pid_vnr(task);
-	struct futex_q *match;
+	struct futex_q *top_waiter;
 	int ret;
 
 	/*
@@ -1202,9 +1296,9 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * Lookup existing state first. If it exists, try to attach to
 	 * its pi_state.
 	 */
-	match = futex_top_waiter(hb, key);
-	if (match)
-		return attach_to_pi_state(uval, match->pi_state, ps);
+	top_waiter = futex_top_waiter(hb, key);
+	if (top_waiter)
+		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
 
 	/*
 	 * No waiter and user TID is 0. We are here because the
@@ -1290,46 +1384,39 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * memory barrier is required here to prevent the following
 	 * store to lock_ptr from getting ahead of the plist_del.
 	 */
-	smp_wmb();
-	q->lock_ptr = NULL;
+	smp_store_release(&q->lock_ptr, NULL);
 }
 
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
-			 struct futex_hash_bucket *hb)
+/*
+ * Caller must hold a reference on @pi_state.
+ */
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	struct task_struct *new_owner;
-	struct futex_pi_state *pi_state = this->pi_state;
 	u32 uninitialized_var(curval), newval;
+	struct task_struct *new_owner;
+	bool deboost = false;
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
-	bool deboost;
 	int ret = 0;
 
-	if (!pi_state)
-		return -EINVAL;
-
-	/*
-	 * If current does not own the pi_state then the futex is
-	 * inconsistent and user space fiddled with the futex value.
-	 */
-	if (pi_state->owner != current)
-		return -EINVAL;
-
-	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
+	if (WARN_ON_ONCE(!new_owner)) {
+		/*
+		 * As per the comment in futex_unlock_pi() this should not happen.
+		 *
+		 * When this happens, give up our locks and try again, giving
+		 * the futex_lock_pi() instance time to complete, either by
+		 * waiting on the rtmutex or removing itself from the futex
+		 * queue.
+		 */
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
 
 	/*
-	 * It is possible that the next waiter (the one that brought
-	 * this owner to the kernel) timed out and is no longer
-	 * waiting on the lock.
-	 */
-	if (!new_owner)
-		new_owner = this->task;
-
-	/*
-	 * We pass it to the next owner. The WAITERS bit is always
-	 * kept enabled while there is PI state around. We cleanup the
-	 * owner died bit, because we are the owner.
+	 * We pass it to the next owner. The WAITERS bit is always kept
+	 * enabled while there is PI state around. We cleanup the owner
+	 * died bit, because we are the owner.
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
 
@@ -1338,6 +1425,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 
 	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)) {
 		ret = -EFAULT;
+
 	} else if (curval != uval) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -1350,10 +1438,9 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 		else
 			ret = -EINVAL;
 	}
-	if (ret) {
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		return ret;
-	}
+
+	if (ret)
+		goto out_unlock;
 
 	raw_spin_lock(&pi_state->owner->pi_lock);
 	WARN_ON(list_empty(&pi_state->list));
@@ -1366,24 +1453,22 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	pi_state->owner = new_owner;
 	raw_spin_unlock(&new_owner->pi_lock);
 
+	/*
+	 * We've updated the uservalue, this unlock cannot fail.
+	 */
+	deboost = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q,
+					  &wake_sleeper_q);
+
+out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
-	deboost = rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q,
-					&wake_sleeper_q);
-
-	/*
-	 * First unlock HB so the waiter does not spin on it once he got woken
-	 * up. Second wake up the waiter before the priority is adjusted. If we
-	 * deboost first (and lose our higher priority), then the task might get
-	 * scheduled away before the wake up can take place.
-	 */
-	deboost |= spin_unlock_no_deboost(&hb->lock);
-	wake_up_q(&wake_q);
-	wake_up_q_sleeper(&wake_sleeper_q);
-	if (deboost)
+	if (deboost) {
+		wake_up_q(&wake_q);
+		wake_up_q_sleeper(&wake_sleeper_q);
 		rt_mutex_adjust_prio(current);
+	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -1829,7 +1914,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			 * If that call succeeds then we have pi_state and an
 			 * initial refcount on it.
 			 */
-			ret = lookup_pi_state(ret, hb2, &key2, &pi_state);
+			ret = lookup_pi_state(uaddr2, ret, hb2, &key2, &pi_state);
 		}
 
 		switch (ret) {
@@ -1912,7 +1997,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			 * refcount on the pi_state and store the pointer in
 			 * the futex_q object of the waiter.
 			 */
-			atomic_inc(&pi_state->refcount);
+			get_pi_state(pi_state);
 			this->pi_state = pi_state;
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
@@ -2022,20 +2107,7 @@ queue_unlock(struct futex_hash_bucket *hb)
 	hb_waiters_dec(hb);
 }
 
-/**
- * queue_me() - Enqueue the futex_q on the futex_hash_bucket
- * @q:	The futex_q to enqueue
- * @hb:	The destination hash bucket
- *
- * The hb->lock must be held by the caller, and is released here. A call to
- * queue_me() is typically paired with exactly one call to unqueue_me().  The
- * exceptions involve the PI related operations, which may use unqueue_me_pi()
- * or nothing if the unqueue is done as part of the wake process and the unqueue
- * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
- * an example).
- */
-static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
-	__releases(&hb->lock)
+static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	int prio;
 
@@ -2052,6 +2124,24 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	plist_node_init(&q->list, prio);
 	plist_add(&q->list, &hb->chain);
 	q->task = current;
+}
+
+/**
+ * queue_me() - Enqueue the futex_q on the futex_hash_bucket
+ * @q:	The futex_q to enqueue
+ * @hb:	The destination hash bucket
+ *
+ * The hb->lock must be held by the caller, and is released here. A call to
+ * queue_me() is typically paired with exactly one call to unqueue_me().  The
+ * exceptions involve the PI related operations, which may use unqueue_me_pi()
+ * or nothing if the unqueue is done as part of the wake process and the unqueue
+ * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
+ * an example).
+ */
+static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
+	__releases(&hb->lock)
+{
+	__queue_me(q, hb);
 	spin_unlock(&hb->lock);
 }
 
@@ -2138,10 +2228,13 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 {
 	u32 newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
 	struct futex_pi_state *pi_state = q->pi_state;
-	struct task_struct *oldowner = pi_state->owner;
 	u32 uval, uninitialized_var(curval), newval;
+	struct task_struct *oldowner;
 	int ret;
 
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	oldowner = pi_state->owner;
 	/* Owner died? */
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
@@ -2149,7 +2242,8 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	/*
 	 * We are here either because we stole the rtmutex from the
 	 * previous highest priority waiter or we are the highest priority
-	 * waiter but failed to get the rtmutex the first time.
+	 * waiter but have failed to get the rtmutex the first time.
+	 *
 	 * We have to replace the newowner TID in the user space variable.
 	 * This must be atomic as we have to preserve the owner died bit here.
 	 *
@@ -2157,17 +2251,16 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * because we can fault here. Imagine swapped out pages or a fork
 	 * that marked all the anonymous memory readonly for cow.
 	 *
-	 * Modifying pi_state _before_ the user space value would
-	 * leave the pi_state in an inconsistent state when we fault
-	 * here, because we need to drop the hash bucket lock to
-	 * handle the fault. This might be observed in the PID check
-	 * in lookup_pi_state.
+	 * Modifying pi_state _before_ the user space value would leave the
+	 * pi_state in an inconsistent state when we fault here, because we
+	 * need to drop the locks to handle the fault. This might be observed
+	 * in the PID check in lookup_pi_state.
 	 */
 retry:
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
 
-	while (1) {
+	for (;;) {
 		newval = (uval & FUTEX_OWNER_DIED) | newtid;
 
 		if (cmpxchg_futex_value_locked(&curval, uaddr, uval, newval))
@@ -2182,47 +2275,60 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * itself.
 	 */
 	if (pi_state->owner != NULL) {
-		raw_spin_lock_irq(&pi_state->owner->pi_lock);
+		raw_spin_lock(&pi_state->owner->pi_lock);
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
-		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+		raw_spin_unlock(&pi_state->owner->pi_lock);
 	}
 
 	pi_state->owner = newowner;
 
-	raw_spin_lock_irq(&newowner->pi_lock);
+	raw_spin_lock(&newowner->pi_lock);
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &newowner->pi_state_list);
-	raw_spin_unlock_irq(&newowner->pi_lock);
+	raw_spin_unlock(&newowner->pi_lock);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+
 	return 0;
 
 	/*
-	 * To handle the page fault we need to drop the hash bucket
-	 * lock here. That gives the other task (either the highest priority
-	 * waiter itself or the task which stole the rtmutex) the
-	 * chance to try the fixup of the pi_state. So once we are
-	 * back from handling the fault we need to check the pi_state
-	 * after reacquiring the hash bucket lock and before trying to
-	 * do another fixup. When the fixup has been done already we
-	 * simply return.
+	 * To handle the page fault we need to drop the locks here. That gives
+	 * the other task (either the highest priority waiter itself or the
+	 * task which stole the rtmutex) the chance to try the fixup of the
+	 * pi_state. So once we are back from handling the fault we need to
+	 * check the pi_state after reacquiring the locks and before trying to
+	 * do another fixup. When the fixup has been done already we simply
+	 * return.
+	 *
+	 * Note: we hold both hb->lock and pi_mutex->wait_lock. We can safely
+	 * drop hb->lock since the caller owns the hb -> futex_q relation.
+	 * Dropping the pi_mutex->wait_lock requires the state revalidate.
 	 */
 handle_fault:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	spin_unlock(q->lock_ptr);
 
 	ret = fault_in_user_writeable(uaddr);
 
 	spin_lock(q->lock_ptr);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
 	 * Check if someone else fixed it for us:
 	 */
-	if (pi_state->owner != oldowner)
-		return 0;
+	if (pi_state->owner != oldowner) {
+		ret = 0;
+		goto out_unlock;
+	}
 
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	goto retry;
+
+out_unlock:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
 }
 
 static long futex_wait_restart(struct restart_block *restart);
@@ -2244,13 +2350,16 @@ static long futex_wait_restart(struct restart_block *restart);
  */
 static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 {
-	struct task_struct *owner;
 	int ret = 0;
 
 	if (locked) {
 		/*
 		 * Got the lock. We might not be the anticipated owner if we
 		 * did a lock-steal - fix up the PI-state in that case:
+		 *
+		 * We can safely read pi_state->owner without holding wait_lock
+		 * because we now own the rt_mutex, only the owner will attempt
+		 * to change it.
 		 */
 		if (q->pi_state->owner != current)
 			ret = fixup_pi_state_owner(uaddr, q, current);
@@ -2258,43 +2367,15 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 	}
 
 	/*
-	 * Catch the rare case, where the lock was released when we were on the
-	 * way back before we locked the hash bucket.
-	 */
-	if (q->pi_state->owner == current) {
-		/*
-		 * Try to get the rt_mutex now. This might fail as some other
-		 * task acquired the rt_mutex after we removed ourself from the
-		 * rt_mutex waiters list.
-		 */
-		if (rt_mutex_trylock(&q->pi_state->pi_mutex)) {
-			locked = 1;
-			goto out;
-		}
-
-		/*
-		 * pi_state is incorrect, some other task did a lock steal and
-		 * we returned due to timeout or signal without taking the
-		 * rt_mutex. Too late.
-		 */
-		raw_spin_lock_irq(&q->pi_state->pi_mutex.wait_lock);
-		owner = rt_mutex_owner(&q->pi_state->pi_mutex);
-		if (!owner)
-			owner = rt_mutex_next_owner(&q->pi_state->pi_mutex);
-		raw_spin_unlock_irq(&q->pi_state->pi_mutex.wait_lock);
-		ret = fixup_pi_state_owner(uaddr, q, owner);
-		goto out;
-	}
-
-	/*
 	 * Paranoia check. If we did not take the lock, then we should not be
 	 * the owner of the rt_mutex.
 	 */
-	if (rt_mutex_owner(&q->pi_state->pi_mutex) == current)
+	if (rt_mutex_owner(&q->pi_state->pi_mutex) == current) {
 		printk(KERN_ERR "fixup_owner: ret = %d pi-mutex: %p "
 				"pi-state %p\n", ret,
 				q->pi_state->pi_mutex.owner,
 				q->pi_state->owner);
+	}
 
 out:
 	return ret ? ret : locked;
@@ -2518,6 +2599,8 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to = NULL;
+	struct futex_pi_state *pi_state = NULL;
+	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -2570,25 +2653,77 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 		}
 	}
 
+	WARN_ON(!q.pi_state);
+
 	/*
 	 * Only actually queue now that the atomic ops are done:
 	 */
-	queue_me(&q, hb);
+	__queue_me(&q, hb);
 
-	WARN_ON(!q.pi_state);
-	/*
-	 * Block on the PI mutex:
-	 */
-	if (!trylock) {
-		ret = rt_mutex_timed_futex_lock(&q.pi_state->pi_mutex, to);
-	} else {
-		ret = rt_mutex_trylock(&q.pi_state->pi_mutex);
+	if (trylock) {
+		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
+		goto no_block;
 	}
 
+	rt_mutex_init_waiter(&rt_waiter, false);
+
+	/*
+	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
+	 * hold it while doing rt_mutex_start_proxy(), because then it will
+	 * include hb->lock in the blocking chain, even through we'll not in
+	 * fact hold it while blocking. This will lead it to report -EDEADLK
+	 * and BUG when futex_unlock_pi() interleaves with this.
+	 *
+	 * Therefore acquire wait_lock while holding hb->lock, but drop the
+	 * latter before calling rt_mutex_start_proxy_lock(). This still fully
+	 * serializes against futex_unlock_pi() as that does the exact same
+	 * lock handoff sequence.
+	 */
+	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
+	/*
+	 * the migrate_disable() here disables migration in the in_atomic() fast
+	 * path which is enabled again in the following spin_unlock(). We have
+	 * one migrate_disable() pending in the slow-path which is reversed
+	 * after the raw_spin_unlock_irq() where we leave the atomic context.
+	 */
+	migrate_disable();
+
+	spin_unlock(q.lock_ptr);
+	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
+	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+	migrate_enable();
+
+	if (ret) {
+		if (ret == 1)
+			ret = 0;
+
+		spin_lock(q.lock_ptr);
+		goto no_block;
+	}
+
+
+	if (unlikely(to))
+		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+
+	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
+
 	spin_lock(q.lock_ptr);
 	/*
+	 * If we failed to acquire the lock (signal/timeout), we must
+	 * first acquire the hb->lock before removing the lock from the
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
+	 * wait lists consistent.
+	 *
+	 * In particular; it is important that futex_unlock_pi() can not
+	 * observe this inconsistency.
+	 */
+	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
+		ret = 0;
+
+no_block:
+	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
 	 * haven't already.
 	 */
@@ -2604,12 +2739,19 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * If fixup_owner() faulted and was unable to handle the fault, unlock
 	 * it and return the fault to userspace.
 	 */
-	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current))
-		rt_mutex_unlock(&q.pi_state->pi_mutex);
+	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current)) {
+		pi_state = q.pi_state;
+		get_pi_state(pi_state);
+	}
 
 	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
 
+	if (pi_state) {
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+	}
+
 	goto out_put_key;
 
 out_unlock_put_key:
@@ -2646,7 +2788,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb;
-	struct futex_q *match;
+	struct futex_q *top_waiter;
 	int ret;
 
 retry:
@@ -2670,12 +2812,48 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * all and we at least want to know if user space fiddled
 	 * with the futex value instead of blindly unlocking.
 	 */
-	match = futex_top_waiter(hb, &key);
-	if (match) {
-		ret = wake_futex_pi(uaddr, uval, match, hb);
+	top_waiter = futex_top_waiter(hb, &key);
+	if (top_waiter) {
+		struct futex_pi_state *pi_state = top_waiter->pi_state;
+
+		ret = -EINVAL;
+		if (!pi_state)
+			goto out_unlock;
+
 		/*
-		 * In case of success wake_futex_pi dropped the hash
-		 * bucket lock.
+		 * If current does not own the pi_state then the futex is
+		 * inconsistent and user space fiddled with the futex value.
+		 */
+		if (pi_state->owner != current)
+			goto out_unlock;
+
+		get_pi_state(pi_state);
+		/*
+		 * By taking wait_lock while still holding hb->lock, we ensure
+		 * there is no point where we hold neither; and therefore
+		 * wake_futex_pi() must observe a state consistent with what we
+		 * observed.
+		 */
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		/*
+		 * Magic trickery for now to make the RT migrate disable
+		 * logic happy. The following spin_unlock() happens with
+		 * interrupts disabled so the internal migrate_enable()
+		 * won't undo the migrate_disable() which was issued when
+		 * locking hb->lock.
+		 */
+		migrate_disable();
+		spin_unlock(&hb->lock);
+
+		/* Drops pi_state->pi_mutex.wait_lock */
+		ret = wake_futex_pi(uaddr, uval, pi_state);
+
+		migrate_enable();
+
+		put_pi_state(pi_state);
+
+		/*
+		 * Success, we're done! No tricky corner cases.
 		 */
 		if (!ret)
 			goto out_putkey;
@@ -2690,7 +2868,6 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * setting the FUTEX_WAITERS bit. Try again.
 		 */
 		if (ret == -EAGAIN) {
-			spin_unlock(&hb->lock);
 			put_futex_key(&key);
 			goto retry;
 		}
@@ -2698,7 +2875,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * wake_futex_pi has detected invalid state. Tell user
 		 * space.
 		 */
-		goto out_unlock;
+		goto out_putkey;
 	}
 
 	/*
@@ -2708,8 +2885,10 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))
+	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, 0)) {
+		spin_unlock(&hb->lock);
 		goto pi_faulted;
+	}
 
 	/*
 	 * If uval has changed, let user space handle it.
@@ -2723,7 +2902,6 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	return ret;
 
 pi_faulted:
-	spin_unlock(&hb->lock);
 	put_futex_key(&key);
 
 	ret = fault_in_user_writeable(uaddr);
@@ -2827,6 +3005,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 				 u32 __user *uaddr2)
 {
 	struct hrtimer_sleeper timeout, *to = NULL;
+	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb, *hb2;
 	union futex_key key2 = FUTEX_KEY_INIT;
@@ -2944,8 +3123,10 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			spin_lock(&hb2->lock);
 			BUG_ON(&hb2->lock != q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
-			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current)
-				rt_mutex_unlock(&q.pi_state->pi_mutex);
+			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
+				pi_state = q.pi_state;
+				get_pi_state(pi_state);
+			}
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
@@ -2963,11 +3144,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
-		debug_rt_mutex_free_waiter(&rt_waiter);
+		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
 		spin_lock(&hb2->lock);
 		BUG_ON(&hb2->lock != q.lock_ptr);
+		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
+			ret = 0;
+
+		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
 		 * haven't already.
@@ -2985,13 +3169,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * the fault, unlock the rt_mutex and return the fault to
 		 * userspace.
 		 */
-		if (ret && rt_mutex_owner(pi_mutex) == current)
-			rt_mutex_unlock(pi_mutex);
+		if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
+			pi_state = q.pi_state;
+			get_pi_state(pi_state);
+		}
 
 		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
 	}
 
+	if (pi_state) {
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+	}
+
 	if (ret == -EINTR) {
 		/*
 		 * We've already been requeued, but cannot restart by calling
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -173,12 +173,3 @@ void debug_rt_mutex_init(struct rt_mutex *lock, const char *name)
 	lock->name = name;
 }
 
-void
-rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task)
-{
-}
-
-void rt_mutex_deadlock_account_unlock(struct task_struct *task)
-{
-}
-
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -9,9 +9,6 @@
  * This file contains macros used solely by rtmutex.c. Debug version.
  */
 
-extern void
-rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task);
-extern void rt_mutex_deadlock_account_unlock(struct task_struct *task);
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -978,8 +978,6 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 	 */
 	rt_mutex_set_owner(lock, task);
 
-	rt_mutex_deadlock_account_lock(lock, task);
-
 	return 1;
 }
 
@@ -998,19 +996,18 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 		migrate_disable();
 
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		rt_mutex_deadlock_account_lock(lock, current);
+		return;
 	else
 		slowfn(lock, do_mig_dis);
 }
 
-static inline int rt_spin_lock_fastunlock(struct rt_mutex *lock,
-					  int (*slowfn)(struct rt_mutex *lock))
+static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
+					   void  (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
-		rt_mutex_deadlock_account_unlock(current);
-		return 0;
-	}
-	return slowfn(lock);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+	else
+		slowfn(lock);
 }
 #ifdef CONFIG_SMP
 /*
@@ -1151,7 +1148,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
-static int noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 {
 	unsigned long flags;
 	WAKE_Q(wake_q);
@@ -1161,12 +1158,10 @@ static int noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	debug_rt_mutex_unlock(lock);
 
-	rt_mutex_deadlock_account_unlock(current);
-
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return 0;
+		return;
 	}
 
 	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
@@ -1177,33 +1172,6 @@ static int noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
-	return 0;
-}
-
-static int noinline __sched rt_spin_lock_slowunlock_no_deboost(struct rt_mutex *lock)
-{
-	unsigned long flags;
-	WAKE_Q(wake_q);
-	WAKE_Q(wake_sleeper_q);
-
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	debug_rt_mutex_unlock(lock);
-
-	rt_mutex_deadlock_account_unlock(current);
-
-	if (!rt_mutex_has_waiters(lock)) {
-		lock->owner = NULL;
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return 0;
-	}
-
-	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
-
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	wake_up_q_sleeper(&wake_sleeper_q);
-	return 1;
 }
 
 void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
@@ -1258,17 +1226,6 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
-int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock)
-{
-	int ret;
-
-	/* NOTE: we always pass in '1' for nested, for simplicity */
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	ret = rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_no_deboost);
-	migrate_enable();
-	return ret;
-}
-
 void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
 {
 	rt_spin_lock_fastunlock(lock, rt_spin_lock_slowunlock);
@@ -1644,6 +1601,15 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 				   next_lock, NULL, task);
 }
 
+void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter, bool savestate)
+{
+	debug_rt_mutex_init_waiter(waiter);
+	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	RB_CLEAR_NODE(&waiter->tree_entry);
+	waiter->task = NULL;
+	waiter->savestate = savestate;
+}
+
 /**
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
@@ -1926,8 +1892,6 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 
 	debug_rt_mutex_unlock(lock);
 
-	rt_mutex_deadlock_account_unlock(current);
-
 	/*
 	 * We must be careful here if the fast path is enabled. If we
 	 * have no waiters queued we cannot set owner to NULL here
@@ -1995,12 +1959,10 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 				enum rtmutex_chainwalk chwalk,
 				struct ww_acquire_ctx *ww_ctx))
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-	} else
-		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
-			      ww_ctx);
+
+	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
 static inline int
@@ -2014,21 +1976,19 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 				      struct ww_acquire_ctx *ww_ctx))
 {
 	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
-	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-	} else
-		return slowfn(lock, state, timeout, chwalk, ww_ctx);
+
+	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 1;
-	}
+
 	return slowfn(lock);
 }
 
@@ -2040,20 +2000,19 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 {
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
+	bool deboost;
 
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
-		rt_mutex_deadlock_account_unlock(current);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
 
-	} else {
-		bool deboost = slowfn(lock, &wake_q, &wake_sleeper_q);
+	deboost = slowfn(lock, &wake_q, &wake_sleeper_q);
 
-		wake_up_q(&wake_q);
-		wake_up_q_sleeper(&wake_sleeper_q);
+	wake_up_q(&wake_q);
+	wake_up_q_sleeper(&wake_sleeper_q);
 
-		/* Undo pi boosting if necessary: */
-		if (deboost)
-			rt_mutex_adjust_prio(current);
-	}
+	/* Undo pi boosting if necessary: */
+	if (deboost)
+		rt_mutex_adjust_prio(current);
 }
 
 /**
@@ -2087,16 +2046,11 @@ int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
 /*
- * Futex variant with full deadlock detection.
+ * Futex variant, must not use fastpath.
  */
-int rt_mutex_timed_futex_lock(struct rt_mutex *lock,
-			      struct hrtimer_sleeper *timeout)
+int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       RT_MUTEX_FULL_CHAINWALK, NULL,
-				       rt_mutex_slowlock);
+	return rt_mutex_slowtrylock(lock);
 }
 
 /**
@@ -2179,21 +2133,41 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /**
- * rt_mutex_futex_unlock - Futex variant of rt_mutex_unlock
- * @lock: the rt_mutex to be unlocked
- *
- * Returns: true/false indicating whether priority adjustment is
- * required or not.
+ * Futex variant, that since futex variants do not use the fast-path, can be
+ * simple and will not need to retry.
  */
-bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock,
-				   struct wake_q_head *wqh,
-				   struct wake_q_head *wq_sleeper)
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
+				    struct wake_q_head *wake_q,
+				    struct wake_q_head *wq_sleeper)
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
-		rt_mutex_deadlock_account_unlock(current);
-		return false;
+	lockdep_assert_held(&lock->wait_lock);
+
+	debug_rt_mutex_unlock(lock);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner = NULL;
+		return false; /* done */
+	}
+
+	mark_wakeup_next_waiter(wake_q, wq_sleeper, lock);
+	return true; /* deboost and wakeups */
+}
+
+void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
+{
+	WAKE_Q(wake_q);
+	WAKE_Q(wake_sleeper_q);
+	bool deboost;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	deboost = __rt_mutex_futex_unlock(lock, &wake_q, &wake_sleeper_q);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	if (deboost) {
+		wake_up_q(&wake_q);
+		wake_up_q_sleeper(&wake_sleeper_q);
+		rt_mutex_adjust_prio(current);
 	}
-	return rt_mutex_slowunlock(lock, wqh, wq_sleeper);
 }
 
 /**
@@ -2249,7 +2223,6 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 	rt_mutex_init(lock);
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
-	rt_mutex_deadlock_account_lock(lock, proxy_owner);
 }
 
 /**
@@ -2265,34 +2238,16 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
-	rt_mutex_deadlock_account_unlock(proxy_owner);
 }
 
-/**
- * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
- * @lock:		the rt_mutex to take
- * @waiter:		the pre-initialized rt_mutex_waiter
- * @task:		the task to prepare
- *
- * Returns:
- *  0 - task blocked on lock
- *  1 - acquired the lock for task, caller should wake it up
- * <0 - error
- *
- * Special API call for FUTEX_REQUEUE_PI support.
- */
-int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
 			      struct task_struct *task)
 {
 	int ret;
 
-	raw_spin_lock_irq(&lock->wait_lock);
-
-	if (try_to_take_rt_mutex(lock, task, NULL)) {
-		raw_spin_unlock_irq(&lock->wait_lock);
+	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
-	}
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 	/*
@@ -2340,14 +2295,38 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
-	raw_spin_unlock_irq(&lock->wait_lock);
-
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
 }
 
 /**
+ * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for FUTEX_REQUEUE_PI support.
+ */
+int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+			      struct rt_mutex_waiter *waiter,
+			      struct task_struct *task)
+{
+	int ret;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return ret;
+}
+
+/**
  * rt_mutex_next_owner - return the next owner of the lock
  *
  * @lock: the rt lock query
@@ -2368,21 +2347,23 @@ struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
 }
 
 /**
- * rt_mutex_finish_proxy_lock() - Complete lock acquisition
+ * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Complete the lock acquisition started our behalf by another thread.
+ * Wait for the the lock acquisition started on our behalf by
+ * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
+ * rt_mutex_cleanup_proxy_lock().
  *
  * Returns:
  *  0 - success
  * <0 - error, one of -EINTR, -ETIMEDOUT
  *
- * Special API call for PI-futex requeue support
+ * Special API call for PI-futex support
  */
-int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
+int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
@@ -2395,8 +2376,45 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
 
-	if (unlikely(ret))
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return ret;
+}
+
+/**
+ * rt_mutex_cleanup_proxy_lock() - Cleanup failed lock acquisition
+ * @lock:		the rt_mutex we were woken on
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ *
+ * Attempt to clean up after a failed rt_mutex_wait_proxy_lock().
+ *
+ * Unless we acquired the lock; we're still enqueued on the wait-list and can
+ * in fact still be granted ownership until we're removed. Therefore we can
+ * find we are in fact the owner and must disregard the
+ * rt_mutex_wait_proxy_lock() failure.
+ *
+ * Returns:
+ *  true  - did the cleanup, we done.
+ *  false - we acquired the lock after rt_mutex_wait_proxy_lock() returned,
+ *          caller should disregards its return value.
+ *
+ * Special API call for PI-futex support
+ */
+bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter)
+{
+	bool cleanup = false;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	/*
+	 * Unless we're the owner; we're still enqueued on the wait_list.
+	 * So check if we became owner, if not, take us off the wait_list.
+	 */
+	if (rt_mutex_owner(lock) != current) {
 		remove_waiter(lock, waiter);
+		fixup_rt_mutex_waiters(lock);
+		cleanup = true;
+	}
 
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
@@ -2406,7 +2424,7 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-	return ret;
+	return cleanup;
 }
 
 static inline int
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -11,8 +11,6 @@
  */
 
 #define rt_mutex_deadlock_check(l)			(0)
-#define rt_mutex_deadlock_account_lock(m, t)		do { } while (0)
-#define rt_mutex_deadlock_account_unlock(l)		do { } while (0)
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
 #define debug_rt_mutex_lock(l)				do { } while (0)
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -107,16 +107,26 @@ extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
 extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 				  struct task_struct *proxy_owner);
+extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter, bool savetate);
+extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+				     struct rt_mutex_waiter *waiter,
+				     struct task_struct *task);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
-				      struct hrtimer_sleeper *to,
-				      struct rt_mutex_waiter *waiter);
-extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
-extern bool rt_mutex_futex_unlock(struct rt_mutex *lock,
-				  struct wake_q_head *wqh,
-				  struct wake_q_head *wq_sleeper);
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+			       struct hrtimer_sleeper *to,
+			       struct rt_mutex_waiter *waiter);
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter);
+
+extern int rt_mutex_futex_trylock(struct rt_mutex *l);
+
+extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
+extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
+				 struct wake_q_head *wqh,
+				 struct wake_q_head *wq_sleeper);
+
 extern void rt_mutex_adjust_prio(struct task_struct *task);
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
@@ -125,14 +135,4 @@ extern void rt_mutex_adjust_prio(struct task_struct *task);
 # include "rtmutex.h"
 #endif
 
-static inline void
-rt_mutex_init_waiter(struct rt_mutex_waiter *waiter, bool savestate)
-{
-	debug_rt_mutex_init_waiter(waiter);
-	waiter->task = NULL;
-	waiter->savestate = savestate;
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
-}
-
 #endif
diff --git a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -677,8 +677,12 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 			void *va = (void *)addr;
 
 			if (va >= start && va < start + mod->percpu_size) {
-				if (can_addr)
+				if (can_addr) {
 					*can_addr = (unsigned long) (va - start);
+					*can_addr += (unsigned long)
+						per_cpu_ptr(mod->percpu,
+							    get_boot_cpu_id());
+				}
 				preempt_enable();
 				return true;
 			}
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
diff --git a/mm/percpu.c b/mm/percpu.c
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1295,8 +1295,11 @@ bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 		void *va = (void *)addr;
 
 		if (va >= start && va < start + static_size) {
-			if (can_addr)
+			if (can_addr) {
 				*can_addr = (unsigned long) (va - start);
+				*can_addr += (unsigned long)
+					per_cpu_ptr(base, get_boot_cpu_id());
+			}
 			return true;
 		}
 	}
