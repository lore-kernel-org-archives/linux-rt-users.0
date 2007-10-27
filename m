From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Don't disable preemption in exception handlers without IST
Date: Sat, 27 Oct 2007 12:39:33 +0200
Message-ID: <20071027103933.GA9536@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57123 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbXJ0Kje (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 06:39:34 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AA23D22D45
	for <linux-rt-users@vger.kernel.org>; Sat, 27 Oct 2007 12:39:33 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Some of the exception handlers that run on an IST in a normal kernel
still disable preemption. This causes might_sleep warning when sending signals
for debugging in PREEMPT-RT because sending signals can take a lock. 
Since the ISTs are disabled now for those don't disable the preemption.

This completes the remove IST patch I sent some time ago and fixes
another case where using gdb caused warnings.

Also it will likely improve latency a little bit.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rt1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.23-rt1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.23-rt1/arch/x86_64/kernel/traps.c
@@ -81,20 +81,22 @@ static inline void conditional_sti(struc
 		local_irq_enable();
 }
 
-static inline void preempt_conditional_sti(struct pt_regs *regs)
+static inline void preempt_conditional_sti(struct pt_regs *regs, int stack)
 {
-	preempt_disable();
+	if (stack)
+		preempt_disable();
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
 }
 
-static inline void preempt_conditional_cli(struct pt_regs *regs)
+static inline void preempt_conditional_cli(struct pt_regs *regs, int stack)
 {
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_disable();
 	/* Make sure to not schedule here because we could be running
 	   on an exception stack. */
-	preempt_enable_no_resched();
+	if (stack)
+		preempt_enable_no_resched();
 }
 
 int kstack_depth_to_print = 12;
@@ -663,9 +665,9 @@ asmlinkage void do_stack_segment(struct 
 	if (notify_die(DIE_TRAP, "stack segment", regs, error_code,
 			12, SIGBUS) == NOTIFY_STOP)
 		return;
-	preempt_conditional_sti(regs);
+	preempt_conditional_sti(regs, STACKFAULT_STACK);
 	do_trap(12, SIGBUS, "stack segment", regs, error_code, NULL);
-	preempt_conditional_cli(regs);
+	preempt_conditional_cli(regs, STACKFAULT_STACK);
 }
 
 asmlinkage void do_double_fault(struct pt_regs * regs, long error_code)
@@ -821,9 +823,9 @@ asmlinkage void __kprobes do_int3(struct
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP) == NOTIFY_STOP) {
 		return;
 	}
-	preempt_conditional_sti(regs);
+	preempt_conditional_sti(regs, DEBUG_STACK);
 	do_trap(3, SIGTRAP, "int3", regs, error_code, NULL);
-	preempt_conditional_cli(regs);
+	preempt_conditional_cli(regs, DEBUG_STACK);
 }
 
 /* Help handler running on IST stack to switch back to user stack
@@ -861,7 +863,7 @@ asmlinkage void __kprobes do_debug(struc
 						SIGTRAP) == NOTIFY_STOP)
 		return;
 
-	preempt_conditional_sti(regs);
+	preempt_conditional_sti(regs, DEBUG_STACK);
 
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
@@ -906,13 +908,13 @@ asmlinkage void __kprobes do_debug(struc
 
 clear_dr7:
 	set_debugreg(0UL, 7);
-	preempt_conditional_cli(regs);
+	preempt_conditional_cli(regs, DEBUG_STACK);
 	return;
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 	regs->eflags &= ~TF_MASK;
-	preempt_conditional_cli(regs);
+	preempt_conditional_cli(regs, DEBUG_STACK);
 }
 
 static int kernel_math_error(struct pt_regs *regs, const char *str, int trapnr)
