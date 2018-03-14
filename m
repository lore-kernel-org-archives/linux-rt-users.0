Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:46197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCNOPQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Mar 2018 10:15:16 -0400
Message-ID: <1521036913.8729.2.camel@gmx.de>
Subject: RT annoyance w. tip 03781e40890c x86/efi: Use efi_switch_mm()
 rather than manually twiddling with %cr3
From: Mike Galbraith <efault@gmx.de>
Date: Wed, 14 Mar 2018 15:15:13 +0100
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: RT <linux-rt-users@vger.kernel.org>

Greetings,

$subject puts task_lock() in preempt and irq disabled sections for RT. 
I have two solutions, neither optimal, one fugly. Better ideas welcome.

[    0.468061] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[    0.468062] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[    0.468062] 1 lock held by swapper/0/1:
[    0.468063]  #0:  (&p->alloc_lock){+.+.}, at: [<ffffffffb906e604>] efi_switch_mm+0x24/0x50
[    0.468067] Preemption disabled at:
[    0.468070] [<ffffffffb960c987>] virt_efi_get_next_variable+0x47/0x190
[    0.468072] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 4.16.0.g557ca5a-rt19-tip-rt #68
[    0.468072] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[    0.468073] Call Trace:
[    0.468077]  dump_stack+0x78/0xab
[    0.468080]  ___might_sleep+0x1f5/0x250
[    0.468083]  rt_spin_lock+0x49/0x60
[    0.468085]  ? efi_switch_mm+0x24/0x50
[    0.468086]  efi_switch_mm+0x24/0x50
[    0.468088]  virt_efi_get_next_variable+0x187/0x190
[    0.468090]  efivar_init+0xea/0x350
[    0.468093]  ? efivar_ssdt_setup+0x3b/0x3b
[    0.468096]  ? _raw_spin_unlock_irqrestore+0x85/0xa0
[    0.468097]  ? preempt_count_sub+0x6a/0xe0
[    0.468101]  efisubsys_init+0xee/0x298
[    0.468103]  ? match_config_table+0x120/0x120
[    0.468106]  do_one_initcall+0x50/0x1a7
[    0.468111]  kernel_init_freeable+0x22b/0x2b3
[    0.468112]  ? set_debug_rodata+0x11/0x11
[    0.468118]  ? rest_init+0xd0/0xd0
[    0.468119]  kernel_init+0xa/0x110
[    0.468120]  ret_from_fork+0x3a/0x50

0. revert annoying commit for RT (nope).

1. tell assorted efi goop to go away, taking lock with it.

---
 arch/x86/platform/efi/efi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -493,6 +493,8 @@ void __init efi_init(void)
 	efi_phys.systab = (efi_system_table_t *)
 			  (boot_params.efi_info.efi_systab |
 			  ((__u64)boot_params.efi_info.efi_systab_hi<<32));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		set_bit(EFI_OLD_MEMMAP, &efi.flags);
 #endif
 
 	if (efi_systab_init(efi_phys.systab))

2. move troublesome lock.

---
 arch/x86/include/asm/efi.h     |    8 ++++++++
 arch/x86/platform/efi/efi_64.c |   20 ++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -81,6 +81,10 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_setup()					\
 ({									\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {			\
+		if (!efi_enabled(EFI_OLD_MEMMAP))			\
+			spin_lock(&current->alloc_lock);		\
+	}								\
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
@@ -101,6 +105,10 @@ struct efi_scratch {
 	firmware_restrict_branch_speculation_end();			\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {			\
+		if (!efi_enabled(EFI_OLD_MEMMAP))			\
+			spin_unlock(&current->alloc_lock);		\
+	}								\
 })
 
 extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -83,7 +83,11 @@ pgd_t * __init efi_call_phys_prolog(void
 	int n_pgds, i, j;
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+			task_lock(current);
 		efi_switch_mm(&efi_mm);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+			task_unlock(current);
 		return NULL;
 	}
 
@@ -156,7 +160,11 @@ void __init efi_call_phys_epilog(pgd_t *
 	pud_t *pud;
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+			task_lock(current);
 		efi_switch_mm(efi_scratch.prev_mm);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+			task_unlock(current);
 		return;
 	}
 
@@ -626,11 +634,15 @@ void __init efi_dump_pagetable(void)
  */
 void efi_switch_mm(struct mm_struct *mm)
 {
-	task_lock(current);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		task_lock(current);
+	else
+		lockdep_assert_held(&current->alloc_lock);
 	efi_scratch.prev_mm = current->active_mm;
 	current->active_mm = mm;
 	switch_mm(efi_scratch.prev_mm, mm, NULL);
-	task_unlock(current);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		task_unlock(current);
 }
 
 #ifdef CONFIG_EFI_MIXED
@@ -683,6 +695,8 @@ efi_status_t efi_thunk_set_virtual_addre
 	unsigned long flags;
 	u32 func;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		task_lock(current);
 	efi_sync_low_kernel_mappings();
 	local_irq_save(flags);
 
@@ -694,6 +708,8 @@ efi_status_t efi_thunk_set_virtual_addre
 
 	efi_switch_mm(efi_scratch.prev_mm);
 	local_irq_restore(flags);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		task_unlock(current);
 
 	return status;
 }
