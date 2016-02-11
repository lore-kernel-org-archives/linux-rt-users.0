From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 10:46:16 +0000
Message-ID: <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>,<20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:44404
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750782AbcBKKqU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 05:46:20 -0500
In-Reply-To: <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Josh.
I tried both options
a) replace prempt_XXX with migrate_XXX as per the patch
b) replacing spin_lock in kvm_vgic_flush_hwstate with raw_spin_lock

Host and guest has NO_HZ_FULL=y 
The cyclictest avg latency / max latency are very high in guest.

host: Avg:   28 Max:     180
guest: Avg:  168 Max:   19532

Running guest within a cset created with -k option

Regards,
Manish Jaggi

________________________________________
From: Josh Cartwright <joshc@ni.com>
Sent: Wednesday, February 10, 2016 10:09 PM
To: Jaggi, Manish
Cc: linux-rt-users; Christoffer Dall
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750

On Wed, Feb 10, 2016 at 09:33:28AM +0000, Jaggi, Manish wrote:
> I am trying to run a kvm guest on a host with 4.4 rt3 patchset
> applied. (Cavium thunderX arm64 system) Getting the following error:
>
> BUG: scheduling while atomic: qemu-system-aar/41889/0x00000002
> [  341.647463] Modules linked in: ipv6 thunderx_edac_lmc thunderx_edac_ccpi i2c_octeon edac_core shpchp aes_ce_blk ablk_helper cryptd aes_ce_cipher ghash_ce sha2_ce sha1_ce uio_pdrv_genirq rtc_efi uio
> [  341.647477] Preemption disabled at:[<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750
> [  341.647478]
> [  341.647484] CPU: 2 PID: 41889 Comm: qemu-system-aar Not tainted 4.4.0-rt3-00120-gbb974fa #64
> [  341.647486] Hardware name: www.cavium.com ThunderX CRB1S/ThunderX CRB1S, BIOS 0.3 Dec  3 2015
> [  341.647488] Call trace:
> [  341.647494] [<ffff800000097878>] dump_backtrace+0x0/0x160
> [  341.647499] [<ffff8000000979fc>] show_stack+0x24/0x30
> [  341.647503] [<ffff800000512608>] dump_stack+0x88/0xa8
> [  341.647509] [<ffff8000000f25c0>] __schedule_bug+0x70/0xc0
> [  341.647514] [<ffff8000008f8f38>] __schedule+0x510/0x580
> [  341.647517] [<ffff8000008f90e8>] schedule+0x50/0xf0
> [  341.647521] [<ffff8000008fa9a4>] rt_spin_lock_slowlock+0x124/0x2e0
> [  341.647525] [<ffff8000008fc5e0>] rt_spin_lock+0x60/0x70
> [  341.647530] [<ffff8000000bffe0>] kvm_vgic_flush_hwstate+0x60/0x278
> [  341.647535] [<ffff8000000b3140>] kvm_arch_vcpu_ioctl_run+0x108/0x618
> [  341.647547] [<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750
> [  341.647553] [<ffff80000024b4dc>] do_vfs_ioctl+0x364/0x628
> [  341.647556] [<ffff80000024b834>] SyS_ioctl+0x94/0xa8
> [  341.647560] [<ffff800000093b04>] el0_svc_naked+0x38/0x3c
>
> The below patch enables preemption:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/kvm/arm.c?h=v4.4&id=1b3d546daf85ed2bc9966e12cee3e6435fb65eca

Another relevant commit is 7e16aa81f9f6a7cfe2287b788a7d62abc2880185:

  Author: Christoffer Dall <christoffer.dall@linaro.org>

  KVM: arm/arm64: Fix preemptible timer active state crazyness

  We were setting the physical active state on the GIC distributor in a
  preemptible section, which could cause us to set the active state on
  different physical CPU from the one we were actually going to run on,
  hacoc ensues.

  Since we are no longer descheduling/scheduling soft timers in the
  flush/sync timer functions, simply moving the timer flush into a
  non-preemptible section.

  Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
  Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

> arm/arm64: KVM: Properly account for guest CPU time
>
> Is there a way to do it without disabling preemption ?

If the concern is touching the wrong per-CPU GIC distributor registers,
it should be sufficient on -rt to downgrade the preempt_disable() /
preempt_enable() to a migrate_disable() / migrate_enable(), which is
preemptible, but prevents the task from moving to another CPU.

  Josh

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4f5c42a..2ce9cc2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -568,7 +568,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
                 * involves poking the GIC, which must be done in a
                 * non-preemptible context.
                 */
-               preempt_disable();
+               migrate_disable();
                kvm_timer_flush_hwstate(vcpu);
                kvm_vgic_flush_hwstate(vcpu);

@@ -587,7 +587,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
                        local_irq_enable();
                        kvm_timer_sync_hwstate(vcpu);
                        kvm_vgic_sync_hwstate(vcpu);
-                       preempt_enable();
+                       migrate_enable();
                        continue;
                }

@@ -641,7 +641,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)

                kvm_vgic_sync_hwstate(vcpu);

-               preempt_enable();
+               migrate_enable();

                ret = handle_exit(vcpu, run, ret);
        }
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e4a0b8c..dec1156 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2135,7 +2135,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *     This call sets the internal irqchip state of an interrupt,
  *     depending on the value of @which.
  *
- *     This function should be called with preemption disabled if the
+ *     This function should be called with migration disabled if the
  *     interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
