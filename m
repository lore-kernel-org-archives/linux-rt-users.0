Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF36DC10F06
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A279B2184C
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfC1WRc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:17:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfC1WRc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 18:17:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9dKx-0002fF-UU; Thu, 28 Mar 2019 23:17:28 +0100
Date:   Thu, 28 Mar 2019 23:17:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.5-rt3
Message-ID: <20190328221727.xupkqegsuakleoiq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.5-rt3 patch set. 

Changes since v5.0.5-rt2:

  - Multiple fixes for build failures introduced by the printk series.
    Reported by the kbuild test robot, patched by John Ogness.

  - Various powerpc fixes:
    - Reorder TIF bits so the assembly code compiles. Reported by kbuild
      test robot.

    - Avoid acquiring a sleeping lock during the bring of the secondary
      CPU.

    - Use a local_lock instead of disabling interrupts as protection in
      pseries' iommu code.

  - Turn show_lock into raw_lock which is used during a sysrq request in
    ARM64. Patch by Julien Grall.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.5-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.5-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.5-rt3

The RT patch against v5.0.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.5-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.5-rt3.tar.xz

Sebastian

diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
index 1c8460e235838..e764eb4b6c284 100644
--- a/arch/powerpc/include/asm/stackprotector.h
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -24,7 +24,11 @@ static __always_inline void boot_init_stack_canary(void)
 	unsigned long canary;
 
 	/* Try to get a semi random initial value. */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	canary = (unsigned long)&canary;
+#else
 	canary = get_random_canary();
+#endif
 	canary ^= mftb();
 	canary ^= LINUX_VERSION_CODE;
 	canary &= CANARY_MASK;
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
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7a1de34f38c85..314be8e39d1fd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -174,7 +174,6 @@ extern void panic_flush_kmsg_start(void)
 
 extern void panic_flush_kmsg_end(void)
 {
-	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 3c6ab22a0c4e3..bf98181c5b309 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -181,11 +181,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	wd_smp_unlock(&flags);
 
-	printk_safe_flush();
-	/*
-	 * printk_safe_flush() seems to require another print
-	 * before anything actually goes out to console.
-	 */
 	if (sysctl_hardlockup_all_cpu_backtrace)
 		trigger_allbutself_cpu_backtrace();
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8fc8fe0b98485..14ecedbd8ff12 100644
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
@@ -191,6 +192,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -211,7 +213,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __this_cpu_read(tce_page);
 
@@ -222,7 +225,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -256,7 +259,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -414,13 +417,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
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
@@ -466,7 +470,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078ec3527..8473557c7ab2a 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -218,10 +218,10 @@ static void showacpu(void *dummy)
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5cfd8ea445362..997d07b6bf975 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -370,6 +370,18 @@ static u64 clear_seq;
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
+/* Return log buffer address */
+char *log_buf_addr_get(void)
+{
+	return printk_rb.buffer;
+}
+
+/* Return log buffer size */
+u32 log_buf_len_get(void)
+{
+	return (1 << printk_rb.size_bits);
+}
+
 /* human readable text of the record */
 static char *log_text(const struct printk_log *msg)
 {
@@ -1910,7 +1922,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(vprintk_emit);
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+static __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
@@ -2684,7 +2696,7 @@ static int __init init_printk_kthread(void)
 }
 late_initcall(init_printk_kthread);
 
-int vprintk_deferred(const char *fmt, va_list args)
+static int vprintk_deferred(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index ce33b5add5a17..9a31d7dbdc005 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -196,8 +196,14 @@ void prb_commit(struct prb_handle *h)
 
 	if (changed) {
 		atomic_long_inc(&rb->wq_counter);
-		if (wq_has_sleeper(rb->wq))
+		if (wq_has_sleeper(rb->wq)) {
+#ifdef CONFIG_IRQ_WORK
 			irq_work_queue(rb->wq_work);
+#else
+			if (!in_nmi())
+				wake_up_interruptible_all(rb->wq);
+#endif
+		}
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
