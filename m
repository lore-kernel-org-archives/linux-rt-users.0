From: Mike Galbraith <bitbucket@online.de>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Sat, 23 Feb 2013 09:25:35 +0100
Message-ID: <1361607935.5729.8.camel@marge.simpson.net>
References: <1361551010.32441.50.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54119 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3BWIZr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Feb 2013 03:25:47 -0500
In-Reply-To: <1361551010.32441.50.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With some old refuse hauled away if anybody wants to play with it.

I can't find anything that it breaks, fwtw. 

---
 include/linux/sched.h   |   27 +++++++++++++++++++++++++--
 kernel/rtmutex.c        |   44 +++++++++++++++++++++++++++++++++++++++-----
 kernel/rtmutex_common.h |   34 +++++++++++++++++++++++++++++++---
 kernel/sched.c          |   32 +++++++++++++++++++++++++++++---
 kernel/sched_fair.c     |    4 ++++
 kernel/sched_rt.c       |    3 +++
 kernel/sys.c            |    1 +
 kernel/sysctl.c         |   11 +++++++++++
 8 files changed, 143 insertions(+), 13 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2146,12 +2146,35 @@ extern unsigned int sysctl_sched_cfs_ban
 #endif
 
 #ifdef CONFIG_RT_MUTEXES
-extern void task_setprio(struct task_struct *p, int prio);
+#ifdef CONFIG_PREEMPT_RT_FULL
+extern unsigned int sysctl_sched_rt_spin_yield;
+
+static inline bool rt_spin_yield_enabled(void)
+{
+	return sysctl_sched_rt_spin_yield;
+}
+
+static inline void rt_spin_yield_disable(void)
+{
+	sysctl_sched_rt_spin_yield = 0;
+}
+#else
+static inline bool rt_spin_yield_enabled(void)
+{
+	return 0;
+}
+static inline void rt_spin_yield_disable(void) { }
+#endif
+extern void task_setprio(struct task_struct *p, int prio, int requeue);
 extern int rt_mutex_getprio(struct task_struct *p);
 extern int rt_mutex_check_prio(struct task_struct *task, int newprio);
 static inline void rt_mutex_setprio(struct task_struct *p, int prio)
 {
-	task_setprio(p, prio);
+	task_setprio(p, prio, 0);
+}
+static inline void rt_mutex_requeue(struct task_struct *p, int prio)
+{
+	task_setprio(p, prio, 1);
 }
 extern void rt_mutex_adjust_pi(struct task_struct *p);
 static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -702,8 +702,8 @@ static int adaptive_wait(struct rt_mutex
 		 * checking the above to be valid.
 		 */
 		barrier();
-		if (!owner->on_cpu) {
-			res = 1;
+		if (!owner || !owner->on_cpu) {
+			res = owner && !owner->on_cpu;
 			break;
 		}
 		cpu_relax();
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
+		if (wait || adaptive_wait(lock, lock_owner))
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
+		rt_mutex_requeue(next, next->prio);
+		pi_unlock(&next->pi_lock);
+	}
+
 	wakeup_next_waiter(lock);
 
 	raw_spin_unlock(&lock->wait_lock);
--- a/kernel/rtmutex_common.h
+++ b/kernel/rtmutex_common.h
@@ -32,9 +32,37 @@ extern void schedule_rt_mutex_test(struc
 		schedule_rt_mutex_test(_lock);			\
   } while (0)
 
-#else
-# define schedule_rt_mutex(_lock)			schedule()
-#endif
+#ifdef CONFIG_PREEMPT_RT_FULL
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
+#define schedule_rt_spinlock(_lock, _spin) schedule_rt_mutex(_lock)
+#endif /* CONFIG_PREEMPT_RT_FULL */
+
+#else /* !CONFIG_RT_MUTEX_TESTER */
+
+#define schedule_rt_mutex(_lock)			schedule()
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define schedule_rt_spinlock(_lock, _spin)			\
+  do {								\
+	if (!_spin)						\
+		schedule();					\
+	else							\
+		yield();					\
+  } while (0)
+#else /* !CONFIG_PREEMPT_RT_FULL */
+#define schedule_rt_spinlock(_lock, _spin) schedule_rt_mutex(_lock)
+#endif /* CONFIG_PREEMPT_RT_FULL */
+#endif /* CONFIG_RT_MUTEX_TESTER */
 
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -943,6 +943,12 @@ late_initcall(sched_init_debug);
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 #else
 const_debug unsigned int sysctl_sched_nr_migrate = 8;
+
+/*
+ * rt spinlock waiters yield() if necessary vs blocking.
+ * SCHED_OTHER must block, but spin if they can do so.
+ */
+unsigned int sysctl_sched_rt_spin_yield __read_mostly;
 #endif
 
 /*
@@ -5292,6 +5298,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
  * task_setprio - set the current priority of a task
  * @p: task
  * @prio: prio value (kernel-internal form)
+ * @requeue: requeue an rt_spin_lock_slowlock() top waiter and preempt
  *
  * This function changes the 'effective' priority of a task. It does
  * not touch ->normal_prio like __setscheduler().
@@ -5299,7 +5306,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
  * Used by the rt_mutex code to implement priority inheritance
  * logic. Call site only calls if the priority of the task changed.
  */
-void task_setprio(struct task_struct *p, int prio)
+void task_setprio(struct task_struct *p, int prio, int requeue)
 {
 	int oldprio, on_rq, running;
 	struct rq *rq;
@@ -5332,6 +5339,8 @@ void task_setprio(struct task_struct *p,
 	prev_class = p->sched_class;
 	on_rq = p->on_rq;
 	running = task_current(rq, p);
+	if (requeue && (running || !on_rq || !rt_prio(oldprio)))
+		goto out_unlock;
 	if (on_rq)
 		dequeue_task(rq, p, 0);
 	if (running)
@@ -5346,8 +5355,25 @@ void task_setprio(struct task_struct *p,
 
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
@@ -2510,6 +2510,10 @@ static void check_preempt_wakeup(struct
 	if (unlikely(se == pse))
 		return;
 
+	/* FIXME: might be spinning on a lock, good enough to play with */
+	if (rt_spin_yield_enabled() && curr->migrate_disable)
+		return;
+
 	/*
 	 * This is possible from callers such as pull_task(), in which we
 	 * unconditionally check_prempt_curr() after an enqueue (which may have
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -991,6 +991,9 @@ enqueue_task_rt(struct rq *rq, struct ta
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	if (rt_spin_yield_enabled() && (flags & WF_LOCK_SLEEPER))
+		flags |= ENQUEUE_HEAD;
+
 	enqueue_rt_entity(rt_se, flags & ENQUEUE_HEAD);
 
 	if (!task_current(rq, p) && p->rt.nr_cpus_allowed > 1)
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -316,6 +316,7 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
+	rt_spin_yield_disable();
 	usermodehelper_disable();
 	device_shutdown();
 	syscore_shutdown();
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


