From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.110-rt140
Date: Mon, 7 Mar 2016 15:54:13 -0500
Message-ID: <20160307155413.2b19b97c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:51297 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753812AbcCGUyR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 15:54:17 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.4.110-rt140 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.4-rt
  Head SHA1: 644c33135750aabfc5af32719fe700aa3ed015c8


Or to build 3.4.110-rt140 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.110.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.110-rt140.patch.xz



You can also build from 3.4.110-rt139 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.110-rt139-rt140.patch.xz



Enjoy,

-- Steve


Changes from v3.4.110-rt139:

---

Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Mike Galbraith (1):
      tracing: Fix probe_wakeup_latency_hist_start() prototype

Sebastian Andrzej Siewior (4):
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 3.4.110-rt140

Yang Shi (1):
      trace: Use rcuidle version for preemptoff_hist trace point

----
 arch/Kconfig                 |  1 +
 include/linux/ftrace.h       | 12 ++++++++++++
 include/linux/sched.h        |  2 --
 include/trace/events/hist.h  |  1 +
 kernel/rcutorture.c          |  7 +++++++
 kernel/sched/core.c          | 18 ++++--------------
 kernel/softirq.c             |  6 +++---
 kernel/trace/latency_hist.c  |  4 ++--
 kernel/trace/trace_irqsoff.c |  8 ++++----
 localversion-rt              |  2 +-
 10 files changed, 35 insertions(+), 26 deletions(-)
---------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 417ff4c6fc14..7b57cdc7b9b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -50,6 +50,7 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
+       depends on (!INTERRUPT_OFF_HIST && !PREEMPT_OFF_HIST && !WAKEUP_LATENCY_HIST && !MISSED_TIMER_OFFSETS_HIST)
        help
          This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index bfbcd439e2c6..93bce698fb86 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -476,6 +476,18 @@ static inline void __ftrace_enabled_restore(int enabled)
 # endif
 #endif /* ifndef HAVE_ARCH_CALLER_ADDR */
 
+static inline unsigned long get_lock_parent_ip(void)
+{
+	unsigned long addr = CALLER_ADDR0;
+
+	if (!in_lock_functions(addr))
+		return addr;
+	addr = CALLER_ADDR1;
+	if (!in_lock_functions(addr))
+		return addr;
+	return CALLER_ADDR2;
+}
+
 #ifdef CONFIG_IRQSOFF_TRACER
   extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
   extern void time_hardirqs_off(unsigned long a0, unsigned long a1);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index daf469059630..029575fb9bc8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -148,8 +148,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 struct seq_file;
 struct cfs_rq;
 struct task_group;
diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 28646db2c775..47332b93e03d 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a,b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index a89b381a8c6e..8de00304751b 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -485,6 +485,7 @@ static struct rcu_torture_ops rcu_expedited_ops = {
 	.name		= "rcu_expedited"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -558,6 +559,12 @@ static struct rcu_torture_ops rcu_bh_expedited_ops = {
 	.name		= "rcu_bh_expedited"
 };
 
+#else
+static struct rcu_torture_ops rcu_bh_ops = {
+	.ttype		= INVALID_RCU_FLAVOR,
+};
+#endif
+
 /*
  * Definitions for srcu torture testing.
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cc4df0131023..ec9bfbef9873 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3241,16 +3241,6 @@ void scheduler_tick(void)
 #endif
 }
 
-notrace unsigned long get_parent_ip(unsigned long addr)
-{
-	if (in_lock_functions(addr)) {
-		addr = CALLER_ADDR2;
-		if (in_lock_functions(addr))
-			addr = CALLER_ADDR3;
-	}
-	return addr;
-}
-
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_PREEMPT_TRACER))
 
@@ -3272,7 +3262,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -3298,7 +3288,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
@@ -3389,7 +3379,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -3420,7 +3410,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index ecf0ab0f7b4d..2cdd5102331b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -207,7 +207,7 @@ static void __local_bh_disable(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 #else /* !CONFIG_TRACE_IRQFLAGS */
 static inline void __local_bh_disable(unsigned long ip, unsigned int cnt)
@@ -561,10 +561,10 @@ static int __thread_do_softirq(int cpu)
 	 */
 	if (local_softirq_pending())
 		__do_softirq_common(cpu >= 0);
-	local_unlock(local_softirq_lock);
 	unpin_current_cpu();
-	preempt_disable();
 	local_irq_enable();
+	local_unlock(local_softirq_lock);
+	preempt_disable();
 	return 0;
 }
 
diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
index 6a4c8694c55a..900046843068 100644
--- a/kernel/trace/latency_hist.c
+++ b/kernel/trace/latency_hist.c
@@ -114,7 +114,7 @@ static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
 static char *wakeup_latency_hist_dir = "wakeup";
 static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success);
+    struct task_struct *p);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
     struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
@@ -868,7 +868,7 @@ static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
 }
 
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success)
+    struct task_struct *p)
 {
 	unsigned long flags;
 	struct task_struct *curr = current;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index bafa41220311..98ed28cf31cc 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -438,13 +438,13 @@ void start_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(TRACE_START, 1);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_START, 1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	trace_preemptirqsoff_hist(TRACE_STOP, 0);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_STOP, 0);
 	if (preempt_trace() || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -489,7 +489,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -499,7 +499,7 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
diff --git a/localversion-rt b/localversion-rt
index e0b93414dc30..e27678f73d17 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt139
+-rt140
