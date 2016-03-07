From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.2.77-rt112
Date: Mon, 7 Mar 2016 15:55:18 -0500
Message-ID: <20160307155518.1783717f@gandalf.local.home>
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
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:43319 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753021AbcCGUzV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 15:55:21 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.2.77-rt112 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.2-rt
  Head SHA1: 5f0ad001127d6f44a362d494c6b515a74cf27cfc


Or to build 3.2.77-rt112 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.77.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.77-rt112.patch.xz



You can also build from 3.2.77-rt111 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.77-rt111-rt112.patch.xz



Enjoy,

-- Steve


Changes from v3.2.77-rt111:

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
      Linux 3.2.77-rt112

----
 arch/Kconfig                |  1 +
 include/linux/ftrace.h      | 12 ++++++++++++
 include/linux/sched.h       |  2 --
 kernel/rcutorture.c         |  7 +++++++
 kernel/sched.c              | 18 ++++--------------
 kernel/softirq.c            |  6 +++---
 kernel/trace/latency_hist.c |  4 ++--
 localversion-rt             |  2 +-
 8 files changed, 30 insertions(+), 22 deletions(-)
---------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 73fc7cd51582..5e921bd9a57b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -46,6 +46,7 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize trace point call sites"
        depends on HAVE_ARCH_JUMP_LABEL
+       depends on (!INTERRUPT_OFF_HIST && !PREEMPT_OFF_HIST && !WAKEUP_LATENCY_HIST && !MISSED_TIMER_OFFSETS_HIST)
        help
          If it is detected that the compiler has support for "asm goto",
 	 the kernel will compile trace point locations with just a
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3ebb09d4283..3c87797e371e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -341,6 +341,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index a15cfd1bac9f..3cb870f1ffc1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -149,8 +149,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 struct seq_file;
 struct cfs_rq;
 struct task_group;
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 764825c2685c..3cd7834c7da6 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -455,6 +455,7 @@ static struct rcu_torture_ops rcu_expedited_ops = {
 	.name		= "rcu_expedited"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -528,6 +529,12 @@ static struct rcu_torture_ops rcu_bh_expedited_ops = {
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
diff --git a/kernel/sched.c b/kernel/sched.c
index a9f6d6c0ab93..abc27a937c1b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4460,16 +4460,6 @@ void scheduler_tick(void)
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
 
@@ -4491,7 +4481,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -4517,7 +4507,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
@@ -4611,7 +4601,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -4642,7 +4632,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index b7d68392e833..b03c01c77d92 100644
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
diff --git a/localversion-rt b/localversion-rt
index 9969a4b69fad..0c40e2660574 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt111
+-rt112
