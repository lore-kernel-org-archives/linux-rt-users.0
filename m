Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6381BDA99;
	Thu, 10 Oct 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569221; cv=none; b=XdKqZoFUpOj0Hp+5bQ1F7qL1yKFYA32Ap3FbrhhjF1s2xt2MySetiTvR/YqR0IMIAmQ8CyguIA7o9f5cVocXHB6mDvLC1JeMRW3dxEVtowB9a+cbCvPfqXSaJ3kjguz9V7Rn4YPqRphxMWSdYqn/sO928vaeMwvwcbnY1xmuAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569221; c=relaxed/simple;
	bh=DEXSEuV429L24aXZTbS3o2ZBQBJO4KbhN6V++QbYmsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pV11W/mP3mlFd9i7mvvWlrG0Pv8olXqFMRxnVVp5cuzgE4DqCwjEHp0kDP+trxxjguymH2dY9C1Y1QW87Re6LCctWaXQ9WD16I2cofmuvLvikiC/SgG1pktpzAx4IFQAyxcJoyxZARy1V+myQfU7+SP4EA3/wg4tr/L1bLcRu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g90+ONzR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VM0kxW+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g90+ONzR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VM0kxW+t"
Date: Thu, 10 Oct 2024 16:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728569212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sddrJZe3qJ40rPNdtUURcrXkl1gLFUN0D2gePqr9PaY=;
	b=g90+ONzRr9l0mHU4pcboVlWoHYUt1zMO6Yqx79XircNhMAd4mAnCvwc+yv06fC1H7F6y6V
	C/6IxqZaQFXKXVA6T0Zx3RrWG/tlR0dnY4zfidSUS0S5964vLu6C3O/ysLjUYNlE0Hb2PT
	dgfe+ea1I8EvSL3Qk5JHejF12nxuIi9vW8QR2GpN4437Lc7muDzmP5PWZ3LRTBirUeBgP9
	e9wXy5XxEKet8tnWreY8wW+UFXuWyBlQL5wmrQWBasi3Q50+CS/sqA/+zz6/OGrp6TXTOq
	EkmvqlOK2DFR3Uu9EyQZvUDIOrX4o6AvT34Af28DAdO+kTGY1CdVW5JBrviQng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728569212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sddrJZe3qJ40rPNdtUURcrXkl1gLFUN0D2gePqr9PaY=;
	b=VM0kxW+tRoGbFnXn7jOuqncNZ8coiX/ePzx5cTxRXqQzUsAY2EUnxgLbnQ3Ymo6cQgIG0j
	Dy8seZw20OXjYHDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.12-rc2-rt4
Message-ID: <20241010140650.5r4XR_Y5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.12-rc2-rt4 patch set. 

Changes since v6.12-rc2-rt3:

  - Update patches to sync with latest submission, no functional change:

    - ARM vfp patches (function renames).

    - ktimerd patches (white space cleanup mostly.

  - Replace the PREEMPT_AUTO patch with LAZY_PREEMPT series by Peter
    Zijlstra. Functionality wise it should be all the same. Notable
    differences:

    - The "hog" test and the sched feature "FORCE_NEED_RESCHED" have
      been removed.

    - PREEMPT_RT is no longer a preemption model but can be selected as
      an additional option (still CONFIG_PREEMPT_RT so oldconfig works).

    - This LAZY preempt feature has been integrated as part of the
      preemption model. In order to enable it select
      CONFIG_PREEMPT_LAZY.

    - CONFIG_PREEMPT_DYNAMIC is supported with PREEMPT_RT. The possible
      choices are "full" and "lazy" on architectures where LAZY
      preemption is supported.

  - Arnd Bergmann reported a build failure on ARM64 with a PAGE_SIZE
    larger than 4KiB.

Known issues
    None.

The delta patch against v6.12-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/incr/patch-6.12-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.12-rc2-rt4

The RT patch against v6.12-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patches-6.12-rc2-rt4.tar.xz

Sebastian

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 48745a3c52618..d44867fc0c5ee 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -58,7 +58,7 @@ union vfp_state *vfp_current_hw_state[NR_CPUS];
 /*
  * Claim ownership of the VFP unit.
  *
- * The caller may change VFP registers until vfp_unlock() is called.
+ * The caller may change VFP registers until vfp_state_release() is called.
  *
  * local_bh_disable() is used to disable preemption and to disable VFP
  * processing in softirq context. On PREEMPT_RT kernels local_bh_disable() is
@@ -67,7 +67,7 @@ union vfp_state *vfp_current_hw_state[NR_CPUS];
  * choice here as bottom half processing is always in thread context on RT
  * kernels so it implicitly prevents bottom half processing as well.
  */
-static void vfp_lock(void)
+static void vfp_state_hold(void)
 {
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_bh_disable();
@@ -75,7 +75,7 @@ static void vfp_lock(void)
 		preempt_disable();
 }
 
-static void vfp_unlock(void)
+static void vfp_state_release(void)
 {
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_bh_enable();
@@ -443,7 +443,7 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 	if (exceptions)
 		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 exit:
-	vfp_unlock();
+	vfp_state_release();
 	if (si_code2)
 		vfp_raise_sigfpe(si_code2, regs);
 	if (si_code)
@@ -546,7 +546,7 @@ static inline void vfp_pm_init(void) { }
  */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
-	vfp_lock();
+	vfp_state_hold();
 
 	if (vfp_state_in_hw(raw_smp_processor_id(), thread)) {
 		u32 fpexc = fmrx(FPEXC);
@@ -559,7 +559,7 @@ void vfp_sync_hwstate(struct thread_info *thread)
 		fmxr(FPEXC, fpexc);
 	}
 
-	vfp_unlock();
+	vfp_state_release();
 }
 
 /* Ensure that the thread reloads the hardware VFP state on the next use. */
@@ -714,7 +714,7 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 	if (!user_mode(regs))
 		return vfp_kmode_exception(regs, trigger);
 
-	vfp_lock();
+	vfp_state_hold();
 	fpexc = fmrx(FPEXC);
 
 	/*
@@ -779,7 +779,7 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 		 * replay the instruction that trapped.
 		 */
 		fmxr(FPEXC, fpexc);
-		vfp_unlock();
+		vfp_state_release();
 	} else {
 		/* Check for synchronous or asynchronous exceptions */
 		if (!(fpexc & (FPEXC_EX | FPEXC_DEX))) {
@@ -794,14 +794,14 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 			if (!(fpscr & FPSCR_IXE)) {
 				if (!(fpscr & FPSCR_LENGTH_MASK)) {
 					pr_debug("not VFP\n");
-					vfp_unlock();
+					vfp_state_release();
 					return -ENOEXEC;
 				}
 				fpexc |= FPEXC_DEX;
 			}
 		}
 bounce:		regs->ARM_pc += 4;
-		/* VFP_bounce() will invoke vfp_unlock() */
+		/* VFP_bounce() will invoke vfp_state_release() */
 		VFP_bounce(trigger, fpexc, regs);
 	}
 
@@ -869,7 +869,7 @@ void kernel_neon_begin(void)
 	unsigned int cpu;
 	u32 fpexc;
 
-	vfp_lock();
+	vfp_state_hold();
 
 	/*
 	 * Kernel mode NEON is only allowed outside of hardirq context with
@@ -900,7 +900,7 @@ void kernel_neon_end(void)
 {
 	/* Disable the NEON/VFP unit. */
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	vfp_unlock();
+	vfp_state_release();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3b766538e75e2..3516c58480612 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
@@ -174,7 +175,6 @@ config RISCV
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL
-	select HAVE_PREEMPT_AUTO
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 4b80fbde5a913..f5916a70879a8 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,10 +107,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_ARCH_RESCHED_LAZY	0	/* Lazy rescheduling */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
+#define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
@@ -118,10 +118,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
 
-#define _TIF_ARCH_RESCHED_LAZY	(1 << TIF_ARCH_RESCHED_LAZY)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5d80802088950..b76aa7f207109 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
@@ -284,7 +285,6 @@ config X86
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
-	select HAVE_PREEMPT_AUTO
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 38e2cf05525e3..75bb390f7baf5 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,7 +87,7 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_ARCH_RESCHED_LAZY	4	/* Lazy rescheduling */
+#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
 #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
 #define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
@@ -111,7 +111,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_ARCH_RESCHED_LAZY	(1 << TIF_ARCH_RESCHED_LAZY)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5af3ebec0f74a..831fa4a121598 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -107,7 +107,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
  */
 static void __cpuidle acpi_safe_halt(void)
 {
-	if (!need_resched()) {
+	if (!tif_need_resched()) {
 		raw_safe_halt();
 		raw_local_irq_disable();
 	}
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f0902dd585534..fc61d0205c970 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -64,8 +64,9 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 674a622c91be2..16149f6625e48 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -17,8 +17,9 @@
 #endif
 
 #define XFER_TO_GUEST_MODE_WORK						\
-	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
+	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
+	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
+	 ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 750f568d18b10..4a4f367cd6864 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -625,7 +625,7 @@ extern void raise_hrtimer_softirq(void);
 
 static inline unsigned int local_pending_timers(void)
 {
-        return __this_cpu_read(pending_timer_softirq);
+	return __this_cpu_read(pending_timer_softirq);
 }
 
 #else
@@ -641,7 +641,7 @@ static inline void raise_hrtimer_softirq(void)
 
 static inline unsigned int local_pending_timers(void)
 {
-        return local_softirq_pending();
+	return local_softirq_pending();
 }
 #endif
 
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index b6321fc491598..52b5ea663b9f0 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -41,7 +41,11 @@
 					 PCPU_MIN_ALLOC_SHIFT)
 
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
-#define PERCPU_DYNAMIC_SIZE_SHIFT      12
+# if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PAGE_SIZE_4KB)
+# define PERCPU_DYNAMIC_SIZE_SHIFT      13
+# else
+# define PERCPU_DYNAMIC_SIZE_SHIFT      12
+#endif /* LOCKDEP and PAGE_SIZE > 4KiB */
 #else
 #define PERCPU_DYNAMIC_SIZE_SHIFT      10
 #endif
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ce76f1a457225..e4b1c3e11133c 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -486,6 +486,8 @@ DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
 extern bool preempt_model_full(void);
+extern bool preempt_model_lazy(void);
+extern bool preempt_model_laziest(void);
 
 #else
 
@@ -502,6 +504,15 @@ static inline bool preempt_model_full(void)
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
 
+static inline bool preempt_model_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
+}
+static inline bool preempt_model_laziest(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZIEST);
+}
+
 #endif
 
 static inline bool preempt_model_rt(void)
@@ -519,7 +530,10 @@ static inline bool preempt_model_rt(void)
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_rt();
+	return preempt_model_full() ||
+	       preempt_model_lazy() ||
+	       preempt_model_laziest() ||
+	       preempt_model_rt();
 }
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2016534bbc533..0053f06648470 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1980,17 +1980,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -2002,12 +2002,11 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
-	if (IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO))
-		clear_tsk_thread_flag(tsk, TIF_NEED_RESCHED_LAZY);
+	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
-static inline bool test_tsk_need_resched(struct task_struct *tsk)
+static inline int test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
@@ -2107,7 +2106,7 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched_lazy() || tif_need_resched());
+	return unlikely(tif_need_resched());
 }
 
 /*
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 00fed88e7671b..e670ac282333e 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(need_resched());
+	return unlikely(tif_need_resched());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(need_resched());
+	return unlikely(tif_need_resched());
 }
 
 #else
@@ -85,11 +85,11 @@ static inline void __current_clr_polling(void) { }
 
 static inline bool __must_check current_set_polling_and_test(void)
 {
-	return unlikely(need_resched());
+	return unlikely(tif_need_resched());
 }
 static inline bool __must_check current_clr_polling_and_test(void)
 {
-	return unlikely(need_resched());
+	return unlikely(tif_need_resched());
 }
 #endif
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 5ded1450ac1a1..cf2446c9c30d4 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,14 +59,12 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_PREEMPT_BUILD_AUTO
-# define TIF_NEED_RESCHED_LAZY		TIF_ARCH_RESCHED_LAZY
-# define _TIF_NEED_RESCHED_LAZY		_TIF_ARCH_RESCHED_LAZY
-# define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
-#else
-# define TIF_NEED_RESCHED_LAZY		TIF_NEED_RESCHED
-# define _TIF_NEED_RESCHED_LAZY		_TIF_NEED_RESCHED
-# define TIF_NEED_RESCHED_LAZY_OFFSET	0
+#ifndef TIF_NEED_RESCHED_LAZY
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+#error Inconsistent PREEMPT_LAZY
+#endif
+#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
 #ifdef __KERNEL__
@@ -189,36 +187,27 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
+	return arch_test_bit(bit,
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
-static __always_inline bool tif_need_resched_lazy(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) &&
-		arch_test_bit(TIF_NEED_RESCHED_LAZY,
-			      (unsigned long *)(&current_thread_info()->flags));
-}
-
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return test_bit(TIF_NEED_RESCHED,
+	return test_bit(bit,
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
-static __always_inline bool tif_need_resched_lazy(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) &&
-		test_bit(TIF_NEED_RESCHED_LAZY,
-			 (unsigned long *)(&current_thread_info()->flags));
-}
-
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
+static __always_inline bool tif_need_resched(void)
+{
+	return tif_test_bit(TIF_NEED_RESCHED);
+}
+
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 75def393bd4f2..8cf8a9a4d868c 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,11 +11,7 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
-config PREEMPT_BUILD_AUTO
-	bool
-	select PREEMPT_BUILD
-
-config HAVE_PREEMPT_AUTO
+config ARCH_HAS_PREEMPT_LAZY
 	bool
 
 choice
@@ -24,6 +20,7 @@ choice
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
+	depends on !PREEMPT_RT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -39,6 +36,7 @@ config PREEMPT_NONE
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	depends on !PREEMPT_RT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
@@ -58,7 +56,7 @@ config PREEMPT_VOLUNTARY
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_BUILD
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -74,17 +72,35 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
-config PREEMPT_AUTO
-	bool "Automagic preemption mode with runtime tweaking support"
-	depends on HAVE_PREEMPT_AUTO
-	select PREEMPT_BUILD_AUTO
+config PREEMPT_LAZY
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
-	  Add some sensible blurb here
+	  This option provides a scheduler driven preemption model that
+	  is fundamentally similar to full preemption, but is less
+	  eager to preempt SCHED_NORMAL tasks in an attempt to
+	  reduce lock holder preemption and recover some of the performance
+	  gains seen from using Voluntary preemption.
+
+config PREEMPT_LAZIEST
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
+	help
+	  This option provides a scheduler driven preemption model that
+	  is fundamentally similar to full preemption, but is least
+	  eager to preempt SCHED_NORMAL tasks in an attempt to
+	  reduce lock holder preemption and recover some of the performance
+	  gains seen from using no preemption.
+
+endchoice
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
-	select PREEMPT_BUILD_AUTO if HAVE_PREEMPT_AUTO
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -99,8 +115,6 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
 
-endchoice
-
 config PREEMPT_COUNT
        bool
 
@@ -110,7 +124,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
+	depends on HAVE_PREEMPT_DYNAMIC
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index c204e22e6aef6..e33691d5adf7a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -307,7 +307,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (test_tsk_need_resched(current))
+		if (need_resched())
 			preempt_schedule_irq();
 	}
 }
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index d952fa5ee8801..8485f63863afc 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & (_TIF_NEED_RESCHED | TIF_NEED_RESCHED_LAZY))
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 91d250a0e039b..694bfcf153cb0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -932,15 +932,13 @@ static inline void hrtick_rq_init(struct rq *rq)
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	struct thread_info *ti = task_thread_info(p);
-
-	return !(fetch_or(&ti->flags, 1 << tif_bit) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, 1 << tif) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -957,7 +955,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 	do {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
-		if (val & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (val & _TIF_NEED_RESCHED)
 			return true;
 	} while (!try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED));
 
@@ -965,9 +963,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	set_tsk_thread_flag(p, tif_bit);
+	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);
 	return true;
 }
 
@@ -1072,27 +1070,31 @@ void wake_up_q(struct wake_q_head *head)
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-static void __resched_curr(struct rq *rq, int lazy)
+static void __resched_curr(struct rq *rq, int tif)
 {
-	int cpu, tif_bit = TIF_NEED_RESCHED + lazy;
 	struct task_struct *curr = rq->curr;
+	struct thread_info *cti = task_thread_info(curr);
+	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (unlikely(test_tsk_thread_flag(curr, tif_bit)))
+	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
+		tif = TIF_NEED_RESCHED;
+
+	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_thread_flag(curr, tif_bit);
-		if (!lazy)
+		set_ti_thread_flag(cti, tif);
+		if (tif == TIF_NEED_RESCHED)
 			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr, tif_bit)) {
-		if (!lazy)
+	if (set_nr_and_not_polling(cti, tif)) {
+		if (tif == TIF_NEED_RESCHED)
 			smp_send_reschedule(cpu);
 	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -1101,18 +1103,42 @@ static void __resched_curr(struct rq *rq, int lazy)
 
 void resched_curr(struct rq *rq)
 {
-	__resched_curr(rq, 0);
+	__resched_curr(rq, TIF_NEED_RESCHED);
+}
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_promote);
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
+}
+static __always_inline bool dynamic_preempt_promote(void)
+{
+	return static_branch_unlikely(&sk_dynamic_preempt_promote);
+}
+#else
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return IS_ENABLED(PREEMPT_LAZY) | IS_ENABLED(PREEMPT_LAZIEST);
+}
+static __always_inline bool dynamic_preempt_promote(void)
+{
+	return IS_ENABLED(PREEMPT_LAZY);
+}
+#endif
+
+static __always_inline int tif_need_resched_lazy(void)
+{
+	if (dynamic_preempt_lazy())
+		return TIF_NEED_RESCHED_LAZY;
+
+	return TIF_NEED_RESCHED;
 }
 
 void resched_curr_lazy(struct rq *rq)
 {
-	int lazy = IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) && !sched_feat(FORCE_NEED_RESCHED) ?
-		TIF_NEED_RESCHED_LAZY_OFFSET : 0;
-
-	if (lazy && unlikely(test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED)))
-		return;
-
-	__resched_curr(rq, lazy);
+	__resched_curr(rq, tif_need_resched_lazy());
 }
 
 void resched_cpu(int cpu)
@@ -1207,7 +1233,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle, TIF_NEED_RESCHED))
+	if (set_nr_and_not_polling(task_thread_info(rq->idle), TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -5610,6 +5636,10 @@ void sched_tick(void)
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
+
+	if (dynamic_preempt_promote() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		resched_curr(rq);
+
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
@@ -7346,6 +7376,8 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
  *
  * VOLUNTARY:
  *   cond_resched               <- __cond_resched
@@ -7353,6 +7385,8 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
  *
  * FULL:
  *   cond_resched               <- RET0
@@ -7360,6 +7394,26 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- preempt_schedule
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
+ *
+ * LAZY:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- true
+ *   dynamic_preempt_promote    <- true
+ *
+ * LAZIEST:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- true
+ *   dynamic_preempt_promote    <- false
  */
 
 enum {
@@ -7367,30 +7421,45 @@ enum {
 	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
+	preempt_dynamic_lazy,
+	preempt_dynamic_laziest,
 };
 
 int preempt_dynamic_mode = preempt_dynamic_undefined;
 
 int sched_dynamic_mode(const char *str)
 {
+#ifndef CONFIG_PREEMPT_RT
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
 		return preempt_dynamic_voluntary;
+#endif
 
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+	if (!strcmp(str, "lazy"))
+		return preempt_dynamic_lazy;
+
+	if (!strcmp(str, "laziest"))
+		return preempt_dynamic_laziest;
+#endif
+
 	return -EINVAL;
 }
 
+#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
-#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
+#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
 #else
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
@@ -7410,6 +7479,8 @@ static void __sched_dynamic_update(int mode)
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
 	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_key_disable(preempt_lazy);
+	preempt_dynamic_key_disable(preempt_promote);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -7419,6 +7490,8 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: none\n");
 		break;
@@ -7430,6 +7503,8 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: voluntary\n");
 		break;
@@ -7441,9 +7516,37 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: full\n");
 		break;
+
+	case preempt_dynamic_lazy:
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_enable(preempt_lazy);
+		preempt_dynamic_key_enable(preempt_promote);
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: lazy\n");
+		break;
+
+	case preempt_dynamic_laziest:
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_enable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: laziest\n");
+		break;
 	}
 
 	preempt_dynamic_mode = mode;
@@ -7506,6 +7609,10 @@ static void __init preempt_dynamic_init(void)
 			sched_dynamic_update(preempt_dynamic_none);
 		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			sched_dynamic_update(preempt_dynamic_lazy);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZIEST)) {
+			sched_dynamic_update(preempt_dynamic_laziest);
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
@@ -7526,6 +7633,8 @@ static void __init preempt_dynamic_init(void)
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
+PREEMPT_MODEL_ACCESSOR(lazy);
+PREEMPT_MODEL_ACCESSOR(laziest);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8b5ad6c4a85c2..9abcc6ead11ba 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,11 +245,12 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
+		"none", "voluntary", "full", "lazy", "laziest",
 	};
-	int i;
+	int j = ARRAY_SIZE(preempt_modes) - 2*!IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
+	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
 
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+	for (; i < j; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);
@@ -469,23 +470,6 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
-static ssize_t sched_hog_write(struct file *filp, const char __user *ubuf,
-			       size_t cnt, loff_t *ppos)
-{
-	unsigned long end = jiffies + 60 * HZ;
-
-	for (; time_before(jiffies, end) && !signal_pending(current);)
-		cpu_relax();
-
-	return cnt;
-}
-
-static const struct file_operations sched_hog_fops = {
-	.write		= sched_hog_write,
-	.open		= simple_open,
-	.llseek		= default_llseek,
-};
-
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -548,8 +532,6 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
-	debugfs_create_file("hog", 0200, debugfs_sched, NULL, &sched_hog_fops);
-
 	debugfs_fair_server_init();
 
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 543ae044bf9bc..57c8f6bbcbb8c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1213,7 +1213,7 @@ s64 update_curr_common(struct rq *rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
+static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rq *rq = rq_of(cfs_rq);
@@ -1250,25 +1250,12 @@ static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
 	if (rq->nr_running == 1)
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) || sched_feat(FORCE_NEED_RESCHED)) {
-		if (resched || did_preempt_short(cfs_rq, curr)) {
-			resched_curr(rq);
-			clear_buddies(cfs_rq, curr);
-		}
-	} else {
-		if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
-			resched_curr(rq);
-		else
-			resched_curr_lazy(rq);
+	if (resched || did_preempt_short(cfs_rq, curr)) {
+		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}
 }
 
-static void update_curr(struct cfs_rq *cfs_rq)
-{
-	__update_curr(cfs_rq, false);
-}
-
 static void update_curr_fair(struct rq *rq)
 {
 	update_curr(cfs_rq_of(&rq->curr->se));
@@ -5676,7 +5663,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	__update_curr(cfs_rq, true);
+	update_curr(cfs_rq);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
@@ -5836,7 +5823,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	 * hierarchy can be throttled
 	 */
 	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
-		resched_curr_lazy(rq_of(cfs_rq));
+		resched_curr(rq_of(cfs_rq));
 }
 
 static __always_inline
@@ -6117,7 +6104,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
-		resched_curr_lazy(rq);
+		resched_curr(rq);
 }
 
 #ifdef CONFIG_SMP
@@ -6832,7 +6819,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 		if (delta < 0) {
 			if (task_current(rq, p))
-				resched_curr_lazy(rq);
+				resched_curr(rq);
 			return;
 		}
 		hrtick_start(rq, delta);
@@ -8797,7 +8784,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (need_resched())
+	if (test_tsk_need_resched(curr))
 		return;
 
 	if (!sched_feat(WAKEUP_PREEMPTION))
@@ -12946,7 +12933,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
-		resched_curr_lazy(rq);
+		resched_curr(rq);
 }
 
 /*
@@ -13098,7 +13085,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 */
 	if (task_current(rq, p)) {
 		if (p->prio > oldprio)
-			resched_curr_lazy(rq);
+			resched_curr(rq);
 	} else
 		wakeup_preempt(rq, p, 0);
 }
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 5abb48aeedbd9..290874079f60d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -113,5 +113,3 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
-
-SCHED_FEAT(FORCE_NEED_RESCHED, false)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index db4116ef040b5..d2f096bb274c3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,7 +57,8 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!need_resched() && (cpu_idle_force_poll || tick_check_broadcast_expired()))
+	while (!tif_need_resched() &&
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0052bd4d9ec1d..2d847405e5a7f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -630,10 +630,10 @@ DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
 
 static void wake_timersd(void)
 {
-        struct task_struct *tsk = __this_cpu_read(timersd);
+	struct task_struct *tsk = __this_cpu_read(timersd);
 
-        if (tsk)
-                wake_up_process(tsk);
+	if (tsk)
+		wake_up_process(tsk);
 }
 
 #else
@@ -996,12 +996,12 @@ static struct smp_hotplug_thread softirq_threads = {
 #ifdef CONFIG_PREEMPT_RT
 static void timersd_setup(unsigned int cpu)
 {
-        sched_set_fifo_low(current);
+	sched_set_fifo_low(current);
 }
 
 static int timersd_should_run(unsigned int cpu)
 {
-        return local_pending_timers();
+	return local_pending_timers();
 }
 
 static void run_timersd(unsigned int cpu)
@@ -1041,11 +1041,11 @@ void raise_timer_softirq(void)
 }
 
 static struct smp_hotplug_thread timer_threads = {
-        .store                  = &timersd,
-        .setup                  = timersd_setup,
-        .thread_should_run      = timersd_should_run,
-        .thread_fn              = run_timersd,
-        .thread_comm            = "ktimers/%u",
+	.store			= &timersd,
+	.setup			= timersd_setup,
+	.thread_should_run	= timersd_should_run,
+	.thread_fn		= run_timersd,
+	.thread_comm		= "ktimers/%u",
 };
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 049dc43bf79f0..fb839d00aad12 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2542,10 +2542,10 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 
 	if (tif_need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
-	if (tif_need_resched_lazy())
-		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index c83a76dd51053..23ca2155306b1 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -480,12 +480,12 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
-	case TRACE_FLAG_NEED_RESCHED_LAZY:
-		need_resched = 'l';
-		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	default:
 		need_resched = '.';
 		break;
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
