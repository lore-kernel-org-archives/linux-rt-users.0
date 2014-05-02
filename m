From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch 2/6] x86/preempt-lazy adapt implementation to percpu
 __preempt_count
Date: Fri, 02 May 2014 13:12:56 +0200
Message-ID: <1399029176.5233.126.camel@marge.simpson.net>
References: <1399020080.5233.96.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:53942 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEBLM7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:12:59 -0400
Received: by mail-ee0-f54.google.com with SMTP id b57so1129401eek.41
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:12:58 -0700 (PDT)
In-Reply-To: <1399020080.5233.96.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 arch/x86/include/asm/preempt.h |    8 ++++++++
 arch/x86/kernel/asm-offsets.c  |    1 +
 arch/x86/kernel/entry_32.S     |    9 ++++++---
 arch/x86/kernel/entry_64.S     |    7 +++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -94,7 +94,11 @@ static __always_inline bool __preempt_co
 {
 	if (____preempt_count_dec_and_test())
 		return true;
+#ifdef CONFIG_PREEMPT_LAZY
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
+#else
+	return false;
+#endif
 }
 
 /*
@@ -102,8 +106,12 @@ static __always_inline bool __preempt_co
  */
 static __always_inline bool should_resched(void)
 {
+#ifdef CONFIG_PREEMPT_LAZY
 	return unlikely(!__this_cpu_read_4(__preempt_count) || \
 			test_thread_flag(TIF_NEED_RESCHED_LAZY));
+#else
+	return unlikely(!__this_cpu_read_4(__preempt_count));
+#endif
 }
 
 #ifdef CONFIG_PREEMPT
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -72,4 +72,5 @@ void common(void) {
 
 	BLANK();
 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
+	DEFINE(_PREEMPT_ENABLED, PREEMPT_ENABLED);
 }
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -365,19 +365,22 @@ ENTRY(resume_kernel)
 need_resched:
 	# preempt count == 0 + NEED_RS set?
 	cmpl $0,PER_CPU_VAR(__preempt_count)
+#ifndef CONFIG_PREEMPT_LAZY
+	jnz restore_all
+#else
 	jz test_int_off
 
 	# atleast preempt count == 0 ?
-	cmpl $_TIF_NEED_RESCHED,PER_CPU_VAR(__preempt_count)
+	cmpl $_PREEMPT_ENABLED,PER_CPU_VAR(__preempt_count)
 	jne restore_all
 
 	cmpl $0,TI_preempt_lazy_count(%ebp)	# non-zero preempt_lazy_count ?
 	jnz restore_all
 
-	testl $_TIF_NEED_RESCHED_LAZY, %ecx
+	testl $_TIF_NEED_RESCHED_LAZY, TI_flags(%ebp)
 	jz restore_all
-
 test_int_off:
+#endif
 	testl $X86_EFLAGS_IF,PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz restore_all
 	call preempt_schedule_irq
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1104,10 +1104,13 @@ ENTRY(native_iret)
 	/* rcx:	 threadinfo. interrupts off. */
 ENTRY(retint_kernel)
 	cmpl $0,PER_CPU_VAR(__preempt_count)
+#ifndef CONFIG_PREEMPT_LAZY
+	jnz  retint_restore_args
+#else
 	jz  check_int_off
 
 	# atleast preempt count == 0 ?
-	cmpl $_TIF_NEED_RESCHED,PER_CPU_VAR(__preempt_count)
+	cmpl $_PREEMPT_ENABLED,PER_CPU_VAR(__preempt_count)
 	jnz retint_restore_args
 
 	cmpl $0, TI_preempt_lazy_count(%rcx)
@@ -1115,8 +1118,8 @@ ENTRY(retint_kernel)
 
 	bt $TIF_NEED_RESCHED_LAZY,TI_flags(%rcx)
 	jnc  retint_restore_args
