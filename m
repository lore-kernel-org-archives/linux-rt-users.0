From: Thavatchai Makphaibulchoke <tmac@hp.com>
Subject: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at kernel/locking/rtmutex.c:997!
Date: Thu, 19 Feb 2015 18:31:05 -0700
Message-ID: <1424395866-81589-2-git-send-email-tmac@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
Cc: mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Thavatchai Makphaibulchoke <tmac@hp.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424395866-81589-1-git-send-email-tmac@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch fixes the problem that the ownership of a mutex acquired by an
interrupt handler(IH) gets incorrectly attributed to the interrupted thread.

This could result in an incorrect deadlock detection in function
rt_mutex_adjust_prio_chain(), causing thread to be killed and possibly leading
up to a system hang.

Here is the approach taken: when calling from an interrupt handler, instead of
attributing ownership to the interrupted task, use a reserved task_struct value
to indicate that the owner is a interrupt handler.  This approach avoids the
incorrect deadlock detection.

This also includes changes in several function in rtmutex.c now that the lock's
requester may be a interrupt handler, not a real task struct.  This impacts
the way how the lock is acquired and prioritized and decision whether to do
the house keeping functions required for a real task struct.

The reserved task_struct values for interrupt handler are

	current | 0x2

where current is the task_struct value of the interrupted task.

Since IH will both acquire and release the lock only during an interrupt
handling, during which current is not changed, the reserved task_struct value
for an IH should be distinct from another instances of IH on a different cpu.

Kernel version 3.14.25 + patch-3.14.25-rt22

Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
---
 include/linux/spinlock_rt.h     |   4 +
 kernel/locking/rtmutex-debug.c  |  15 ++-
 kernel/locking/rtmutex.c        | 212 ++++++++++++++++++++++++++++------------
 kernel/locking/rtmutex_common.h |  21 ++++
 kernel/timer.c                  |   4 +-
 5 files changed, 188 insertions(+), 68 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index c0d1367..eeb4188 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -27,6 +27,7 @@ extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock(spinlock_t *lock);
+extern int __lockfunc rt_spin_trylock_in_interrupt(spinlock_t *lock);
 extern int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock);
 
 /*
@@ -52,6 +53,9 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 
 #define spin_lock_irq(lock)		spin_lock(lock)
 
+#define spin_do_trylock_in_interrupt(lock)	\
+		__cond_lock(lock, rt_spin_trylock_in_interrupt(lock))
+
 #define spin_do_trylock(lock)		__cond_lock(lock, rt_spin_trylock(lock))
 
 #define spin_trylock(lock)			\
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 49b2ed3..c36d629 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -40,6 +40,8 @@ static void printk_task(struct task_struct *p)
 
 static void printk_lock(struct rt_mutex *lock, int print_owner)
 {
+	struct task_struct *owner = rt_mutex_owner(lock);
+
 	if (lock->name)
 		printk(" [%p] {%s}\n",
 			lock, lock->name);
@@ -47,10 +49,13 @@ static void printk_lock(struct rt_mutex *lock, int print_owner)
 		printk(" [%p] {%s:%d}\n",
 			lock, lock->file, lock->line);
 
-	if (print_owner && rt_mutex_owner(lock)) {
+	if (print_owner && owner) {
 		printk(".. ->owner: %p\n", lock->owner);
 		printk(".. held by:  ");
-		printk_task(rt_mutex_owner(lock));
+		if (rt_mutex_owner_is_task(owner))
+			printk_task(owner);
+		else
+			printk(" an interrupt handler.");
 		printk("\n");
 	}
 }
@@ -76,6 +81,8 @@ void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *act_waiter,
 
 	task = rt_mutex_owner(act_waiter->lock);
 	if (task && task != current) {
+		/* Interrupt handler should not be deadlocking. */
+		BUG_ON(!rt_mutex_owner_is_task(task));
 		act_waiter->deadlock_task_pid = get_pid(task_pid(task));
 		act_waiter->deadlock_lock = lock;
 	}
@@ -138,7 +145,9 @@ void debug_rt_mutex_lock(struct rt_mutex *lock)
 
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
-	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
+	DEBUG_LOCKS_WARN_ON(in_interrupt() ?
+		!rt_mutex_owner_is_task(rt_mutex_owner(lock)) :
+		rt_mutex_owner(lock) != current);
 }
 
 void
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660..8b66f81 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -51,6 +51,9 @@
  * waiters. This can happen when grabbing the lock in the slow path.
  * To prevent a cmpxchg of the owner releasing the lock, we need to
  * set this bit before looking at the lock.
+ *
+ * owner can also be reserved value, INTERRUPT_HANDLER, in case the mutex
+ * is owned by an interrupt handler.
  */
 
 static void
@@ -366,10 +369,11 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 				      struct rt_mutex_waiter *orig_waiter,
 				      struct task_struct *top_task)
 {
-	struct rt_mutex *lock;
+	struct rt_mutex *lock = NULL;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	int detect_deadlock, ret = 0, depth = 0;
 	unsigned long flags;
+	struct task_struct *owner;
 
 	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
 							 deadlock_detect);
@@ -417,8 +421,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * Check the orig_waiter state. After we dropped the locks,
 	 * the previous owner of the lock might have released the lock.
 	 */
-	if (orig_waiter && !rt_mutex_owner(orig_lock))
-		goto out_unlock_pi;
+	if (orig_waiter) {
+		struct task_struct *orig_owner;
+
+		WARN_ON(!orig_lock);
+		orig_owner = rt_mutex_owner(orig_lock);
+		if (!orig_owner || !rt_mutex_owner_is_task(orig_owner))
+			goto out_unlock_pi;
+	}
 
 	/*
 	 * We dropped all locks after taking a refcount on @task, so
@@ -484,16 +494,24 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* Release the task */
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-	if (!rt_mutex_owner(lock)) {
-		struct rt_mutex_waiter *lock_top_waiter;
-
-		/*
-		 * If the requeue above changed the top waiter, then we need
-		 * to wake the new top waiter up to try to get the lock.
-		 */
-		lock_top_waiter = rt_mutex_top_waiter(lock);
-		if (top_waiter != lock_top_waiter)
-			rt_mutex_wake_waiter(lock_top_waiter);
+	owner = rt_mutex_owner(lock);
+	/*
+	 * No need to continue if lock is either free or
+	 * owned by an interrupt handler.
+	 */
+	if (!owner || !rt_mutex_owner_is_task(owner)) {
+		if (!owner) {
+			struct rt_mutex_waiter *lock_top_waiter;
+
+			/*
+			 * If the lock is free and the requeue above changed the
+			 * top waiter, then we need to wake the new top waiter
+			 * up to try to get the lock.
+			 */
+			lock_top_waiter = rt_mutex_top_waiter(lock);
+			if (top_waiter != lock_top_waiter)
+				rt_mutex_wake_waiter(lock_top_waiter);
+		}
 		raw_spin_unlock(&lock->wait_lock);
 		goto out_put_task;
 	}
@@ -583,6 +601,8 @@ static int
 __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 		       struct rt_mutex_waiter *waiter, int mode)
 {
+	int caller_is_task = rt_mutex_owner_is_task(task);
+	int has_waiters;
 	/*
 	 * We have to be careful here if the atomic speedups are
 	 * enabled, such that, when
@@ -613,43 +633,47 @@ __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	 * 2) higher priority than waiters
 	 * 3) it is top waiter
 	 */
-	if (rt_mutex_has_waiters(lock)) {
+	has_waiters = rt_mutex_has_waiters(lock);
+	if (has_waiters) {
 		struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
 
-		if (task != pown && !lock_is_stealable(task, pown, mode))
+		if (!caller_is_task || (task != pown &&
+			!lock_is_stealable(task, pown, mode)))
 			return 0;
 	}
 
 	/* We got the lock. */
 
-	if (waiter || rt_mutex_has_waiters(lock)) {
+	if (waiter || has_waiters) {
 		unsigned long flags;
 		struct rt_mutex_waiter *top;
 
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
-
 		/* remove the queued waiter. */
-		if (waiter) {
+		if (waiter)
 			rt_mutex_dequeue(lock, waiter);
-			task->pi_blocked_on = NULL;
-		}
 
-		/*
-		 * We have to enqueue the top waiter(if it exists) into
-		 * task->pi_waiters list.
-		 */
-		if (rt_mutex_has_waiters(lock)) {
-			top = rt_mutex_top_waiter(lock);
-			rt_mutex_enqueue_pi(task, top);
+		if (caller_is_task) {
+			raw_spin_lock_irqsave(&task->pi_lock, flags);
+			if (waiter)
+				task->pi_blocked_on = NULL;
+			/*
+			 * We have to enqueue the top waiter(if it exists) into
+			 * task->pi_waiters list.
+			 */
+			if (rt_mutex_has_waiters(lock)) {
+				top = rt_mutex_top_waiter(lock);
+				rt_mutex_enqueue_pi(task, top);
+			}
+			raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		}
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 	}
 
 	debug_rt_mutex_lock(lock);
 
 	rt_mutex_set_owner(lock, task);
 
-	rt_mutex_deadlock_account_lock(lock, task);
+	if (caller_is_task)
+		rt_mutex_deadlock_account_lock(lock, task);
 
 	return 1;
 }
@@ -723,14 +747,13 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 
-	if (!owner)
+	if (!owner || !rt_mutex_owner_is_task(owner))
 		return 0;
 
 	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 	if (waiter == rt_mutex_top_waiter(lock)) {
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
-
 		__rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
@@ -777,21 +800,27 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  */
 static void wakeup_next_waiter(struct rt_mutex *lock)
 {
+	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *waiter;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
-
 	waiter = rt_mutex_top_waiter(lock);
 
-	/*
-	 * Remove it from current->pi_waiters. We do not adjust a
-	 * possible priority boost right now. We execute wakeup in the
-	 * boosted mode and go back to normal after releasing
-	 * lock->wait_lock.
-	 */
-	rt_mutex_dequeue_pi(current, waiter);
+	/* Check to make sure caller is not interrupt handler */
+	if (rt_mutex_owner_is_task(owner)) {
 
+		raw_spin_lock_irqsave(&owner->pi_lock, flags);
+
+		/*
+		 * Remove it from current->pi_waiters. We do not adjust a
+		 * possible priority boost right now. We execute wakeup in the
+		 * boosted mode and go back to normal after releasing
+		 * lock->wait_lock.
+		 */
+		rt_mutex_dequeue_pi(owner, waiter);
+
+		raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
+	}
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
 	 * queued on the lock until it gets the lock, this lock
@@ -802,7 +831,6 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 	 */
 	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
 
-	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	/*
 	 * It's safe to dereference waiter as it cannot go away as
@@ -831,7 +859,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
-	if (!owner)
+	/* Return if no owner or owned by interrupt handler */
+	if (!owner || !rt_mutex_owner_is_task(owner))
 		return;
 
 	if (first) {
@@ -902,6 +931,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 					 void  (*slowfn)(struct rt_mutex *lock))
 {
+	/* Might sleep, should not be called in interrupt context. */
+	BUG_ON(in_interrupt());
 	might_sleep();
 
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current)))
@@ -911,12 +942,12 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 }
 
 static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
-					   void  (*slowfn)(struct rt_mutex *lock))
+	void (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
 {
 	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
 		rt_mutex_deadlock_account_unlock(current);
 	else
-		slowfn(lock);
+		slowfn(lock, current);
 }
 
 #ifdef CONFIG_SMP
@@ -937,10 +968,12 @@ static int adaptive_wait(struct rt_mutex *lock,
 		 * Ensure that owner->on_cpu is dereferenced _after_
 		 * checking the above to be valid.
 		 */
-		barrier();
-		if (!owner->on_cpu) {
-			res = 1;
-			break;
+		if (rt_mutex_owner_is_task(owner)) {
+			barrier();
+			if (!owner->on_cpu) {
+				res = 1;
+				break;
+			}
 		}
 		cpu_relax();
 	}
@@ -971,6 +1004,8 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	struct rt_mutex_waiter waiter, *top_waiter;
 	int ret;
 
+	/* Might sleep, should not be called in interrupt context. */
+	BUG_ON(in_interrupt());
 	rt_mutex_init_waiter(&waiter, true);
 
 	raw_spin_lock(&lock->wait_lock);
@@ -1008,6 +1043,10 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
+		/*
+		 * If lock is owned by interrupt handler, go ahead and
+		 * retry. Interrupt handler should complete soon.
+		 */
 		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
 			schedule_rt_mutex(lock);
 
@@ -1047,11 +1086,15 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
-static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock,
+	struct task_struct *task)
 {
+	int caller_is_task = rt_mutex_owner_is_task(task);
+
 	debug_rt_mutex_unlock(lock);
 
-	rt_mutex_deadlock_account_unlock(current);
+	if (caller_is_task)
+		rt_mutex_deadlock_account_unlock(task);
 
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
@@ -1064,24 +1107,30 @@ static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	raw_spin_unlock(&lock->wait_lock);
 
 	/* Undo pi boosting.when necessary */
-	rt_mutex_adjust_prio(current);
+	if (caller_is_task)
+		rt_mutex_adjust_prio(task);
 }
 
-static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static noinline void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock,
+	struct task_struct *task)
 {
 	raw_spin_lock(&lock->wait_lock);
-	__rt_spin_lock_slowunlock(lock);
+	__rt_spin_lock_slowunlock(lock, task);
 }
 
-static void  noinline __sched rt_spin_lock_slowunlock_hirq(struct rt_mutex *lock)
+static inline void rt_spin_lock_fastunlock_in_irq(struct rt_mutex *lock,
+	void (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
 {
 	int ret;
+	struct task_struct *intr_owner = rt_mutex_owner_intr_handler(current);
 
+	if (likely(rt_mutex_cmpxchg(lock, intr_owner, NULL)))
+		return;
 	do {
 		ret = raw_spin_trylock(&lock->wait_lock);
 	} while (!ret);
 
-	__rt_spin_lock_slowunlock(lock);
+	slowfn(lock, intr_owner);
 }
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
@@ -1100,6 +1149,8 @@ EXPORT_SYMBOL(__rt_spin_lock);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
+	/* Might sleep, should not be called in interrupt context. */
+	BUG_ON(in_interrupt());
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 }
@@ -1118,7 +1169,7 @@ void __lockfunc rt_spin_unlock_after_trylock_in_irq(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
-	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_hirq);
+	rt_spin_lock_fastunlock_in_irq(&lock->lock, __rt_spin_lock_slowunlock);
 }
 
 void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
@@ -1266,6 +1317,8 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	int ret = 0;
 
 	for (;;) {
+		struct task_struct *owner;
+
 		/* Try to acquire the lock: */
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
@@ -1290,11 +1343,17 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 				break;
 		}
 
+		owner = rt_mutex_owner(lock);
 		raw_spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(waiter);
 
-		schedule_rt_mutex(lock);
+		/*
+		 * Only try to reschedule, if owner is a real task.
+		 * Interrupt handler should complete soon.
+		 */
+		if (!owner || rt_mutex_owner_is_task(owner))
+			schedule_rt_mutex(lock);
 
 		raw_spin_lock(&lock->wait_lock);
 		set_current_state(state);
@@ -1410,6 +1469,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
 
+	/* Might sleep, should not be called in interrupt context. */
+	BUG_ON(in_interrupt());
 	rt_mutex_init_waiter(&waiter, false);
 
 	raw_spin_lock(&lock->wait_lock);
@@ -1466,16 +1527,16 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
  * Slow path try-lock function:
  */
 static inline int
-rt_mutex_slowtrylock(struct rt_mutex *lock)
+rt_mutex_slowtrylock(struct rt_mutex *lock, struct task_struct *task)
 {
 	int ret = 0;
 
 	if (!raw_spin_trylock(&lock->wait_lock))
 		return ret;
 
-	if (likely(rt_mutex_owner(lock) != current)) {
+	if (likely(rt_mutex_owner(lock) != task)) {
 
-		ret = try_to_take_rt_mutex(lock, current, NULL);
+		ret = try_to_take_rt_mutex(lock, task, NULL);
 		/*
 		 * try_to_take_rt_mutex() sets the lock waiters
 		 * bit unconditionally. Clean this up.
@@ -1590,13 +1651,25 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock))
+	int (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 1;
 	}
-	return slowfn(lock);
+	return slowfn(lock, current);
+}
+
+static inline int
+rt_mutex_fasttrylock_in_irq(struct rt_mutex *lock,
+	int (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
+{
+	struct task_struct *intr_owner = rt_mutex_owner_intr_handler(current);
+
+	/* Called by interrupt handler, use reservered task_strcut */
+	if (likely(rt_mutex_cmpxchg(lock, NULL, intr_owner)))
+		return 1;
+	return slowfn(lock, intr_owner);
 }
 
 static inline void
@@ -1609,6 +1682,19 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 		slowfn(lock);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+int __lockfunc rt_spin_trylock_in_interrupt(spinlock_t *lock)
+{
+	int ret = rt_mutex_fasttrylock_in_irq(&lock->lock,
+			rt_mutex_slowtrylock);
+
+	if (ret)
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(rt_spin_trylock_in_interrupt);
+#endif /* PREEMPT_RT_FULL */
+
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ac636d3..fc0ad46 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -95,6 +95,8 @@ task_top_pi_waiter(struct task_struct *p)
  */
 #define RT_MUTEX_HAS_WAITERS	1UL
 #define RT_MUTEX_OWNER_MASKALL	1UL
+#define RT_MUTEX_OWNER_MASKBITS	1UL
+#define RT_MUTEX_INTR_HDLR_BITS	2UL
 
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 {
@@ -103,6 +105,25 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 }
 
 /*
+ * Function to determine if a lock->owner task_struct is a real task.
+ */
+static inline int rt_mutex_owner_is_task(struct task_struct *task)
+{
+	return !((unsigned long)task & RT_MUTEX_INTR_HDLR_BITS);
+}
+
+/*
+ * Function to generate rtmutex's owner task_struct for interrupt handler from
+ * a given interrupted task.
+ */
+static inline struct task_struct *rt_mutex_owner_intr_handler(struct task_struct
+	*task)
+{
+	return (struct task_struct *)((unsigned long)task |
+		RT_MUTEX_INTR_HDLR_BITS);
+}
+
+/*
  * PI-futex support (proxy locking functions, etc.):
  */
 #define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
diff --git a/kernel/timer.c b/kernel/timer.c
index 8f1687a..b34efb6 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1389,7 +1389,7 @@ unsigned long get_next_timer_interrupt(unsigned long now)
 	 * value.  We use the rt functions here directly to avoid a
 	 * migrate_disable() call.
 	 */
-	if (!spin_do_trylock(&base->lock))
+	if (!spin_do_trylock_in_interrupt(&base->lock))
 		return  now + 1;
 #else
 	spin_lock(&base->lock);
@@ -1480,7 +1480,7 @@ void run_local_timers(void)
 		return;
 	}
 
-	if (!spin_do_trylock(&base->lock)) {
+	if (!spin_do_trylock_in_interrupt(&base->lock)) {
 		raise_softirq(TIMER_SOFTIRQ);
 		return;
 	}
-- 
1.9.1
