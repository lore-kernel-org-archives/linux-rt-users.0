Return-Path: <SRS0=XVUn=SO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89360C282CE
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Apr 2019 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFB72171F
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Apr 2019 21:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDLVXf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:23:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLVXe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Apr 2019 17:23:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hF3dh-0005iM-PR; Fri, 12 Apr 2019 23:23:13 +0200
Date:   Fri, 12 Apr 2019 23:23:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.7-rt5
Message-ID: <20190412212313.blex53rgtd3qyg77@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.7-rt5 patch set. 

Changes since v5.0.7-rt4:

  - Update "x86: load FPU registers on return to userland" from v7 to
    v9.

  - Update "clocksource: improve Atmel TCB timer driver" from v7 to
    latest post by Alexandre Belloni. I hope this works, my HW refuses
    to cooperate so I can't verify.

  - Avoid allocating a spin lock with disabled interrupts in i915.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.7-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.7-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.7-rt5

The RT patch against v5.0.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.7-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.7-rt5.tar.xz

Sebastian

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index f4b253bd05ede..c8876d0ca41a8 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -65,6 +65,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index c2dc35dfb3215..10ebc9481f72c 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -76,6 +76,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index fa493a86e2bb3..da1d97a06c53a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -121,10 +121,8 @@ config ATMEL_CLOCKSOURCE_PIT
 
 config ATMEL_CLOCKSOURCE_TCB
 	bool "Timer Counter Blocks (TCB) support"
-	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5 || COMPILE_TEST
 	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
-	depends on !ATMEL_TCLIB
-	select ATMEL_ARM_TCB_CLKSRC
+	select ATMEL_TCB_CLKSRC
 	help
 	  Select this to get a high precision clocksource based on a
 	  TC block with a 5+ MHz base clock rate.
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 749ee389a1178..33e2294b5a675 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include <asm/user.h>
 #include <asm/fpu/api.h>
@@ -120,7 +121,7 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 	err;								\
 })
 
-#define kernel_insn_norestore(insn, output, input...)			\
+#define kernel_insn_err(insn, output, input...)				\
 ({									\
 	int err;							\
 	asm volatile("1:" #insn "\n\t"					\
@@ -141,6 +142,22 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
+static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+{
+	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
+}
+
+static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
+	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
+		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
+
+	/* See comment in copy_fxregs_to_kernel() below. */
+	return user_insn(rex64/fxsave (%[fx]), "=m" (*fx), [fx] "R" (fx));
+}
+
 static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32)) {
@@ -155,15 +172,23 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 	}
 }
 
-static inline int copy_users_to_fxregs(struct fxregs_state *fx)
+static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
-		return kernel_insn_norestore(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	else
+		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
-		return kernel_insn_norestore(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 
 	/* See comment in copy_fxregs_to_kernel() below. */
-	return kernel_insn_norestore(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
+	return user_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
 			  "m" (*fx));
 }
 
@@ -172,9 +197,14 @@ static inline void copy_kernel_to_fregs(struct fregs_state *fx)
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_users_to_fregs(struct fregs_state *fx)
+static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
 {
-	return kernel_insn_norestore(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+{
+	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
@@ -351,11 +381,57 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
+/*
+ * Save xstate to user space xsave area.
+ *
+ * We don't use modified optimization because xrstor/xrstors might track
+ * a different application.
+ *
+ * We don't use compacted format xsave area for
+ * backward compatibility for old applications which don't understand
+ * compacted format of xsave area.
+ */
+static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+{
+	int err;
+
+	/*
+	 * Clear the xsave header first, so that reserved fields are
+	 * initialized to zero.
+	 */
+	err = __clear_user(&buf->header, sizeof(buf->header));
+	if (unlikely(err))
+		return -EFAULT;
+
+	stac();
+	XSTATE_OP(XSAVE, buf, -1, -1, err);
+	clac();
+
+	return err;
+}
+
+/*
+ * Restore xstate from user space xsave area.
+ */
+static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+{
+	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	stac();
+	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	clac();
+
+	return err;
+}
+
 /*
  * Restore xstate from kernel space xsave area, return an error code instead an
  * exception.
  */
-static inline int copy_users_to_xregs(struct xregs_state *xstate, u64 mask)
+static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
@@ -544,7 +620,7 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
 	struct pkru_state *pk;
-	u32 pkru_val = 0;
+	u32 pkru_val = init_pkru_value;
 
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
@@ -554,9 +630,12 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
+	/*
+	 * PKRU state is switched eagerly because it needs to be valid before we
+	 * return to userland e.g. for a copy_to_user() operation.
+	 */
 	if (current->mm) {
 		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		WARN_ON_ONCE(!pk);
 		if (pk)
 			pkru_val = pk->pkru;
 	}
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 50a8399d223e9..58a3a68e1f114 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -129,7 +129,7 @@ static inline int pte_dirty(pte_t pte)
 static inline u32 read_pkru(void)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return __read_pkru();
+		return __read_pkru_ins();
 	return 0;
 }
 
@@ -1371,6 +1371,12 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 #define PKRU_WD_BIT 0x2
 #define PKRU_BITS_PER_PKEY 2
 
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+extern u32 init_pkru_value;
+#else
+#define init_pkru_value	0
+#endif
+
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
 	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2d3adeb268e38..28ffdf0c1add4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -92,7 +92,7 @@ static inline void native_write_cr8(unsigned long val)
 #endif
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-static inline u32 __read_pkru(void)
+static inline u32 __read_pkru_ins(void)
 {
 	u32 ecx = 0;
 	u32 edx, pkru;
@@ -107,16 +107,10 @@ static inline u32 __read_pkru(void)
 	return pkru;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void __write_pkru_ins(u32 pkru)
 {
 	u32 ecx = 0, edx = 0;
 
-	/*
-	 * WRPKRU is relatively expensive compared to RDPKRU.
-	 * Avoid WRPKRU when it would not change the value.
-	 */
-	if (pkru == __read_pkru())
-		return;
 	/*
 	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
 	 * requires that ecx = edx = 0.
@@ -124,8 +118,20 @@ static inline void __write_pkru(u32 pkru)
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
+
+static inline void __write_pkru(u32 pkru)
+{
+	/*
+	 * WRPKRU is relatively expensive compared to RDPKRU.
+	 * Avoid WRPKRU when it would not change the value.
+	 */
+	if (pkru == __read_pkru_ins())
+		return;
+	__write_pkru_ins(pkru);
+}
+
 #else
-static inline u32 __read_pkru(void)
+static inline u32 __read_pkru_ins(void)
 {
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659a..352fa19e63110 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -372,6 +372,8 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
+	struct pkru_state *pk;
+
 	/* check the boot processor, plus compile options for PKU: */
 	if (!cpu_feature_enabled(X86_FEATURE_PKU))
 		return;
@@ -382,6 +384,9 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 		return;
 
 	cr4_set_bits(X86_CR4_PKE);
+	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
+	if (pk)
+		pk->pkru = init_pkru_value;
 	/*
 	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 589fb27515e08..16f700d5b3a47 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -118,6 +118,22 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	return err;
 }
 
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+{
+	int err;
+
+	if (use_xsave())
+		err = copy_xregs_to_user(buf);
+	else if (use_fxsr())
+		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
+	else
+		err = copy_fregs_to_user((struct fregs_state __user *) buf);
+
+	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
+		err = -EFAULT;
+	return err;
+}
+
 /*
  * Save the fpu, extended register state to the user signal frame.
  *
@@ -128,8 +144,10 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Save the state to task's fpu->state and then copy it to the user frame
- * pointed by the aligned pointer 'buf_fx'.
+ * Try to save it directly to the user frame with disabled page fault handler.
+ * If this fails then do the slow path where the FPU state is first saved to
+ * task's fpu->state and then copy it to the user frame pointed by the aligned
+ * pointer 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -143,6 +161,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
+	int ret = -EFAULT;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -157,21 +176,31 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	fpregs_lock();
 	/*
-	 * If we do not need to load the FPU registers at return to userspace
-	 * then the CPU has the current state and we need to save it. Otherwise
-	 * it is already done and we can skip it.
+	 * Load the FPU register if they are not valid for the current task.
+	 * With a valid FPU state we can attempt to save the state directly to
+	 * userland's stack frame which will likely succeed. If it does not, do
+	 * the slowpath.
 	 */
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-		copy_fpregs_to_fpstate(fpu);
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
 
+	pagefault_disable();
+	ret = copy_fpregs_to_sigframe(buf_fx);
+	pagefault_enable();
+	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
+		copy_fpregs_to_fpstate(fpu);
+	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
-	if (using_compacted_format()) {
-		copy_xstate_to_user(buf_fx, xsave, 0, size);
-	} else {
-		fpstate_sanitize_xstate(fpu);
-		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-			return -1;
+	if (ret) {
+		if (using_compacted_format()) {
+			if (copy_xstate_to_user(buf_fx, xsave, 0, size))
+				return -1;
+		} else {
+			fpstate_sanitize_xstate(fpu);
+			if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+				return -1;
+		}
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
@@ -221,6 +250,28 @@ sanitize_restored_xstate(union fpregs_state *state,
 	}
 }
 
+/*
+ * Restore the extended state if present. Otherwise, restore the FP/SSE state.
+ */
+static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+{
+	if (use_xsave()) {
+		if (fx_only) {
+			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			return copy_user_to_fxregs(buf);
+		} else {
+			u64 init_bv = xfeatures_mask & ~xbv;
+			if (unlikely(init_bv))
+				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			return copy_user_to_xregs(buf, xbv);
+		}
+	} else if (use_fxsr()) {
+		return copy_user_to_fxregs(buf);
+	} else
+		return copy_user_to_fregs(buf);
+}
+
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 {
 	struct user_i387_ia32_struct *envp = NULL;
@@ -287,7 +338,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (ret)
 			goto err_out;
 		envp = &env;
+	} else {
+		fpregs_lock();
+		pagefault_disable();
+		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
+		pagefault_enable();
+		if (!ret) {
+			fpregs_mark_activate();
+			fpregs_unlock();
+			return 0;
+		}
+		fpregs_unlock();
 	}
+
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask & ~xfeatures;
 
@@ -307,7 +370,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_users_to_xregs(&fpu->state.xsave, xfeatures);
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures);
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
@@ -324,13 +387,13 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
-		ret = copy_users_to_fxregs(&fpu->state.fxsave);
+		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)
 			goto err_out;
 		fpregs_lock();
-		ret = copy_users_to_fregs(buf_fx);
+		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
 	}
 	if (!ret)
 		fpregs_mark_activate();
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a0a7708164291..eb694a0f7a22f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6630,7 +6630,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
-		vcpu->arch.pkru = __read_pkru();
+		vcpu->arch.pkru = __read_pkru_ins();
 		if (vcpu->arch.pkru != vmx->host_pkru)
 			__write_pkru(vmx->host_pkru);
 	}
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 50f65fc1b9a3f..1dcfc91c8f0c3 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -18,6 +18,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -126,7 +127,6 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-static
 u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
 		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
@@ -162,6 +162,7 @@ static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
+	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -184,6 +185,10 @@ static ssize_t init_pkru_write_file(struct file *file,
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
+	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
+	if (!pk)
+		return -EINVAL;
+	pk->pkru = new_init_pkru;
 	return count;
 }
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 75990b60b72ca..cbf800096fdf5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -398,11 +398,11 @@ config ARMV7M_SYSTICK
 	  This options enables support for the ARMv7M system timer unit
 
 config ATMEL_PIT
-	bool "Microchip ARM Periodic Interval Timer (PIT)" if COMPILE_TEST
+	bool "Atmel PIT support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF if OF
 	help
-	  This enables build of clocksource and clockevent driver for
-	  the integrated PIT in Microchip ARM SoCs.
+	  Support for the Periodic Interval Timer found on Atmel SoCs.
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
@@ -412,13 +412,19 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
-config ATMEL_ARM_TCB_CLKSRC
-	bool "Microchip ARM TC Block" if COMPILE_TEST
-	select REGMAP_MMIO
-	depends on GENERIC_CLOCKEVENTS
+config ATMEL_TCB_CLKSRC
+	bool "Atmel TC Block timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF if OF
 	help
-	  This enables build of clocksource and clockevent driver for
-	  the integrated Timer Counter Blocks in Microchip ARM SoCs.
+	  Support for Timer Counter Blocks on Atmel SoCs.
+
+config ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+	bool "TC Block use 32 KiHz clock"
+	depends on ATMEL_TCB_CLKSRC
+	default y
+	help
+	  Select this to use 32 KiHz base clock rate as TC block clock.
 
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4089469eee166..c93bd598955fb 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,8 +3,7 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
-obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcb.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= timer-atmel-tcb.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
deleted file mode 100644
index ba15242a60665..0000000000000
--- a/drivers/clocksource/tcb_clksrc.c
+++ /dev/null
@@ -1,464 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/syscore_ops.h>
-#include <linux/atmel_tc.h>
-
-
-/*
- * We're configured to use a specific TC block, one that's not hooked
- * up to external hardware, to provide a time solution:
- *
- *   - Two channels combine to create a free-running 32 bit counter
- *     with a base rate of 5+ MHz, packaged as a clocksource (with
- *     resolution better than 200 nsec).
- *   - Some chips support 32 bit counter. A single channel is used for
- *     this 32 bit free-running counter. the second channel is not used.
- *
- *   - The third channel may be used to provide a 16-bit clockevent
- *     source, used in either periodic or oneshot mode.
- *
- * A boot clocksource and clockevent source are also currently needed,
- * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
- * this code can be used when init_timers() is called, well before most
- * devices are set up.  (Some low end AT91 parts, which can run uClinux,
- * have only the timers in one TC block... they currently don't support
- * the tclib code, because of that initialization issue.)
- *
- * REVISIT behavior during system suspend states... we should disable
- * all clocks and save the power.  Easily done for clockevent devices,
- * but clocksources won't necessarily get the needed notifications.
- * For deeper system sleep states, this will be mandatory...
- */
-
-static void __iomem *tcaddr;
-static struct
-{
-	u32 cmr;
-	u32 imr;
-	u32 rc;
-	bool clken;
-} tcb_cache[3];
-static u32 bmr_cache;
-
-static u64 tc_get_cycles(struct clocksource *cs)
-{
-	unsigned long	flags;
-	u32		lower, upper;
-
-	raw_local_irq_save(flags);
-	do {
-		upper = readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV));
-		lower = readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
-	} while (upper != readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV)));
-
-	raw_local_irq_restore(flags);
-	return (upper << 16) | lower;
-}
-
-static u64 tc_get_cycles32(struct clocksource *cs)
-{
-	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
-}
-
-void tc_clksrc_suspend(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
-		tcb_cache[i].cmr = readl(tcaddr + ATMEL_TC_REG(i, CMR));
-		tcb_cache[i].imr = readl(tcaddr + ATMEL_TC_REG(i, IMR));
-		tcb_cache[i].rc = readl(tcaddr + ATMEL_TC_REG(i, RC));
-		tcb_cache[i].clken = !!(readl(tcaddr + ATMEL_TC_REG(i, SR)) &
-					ATMEL_TC_CLKSTA);
-	}
-
-	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
-}
-
-void tc_clksrc_resume(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
-		/* Restore registers for the channel, RA and RB are not used  */
-		writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));
-		writel(tcb_cache[i].rc, tcaddr + ATMEL_TC_REG(i, RC));
-		writel(0, tcaddr + ATMEL_TC_REG(i, RA));
-		writel(0, tcaddr + ATMEL_TC_REG(i, RB));
-		/* Disable all the interrupts */
-		writel(0xff, tcaddr + ATMEL_TC_REG(i, IDR));
-		/* Reenable interrupts that were enabled before suspending */
-		writel(tcb_cache[i].imr, tcaddr + ATMEL_TC_REG(i, IER));
-		/* Start the clock if it was used */
-		if (tcb_cache[i].clken)
-			writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(i, CCR));
-	}
-
-	/* Dual channel, chain channels */
-	writel(bmr_cache, tcaddr + ATMEL_TC_BMR);
-	/* Finally, trigger all the channels*/
-	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
-}
-
-static struct clocksource clksrc = {
-	.name           = "tcb_clksrc",
-	.rating         = 200,
-	.read           = tc_get_cycles,
-	.mask           = CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.suspend	= tc_clksrc_suspend,
-	.resume		= tc_clksrc_resume,
-};
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-
-struct tc_clkevt_device {
-	struct clock_event_device	clkevt;
-	struct clk			*clk;
-	bool				clk_enabled;
-	u32				freq;
-	void __iomem			*regs;
-};
-
-static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
-{
-	return container_of(clkevt, struct tc_clkevt_device, clkevt);
-}
-
-static u32 timer_clock;
-
-static void tc_clk_disable(struct clock_event_device *d)
-{
-	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
-
-	clk_disable(tcd->clk);
-	tcd->clk_enabled = false;
-}
-
-static void tc_clk_enable(struct clock_event_device *d)
-{
-	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
-
-	if (tcd->clk_enabled)
-		return;
-	clk_enable(tcd->clk);
-	tcd->clk_enabled = true;
-}
-
-static int tc_shutdown(struct clock_event_device *d)
-{
-	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
-	void __iomem		*regs = tcd->regs;
-
-	writel(0xff, regs + ATMEL_TC_REG(2, IDR));
-	writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
-	return 0;
-}
-
-static int tc_shutdown_clk_off(struct clock_event_device *d)
-{
-	tc_shutdown(d);
-	if (!clockevent_state_detached(d))
-		tc_clk_disable(d);
-
-	return 0;
-}
-
-static int tc_set_oneshot(struct clock_event_device *d)
-{
-	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
-	void __iomem		*regs = tcd->regs;
-
-	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_shutdown(d);
-
-	tc_clk_enable(d);
-
-	/* count up to RC, then irq and stop */
-	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
-		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
-	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
-
-	/* set_next_event() configures and starts the timer */
-	return 0;
-}
-
-static int tc_set_periodic(struct clock_event_device *d)
-{
-	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
-	void __iomem		*regs = tcd->regs;
-
-	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_shutdown(d);
-
-	/* By not making the gentime core emulate periodic mode on top
-	 * of oneshot, we get lower overhead and improved accuracy.
-	 */
-	tc_clk_enable(d);
-
-	/* count up to RC, then irq and restart */
-	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
-		     regs + ATMEL_TC_REG(2, CMR));
-	writel((tcd->freq + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
-
-	/* Enable clock and interrupts on RC compare */
-	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
-
-	/* go go gadget! */
-	writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG, regs +
-		     ATMEL_TC_REG(2, CCR));
-	return 0;
-}
-
-static int tc_next_event(unsigned long delta, struct clock_event_device *d)
-{
-	writel_relaxed(delta, tcaddr + ATMEL_TC_REG(2, RC));
-
-	/* go go gadget! */
-	writel_relaxed(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-			tcaddr + ATMEL_TC_REG(2, CCR));
-	return 0;
-}
-
-static struct tc_clkevt_device clkevt = {
-	.clkevt	= {
-		.name			= "tc_clkevt",
-		.features		= CLOCK_EVT_FEAT_PERIODIC |
-					  CLOCK_EVT_FEAT_ONESHOT,
-		/* Should be lower than at91rm9200's system timer */
-#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
-		.rating			= 125,
-#else
-		.rating			= 200,
-#endif
-		.set_next_event		= tc_next_event,
-		.set_state_shutdown	= tc_shutdown_clk_off,
-		.set_state_periodic	= tc_set_periodic,
-		.set_state_oneshot	= tc_set_oneshot,
-	},
-};
-
-static irqreturn_t ch2_irq(int irq, void *handle)
-{
-	struct tc_clkevt_device	*dev = handle;
-	unsigned int		sr;
-
-	sr = readl_relaxed(dev->regs + ATMEL_TC_REG(2, SR));
-	if (sr & ATMEL_TC_CPCS) {
-		dev->clkevt.event_handler(&dev->clkevt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
-{
-	unsigned divisor = atmel_tc_divisors[divisor_idx];
-	int ret;
-	struct clk *t2_clk = tc->clk[2];
-	int irq = tc->irq[2];
-
-	ret = clk_prepare_enable(tc->slow_clk);
-	if (ret)
-		return ret;
-
-	/* try to enable t2 clk to avoid future errors in mode change */
-	ret = clk_prepare_enable(t2_clk);
-	if (ret) {
-		clk_disable_unprepare(tc->slow_clk);
-		return ret;
-	}
-
-	clk_disable(t2_clk);
-
-	clkevt.regs = tc->regs;
-	clkevt.clk = t2_clk;
-
-	timer_clock = divisor_idx;
-	if (!divisor)
-		clkevt.freq = 32768;
-	else
-		clkevt.freq = clk_get_rate(t2_clk) / divisor;
-
-	clkevt.clkevt.cpumask = cpumask_of(0);
-
-	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
-	if (ret) {
-		clk_unprepare(t2_clk);
-		clk_disable_unprepare(tc->slow_clk);
-		return ret;
-	}
-
-	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
-
-	return ret;
-}
-
-#else /* !CONFIG_GENERIC_CLOCKEVENTS */
-
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
-{
-	/* NOTHING */
-	return 0;
-}
-
-#endif
-
-static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
-{
-	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
-	writel(mck_divisor_idx			/* likely divide-by-8 */
-			| ATMEL_TC_WAVE
-			| ATMEL_TC_WAVESEL_UP		/* free-run */
-			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
-			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
-			tcaddr + ATMEL_TC_REG(0, CMR));
-	writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
-	writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
-	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
-
-	/* channel 1:  waveform mode, input TIOA0 */
-	writel(ATMEL_TC_XC1			/* input: TIOA0 */
-			| ATMEL_TC_WAVE
-			| ATMEL_TC_WAVESEL_UP,		/* free-run */
-			tcaddr + ATMEL_TC_REG(1, CMR));
-	writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
-	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
-
-	/* chain channel 0 to channel 1*/
-	writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
-	/* then reset all the timers */
-	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
-}
-
-static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_idx)
-{
-	/* channel 0:  waveform mode, input mclk/8 */
-	writel(mck_divisor_idx			/* likely divide-by-8 */
-			| ATMEL_TC_WAVE
-			| ATMEL_TC_WAVESEL_UP,		/* free-run */
-			tcaddr + ATMEL_TC_REG(0, CMR));
-	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
-
-	/* then reset all the timers */
-	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
-}
-
-static int __init tcb_clksrc_init(void)
-{
-	static char bootinfo[] __initdata
-		= KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
-
-	struct platform_device *pdev;
-	struct atmel_tc *tc;
-	struct clk *t0_clk;
-	u32 rate, divided_rate = 0;
-	int best_divisor_idx = -1;
-	int clk32k_divisor_idx = -1;
-	int i;
-	int ret;
-
-	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
-	if (!tc) {
-		pr_debug("can't alloc TC for clocksource\n");
-		return -ENODEV;
-	}
-	tcaddr = tc->regs;
-	pdev = tc->pdev;
-
-	t0_clk = tc->clk[0];
-	ret = clk_prepare_enable(t0_clk);
-	if (ret) {
-		pr_debug("can't enable T0 clk\n");
-		goto err_free_tc;
-	}
-
-	/* How fast will we be counting?  Pick something over 5 MHz.  */
-	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < 5; i++) {
-		unsigned divisor = atmel_tc_divisors[i];
-		unsigned tmp;
-
-		/* remember 32 KiHz clock for later */
-		if (!divisor) {
-			clk32k_divisor_idx = i;
-			continue;
-		}
-
-		tmp = rate / divisor;
-		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
-		if (best_divisor_idx > 0) {
-			if (tmp < 5 * 1000 * 1000)
-				continue;
-		}
-		divided_rate = tmp;
-		best_divisor_idx = i;
-	}
-
-
-	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
-			divided_rate / 1000000,
-			((divided_rate % 1000000) + 500) / 1000);
-
-	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
-		/* use apropriate function to read 32 bit counter */
-		clksrc.read = tc_get_cycles32;
-		/* setup ony channel 0 */
-		tcb_setup_single_chan(tc, best_divisor_idx);
-	} else {
-		/* tclib will give us three clocks no matter what the
-		 * underlying platform supports.
-		 */
-		ret = clk_prepare_enable(tc->clk[1]);
-		if (ret) {
-			pr_debug("can't enable T1 clk\n");
-			goto err_disable_t0;
-		}
-		/* setup both channel 0 & 1 */
-		tcb_setup_dual_chan(tc, best_divisor_idx);
-	}
-
-	/* and away we go! */
-	ret = clocksource_register_hz(&clksrc, divided_rate);
-	if (ret)
-		goto err_disable_t1;
-
-	/* channel 2:  periodic and oneshot timer support */
-#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
-	ret = setup_clkevents(tc, clk32k_divisor_idx);
-#else
-	ret = setup_clkevents(tc, best_divisor_idx);
-#endif
-	if (ret)
-		goto err_unregister_clksrc;
-
-	return 0;
-
-err_unregister_clksrc:
-	clocksource_unregister(&clksrc);
-
-err_disable_t1:
-	if (!tc->tcb_config || tc->tcb_config->counter_width != 32)
-		clk_disable_unprepare(tc->clk[1]);
-
-err_disable_t0:
-	clk_disable_unprepare(t0_clk);
-
-err_free_tc:
-	atmel_tc_free(tc);
-	return ret;
-}
-arch_initcall(tcb_clksrc_init);
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 63ce3b69338a0..cfcc18902651a 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -1,468 +1,437 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/clk.h>
-#include <linux/clockchips.h>
+#include <linux/init.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
+#include <linux/irq.h>
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/regmap.h>
 #include <linux/sched_clock.h>
+#include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
 
-struct atmel_tcb_clksrc {
-	struct clocksource clksrc;
-	struct clock_event_device clkevt;
-	struct regmap *regmap;
-	void __iomem *base;
-	struct clk *clk[2];
-	char name[20];
-	int channels[2];
-	int bits;
-	int irq;
-	struct {
-		u32 cmr;
-		u32 imr;
-		u32 rc;
-		bool clken;
-	} cache[2];
-	u32 bmr_cache;
-	bool registered;
-	bool clk_enabled;
-};
-
-static struct atmel_tcb_clksrc tc, tce;
-
-static struct clk *tcb_clk_get(struct device_node *node, int channel)
-{
-	struct clk *clk;
-	char clk_name[] = "t0_clk";
-
-	clk_name[1] += channel;
-	clk = of_clk_get_by_name(node->parent, clk_name);
-	if (!IS_ERR(clk))
-		return clk;
-
-	return of_clk_get_by_name(node->parent, "t0_clk");
-}
 
 /*
- * Clockevent device using its own channel
- */
-
-static void tc_clkevt2_clk_disable(struct clock_event_device *d)
-{
-	clk_disable(tce.clk[0]);
-	tce.clk_enabled = false;
-}
-
-static void tc_clkevt2_clk_enable(struct clock_event_device *d)
-{
-	if (tce.clk_enabled)
-		return;
-	clk_enable(tce.clk[0]);
-	tce.clk_enabled = true;
-}
-
-static int tc_clkevt2_stop(struct clock_event_device *d)
-{
-	writel(0xff, tce.base + ATMEL_TC_IDR(tce.channels[0]));
-	writel(ATMEL_TC_CCR_CLKDIS, tce.base + ATMEL_TC_CCR(tce.channels[0]));
-
-	return 0;
-}
-
-static int tc_clkevt2_shutdown(struct clock_event_device *d)
-{
-	tc_clkevt2_stop(d);
-	if (!clockevent_state_detached(d))
-		tc_clkevt2_clk_disable(d);
-
-	return 0;
-}
-
-/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
- * because using one of the divided clocks would usually mean the
- * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
+ * We're configured to use a specific TC block, one that's not hooked
+ * up to external hardware, to provide a time solution:
  *
- * A divided clock could be good for high resolution timers, since
- * 30.5 usec resolution can seem "low".
+ *   - Two channels combine to create a free-running 32 bit counter
+ *     with a base rate of 5+ MHz, packaged as a clocksource (with
+ *     resolution better than 200 nsec).
+ *   - Some chips support 32 bit counter. A single channel is used for
+ *     this 32 bit free-running counter. the second channel is not used.
+ *
+ *   - The third channel may be used to provide a 16-bit clockevent
+ *     source, used in either periodic or oneshot mode.
+ *
+ * REVISIT behavior during system suspend states... we should disable
+ * all clocks and save the power.  Easily done for clockevent devices,
+ * but clocksources won't necessarily get the needed notifications.
+ * For deeper system sleep states, this will be mandatory...
  */
-static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
+
+static void __iomem *tcaddr;
+static struct
 {
-	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_clkevt2_stop(d);
+	u32 cmr;
+	u32 imr;
+	u32 rc;
+	bool clken;
+} tcb_cache[3];
+static u32 bmr_cache;
 
-	tc_clkevt2_clk_enable(d);
-
-	/* slow clock, count up to RC, then irq and stop */
-	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_CPCSTOP |
-	       ATMEL_TC_CMR_WAVE | ATMEL_TC_CMR_WAVESEL_UPRC,
-	       tce.base + ATMEL_TC_CMR(tce.channels[0]));
-	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channels[0]));
-
-	return 0;
-}
-
-static int tc_clkevt2_set_periodic(struct clock_event_device *d)
-{
-	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_clkevt2_stop(d);
-
-	/* By not making the gentime core emulate periodic mode on top
-	 * of oneshot, we get lower overhead and improved accuracy.
-	 */
-	tc_clkevt2_clk_enable(d);
-
-	/* slow clock, count up to RC, then irq and restart */
-	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
-	       ATMEL_TC_CMR_WAVESEL_UPRC,
-	       tce.base + ATMEL_TC_CMR(tce.channels[0]));
-	writel((32768 + HZ / 2) / HZ, tce.base + ATMEL_TC_RC(tce.channels[0]));
-
-	/* Enable clock and interrupts on RC compare */
-	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channels[0]));
-	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-	       tce.base + ATMEL_TC_CCR(tce.channels[0]));
-
-	return 0;
-}
-
-static int tc_clkevt2_next_event(unsigned long delta,
-				 struct clock_event_device *d)
-{
-	writel(delta, tce.base + ATMEL_TC_RC(tce.channels[0]));
-	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-	       tce.base + ATMEL_TC_CCR(tce.channels[0]));
-
-	return 0;
-}
-
-static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
-{
-	unsigned int sr;
-
-	sr = readl(tce.base + ATMEL_TC_SR(tce.channels[0]));
-	if (sr & ATMEL_TC_CPCS) {
-		tce.clkevt.event_handler(&tce.clkevt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-static void tc_clkevt2_suspend(struct clock_event_device *d)
-{
-	tce.cache[0].cmr = readl(tce.base + ATMEL_TC_CMR(tce.channels[0]));
-	tce.cache[0].imr = readl(tce.base + ATMEL_TC_IMR(tce.channels[0]));
-	tce.cache[0].rc = readl(tce.base + ATMEL_TC_RC(tce.channels[0]));
-	tce.cache[0].clken = !!(readl(tce.base + ATMEL_TC_SR(tce.channels[0])) &
-				ATMEL_TC_CLKSTA);
-}
-
-static void tc_clkevt2_resume(struct clock_event_device *d)
-{
-	/* Restore registers for the channel, RA and RB are not used  */
-	writel(tce.cache[0].cmr, tc.base + ATMEL_TC_CMR(tce.channels[0]));
-	writel(tce.cache[0].rc, tc.base + ATMEL_TC_RC(tce.channels[0]));
-	writel(0, tc.base + ATMEL_TC_RA(tce.channels[0]));
-	writel(0, tc.base + ATMEL_TC_RB(tce.channels[0]));
-	/* Disable all the interrupts */
-	writel(0xff, tc.base + ATMEL_TC_IDR(tce.channels[0]));
-	/* Reenable interrupts that were enabled before suspending */
-	writel(tce.cache[0].imr, tc.base + ATMEL_TC_IER(tce.channels[0]));
-
-	/* Start the clock if it was used */
-	if (tce.cache[0].clken)
-		writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-		       tc.base + ATMEL_TC_CCR(tce.channels[0]));
-}
-
-static int __init tc_clkevt_register(struct device_node *node,
-				     struct regmap *regmap, void __iomem *base,
-				     int channel, int irq, int bits)
-{
-	int ret;
-	struct clk *slow_clk;
-
-	tce.regmap = regmap;
-	tce.base = base;
-	tce.channels[0] = channel;
-	tce.irq = irq;
-
-	slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
-	if (IS_ERR(slow_clk))
-		return PTR_ERR(slow_clk);
-
-	ret = clk_prepare_enable(slow_clk);
-	if (ret)
-		return ret;
-
-	tce.clk[0] = tcb_clk_get(node, tce.channels[0]);
-	if (IS_ERR(tce.clk[0])) {
-		ret = PTR_ERR(tce.clk[0]);
-		goto err_slow;
-	}
-
-	snprintf(tce.name, sizeof(tce.name), "%s:%d",
-		 kbasename(node->parent->full_name), channel);
-	tce.clkevt.cpumask = cpumask_of(0);
-	tce.clkevt.name = tce.name;
-	tce.clkevt.set_next_event = tc_clkevt2_next_event,
-	tce.clkevt.set_state_shutdown = tc_clkevt2_shutdown,
-	tce.clkevt.set_state_periodic = tc_clkevt2_set_periodic,
-	tce.clkevt.set_state_oneshot = tc_clkevt2_set_oneshot,
-	tce.clkevt.suspend = tc_clkevt2_suspend,
-	tce.clkevt.resume = tc_clkevt2_resume,
-	tce.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	tce.clkevt.rating = 140;
-
-	/* try to enable clk to avoid future errors in mode change */
-	ret = clk_prepare_enable(tce.clk[0]);
-	if (ret)
-		goto err_slow;
-	clk_disable(tce.clk[0]);
-
-	clockevents_config_and_register(&tce.clkevt, 32768, 1,
-					CLOCKSOURCE_MASK(bits));
-
-	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
-			  tce.clkevt.name, &tce);
-	if (ret)
-		goto err_clk;
-
-	tce.registered = true;
-
-	return 0;
-
-err_clk:
-	clk_unprepare(tce.clk[0]);
-err_slow:
-	clk_disable_unprepare(slow_clk);
-
-	return ret;
-}
-
-/*
- * Clocksource and clockevent using the same channel(s)
- */
 static u64 tc_get_cycles(struct clocksource *cs)
 {
-	u32 lower, upper;
+	unsigned long	flags;
+	u32		lower, upper;
 
+	raw_local_irq_save(flags);
 	do {
-		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
-		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
-	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
+		upper = readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV));
+		lower = readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
+	} while (upper != readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV)));
 
+	raw_local_irq_restore(flags);
 	return (upper << 16) | lower;
 }
 
 static u64 tc_get_cycles32(struct clocksource *cs)
 {
-	return readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
+	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
+void tc_clksrc_suspend(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
+		tcb_cache[i].cmr = readl(tcaddr + ATMEL_TC_REG(i, CMR));
+		tcb_cache[i].imr = readl(tcaddr + ATMEL_TC_REG(i, IMR));
+		tcb_cache[i].rc = readl(tcaddr + ATMEL_TC_REG(i, RC));
+		tcb_cache[i].clken = !!(readl(tcaddr + ATMEL_TC_REG(i, SR)) &
+					ATMEL_TC_CLKSTA);
+	}
+
+	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
+}
+
+void tc_clksrc_resume(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
+		/* Restore registers for the channel, RA and RB are not used  */
+		writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));
+		writel(tcb_cache[i].rc, tcaddr + ATMEL_TC_REG(i, RC));
+		writel(0, tcaddr + ATMEL_TC_REG(i, RA));
+		writel(0, tcaddr + ATMEL_TC_REG(i, RB));
+		/* Disable all the interrupts */
+		writel(0xff, tcaddr + ATMEL_TC_REG(i, IDR));
+		/* Reenable interrupts that were enabled before suspending */
+		writel(tcb_cache[i].imr, tcaddr + ATMEL_TC_REG(i, IER));
+		/* Start the clock if it was used */
+		if (tcb_cache[i].clken)
+			writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(i, CCR));
+	}
+
+	/* Dual channel, chain channels */
+	writel(bmr_cache, tcaddr + ATMEL_TC_BMR);
+	/* Finally, trigger all the channels*/
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+}
+
+static struct clocksource clksrc = {
+	.rating         = 200,
+	.read           = tc_get_cycles,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= tc_clksrc_suspend,
+	.resume		= tc_clksrc_resume,
+};
+
 static u64 notrace tc_sched_clock_read(void)
 {
-	return tc_get_cycles(&tc.clksrc);
+	return tc_get_cycles(&clksrc);
 }
 
 static u64 notrace tc_sched_clock_read32(void)
 {
-	return tc_get_cycles32(&tc.clksrc);
+	return tc_get_cycles32(&clksrc);
 }
 
-static int tcb_clkevt_next_event(unsigned long delta,
-				 struct clock_event_device *d)
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+struct tc_clkevt_device {
+	struct clock_event_device	clkevt;
+	struct clk			*clk;
+	bool				clk_enabled;
+	u32				freq;
+	void __iomem			*regs;
+};
+
+static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
 {
-	u32 old, next, cur;
+	return container_of(clkevt, struct tc_clkevt_device, clkevt);
+}
 
-	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
-	next = old + delta;
-	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
-	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
+static u32 timer_clock;
 
-	/* check whether the delta elapsed while setting the register */
-	if ((next < old && cur < old && cur > next) ||
-	    (next > old && (cur < old || cur > next))) {
-		/*
-		 * Clear the CPCS bit in the status register to avoid
-		 * generating a spurious interrupt next time a valid
-		 * timer event is configured.
-		 */
-		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
-		return -ETIME;
-	}
+static void tc_clk_disable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
 
-	writel(ATMEL_TC_CPCS, tc.base + ATMEL_TC_IER(tc.channels[0]));
+	clk_disable(tcd->clk);
+	tcd->clk_enabled = false;
+}
+
+static void tc_clk_enable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	if (tcd->clk_enabled)
+		return;
+	clk_enable(tcd->clk);
+	tcd->clk_enabled = true;
+}
+
+static int tc_shutdown(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+	void __iomem		*regs = tcd->regs;
+
+	writel(0xff, regs + ATMEL_TC_REG(2, IDR));
+	writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+	return 0;
+}
+
+static int tc_shutdown_clk_off(struct clock_event_device *d)
+{
+	tc_shutdown(d);
+	if (!clockevent_state_detached(d))
+		tc_clk_disable(d);
 
 	return 0;
 }
 
-static irqreturn_t tc_clkevt_irq(int irq, void *handle)
+static int tc_set_oneshot(struct clock_event_device *d)
 {
-	unsigned int sr;
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+	void __iomem		*regs = tcd->regs;
 
-	sr = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
+
+	tc_clk_enable(d);
+
+	/* count up to RC, then irq and stop */
+	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
+		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
+	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+
+	/* set_next_event() configures and starts the timer */
+	return 0;
+}
+
+static int tc_set_periodic(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+	void __iomem		*regs = tcd->regs;
+
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
+
+	/* By not making the gentime core emulate periodic mode on top
+	 * of oneshot, we get lower overhead and improved accuracy.
+	 */
+	tc_clk_enable(d);
+
+	/* count up to RC, then irq and restart */
+	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
+		     regs + ATMEL_TC_REG(2, CMR));
+	writel((tcd->freq + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+
+	/* Enable clock and interrupts on RC compare */
+	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+
+	/* go go gadget! */
+	writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG, regs +
+		     ATMEL_TC_REG(2, CCR));
+	return 0;
+}
+
+static int tc_next_event(unsigned long delta, struct clock_event_device *d)
+{
+	writel_relaxed(delta, tcaddr + ATMEL_TC_REG(2, RC));
+
+	/* go go gadget! */
+	writel_relaxed(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+			tcaddr + ATMEL_TC_REG(2, CCR));
+	return 0;
+}
+
+static struct tc_clkevt_device clkevt = {
+	.clkevt	= {
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		/* Should be lower than at91rm9200's system timer */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+		.rating			= 125,
+#else
+		.rating			= 200,
+#endif
+		.set_next_event		= tc_next_event,
+		.set_state_shutdown	= tc_shutdown_clk_off,
+		.set_state_periodic	= tc_set_periodic,
+		.set_state_oneshot	= tc_set_oneshot,
+	},
+};
+
+static irqreturn_t ch2_irq(int irq, void *handle)
+{
+	struct tc_clkevt_device	*dev = handle;
+	unsigned int		sr;
+
+	sr = readl_relaxed(dev->regs + ATMEL_TC_REG(2, SR));
 	if (sr & ATMEL_TC_CPCS) {
-		tc.clkevt.event_handler(&tc.clkevt);
+		dev->clkevt.event_handler(&dev->clkevt);
 		return IRQ_HANDLED;
 	}
 
 	return IRQ_NONE;
 }
 
-static int tcb_clkevt_oneshot(struct clock_event_device *dev)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
-	if (clockevent_state_oneshot(dev))
-		return 0;
+	unsigned divisor = atmel_tc_divisors[divisor_idx];
+	int ret;
+	struct clk *t2_clk = tc->clk[2];
+	int irq = tc->irq[2];
 
-	/*
-	 * Because both clockevent devices may share the same IRQ, we don't want
-	 * the less likely one to stay requested
-	 */
-	return request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
-			   tc.name, &tc);
+	ret = clk_prepare_enable(tc->slow_clk);
+	if (ret)
+		return ret;
+
+	/* try to enable t2 clk to avoid future errors in mode change */
+	ret = clk_prepare_enable(t2_clk);
+	if (ret) {
+		clk_disable_unprepare(tc->slow_clk);
+		return ret;
+	}
+
+	clk_disable(t2_clk);
+
+	clkevt.regs = tc->regs;
+	clkevt.clk = t2_clk;
+
+	timer_clock = divisor_idx;
+	if (!divisor)
+		clkevt.freq = 32768;
+	else
+		clkevt.freq = clk_get_rate(t2_clk) / divisor;
+
+	clkevt.clkevt.cpumask = cpumask_of(0);
+
+	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
+	if (ret) {
+		clk_unprepare(t2_clk);
+		clk_disable_unprepare(tc->slow_clk);
+		return ret;
+	}
+
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
+
+	return ret;
 }
 
-static int tcb_clkevt_shutdown(struct clock_event_device *dev)
+#else /* !CONFIG_GENERIC_CLOCKEVENTS */
+
+static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 {
-	writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[0]));
-	if (tc.bits == 16)
-		writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[1]));
-
-	if (!clockevent_state_detached(dev))
-		free_irq(tc.irq, &tc);
-
+	/* NOTHING */
 	return 0;
 }
 
-static void __init tcb_setup_dual_chan(struct atmel_tcb_clksrc *tc,
-				       int mck_divisor_idx)
+#endif
+
+static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
-	/* first channel: waveform mode, input mclk/8, clock TIOA on overflow */
+	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
 	writel(mck_divisor_idx			/* likely divide-by-8 */
-	       | ATMEL_TC_CMR_WAVE
-	       | ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
-	       | ATMEL_TC_CMR_ACPA(SET)		/* TIOA rises at 0 */
-	       | ATMEL_TC_CMR_ACPC(CLEAR),	/* (duty cycle 50%) */
-	       tc->base + ATMEL_TC_CMR(tc->channels[0]));
-	writel(0x0000, tc->base + ATMEL_TC_RA(tc->channels[0]));
-	writel(0x8000, tc->base + ATMEL_TC_RC(tc->channels[0]));
-	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[0]));	/* no irqs */
-	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[0]));
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
+			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
+			tcaddr + ATMEL_TC_REG(0, CMR));
+	writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
+	writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
+	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
-	/* second channel: waveform mode, input TIOA */
-	writel(ATMEL_TC_CMR_XC(tc->channels[1])		/* input: TIOA */
-	       | ATMEL_TC_CMR_WAVE
-	       | ATMEL_TC_CMR_WAVESEL_UP,		/* free-run */
-	       tc->base + ATMEL_TC_CMR(tc->channels[1]));
-	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[1]));	/* no irqs */
-	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[1]));
+	/* channel 1:  waveform mode, input TIOA0 */
+	writel(ATMEL_TC_XC1			/* input: TIOA0 */
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP,		/* free-run */
+			tcaddr + ATMEL_TC_REG(1, CMR));
+	writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
 
-	/* chain both channel, we assume the previous channel */
-	regmap_write(tc->regmap, ATMEL_TC_BMR,
-		     ATMEL_TC_BMR_TCXC(1 + tc->channels[1], tc->channels[1]));
+	/* chain channel 0 to channel 1*/
+	writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
 	/* then reset all the timers */
-	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static void __init tcb_setup_single_chan(struct atmel_tcb_clksrc *tc,
-					 int mck_divisor_idx)
+static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
 	/* channel 0:  waveform mode, input mclk/8 */
 	writel(mck_divisor_idx			/* likely divide-by-8 */
-	       | ATMEL_TC_CMR_WAVE
-	       | ATMEL_TC_CMR_WAVESEL_UP,	/* free-run */
-	       tc->base + ATMEL_TC_CMR(tc->channels[0]));
-	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[0]));	/* no irqs */
-	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[0]));
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP,		/* free-run */
+			tcaddr + ATMEL_TC_REG(0, CMR));
+	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
 	/* then reset all the timers */
-	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static void tc_clksrc_suspend(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < 1 + (tc.bits == 16); i++) {
-		tc.cache[i].cmr = readl(tc.base + ATMEL_TC_CMR(tc.channels[i]));
-		tc.cache[i].imr = readl(tc.base + ATMEL_TC_IMR(tc.channels[i]));
-		tc.cache[i].rc = readl(tc.base + ATMEL_TC_RC(tc.channels[i]));
-		tc.cache[i].clken = !!(readl(tc.base +
-					     ATMEL_TC_SR(tc.channels[i])) &
-				       ATMEL_TC_CLKSTA);
-	}
-
-	if (tc.bits == 16)
-		regmap_read(tc.regmap, ATMEL_TC_BMR, &tc.bmr_cache);
-}
-
-static void tc_clksrc_resume(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < 1 + (tc.bits == 16); i++) {
-		/* Restore registers for the channel, RA and RB are not used  */
-		writel(tc.cache[i].cmr, tc.base + ATMEL_TC_CMR(tc.channels[i]));
-		writel(tc.cache[i].rc, tc.base + ATMEL_TC_RC(tc.channels[i]));
-		writel(0, tc.base + ATMEL_TC_RA(tc.channels[i]));
-		writel(0, tc.base + ATMEL_TC_RB(tc.channels[i]));
-		/* Disable all the interrupts */
-		writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[i]));
-		/* Reenable interrupts that were enabled before suspending */
-		writel(tc.cache[i].imr, tc.base + ATMEL_TC_IER(tc.channels[i]));
-
-		/* Start the clock if it was used */
-		if (tc.cache[i].clken)
-			writel(ATMEL_TC_CCR_CLKEN, tc.base +
-			       ATMEL_TC_CCR(tc.channels[i]));
-	}
-
-	/* in case of dual channel, chain channels */
-	if (tc.bits == 16)
-		regmap_write(tc.regmap, ATMEL_TC_BMR, tc.bmr_cache);
-	/* Finally, trigger all the channels*/
-	regmap_write(tc.regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
-}
-
-static int __init tcb_clksrc_register(struct device_node *node,
-				      struct regmap *regmap, void __iomem *base,
-				      int channel, int channel1, int irq,
-				      int bits)
+static int __init tcb_clksrc_init(struct device_node *node)
 {
+	struct atmel_tc tc;
+	struct clk *t0_clk;
+	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
+	int irq;
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
-	int i, err = -1;
-	u64 (*tc_sched_clock)(void);
+	int clk32k_divisor_idx = -1;
+	int i;
+	int ret;
 
-	tc.regmap = regmap;
-	tc.base = base;
-	tc.channels[0] = channel;
-	tc.channels[1] = channel1;
-	tc.irq = irq;
-	tc.bits = bits;
+	/* Protect against multiple calls */
+	if (tcaddr)
+		return 0;
 
-	tc.clk[0] = tcb_clk_get(node, tc.channels[0]);
-	if (IS_ERR(tc.clk[0]))
-		return PTR_ERR(tc.clk[0]);
-	err = clk_prepare_enable(tc.clk[0]);
-	if (err) {
+	tc.regs = of_iomap(node->parent, 0);
+	if (!tc.regs)
+		return -ENXIO;
+
+	t0_clk = of_clk_get_by_name(node->parent, "t0_clk");
+	if (IS_ERR(t0_clk))
+		return PTR_ERR(t0_clk);
+
+	tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tc.slow_clk))
+		return PTR_ERR(tc.slow_clk);
+
+	irq = of_irq_get(node->parent, 0);
+	if (irq <= 0)
+		return -EINVAL;
+
+	tc.clk[0] = t0_clk;
+	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
+	if (IS_ERR(tc.clk[1]))
+		tc.clk[1] = t0_clk;
+	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
+	if (IS_ERR(tc.clk[2]))
+		tc.clk[2] = t0_clk;
+
+	tc.irq[0] = irq;
+	tc.irq[1] = of_irq_get(node->parent, 1);
+	if (tc.irq[1] <= 0)
+		tc.irq[1] = irq;
+	tc.irq[2] = of_irq_get(node->parent, 2);
+	if (tc.irq[2] <= 0)
+		tc.irq[2] = irq;
+
+	match = of_match_node(atmel_tcb_dt_ids, node->parent);
+	tc.tcb_config = match->data;
+
+	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
+		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
+
+	ret = clk_prepare_enable(t0_clk);
+	if (ret) {
 		pr_debug("can't enable T0 clk\n");
-		goto err_clk;
+		return ret;
 	}
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
-	rate = (u32)clk_get_rate(tc.clk[0]);
-	for (i = 0; i < 5; i++) {
-		unsigned int divisor = atmel_tc_divisors[i];
-		unsigned int tmp;
+	rate = (u32) clk_get_rate(t0_clk);
+	for (i = 0; i < ARRAY_SIZE(atmel_tc_divisors); i++) {
+		unsigned divisor = atmel_tc_divisors[i];
+		unsigned tmp;
 
-		if (!divisor)
+		/* remember 32 KiHz clock for later */
+		if (!divisor) {
+			clk32k_divisor_idx = i;
 			continue;
+		}
 
 		tmp = rate / divisor;
 		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
@@ -474,144 +443,63 @@ static int __init tcb_clksrc_register(struct device_node *node,
 		best_divisor_idx = i;
 	}
 
-	if (tc.bits == 32) {
-		tc.clksrc.read = tc_get_cycles32;
+	clksrc.name = kbasename(node->parent->full_name);
+	clkevt.clkevt.name = kbasename(node->parent->full_name);
+	pr_debug("%s at %d.%03d MHz\n", clksrc.name, divided_rate / 1000000,
+			((divided_rate % 1000000) + 500) / 1000);
+
+	tcaddr = tc.regs;
+
+	if (tc.tcb_config->counter_width == 32) {
+		/* use apropriate function to read 32 bit counter */
+		clksrc.read = tc_get_cycles32;
+		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read32;
-		snprintf(tc.name, sizeof(tc.name), "%s:%d",
-			 kbasename(node->parent->full_name), tc.channels[0]);
 	} else {
-		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
-		if (IS_ERR(tc.clk[1]))
-			goto err_disable_t0;
-
-		err = clk_prepare_enable(tc.clk[1]);
-		if (err) {
+		/* we have three clocks no matter what the
+		 * underlying platform supports.
+		 */
+		ret = clk_prepare_enable(tc.clk[1]);
+		if (ret) {
 			pr_debug("can't enable T1 clk\n");
-			goto err_clk1;
+			goto err_disable_t0;
 		}
-		tc.clksrc.read = tc_get_cycles,
+		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read;
-		snprintf(tc.name, sizeof(tc.name), "%s:%d,%d",
-			 kbasename(node->parent->full_name), tc.channels[0],
-			 tc.channels[1]);
 	}
 
-	pr_debug("%s at %d.%03d MHz\n", tc.name,
-		 divided_rate / 1000000,
-		 ((divided_rate + 500000) % 1000000) / 1000);
-
-	tc.clksrc.name = tc.name;
-	tc.clksrc.suspend = tc_clksrc_suspend;
-	tc.clksrc.resume = tc_clksrc_resume;
-	tc.clksrc.rating = 200;
-	tc.clksrc.mask = CLOCKSOURCE_MASK(32);
-	tc.clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-
-	err = clocksource_register_hz(&tc.clksrc, divided_rate);
-	if (err)
+	/* and away we go! */
+	ret = clocksource_register_hz(&clksrc, divided_rate);
+	if (ret)
 		goto err_disable_t1;
 
+	/* channel 2:  periodic and oneshot timer support */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+	ret = setup_clkevents(&tc, clk32k_divisor_idx);
+#else
+	ret = setup_clkevents(tc, best_divisor_idx);
+#endif
+	if (ret)
+		goto err_unregister_clksrc;
+
 	sched_clock_register(tc_sched_clock, 32, divided_rate);
 
-	tc.registered = true;
-
-	/* Set up and register clockevents */
-	tc.clkevt.name = tc.name;
-	tc.clkevt.cpumask = cpumask_of(0);
-	tc.clkevt.set_next_event = tcb_clkevt_next_event;
-	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
-	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
-	tc.clkevt.features = CLOCK_EVT_FEAT_ONESHOT;
-	tc.clkevt.rating = 125;
-
-	clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
-					BIT(tc.bits) - 1);
-
 	return 0;
 
+err_unregister_clksrc:
+	clocksource_unregister(&clksrc);
+
 err_disable_t1:
-	if (tc.bits == 16)
+	if (tc.tcb_config->counter_width != 32)
 		clk_disable_unprepare(tc.clk[1]);
 
-err_clk1:
-	if (tc.bits == 16)
-		clk_put(tc.clk[1]);
-
 err_disable_t0:
-	clk_disable_unprepare(tc.clk[0]);
+	clk_disable_unprepare(t0_clk);
 
-err_clk:
-	clk_put(tc.clk[0]);
+	tcaddr = NULL;
 
-	pr_err("%s: unable to register clocksource/clockevent\n",
-	       tc.clksrc.name);
-
-	return err;
-}
-
-static int __init tcb_clksrc_init(struct device_node *node)
-{
-	const struct of_device_id *match;
-	struct regmap *regmap;
-	void __iomem *tcb_base;
-	u32 channel;
-	int irq, err, chan1 = -1;
-	unsigned bits;
-
-	if (tc.registered && tce.registered)
-		return -ENODEV;
-
-	/*
-	 * The regmap has to be used to access registers that are shared
-	 * between channels on the same TCB but we keep direct IO access for
-	 * the counters to avoid the impact on performance
-	 */
-	regmap = syscon_node_to_regmap(node->parent);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	tcb_base = of_iomap(node->parent, 0);
-	if (!tcb_base) {
-		pr_err("%s +%d %s\n", __FILE__, __LINE__, __func__);
-		return -ENXIO;
-	}
-
-	match = of_match_node(atmel_tcb_dt_ids, node->parent);
-	bits = (uintptr_t)match->data;
-
-	err = of_property_read_u32_index(node, "reg", 0, &channel);
-	if (err)
-		return err;
-
-	irq = of_irq_get(node->parent, channel);
-	if (irq < 0) {
-		irq = of_irq_get(node->parent, 0);
-		if (irq < 0)
-			return irq;
-	}
-
-	if (tc.registered)
-		return tc_clkevt_register(node, regmap, tcb_base, channel, irq,
-					  bits);
-
-	if (bits == 16) {
-		of_property_read_u32_index(node, "reg", 1, &chan1);
-		if (chan1 == -1) {
-			if (tce.registered) {
-				pr_err("%s: clocksource needs two channels\n",
-				       node->parent->full_name);
-				return -EINVAL;
-			} else {
-				return tc_clkevt_register(node, regmap,
-							  tcb_base, channel,
-							  irq, bits);
-			}
-		}
-	}
-
-	return tcb_clksrc_register(node, regmap, tcb_base, channel, chan1, irq,
-				   bits);
+	return ret;
 }
 TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index ca95ab2f4cfa3..8744d20ac1681 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -278,9 +278,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 
 	GEM_BUG_ON(!i915_request_completed(rq));
 
-	local_irq_disable();
-
-	spin_lock(&engine->timeline.lock);
+	spin_lock_irq(&engine->timeline.lock);
 	GEM_BUG_ON(!list_is_first(&rq->link, &engine->timeline.requests));
 	list_del_init(&rq->link);
 	spin_unlock(&engine->timeline.lock);
@@ -294,9 +292,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 		GEM_BUG_ON(!atomic_read(&rq->i915->gt_pm.rps.num_waiters));
 		atomic_dec(&rq->i915->gt_pm.rps.num_waiters);
 	}
-	spin_unlock(&rq->lock);
-
-	local_irq_enable();
+	spin_unlock_irq(&rq->lock);
 
 	/*
 	 * The backing object for the context is done after switching to the
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fb6bdd90cad5a..ab3c8ba07f2ce 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -59,38 +59,6 @@ config ATMEL_TCLIB
 	  blocks found on many Atmel processors.  This facilitates using
 	  these blocks by different drivers despite processor differences.
 
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ATMEL_TCLIB
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode.
-
-config ATMEL_TCB_CLKSRC_BLOCK
-	int
-	depends on ATMEL_TCB_CLKSRC
-	default 0
-	range 0 1
-	help
-	  Some chips provide more than one TC block, so you have the
-	  choice of which one to use for the clock framework.  The other
-	  TC can be used for other purposes, such as PWM generation and
-	  interval timing.
-
-config ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
-	bool "TC Block use 32 KiHz clock"
-	depends on ATMEL_TCB_CLKSRC
-	default y
-	help
-	  Select this to use 32 KiHz base clock rate as TC block clock
-	  source for clock events.
-
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index ac24a4bd63f75..b610cc894cd82 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -1,4 +1,3 @@
-#include <linux/atmel_tc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -10,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <soc/at91/atmel_tcb.h>
 
 /*
  * This is a thin library to solve the problem of how to portably allocate
@@ -17,18 +17,6 @@
  * share individual timers between different drivers.
  */
 
-#if defined(CONFIG_AVR32)
-/* AVR32 has these divide PBB */
-const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#elif defined(CONFIG_ARCH_AT91)
-/* AT91 has these divide MCK */
-const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#endif
-
 static DEFINE_SPINLOCK(tc_list_lock);
 static LIST_HEAD(tc_list);
 
@@ -80,26 +68,6 @@ void atmel_tc_free(struct atmel_tc *tc)
 EXPORT_SYMBOL_GPL(atmel_tc_free);
 
 #if defined(CONFIG_OF)
-static struct atmel_tcb_config tcb_rm9200_config = {
-	.counter_width = 16,
-};
-
-static struct atmel_tcb_config tcb_sam9x5_config = {
-	.counter_width = 32,
-};
-
-static const struct of_device_id atmel_tcb_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-tcb",
-		.data = &tcb_rm9200_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &tcb_sam9x5_config,
-	}, {
-		/* sentinel */
-	}
-};
-
 MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
 #endif
 
@@ -111,6 +79,9 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct resource	*r;
 	unsigned int	i;
 
+	if (of_get_child_count(pdev->dev.of_node))
+		return 0;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0d0f8376bc351..d7e92fd552e40 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,7 +17,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
+#include <soc/at91/atmel_tcb.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
deleted file mode 100644
index 468fdfa643f0d..0000000000000
--- a/include/linux/atmel_tc.h
+++ /dev/null
@@ -1,270 +0,0 @@
-/*
- * Timer/Counter Unit (TC) registers.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ATMEL_TC_H
-#define ATMEL_TC_H
-
-#include <linux/compiler.h>
-#include <linux/list.h>
-
-/*
- * Many 32-bit Atmel SOCs include one or more TC blocks, each of which holds
- * three general-purpose 16-bit timers.  These timers share one register bank.
- * Depending on the SOC, each timer may have its own clock and IRQ, or those
- * may be shared by the whole TC block.
- *
- * These TC blocks may have up to nine external pins:  TCLK0..2 signals for
- * clocks or clock gates, and per-timer TIOA and TIOB signals used for PWM
- * or triggering.  Those pins need to be set up for use with the TC block,
- * else they will be used as GPIOs or for a different controller.
- *
- * Although we expect each TC block to have a platform_device node, those
- * nodes are not what drivers bind to.  Instead, they ask for a specific
- * TC block, by number ... which is a common approach on systems with many
- * timers.  Then they use clk_get() and platform_get_irq() to get clock and
- * IRQ resources.
- */
-
-struct clk;
-
-/**
- * struct atmel_tcb_config - SoC data for a Timer/Counter Block
- * @counter_width: size in bits of a timer counter register
- */
-struct atmel_tcb_config {
-	size_t	counter_width;
-};
-
-/**
- * struct atmel_tc - information about a Timer/Counter Block
- * @pdev: physical device
- * @regs: mapping through which the I/O registers can be accessed
- * @id: block id
- * @tcb_config: configuration data from SoC
- * @irq: irq for each of the three channels
- * @clk: internal clock source for each of the three channels
- * @node: list node, for tclib internal use
- * @allocated: if already used, for tclib internal use
- *
- * On some platforms, each TC channel has its own clocks and IRQs,
- * while on others, all TC channels share the same clock and IRQ.
- * Drivers should clk_enable() all the clocks they need even though
- * all the entries in @clk may point to the same physical clock.
- * Likewise, drivers should request irqs independently for each
- * channel, but they must use IRQF_SHARED in case some of the entries
- * in @irq are actually the same IRQ.
- */
-struct atmel_tc {
-	struct platform_device	*pdev;
-	void __iomem		*regs;
-	int                     id;
-	const struct atmel_tcb_config *tcb_config;
-	int			irq[3];
-	struct clk		*clk[3];
-	struct clk		*slow_clk;
-	struct list_head	node;
-	bool			allocated;
-};
-
-extern struct atmel_tc *atmel_tc_alloc(unsigned block);
-extern void atmel_tc_free(struct atmel_tc *tc);
-
-/* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
-extern const u8 atmel_tc_divisors[5];
-
-
-/*
- * Two registers have block-wide controls.  These are: configuring the three
- * "external" clocks (or event sources) used by the timer channels; and
- * synchronizing the timers by resetting them all at once.
- *
- * "External" can mean "external to chip" using the TCLK0, TCLK1, or TCLK2
- * signals.  Or, it can mean "external to timer", using the TIOA output from
- * one of the other two timers that's being run in waveform mode.
- */
-
-#define ATMEL_TC_BCR	0xc0		/* TC Block Control Register */
-#define     ATMEL_TC_SYNC	(1 << 0)	/* synchronize timers */
-
-#define ATMEL_TC_BMR	0xc4		/* TC Block Mode Register */
-#define     ATMEL_TC_TC0XC0S	(3 << 0)	/* external clock 0 source */
-#define        ATMEL_TC_TC0XC0S_TCLK0	(0 << 0)
-#define        ATMEL_TC_TC0XC0S_NONE	(1 << 0)
-#define        ATMEL_TC_TC0XC0S_TIOA1	(2 << 0)
-#define        ATMEL_TC_TC0XC0S_TIOA2	(3 << 0)
-#define     ATMEL_TC_TC1XC1S	(3 << 2)	/* external clock 1 source */
-#define        ATMEL_TC_TC1XC1S_TCLK1	(0 << 2)
-#define        ATMEL_TC_TC1XC1S_NONE	(1 << 2)
-#define        ATMEL_TC_TC1XC1S_TIOA0	(2 << 2)
-#define        ATMEL_TC_TC1XC1S_TIOA2	(3 << 2)
-#define     ATMEL_TC_TC2XC2S	(3 << 4)	/* external clock 2 source */
-#define        ATMEL_TC_TC2XC2S_TCLK2	(0 << 4)
-#define        ATMEL_TC_TC2XC2S_NONE	(1 << 4)
-#define        ATMEL_TC_TC2XC2S_TIOA0	(2 << 4)
-#define        ATMEL_TC_TC2XC2S_TIOA1	(3 << 4)
-
-
-/*
- * Each TC block has three "channels", each with one counter and controls.
- *
- * Note that the semantics of ATMEL_TC_TIMER_CLOCKx (input clock selection
- * when it's not "external") is silicon-specific.  AT91 platforms use one
- * set of definitions; AVR32 platforms use a different set.  Don't hard-wire
- * such knowledge into your code, use the global "atmel_tc_divisors" ...
- * where index N is the divisor for clock N+1, else zero to indicate it uses
- * the 32 KiHz clock.
- *
- * The timers can be chained in various ways, and operated in "waveform"
- * generation mode (including PWM) or "capture" mode (to time events).  In
- * both modes, behavior can be configured in many ways.
- *
- * Each timer has two I/O pins, TIOA and TIOB.  Waveform mode uses TIOA as a
- * PWM output, and TIOB as either another PWM or as a trigger.  Capture mode
- * uses them only as inputs.
- */
-#define ATMEL_TC_CHAN(idx)	((idx)*0x40)
-#define ATMEL_TC_REG(idx, reg)	(ATMEL_TC_CHAN(idx) + ATMEL_TC_ ## reg)
-
-#define ATMEL_TC_CCR	0x00		/* Channel Control Register */
-#define     ATMEL_TC_CLKEN	(1 << 0)	/* clock enable */
-#define     ATMEL_TC_CLKDIS	(1 << 1)	/* clock disable */
-#define     ATMEL_TC_SWTRG	(1 << 2)	/* software trigger */
-
-#define ATMEL_TC_CMR	0x04		/* Channel Mode Register */
-
-/* Both modes share some CMR bits */
-#define     ATMEL_TC_TCCLKS	(7 << 0)	/* clock source */
-#define        ATMEL_TC_TIMER_CLOCK1	(0 << 0)
-#define        ATMEL_TC_TIMER_CLOCK2	(1 << 0)
-#define        ATMEL_TC_TIMER_CLOCK3	(2 << 0)
-#define        ATMEL_TC_TIMER_CLOCK4	(3 << 0)
-#define        ATMEL_TC_TIMER_CLOCK5	(4 << 0)
-#define        ATMEL_TC_XC0		(5 << 0)
-#define        ATMEL_TC_XC1		(6 << 0)
-#define        ATMEL_TC_XC2		(7 << 0)
-#define     ATMEL_TC_CLKI	(1 << 3)	/* clock invert */
-#define     ATMEL_TC_BURST	(3 << 4)	/* clock gating */
-#define        ATMEL_TC_GATE_NONE	(0 << 4)
-#define        ATMEL_TC_GATE_XC0	(1 << 4)
-#define        ATMEL_TC_GATE_XC1	(2 << 4)
-#define        ATMEL_TC_GATE_XC2	(3 << 4)
-#define     ATMEL_TC_WAVE	(1 << 15)	/* true = Waveform mode */
-
-/* CAPTURE mode CMR bits */
-#define     ATMEL_TC_LDBSTOP	(1 << 6)	/* counter stops on RB load */
-#define     ATMEL_TC_LDBDIS	(1 << 7)	/* counter disable on RB load */
-#define     ATMEL_TC_ETRGEDG	(3 << 8)	/* external trigger edge */
-#define        ATMEL_TC_ETRGEDG_NONE	(0 << 8)
-#define        ATMEL_TC_ETRGEDG_RISING	(1 << 8)
-#define        ATMEL_TC_ETRGEDG_FALLING	(2 << 8)
-#define        ATMEL_TC_ETRGEDG_BOTH	(3 << 8)
-#define     ATMEL_TC_ABETRG	(1 << 10)	/* external trigger is TIOA? */
-#define     ATMEL_TC_CPCTRG	(1 << 14)	/* RC compare trigger enable */
-#define     ATMEL_TC_LDRA	(3 << 16)	/* RA loading edge (of TIOA) */
-#define        ATMEL_TC_LDRA_NONE	(0 << 16)
-#define        ATMEL_TC_LDRA_RISING	(1 << 16)
-#define        ATMEL_TC_LDRA_FALLING	(2 << 16)
-#define        ATMEL_TC_LDRA_BOTH	(3 << 16)
-#define     ATMEL_TC_LDRB	(3 << 18)	/* RB loading edge (of TIOA) */
-#define        ATMEL_TC_LDRB_NONE	(0 << 18)
-#define        ATMEL_TC_LDRB_RISING	(1 << 18)
-#define        ATMEL_TC_LDRB_FALLING	(2 << 18)
-#define        ATMEL_TC_LDRB_BOTH	(3 << 18)
-
-/* WAVEFORM mode CMR bits */
-#define     ATMEL_TC_CPCSTOP	(1 <<  6)	/* RC compare stops counter */
-#define     ATMEL_TC_CPCDIS	(1 <<  7)	/* RC compare disables counter */
-#define     ATMEL_TC_EEVTEDG	(3 <<  8)	/* external event edge */
-#define        ATMEL_TC_EEVTEDG_NONE	(0 << 8)
-#define        ATMEL_TC_EEVTEDG_RISING	(1 << 8)
-#define        ATMEL_TC_EEVTEDG_FALLING	(2 << 8)
-#define        ATMEL_TC_EEVTEDG_BOTH	(3 << 8)
-#define     ATMEL_TC_EEVT	(3 << 10)	/* external event source */
-#define        ATMEL_TC_EEVT_TIOB	(0 << 10)
-#define        ATMEL_TC_EEVT_XC0	(1 << 10)
-#define        ATMEL_TC_EEVT_XC1	(2 << 10)
-#define        ATMEL_TC_EEVT_XC2	(3 << 10)
-#define     ATMEL_TC_ENETRG	(1 << 12)	/* external event is trigger */
-#define     ATMEL_TC_WAVESEL	(3 << 13)	/* waveform type */
-#define        ATMEL_TC_WAVESEL_UP	(0 << 13)
-#define        ATMEL_TC_WAVESEL_UPDOWN	(1 << 13)
-#define        ATMEL_TC_WAVESEL_UP_AUTO	(2 << 13)
-#define        ATMEL_TC_WAVESEL_UPDOWN_AUTO (3 << 13)
-#define     ATMEL_TC_ACPA	(3 << 16)	/* RA compare changes TIOA */
-#define        ATMEL_TC_ACPA_NONE	(0 << 16)
-#define        ATMEL_TC_ACPA_SET	(1 << 16)
-#define        ATMEL_TC_ACPA_CLEAR	(2 << 16)
-#define        ATMEL_TC_ACPA_TOGGLE	(3 << 16)
-#define     ATMEL_TC_ACPC	(3 << 18)	/* RC compare changes TIOA */
-#define        ATMEL_TC_ACPC_NONE	(0 << 18)
-#define        ATMEL_TC_ACPC_SET	(1 << 18)
-#define        ATMEL_TC_ACPC_CLEAR	(2 << 18)
-#define        ATMEL_TC_ACPC_TOGGLE	(3 << 18)
-#define     ATMEL_TC_AEEVT	(3 << 20)	/* external event changes TIOA */
-#define        ATMEL_TC_AEEVT_NONE	(0 << 20)
-#define        ATMEL_TC_AEEVT_SET	(1 << 20)
-#define        ATMEL_TC_AEEVT_CLEAR	(2 << 20)
-#define        ATMEL_TC_AEEVT_TOGGLE	(3 << 20)
-#define     ATMEL_TC_ASWTRG	(3 << 22)	/* software trigger changes TIOA */
-#define        ATMEL_TC_ASWTRG_NONE	(0 << 22)
-#define        ATMEL_TC_ASWTRG_SET	(1 << 22)
-#define        ATMEL_TC_ASWTRG_CLEAR	(2 << 22)
-#define        ATMEL_TC_ASWTRG_TOGGLE	(3 << 22)
-#define     ATMEL_TC_BCPB	(3 << 24)	/* RB compare changes TIOB */
-#define        ATMEL_TC_BCPB_NONE	(0 << 24)
-#define        ATMEL_TC_BCPB_SET	(1 << 24)
-#define        ATMEL_TC_BCPB_CLEAR	(2 << 24)
-#define        ATMEL_TC_BCPB_TOGGLE	(3 << 24)
-#define     ATMEL_TC_BCPC	(3 << 26)	/* RC compare changes TIOB */
-#define        ATMEL_TC_BCPC_NONE	(0 << 26)
-#define        ATMEL_TC_BCPC_SET	(1 << 26)
-#define        ATMEL_TC_BCPC_CLEAR	(2 << 26)
-#define        ATMEL_TC_BCPC_TOGGLE	(3 << 26)
-#define     ATMEL_TC_BEEVT	(3 << 28)	/* external event changes TIOB */
-#define        ATMEL_TC_BEEVT_NONE	(0 << 28)
-#define        ATMEL_TC_BEEVT_SET	(1 << 28)
-#define        ATMEL_TC_BEEVT_CLEAR	(2 << 28)
-#define        ATMEL_TC_BEEVT_TOGGLE	(3 << 28)
-#define     ATMEL_TC_BSWTRG	(3 << 30)	/* software trigger changes TIOB */
-#define        ATMEL_TC_BSWTRG_NONE	(0 << 30)
-#define        ATMEL_TC_BSWTRG_SET	(1 << 30)
-#define        ATMEL_TC_BSWTRG_CLEAR	(2 << 30)
-#define        ATMEL_TC_BSWTRG_TOGGLE	(3 << 30)
-
-#define ATMEL_TC_CV	0x10		/* counter Value */
-#define ATMEL_TC_RA	0x14		/* register A */
-#define ATMEL_TC_RB	0x18		/* register B */
-#define ATMEL_TC_RC	0x1c		/* register C */
-
-#define ATMEL_TC_SR	0x20		/* status (read-only) */
-/* Status-only flags */
-#define     ATMEL_TC_CLKSTA	(1 << 16)	/* clock enabled */
-#define     ATMEL_TC_MTIOA	(1 << 17)	/* TIOA mirror */
-#define     ATMEL_TC_MTIOB	(1 << 18)	/* TIOB mirror */
-
-#define ATMEL_TC_IER	0x24		/* interrupt enable (write-only) */
-#define ATMEL_TC_IDR	0x28		/* interrupt disable (write-only) */
-#define ATMEL_TC_IMR	0x2c		/* interrupt mask (read-only) */
-
-/* Status and IRQ flags */
-#define     ATMEL_TC_COVFS	(1 <<  0)	/* counter overflow */
-#define     ATMEL_TC_LOVRS	(1 <<  1)	/* load overrun */
-#define     ATMEL_TC_CPAS	(1 <<  2)	/* RA compare */
-#define     ATMEL_TC_CPBS	(1 <<  3)	/* RB compare */
-#define     ATMEL_TC_CPCS	(1 <<  4)	/* RC compare */
-#define     ATMEL_TC_LDRAS	(1 <<  5)	/* RA loading */
-#define     ATMEL_TC_LDRBS	(1 <<  6)	/* RB loading */
-#define     ATMEL_TC_ETRGS	(1 <<  7)	/* external trigger */
-#define     ATMEL_TC_ALL_IRQ	(ATMEL_TC_COVFS	| ATMEL_TC_LOVRS | \
-				 ATMEL_TC_CPAS | ATMEL_TC_CPBS | \
-				 ATMEL_TC_CPCS | ATMEL_TC_LDRAS | \
-				 ATMEL_TC_LDRBS | ATMEL_TC_ETRGS) \
-				 /* all IRQs */
-
-#endif
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index 657e234b14832..cb0c5f53cd46c 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -1,183 +1,289 @@
-//SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018 Microchip */
+/*
+ * Timer/Counter Unit (TC) registers.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
 
 #ifndef __SOC_ATMEL_TCB_H
 #define __SOC_ATMEL_TCB_H
 
-/* Channel registers */
-#define ATMEL_TC_COFFS(c)		((c) * 0x40)
-#define ATMEL_TC_CCR(c)			ATMEL_TC_COFFS(c)
-#define ATMEL_TC_CMR(c)			(ATMEL_TC_COFFS(c) + 0x4)
-#define ATMEL_TC_SMMR(c)		(ATMEL_TC_COFFS(c) + 0x8)
-#define ATMEL_TC_RAB(c)			(ATMEL_TC_COFFS(c) + 0xc)
-#define ATMEL_TC_CV(c)			(ATMEL_TC_COFFS(c) + 0x10)
-#define ATMEL_TC_RA(c)			(ATMEL_TC_COFFS(c) + 0x14)
-#define ATMEL_TC_RB(c)			(ATMEL_TC_COFFS(c) + 0x18)
-#define ATMEL_TC_RC(c)			(ATMEL_TC_COFFS(c) + 0x1c)
-#define ATMEL_TC_SR(c)			(ATMEL_TC_COFFS(c) + 0x20)
-#define ATMEL_TC_IER(c)			(ATMEL_TC_COFFS(c) + 0x24)
-#define ATMEL_TC_IDR(c)			(ATMEL_TC_COFFS(c) + 0x28)
-#define ATMEL_TC_IMR(c)			(ATMEL_TC_COFFS(c) + 0x2c)
-#define ATMEL_TC_EMR(c)			(ATMEL_TC_COFFS(c) + 0x30)
+#include <linux/compiler.h>
+#include <linux/list.h>
 
-/* Block registers */
-#define ATMEL_TC_BCR			0xc0
-#define ATMEL_TC_BMR			0xc4
-#define ATMEL_TC_QIER			0xc8
-#define ATMEL_TC_QIDR			0xcc
-#define ATMEL_TC_QIMR			0xd0
-#define ATMEL_TC_QISR			0xd4
-#define ATMEL_TC_FMR			0xd8
-#define ATMEL_TC_WPMR			0xe4
+/*
+ * Many 32-bit Atmel SOCs include one or more TC blocks, each of which holds
+ * three general-purpose 16-bit timers.  These timers share one register bank.
+ * Depending on the SOC, each timer may have its own clock and IRQ, or those
+ * may be shared by the whole TC block.
+ *
+ * These TC blocks may have up to nine external pins:  TCLK0..2 signals for
+ * clocks or clock gates, and per-timer TIOA and TIOB signals used for PWM
+ * or triggering.  Those pins need to be set up for use with the TC block,
+ * else they will be used as GPIOs or for a different controller.
+ *
+ * Although we expect each TC block to have a platform_device node, those
+ * nodes are not what drivers bind to.  Instead, they ask for a specific
+ * TC block, by number ... which is a common approach on systems with many
+ * timers.  Then they use clk_get() and platform_get_irq() to get clock and
+ * IRQ resources.
+ */
 
-/* CCR fields */
-#define ATMEL_TC_CCR_CLKEN		BIT(0)
-#define ATMEL_TC_CCR_CLKDIS		BIT(1)
-#define ATMEL_TC_CCR_SWTRG		BIT(2)
+struct clk;
 
-/* Common CMR fields */
-#define ATMEL_TC_CMR_TCLKS_MSK		GENMASK(2, 0)
-#define ATMEL_TC_CMR_TCLK(x)		(x)
-#define ATMEL_TC_CMR_XC(x)		((x) + 5)
-#define ATMEL_TC_CMR_CLKI		BIT(3)
-#define ATMEL_TC_CMR_BURST_MSK		GENMASK(5, 4)
-#define ATMEL_TC_CMR_BURST_XC(x)	(((x) + 1) << 4)
-#define ATMEL_TC_CMR_WAVE		BIT(15)
+/**
+ * struct atmel_tcb_config - SoC data for a Timer/Counter Block
+ * @counter_width: size in bits of a timer counter register
+ */
+struct atmel_tcb_config {
+	size_t	counter_width;
+};
 
-/* Capture mode CMR fields */
-#define ATMEL_TC_CMR_LDBSTOP		BIT(6)
-#define ATMEL_TC_CMR_LDBDIS		BIT(7)
-#define ATMEL_TC_CMR_ETRGEDG_MSK	GENMASK(9, 8)
-#define ATMEL_TC_CMR_ETRGEDG_NONE	(0 << 8)
-#define ATMEL_TC_CMR_ETRGEDG_RISING	(1 << 8)
-#define ATMEL_TC_CMR_ETRGEDG_FALLING	(2 << 8)
-#define ATMEL_TC_CMR_ETRGEDG_BOTH	(3 << 8)
-#define ATMEL_TC_CMR_ABETRG		BIT(10)
-#define ATMEL_TC_CMR_CPCTRG		BIT(14)
-#define ATMEL_TC_CMR_LDRA_MSK		GENMASK(17, 16)
-#define ATMEL_TC_CMR_LDRA_NONE		(0 << 16)
-#define ATMEL_TC_CMR_LDRA_RISING	(1 << 16)
-#define ATMEL_TC_CMR_LDRA_FALLING	(2 << 16)
-#define ATMEL_TC_CMR_LDRA_BOTH		(3 << 16)
-#define ATMEL_TC_CMR_LDRB_MSK		GENMASK(19, 18)
-#define ATMEL_TC_CMR_LDRB_NONE		(0 << 18)
-#define ATMEL_TC_CMR_LDRB_RISING	(1 << 18)
-#define ATMEL_TC_CMR_LDRB_FALLING	(2 << 18)
-#define ATMEL_TC_CMR_LDRB_BOTH		(3 << 18)
-#define ATMEL_TC_CMR_SBSMPLR_MSK	GENMASK(22, 20)
-#define ATMEL_TC_CMR_SBSMPLR(x)		((x) << 20)
+/**
+ * struct atmel_tc - information about a Timer/Counter Block
+ * @pdev: physical device
+ * @regs: mapping through which the I/O registers can be accessed
+ * @id: block id
+ * @tcb_config: configuration data from SoC
+ * @irq: irq for each of the three channels
+ * @clk: internal clock source for each of the three channels
+ * @node: list node, for tclib internal use
+ * @allocated: if already used, for tclib internal use
+ *
+ * On some platforms, each TC channel has its own clocks and IRQs,
+ * while on others, all TC channels share the same clock and IRQ.
+ * Drivers should clk_enable() all the clocks they need even though
+ * all the entries in @clk may point to the same physical clock.
+ * Likewise, drivers should request irqs independently for each
+ * channel, but they must use IRQF_SHARED in case some of the entries
+ * in @irq are actually the same IRQ.
+ */
+struct atmel_tc {
+	struct platform_device	*pdev;
+	void __iomem		*regs;
+	int                     id;
+	const struct atmel_tcb_config *tcb_config;
+	int			irq[3];
+	struct clk		*clk[3];
+	struct clk		*slow_clk;
+	struct list_head	node;
+	bool			allocated;
+};
 
-/* Waveform mode CMR fields */
-#define ATMEL_TC_CMR_CPCSTOP		BIT(6)
-#define ATMEL_TC_CMR_CPCDIS		BIT(7)
-#define ATMEL_TC_CMR_EEVTEDG_MSK	GENMASK(9, 8)
-#define ATMEL_TC_CMR_EEVTEDG_NONE	(0 << 8)
-#define ATMEL_TC_CMR_EEVTEDG_RISING	(1 << 8)
-#define ATMEL_TC_CMR_EEVTEDG_FALLING	(2 << 8)
-#define ATMEL_TC_CMR_EEVTEDG_BOTH	(3 << 8)
-#define ATMEL_TC_CMR_EEVT_MSK		GENMASK(11, 10)
-#define ATMEL_TC_CMR_EEVT_XC(x)		(((x) + 1) << 10)
-#define ATMEL_TC_CMR_ENETRG		BIT(12)
-#define ATMEL_TC_CMR_WAVESEL_MSK	GENMASK(14, 13)
-#define ATMEL_TC_CMR_WAVESEL_UP		(0 << 13)
-#define ATMEL_TC_CMR_WAVESEL_UPDOWN	(1 << 13)
-#define ATMEL_TC_CMR_WAVESEL_UPRC	(2 << 13)
-#define ATMEL_TC_CMR_WAVESEL_UPDOWNRC	(3 << 13)
-#define ATMEL_TC_CMR_ACPA_MSK		GENMASK(17, 16)
-#define ATMEL_TC_CMR_ACPA(a)		(ATMEL_TC_CMR_ACTION_##a << 16)
-#define ATMEL_TC_CMR_ACPC_MSK		GENMASK(19, 18)
-#define ATMEL_TC_CMR_ACPC(a)		(ATMEL_TC_CMR_ACTION_##a << 18)
-#define ATMEL_TC_CMR_AEEVT_MSK		GENMASK(21, 20)
-#define ATMEL_TC_CMR_AEEVT(a)		(ATMEL_TC_CMR_ACTION_##a << 20)
-#define ATMEL_TC_CMR_ASWTRG_MSK		GENMASK(23, 22)
-#define ATMEL_TC_CMR_ASWTRG(a)		(ATMEL_TC_CMR_ACTION_##a << 22)
-#define ATMEL_TC_CMR_BCPB_MSK		GENMASK(25, 24)
-#define ATMEL_TC_CMR_BCPB(a)		(ATMEL_TC_CMR_ACTION_##a << 24)
-#define ATMEL_TC_CMR_BCPC_MSK		GENMASK(27, 26)
-#define ATMEL_TC_CMR_BCPC(a)		(ATMEL_TC_CMR_ACTION_##a << 26)
-#define ATMEL_TC_CMR_BEEVT_MSK		GENMASK(29, 28)
-#define ATMEL_TC_CMR_BEEVT(a)		(ATMEL_TC_CMR_ACTION_##a << 28)
-#define ATMEL_TC_CMR_BSWTRG_MSK		GENMASK(31, 30)
-#define ATMEL_TC_CMR_BSWTRG(a)		(ATMEL_TC_CMR_ACTION_##a << 30)
-#define ATMEL_TC_CMR_ACTION_NONE	0
-#define ATMEL_TC_CMR_ACTION_SET		1
-#define ATMEL_TC_CMR_ACTION_CLEAR	2
-#define ATMEL_TC_CMR_ACTION_TOGGLE	3
+extern struct atmel_tc *atmel_tc_alloc(unsigned block);
+extern void atmel_tc_free(struct atmel_tc *tc);
 
-/* SMMR fields */
-#define ATMEL_TC_SMMR_GCEN		BIT(0)
-#define ATMEL_TC_SMMR_DOWN		BIT(1)
+/* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
+static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
 
-/* SR/IER/IDR/IMR fields */
-#define ATMEL_TC_COVFS			BIT(0)
-#define ATMEL_TC_LOVRS			BIT(1)
-#define ATMEL_TC_CPAS			BIT(2)
-#define ATMEL_TC_CPBS			BIT(3)
-#define ATMEL_TC_CPCS			BIT(4)
-#define ATMEL_TC_LDRAS			BIT(5)
-#define ATMEL_TC_LDRBS			BIT(6)
-#define ATMEL_TC_ETRGS			BIT(7)
-#define ATMEL_TC_CLKSTA			BIT(16)
-#define ATMEL_TC_MTIOA			BIT(17)
-#define ATMEL_TC_MTIOB			BIT(18)
+static const struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
 
-/* EMR fields */
-#define ATMEL_TC_EMR_TRIGSRCA_MSK	GENMASK(1, 0)
-#define ATMEL_TC_EMR_TRIGSRCA_TIOA	0
-#define ATMEL_TC_EMR_TRIGSRCA_PWMX	1
-#define ATMEL_TC_EMR_TRIGSRCB_MSK	GENMASK(5, 4)
-#define ATMEL_TC_EMR_TRIGSRCB_TIOB	(0 << 4)
-#define ATMEL_TC_EMR_TRIGSRCB_PWM	(1 << 4)
-#define ATMEL_TC_EMR_NOCLKDIV		BIT(8)
-
-/* BCR fields */
-#define ATMEL_TC_BCR_SYNC		BIT(0)
-
-/* BMR fields */
-#define ATMEL_TC_BMR_TCXC_MSK(c)	GENMASK(((c) * 2) + 1, (c) * 2)
-#define ATMEL_TC_BMR_TCXC(x, c)		((x) << (2 * (c)))
-#define ATMEL_TC_BMR_QDEN		BIT(8)
-#define ATMEL_TC_BMR_POSEN		BIT(9)
-#define ATMEL_TC_BMR_SPEEDEN		BIT(10)
-#define ATMEL_TC_BMR_QDTRANS		BIT(11)
-#define ATMEL_TC_BMR_EDGPHA		BIT(12)
-#define ATMEL_TC_BMR_INVA		BIT(13)
-#define ATMEL_TC_BMR_INVB		BIT(14)
-#define ATMEL_TC_BMR_INVIDX		BIT(15)
-#define ATMEL_TC_BMR_SWAP		BIT(16)
-#define ATMEL_TC_BMR_IDXPHB		BIT(17)
-#define ATMEL_TC_BMR_AUTOC		BIT(18)
-#define ATMEL_TC_MAXFILT_MSK		GENMASK(25, 20)
-#define ATMEL_TC_MAXFILT(x)		(((x) - 1) << 20)
-#define ATMEL_TC_MAXCMP_MSK		GENMASK(29, 26)
-#define ATMEL_TC_MAXCMP(x)		((x) << 26)
-
-/* QEDC fields */
-#define ATMEL_TC_QEDC_IDX		BIT(0)
-#define ATMEL_TC_QEDC_DIRCHG		BIT(1)
-#define ATMEL_TC_QEDC_QERR		BIT(2)
-#define ATMEL_TC_QEDC_MPE		BIT(3)
-#define ATMEL_TC_QEDC_DIR		BIT(8)
-
-/* FMR fields */
-#define ATMEL_TC_FMR_ENCF(x)		BIT(x)
-
-/* WPMR fields */
-#define ATMEL_TC_WPMR_WPKEY		(0x54494d << 8)
-#define ATMEL_TC_WPMR_WPEN		BIT(0)
-
-static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
+static const struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
 
 static const struct of_device_id atmel_tcb_dt_ids[] = {
 	{
 		.compatible = "atmel,at91rm9200-tcb",
-		.data = (void *)16,
+		.data = &tcb_rm9200_config,
 	}, {
 		.compatible = "atmel,at91sam9x5-tcb",
-		.data = (void *)32,
+		.data = &tcb_sam9x5_config,
 	}, {
 		/* sentinel */
 	}
 };
 
-#endif /* __SOC_ATMEL_TCB_H */
+/*
+ * Two registers have block-wide controls.  These are: configuring the three
+ * "external" clocks (or event sources) used by the timer channels; and
+ * synchronizing the timers by resetting them all at once.
+ *
+ * "External" can mean "external to chip" using the TCLK0, TCLK1, or TCLK2
+ * signals.  Or, it can mean "external to timer", using the TIOA output from
+ * one of the other two timers that's being run in waveform mode.
+ */
+
+#define ATMEL_TC_BCR	0xc0		/* TC Block Control Register */
+#define     ATMEL_TC_SYNC	(1 << 0)	/* synchronize timers */
+
+#define ATMEL_TC_BMR	0xc4		/* TC Block Mode Register */
+#define     ATMEL_TC_TC0XC0S	(3 << 0)	/* external clock 0 source */
+#define        ATMEL_TC_TC0XC0S_TCLK0	(0 << 0)
+#define        ATMEL_TC_TC0XC0S_NONE	(1 << 0)
+#define        ATMEL_TC_TC0XC0S_TIOA1	(2 << 0)
+#define        ATMEL_TC_TC0XC0S_TIOA2	(3 << 0)
+#define     ATMEL_TC_TC1XC1S	(3 << 2)	/* external clock 1 source */
+#define        ATMEL_TC_TC1XC1S_TCLK1	(0 << 2)
+#define        ATMEL_TC_TC1XC1S_NONE	(1 << 2)
+#define        ATMEL_TC_TC1XC1S_TIOA0	(2 << 2)
+#define        ATMEL_TC_TC1XC1S_TIOA2	(3 << 2)
+#define     ATMEL_TC_TC2XC2S	(3 << 4)	/* external clock 2 source */
+#define        ATMEL_TC_TC2XC2S_TCLK2	(0 << 4)
+#define        ATMEL_TC_TC2XC2S_NONE	(1 << 4)
+#define        ATMEL_TC_TC2XC2S_TIOA0	(2 << 4)
+#define        ATMEL_TC_TC2XC2S_TIOA1	(3 << 4)
+
+
+/*
+ * Each TC block has three "channels", each with one counter and controls.
+ *
+ * Note that the semantics of ATMEL_TC_TIMER_CLOCKx (input clock selection
+ * when it's not "external") is silicon-specific.  AT91 platforms use one
+ * set of definitions; AVR32 platforms use a different set.  Don't hard-wire
+ * such knowledge into your code, use the global "atmel_tc_divisors" ...
+ * where index N is the divisor for clock N+1, else zero to indicate it uses
+ * the 32 KiHz clock.
+ *
+ * The timers can be chained in various ways, and operated in "waveform"
+ * generation mode (including PWM) or "capture" mode (to time events).  In
+ * both modes, behavior can be configured in many ways.
+ *
+ * Each timer has two I/O pins, TIOA and TIOB.  Waveform mode uses TIOA as a
+ * PWM output, and TIOB as either another PWM or as a trigger.  Capture mode
+ * uses them only as inputs.
+ */
+#define ATMEL_TC_CHAN(idx)	((idx)*0x40)
+#define ATMEL_TC_REG(idx, reg)	(ATMEL_TC_CHAN(idx) + ATMEL_TC_ ## reg)
+
+#define ATMEL_TC_CCR	0x00		/* Channel Control Register */
+#define     ATMEL_TC_CLKEN	(1 << 0)	/* clock enable */
+#define     ATMEL_TC_CLKDIS	(1 << 1)	/* clock disable */
+#define     ATMEL_TC_SWTRG	(1 << 2)	/* software trigger */
+
+#define ATMEL_TC_CMR	0x04		/* Channel Mode Register */
+
+/* Both modes share some CMR bits */
+#define     ATMEL_TC_TCCLKS	(7 << 0)	/* clock source */
+#define        ATMEL_TC_TIMER_CLOCK1	(0 << 0)
+#define        ATMEL_TC_TIMER_CLOCK2	(1 << 0)
+#define        ATMEL_TC_TIMER_CLOCK3	(2 << 0)
+#define        ATMEL_TC_TIMER_CLOCK4	(3 << 0)
+#define        ATMEL_TC_TIMER_CLOCK5	(4 << 0)
+#define        ATMEL_TC_XC0		(5 << 0)
+#define        ATMEL_TC_XC1		(6 << 0)
+#define        ATMEL_TC_XC2		(7 << 0)
+#define     ATMEL_TC_CLKI	(1 << 3)	/* clock invert */
+#define     ATMEL_TC_BURST	(3 << 4)	/* clock gating */
+#define        ATMEL_TC_GATE_NONE	(0 << 4)
+#define        ATMEL_TC_GATE_XC0	(1 << 4)
+#define        ATMEL_TC_GATE_XC1	(2 << 4)
+#define        ATMEL_TC_GATE_XC2	(3 << 4)
+#define     ATMEL_TC_WAVE	(1 << 15)	/* true = Waveform mode */
+
+/* CAPTURE mode CMR bits */
+#define     ATMEL_TC_LDBSTOP	(1 << 6)	/* counter stops on RB load */
+#define     ATMEL_TC_LDBDIS	(1 << 7)	/* counter disable on RB load */
+#define     ATMEL_TC_ETRGEDG	(3 << 8)	/* external trigger edge */
+#define        ATMEL_TC_ETRGEDG_NONE	(0 << 8)
+#define        ATMEL_TC_ETRGEDG_RISING	(1 << 8)
+#define        ATMEL_TC_ETRGEDG_FALLING	(2 << 8)
+#define        ATMEL_TC_ETRGEDG_BOTH	(3 << 8)
+#define     ATMEL_TC_ABETRG	(1 << 10)	/* external trigger is TIOA? */
+#define     ATMEL_TC_CPCTRG	(1 << 14)	/* RC compare trigger enable */
+#define     ATMEL_TC_LDRA	(3 << 16)	/* RA loading edge (of TIOA) */
+#define        ATMEL_TC_LDRA_NONE	(0 << 16)
+#define        ATMEL_TC_LDRA_RISING	(1 << 16)
+#define        ATMEL_TC_LDRA_FALLING	(2 << 16)
+#define        ATMEL_TC_LDRA_BOTH	(3 << 16)
+#define     ATMEL_TC_LDRB	(3 << 18)	/* RB loading edge (of TIOA) */
+#define        ATMEL_TC_LDRB_NONE	(0 << 18)
+#define        ATMEL_TC_LDRB_RISING	(1 << 18)
+#define        ATMEL_TC_LDRB_FALLING	(2 << 18)
+#define        ATMEL_TC_LDRB_BOTH	(3 << 18)
+
+/* WAVEFORM mode CMR bits */
+#define     ATMEL_TC_CPCSTOP	(1 <<  6)	/* RC compare stops counter */
+#define     ATMEL_TC_CPCDIS	(1 <<  7)	/* RC compare disables counter */
+#define     ATMEL_TC_EEVTEDG	(3 <<  8)	/* external event edge */
+#define        ATMEL_TC_EEVTEDG_NONE	(0 << 8)
+#define        ATMEL_TC_EEVTEDG_RISING	(1 << 8)
+#define        ATMEL_TC_EEVTEDG_FALLING	(2 << 8)
+#define        ATMEL_TC_EEVTEDG_BOTH	(3 << 8)
+#define     ATMEL_TC_EEVT	(3 << 10)	/* external event source */
+#define        ATMEL_TC_EEVT_TIOB	(0 << 10)
+#define        ATMEL_TC_EEVT_XC0	(1 << 10)
+#define        ATMEL_TC_EEVT_XC1	(2 << 10)
+#define        ATMEL_TC_EEVT_XC2	(3 << 10)
+#define     ATMEL_TC_ENETRG	(1 << 12)	/* external event is trigger */
+#define     ATMEL_TC_WAVESEL	(3 << 13)	/* waveform type */
+#define        ATMEL_TC_WAVESEL_UP	(0 << 13)
+#define        ATMEL_TC_WAVESEL_UPDOWN	(1 << 13)
+#define        ATMEL_TC_WAVESEL_UP_AUTO	(2 << 13)
+#define        ATMEL_TC_WAVESEL_UPDOWN_AUTO (3 << 13)
+#define     ATMEL_TC_ACPA	(3 << 16)	/* RA compare changes TIOA */
+#define        ATMEL_TC_ACPA_NONE	(0 << 16)
+#define        ATMEL_TC_ACPA_SET	(1 << 16)
+#define        ATMEL_TC_ACPA_CLEAR	(2 << 16)
+#define        ATMEL_TC_ACPA_TOGGLE	(3 << 16)
+#define     ATMEL_TC_ACPC	(3 << 18)	/* RC compare changes TIOA */
+#define        ATMEL_TC_ACPC_NONE	(0 << 18)
+#define        ATMEL_TC_ACPC_SET	(1 << 18)
+#define        ATMEL_TC_ACPC_CLEAR	(2 << 18)
+#define        ATMEL_TC_ACPC_TOGGLE	(3 << 18)
+#define     ATMEL_TC_AEEVT	(3 << 20)	/* external event changes TIOA */
+#define        ATMEL_TC_AEEVT_NONE	(0 << 20)
+#define        ATMEL_TC_AEEVT_SET	(1 << 20)
+#define        ATMEL_TC_AEEVT_CLEAR	(2 << 20)
+#define        ATMEL_TC_AEEVT_TOGGLE	(3 << 20)
+#define     ATMEL_TC_ASWTRG	(3 << 22)	/* software trigger changes TIOA */
+#define        ATMEL_TC_ASWTRG_NONE	(0 << 22)
+#define        ATMEL_TC_ASWTRG_SET	(1 << 22)
+#define        ATMEL_TC_ASWTRG_CLEAR	(2 << 22)
+#define        ATMEL_TC_ASWTRG_TOGGLE	(3 << 22)
+#define     ATMEL_TC_BCPB	(3 << 24)	/* RB compare changes TIOB */
+#define        ATMEL_TC_BCPB_NONE	(0 << 24)
+#define        ATMEL_TC_BCPB_SET	(1 << 24)
+#define        ATMEL_TC_BCPB_CLEAR	(2 << 24)
+#define        ATMEL_TC_BCPB_TOGGLE	(3 << 24)
+#define     ATMEL_TC_BCPC	(3 << 26)	/* RC compare changes TIOB */
+#define        ATMEL_TC_BCPC_NONE	(0 << 26)
+#define        ATMEL_TC_BCPC_SET	(1 << 26)
+#define        ATMEL_TC_BCPC_CLEAR	(2 << 26)
+#define        ATMEL_TC_BCPC_TOGGLE	(3 << 26)
+#define     ATMEL_TC_BEEVT	(3 << 28)	/* external event changes TIOB */
+#define        ATMEL_TC_BEEVT_NONE	(0 << 28)
+#define        ATMEL_TC_BEEVT_SET	(1 << 28)
+#define        ATMEL_TC_BEEVT_CLEAR	(2 << 28)
+#define        ATMEL_TC_BEEVT_TOGGLE	(3 << 28)
+#define     ATMEL_TC_BSWTRG	(3 << 30)	/* software trigger changes TIOB */
+#define        ATMEL_TC_BSWTRG_NONE	(0 << 30)
+#define        ATMEL_TC_BSWTRG_SET	(1 << 30)
+#define        ATMEL_TC_BSWTRG_CLEAR	(2 << 30)
+#define        ATMEL_TC_BSWTRG_TOGGLE	(3 << 30)
+
+#define ATMEL_TC_CV	0x10		/* counter Value */
+#define ATMEL_TC_RA	0x14		/* register A */
+#define ATMEL_TC_RB	0x18		/* register B */
+#define ATMEL_TC_RC	0x1c		/* register C */
+
+#define ATMEL_TC_SR	0x20		/* status (read-only) */
+/* Status-only flags */
+#define     ATMEL_TC_CLKSTA	(1 << 16)	/* clock enabled */
+#define     ATMEL_TC_MTIOA	(1 << 17)	/* TIOA mirror */
+#define     ATMEL_TC_MTIOB	(1 << 18)	/* TIOB mirror */
+
+#define ATMEL_TC_IER	0x24		/* interrupt enable (write-only) */
+#define ATMEL_TC_IDR	0x28		/* interrupt disable (write-only) */
+#define ATMEL_TC_IMR	0x2c		/* interrupt mask (read-only) */
+
+/* Status and IRQ flags */
+#define     ATMEL_TC_COVFS	(1 <<  0)	/* counter overflow */
+#define     ATMEL_TC_LOVRS	(1 <<  1)	/* load overrun */
+#define     ATMEL_TC_CPAS	(1 <<  2)	/* RA compare */
+#define     ATMEL_TC_CPBS	(1 <<  3)	/* RB compare */
+#define     ATMEL_TC_CPCS	(1 <<  4)	/* RC compare */
+#define     ATMEL_TC_LDRAS	(1 <<  5)	/* RA loading */
+#define     ATMEL_TC_LDRBS	(1 <<  6)	/* RB loading */
+#define     ATMEL_TC_ETRGS	(1 <<  7)	/* external trigger */
+#define     ATMEL_TC_ALL_IRQ	(ATMEL_TC_COVFS	| ATMEL_TC_LOVRS | \
+				 ATMEL_TC_CPAS | ATMEL_TC_CPBS | \
+				 ATMEL_TC_CPCS | ATMEL_TC_LDRAS | \
+				 ATMEL_TC_LDRBS | ATMEL_TC_ETRGS) \
+				 /* all IRQs */
+
+#endif
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
