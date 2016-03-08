From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fix preempt-rt on AT91
Date: Tue, 8 Mar 2016 12:26:46 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603081223470.6083@nanos>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com> <20160118174259.GC12309@linutronix.de> <20160305113553.GB21216@piout.net> <20160308110639.GC21842@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50350 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbcCHL2K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 06:28:10 -0500
In-Reply-To: <20160308110639.GC21842@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 8 Mar 2016, Sebastian Andrzej Siewior wrote:
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

I think we really need to have this irq_en/disable_action() thingy sooner than
later.

> Is it possible to drop this disable/enable clock on the switch from pit
> to one shot mode?

There was an earlier discussion about the clk stuff. Actually the lock
protecting disable/enable should be made raw, but there was some crap going on
in some of the clk callbacks which made that impossible. We realy should
revisit this.

Thanks,

	tglx
