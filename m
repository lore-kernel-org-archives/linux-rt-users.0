From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.13-rt9
Date: Thu, 14 May 2015 23:31:16 +0200
Message-ID: <20150514213116.GK13442@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v3.18.13-rt9 patch set.

Changes since v3.18.13-rt8

- arm64 support. Patches by Anders Roxell.

- fix for XFS live-stall by Steven Rostedt.

- kvm mpic emulation for e500 (PPC) CPUs disabled. It is now known not
  to work perfectly. It is been worked on a final (workin) solution.
  Patch sent by Bogdan Purcareata.

- A dead lock fix for ftrace noticed and fixed by Jan Kiszka.

Known issues:

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 3.18.13-rt8 is appended below and can be found here: 

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.13-rt8-rt9.patch.xz

The RT patch against 3.18.13 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.13-rt9.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.13-rt9.tar.xz

Sebastian

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dc2d66cdf311..54ec128acf2d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -59,8 +59,10 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_PREEMPT_LAZY
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
+	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
 	select OF
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 459bf8e53208..3e24ea15c05c 100644
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
index 9a9fce090d58..f77413646dba 100644
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
index 2b0f3d5e11c7..0c7c7245b97c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -367,11 +367,16 @@ ENDPROC(el1_sync)
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
@@ -385,6 +390,7 @@ ENDPROC(el1_irq)
 1:	bl	preempt_schedule_irq		// irq en/disable is done inside
 	ldr	x0, [tsk, #TI_FLAGS]		// get new tasks TI_FLAGS
 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
+	tbnz	x0, #TIF_NEED_RESCHED_LAZY, 1b	// needs rescheduling?
 	ret	x24
 #endif
 
@@ -621,6 +627,7 @@ ENDPROC(cpu_switch_to)
 	str	x0, [sp, #S_X0]			// returned x0
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
+	tbnz	x1, #TIF_NEED_RESCHED_LAZY, work_resched
 	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
 	ldr	x2, [sp, #S_PSTATE]
 	mov	x0, sp				// 'regs'
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index aa29ecb4f800..70dcde67a808 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -461,7 +461,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 			}
 
 			err = request_irq(irq, armpmu->handle_irq,
-					IRQF_NOBALANCING,
+					IRQF_NOBALANCING | IRQF_NO_THREAD,
 					"arm-pmu", armpmu);
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 602eb51d20bc..60fc1adab19f 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -157,6 +157,7 @@ config KVM_E500MC
 config KVM_MPIC
 	bool "KVM in-kernel MPIC emulation"
 	depends on KVM && E500
+	depends on !PREEMPT_RT_FULL
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 6a51619d8690..430e7987d6ad 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -119,7 +119,7 @@ typedef __uint64_t __psunsigned_t;
 /*
  * Feature macros (disable/enable)
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT_FULL)
 #define HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
 #else
 #undef  HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9dda38a377bf..171dfacb61d4 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -85,12 +85,9 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		raise_irqwork = llist_add(&work->llnode,
 					  &per_cpu(hirq_work_list, cpu));
 	else
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(lazy_list, cpu));
-#else
+#endif
 		raise_irqwork = llist_add(&work->llnode,
 					  &per_cpu(raised_list, cpu));
-#endif
 
 	if (raise_irqwork)
 		arch_send_call_function_single_ipi(cpu);
@@ -114,21 +111,20 @@ bool irq_work_queue(struct irq_work *work)
 	if (work->flags & IRQ_WORK_HARD_IRQ) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
 			arch_irq_work_raise();
-	} else {
+	} else
+#endif
+	if (work->flags & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
+#ifdef CONFIG_PREEMPT_RT_FULL
 			raise_softirq(TIMER_SOFTIRQ);
-	}
 #else
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
+#endif
 	} else {
 		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
-#endif
 
 	preempt_enable();
 
@@ -202,6 +198,13 @@ void irq_work_run(void)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
 	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
+	/*
+	 * NOTE: we raise softirq via IPI for safety (caller may hold locks
+	 * that raise_softirq needs) and execute in irq_work_tick() to move
+	 * the overhead from hard to soft irq context.
+	 */
+	if (!llist_empty(this_cpu_ptr(&raised_list)))
+		raise_softirq(TIMER_SOFTIRQ);
 #else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
@@ -211,15 +214,12 @@ EXPORT_SYMBOL_GPL(irq_work_run);
 
 void irq_work_tick(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-#else
-	struct llist_head *raised = &__get_cpu_var(raised_list);
+	struct llist_head *raised = this_cpu_ptr(&raised_list);
 
-	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
+	if (!llist_empty(raised) && (!arch_irq_work_has_interrupt() ||
+				     IS_ENABLED(CONFIG_PREEMPT_RT_FULL)))
 		irq_work_run_list(raised);
-	irq_work_run_list(&__get_cpu_var(lazy_list));
-#endif
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
 /*
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9b..22746d6390a4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
