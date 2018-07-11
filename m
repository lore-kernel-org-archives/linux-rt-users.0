Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732747AbeGKPMT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Jul 2018 11:12:19 -0400
Message-ID: <1531321642.12761.30.camel@gmx.de>
Subject: [rfc 4.16-rt patch] arm64: efi,fpsimd: use a local_lock() in
 efi_virtmap_load()
From: Mike Galbraith <efault@gmx.de>
Date: Wed, 11 Jul 2018 17:07:22 +0200
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

Greetings,

With the patch below, there's still one neon splat to figure out what
to do with should this patch not die a gruesome death.  Cavium box
boots and seemingly works fine modulo kvm, which is utterly deadly in
4.16-rt due to..

972             if (!vgic_initialized(vcpu->kvm))
973                     return false;
974
975             irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
976             spin_lock_irqsave(&irq->irq_lock, flags);

..that lock apparently having wandered into a minefield post v4.14.

Remaining neon splat:

[   26.820029] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[   26.820032] in_atomic(): 1, irqs_disabled(): 0, pid: 1243, name: modprobe
[   26.820034] Preemption disabled at:
[   26.820048] [<ffff00000116d0b4>] init_module+0xb4/0x1000 [raid6_pq]
[   26.820073] CPU: 5 PID: 1243 Comm: modprobe Tainted: G        W        4.16.18-rt9-rt #6
[   26.820075] Hardware name: www.cavium.com crb-1s/crb-1s, BIOS 0.3 Apr 25 2017
[   26.820077] Call trace:
[   26.820082]  dump_backtrace+0x0/0x1c8
[   26.820085]  show_stack+0x24/0x30
[   26.820090]  dump_stack+0xac/0xe8
[   26.820096]  ___might_sleep+0x124/0x188
[   26.820099]  rt_spin_lock+0x40/0x88
[   26.820103]  kernel_neon_begin+0x88/0x128
[   26.820112]  raid6_neon1_gen_syndrome+0x20/0x48 [raid6_pq]
[   26.820119]  init_module+0x110/0x1000 [raid6_pq]
[   26.820121]  do_one_initcall+0x44/0x138
[   26.820125]  do_init_module+0x64/0x204
[   26.820127]  load_module+0x13b0/0x15b8
[   26.820129]  SyS_finit_module+0xd8/0xf0
[   26.820131]  el0_svc_naked+0x30/0x34
[   26.836189] raid6: neonx1   gen()  1234 MB/s
[   26.853199] raid6: neonx1   xor()  1091 MB/s
[   26.870089] raid6: neonx2   gen()  1406 MB/s
[   26.887178] raid6: neonx2   xor()  1253 MB/s
[   26.904190] raid6: neonx4   gen()  1488 MB/s
[   26.921397] raid6: neonx4   xor()  1333 MB/s
[   26.938021] raid6: neonx8   gen()  1480 MB/s
[   26.955403] raid6: neonx8   xor()  1294 MB/s
[   26.955409] raid6: using algorithm int64x4 gen() 1621 MB/s
[   26.955415] raid6: .... xor() 1021 MB/s, rmw enabled
[   26.955420] raid6: using neon recovery algorithm

The patch:

("arm64: fpsimd: use a local_lock() in addition to local_bh_disable()")
added a local_lock() which efi_virtmap_load()/efi_virtmap_unload() will
embed in the preempt disabled section therein.

[    9.406518] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[    9.406520] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[    9.406522] Preemption disabled at:
[    9.406533] [<ffff0000087d9018>] efi_virtmap_load+0x18/0x38
[    9.406539] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        4.16.18-rt7-rt-virgin #3
[    9.406540] Hardware name: www.cavium.com crb-1s/crb-1s, BIOS 0.3 Apr 25 2017
[    9.406542] Call trace:
[    9.406549]  dump_backtrace+0x0/0x188
[    9.406551]  show_stack+0x24/0x30
[    9.406556]  dump_stack+0x9c/0xd0
[    9.406561]  ___might_sleep+0x124/0x188
[    9.406565]  rt_spin_lock+0x40/0x80
[    9.406568]  kernel_neon_begin+0x90/0x170
[    9.406570]  __efi_fpsimd_begin+0x68/0x1a0
[    9.406573]  virt_efi_get_next_variable+0x48/0xc8
[    9.406575]  efivar_init+0xb0/0x380
[    9.406580]  efisubsys_init+0xd4/0x26c
[    9.406582]  do_one_initcall+0x58/0x168
[    9.406588]  kernel_init_freeable+0x1e0/0x284
[    9.406590]  kernel_init+0x18/0x118
[    9.406592]  ret_from_fork+0x10/0x18

To solve this, use a local_lock() in efi_virtmap_load()/efi_virtmap_unload()
as well, and to prevent unlock thereof tripping over the preemption disabled
section created by kernel_neon_begin()/kernel_neon_end(), do not disable
preemption there either, which !RT does to ensure that preemption remains
disabled across local_bh_enable().  Instead, hold fpsimd_lock across the
pair, nesting local_bh_disable()/local_bh_enable() inside fpsimd_lock.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/arm64/kernel/fpsimd.c         |   38 ++++++++++++++++++++-----------------
 drivers/firmware/efi/arm-runtime.c |    7 ++++--
 2 files changed, 26 insertions(+), 19 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -607,8 +607,8 @@ int sve_set_vector_length(struct task_st
 		sve_to_fpsimd(task);
 
 	if (task == current) {
-		local_unlock(fpsimd_lock);
 		local_bh_enable();
+		local_unlock(fpsimd_lock);
 	}
 
 	/*
@@ -841,8 +841,8 @@ asmlinkage void do_sve_acc(unsigned int
 
 	sve_alloc(current);
 
-	local_bh_disable();
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 
 	task_fpsimd_save();
 	fpsimd_to_sve(current);
@@ -854,8 +854,8 @@ asmlinkage void do_sve_acc(unsigned int
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_unlock(fpsimd_lock);
 	local_bh_enable();
+	local_unlock(fpsimd_lock);
 }
 
 /*
@@ -931,8 +931,8 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
@@ -974,8 +974,8 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_unlock(fpsimd_lock);
 	local_bh_enable();
+	local_unlock(fpsimd_lock);
 }
 
 /*
@@ -987,11 +987,11 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 	task_fpsimd_save();
-	local_unlock(fpsimd_lock);
 	local_bh_enable();
+	local_unlock(fpsimd_lock);
 }
 
 /*
@@ -1031,16 +1031,16 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_to_cpu();
 	}
 
-	local_unlock(fpsimd_lock);
 	local_bh_enable();
+	local_unlock(fpsimd_lock);
 }
 
 /*
@@ -1053,8 +1053,8 @@ void fpsimd_update_current_state(struct
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1065,8 +1065,8 @@ void fpsimd_update_current_state(struct
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_bind_to_cpu();
 
-	local_unlock(fpsimd_lock);
 	local_bh_enable();
+	local_unlock(fpsimd_lock);
 }
 
 /*
@@ -1129,8 +1129,14 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
+	/*
+	 * Note: local_lock() maps to preempt_disable() for !RT builds.
+	 * Holding the lock across kernel_neon_begin()/end() keeps
+	 * preemption disabled across local_bh_enable() as required for
+	 * !RT builds, while providing preemptible exclusion for RT.
+	 */
 	local_lock(fpsimd_lock);
+	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
 
@@ -1143,9 +1149,6 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
-	local_unlock(fpsimd_lock);
-	preempt_disable();
-
 	local_bh_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
@@ -1169,7 +1172,7 @@ void kernel_neon_end(void)
 	busy = __this_cpu_xchg(kernel_neon_busy, false);
 	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
 
-	preempt_enable();
+	local_unlock(fpsimd_lock);
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
@@ -1201,7 +1204,8 @@ void __efi_fpsimd_begin(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	WARN_ON(preemptible());
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
+		WARN_ON(preemptible());
 
 	if (may_use_simd()) {
 		kernel_neon_begin();
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/locallock.h>
 
 #include <asm/cacheflush.h>
 #include <asm/efi.h>
@@ -159,16 +160,18 @@ static int __init arm_enable_runtime_ser
 }
 early_initcall(arm_enable_runtime_services);
 
+static DEFINE_LOCAL_IRQ_LOCK(efi_virtmap_lock);
+
 void efi_virtmap_load(void)
 {
-	preempt_disable();
+	local_lock(efi_virtmap_lock);
 	efi_set_pgd(&efi_mm);
 }
 
 void efi_virtmap_unload(void)
 {
 	efi_set_pgd(current->active_mm);
-	preempt_enable();
+	local_unlock(efi_virtmap_lock);
 }
 
 
