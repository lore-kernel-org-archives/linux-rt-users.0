From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] kvm: Convert pvclock_gtod_sync_lock to raw_spinlock_t
Date: Mon, 26 Dec 2016 07:54:08 +0100
Message-ID: <1482735248.4476.58.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbcLZGy2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Dec 2016 01:54:28 -0500
In-Reply-To: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fix splat below.  Lock is short hold, make it raw.

[15528.614216] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:995
[15528.614218] in_atomic(): 0, irqs_disabled(): 1, pid: 19619, name: qemu-system-x86
[15528.614218] no locks held by qemu-system-x86/19619.
[15528.614219] irq event stamp: 321840
[15528.614224] hardirqs last  enabled at (321839): [<ffffffff816a8467>] entry_SYSCALL_64_fastpath+0x5/0xc2
[15528.614244] hardirqs last disabled at (321840): [<ffffffffa08578f4>] kvm_arch_vm_ioctl+0x234/0xda0 [kvm]
[15528.614246] softirqs last  enabled at (0): [<ffffffff81077e8a>] copy_process.part.36+0x5ba/0x20b0
[15528.614247] softirqs last disabled at (0): [<          (null)>]           (null)
[15528.614250] CPU: 7 PID: 19619 Comm: qemu-system-x86 Tainted: G            E   4.9.0-rt1-virgin #1
[15528.614250] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[15528.614253]  ffffc9000b98bc30 ffffffff8136874d 0000000000000000 ffff8803e76db200
[15528.614255]  ffffc9000b98bc68 ffffffff810abe9d ffff8800353472d0 ffff8800353472d0
[15528.614257]  00007ffc53dbc2b0 000000000000000b 00007ffc53dbc2b0 ffffc9000b98bc88
[15528.614257] Call Trace:
[15528.614262]  [<ffffffff8136874d>] dump_stack+0x85/0xc8
[15528.614266]  [<ffffffff810abe9d>] ___might_sleep+0x15d/0x260
[15528.614268]  [<ffffffff816a7ca4>] rt_spin_lock+0x24/0x80
[15528.614283]  [<ffffffffa084b212>] __get_kvmclock_ns+0x22/0xf0 [kvm]
[15528.614297]  [<ffffffffa08578fc>] kvm_arch_vm_ioctl+0x23c/0xda0 [kvm]
[15528.614300]  [<ffffffff810dc5d5>] ? __lock_acquire+0x305/0x16a0
[15528.614301]  [<ffffffff8107d916>] ? unpin_current_cpu+0x16/0x70
[15528.614314]  [<ffffffffa08409dd>] kvm_vm_ioctl+0x9d/0x920 [kvm]
[15528.614316]  [<ffffffff8127b547>] ? __fget+0x107/0x220
[15528.614318]  [<ffffffff810da5f9>] ? __lock_is_held+0x49/0x70
[15528.614320]  [<ffffffff8126e9b6>] do_vfs_ioctl+0x96/0x6c0
[15528.614321]  [<ffffffff8127b564>] ? __fget+0x124/0x220
[15528.614322]  [<ffffffff8127b445>] ? __fget+0x5/0x220
[15528.614324]  [<ffffffff8126f021>] SyS_ioctl+0x41/0x70
[15528.614326]  [<ffffffff816a8481>] entry_SYSCALL_64_fastpath+0x1f/0xc2

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/x86/include/asm/kvm_host.h |    2 +-
 arch/x86/kvm/x86.c              |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -755,7 +755,7 @@ struct kvm_arch {
 	u64 cur_tsc_generation;
 	int nr_vcpus_matched_tsc;
 
-	spinlock_t pvclock_gtod_sync_lock;
+	raw_spinlock_t pvclock_gtod_sync_lock;
 	bool use_master_clock;
 	u64 master_kernel_ns;
 	cycle_t master_cycle_now;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1540,7 +1540,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu
 	kvm_vcpu_write_tsc_offset(vcpu, offset);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 
-	spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
+	raw_spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
 	if (!matched) {
 		kvm->arch.nr_vcpus_matched_tsc = 0;
 	} else if (!already_matched) {
@@ -1548,7 +1548,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu
 	}
 
 	kvm_track_tsc_matching(vcpu);
-	spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);
+	raw_spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);
 }
 
 EXPORT_SYMBOL_GPL(kvm_write_tsc);
@@ -1715,7 +1715,7 @@ static void kvm_gen_update_masterclock(s
 	struct kvm_vcpu *vcpu;
 	struct kvm_arch *ka = &kvm->arch;
 
-	spin_lock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_lock(&ka->pvclock_gtod_sync_lock);
 	kvm_make_mclock_inprogress_request(kvm);
 	/* no guest entries from this point */
 	pvclock_update_vm_gtod_copy(kvm);
@@ -1727,7 +1727,7 @@ static void kvm_gen_update_masterclock(s
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		clear_bit(KVM_REQ_MCLOCK_INPROGRESS, &vcpu->requests);
 
-	spin_unlock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_unlock(&ka->pvclock_gtod_sync_lock);
 #endif
 }
 
@@ -1736,15 +1736,15 @@ static u64 __get_kvmclock_ns(struct kvm
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 
-	spin_lock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_lock(&ka->pvclock_gtod_sync_lock);
 	if (!ka->use_master_clock) {
-		spin_unlock(&ka->pvclock_gtod_sync_lock);
+		raw_spin_unlock(&ka->pvclock_gtod_sync_lock);
 		return ktime_get_boot_ns() + ka->kvmclock_offset;
 	}
 
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-	spin_unlock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_unlock(&ka->pvclock_gtod_sync_lock);
 
 	kvm_get_time_scale(NSEC_PER_SEC, __this_cpu_read(cpu_tsc_khz) * 1000LL,
 			   &hv_clock.tsc_shift,
@@ -1835,13 +1835,13 @@ static int kvm_guest_time_update(struct
 	 * If the host uses TSC clock, then passthrough TSC as stable
 	 * to the guest.
 	 */
-	spin_lock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_lock(&ka->pvclock_gtod_sync_lock);
 	use_master_clock = ka->use_master_clock;
 	if (use_master_clock) {
 		host_tsc = ka->master_cycle_now;
 		kernel_ns = ka->master_kernel_ns;
 	}
-	spin_unlock(&ka->pvclock_gtod_sync_lock);
+	raw_spin_unlock(&ka->pvclock_gtod_sync_lock);
 
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
@@ -7831,7 +7831,7 @@ int kvm_arch_init_vm(struct kvm *kvm, un
 
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
 	mutex_init(&kvm->arch.apic_map_lock);
-	spin_lock_init(&kvm->arch.pvclock_gtod_sync_lock);
+	raw_spin_lock_init(&kvm->arch.pvclock_gtod_sync_lock);
 
 	kvm->arch.kvmclock_offset = -ktime_get_boot_ns();
 	pvclock_update_vm_gtod_copy(kvm);
