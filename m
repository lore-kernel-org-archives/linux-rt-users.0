Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AAEC56201
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Nov 2020 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAF216FD
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Nov 2020 16:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYGTW4n+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ZuiAfRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgKLQ63 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLQ63 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Nov 2020 11:58:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD18CC0613D1;
        Thu, 12 Nov 2020 08:58:28 -0800 (PST)
Date:   Thu, 12 Nov 2020 17:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605200306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YZBfieHAInTJsx8tkl1n9WkrjhgE0X9LJu/TvBMCScw=;
        b=BYGTW4n+65RDYJNJ0o2tAR+E9azKElCOX3WugBeQj4eIiPdzYMUUEqrlatPGfuBeAOdeCo
        dTKtB0fwRHsBo6rMGUlZSdcEi3hxCbhyx1NDdTpbxyC/7yB9N6acVERYHYNJwfJ/Mp1P5G
        96fpD8Lh2d45tF59tIS3S1ixJZl6yswNd2W+P7ExJHvEg3lTyeybfffcUP8RkQ3jC4axyq
        Q+i6WJeGTimGNRUys3cJJGC1N0fYGQMK8BqdGjIUA9YLXlugGagnpMWkHW3WsRT0TALbnc
        ybZwV2lH8ZEgXMSHT6N+UBufCiHKfYmXV+QcC+EtDug4YJR1h9sR4wlsTvo4tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605200306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YZBfieHAInTJsx8tkl1n9WkrjhgE0X9LJu/TvBMCScw=;
        b=+ZuiAfRwzNEVcCdkM5A/kNpeE0dnyJAxPyAeMG0uMUxnwzXz9SawNGFAAjU+nI/IXEr5Am
        EMtHy4hZta6YSmCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc3-rt7
Message-ID: <20201112165824.s56wsbzsovunzwwg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc3-rt7 patch set. 

Changes since v5.10-rc3-rt6:

  - Mike Galbraith reported a lockdep warning triggered by the nouveau
    driver with threaded interrupts.

  - The recently reworked highmem code could trigger a warning on
    certain ARM configurations. Reported upstream once parts of the code
    hit linux-next. Patch by Thomas Gleixner.

  - Update the softirq patches by Thomas Gleixner to newer version.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc3-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc3-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc3-rt7

The RT patch against v5.10-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc3-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc3-rt7.tar.xz

Sebastian

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index b95848ed2bc7f..706efafbf9722 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -2,16 +2,11 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
 #include <asm/irq.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
+#define ack_bad_irq ack_bad_irq
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d41140df27d..1cbcc462b07e8 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,6 +31,8 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 5ffa4bacdad38..cbfa7b6f2e098 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,11 +13,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define ack_bad_irq ack_bad_irq
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 7f7039516e53f..fad29aa6f45fa 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -32,7 +32,6 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-#define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
diff --git a/arch/sh/include/asm/hardirq.h b/arch/sh/include/asm/hardirq.h
index edaea3559a232..9fe4495a8e90b 100644
--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -2,16 +2,10 @@
 #ifndef __ASM_SH_HARDIRQ_H
 #define __ASM_SH_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/irq.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;		/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+#define ARCH_WANTS_NMI_IRQSTAT
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_SH_HARDIRQ_H */
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index c4e46252377ed..9d2e4026be961 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 9c3d32b80038a..f5beecdac6938 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
 	arch_ftrace_nmi_enter();
 
 	nmi_enter();
-	nmi_count(cpu)++;
+	this_cpu_inc(irq_stat.__nmi_count);
 
 	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
 	case NOTIFY_OK:
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796d26fd7..52e2c36267a93 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,22 +2,7 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-#include <linux/irq.h>
-
-#ifndef ack_bad_irq
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
-#endif
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 22a39b72ce93f..b0ce938bbdb71 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -30,23 +30,32 @@ extern void kernel_fpu_resched(void);
  * A context switch will (and softirq might) save CPU's FPU registers to
  * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
+ *
+ * local_bh_disable() protects against both preemption and soft interrupts
+ * on !RT kernels.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
+ *
+ * Disabling preemption also serializes against kernel_fpu_begin().
  */
 static inline void fpregs_lock(void)
 {
-	preempt_disable();
-	/*
-	 * On RT disabling preemption is good enough because bottom halfs
-	 * are always running in thread context.
-	 */
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_bh_disable();
+	else
+		preempt_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_bh_enable();
-	preempt_enable();
+	else
+		preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214dfc10b3..7317e8258b486 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -7,9 +7,13 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef ARCH_WANTS_NMI_IRQSTAT
+	unsigned int __nmi_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
 #include <linux/irq.h>
 
 #ifndef ack_bad_irq
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 41408d5e40149..b14fb2a2a9c56 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -6,9 +6,9 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
+#include <linux/sched.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
-#include <linux/sched.h>
 
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fa0a1ec9cb691..e65df3c95bc55 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -665,6 +665,7 @@ static inline void tasklet_unlock(struct tasklet_struct *t)
 	smp_mb__before_atomic();
 	clear_bit(TASKLET_STATE_RUN, &(t)->state);
 }
+
 void tasklet_unlock_wait(struct tasklet_struct *t);
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
deleted file mode 100644
index 6e8895cd4d926..0000000000000
--- a/include/linux/irq_cpustat.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __irq_cpustat_h
-#define __irq_cpustat_h
-
-/*
- * Contains default mappings for irq_cpustat_t, used by almost every
- * architecture.  Some arch (like s390) have per cpu hardware pages and
- * they define their own mappings for irq_stat.
- *
- * Keith Owens <kaos@ocs.com.au> July 2000.
- */
-
-
-/*
- * Simple wrappers reducing source bloat.  Define all irq_stat fields
- * here, even ones that are arch dependent.  That way we get common
- * definitions instead of differing sets for each arch.
- */
-
-#ifndef __ARCH_IRQ_STAT
-DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
-#endif
-
-/* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
-
-#endif	/* __irq_cpustat_h */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 83b34cb809155..af39859f02ee1 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,34 +77,37 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
-#define pc_nmi_count()		(preempt_count() & NMI_MASK)
-#define hardirq_count()		(preempt_count() & HARDIRQ_MASK)
+#define nmi_count()	(preempt_count() & NMI_MASK)
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
 # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
 #else
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #endif
-#define irq_count()		(pc_nmi_count() | hardirq_count() | softirq_count())
+#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
- * Are we doing bottom half or hardware interrupt processing?
+ * Macros to retrieve the current execution context:
  *
- * in_irq()       - We're in (hard) IRQ context
+ * in_nmi()		- We're in NMI context
+ * in_hardirq()		- We're in hard IRQ context
+ * in_serving_softirq()	- We're in softirq context
+ * in_task()		- We're in task context
+ */
+#define in_nmi()		(nmi_count())
+#define in_hardirq()		(hardirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+
+/*
+ * The following macros are deprecated and should not be used in new code:
+ * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
- * in_serving_softirq() - We're in softirq context
- * in_nmi()       - We're in NMI context
- * in_task()	  - We're in task context
- *
- * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
- *       should not be used in new code.
  */
-#define in_nmi()		(pc_nmi_count())
 #define in_irq()		(hardirq_count())
-#define in_interrupt()		(irq_count())
 #define in_softirq()		(softirq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_task()		(!(irq_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+#define in_interrupt()		(irq_count())
 
 /*
  * The preempt_count offset after preempt_disable();
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 67dc04573ae35..ef4c1343bd0ca 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1155,6 +1155,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
 
+	sched_set_fifo(current);
+
 	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
 					&action->thread_flags))
 		handler_fn = irq_forced_thread_fn;
@@ -1326,8 +1328,6 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_set_fifo(t);
-
 	/*
 	 * We keep the reference to the task struct even if
 	 * the thread dies to avoid that the interrupt code
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 933a625621b8d..4a31127c6efbf 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -243,6 +243,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 static int kthread(void *_create)
 {
+	static const struct sched_param param = { .sched_priority = 0 };
 	/* Copy data: it's on kthread's stack */
 	struct kthread_create_info *create = _create;
 	int (*threadfn)(void *data) = create->threadfn;
@@ -273,6 +274,13 @@ static int kthread(void *_create)
 	init_completion(&self->parked);
 	current->vfork_done = &self->exited;
 
+	/*
+	 * The new thread inherited kthreadd's priority and CPU mask. Reset
+	 * back to default in case they have been changed.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
@@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	}
 	task = create->result;
 	if (!IS_ERR(task)) {
-		static const struct sched_param param = { .sched_priority = 0 };
 		char name[TASK_COMM_LEN];
 
 		/*
@@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 */
 		vsnprintf(name, sizeof(name), namefmt, args);
 		set_task_comm(task, name);
-		/*
-		 * root may have changed our (kthreadd's) priority or CPU mask.
-		 * The kernel thread should not inherit these properties.
-		 */
-		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a02735d4d1e9f..4406cdaa84670 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -158,7 +158,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	unsigned long flags;
 	int newcnt;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
@@ -314,11 +314,10 @@ static inline bool should_wake_ksoftirqd(void)
 #else /* CONFIG_PREEMPT_RT */
 
 /*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
+ * This one is for softirq.c-internal use, where hardirqs are disabled
+ * legitimately:
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -440,6 +439,11 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -466,7 +470,23 @@ static inline void invoke_softirq(void)
 	}
 }
 
-static inline bool should_wake_ksoftirqd(void) { return true; }
+asmlinkage __visible void do_softirq(void)
+{
+	__u32 pending;
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	pending = local_softirq_pending();
+
+	if (pending && !ksoftirqd_running(pending))
+		do_softirq_own_stack();
+
+	local_irq_restore(flags);
+}
 
 #endif /* !CONFIG_PREEMPT_RT */
 
@@ -595,26 +615,6 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
-#ifndef CONFIG_PREEMPT_RT
-asmlinkage __visible void do_softirq(void)
-{
-	__u32 pending;
-	unsigned long flags;
-
-	if (in_interrupt())
-		return;
-
-	local_irq_save(flags);
-
-	pending = local_softirq_pending();
-
-	if (pending && !ksoftirqd_running(pending))
-		do_softirq_own_stack();
-
-	local_irq_restore(flags);
-}
-#endif
-
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/highmem.c b/mm/highmem.c
index 8db577e5290cc..72b9a2d95c72a 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -422,12 +422,15 @@ static inline void *arch_kmap_local_high_get(struct page *page)
 #endif
 
 /* Unmap a local mapping which was obtained by kmap_high_get() */
-static inline void kmap_high_unmap_local(unsigned long vaddr)
+static inline bool kmap_high_unmap_local(unsigned long vaddr)
 {
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
-	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
 		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		return true;
+	}
 #endif
+	return false;
 }
 
 static inline int kmap_local_calc_idx(int idx)
@@ -493,10 +496,14 @@ void kunmap_local_indexed(void *vaddr)
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
-		WARN_ON_ONCE(addr < PAGE_OFFSET);
-
-		/* Handle mappings which were obtained by kmap_high_get() */
-		kmap_high_unmap_local(addr);
+		/*
+		 * Handle mappings which were obtained by kmap_high_get()
+		 * first as the virtual address of such mappings is below
+		 * PAGE_OFFSET. Warn for all other addresses which are in
+		 * the user space part of the virtual address space.
+		 */
+		if (!kmap_high_unmap_local(addr))
+			WARN_ON_ONCE(addr < PAGE_OFFSET);
 		return;
 	}
 
