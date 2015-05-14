From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/5] kernel/irq_work: fix no_hz deadlock
Date: Thu, 14 May 2015 10:01:38 -0400
Message-ID: <20150514140146.474702087@goodmis.org>
References: <20150514140137.396749660@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:35625 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906AbbENOBu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 10:01:50 -0400
Content-Disposition: inline; filename=0001-kernel-irq_work-fix-no_hz-deadlock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.40-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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

Cc: stable-rt@vger.kernel.org
Reported-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ Added check for in_irq() before calling irq_work_run() ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kernel/time.c | 2 +-
 arch/sparc/kernel/pcr.c    | 2 --
 arch/x86/kernel/irq_work.c | 2 --
 kernel/irq_work.c          | 5 +----
 kernel/time/tick-sched.c   | 5 +++++
 kernel/timer.c             | 2 +-
 6 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 03cbe6f231dc..945505e6ae9e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -423,7 +423,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 
 /*
  * 64-bit uses a byte in the PACA, 32-bit uses a per-cpu variable...
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 927d9c5e50f5..7e967c8018c8 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -43,12 +43,10 @@ void __irq_entry deferred_pcr_work_irq(int irq, struct pt_regs *regs)
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
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 3d21f7bd7b42..1de84e3ab4e0 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -38,7 +38,6 @@ __visible void smp_trace_irq_work_interrupt(struct pt_regs *regs)
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
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 35d21f93bbe8..5f7d93d89c7f 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -16,6 +16,7 @@
 #include <linux/tick.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
+#include <linux/interrupt.h>
 #include <asm/processor.h>
 
 
@@ -51,11 +52,7 @@ static bool irq_work_claim(struct irq_work *work)
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
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7e5c94b245e8..2cfd4c740042 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -175,6 +175,11 @@ static bool can_stop_full_tick(void)
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
diff --git a/kernel/timer.c b/kernel/timer.c
index 2d9ba1b9f698..286ca044f767 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1450,7 +1450,7 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
-#if defined(CONFIG_IRQ_WORK)
+#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
 	if (in_irq())
 		irq_work_run();
 #endif
-- 
2.1.4


