From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Intel graphics and kernel RT failure
Date: Fri, 5 Jun 2009 00:21:05 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr>
References: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Hector Centeno <hcengar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:36287 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZFDWVE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jun 2009 18:21:04 -0400
In-Reply-To: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>




Cc'ing linux-rt. Mabye someone has a flash of an idea.

On Thursday 2009-06-04 23:42, Hector Centeno wrote to Jan Engelhardt:
>
>I hope it is OK to contact you directly to this email. I've been
>trying to use your 2.6.29 RT kernel for OpenSuse 11.1 and came across
>some problems related to the Intel graphics driver (I have a laptop
>with intel GMA 950). The problem seems to be related to the new intel
>driver development that is going on and that seems to affect older
>hardware like mine. I get a constantly growing list of errors in
>/var/log/mesages like these:
>
>kernel: BUG: using smp_processor_id() in preemptible [00000000] code: X/3257
>kernel: caller is kmap_atomic_prot_pfn+0x1a/0x94
>kernel: Pid: 3257, comm: X Tainted: G   N  2.6.29.4-jen80-rt #1
>kernel: Call Trace:
>kernel:  [<b033c3f2>] ? printk+0xf/0x15
>kernel:  [<b022712e>] debug_smp_processor_id+0xa6/0xbc
>kernel:  [<b011d617>] kmap_atomic_prot_pfn+0x1a/0x94
>kernel:  [<f8a23c4c>] i915_gem_object_flush_cpu_write_domain+0x1c/0x27 [i915]
>kernel:  [<b011d6b7>] iomap_atomic_prot_pfn+0x26/0x2b
>kernel:  [<f8a270be>] i915_gem_gtt_pwrite+0x102/0x1b8 [i915]
>kernel:  [<f8a27290>] i915_gem_pwrite_ioctl+0x11c/0x1a8 [i915]
>kernel:  [<b0223e73>] ? copy_from_user+0x34/0x11b
>kernel:  [<f89d2776>] drm_ioctl+0x1b7/0x22f [drm]
>kernel:  [<f8a27174>] ? i915_gem_pwrite_ioctl+0x0/0x1a8 [i915]
>kernel:  [<b01ae63f>] vfs_ioctl+0x4e/0x67
>kernel:  [<b01aec30>] do_vfs_ioctl+0x22a/0x242
>kernel:  [<b01aec88>] sys_ioctl+0x40/0x5a
>kernel:  [<b01032fc>] sysenter_do_call+0x12/0x28
>kernel: BUG: using smp_processor_id() in preemptible [00000000] code: X/3257
>kernel: caller is iounmap_atomic+0x18/0x9b
>kernel: Pid: 3257, comm: X Tainted: G   N  2.6.29.4-jen80-rt #1
>kernel: Call Trace:
>kernel:  [<b033c3f2>] ? printk+0xf/0x15
>kernel:  [<b022712e>] debug_smp_processor_id+0xa6/0xbc
>kernel:  [<b011d57a>] iounmap_atomic+0x18/0x9b
>kernel:  [<f8a270df>] i915_gem_gtt_pwrite+0x123/0x1b8 [i915]
>kernel:  [<f8a27290>] i915_gem_pwrite_ioctl+0x11c/0x1a8 [i915]
>kernel:  [<b0223e73>] ? copy_from_user+0x34/0x11b
>kernel:  [<f89d2776>] drm_ioctl+0x1b7/0x22f [drm]
>kernel:  [<f8a27174>] ? i915_gem_pwrite_ioctl+0x0/0x1a8 [i915]
>kernel:  [<b01ae63f>] vfs_ioctl+0x4e/0x67
>kernel:  [<b01aec30>] do_vfs_ioctl+0x22a/0x242
>kernel:  [<b01aec88>] sys_ioctl+0x40/0x5a
>kernel:  [<b01032fc>] sysenter_do_call+0x12/0x28
>
>I'm assuming it is related to the Intel graphics driver because there
>is mention to i915 but I might be wrong. If the Intel driver is
>causing this I wonder if this has been fixed in upstream [...]
