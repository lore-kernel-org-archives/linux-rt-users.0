From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 1/3] locking: Add spin_try_or_boost_lock() infrastructure
Date: Thu, 03 Sep 2015 21:19:01 -0400
Message-ID: <20150904012118.201373918@goodmis.org>
References: <20150904011900.730816481@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-locking-Add-spin_try_or_boost_lock-infrastructure.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

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
have preempted the owner, and it can prevent the owne from making forward
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

The solution here is to add a new type of priority. All tasks are given a
new field in the task_struct called "trylock_prio" (only when PREEMPT_RT is
configured). This priority is initialize as MAX_PRIO. If a task needs to
grab locks in reverse order, instead of simply using spin_trylock(), it will
use the new primitive spin_try_or_boost_lock(). If the task does not get the
lock, and the lock has an owner, then that owner gets its "trylock_prio"
field set to the prio of the caller of spin_try_or_boost_lock() if it is
less than than that prio. The priority inheritance code is executed in case
that task is currently blocked on something else that may be preempted by
the original task. But unlike the normal priority inheritance code, the
original task is not part of the chain, as that could be detected as a false
deadlock. Instead, each step checks not only the priority of the task and
its highest waiter, but also this new "trylock_prio" field of the task. This
allows the task to be boosted to that priority as well.

Whenever a task releases a spinlock converted to an rtmutex, if its
"trylock_prio" is set to something other than MAX_PRIO, then it enters the
slow unlock path, resets the "trylock_prio" to MAX_PRIO and runs the
priority inheritance chain, where it loses its special priority.

It is possible that the owner releases a lock other than the one that
boosted its priority with the spin_try_or_boost_lock() call. This is fine,
because the owner would still make forward progress. If it loses its
priority, and the original task runs, it will loop again, and boost it
again, until eventually the owner releases the lock, letting the original
task to grab it in the reverse order.

Note, as FIFO tasks won't let the owner run if the current task is spinning,
it is still required that the original task calls cpu_chill() after calling
spin_try_or_boost_lock(). But this lets us change cpu_chill() from being a
simple msleep(1) (hoping that the owner will release the lock in that time
frame, and no other owner will take it), to a sched_yield(), where it will
allow the owner to run before it to make that forward progress.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/init_task.h   |   8 +++
 include/linux/rtmutex.h     |   1 +
 include/linux/sched.h       |  27 ++++++++++
 include/linux/spinlock.h    |   5 ++
 include/linux/spinlock_rt.h |  13 +++++
 kernel/locking/rtmutex.c    | 121 ++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 164 insertions(+), 11 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 4a77d39ff7dd..eb39f31837dd 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -189,6 +189,13 @@ extern struct task_group root_task_group;
 # define INIT_KASAN(tsk)
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+# define INIT_TRYLOCK_PRIO(tsk)						\
+	.trylock_prio	= MAX_PRIO,
+#else
+# define INIT_TRYLOCK_PRIO(tsk)
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -204,6 +211,7 @@ extern struct task_group root_task_group;
 	.normal_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
+	INIT_TRYLOCK_PRIO(tsk)						\
 	.nr_cpus_allowed= NR_CPUS,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
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
index 956658437527..e6a39360a182 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1357,6 +1357,33 @@ struct task_struct {
 
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
+	 * For these cases, a spin_try_or_boost_lock() must be used
+	 * on PREEMPT_RT. This will set the owner of the lock to the
+	 * prioirty of the caller of spin_try_or_boost_lock()
+	 * via this trylock_prio field (if the owner has a lower
+	 * priority than the caller). This priority is always reset
+	 * whenever any spinlock converted rtmutex is released.
+	 * This guarantees forward progress of the trylock spin.
+	 *
+	 * Callers of spin_try_or_boost_lock() must also call cpu_chill()
+	 * which on PREEMPT_RT is a sched_yield() that allows the
+	 * newly risen priority task to run ahead of the trylock spinner.
+	 */
+	int trylock_prio;
+#endif
 	const struct sched_class *sched_class;
 	struct sched_entity se;
 	struct sched_rt_entity rt;
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 28f4366fd495..b48bebec4302 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -330,6 +330,11 @@ static inline int spin_trylock(spinlock_t *lock)
 	return raw_spin_trylock(&lock->rlock);
 }
 
+static inline int spin_try_or_boost_lock(spinlock_t *lock)
+{
+	return raw_spin_trylock(&lock->rlock);
+}
+
 #define spin_lock_nested(lock, subclass)			\
 do {								\
 	raw_spin_lock_nested(spinlock_check(lock), subclass);	\
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f757096b230c..084816738d3e 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -26,6 +26,7 @@ extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock(spinlock_t *lock);
+extern int __lockfunc rt_spin_try_or_boost_lock(spinlock_t *lock);
 extern int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock);
 
 /*
@@ -53,6 +54,8 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 
 #define spin_do_trylock(lock)		__cond_lock(lock, rt_spin_trylock(lock))
 
+#define spin_do_try_or_boost_lock(lock) __cond_lock(lock, rt_spin_try_or_boost_lock(lock))
+
 #define spin_trylock(lock)			\
 ({						\
 	int __locked;				\
@@ -63,6 +66,16 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 	__locked;				\
 })
 
+#define spin_try_or_boost_lock(lock)			\
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
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2822aceb8dfb..2830c17dc3e4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -253,6 +253,65 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline int task_normal_prio(struct task_struct *task)
+{
+	return min(task->normal_prio, task->trylock_prio);
+}
+
+static inline int task_top_waiter_prio(struct task_struct *task)
+{
+	return min3(task_top_pi_waiter(task)->prio,
+		    task->normal_prio, task->trylock_prio);
+}
+
+static inline void clear_trylock_prio(struct task_struct *task)
+{
+	task->trylock_prio = MAX_PRIO;
+}
+
+static inline bool current_boosted(void)
+{
+	return current->trylock_prio < MAX_PRIO;
+}
+
+static void __rt_mutex_adjust_prio(struct task_struct *task);
+
+/* Must call rt_mutex_adjust_prio_chain() if an owner is returned */
+static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
+{
+	struct task_struct *owner;
+
+	owner = rt_mutex_owner(lock);
+	if (!owner)
+		return NULL;
+
+	/* Will be released by rt_mutex_adjust_prio_chain() */
+	get_task_struct(owner);
+
+	raw_spin_lock_irq(&owner->pi_lock);
+	if (owner->trylock_prio > current->prio) {
+		owner->trylock_prio = current->prio;
+		__rt_mutex_adjust_prio(owner);
+	}
+	raw_spin_unlock_irq(&owner->pi_lock);
+
+	return owner;
+}
+#else
+static inline int task_normal_prio(struct task_struct *task)
+{
+	return task->normal_prio;
+}
+static inline int task_top_waiter_prio(struct task_struct *task)
+{
+	return min(task_top_pi_waiter(task)->prio,
+		   task->normal_prio);
+}
+# define current_boosted()	0
+# define clear_trylock_prio(tsk)	do {} while (0)
+#endif
+
 /*
  * Calculate task priority from the waiter tree priority
  *
@@ -262,10 +321,9 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 int rt_mutex_getprio(struct task_struct *task)
 {
 	if (likely(!task_has_pi_waiters(task)))
-		return task->normal_prio;
+		return task_normal_prio(task);
 
-	return min(task_top_pi_waiter(task)->prio,
-		   task->normal_prio);
+	return task_top_waiter_prio(task);
 }
 
 struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
@@ -925,7 +983,7 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
 					   void  (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
+	if (likely(rt_mutex_cmpxchg(lock, current, NULL) && !current_boosted()))
 		rt_mutex_deadlock_account_unlock(current);
 	else
 		slowfn(lock);
@@ -1074,6 +1132,8 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		raw_spin_unlock(&lock->wait_lock);
+		if (current_boosted())
+			goto adjust;
 		return;
 	}
 
@@ -1081,6 +1141,9 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	raw_spin_unlock(&lock->wait_lock);
 
+adjust:
+	clear_trylock_prio(current);
+
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
 }
@@ -1148,6 +1211,16 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_trylock);
 
+int __lockfunc rt_spin_try_or_boost_lock(spinlock_t *lock)
+{
+	int ret = rt_mutex_try_or_boost_lock(&lock->lock);
+
+	if (ret)
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(rt_spin_try_or_boost_lock);
+
 int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 {
 	int ret;
@@ -1717,26 +1790,34 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
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
@@ -1745,6 +1826,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 
 	raw_spin_unlock(&lock->wait_lock);
 
+	if (!ret && boost && owner)
+		rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK,
+					   lock, NULL, NULL, NULL);
+
 	return ret;
 }
 
@@ -1852,13 +1937,14 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 
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
@@ -1969,11 +2055,24 @@ EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
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
-- 
2.4.6
