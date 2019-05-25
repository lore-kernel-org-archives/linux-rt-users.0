Return-Path: <SRS0=dorw=TZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51566C282E3
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7842177E
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEYDdc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 May 2019 23:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfEYDdR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 May 2019 23:33:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75692217D7;
        Sat, 25 May 2019 03:33:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNQp-0002Fq-Ip; Fri, 24 May 2019 23:33:15 -0400
Message-Id: <20190525033315.468968522@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:32:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 2/6] powerpc: reshuffle TIF bits
References: <20190525033232.795741612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.37-rt20-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Powerpc32/64 does not compile because TIF_SYSCALL_TRACE's bit is higher
than 15 and the assembly instructions don't expect that.

Move TIF_RESTOREALL, TIF_NOERROR to the higher bits and keep
TIF_NEED_RESCHED_LAZY in the lower range. As a result one split load is
needed and otherwise we can use immediates.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/thread_info.h | 11 +++++++----
 arch/powerpc/kernel/entry_32.S         | 12 +++++++-----
 arch/powerpc/kernel/entry_64.S         | 12 +++++++-----
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ce316076bc52..64c3d1a720e2 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -83,18 +83,18 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
-#define TIF_NEED_RESCHED_LAZY	4       /* lazy rescheduling necessary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
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
@@ -103,6 +103,9 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_RESTOREALL		21	/* Restore all regs (implies NOERROR) */
+#define TIF_NOERROR		22	/* Force successful syscall return */
+
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3783f3ef17a4..44bcf1585bd1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -393,7 +393,9 @@ ret_from_syscall:
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
@@ -511,13 +513,13 @@ syscall_dotrace:
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
@@ -526,12 +528,12 @@ syscall_exit_work:
 
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
index 7671fa5da9fa..fe713d014220 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -250,7 +250,9 @@ system_call_exit:
 
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	lis	r0,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@h
+	ori	r0,r0,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@l
+	and.	r0,r9,r0
 	bne-	.Lsyscall_exit_work
 
 	andi.	r0,r8,MSR_FP
@@ -363,25 +365,25 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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


