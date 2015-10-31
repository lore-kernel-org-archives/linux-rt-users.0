From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] v4.1.10-rt11
Date: Sat, 31 Oct 2015 16:24:42 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1510311618310.4032@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.1.10-rt11 patch set.

Changes since v4.1.10-rt11:

  Eric Dumazet (1):
      inet: fix potential deadlock in reqsk_queue_unlink()

  Josh Cartwright (1):
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

  Mathieu Desnoyers (1):
      latency_hist: Update sched_wakeup probe

  Peter Zijlstra (1):
      sched: Introduce the trace_sched_waking tracepoint

  Thomas Gleixner (2):
      softirq: Sanitize local_bh_[en|dis]able for RT
      v4.1.10-rt11

  Yang Shi (1):
      trace: Add missing tracer macros

Known issues:

  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.1.10-rt10 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.10-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.10-rt11

The RT patch against 4.1.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.10-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.10-rt11.tar.xz

Enjoy!

	tglx

---

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 8ca9389352f2..d3c0c02acc97 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -6,12 +6,34 @@
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 
-extern void local_bh_disable(void);
+extern void __local_bh_disable(void);
 extern void _local_bh_enable(void);
-extern void local_bh_enable(void);
-extern void local_bh_enable_ip(unsigned long ip);
-extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
-extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
+extern void __local_bh_enable(void);
+
+static inline void local_bh_disable(void)
+{
+	__local_bh_disable();
+}
+
+static inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+{
+	__local_bh_disable();
+}
+
+static inline void local_bh_enable(void)
+{
+	__local_bh_enable();
+}
+
+static inline void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+{
+	__local_bh_enable();
+}
+
+static inline void local_bh_enable_ip(unsigned long ip)
+{
+	__local_bh_enable();
+}
 
 #else
 
diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 6122e4286177..37f6eb8c9dc2 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
@@ -33,6 +34,7 @@ TRACE_EVENT(preemptirqsoff_hist,
 
 #ifndef CONFIG_MISSED_TIMER_OFFSETS_HIST
 #define trace_hrtimer_interrupt(a, b, c, d)
+#define trace_hrtimer_interrupt_rcuidle(a, b, c, d)
 #else
 TRACE_EVENT(hrtimer_interrupt,
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 30fedaf3e56a..3b63828390a6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -55,9 +55,9 @@ TRACE_EVENT(sched_kthread_stop_ret,
  */
 DECLARE_EVENT_CLASS(sched_wakeup_template,
 
-	TP_PROTO(struct task_struct *p, int success),
+	TP_PROTO(struct task_struct *p),
 
-	TP_ARGS(__perf_task(p), success),
+	TP_ARGS(__perf_task(p)),
 
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
 
+/*
+ * Tracepoint called when waking a task; this tracepoint is guaranteed to be
+ * called from the waking context.
+ */
+DEFINE_EVENT(sched_wakeup_template, sched_waking,
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
+
+/*
+ * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
+ * It it not always called from the waking context.
+ */
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 799b75b273a2..b8b53df3ecf1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1558,9 +1558,9 @@ static void
 ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	check_preempt_curr(rq, p, wake_flags);
-	trace_sched_wakeup(p, true);
-
 	p->state = TASK_RUNNING;
+	trace_sched_wakeup(p);
+
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
 		p->sched_class->task_woken(rq, p);
@@ -1784,6 +1784,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(wake_flags & WF_LOCK_SLEEPER))
 		p->saved_state = TASK_RUNNING;
 
+	trace_sched_waking(p);
+
 	success = 1; /* we're going to change ->state */
 	cpu = task_cpu(p);
 
@@ -2188,7 +2190,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = TASK_ON_RQ_QUEUED;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 49baf81848d6..0fd93311536f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -554,26 +554,14 @@ static void do_current_softirqs(void)
 	}
 }
 
-static void __local_bh_disable(void)
+void __local_bh_disable(void)
 {
 	if (++current->softirq_nestcnt == 1)
 		migrate_disable();
 }
+EXPORT_SYMBOL(__local_bh_disable);
 
-void local_bh_disable(void)
-{
-	__local_bh_disable();
-}
-EXPORT_SYMBOL(local_bh_disable);
-
-void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
-{
-	__local_bh_disable();
-	if (cnt & PREEMPT_CHECK_OFFSET)
-		preempt_disable();
-}
-
-static void __local_bh_enable(void)
+void __local_bh_enable(void)
 {
 	if (WARN_ON(current->softirq_nestcnt == 0))
 		return;
@@ -586,25 +574,7 @@ static void __local_bh_enable(void)
 	if (--current->softirq_nestcnt == 0)
 		migrate_enable();
 }
-
-void local_bh_enable(void)
-{
-	__local_bh_enable();
-}
-EXPORT_SYMBOL(local_bh_enable);
-
-extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
-{
-	__local_bh_enable();
-	if (cnt & PREEMPT_CHECK_OFFSET)
-		preempt_enable();
-}
-
-void local_bh_enable_ip(unsigned long ip)
-{
-	local_bh_enable();
-}
-EXPORT_SYMBOL(local_bh_enable_ip);
+EXPORT_SYMBOL(__local_bh_enable);
 
 void _local_bh_enable(void)
 {
diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
index 66a69eb5329c..b6c1d14b71c4 100644
--- a/kernel/trace/latency_hist.c
+++ b/kernel/trace/latency_hist.c
@@ -115,7 +115,7 @@ static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
 static char *wakeup_latency_hist_dir = "wakeup";
 static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
 static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p, int success);
+	struct task_struct *p);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
 	struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
@@ -869,7 +869,7 @@ static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
 }
 
 static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p, int success)
+	struct task_struct *p)
 {
 	unsigned long flags;
 	struct task_struct *curr = current;
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 419ca37e72c9..f270088e9929 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -26,7 +26,7 @@ probe_sched_switch(void *ignore, struct task_struct *prev, struct task_struct *n
 }
 
 static void
-probe_sched_wakeup(void *ignore, struct task_struct *wakee, int success)
+probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 {
 	if (unlikely(!sched_ref))
 		return;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index d6e1003724e9..79a2a5f7fc82 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -514,7 +514,7 @@ static void wakeup_reset(struct trace_array *tr)
 }
 
 static void
-probe_wakeup(void *ignore, struct task_struct *p, int success)
+probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu = smp_processor_id();
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaa..05c35cb58077 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/core/dev.c b/net/core/dev.c
index f8c23dee5ae9..16fbef81024d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6969,7 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b27fc401c6a9..e664706b350c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -584,7 +584,7 @@ static bool reqsk_queue_unlink(struct request_sock_queue *queue,
 	}
 
 	spin_unlock(&queue->syn_wait_lock);
-	if (del_timer_sync(&req->rsk_timer))
+	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
 		reqsk_put(req);
 	return found;
 }
