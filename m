From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Thu, 3 Mar 2016 16:00:17 -1000
Message-ID: <nbaq7h$tme$1@ger.gmane.org>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de> <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
 <56D52CBB.2020003@sysnux.pf>
 <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
 <20160301160005.GB23985@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49633 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757734AbcCDCAd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Mar 2016 21:00:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1abf2a-0002WT-DM
	for linux-rt-users@vger.kernel.org; Fri, 04 Mar 2016 03:00:28 +0100
Received: from 141.84.50.123.dsl.dyn.mana.pf ([123.50.84.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Mar 2016 03:00:28 +0100
Received: from jd.girard by 141.84.50.123.dsl.dyn.mana.pf with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Mar 2016 03:00:28 +0100
In-Reply-To: <20160301160005.GB23985@piout.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Le 01/03/2016 06:00, Alexandre Belloni a =E9crit :
> I also have that branch for preempt-rt on at91:
>=20
> https://github.com/alexandrebelloni/linux/tree/at91-rt

I've not been able to apply the 13 patches on 4.4.3-rt9 due to
conflicts, and then kernel would not compile.

So I tried your at91-rt branch, Alexandre, and I'm pleased to report
that it works!

I'm just getting this warning:

at91_i2c f8014000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DMA
transfers
at91_i2c f8014000.i2c: AT91 i2c bus driver (hw version: 0x402).
clocksource: Switched to clocksource tcb_clksrc
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/locking/rtmutex.c:2008
rt_mutex_trylock+0x28/0xec()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.1-rt5 #1
Hardware name: Atmel AT91SAM9
[<c000ecf4>] (unwind_backtrace) from [<c000cf18>] (show_stack+0x10/0x14=
)
[<c000cf18>] (show_stack) from [<c0016720>] (warn_slowpath_common+0x80/=
0xa8)
[<c0016720>] (warn_slowpath_common) from [<c00167d8>]
(warn_slowpath_null+0x18/0x20)
[<c00167d8>] (warn_slowpath_null) from [<c03b0574>]
(rt_mutex_trylock+0x28/0xec)
[<c03b0574>] (rt_mutex_trylock) from [<c03b1a08>]
(rt_spin_trylock_irqsave+0x10/0x1)
[<c03b1a08>] (rt_spin_trylock_irqsave) from [<c0317524>]
(clk_enable_lock+0x10/0xe4)
[<c0317524>] (clk_enable_lock) from [<c03188e8>] (clk_disable+0x1c/0x34=
)
[<c03188e8>] (clk_disable) from [<c0304d74>] (tc_shutdown+0x2c/0x3c)
[<c0304d74>] (tc_shutdown) from [<c0304da4>] (tc_set_oneshot+0x20/0x50)
[<c0304da4>] (tc_set_oneshot) from [<c0058d98>]
(clockevents_switch_state+0x8c/0x12)
[<c0058d98>] (clockevents_switch_state) from [<c0059cbc>]
(tick_switch_to_oneshot+0)
[<c0059cbc>] (tick_switch_to_oneshot) from [<c004e220>]
(hrtimer_run_queues+0x34/0x)
[<c004e220>] (hrtimer_run_queues) from [<c004cde8>]
(run_local_timers+0x8/0x14)
[<c004cde8>] (run_local_timers) from [<c004ce20>]
(update_process_times+0x2c/0x5c)
[<c004ce20>] (update_process_times) from [<c0059480>]
(tick_handle_periodic+0x10/0x)
[<c0059480>] (tick_handle_periodic) from [<c0304e60>] (ch2_irq+0x20/0x2=
8)
[<c0304e60>] (ch2_irq) from [<c003ff78>]
(handle_irq_event_percpu+0x40/0x138)
[<c003ff78>] (handle_irq_event_percpu) from [<c00400d8>]
(handle_irq_event+0x68/0x9)
[<c00400d8>] (handle_irq_event) from [<c0042ff4>]
(handle_fasteoi_irq+0xa8/0x1a4)
[<c0042ff4>] (handle_fasteoi_irq) from [<c003f820>]
(generic_handle_irq+0x18/0x28)
[<c003f820>] (generic_handle_irq) from [<c003fa68>]
(__handle_domain_irq+0x7c/0xa0)
[<c003fa68>] (__handle_domain_irq) from [<c000d8f0>] (__irq_svc+0x50/0x=
98)
[<c000d8f0>] (__irq_svc) from [<c000f0dc>] (printascii+0x2c/0x58)
[<c000f0dc>] (printascii) from [<c000f178>] (early_console_write+0x30/0=
x214)
[<c000f178>] (early_console_write) from [<c003ca2c>]
(call_console_drivers.constpro)
[<c003ca2c>] (call_console_drivers.constprop.13) from [<c003e608>]
(console_unlock+)
[<c003e608>] (console_unlock) from [<c003ec64>] (vprintk_emit+0x448/0x4=
84)
[<c003ec64>] (vprintk_emit) from [<c003edb4>] (vprintk_default+0x1c/0x2=
4)
[<c003edb4>] (vprintk_default) from [<c006987c>] (printk+0x6c/0x80)
[<c006987c>] (printk) from [<c0055b88>] (__clocksource_select+0x12c/0x1=
4c)
[<c0055b88>] (__clocksource_select) from [<c051038c>]
(clocksource_done_booting+0x2)
[<c051038c>] (clocksource_done_booting) from [<c00097a0>]
(do_one_initcall+0x104/0x)
[<c00097a0>] (do_one_initcall) from [<c0509d0c>]
(kernel_init_freeable+0xfc/0x1c0)
[<c0509d0c>] (kernel_init_freeable) from [<c03ae1c4>] (kernel_init+0x8/=
0xe4)
[<c03ae1c4>] (kernel_init) from [<c000a378>] (ret_from_fork+0x14/0x3c)
---[ end trace 0000000000000001 ]---

But the arietta seems to run fine. I'm getting about 100 - 250 =B5s
latencies on a simple GPIO test.


Thanks,
--=20
Jean-Denis Girard

SysNux                Syst=E8mes   Linux   en   Polyn=E9sie   fran=E7ai=
se
http://www.sysnux.pf/ T=E9l: +689 40.50.10.40 / GSM: +689 87.79.75.27


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
