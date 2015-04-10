From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Fri, 10 Apr 2015 14:36:34 +0200
Message-ID: <20150410123634.GA3057@linutronix.de>
References: <55245FC8.9090509@osadl.org>
 <5526AE86.7030708@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51314 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbbDJMgg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Apr 2015 08:36:36 -0400
Content-Disposition: inline
In-Reply-To: <5526AE86.7030708@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2015-04-09 18:53:26 [+0200]:

>On 04/08/2015 12:52 AM, Carsten Emde wrote:
>> Hi Sebastian,
>
Hi Carsten,

>> an Intel Bay Trail board (Intel(R) Celeron(R) CPU  J1900  @ 1.99GHz) at
>> the OSADL QA Farm rack #b/slot #6 (https://www.osadl.org/?id=1894) stops
>> working every 12 to 36 hours. The only way to get the board back to work
>
>I'm going to re-arm the IPI which should cure this. Tomorrow.

Could you try this:
--

Subject: [PATCH] kernel/irq_work: fix no_hz deadlock

Invoking NO_HZ's irq_work callback from timer irq is not working very
well if the callback decides to invoke hrtimer_cancel():

|hrtimer_try_to_cancel+0x55/0x5f
|hrtimer_cancel+0x16/0x28
|tick_nohz_restart+0x17/0x72
|__tick_nohz_full_check+0x8e/0x93
|nohz_full_kick_work_func+0xe/0x10
|irq_work_run_list+0x39/0x57
|irq_work_tick+0x60/0x67
|update_process_times+0x57/0x67
|tick_sched_handle+0x4a/0x59
|tick_sched_timer+0x3b/0x64
|__run_hrtimer+0x7a/0x149
|hrtimer_interrupt+0x1cc/0x2c5

and here we deadlock while waiting for the lock which we are holding.
To fix this I'm doing the same thing that upstream is doing: is the
irq_work dedicated IRQ and use it only for what is marked as "hirq"
which should only be the FULL_NO_HZ related work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/smp.c      |    2 --
 arch/arm64/kernel/smp.c    |    2 --
 arch/powerpc/kernel/time.c |    2 +-
 arch/sparc/kernel/pcr.c    |    2 --
 arch/x86/kernel/irq_work.c |    2 --
 kernel/irq_work.c          |   33 +++++++++++----------------------
 kernel/time/tick-sched.c   |    5 +++++
 kernel/time/timer.c        |    6 +++---
 8 files changed, 20 insertions(+), 34 deletions(-)

--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -506,14 +506,12 @@ void arch_send_call_function_single_ipi(
 }
 
 #ifdef CONFIG_IRQ_WORK
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	if (arch_irq_work_has_interrupt())
 		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
-#endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -529,14 +529,12 @@ void arch_send_call_function_single_ipi(
 }
 
 #ifdef CONFIG_IRQ_WORK
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	if (__smp_cross_call)
 		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
-#endif
 
 static DEFINE_RAW_SPINLOCK(stop_lock);
 
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -424,7 +424,7 @@ unsigned long profile_pc(struct pt_regs
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 
 /*
  * 64-bit uses a byte in the PACA, 32-bit uses a per-cpu variable...
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -43,12 +43,10 @@ void __irq_entry deferred_pcr_work_irq(i
 	set_irq_regs(old_regs);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	set_softint(1 << PIL_DEFERRED_PCR_WORK);
 }
-#endif
 
 const struct pcr_ops *pcr_ops;
 EXPORT_SYMBOL_GPL(pcr_ops);
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -38,7 +38,6 @@ static inline void __smp_irq_work_interr
 	exiting_irq();
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -49,4 +48,3 @@ void arch_irq_work_raise(void)
 	apic_wait_icr_idle();
 #endif
 }
-#endif
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -51,11 +51,7 @@ static bool irq_work_claim(struct irq_wo
 	return true;
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-void arch_irq_work_raise(void)
-#else
 void __weak arch_irq_work_raise(void)
-#endif
 {
 	/*
 	 * Lame architectures will get the timer tick callback
@@ -117,10 +113,8 @@ bool irq_work_queue(struct irq_work *wor
 	if (work->flags & IRQ_WORK_HARD_IRQ) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
 			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
-			arch_irq_work_raise();
-	}
+	} /* for lazy_list we have the timer irq */
+
 #else
 	if (work->flags & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
@@ -203,30 +197,25 @@ static void irq_work_run_list(struct lli
 void irq_work_run(void)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_irq()) {
-		irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-		return;
-	}
-#endif
+	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
+#else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
+#endif
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
 void irq_work_tick(void)
 {
-	struct llist_head *raised;
-
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_irq()) {
-		irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-		return;
-	}
-#endif
-	raised = &__get_cpu_var(raised_list);
-	if (!llist_empty(raised))
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+#else
+	struct llist_head *raised = &__get_cpu_var(raised_list);
+
+	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
 	irq_work_run_list(&__get_cpu_var(lazy_list));
+#endif
 }
 
 /*
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -181,6 +181,11 @@ static bool can_stop_full_tick(void)
 		return false;
 	}
 
+	if (!arch_irq_work_has_interrupt()) {
+		trace_tick_stop(0, "missing irq work interrupt\n");
+		return false;
+	}
+
 	/* sched_clock_tick() needs us? */
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 	/*
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1450,9 +1450,9 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
-#ifdef CONFIG_IRQ_WORK
-	if (in_irq())
-		irq_work_tick();
+
+#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+	irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }
