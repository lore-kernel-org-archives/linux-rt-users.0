From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/22] softirq: split timer softirqs out of ksoftirqd
Date: Wed, 02 Mar 2016 10:09:06 -0500
Message-ID: <20160302151111.368583146@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55097 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcCBPLP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:11:15 -0500
Content-Disposition: inline; filename=0007-softirq-split-timer-softirqs-out-of-ksoftirqd.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.15-rt18-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The softirqd runs in -RT with SCHED_FIFO (prio 1) and deals mostly with
timer wakeup which can not happen in hardirq context. The prio has been
risen from the normal SCHED_OTHER so the timer wakeup does not happen
too late.
With enough networking load it is possible that the system never goes
idle and schedules ksoftirqd and everything else with a higher priority.
One of the tasks left behind is one of RCU's threads and so we see stalls
and eventually run out of memory.
This patch moves the TIMER and HRTIMER softirqs out of the `ksoftirqd`
thread into its own `ktimersoftd`. The former can now run SCHED_OTHER
(same as mainline) and the latter at SCHED_FIFO due to the wakeups.

>From networking point of view: The NAPI callback runs after the network
interrupt thread completes. If its run time takes too long the NAPI code
itself schedules the `ksoftirqd`. Here in the thread it can run at
SCHED_OTHER priority and it won't defer RCU anymore.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index f4c2e679a7d7..aff764fad236 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -58,6 +58,10 @@ EXPORT_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define TIMER_SOFTIRQS	((1 << TIMER_SOFTIRQ) | (1 << HRTIMER_SOFTIRQ))
+DEFINE_PER_CPU(struct task_struct *, ktimer_softirqd);
+#endif
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "BLOCK_IOPOLL",
@@ -171,6 +175,17 @@ static void wakeup_softirqd(void)
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
 static void handle_softirq(unsigned int vec_nr)
 {
 	struct softirq_action *h = softirq_vec + vec_nr;
@@ -473,7 +488,6 @@ void __raise_softirq_irqoff(unsigned int nr)
 static inline void local_bh_disable_nort(void) { local_bh_disable(); }
 static inline void _local_bh_enable_nort(void) { _local_bh_enable(); }
 static void ksoftirqd_set_sched_params(unsigned int cpu) { }
-static void ksoftirqd_clr_sched_params(unsigned int cpu, bool online) { }
 
 #else /* !PREEMPT_RT_FULL */
 
@@ -618,8 +632,12 @@ void thread_do_softirq(void)
 
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
@@ -628,16 +646,30 @@ static void do_raise_softirq_irqoff(unsigned int nr)
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
 
+
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	do_raise_softirq_irqoff(nr);
 	if (!in_irq() && !current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
 }
 
 /*
@@ -663,7 +695,7 @@ void raise_softirq_irqoff(unsigned int nr)
 	 * raise a WARN() if the condition is met.
 	 */
 	if (!current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
 }
 
 static inline int ksoftirqd_softirq_pending(void)
@@ -676,22 +708,37 @@ static inline void _local_bh_enable_nort(void) { }
 
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
@@ -741,6 +788,9 @@ static inline void invoke_softirq(void)
 	if (__this_cpu_read(ksoftirqd) &&
 			__this_cpu_read(ksoftirqd)->softirqs_raised)
 		wakeup_softirqd();
+	if (__this_cpu_read(ktimer_softirqd) &&
+			__this_cpu_read(ktimer_softirqd)->softirqs_raised)
+		wakeup_timer_softirqd();
 	local_irq_restore(flags);
 #endif
 }
@@ -1173,17 +1223,30 @@ static struct notifier_block cpu_nfb = {
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
-- 
2.7.0


