From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 22:34:57 +0200
Message-ID: <20160630203457.GF3932@pd.tnic>
References: <20160630115101.6337c395@gandalf.local.home>
 <20160630160128.GA4365@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org>
 <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org>
 <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org>
 <20160630182257.GD3932@pd.tnic>
 <577576AA.8040004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Corey Minyard <minyard@acm.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57334 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbcF3Uni (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 16:43:38 -0400
Content-Disposition: inline
In-Reply-To: <577576AA.8040004@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jun 30, 2016 at 02:44:42PM -0500, Corey Minyard wrote:
> >[    0.164153] Call Trace:
> >[    0.164165]  <IRQ>
> >[    0.164185]  [<ffffffff8106dcd8>] try_to_wake_up+0x28/0x320
> >[    0.164188]  [<ffffffff8106dfe0>] wake_up_process+0x10/0x20
> >[    0.164207]  [<ffffffff8101c548>] mce_notify_irq+0x28/0x30
> >[    0.164210]  [<ffffffff8101df35>] intel_threshold_interrupt+0xb5/0xd0
> >[    0.164213]  [<ffffffff8101e88c>] smp_threshold_interrupt+0x1c/0x40
> >[    0.164221]  [<ffffffff816f9b5a>] threshold_interrupt+0x6a/0x70
> >[    0.164223]  <EOI>
> >[    0.164226]  [<ffffffff8101dda7>] ? cmci_recheck+0x67/0x70
> >[    0.164241]  [<ffffffff816e9777>] setup_local_APIC+0x276/0x283
> >[    0.164259]  [<ffffffff81caf010>] native_smp_prepare_cpus+0x379/0x43b
> >[    0.164266]  [<ffffffff81ca3e4f>] kernel_init_freeable+0xd7/0x21a
> >[    0.164270]  [<ffffffff816df1f0>] ? rest_init+0x90/0x90
> >[    0.164272]  [<ffffffff816df1f9>] kernel_init+0x9/0x180
> >[    0.164275]  [<ffffffff816f8dc8>] ret_from_fork+0x58/0x90
> >[    0.164277]  [<ffffffff816df1f0>] ? rest_init+0x90/0x90
> >[    0.164295] Code: e7 ff ff 48 8b 7d 08 e8 02 1a 95 ff 5d c3 55 48 89 e5 41
> >54 53 48 89 fb 9c 41 5c fa bf 01 00 00 00 e8 a8 38 00 00 ba 00 01 00 00 <f0>
> >66 0f c1 13 0f b6 ce 38 d1 74 10 0f 1f 80 00 00 00 00 f3 90
> >[    0.164298] RIP  [<ffffffff816f344d>] _raw_spin_lock_irqsave+0x1d/0x50
> >[    0.164298]  RSP <ffff88017fa03f00>
> >[    0.164299] CR2: 0000000000000600
> >[    0.656225] ---[ end trace 0000000000000001 ]---
> >[    0.656233] Kernel panic - not syncing: Fatal exception in interrupt
> >
> >we're 0.16 seconds within the boot and we're just initializing the local
> >APIC and the moment that happens, we get a thresholding APIC interrupt.
> >
> >So how can interrupts be initialized before that?
> 
> I don't think they are.  I think there is something about this
> particular board.  We aren't having any issues with other systems.

Right, so the fact that it raises the thresholding interrupt could
mean that it generates a bunch of correctable ECC errors and it hits a
threshold which is signalled by that interrupt.

And if that is true, then you should be seeing some errors in mcelog or
sb_edac reporting some.

You could, just in case, try latest upstream and enable
CONFIG_EDAC_SBRIDGE and check dmesg for some ECCs.

Or, of course, something else entirely might be funny with that box,
causing that interrupt to fire.

> But as you say, the kernel should be ready for this.

Right, and we've removed that mce_notify_irq() call in
intel_threshold_interrupt() with

  f29a7aff4bd6 ("x86/mce: Avoid potential deadlock due to printk() in MCE context")

but that's more of a side-effect of that patch.

And if you want to backport it, you'd need the mce_gen_pool_add() and
remaining machinery for the genpool.

Presumably, booting with "mce=no_cmci" should fix this but then you
won't have the CMCI thresholding, i.e., the interrupt which gets raised
when a certain amount of correctable errors has been generated.

Hmm, a funny box that.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
