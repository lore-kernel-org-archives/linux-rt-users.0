From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.110-rt139
Date: Mon, 29 Feb 2016 12:07:05 -0500
Message-ID: <20160229120705.3d81b96d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.4.110-rt139 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.4-rt
  Head SHA1: 86684e777ddf6ec1c9e8c775fa8360c414d57232


Or to build 3.4.110-rt139 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.110.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.110-rt139.patch.xz



You can also build from 3.4.110-rt138 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.110-rt138-rt139.patch.xz



Enjoy,

-- Steve


Changes from v3.4.110-rt138:

---

Josh Cartwright (1):
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

Peter Zijlstra (1):
      sched: Introduce the trace_sched_waking tracepoint

Sebastian Andrzej Siewior (1):
      dump stack: don't disable preemption during trace

Steven Rostedt (Red Hat) (2):
      rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum
      Linux 3.4.110-rt139

Thomas Gleixner (1):
      rtmutex: Handle non enqueued waiters gracefully

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/x86/kernel/dumpstack_64.c    |  8 ++++----
 include/trace/events/sched.h      | 30 +++++++++++++++++++++---------
 kernel/rtmutex.c                  |  6 +++---
 kernel/sched/core.c               |  7 +++++--
 kernel/trace/trace_sched_switch.c |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 localversion-rt                   |  2 +-
 net/core/dev.c                    |  2 +-
 8 files changed, 37 insertions(+), 22 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index e8206060a0a8..bebc49d03531 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -114,7 +114,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	unsigned long *irq_stack_end =
 		(unsigned long *)per_cpu(irq_stack_ptr, cpu);
 	unsigned used = 0;
@@ -191,7 +191,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	 * This handles the process stack:
 	 */
 	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
@@ -205,7 +205,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int cpu;
 	int i;
 
-	preempt_disable();
+	migrate_disable();
 	cpu = smp_processor_id();
 
 	irq_stack_end	= (unsigned long *)(per_cpu(irq_stack_ptr, cpu));
@@ -238,7 +238,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		printk(KERN_CONT " %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	printk(KERN_CONT "\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index ea7a2035456d..0a91a095e3c9 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -55,9 +55,9 @@ TRACE_EVENT(sched_kthread_stop_ret,
  */
 DECLARE_EVENT_CLASS(sched_wakeup_template,
 
-	TP_PROTO(struct task_struct *p, int success),
+	TP_PROTO(struct task_struct *p),
 
-	TP_ARGS(p, success),
+	TP_ARGS(p),
 
 	TP_STRUCT__entry(
 		__array(	char,	comm,	TASK_COMM_LEN	)
@@ -71,25 +71,37 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio;
-		__entry->success	= success;
+		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d success=%d target_cpu=%03d",
+	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
 		  __entry->comm, __entry->pid, __entry->prio,
-		  __entry->success, __entry->target_cpu)
+		  __entry->target_cpu)
 );
 
+ /*
+  * Tracepoint called when waking a task; this tracepoint is guaranteed to be
+  * called from the waking context.
+  */
+DEFINE_EVENT(sched_wakeup_template, sched_waking,
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
+
+ /*
+  * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
+  * It it not always called from the waking context.
+  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 /*
  * Tracepoint for waking up a new task:
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(struct task_struct *p)
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 4cc273b85beb..c2d0f9c8039f 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1163,7 +1163,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
@@ -1633,7 +1633,7 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			enum rtmutex_chainwalk chwalk,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock))
+				      enum rtmutex_chainwalk chwalk))
 {
 	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
 	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
@@ -1911,7 +1911,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0916d418dabd..cc4df0131023 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1412,10 +1412,11 @@ static void ttwu_activate(struct rq *rq, struct task_struct *p, int en_flags)
 static void
 ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	trace_sched_wakeup(p, true);
 	check_preempt_curr(rq, p, wake_flags);
 
 	p->state = TASK_RUNNING;
+	trace_sched_wakeup(p);
+
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
 		p->sched_class->task_woken(rq, p);
@@ -1608,6 +1609,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(wake_flags & WF_LOCK_SLEEPER))
 		p->saved_state = TASK_RUNNING;
 
+	trace_sched_waking(p);
+
 	success = 1; /* we're going to change ->state */
 	cpu = task_cpu(p);
 
@@ -1827,7 +1830,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = 1;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 7e62c0a18456..5982146ee863 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -108,7 +108,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 }
 
 static void
-probe_sched_wakeup(void *ignore, struct task_struct *wakee, int success)
+probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 {
 	struct trace_array_cpu *data;
 	unsigned long flags;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 9eadedc9b4a8..60160801b8e8 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -414,7 +414,7 @@ static void wakeup_reset(struct trace_array *tr)
 }
 
 static void
-probe_wakeup(void *ignore, struct task_struct *p, int success)
+probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu = smp_processor_id();
diff --git a/localversion-rt b/localversion-rt
index 9f63718d5731..e0b93414dc30 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt138
+-rt139
diff --git a/net/core/dev.c b/net/core/dev.c
index 46f960a4c83b..4dbd27b16d1f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6081,7 +6081,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
