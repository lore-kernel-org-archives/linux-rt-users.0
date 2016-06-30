From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 14:44:42 -0500
Message-ID: <577576AA.8040004@mvista.com>
References: <20160630094301.22d32ec1@gandalf.local.home>
 <5775316F.2020102@acm.org> <20160630115101.6337c395@gandalf.local.home>
 <20160630160128.GA4365@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org> <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org> <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org> <20160630182257.GD3932@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35982 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcF3Tuk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 15:50:40 -0400
Received: by mail-oi0-f51.google.com with SMTP id f189so80894106oig.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 12:50:40 -0700 (PDT)
In-Reply-To: <20160630182257.GD3932@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/30/2016 01:22 PM, Borislav Petkov wrote:
> On Thu, Jun 30, 2016 at 12:54:14PM -0500, Corey Minyard wrote:
>> It won't crash.  If you disable PREEMPT_RT on the 3.10-rt kernel it won't
>> crash (which I have tested).  With PREEMPT_RT, the kernel creates a
>> separate thread that is woken on mce notifications.  The trouble is
>> that the interrupts are initialized before the thread is created.
> Hmmm.
>
> Ok, so I don't have any idea what RT does but from looking at your splat:
>
> [    0.164153] Call Trace:
> [    0.164165]  <IRQ>
> [    0.164185]  [<ffffffff8106dcd8>] try_to_wake_up+0x28/0x320
> [    0.164188]  [<ffffffff8106dfe0>] wake_up_process+0x10/0x20
> [    0.164207]  [<ffffffff8101c548>] mce_notify_irq+0x28/0x30
> [    0.164210]  [<ffffffff8101df35>] intel_threshold_interrupt+0xb5/0xd0
> [    0.164213]  [<ffffffff8101e88c>] smp_threshold_interrupt+0x1c/0x40
> [    0.164221]  [<ffffffff816f9b5a>] threshold_interrupt+0x6a/0x70
> [    0.164223]  <EOI>
> [    0.164226]  [<ffffffff8101dda7>] ? cmci_recheck+0x67/0x70
> [    0.164241]  [<ffffffff816e9777>] setup_local_APIC+0x276/0x283
> [    0.164259]  [<ffffffff81caf010>] native_smp_prepare_cpus+0x379/0x43b
> [    0.164266]  [<ffffffff81ca3e4f>] kernel_init_freeable+0xd7/0x21a
> [    0.164270]  [<ffffffff816df1f0>] ? rest_init+0x90/0x90
> [    0.164272]  [<ffffffff816df1f9>] kernel_init+0x9/0x180
> [    0.164275]  [<ffffffff816f8dc8>] ret_from_fork+0x58/0x90
> [    0.164277]  [<ffffffff816df1f0>] ? rest_init+0x90/0x90
> [    0.164295] Code: e7 ff ff 48 8b 7d 08 e8 02 1a 95 ff 5d c3 55 48 89 e5 41
> 54 53 48 89 fb 9c 41 5c fa bf 01 00 00 00 e8 a8 38 00 00 ba 00 01 00 00 <f0>
> 66 0f c1 13 0f b6 ce 38 d1 74 10 0f 1f 80 00 00 00 00 f3 90
> [    0.164298] RIP  [<ffffffff816f344d>] _raw_spin_lock_irqsave+0x1d/0x50
> [    0.164298]  RSP <ffff88017fa03f00>
> [    0.164299] CR2: 0000000000000600
> [    0.656225] ---[ end trace 0000000000000001 ]---
> [    0.656233] Kernel panic - not syncing: Fatal exception in interrupt
>
> we're 0.16 seconds within the boot and we're just initializing the local
> APIC and the moment that happens, we get a thresholding APIC interrupt.
>
> So how can interrupts be initialized before that?

I don't think they are.  I think there is something about this
particular board.  We aren't having any issues with other systems.

But as you say, the kernel should be ready for this.

>
> I'm genuinely asking because I can't imagine how CMCI can get initialized
> *after* the local APIC init.
>
> Because, we do init CMCI in identify_cpu()->mcheck_cpu_init() and that
> happens earlier than your splat. You can even see where it happens in
> dmesg:
>
> [    0.049270] mce: CPU supports 22 MCE banks
> [    0.049383] CPU0: Thermal monitoring enabled (TM1)
>
> First line is __mcheck_cpu_cap_init(), second is intel_init_thermal().
>
> The CMCI initialization is done right after it in
>
> void mce_intel_feature_init(struct cpuinfo_x86 *c)
> {
>          intel_init_thermal(c);
>          intel_init_cmci();
>
>
> but wait!, this is the upstream kernel. Where can I look at 3.10-rt
> sources?

They are at:

git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git 
v3.10-rt

-corey
