From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Wed, 10 Feb 2016 09:33:28 +0000
Message-ID: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Christoffer Dall <christoffer.dall@linaro.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-by2on0098.outbound.protection.outlook.com ([207.46.100.98]:4689
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752717AbcBJLFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Feb 2016 06:05:16 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am trying to run a kvm guest on a host with 4.4 rt3 patchset applied. (Cavium thunderX arm64 system)
Getting the following error: 

BUG: scheduling while atomic: qemu-system-aar/41889/0x00000002
[  341.647463] Modules linked in: ipv6 thunderx_edac_lmc thunderx_edac_ccpi i2c_octeon edac_core shpchp aes_ce_blk ablk_helper cryptd aes_ce_cipher ghash_ce sha2_ce sha1_ce uio_pdrv_genirq rtc_efi uio
[  341.647477] Preemption disabled at:[<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750
[  341.647478] 
[  341.647484] CPU: 2 PID: 41889 Comm: qemu-system-aar Not tainted 4.4.0-rt3-00120-gbb974fa #64
[  341.647486] Hardware name: www.cavium.com ThunderX CRB1S/ThunderX CRB1S, BIOS 0.3 Dec  3 2015
[  341.647488] Call trace:
[  341.647494] [<ffff800000097878>] dump_backtrace+0x0/0x160
[  341.647499] [<ffff8000000979fc>] show_stack+0x24/0x30
[  341.647503] [<ffff800000512608>] dump_stack+0x88/0xa8
[  341.647509] [<ffff8000000f25c0>] __schedule_bug+0x70/0xc0
[  341.647514] [<ffff8000008f8f38>] __schedule+0x510/0x580
[  341.647517] [<ffff8000008f90e8>] schedule+0x50/0xf0
[  341.647521] [<ffff8000008fa9a4>] rt_spin_lock_slowlock+0x124/0x2e0
[  341.647525] [<ffff8000008fc5e0>] rt_spin_lock+0x60/0x70
[  341.647530] [<ffff8000000bffe0>] kvm_vgic_flush_hwstate+0x60/0x278
[  341.647535] [<ffff8000000b3140>] kvm_arch_vcpu_ioctl_run+0x108/0x618
[  341.647547] [<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750
[  341.647553] [<ffff80000024b4dc>] do_vfs_ioctl+0x364/0x628
[  341.647556] [<ffff80000024b834>] SyS_ioctl+0x94/0xa8
[  341.647560] [<ffff800000093b04>] el0_svc_naked+0x38/0x3c


The below patch enables preemption:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/kvm/arm.c?h=v4.4&id=1b3d546daf85ed2bc9966e12cee3e6435fb65eca

arm/arm64: KVM: Properly account for guest CPU time

Is there a way to do it without disabling preemption ? 
Or any other way to workaround

  
 Regards, 
Manish Jaggi    