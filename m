From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT v2 1/3] [PATCH 1/3] locking: Add spin_trylock_or_boost() infrastructure
Date: Thu, 10 Sep 2015 10:50:56 -0400
Message-ID: <20150910150115.304708896@goodmis.org>
References: <20150910145055.948545589@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52568 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbbIJPBU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2015 11:01:20 -0400
Content-Disposition: inline; filename=0001-locking-Add-spin_trylock_or_boost-infrastructure.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In mainline Linux, there are cases where locks need to be taken in reverse
order. In non PREEMPT_RT code, spinlocks can not be preempted, thus if one
needs to take locks in reverse order, if it can't get the second lock, it
simply needs to release the first lock (the one that can cause a deadlock)
and try again. The owner of the second lock must be running on another CPU
and as long as it's not blocked on the held lock of the original task, then
progress will be made.

But things change when these locks become preemptive locks.

Simply releasing the first lock when failing to get the second lock wont
always work if the locks can be preempted. That's because the task could
have preempted the owner, and it can prevent the owner from making forward
progress. Just letting go of the first lock and trying again wont change the
state of things, as the owner will still be blocked by being preempted by
the original task. This is especially true when the original task is a
real-time task running a FIFO prio.

	<Task 1>
	Grab lock A

	<preempt to higher priority Task 2>

	Grab lock B
	try to grab lock A
	release lock B
	Grab lock B
	try to grab lock A
	<wash, rinse, repeat>  (sorry Fred)

As Task 1 will never run as long as Task 2 is spinning, no forward progress
is had, and this becomes a live lock (as suppose to a dead lock).

The solution here is to create add a static rt_mutex_waiter to the
task_struct. The rt_mutex_waiter is a structure that is used to connect
locks with owners and those that are blocked on the lock in order to
propagate priority inheritance. But the rt_mutex_waiter is allocated on the
stack when an rtmutex is blocked. This is fine, because the scope of that
waiter structure will be finished by the time the rtmutex function returns.
For the spin_trylock_or_boost() caller, the waiter's scope needs to go
beyond the function call, thus it must not be allocated on the stack. Adding
it to the task struct works, but only allows one trylock_or_boost to be
called, but that should be fine anyway (a warning is added if it is not).

The spin_trylock_or_boost() will add this new task_struct waiter to the pi
lists of the lock, and if necessary (if it is the highest waiter on the
lock) to the owner's pi list too. This is exactly the way things work with
the current pi inheritance logic.

Some things need to be changed though. As the waiter is not actually waiting
on the lock, the owner can't wake it up without prejudice, as the waiter
could have set itself in another state before calling cpu_chill(). A
"wake_up" field is added to the waiter and is set only when the task is
ready to receive the wakeup and it saves the current state.

When the owner of the lock releases the lock and picks this task to take the
lock next, it will remove it from the pi lists and clear the waiter->lock.
This is done under the task's pi_lock to make sure it synchronizes with the
cpu_chill() call.

When cpu_chill() is called, it will look to see if the task's static waiter
has a lock. If it does not, the cpu_chill will act like a cpu_relax(), as
that means the owner released the lock. The cpu_chill() will then set the
"wake_up" flag, save the state, and go to sleep in the TASK_INTERRUPTIBLE
state, as anything should be able to wake it up.

When it is woken, it clears the lock (if it hasn't already been done) and
removes itself from the pi lists.

Note, the reason that the owner of the lock clears the lock and does not let
the task stay on the pi lists, is because nothing prevents the lock from
being freed when there is no real owner of the task.

Note 2, if the task blocks on a rtmutex, or tries to call trylock_or_boost
again and fails while already boosting a lock, then it must remove itself
from the previous lock before it can boost another task. Only one boosting
per task is allowed. A task can not boost more than one task.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/rtmutex.h         |   1 +
 include/linux/sched.h           |  50 +++++++
 include/linux/spinlock.h        |   5 +
 include/linux/spinlock_rt.h     |  15 ++
 kernel/locking/rtmutex.c        | 323 +++++++++++++++++++++++++++++++++++++++-
 kernel/locking/rtmutex_common.h |  22 ---
 6 files changed, 386 insertions(+), 30 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index d5a04ea47a13..4ab8d4bddfbb 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -111,6 +111,7 @@ extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *timeout);
 
 extern int rt_mutex_trylock(struct rt_mutex *lock);
+extern int rt_mutex_try_or_boost_lock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 956658437527..94ebad0ac112 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1336,6 +1336,29 @@ enum perf_event_task_context {
 	perf_nr_task_contexts,
 };
 
+/*
+ * This is the control structure for tasks blocked on a rt_mutex,
+ * which is allocated on the kernel stack on of the blocked task.
+ *
+ * @tree_entry:		pi node to enqueue into the mutex waiters tree
+ * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
+ * @task:		task reference to the blocked task
+ */
+struct rt_mutex_waiter {
+	struct rb_node          tree_entry;
+	struct rb_node          pi_tree_entry;
+	struct task_struct	*task;
+	struct rt_mutex		*lock;
+	bool			savestate;
+	bool			wake_up;
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+	unsigned long		ip;
+	struct pid		*deadlock_task_pid;
+	struct rt_mutex		*deadlock_lock;
+#endif
+	int prio;
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	volatile long saved_state;	/* saved state for "spinlock sleepers" */
@@ -1357,6 +1380,33 @@ struct task_struct {
 
 	int prio, static_prio, normal_prio;
 	unsigned int rt_priority;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/*
+	 * There are cases where spinlocks are taken in reverse
+	 * order via a spin_trylock(). This is fine for true
+	 * spinlocks, but in PREEMPT_RT, they become mutexes.
+	 * If a real-time high priority task preempts the owner
+	 * of a lock it is trying to grab in reverse order with
+	 * a trylock, it can go into a livelock, as it spins
+	 * waiting for the owner to release the lock. But as it
+	 * has preempted that owner, and prevented it from continuing,
+	 * the lock is never released, and the high priority task
+	 * spins forever.
+	 *
+	 * For these cases, a spin_trylock_or_boost() must be used
+	 * on PREEMPT_RT. This will set the owner of the lock to the
+	 * prioirty of the caller of spin_trylock_or_boost()
+	 * via this trylock_prio field (if the owner has a lower
+	 * priority than the caller). This priority is always reset
+	 * whenever any spinlock converted rtmutex is released.
+	 * This guarantees forward progress of the trylock spin.
+	 *
+	 * Callers of spin_trylock_or_boost() must also call cpu_chill()
+	 * which on PREEMPT_RT is a sched_yield() that allows the
+	 * newly risen priority task to run ahead of the trylock spinner.
+	 */
+	struct rt_mutex_waiter	rt_waiter;
+#endif
 	const struct sched_class *sched_class;
 	struct sched_entity se;
 	struct sched_rt_entity rt;
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 28f4366fd495..1d15e8c1267f 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -330,6 +330,11 @@ static inline int spin_trylock(spinlock_t *lock)
 	return raw_spin_trylock(&lock->rlock);
 }
 
+static inline int spin_trylock_or_boost(spinlock_t *lock)
+{
+	return raw_spin_trylock(&lock->rlock);
+}
+
 #define spin_lock_nested(lock, subclass)			\
 do {								\
 	raw_spin_lock_nested(spinlock_check(lock), subclass);	\
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f757096b230c..e65951230e3e 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -26,6 +26,7 @@ extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock(spinlock_t *lock);
+extern int __lockfunc rt_spin_trylock_or_boost(spinlock_t *lock);
 extern int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock);
 
 /*
@@ -53,6 +54,8 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 
 #define spin_do_trylock(lock)		__cond_lock(lock, rt_spin_trylock(lock))
 
+#define spin_do_try_or_boost_lock(lock) __cond_lock(lock, rt_spin_trylock_or_boost(lock))
+
 #define spin_trylock(lock)			\
 ({						\
 	int __locked;				\
@@ -63,6 +66,16 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 	__locked;				\
 })
 
+#define spin_trylock_or_boost(lock)			\
+({							\
+	int __locked;					\
+	migrate_disable();				\
+	__locked = spin_do_try_or_boost_lock(lock);	\
+	if (!__locked)					\
+		migrate_enable();			\
+	__locked;					\
+})
+
 #ifdef CONFIG_LOCKDEP
 # define spin_lock_nested(lock, subclass)		\
 	do {						\
@@ -153,6 +166,8 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 # define spin_is_contended(lock)	(((void)(lock), 0))
 #endif
 
+void rt_mutex_wait_for_lock(struct task_struct *task);
+
 static inline int spin_can_lock(spinlock_t *lock)
 {
 	return !rt_mutex_is_locked(&lock->lock);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2822aceb8dfb..843b67f38e20 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -253,6 +253,258 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Returns true if the task should be woken up, false otherwise.
+ */
+static inline bool rt_mutex_wake_trylock_waiter(struct rt_mutex_waiter *waiter)
+{
+	struct task_struct *task = waiter->task;
+	unsigned long flags;
+	bool wakeup;
+
+	if (likely(waiter != &task->rt_waiter))
+		return true;
+
+	/*
+	 * A task boosted current because it is within a trylock spin.
+	 * But we only want to wake up the task if it is in the
+	 * cpu_chill() sleep, and not before. When the task is ready, it
+	 * will set "wake_up" to true. Otherwise we do nothing. When the
+	 * task gets to the cpu_chill() it will not sleep because the
+	 * waiter->lock will be NULL.
+	 */
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	rt_mutex_dequeue(waiter->lock, waiter);
+	waiter->lock = NULL;
+
+	wakeup = waiter->wake_up;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	return wakeup;
+}
+
+static void __rt_mutex_adjust_prio(struct task_struct *task);
+
+/* 
+ * Called with lock->wait_lock held and must call
+ * rt_mutex_adjust_prio_chain() if an owner is returned
+ */
+static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
+{
+	struct rt_mutex_waiter *top_waiter = NULL;
+	struct rt_mutex_waiter *waiter;
+	struct task_struct *task = current;
+	struct task_struct *owner;
+
+	owner = rt_mutex_owner(lock);
+	if (!owner)
+		return NULL;
+
+	waiter = &task->rt_waiter;
+
+	raw_spin_lock_irq(&task->pi_lock);
+
+	/*
+	 * current is already waiting for another lock owner?
+	 * This should never happen. Don't add another.
+	 */
+	if (WARN_ON_ONCE(waiter->lock)) {
+		raw_spin_unlock_irq(&task->pi_lock);
+		return NULL;
+	}
+
+	/* Add waiter to lock */
+	waiter->task = task;
+	waiter->lock = lock;
+	waiter->prio = task->prio;
+	waiter->wake_up = false;
+	raw_spin_unlock_irq(&task->pi_lock);
+
+	if (rt_mutex_has_waiters(lock))
+		top_waiter = rt_mutex_top_waiter(lock);
+
+	rt_mutex_enqueue(lock, waiter);
+
+	if (waiter == rt_mutex_top_waiter(lock)) {
+		raw_spin_lock_irq(&owner->pi_lock);
+		if (top_waiter)
+			rt_mutex_dequeue_pi(owner, top_waiter);
+		rt_mutex_enqueue_pi(owner, waiter);
+		__rt_mutex_adjust_prio(owner);
+		raw_spin_unlock_irq(&owner->pi_lock);
+
+		/* Will be released by rt_mutex_adjust_prio_chain() */
+		get_task_struct(owner);
+
+		/* New top waiter, need to do the chain walk */
+		return owner;
+	}
+
+	return NULL;
+}
+
+/*
+ * Returns true if lock->wait_lock was released.
+ */
+static inline bool check_static_waiter(struct task_struct *task,
+				       struct rt_mutex *orig_lock, bool ok)
+{
+	struct rt_mutex_waiter *top_waiter;
+	struct rt_mutex_waiter *waiter = &task->rt_waiter;
+	struct task_struct *owner;
+	struct rt_mutex *lock;
+
+	if (likely(!waiter->lock))
+		return false;
+
+	/* Only spinlock converted to rtmutex may be called with a waiter */
+	BUG_ON(!ok);
+
+	/*
+	 * The task is about to block on a lock, and it boosted
+	 * the owner of another lock. The pi chain can not handle
+	 * the same task on the chain at once. This task is going
+	 * to go to sleep anyway, remove itself from the other lock.
+	 */
+	raw_spin_unlock(&orig_lock->wait_lock);
+
+	/*
+	 * Need to get the task->pi_lock first, as that will be
+	 * used to synchronize with the owner of the lock if it
+	 * releases the lock.
+	 */
+again:
+	raw_spin_lock_irq(&task->pi_lock);
+	/* The lock could have been released. */
+	lock = waiter->lock;
+	if (!lock) {
+		raw_spin_unlock_irq(&task->pi_lock);
+		goto out;
+	}
+
+	if (!raw_spin_trylock(&lock->wait_lock)) {
+		/* ironic isn't this. */
+		raw_spin_unlock_irq(&task->pi_lock);
+		goto again;
+	}
+
+	waiter->lock = NULL;
+
+	/*
+	 * Having the lock->wait_lock will prevent the owner from
+	 * doing anything else.
+	 */
+	raw_spin_unlock_irq(&task->pi_lock);
+
+	top_waiter = rt_mutex_top_waiter(lock);
+	rt_mutex_dequeue(lock, waiter);
+
+	owner = rt_mutex_owner(lock);
+	if (owner && waiter == top_waiter) {
+		raw_spin_lock_irq(&owner->pi_lock);
+		rt_mutex_dequeue_pi(owner, waiter);
+		if (rt_mutex_has_waiters(lock)) {
+			top_waiter = rt_mutex_top_waiter(lock);
+			rt_mutex_enqueue_pi(owner, top_waiter);
+			__rt_mutex_adjust_prio(owner);
+		}
+		raw_spin_unlock_irq(&owner->pi_lock);
+	}
+
+	raw_spin_unlock(&lock->wait_lock);
+out:
+	raw_spin_lock(&orig_lock->wait_lock);
+
+	return true;
+}
+/*
+ * Called by cpu_chill() that is after a spin_trylock_or_boost().
+ * This will sleep if the lock is still held by the task that was boosted.
+ */
+void rt_mutex_wait_for_lock(struct task_struct *task)
+{
+	struct rt_mutex_waiter *waiter = &task->rt_waiter;
+	struct rt_mutex *lock;
+
+	if (!waiter->lock) {
+		cpu_relax();
+		return;
+	}
+
+	/* The pi_lock will prevent the owner from doing anything */
+	raw_spin_lock_irq(&task->pi_lock);
+	lock = waiter->lock;
+	if (!lock) {
+		raw_spin_unlock_irq(&task->pi_lock);
+		return;
+	}
+
+	task->saved_state = task->state;
+	/* We let anything wake this up. */
+	__set_current_state_no_track(TASK_INTERRUPTIBLE);
+
+	waiter->wake_up = true;
+	raw_spin_unlock_irq(&task->pi_lock);
+
+	if (waiter->lock)
+		schedule();
+
+again:
+	raw_spin_lock_irq(&task->pi_lock);
+	waiter->wake_up = false;
+
+	/* Make sure it still does not have the lock */
+	if (waiter->lock) {
+		struct rt_mutex_waiter *top_waiter = NULL;
+		struct task_struct *owner;
+
+		lock = waiter->lock;
+		if (!raw_spin_trylock(&lock->wait_lock)) {
+			raw_spin_unlock_irq(&task->pi_lock);
+			goto again;
+		}
+		
+		top_waiter = rt_mutex_top_waiter(lock);
+		rt_mutex_dequeue(lock, waiter);
+		waiter->lock = NULL;
+
+		owner = rt_mutex_owner(lock);
+		if (owner && waiter == top_waiter) {
+			raw_spin_unlock(&task->pi_lock);
+			raw_spin_lock(&owner->pi_lock);
+			rt_mutex_dequeue_pi(owner, waiter);
+			if (rt_mutex_has_waiters(lock)) {
+				top_waiter = rt_mutex_top_waiter(lock);
+				rt_mutex_enqueue_pi(owner, top_waiter);
+			}
+			raw_spin_unlock(&owner->pi_lock);
+			raw_spin_lock(&task->pi_lock);
+		}
+		raw_spin_unlock(&lock->wait_lock);
+	}
+		
+	__set_current_state_no_track(task->saved_state);
+	task->saved_state = TASK_RUNNING;
+	raw_spin_unlock_irq(&task->pi_lock);
+}
+
+#else
+static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
+{
+	return NULL;
+}
+static inline bool rt_mutex_wake_trylock_waiter(struct rt_mutex_waiter *waiter)
+{
+	return true;
+}
+static inline bool check_static_waiter(struct task_struct *task,
+				       struct rt_mutex *lock, bool ok)
+{
+	return false;
+}
+#endif
+
 /*
  * Calculate task priority from the waiter tree priority
  *
@@ -1081,7 +1333,7 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	/* Undo pi boosting.when necessary */
+
 	rt_mutex_adjust_prio(current);
 }
 
@@ -1148,6 +1400,16 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_trylock);
 
+int __lockfunc rt_spin_trylock_or_boost(spinlock_t *lock)
+{
+	int ret = rt_mutex_try_or_boost_lock(&lock->lock);
+
+	if (ret)
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(rt_spin_trylock_or_boost);
+
 int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 {
 	int ret;
@@ -1392,6 +1654,9 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
+	if (!rt_mutex_wake_trylock_waiter(waiter))
+		return;
+
 	/*
 	 * It's safe to dereference waiter as it cannot go away as
 	 * long as we hold lock->wait_lock. The waiter task needs to
@@ -1655,6 +1920,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	rt_mutex_init_waiter(&waiter, false);
 
+ try_again:
 	raw_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
@@ -1665,6 +1931,19 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		return 0;
 	}
 
+	/*
+	 * If the task boosted another task with trylock_or_boost
+	 * it can not block with that in use. The check_static_waiter()
+	 * will remove the boosting of the trylock if needed. But to
+	 * do so will require unlocking lock->wait_lock, and then
+	 * the state of the lock may change. If the wait_lock is
+	 * released, the lock is tried again.
+	 */
+	if (unlikely(check_static_waiter(current, lock, true))) {
+		raw_spin_unlock(&lock->wait_lock);
+		goto try_again;
+	}
+
 	set_current_state(state);
 
 	/* Setup the timer, when timeout != NULL */
@@ -1717,26 +1996,34 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 /*
  * Slow path try-lock function:
  */
-static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
+static inline int rt_mutex_slowtrylock(struct rt_mutex *lock, bool boost)
 {
+	struct task_struct *owner;
 	int ret;
 
 	/*
 	 * If the lock already has an owner we fail to get the lock.
 	 * This can be done without taking the @lock->wait_lock as
 	 * it is only being read, and this is a trylock anyway.
+	 *
+	 * Only do the short cut if we do not need to boost the task
+	 * if we fail to get the lock.
 	 */
-	if (rt_mutex_owner(lock))
+	if (!boost && rt_mutex_owner(lock))
 		return 0;
 
 	/*
-	 * The mutex has currently no owner. Lock the wait lock and
-	 * try to acquire the lock.
+	 * The mutex has currently no owner or we need to boost the task
+	 * if we fail to grab the lock. Lock the wait lock and try to
+	 * acquire the lock.
 	 */
 	raw_spin_lock(&lock->wait_lock);
 
 	ret = try_to_take_rt_mutex(lock, current, NULL);
 
+	if (!ret && boost)
+		owner = trylock_boost_owner(lock);
+
 	/*
 	 * try_to_take_rt_mutex() sets the lock waiters bit
 	 * unconditionally. Clean this up.
@@ -1745,6 +2032,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 
 	raw_spin_unlock(&lock->wait_lock);
 
+	if (!ret && boost && owner)
+		rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK,
+					   lock, NULL, NULL, NULL);
+
 	return ret;
 }
 
@@ -1852,13 +2143,14 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock))
+		     int (*slowfn)(struct rt_mutex *lock, bool boost),
+		     bool boost)
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 1;
 	}
-	return slowfn(lock);
+	return slowfn(lock, boost);
 }
 
 static inline void
@@ -1969,11 +2261,24 @@ EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
  */
 int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
-	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock, false);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 
 /**
+ * rt_mutex_try_or_boost_lock - try to lock a rt_mutex or boost the owner
+ *
+ * @lock:	the rt_mutex to be locked
+ *
+ * Returns 1 on success and 0 on contention
+ */
+int __sched rt_mutex_try_or_boost_lock(struct rt_mutex *lock)
+{
+	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock, true);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_try_or_boost_lock);
+
+/**
  * rt_mutex_unlock - unlock a rt_mutex
  *
  * @lock: the rt_mutex to be unlocked
@@ -2127,6 +2432,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	raw_spin_unlock_irq(&task->pi_lock);
 #endif
 
+	check_static_waiter(task, lock, false);
+
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
 				      RT_MUTEX_FULL_CHAINWALK);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 4d317e9a5d0f..338e7fa4bbfa 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -37,28 +37,6 @@ extern void schedule_rt_mutex_test(struct rt_mutex *lock);
 #endif
 
 /*
- * This is the control structure for tasks blocked on a rt_mutex,
- * which is allocated on the kernel stack on of the blocked task.
- *
- * @tree_entry:		pi node to enqueue into the mutex waiters tree
- * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
- * @task:		task reference to the blocked task
- */
-struct rt_mutex_waiter {
-	struct rb_node          tree_entry;
-	struct rb_node          pi_tree_entry;
-	struct task_struct	*task;
-	struct rt_mutex		*lock;
-	bool			savestate;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	unsigned long		ip;
-	struct pid		*deadlock_task_pid;
-	struct rt_mutex		*deadlock_lock;
-#endif
-	int prio;
-};
