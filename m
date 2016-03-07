From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.97-rt107
Date: Mon, 7 Mar 2016 15:53:50 -0500
Message-ID: <20160307155350.45941a17@gandalf.local.home>
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
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:51263 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753013AbcCGUxy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 15:53:54 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.10.97-rt107 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: c443dcfea9e25bfbf12b6648d7b8fb77d9546be2


Or to build 3.10.97-rt107 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.97.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.97-rt107.patch.xz



You can also build from 3.10.97-rt106 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.97-rt106-rt107.patch.xz



Enjoy,

-- Steve


Changes from v3.10.97-rt106:

---

Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Mike Galbraith (1):
      tracing: Fix probe_wakeup_latency_hist_start() prototype

Sebastian Andrzej Siewior (7):
      softirq: split timer softirqs out of ksoftirqd
      net: provide a way to delegate processing a softirq to ksoftirqd
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel/stop_machine: partly revert "stop_machine: Use raw spinlocks"
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 3.10.97-rt107

Yang Shi (1):
      trace: Use rcuidle version for preemptoff_hist trace point

----
 arch/Kconfig                 |   1 +
 include/linux/ftrace.h       |  12 +++++
 include/linux/interrupt.h    |   8 ++++
 include/linux/sched.h        |   2 -
 include/trace/events/hist.h  |   1 +
 kernel/rcutorture.c          |   7 +++
 kernel/sched/core.c          |  18 ++-----
 kernel/softirq.c             | 110 ++++++++++++++++++++++++++++++++++++++-----
 kernel/stop_machine.c        |  38 +++------------
 kernel/trace/latency_hist.c  |   4 +-
 kernel/trace/trace_irqsoff.c |   8 ++--
 localversion-rt              |   2 +-
 net/core/dev.c               |   2 +-
 13 files changed, 145 insertions(+), 68 deletions(-)
---------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 8b1a614cb58a..9a053ceae899 100644
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
index 7a13848d635c..c47f15afecdc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -631,6 +631,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d6c00bcb7f97..3539dd67eee6 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -495,6 +495,14 @@ extern void thread_do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
+#ifdef CONFIG_PREEMPT_RT_FULL
+extern void __raise_softirq_irqoff_ksoft(unsigned int nr);
+#else
+static inline void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+}
+#endif
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61326229b234..866028bbd8ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -117,8 +117,6 @@ struct task_migration_notifier {
 };
 extern void register_task_migration_notifier(struct notifier_block *n);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
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
index e1f3a8c96724..00dbf08794ba 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -520,6 +520,7 @@ static struct rcu_torture_ops rcu_expedited_ops = {
 	.name		= "rcu_expedited"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -593,6 +594,12 @@ static struct rcu_torture_ops rcu_bh_expedited_ops = {
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
index 6c21a28689b9..756953bdc800 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2850,16 +2850,6 @@ u64 scheduler_tick_max_deferment(void)
 }
 #endif
 
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
 
@@ -2881,7 +2871,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2907,7 +2897,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
@@ -2999,7 +2989,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -3034,7 +3024,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d296cff5a0ee..2c71e6529c2c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -56,6 +56,10 @@ EXPORT_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define TIMER_SOFTIRQS	((1 << TIMER_SOFTIRQ) | (1 << HRTIMER_SOFTIRQ))
+DEFINE_PER_CPU(struct task_struct *, ktimer_softirqd);
+#endif
 
 char *softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "BLOCK_IOPOLL",
@@ -169,6 +173,17 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void wakeup_timer_softirqd(void)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __this_cpu_read(ktimer_softirqd);
+
+	if (tsk && tsk->state != TASK_RUNNING)
+		wake_up_process(tsk);
+}
+#endif
+
 static void handle_softirq(unsigned int vec_nr, int cpu, int need_rcu_bh_qs)
 {
 	struct softirq_action *h = softirq_vec + vec_nr;
@@ -262,7 +277,7 @@ static void __local_bh_disable(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 #else /* !CONFIG_TRACE_IRQFLAGS */
 static inline void __local_bh_disable(unsigned long ip, unsigned int cnt)
@@ -490,7 +505,6 @@ void __raise_softirq_irqoff(unsigned int nr)
 static inline void local_bh_disable_nort(void) { local_bh_disable(); }
 static inline void _local_bh_enable_nort(void) { _local_bh_enable(); }
 static void ksoftirqd_set_sched_params(unsigned int cpu) { }
-static void ksoftirqd_clr_sched_params(unsigned int cpu, bool online) { }
 
 #else /* !PREEMPT_RT_FULL */
 
@@ -566,8 +580,10 @@ static void do_current_softirqs(int need_rcu_bh_qs)
 			do_single_softirq(i, need_rcu_bh_qs);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
@@ -638,8 +654,12 @@ void thread_do_softirq(void)
 
 static void do_raise_softirq_irqoff(unsigned int nr)
 {
+	unsigned int mask;
+
+	mask = 1UL << nr;
+
 	trace_softirq_raise(nr);
-	or_softirq_pending(1UL << nr);
+	or_softirq_pending(mask);
 
 	/*
 	 * If we are not in a hard interrupt and inside a bh disabled
@@ -648,16 +668,50 @@ static void do_raise_softirq_irqoff(unsigned int nr)
 	 * delegate it to ksoftirqd.
 	 */
 	if (!in_irq() && current->softirq_nestcnt)
-		current->softirqs_raised |= (1U << nr);
-	else if (__this_cpu_read(ksoftirqd))
-		__this_cpu_read(ksoftirqd)->softirqs_raised |= (1U << nr);
+		current->softirqs_raised |= mask;
+	else if (!__this_cpu_read(ksoftirqd) || !__this_cpu_read(ktimer_softirqd))
+		return;
+
+	if (mask & TIMER_SOFTIRQS)
+		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
+	else
+		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
+}
+
+static void wakeup_proper_softirq(unsigned int nr)
+{
+	if ((1UL << nr) & TIMER_SOFTIRQS)
+		wakeup_timer_softirqd();
+	else
+		wakeup_softirqd();
 }
 
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	do_raise_softirq_irqoff(nr);
 	if (!in_irq() && !current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
+}
+
+/*
+ * Same as __raise_softirq_irqoff() but will process them in ksoftirqd
+ */
+void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	unsigned int mask;
+
+	if (WARN_ON_ONCE(!__this_cpu_read(ksoftirqd) ||
+			 !__this_cpu_read(ktimer_softirqd)))
+		return;
+	mask = 1UL << nr;
+
+	trace_softirq_raise(nr);
+	or_softirq_pending(mask);
+	if (mask & TIMER_SOFTIRQS)
+		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
+	else
+		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
+	wakeup_proper_softirq(nr);
 }
 
 /*
@@ -697,22 +751,37 @@ static inline void _local_bh_enable_nort(void) { }
 
 static inline void ksoftirqd_set_sched_params(unsigned int cpu)
 {
+	/* Take over all but timer pending softirqs when starting */
+	local_irq_disable();
+	current->softirqs_raised = local_softirq_pending() & ~TIMER_SOFTIRQS;
+	local_irq_enable();
+}
+
+static inline void ktimer_softirqd_set_sched_params(unsigned int cpu)
+{
 	struct sched_param param = { .sched_priority = 1 };
 
 	sched_setscheduler(current, SCHED_FIFO, &param);
-	/* Take over all pending softirqs when starting */
+
+	/* Take over timer pending softirqs when starting */
 	local_irq_disable();
-	current->softirqs_raised = local_softirq_pending();
+	current->softirqs_raised = local_softirq_pending() & TIMER_SOFTIRQS;
 	local_irq_enable();
 }
 
-static inline void ksoftirqd_clr_sched_params(unsigned int cpu, bool online)
+static inline void ktimer_softirqd_clr_sched_params(unsigned int cpu,
+						    bool online)
 {
 	struct sched_param param = { .sched_priority = 0 };
 
 	sched_setscheduler(current, SCHED_NORMAL, &param);
 }
 
+static int ktimer_softirqd_should_run(unsigned int cpu)
+{
+	return current->softirqs_raised;
+}
+
 #endif /* PREEMPT_RT_FULL */
 /*
  * Enter an interrupt context.
@@ -758,8 +827,10 @@ static inline void invoke_softirq(void)
 	local_irq_save(flags);
 	if (__this_cpu_read(ksoftirqd) &&
 			__this_cpu_read(ksoftirqd)->softirqs_raised)
-
 		wakeup_softirqd();
+	if (__this_cpu_read(ktimer_softirqd) &&
+			__this_cpu_read(ktimer_softirqd)->softirqs_raised)
+		wakeup_timer_softirqd();
 	local_irq_restore(flags);
 #endif
 }
@@ -1205,17 +1276,30 @@ static struct notifier_block __cpuinitdata cpu_nfb = {
 static struct smp_hotplug_thread softirq_threads = {
 	.store			= &ksoftirqd,
 	.setup			= ksoftirqd_set_sched_params,
-	.cleanup		= ksoftirqd_clr_sched_params,
 	.thread_should_run	= ksoftirqd_should_run,
 	.thread_fn		= run_ksoftirqd,
 	.thread_comm		= "ksoftirqd/%u",
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static struct smp_hotplug_thread softirq_timer_threads = {
+	.store			= &ktimer_softirqd,
+	.setup			= ktimer_softirqd_set_sched_params,
+	.cleanup		= ktimer_softirqd_clr_sched_params,
+	.thread_should_run	= ktimer_softirqd_should_run,
+	.thread_fn		= run_ksoftirqd,
+	.thread_comm		= "ktimersoftd/%u",
+};
+#endif
+
 static __init int spawn_ksoftirqd(void)
 {
 	register_cpu_notifier(&cpu_nfb);
 
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
+#ifdef CONFIG_PREEMPT_RT_FULL
+	BUG_ON(smpboot_register_percpu_thread(&softirq_timer_threads));
+#endif
 
 	return 0;
 }
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5f02a3fe729f..652fea4b0c83 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -29,7 +29,7 @@ struct cpu_stop_done {
 	atomic_t		nr_todo;	/* nr left to execute */
 	bool			executed;	/* actually executed? */
 	int			ret;		/* collected return value */
-	struct task_struct	*waiter;	/* woken when nr_todo reaches 0 */
+	struct completion	completion;	/* fired if nr_todo reaches 0 */
 };
 
 /* the actual stopper, one per every possible cpu, enabled on online cpus */
@@ -47,7 +47,7 @@ static void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
 {
 	memset(done, 0, sizeof(*done));
 	atomic_set(&done->nr_todo, nr_todo);
-	done->waiter = current;
+	init_completion(&done->completion);
 }
 
 /* signal completion unless @done is NULL */
@@ -56,10 +56,8 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done, bool executed)
 	if (done) {
 		if (executed)
 			done->executed = true;
-		if (atomic_dec_and_test(&done->nr_todo)) {
-			wake_up_process(done->waiter);
-			done->waiter = NULL;
-		}
+		if (atomic_dec_and_test(&done->nr_todo))
+			complete(&done->completion);
 	}
 }
 
@@ -82,22 +80,6 @@ static void cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 }
 
-static void wait_for_stop_done(struct cpu_stop_done *done)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	while (atomic_read(&done->nr_todo)) {
-		schedule();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-	/*
-	 * We need to wait until cpu_stop_signal_done() has cleared
-	 * done->waiter.
-	 */
-	while (done->waiter)
-		cpu_relax();
-	set_current_state(TASK_RUNNING);
-}
-
 /**
  * stop_one_cpu - stop a cpu
  * @cpu: cpu to stop
@@ -129,7 +111,7 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 
 	cpu_stop_init_done(&done, 1);
 	cpu_stop_queue_work(cpu, &work);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -195,7 +177,7 @@ static int __stop_cpus(const struct cpumask *cpumask,
 
 	cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	queue_stop_cpus_work(cpumask, fn, arg, &done, false);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -326,13 +308,7 @@ repeat:
 			  kallsyms_lookup((unsigned long)fn, NULL, NULL, NULL,
 					  ksym_buf), arg);
 
-		/*
-		 * Make sure that the wakeup and setting done->waiter
-		 * to NULL is atomic.
-		 */
-		local_irq_disable();
 		cpu_stop_signal_done(done, true);
-		local_irq_enable();
 		goto repeat;
 	}
 }
@@ -573,7 +549,7 @@ int stop_machine_from_inactive_cpu(int (*fn)(void *), void *data,
 	ret = stop_machine_cpu_stop(&smdata);
 
 	/* Busy wait for completion. */
-	while (atomic_read(&done.nr_todo))
+	while (!completion_done(&done.completion))
 		cpu_relax();
 
 	mutex_unlock(&stop_cpus_mutex);
diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
index 011c2328d7b5..ff6ce3fcc001 100644
--- a/kernel/trace/latency_hist.c
+++ b/kernel/trace/latency_hist.c
@@ -115,7 +115,7 @@ static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
 static char *wakeup_latency_hist_dir = "wakeup";
 static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success);
+    struct task_struct *p);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
     struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
@@ -869,7 +869,7 @@ static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
 }
 
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success)
+    struct task_struct *p)
 {
 	unsigned long flags;
 	struct task_struct *curr = current;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 2f4eb37815d8..77bdfa55ce90 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -440,13 +440,13 @@ void start_critical_timings(void)
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
@@ -491,7 +491,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -501,7 +501,7 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
diff --git a/localversion-rt b/localversion-rt
index 8111d0b4d38d..2e0a3c960575 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt106
+-rt107
diff --git a/net/core/dev.c b/net/core/dev.c
index 864f7ae42c08..1857dde698ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4298,7 +4298,7 @@ out:
 
 softnet_break:
 	sd->time_squeeze++;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	__raise_softirq_irqoff_ksoft(NET_RX_SOFTIRQ);
 	goto out;
 }
 
