From: Mike Galbraith <bitbucket@online.de>
Subject: rt: rtmutex experiment doubled tbench throughput
Date: Fri, 22 Feb 2013 17:36:50 +0100
Message-ID: <1361551010.32441.50.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60516 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab3BVQhD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Feb 2013 11:37:03 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

A user reported surprise at seeing a low priority rt task awakened in
the same semop as a high priority task run before the high priority task
could finish what it was supposed to do, and put itself to sleep.  The
reason for that happening is that it, and a few of its brothers (highly
synchronized task schedulers) enter semop to diddle the same array at
the same time, meet at spinlock (rtmutex) and block.

Now you could say "Waking task foo and depending on it's lower than task
bar priority to keep it off the CPU is your bad if you do so without a
no-block guarantee in hand for everything task bar does." which I did,
that and "The semop syscall is not atomic per POSIX, it's the array
operations that are atomic.  Blocking on a contended lock is fine".

Anyway, I looked at rtmutex.c and started pondering, wondering if I
could un-surprise the user without breaking the world, and maybe even
make non-rt stuff perform a little better.

Numerous deadlocks and cool explosions later...

This seems to work, no harm to 60 core jitter testcase detected, and it
doubled tbench throughput.  But be advised, your breakfast may emigrate,
or a POSIX swat team may kick in your door if you even _look_ at this. 

64 core DL980G2, 3.0.61-rt85

vogelweide:/:[0]# tbench.sh 128 10
waiting for connections
dbench version 3.04 - Copyright Andrew Tridgell 1999-2004

Running for 10 seconds with load '/usr/share/dbench/client.txt' and minimum warmup 2 secs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^128 clients started
 128      5881  6239.48 MB/sec  warmup   1 sec   
 128     17978  4169.33 MB/sec  execute   1 sec   
 128     24051  4173.54 MB/sec  execute   2 sec   
 128     30131  4185.35 MB/sec  execute   3 sec   
 128     36145  4173.59 MB/sec  execute   4 sec   
 128     42233  4182.69 MB/sec  execute   5 sec   
 128     48293  4181.18 MB/sec  execute   6 sec   
 128     54407  4185.10 MB/sec  execute   7 sec   
 128     60445  4183.09 MB/sec  execute   8 sec   
 128     66482  4179.41 MB/sec  execute   9 sec   
 128     72543  4179.37 MB/sec  cleanup  10 sec   
 128     72543  4174.07 MB/sec  cleanup  10 sec   

Throughput 4179.49 MB/sec 128 procs
924536 packets/sec
/root/bin/tbench.sh: line 33: 11292 Killed                  tbench_srv


vogelweide:/:[0]# echo 1 >  /proc/sys/kernel/sched_rt_spin_yield
vogelweide:/:[0]# tbench.sh 128 10
waiting for connections
dbench version 3.04 - Copyright Andrew Tridgell 1999-2004

Running for 10 seconds with load '/usr/share/dbench/client.txt' and minimum warmup 2 secs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^128 clients started
 128     14360  12090.05 MB/sec  warmup   1 sec   
 128     42573  9740.67 MB/sec  execute   1 sec   
 128     56661  9736.85 MB/sec  execute   2 sec   
 128     70752  9723.79 MB/sec  execute   3 sec   
 128     84850  9724.82 MB/sec  execute   4 sec   
 128     98936  9720.49 MB/sec  execute   5 sec   
 128    113021  9721.15 MB/sec  execute   6 sec   
 128    127111  9723.26 MB/sec  execute   7 sec   
 128    141203  9722.81 MB/sec  execute   8 sec   
 128    155300  9722.90 MB/sec  execute   9 sec   
 128    169392  9727.48 MB/sec  cleanup  10 sec   
 128    169392  9712.52 MB/sec  cleanup  10 sec   

Throughput 9727.56 MB/sec 128 procs
2150132 packets/sec
/root/bin/tbench.sh: line 34: 11568 Killed                  tbench_srv

---
 include/linux/sched.h   |    7 +++++--
 kernel/rtmutex.c        |   48 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/rtmutex_common.h |   42 +++++++++++++++++++++++++++++++++++++++---
 kernel/sched.c          |   31 ++++++++++++++++++++++++++++---
 kernel/sched_fair.c     |    5 +++++
 kernel/sched_rt.c       |    3 +++
 kernel/sysctl.c         |   11 +++++++++++
 7 files changed, 132 insertions(+), 15 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2083,6 +2083,9 @@ extern unsigned int sysctl_sched_latency
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern unsigned int sysctl_sched_child_runs_first;
+#ifdef CONFIG_PREEMPT_RT_FULL
+extern unsigned int sysctl_sched_rt_spin_yield;
+#endif
 
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
@@ -2146,12 +2149,12 @@ extern unsigned int sysctl_sched_cfs_ban
 #endif
 
 #ifdef CONFIG_RT_MUTEXES
-extern void task_setprio(struct task_struct *p, int prio);
+extern void task_setprio(struct task_struct *p, int prio, int yield);
 extern int rt_mutex_getprio(struct task_struct *p);
 extern int rt_mutex_check_prio(struct task_struct *task, int newprio);
 static inline void rt_mutex_setprio(struct task_struct *p, int prio)
 {
-	task_setprio(p, prio);
+	task_setprio(p, prio, 0);
 }
 extern void rt_mutex_adjust_pi(struct task_struct *p);
 static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -689,7 +689,7 @@ static inline void rt_spin_lock_fastunlo
  * on rcu_read_lock() and the check against the lock owner.
  */
 static int adaptive_wait(struct rt_mutex *lock,
-			 struct task_struct *owner)
+			 struct task_struct *owner, int spin)
 {
 	int res = 0;
 
@@ -702,8 +702,8 @@ static int adaptive_wait(struct rt_mutex
 		 * checking the above to be valid.
 		 */
 		barrier();
-		if (!owner->on_cpu) {
-			res = 1;
+		if (!owner || !owner->on_cpu) {
+			res = !spin;
 			break;
 		}
 		cpu_relax();
@@ -713,7 +713,7 @@ static int adaptive_wait(struct rt_mutex
 }
 #else
 static int adaptive_wait(struct rt_mutex *lock,
-			 struct task_struct *orig_owner)
+			 struct task_struct *orig_owner, int spin)
 {
 	return 1;
 }
@@ -733,7 +733,7 @@ static void  noinline __sched rt_spin_lo
 {
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
-	int ret;
+	int ret, wait, rt_spin = 0, other_spin = 0, cpu;
 
 	rt_mutex_init_waiter(&waiter, true);
 
@@ -761,6 +761,17 @@ static void  noinline __sched rt_spin_lo
 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
 	BUG_ON(ret);
 
+	/* basic spin/yield sanity checks */
+	if (rt_spin_yield_enabled()) {
+		rt_spin = !self->saved_state;
+		/* Here there be dragons */
+		rt_spin &= !(self->flags & PF_EXITING);
+		other_spin = rt_spin;
+		rt_spin &= rt_task(self);
+		other_spin &= !rt_spin;
+	}
+	cpu = raw_smp_processor_id();
+
 	for (;;) {
 		/* Try to acquire the lock again. */
 		if (__try_to_take_rt_mutex(lock, self, &waiter, STEAL_LATERAL))
@@ -769,12 +780,25 @@ static void  noinline __sched rt_spin_lo
 		top_waiter = rt_mutex_top_waiter(lock);
 		lock_owner = rt_mutex_owner(lock);
 
+		if (rt_spin)
+			wait = 1;
+		else
+			wait = top_waiter != &waiter;
+
+		/* SCHED_OTHER can laterally steal, let them try */
+		if (other_spin) {
+			wait &= task_cpu(top_waiter->task) == cpu;
+			wait |= top_waiter->task->prio < self->prio;
+			wait |= lock_owner && !lock_owner->on_cpu;
+			wait |= lock_owner && !lock_owner->prio < self->prio;
+		}
+
 		raw_spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
-			schedule_rt_mutex(lock);
+		if (wait || adaptive_wait(lock, lock_owner, rt_spin))
+			schedule_rt_spinlock(lock, rt_spin);
 
 		raw_spin_lock(&lock->wait_lock);
 
@@ -826,6 +850,16 @@ static void  noinline __sched rt_spin_lo
 		return;
 	}
 
+	if (rt_spin_yield_enabled() && rt_task(current)) {
+		struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
+		struct task_struct *next = top_waiter->task;
+
+		/* Move next in line to head of its queue */
+		pi_lock(&next->pi_lock);
+		task_setprio(next, next->prio, 1);
+		pi_unlock(&next->pi_lock);
+	}
+
 	wakeup_next_waiter(lock);
 
 	raw_spin_unlock(&lock->wait_lock);
--- a/kernel/rtmutex_common.h
+++ b/kernel/rtmutex_common.h
@@ -32,9 +32,45 @@ extern void schedule_rt_mutex_test(struc
 		schedule_rt_mutex_test(_lock);			\
   } while (0)
 
-#else
-# define schedule_rt_mutex(_lock)			schedule()
-#endif
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define rt_spin_yield_enabled()					\
+	(sysctl_sched_rt_spin_yield && system_state == SYSTEM_RUNNING)
+
+#define schedule_rt_spinlock(_lock, _spin)			\
+  do {								\
+	if (!(current->flags & PF_MUTEX_TESTER)) {		\
+		if (!_spin)					\
+			schedule();				\
+		else						\
+			yield();				\
+	} else							\
+		schedule_rt_mutex_test(_lock);			\
+  } while (0)
+#else /* !CONFIG_PREEMPT_RT_FULL */
+#define rt_spin_yield_enabled()	(0)
+#define schedule_rt_spinlock(_lock, _spin) schedule_rt_mutex(_lock)
+#endif /* CONFIG_PREEMPT_RT_FULL */
+
+#else /* !CONFIG_RT_MUTEX_TESTER */
+
+#define schedule_rt_mutex(_lock)			schedule()
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define rt_spin_yield_enabled()					\
+	(sysctl_sched_rt_spin_yield && system_state == SYSTEM_RUNNING)
+
+#define schedule_rt_spinlock(_lock, _spin)			\
+  do {								\
+	if (!_spin)						\
+		schedule();					\
+	else							\
+		yield();					\
+  } while (0)
+#else /* !CONFIG_PREEMPT_RT_FULL */
+#define rt_spin_yield_enabled()	(0)
+#define schedule_rt_spinlock(_lock, _spin) schedule_rt_mutex(_lock)
+#endif /* CONFIG_PREEMPT_RT_FULL */
+#endif /* CONFIG_RT_MUTEX_TESTER */
 
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -943,6 +943,11 @@ late_initcall(sched_init_debug);
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 #else
 const_debug unsigned int sysctl_sched_nr_migrate = 8;
+
+/*
+ * rt spinlock waiters spin and yield() if necessary vs blocking
+ */
+unsigned int sysctl_sched_rt_spin_yield __read_mostly;
 #endif
 
 /*
@@ -5292,6 +5297,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
  * task_setprio - set the current priority of a task
  * @p: task
  * @prio: prio value (kernel-internal form)
+ * @requeue: requeue an rt_spin_lock_slowlock() top waiter and preempt
  *
  * This function changes the 'effective' priority of a task. It does
  * not touch ->normal_prio like __setscheduler().
@@ -5299,7 +5305,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
  * Used by the rt_mutex code to implement priority inheritance
  * logic. Call site only calls if the priority of the task changed.
  */
-void task_setprio(struct task_struct *p, int prio)
+void task_setprio(struct task_struct *p, int prio, int requeue)
 {
 	int oldprio, on_rq, running;
 	struct rq *rq;
@@ -5332,6 +5338,8 @@ void task_setprio(struct task_struct *p,
 	prev_class = p->sched_class;
 	on_rq = p->on_rq;
 	running = task_current(rq, p);
+	if (requeue && (running || !on_rq || !rt_prio(oldprio)))
+		goto out_unlock;
 	if (on_rq)
 		dequeue_task(rq, p, 0);
 	if (running)
@@ -5346,8 +5354,25 @@ void task_setprio(struct task_struct *p,
 
 	if (running)
 		p->sched_class->set_curr_task(rq);
-	if (on_rq)
-		enqueue_task(rq, p, oldprio < prio ? ENQUEUE_HEAD : 0);
+	if (on_rq) {
+		if (!sysctl_sched_rt_spin_yield) {
+			enqueue_task(rq, p, oldprio < prio ? ENQUEUE_HEAD : 0);
+		} else {
+			enqueue_task(rq, p, ENQUEUE_HEAD);
+
+			/*
+			 * If we're requeueing a spinlock waiter, preempt any
+			 * peer in the way, waiter involuntarily blocked, so
+			 * has the right to use this CPU before its peers.
+			 */
+			requeue &= p->prio <= rq->curr->prio;
+			requeue &= rq->curr->state == TASK_RUNNING;
+			requeue &= rq->curr != current;
+
+			if (requeue)
+				resched_task(rq->curr);
+		}
+	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
--- a/kernel/sched_fair.c
+++ b/kernel/sched_fair.c
@@ -2510,6 +2510,11 @@ static void check_preempt_wakeup(struct
 	if (unlikely(se == pse))
 		return;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (sysctl_sched_rt_spin_yield && curr->migrate_disable)
+		return;
+#endif
+
 	/*
 	 * This is possible from callers such as pull_task(), in which we
 	 * unconditionally check_prempt_curr() after an enqueue (which may have
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -991,6 +991,9 @@ enqueue_task_rt(struct rq *rq, struct ta
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	if (sysctl_sched_rt_spin_yield && (flags & WF_LOCK_SLEEPER))
+		flags |= ENQUEUE_HEAD;
+
 	enqueue_rt_entity(rt_se, flags & ENQUEUE_HEAD);
 
 	if (!task_current(rq, p) && p->rt.nr_cpus_allowed > 1)
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,6 +368,17 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
 	},
+#ifdef CONFIG_PREEMPT_RT_FULL
+	{
+		.procname	= "sched_rt_spin_yield",
+		.data		= &sysctl_sched_rt_spin_yield,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 	{
 		.procname	= "sched_compat_yield",
 		.data		= &sysctl_sched_compat_yield,



