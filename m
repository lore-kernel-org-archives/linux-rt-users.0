From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Fri, 4 Mar 2016 12:11:34 +0200
Message-ID: <56D95F56.3080904@ti.com>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de> <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
 <56D52CBB.2020003@sysnux.pf>
 <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
 <20160301160005.GB23985@piout.net> <nbaq7h$tme$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jean-Denis Girard <jd.girard@sysnux.pf>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41030 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbcCDKLs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2016 05:11:48 -0500
In-Reply-To: <nbaq7h$tme$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/04/2016 04:00 AM, Jean-Denis Girard wrote:
> Hi,
>
> Le 01/03/2016 06:00, Alexandre Belloni a =E9crit :
>> I also have that branch for preempt-rt on at91:
>>
>> https://github.com/alexandrebelloni/linux/tree/at91-rt
>
> I've not been able to apply the 13 patches on 4.4.3-rt9 due to
> conflicts, and then kernel would not compile.
>
> So I tried your at91-rt branch, Alexandre, and I'm pleased to report
> that it works!
>
> I'm just getting this warning:
>
> at91_i2c f8014000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DM=
A
> transfers
> at91_i2c f8014000.i2c: AT91 i2c bus driver (hw version: 0x402).
> clocksource: Switched to clocksource tcb_clksrc
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/locking/rtmutex.c:2008
> rt_mutex_trylock+0x28/0xec()
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.1-rt5 #1
> Hardware name: Atmel AT91SAM9
> [<c000ecf4>] (unwind_backtrace) from [<c000cf18>] (show_stack+0x10/0x=
14)
> [<c000cf18>] (show_stack) from [<c0016720>] (warn_slowpath_common+0x8=
0/0xa8)
> [<c0016720>] (warn_slowpath_common) from [<c00167d8>]
> (warn_slowpath_null+0x18/0x20)
> [<c00167d8>] (warn_slowpath_null) from [<c03b0574>]
> (rt_mutex_trylock+0x28/0xec)
> [<c03b0574>] (rt_mutex_trylock) from [<c03b1a08>]
> (rt_spin_trylock_irqsave+0x10/0x1)
> [<c03b1a08>] (rt_spin_trylock_irqsave) from [<c0317524>]
> (clk_enable_lock+0x10/0xe4)
> [<c0317524>] (clk_enable_lock) from [<c03188e8>] (clk_disable+0x1c/0x=
34)
> [<c03188e8>] (clk_disable) from [<c0304d74>] (tc_shutdown+0x2c/0x3c)
> [<c0304d74>] (tc_shutdown) from [<c0304da4>] (tc_set_oneshot+0x20/0x5=
0)
> [<c0304da4>] (tc_set_oneshot) from [<c0058d98>]
> (clockevents_switch_state+0x8c/0x12)
> [<c0058d98>] (clockevents_switch_state) from [<c0059cbc>]
> (tick_switch_to_oneshot+0)
> [<c0059cbc>] (tick_switch_to_oneshot) from [<c004e220>]
> (hrtimer_run_queues+0x34/0x)
> [<c004e220>] (hrtimer_run_queues) from [<c004cde8>]
> (run_local_timers+0x8/0x14)
> [<c004cde8>] (run_local_timers) from [<c004ce20>]
> (update_process_times+0x2c/0x5c)
> [<c004ce20>] (update_process_times) from [<c0059480>]
> (tick_handle_periodic+0x10/0x)
> [<c0059480>] (tick_handle_periodic) from [<c0304e60>] (ch2_irq+0x20/0=
x28)
> [<c0304e60>] (ch2_irq) from [<c003ff78>]
> (handle_irq_event_percpu+0x40/0x138)
> [<c003ff78>] (handle_irq_event_percpu) from [<c00400d8>]
> (handle_irq_event+0x68/0x9)
> [<c00400d8>] (handle_irq_event) from [<c0042ff4>]
> (handle_fasteoi_irq+0xa8/0x1a4)
> [<c0042ff4>] (handle_fasteoi_irq) from [<c003f820>]
> (generic_handle_irq+0x18/0x28)
> [<c003f820>] (generic_handle_irq) from [<c003fa68>]
> (__handle_domain_irq+0x7c/0xa0)
> [<c003fa68>] (__handle_domain_irq) from [<c000d8f0>] (__irq_svc+0x50/=
0x98)
> [<c000d8f0>] (__irq_svc) from [<c000f0dc>] (printascii+0x2c/0x58)
> [<c000f0dc>] (printascii) from [<c000f178>] (early_console_write+0x30=
/0x214)
> [<c000f178>] (early_console_write) from [<c003ca2c>]
> (call_console_drivers.constpro)
> [<c003ca2c>] (call_console_drivers.constprop.13) from [<c003e608>]
> (console_unlock+)
> [<c003e608>] (console_unlock) from [<c003ec64>] (vprintk_emit+0x448/0=
x484)
> [<c003ec64>] (vprintk_emit) from [<c003edb4>] (vprintk_default+0x1c/0=
x24)
> [<c003edb4>] (vprintk_default) from [<c006987c>] (printk+0x6c/0x80)
> [<c006987c>] (printk) from [<c0055b88>] (__clocksource_select+0x12c/0=
x14c)
> [<c0055b88>] (__clocksource_select) from [<c051038c>]
> (clocksource_done_booting+0x2)
> [<c051038c>] (clocksource_done_booting) from [<c00097a0>]
> (do_one_initcall+0x104/0x)
> [<c00097a0>] (do_one_initcall) from [<c0509d0c>]
> (kernel_init_freeable+0xfc/0x1c0)
> [<c0509d0c>] (kernel_init_freeable) from [<c03ae1c4>] (kernel_init+0x=
8/0xe4)
> [<c03ae1c4>] (kernel_init) from [<c000a378>] (ret_from_fork+0x14/0x3c=
)
> ---[ end trace 0000000000000001 ]---
>
> But the arietta seems to run fine. I'm getting about 100 - 250 =B5s
> latencies on a simple GPIO test.
>

Yeah. You can't use CLK framework in atomic context on -RT [1], [2].

[1] http://www.spinics.net/lists/linux-rt-users/msg13653.html
[2] https://lkml.org/lkml/2015/10/20/783
--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
