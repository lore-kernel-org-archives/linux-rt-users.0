Return-Path: <SRS0=Q2zZ=T4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D8FC04AB6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8376621670
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 22:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfE1WtC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 May 2019 18:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1WtB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 May 2019 18:49:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825E720B1F;
        Tue, 28 May 2019 22:48:59 +0000 (UTC)
Date:   Tue, 28 May 2019 18:48:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.19.37-rt20
Message-ID: <20190528184857.2b9442c7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.37-rt20 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 66d5562e2a457c468303368e49722d5f6e4cfad0


Or to build 4.19.37-rt20 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.37.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.37-rt20.patch.xz



You can also build from 4.19.37-rt19 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.37-rt19-rt20.patch.xz



Enjoy,

-- Steve


Changes from v4.19.37-rt19:

---

Corey Minyard (1):
      sched/completion: Fix a lockup in wait_for_completion()

Julien Grall (1):
      tty/sysrq: Convert show_lock to raw_spinlock_t

Sebastian Andrzej Siewior (3):
      powerpc/pseries/iommu: Use a locallock instead local_irq_save()
      powerpc: reshuffle TIF bits
      drm/i915: Don't disable interrupts independently of the lock

Steven Rostedt (VMware) (1):
      Linux 4.19.37-rt20

----
 arch/powerpc/include/asm/thread_info.h | 11 +++++++----
 arch/powerpc/kernel/entry_32.S         | 12 +++++++-----
 arch/powerpc/kernel/entry_64.S         | 12 +++++++-----
 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++++++------
 drivers/gpu/drm/i915/i915_request.c    |  8 ++------
 drivers/tty/sysrq.c                    |  6 +++---
 kernel/sched/completion.c              |  2 +-
 localversion-rt                        |  2 +-
 8 files changed, 38 insertions(+), 31 deletions(-)
---------------------------
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
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f02960b439..d80d919c78d3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/locallock.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -212,6 +213,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -232,7 +234,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __this_cpu_read(tce_page);
 
@@ -243,7 +246,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -277,7 +280,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -435,13 +438,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	u64 rc = 0;
 	long l, limit;
 
-	local_irq_disable();	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irq(tcp_page_lock);
 	tcep = __this_cpu_read(tce_page);
 
 	if (!tcep) {
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
-			local_irq_enable();
+			local_unlock_irq(tcp_page_lock);
 			return -ENOMEM;
 		}
 		__this_cpu_write(tce_page, tcep);
@@ -487,7 +491,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 5c2c93cbab12..7124510b9131 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -356,9 +356,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 
 	GEM_BUG_ON(!i915_request_completed(rq));
 
-	local_irq_disable();
-
-	spin_lock(&engine->timeline.lock);
+	spin_lock_irq(&engine->timeline.lock);
 	GEM_BUG_ON(!list_is_first(&rq->link, &engine->timeline.requests));
 	list_del_init(&rq->link);
 	spin_unlock(&engine->timeline.lock);
@@ -372,9 +370,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 		GEM_BUG_ON(!atomic_read(&rq->i915->gt_pm.rps.num_waiters));
 		atomic_dec(&rq->i915->gt_pm.rps.num_waiters);
 	}
-	spin_unlock(&rq->lock);
-
-	local_irq_enable();
+	spin_unlock_irq(&rq->lock);
 
 	/*
 	 * The backing object for the context is done after switching to the
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..627517ad55bf 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -215,7 +215,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -225,10 +225,10 @@ static void showacpu(void *dummy)
 	if (idle_cpu(smp_processor_id()))
 		return;
 
-	spin_lock_irqsave(&show_lock, flags);
+	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
 	show_stack(NULL, NULL);
-	spin_unlock_irqrestore(&show_lock, flags);
+	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a58084978..49c14137988e 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/localversion-rt b/localversion-rt
index 483ad771f201..53614196cb36 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt19
+-rt20-rc1
