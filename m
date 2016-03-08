From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Fix preempt-rt on AT91
Date: Tue, 8 Mar 2016 19:39:10 +0100
Message-ID: <20160308183910.GD5845@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
 <20160305113553.GB21216@piout.net>
 <20160308110639.GC21842@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160308110639.GC21842@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 08/03/2016 at 12:06:39 +0100, Sebastian Andrzej Siewior wrote :
> I sucked this in. It seems to work. What remains that free_irq() thingy:
> |WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1541 __free_irq+0xb4/0x2e0()
> |Trying to free already-free IRQ 16
> |CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.4-rt10+ #219
> |Hardware name: Atmel SAMA5
> |[<c0015bd0>] (unwind_backtrace) from [<c0013604>] (show_stack+0x10/0x14)
> |[<c0013604>] (show_stack) from [<c002b850>] (warn_slowpath_common+0x80/0xac)
> |[<c002b850>] (warn_slowpath_common) from [<c002b8ac>] (warn_slowpath_fmt+0x30/0x40)
> |[<c002b8ac>] (warn_slowpath_fmt) from [<c005adfc>] (__free_irq+0xb4/0x2e0)
> |[<c005adfc>] (__free_irq) from [<c005b0a0>] (free_irq+0x30/0x4c)
> |[<c005b0a0>] (free_irq) from [<c0429034>] (pit_clkevt_shutdown+0x24/0x2c)
> |[<c0429034>] (pit_clkevt_shutdown) from [<c0076430>] (clockevents_switch_state+0x60/0x130)
> |---[ end trace 0000000000000001 ]---
> 
> which is a different problem and was there. The new thing is this:
> 
> |WARNING: CPU: 0 PID: 1 at kernel/locking/rtmutex.c:2062 rt_mutex_trylock+0x30/0x108)
> |Modules linked in:
> |CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.4.4-rt10+ #219
> |Hardware name: Atmel SAMA5
> |[<c0015bd0>] (unwind_backtrace) from [<c0013604>] (show_stack+0x10/0x14)
> |[<c0013604>] (show_stack) from [<c002b850>] (warn_slowpath_common+0x80/0xac)
> |[<c002b850>] (warn_slowpath_common) from [<c002b918>] (warn_slowpath_null+0x1c/0x24)
> |[<c002b918>] (warn_slowpath_null) from [<c054a54c>] (rt_mutex_trylock+0x30/0x108)
> |[<c054a54c>] (rt_mutex_trylock) from [<c054bd0c>] (rt_spin_trylock_irqsave+0x10/0x1c)
> |[<c054bd0c>] (rt_spin_trylock_irqsave) from [<c043e030>] (clk_enable_lock+0x18/0x114)
> |[<c043e030>] (clk_enable_lock) from [<c043f600>] (clk_disable+0x1c/0x34)
> |[<c043f600>] (clk_disable) from [<c0429188>] (tc_shutdown+0x34/0x3c)
> |[<c0429188>] (tc_shutdown) from [<c04291b0>] (tc_set_oneshot+0x20/0x50)
> |[<c04291b0>] (tc_set_oneshot) from [<c00764a4>] (clockevents_switch_state+0xd4/0x130)
> |[<c00764a4>] (clockevents_switch_state) from [<c00773e8>] (tick_switch_to_oneshot+0x48/0xb8)
> |[<c00773e8>] (tick_switch_to_oneshot) from [<c006a480>] (hrtimer_run_queues+0x48/0x108)
> |[<c006a480>] (hrtimer_run_queues) from [<c0068dd8>] (update_process_times+0x2c/0x64)
> |[<c0068dd8>] (update_process_times) from [<c0076ad0>] (tick_handle_periodic+0x1c/0x90)
> |[<c0076ad0>] (tick_handle_periodic) from [<c0429274>] (ch2_irq+0x20/0x28)
> |[<c0429274>] (ch2_irq) from [<c005a39c>] (handle_irq_event_percpu+0x74/0x16c)
> 
> Is it possible to drop this disable/enable clock on the switch from pit
> to one shot mode?
> 

Both are things to work on. In the mean time, I'm using the following
patch:
https://github.com/alexandrebelloni/linux/commit/3a2eae463fce18ae815b887a5c9ca1a657b180ac

I understood from
http://lkml.iu.edu/hypermail/linux/kernel/1601.2/00941.html that this
was not your preferred course of action.

Even if that is something that is only seen when using preempt-rt, that
is probably something I should push mainline.

> >You may also stop at 99a81706526fb167029a940ef1f7bfbe882abd3e which
> >should solve the crash but it has not been tested as thoroughly.
> 
> Did you confuse the sha1 with something? This patch is called ("clk:
> at91: remove IRQ handling and use polling") and is part of the series
> you gave (patch #3).
> 

Yeah, what I meant is that you could stop merging after that patch as
this is the one solving the crash.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
