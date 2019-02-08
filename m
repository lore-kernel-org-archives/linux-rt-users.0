From: Julien Grall <julien.grall@arm.com>
Subject: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
Date: Fri,  8 Feb 2019 16:55:13 +0000
Message-ID: <20190208165513.8435-1-julien.grall@arm.com>
Cc: bigeasy@linutronix.de, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
the kernel may be able to use FPSIMD/SVE. This is for instance the case
for crypto code.

Any use of FPSIMD/SVE in the kernel are clearly marked by using the
function kernel_neon_{begin, end}. Furthermore, this can only be used
when may_use_simd() returns true.

The current implementation of may_use_simd() allows softirq to use
FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
When in used, softirqs usually fallback to a software method.

At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
when touching the FPSIMD/SVE context. This has the drawback to disable
all softirqs even if they are not using FPSIMD/SVE.

As a softirq should not rely on been able to use simd at a given time,
there are limited reason to keep softirq disabled when touching the
FPSIMD/SVE context. Instead, we can only disable preemption and tell
the NEON unit is currently in use.

This patch introduces two new helpers kernel_neon_{disable, enable} to
mark the area using FPSIMD/SVE context and use them in replacement of
local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
also re-implemented to use the new helpers.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

I have been exploring this solution as an alternative approach to the RT
patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".

So far, the patch has only been lightly tested.

For RT-linux, it might be possible to use migrate_{enable, disable}. I
am quite new with RT and have some trouble to understand the semantics
of migrate_{enable, disable}. So far, I am still unsure if it is possible
to run another userspace task on the same CPU while getting preempted
when the migration is disabled.
---
 arch/arm64/include/asm/simd.h |  4 +--
 arch/arm64/kernel/fpsimd.c    | 76 +++++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 6495cc51246f..94c0dac508aa 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -15,10 +15,10 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
-
 DECLARE_PER_CPU(bool, kernel_neon_busy);
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+
 /*
  * may_use_simd - whether it is allowable at this time to issue SIMD
  *                instructions or access the SIMD register file
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5ebe73b69961..b7e5dac26190 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -90,7 +90,8 @@
  * To prevent this from racing with the manipulation of the task's FPSIMD state
  * from task context and thereby corrupting the state, it is necessary to
  * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
- * flag with local_bh_disable() unless softirqs are already masked.
+ * flag with kernel_neon_{disable, enable}. This will still allow softirqs to
+ * run but prevent them to use FPSIMD.
  *
  * For a certain task, the sequence may look something like this:
  * - the task gets scheduled in; if both the task's fpsimd_cpu field
@@ -142,6 +143,9 @@ extern void __percpu *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+static void kernel_neon_disable(void);
+static void kernel_neon_enable(void);
+
 /*
  * Call __sve_free() directly only if you know task can't be scheduled
  * or preempted.
@@ -213,11 +217,11 @@ static void sve_free(struct task_struct *task)
  * thread_struct is known to be up to date, when preparing to enter
  * userspace.
  *
- * Softirqs (and preemption) must be disabled.
+ * Preemption must be disabled.
  */
 static void task_fpsimd_load(void)
 {
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	WARN_ON(!preempt_count() && !irqs_disabled());
 
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
@@ -238,7 +242,7 @@ void fpsimd_save(void)
 	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
 
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	WARN_ON(!preempt_count() && !irqs_disabled());
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
@@ -360,7 +364,7 @@ static int __init sve_sysctl_init(void) { return 0; }
  * task->thread.sve_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * preemption must be disabled.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.uw.fpsimd_state must be up to date before calling this
@@ -387,7 +391,7 @@ static void fpsimd_to_sve(struct task_struct *task)
  * task->thread.uw.fpsimd_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * preemption must be disabled.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.sve_state must be up to date before calling this function.
@@ -547,7 +551,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
-		local_bh_disable();
+		kernel_neon_disable();
 
 		fpsimd_save();
 		set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -558,7 +562,7 @@ int sve_set_vector_length(struct task_struct *task,
 		sve_to_fpsimd(task);
 
 	if (task == current)
-		local_bh_enable();
+		kernel_neon_enable();
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -813,7 +817,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	sve_alloc(current);
 
-	local_bh_disable();
+	kernel_neon_disable();
 
 	fpsimd_save();
 	fpsimd_to_sve(current);
@@ -825,7 +829,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_bh_enable();
+	kernel_neon_enable();
 }
 
 /*
@@ -892,7 +896,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	kernel_neon_disable();
 
 	memset(&current->thread.uw.fpsimd_state, 0,
 	       sizeof(current->thread.uw.fpsimd_state));
@@ -935,7 +939,7 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	kernel_neon_enable();
 }
 
 /*
@@ -947,9 +951,9 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	kernel_neon_disable();
 	fpsimd_save();
-	local_bh_enable();
+	kernel_neon_enable();
 }
 
 /*
@@ -1007,14 +1011,14 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	kernel_neon_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_task_to_cpu();
 	}
 
-	local_bh_enable();
+	kernel_neon_enable();
 }
 
 /*
@@ -1027,7 +1031,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	kernel_neon_disable();
 
 	current->thread.uw.fpsimd_state = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1038,7 +1042,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 
 	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	kernel_neon_enable();
 }
 
 /*
@@ -1055,11 +1059,28 @@ void fpsimd_flush_cpu_state(void)
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-#ifdef CONFIG_KERNEL_MODE_NEON
-
 DEFINE_PER_CPU(bool, kernel_neon_busy);
 EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
 
+static void kernel_neon_disable(void)
+{
+	preempt_disable();
+	WARN_ON(__this_cpu_read(kernel_neon_busy));
+	__this_cpu_write(kernel_neon_busy, true);
+}
+
+static void kernel_neon_enable(void)
+{
+	bool busy;
+
+	busy = __this_cpu_xchg(kernel_neon_busy, false);
+	WARN_ON(!busy); /* No matching kernel_neon_disable()? */
+
+	preempt_enable();
+}
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+
 /*
  * Kernel-side NEON support functions
  */
@@ -1084,9 +1105,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
-
-	__this_cpu_write(kernel_neon_busy, true);
+	kernel_neon_disable();
 
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
@@ -1094,9 +1113,7 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
-	preempt_disable();
-
-	local_bh_enable();
+	kernel_neon_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
@@ -1111,15 +1128,10 @@ EXPORT_SYMBOL(kernel_neon_begin);
  */
 void kernel_neon_end(void)
 {
-	bool busy;
-
 	if (!system_supports_fpsimd())
 		return;
 
-	busy = __this_cpu_xchg(kernel_neon_busy, false);
-	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
-
-	preempt_enable();
+	kernel_neon_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.11.0
