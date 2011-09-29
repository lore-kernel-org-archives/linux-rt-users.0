From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: x86_64 patch for idle notifiers
Date: Thu, 29 Sep 2011 12:40:47 -0700
Message-ID: <20110929194047.GA10247@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com
To: lclaudio@uudg.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35384 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403Ab1I2Tkw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 15:40:52 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8TJ9kSp022898
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Sep 2011 15:09:47 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p8TJenVn3260464
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Sep 2011 15:40:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p8TJemiZ009742
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Sep 2011 15:40:49 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello, Claudio,

Here you go, courtesy of Frederic.

								Thanx, Paul

------------------------------------------------------------------------

commit ef14aea88fee6089ae0d2bea540761cbe3081e04
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Mon Sep 26 12:19:11 2011 +0200

    x86: Call idle notifier after irq_enter()
    
    Interrupts notify the idle exit state before calling irq_enter().
    But the notifier code calls rcu_read_lock() and this is not
    allowed while rcu is in an extended quiescent state. We need
    to wait for rcu_irq_enter() to be called before doing so
    otherwise this results in a grumpy RCU:
    
    [    0.099991] WARNING: at include/linux/rcupdate.h:194 __atomic_notifier_call_chain+0xd2/0x110()
    [    0.099991] Hardware name: AMD690VM-FMH
    [    0.099991] Modules linked in:
    [    0.099991] Pid: 0, comm: swapper Not tainted 3.0.0-rc6+ #255
    [    0.099991] Call Trace:
    [    0.099991]  <IRQ>  [<ffffffff81051c8a>] warn_slowpath_common+0x7a/0xb0
    [    0.099991]  [<ffffffff81051cd5>] warn_slowpath_null+0x15/0x20
    [    0.099991]  [<ffffffff817d6fa2>] __atomic_notifier_call_chain+0xd2/0x110
    [    0.099991]  [<ffffffff817d6ff1>] atomic_notifier_call_chain+0x11/0x20
    [    0.099991]  [<ffffffff81001873>] exit_idle+0x43/0x50
    [    0.099991]  [<ffffffff81020439>] smp_apic_timer_interrupt+0x39/0xa0
    [    0.099991]  [<ffffffff817da253>] apic_timer_interrupt+0x13/0x20
    [    0.099991]  <EOI>  [<ffffffff8100ae67>] ? default_idle+0xa7/0x350
    [    0.099991]  [<ffffffff8100ae65>] ? default_idle+0xa5/0x350
    [    0.099991]  [<ffffffff8100b19b>] amd_e400_idle+0x8b/0x110
    [    0.099991]  [<ffffffff810cb01f>] ? rcu_enter_nohz+0x8f/0x160
    [    0.099991]  [<ffffffff810019a0>] cpu_idle+0xb0/0x110
    [    0.099991]  [<ffffffff817a7505>] rest_init+0xe5/0x140
    [    0.099991]  [<ffffffff817a7468>] ? rest_init+0x48/0x140
    [    0.099991]  [<ffffffff81cc5ca3>] start_kernel+0x3d1/0x3dc
    [    0.099991]  [<ffffffff81cc5321>] x86_64_start_reservations+0x131/0x135
    [    0.099991]  [<ffffffff81cc5412>] x86_64_start_kernel+0xed/0xf4
    
    Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Andy Henroid <andrew.d.henroid@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b9338b8..82af921 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -856,8 +856,8 @@ void __irq_entry smp_apic_timer_interrupt(struct pt_regs *regs)
 	 * Besides, if we don't timer interrupts ignore the global
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	local_apic_timer_interrupt();
 	irq_exit();
 
@@ -1790,8 +1790,8 @@ void smp_spurious_interrupt(struct pt_regs *regs)
 {
 	u32 v;
 
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1827,8 +1827,8 @@ void smp_error_interrupt(struct pt_regs *regs)
 		"Illegal register address",	/* APIC Error Bit 7 */
 	};
 
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v0 = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e529339..e1b5eec 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2275,8 +2275,8 @@ asmlinkage void smp_irq_move_cleanup_interrupt(void)
 	unsigned vector, me;
 
 	ack_APIC_irq();
-	exit_idle();
 	irq_enter();
+	exit_idle();
 
 	me = smp_processor_id();
 	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index ff1ae9b..7ba9757 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -470,8 +470,8 @@ static inline void mce_get_rip(struct mce *m, struct pt_regs *regs)
 asmlinkage void smp_mce_self_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	mce_notify_irq();
 	mce_schedule_work();
 	irq_exit();
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 27c6251..f6bbc64 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -396,8 +396,8 @@ static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
 asmlinkage void smp_thermal_interrupt(struct pt_regs *regs)
 {
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	inc_irq_stat(irq_thermal_count);
 	smp_thermal_vector();
 	irq_exit();
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mcheck/threshold.c
index d746df2..aa578ca 100644
--- a/arch/x86/kernel/cpu/mcheck/threshold.c
+++ b/arch/x86/kernel/cpu/mcheck/threshold.c
@@ -19,8 +19,8 @@ void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
 asmlinkage void smp_threshold_interrupt(void)
 {
-	exit_idle();
 	irq_enter();
+	exit_idle();
 	inc_irq_stat(irq_threshold_count);
 	mce_threshold_vector();
 	irq_exit();
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 6c0802e..73cf928 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -180,8 +180,8 @@ unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	unsigned vector = ~regs->orig_ax;
 	unsigned irq;
 
-	exit_idle();
 	irq_enter();
+	exit_idle();
 
 	irq = __this_cpu_read(vector_irq[vector]);
 
@@ -208,10 +208,10 @@ void smp_x86_platform_ipi(struct pt_regs *regs)
 
 	ack_APIC_irq();
 
-	exit_idle();
