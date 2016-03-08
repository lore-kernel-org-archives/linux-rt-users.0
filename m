From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Fix preempt-rt on AT91
Date: Tue, 8 Mar 2016 12:06:39 +0100
Message-ID: <20160308110639.GC21842@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
 <20160305113553.GB21216@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160305113553.GB21216@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Alexandre Belloni | 2016-03-05 12:35:53 [+0100]:

>Hi Sebastian,
Hi Alexandre,

>The series landed in arm-soc and is making its way to v4.6. I guess you
>can pull the original pull request. It is based on v4.5-rc1 but should
>apply cleanly on v4.4:

I sucked this in. It seems to work. What remains that free_irq() thingy:
|WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1541 __free_irq+0xb4/0x2e0()
|Trying to free already-free IRQ 16
|CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.4-rt10+ #219
|Hardware name: Atmel SAMA5
|[<c0015bd0>] (unwind_backtrace) from [<c0013604>] (show_stack+0x10/0x14)
|[<c0013604>] (show_stack) from [<c002b850>] (warn_slowpath_common+0x80/0xac)
|[<c002b850>] (warn_slowpath_common) from [<c002b8ac>] (warn_slowpath_fmt+0x30/0x40)
|[<c002b8ac>] (warn_slowpath_fmt) from [<c005adfc>] (__free_irq+0xb4/0x2e0)
|[<c005adfc>] (__free_irq) from [<c005b0a0>] (free_irq+0x30/0x4c)
|[<c005b0a0>] (free_irq) from [<c0429034>] (pit_clkevt_shutdown+0x24/0x2c)
|[<c0429034>] (pit_clkevt_shutdown) from [<c0076430>] (clockevents_switch_state+0x60/0x130)
|---[ end trace 0000000000000001 ]---

which is a different problem and was there. The new thing is this:

|WARNING: CPU: 0 PID: 1 at kernel/locking/rtmutex.c:2062 rt_mutex_trylock+0x30/0x108)
|Modules linked in:
|CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.4.4-rt10+ #219
|Hardware name: Atmel SAMA5
|[<c0015bd0>] (unwind_backtrace) from [<c0013604>] (show_stack+0x10/0x14)
|[<c0013604>] (show_stack) from [<c002b850>] (warn_slowpath_common+0x80/0xac)
|[<c002b850>] (warn_slowpath_common) from [<c002b918>] (warn_slowpath_null+0x1c/0x24)
|[<c002b918>] (warn_slowpath_null) from [<c054a54c>] (rt_mutex_trylock+0x30/0x108)
|[<c054a54c>] (rt_mutex_trylock) from [<c054bd0c>] (rt_spin_trylock_irqsave+0x10/0x1c)
|[<c054bd0c>] (rt_spin_trylock_irqsave) from [<c043e030>] (clk_enable_lock+0x18/0x114)
|[<c043e030>] (clk_enable_lock) from [<c043f600>] (clk_disable+0x1c/0x34)
|[<c043f600>] (clk_disable) from [<c0429188>] (tc_shutdown+0x34/0x3c)
|[<c0429188>] (tc_shutdown) from [<c04291b0>] (tc_set_oneshot+0x20/0x50)
|[<c04291b0>] (tc_set_oneshot) from [<c00764a4>] (clockevents_switch_state+0xd4/0x130)
|[<c00764a4>] (clockevents_switch_state) from [<c00773e8>] (tick_switch_to_oneshot+0x48/0xb8)
|[<c00773e8>] (tick_switch_to_oneshot) from [<c006a480>] (hrtimer_run_queues+0x48/0x108)
|[<c006a480>] (hrtimer_run_queues) from [<c0068dd8>] (update_process_times+0x2c/0x64)
|[<c0068dd8>] (update_process_times) from [<c0076ad0>] (tick_handle_periodic+0x1c/0x90)
|[<c0076ad0>] (tick_handle_periodic) from [<c0429274>] (ch2_irq+0x20/0x28)
|[<c0429274>] (ch2_irq) from [<c005a39c>] (handle_irq_event_percpu+0x74/0x16c)

Is it possible to drop this disable/enable clock on the switch from pit
to one shot mode?

>You may also stop at 99a81706526fb167029a940ef1f7bfbe882abd3e which
>should solve the crash but it has not been tested as thoroughly.

Did you confuse the sha1 with something? This patch is called ("clk:
at91: remove IRQ handling and use polling") and is part of the series
you gave (patch #3).

>Thanks!

Sebastian
