From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arch/arm64: Enable PREEMPT_RT_FULL
Date: Sun, 12 Apr 2015 09:59:38 +0200
Message-ID: <1428825578-12326-1-git-send-email-anders.roxell@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35255 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbDLH7p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 Apr 2015 03:59:45 -0400
Received: by lbbuc2 with SMTP id uc2so39098924lbb.2
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Apr 2015 00:59:43 -0700 (PDT)
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

I tested this on an arm64 juno target, to get that to boot I had to
backport the dtb from v4.0-rc6 to v3.18.11-rt6.


 arch/arm64/Kconfig                   |  2 ++
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/arm64/kernel/entry.S            | 14 ++++++++++----
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..62f4e00 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -59,7 +59,9 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_PREEMPT_LAZY
 	select HAVE_SYSCALL_TRACEPOINTS
+	select IRQ_FORCED_THREADING
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
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
index 726b910..8a631bb 100644
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
+	tbz	x0, #_TIF_NEED_RESCHED, 2f	// needs rescheduling?
+
+	ldr	w24, [tsk, #TI_PREEMPT_LAZY]	// get preempt lazy count
+	cbnz	w24, 1f				// preempt count != 0
+	tbz	x0, #_TIF_NEED_RESCHED_LAZY, 2f	// needs rescheduling?
 1:
+	bl	el1_preempt
+2:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
@@ -364,7 +369,8 @@ el1_preempt:
 	mov	x24, lr
 1:	bl	preempt_schedule_irq		// irq en/disable is done inside
 	ldr	x0, [tsk, #TI_FLAGS]		// get new tasks TI_FLAGS
-	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
+	tbnz	x0, #_TIF_NEED_RESCHED, 2b	// needs rescheduling?
+	tbnz	x0, #_TIF_NEED_RESCHED_LAZY, 2b
 	ret	x24
 #endif
 
-- 
2.1.4

