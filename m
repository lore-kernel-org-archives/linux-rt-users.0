Return-Path: <SRS0=WElg=R6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA8C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9A2070B
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbfC0SdR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:33:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390945AbfC0SdQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Mar 2019 14:33:16 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9DMO-0004Tc-RQ; Wed, 27 Mar 2019 19:33:13 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/4] powerpc: reshuffle TIF bits
Date:   Wed, 27 Mar 2019 19:33:10 +0100
Message-Id: <20190327183310.1015-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327183310.1015-1-bigeasy@linutronix.de>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
 <20190327183310.1015-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Powerpc32/64 does not compile because TIF_SYSCALL_TRACE's bit is higher
than 15 and the assembly instructions don't expect that.

Move TIF_RESTOREALL, TIF_NOERROR to the higher bits and keep
TIF_NEED_RESCHED_LAZY in the lower range. As a result one split load is
needed and otherwise we can use immediates.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/include/asm/thread_info.h | 13 ++++++++-----
 arch/powerpc/kernel/entry_32.S         | 12 +++++++-----
 arch/powerpc/kernel/entry_64.S         | 12 +++++++-----
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 7e542e729f131..f9132398566d9 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -90,7 +90,7 @@ void arch_setup_new_exec(void);
 /*
  * thread information flag bit numbers
  */
-#define TIF_NEED_RESCHED_LAZY	0	/* lazy rescheduling necessary */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
@@ -101,11 +101,12 @@ void arch_setup_new_exec(void);
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
 #define TIF_SECCOMP		10	/* secure computing */
-#define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
-#define TIF_NOERROR		12	/* Force successful syscall return */
+
+#define TIF_NEED_RESCHED_LAZY	11	/* lazy rescheduling necessary */
+#define TIF_SYSCALL_TRACEPOINT	12	/* syscall tracepoint instrumentation */
+
 #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
 #define TIF_UPROBE		14	/* breakpointed or single-stepping */
-#define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
 #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
 						for stack store? */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -114,7 +115,9 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_TRACE	21	/* syscall trace active */
+#define TIF_RESTOREALL		21	/* Restore all regs (implies NOERROR) */
+#define TIF_NOERROR		22	/* Force successful syscall return */
+
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 553e1ad981c30..1b6c95d49cd23 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -393,7 +393,9 @@ _GLOBAL(DoSyscall)
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-MAX_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	lis	r0,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@h
+	ori	r0,r0, (_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@l
+	and.	r0,r9,r0
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
 	blt+	syscall_exit_cont
@@ -511,13 +513,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	b	syscall_dotrace_cont
 
 syscall_exit_work:
-	andi.	r0,r9,_TIF_RESTOREALL
+	andis.	r0,r9,_TIF_RESTOREALL@h
 	beq+	0f
 	REST_NVGPRS(r1)
 	b	2f
 0:	cmplw	0,r3,r8
 	blt+	1f
-	andi.	r0,r9,_TIF_NOERROR
+	andis.	r0,r9,_TIF_NOERROR@h
 	bne-	1f
 	lwz	r11,_CCR(r1)			/* Load CR */
 	neg	r3,r3
@@ -526,12 +528,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 
 1:	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
+2:	andis.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
 	beq	4f
 
 	/* Clear per-syscall TIF flags if any are set.  */
 
-	li	r11,_TIF_PERSYSCALL_MASK
+	lis	r11,_TIF_PERSYSCALL_MASK@h
 	addi	r12,r12,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index fcf8fe69beb51..d857823e25b2f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -253,7 +253,9 @@ system_call:			/* label this so stack traces look sane */
 
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	lis	r0,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@h
+	ori	r0,r0,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@l
+	and.	r0,r9,r0
 	bne-	.Lsyscall_exit_work
 
 	andi.	r0,r8,MSR_FP
@@ -370,25 +372,25 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
 	 If TIF_NOERROR is set, just save r3 as it is. */
 
-	andi.	r0,r9,_TIF_RESTOREALL
+	andis.	r0,r9,_TIF_RESTOREALL@h
 	beq+	0f
 	REST_NVGPRS(r1)
 	b	2f
 0:	cmpld	r3,r11		/* r11 is -MAX_ERRNO */
 	blt+	1f
-	andi.	r0,r9,_TIF_NOERROR
+	andis.	r0,r9,_TIF_NOERROR@h
 	bne-	1f
 	ld	r5,_CCR(r1)
 	neg	r3,r3
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
 	std	r5,_CCR(r1)
 1:	std	r3,GPR3(r1)
-2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
+2:	andis.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
 	beq	4f
 
 	/* Clear per-syscall TIF flags if any are set.  */
 
-	li	r11,_TIF_PERSYSCALL_MASK
+	lis	r11,(_TIF_PERSYSCALL_MASK)@h
 	addi	r12,r12,TI_FLAGS
 3:	ldarx	r10,0,r12
 	andc	r10,r10,r11
-- 
2.20.1

