Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:41421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755816AbeFZCc3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jun 2018 22:32:29 -0400
Message-ID: <1529980339.7358.4.camel@gmx.de>
Subject: [patch-rt] arm/efi: use a local_lock() in efi_virtmap_load()
From: Mike Galbraith <efault@gmx.de>
Date: Tue, 26 Jun 2018 04:32:19 +0200
In-Reply-To: <20180518091936.j5ep2tqvhba5lta7@linutronix.de>
References: <20180518091936.j5ep2tqvhba5lta7@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2018-05-18 at 11:19 +0200, Sebastian Andrzej Siewior wrote:
> 
>   - Add a locallock during saving/restoring of SIMD registers on ARM64.
>     On RT we are preemptible there so extra protection is required.

From: Mike Galbraith <efault@gmx.de>

[    2.106296] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[    2.106361] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[    2.106416] Preemption disabled at:
[    2.106556] [<ffff0b5ce3b2cf58>] efi_virtmap_load+0x18/0x38
[    2.106761] CPU: 7 PID: 1 Comm: swapper/0 Not tainted 4.16.17-rt7-rt #4
[    2.106775] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    2.106902] Call trace:
[    2.106927]  dump_backtrace+0x0/0x1c8
[    2.106948]  show_stack+0x24/0x30
[    2.106957]  dump_stack+0xac/0xe8
[    2.106966]  ___might_sleep+0x124/0x188
[    2.106973]  rt_spin_lock+0x40/0x88
[    2.106993]  kernel_neon_begin+0x90/0x170
[    2.107008]  __efi_fpsimd_begin+0x68/0x1a0
[    2.107019]  virt_efi_get_next_variable+0x48/0xc8
[    2.107026]  efivar_init+0xb0/0x380
[    2.107039]  efisubsys_init+0xd4/0x26c
[    2.107045]  do_one_initcall+0x58/0x168
[    2.107053]  kernel_init_freeable+0x1e0/0x284
[    2.107062]  kernel_init+0x18/0x118
[    2.107071]  ret_from_fork+0x10/0x18

("arm64: fpsimd: use a local_lock() in addition to local_bh_disable()")
added a local_lock(), which efi_virtmap_load()/efi_virtmap_unload() can
encase in a preempt disabled section during boot.  Make that section
preemptible via another local_lock().

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/arm64/kernel/fpsimd.c         |    3 ++-
 drivers/firmware/efi/arm-runtime.c |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1201,7 +1201,8 @@ void __efi_fpsimd_begin(void)
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
 
 
