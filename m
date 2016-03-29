From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] clockevents/drivers/timer-atmel-pit: fix double free_irq
Date: Tue, 29 Mar 2016 15:52:04 +0200
Message-ID: <20160329135204.GG2346@piout.net>
References: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160329133206.GA13334@linutronix.de>
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
In-Reply-To: <20160329133206.GA13334@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 29/03/2016 at 15:32:06 +0200, Sebastian Andrzej Siewior wrote :
> * Alexandre Belloni | 2016-03-17 21:09:43 [+0100]:
> 
> >Hi Sebastian,
> Hi Alexandre,
> 
> >This patch fixes the last warning for preempt-rt on at91. It applies on
> >v4.4.4-rt11. Note that the whome PIT/TCB mess will be fixed in another way in
> >the mainline as we are reworking the tcb driver to avoid using the pit when
> >booting.
> 
> oh, okay. I just sent the "arm: at91: do not disable/enable clocks in a
> row" patch as you asked me a while ago. It applied cleanly against the
> next tree of today.

Yeah, actually, it was not needed anymore. I forgot about it at the time
but f02b4b72d12c (clockevents/tcb_clksrc: Prevent disabling an already
disabled clock) was sufficient to remove the warning. Your patch is
still Ok but maybe it can get rid of the
"if (!clockevent_state_detached(d))" in tc_shutdown_clk_off()

I'll test and take care of that.

> So I will apply this to get rid of the warning. And if you manage not to
> use the PIT during boot then we won't have the free_irq() mess which is
> good.
> 

Yeah, this will definitively happen (hopefully sooner than later ;) )

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
