From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
Date: Mon, 27 Apr 2015 22:53:10 +0200
Message-ID: <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de, ayyappa.ch.linux@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33838 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965140AbbD0UyB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 16:54:01 -0400
Received: by lbcga7 with SMTP id ga7so92060783lbc.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2015 13:53:59 -0700 (PDT)
In-Reply-To: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

arm64 is missing support for PREEMPT_RT. The main feature which is
lacking is support for lazy preemption. The arch-specific entry code,
thread information structure definitions, and associated data tables
have to be extended to provide this support. Then the Kconfig file has
to be extended to indicate the support is available, and also to
indicate that support for full RT preemption is now available.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/arm64/kernel/entry.S            | 13 ++++++++++---
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3708eec..06995bc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -59,6 +59,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_PREEMPT_LAZY
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 459bf8e..3e24ea1 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -50,6 +50,7 @@ struct thread_info {
 	struct exec_domain	*exec_domain;	/* execution domain */
 	struct restart_block	restart_block;
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
+	int			preempt_lazy_count;	/* 0 => preemptable, <0 => bug */
 	int			cpu;		/* cpu */
 };
 
@@ -108,6 +109,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
+#define TIF_NEED_RESCHED_LAZY	4
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -124,6 +126,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 9a9fce0..f774136 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -36,6 +36,7 @@ int main(void)
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
+  DEFINE(TI_PREEMPT_LAZY,	offsetof(struct thread_info, preempt_lazy_count));
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 726b910..b324d45 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -347,11 +347,16 @@ el1_irq:
 #ifdef CONFIG_PREEMPT
 	get_thread_info tsk
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
-	cbnz	w24, 1f				// preempt count != 0
+	cbnz	w24, 2f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
-	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
-	bl	el1_preempt
+	tbnz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
+
+	ldr	w24, [tsk, #TI_PREEMPT_LAZY]	// get preempt lazy count
+	cbnz	w24, 2f				// preempt lazy count != 0
+	tbz	x0, #TIF_NEED_RESCHED_LAZY, 2f	// needs rescheduling?
 1:
+	bl	el1_preempt
+2:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
@@ -365,6 +370,7 @@ el1_preempt:
 1:	bl	preempt_schedule_irq		// irq en/disable is done inside
 	ldr	x0, [tsk, #TI_FLAGS]		// get new tasks TI_FLAGS
 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
+	tbnz	x0, #TIF_NEED_RESCHED_LAZY, 1b	// needs rescheduling?
 	ret	x24
 #endif
 
@@ -601,6 +607,7 @@ fast_work_pending:
 	str	x0, [sp, #S_X0]			// returned x0
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
+	tbnz	x1, #TIF_NEED_RESCHED_LAZY, work_resched
 	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
 	ldr	x2, [sp, #S_PSTATE]
 	mov	x0, sp				// 'regs'
-- 
2.1.4

