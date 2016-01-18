From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Fix preempt-rt on AT91
Date: Mon, 18 Jan 2016 20:23:08 +0100
Message-ID: <20160118192308.GR3367@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60108 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756409AbcARTXQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 14:23:16 -0500
Content-Disposition: inline
In-Reply-To: <20160118174259.GC12309@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 18/01/2016 at 18:42:59 +0100, Sebastian Andrzej Siewior wrote :
> > 1/ After apply the preempt-rt patch, the kernel doesn't build anymore,
> > arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch is not correct
> > anymore. Can you squash the following patch to solve this build issue?
> 
> I folded most of the changes and should be part of -rt3.
> 

Thanks!

> > 2/ This approach actually has more issues, in particular, request_irq() must
> > not be calls from interrupt disabled context. That only works because
> > might_sleep() is not active during early boot.
> > For more information, see the following discussion:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357607.html
> >
> > However, we can't remove those patches now because else we would suffer from
> > another issue:
> > The timer interrupt is shared with other devices, in particular the debug tty,
> > the rtc dans the pmc. When using preempt-rt, those interrupts become threaded
> > interrupts. But, the pit interrupt is requested with IRQF_TIMER and so has
> > IRQF_NO_THREAD. If the pit interrupt is not freed at early boot, all the other
> > devices will fail requesting their interrupt, for example:
> >
> >genirq: Flags mismatch irq 16. 00042080 (ttyS0) vs. 00015280 (at91_tick)
> >atmel_usart ffffee00.serial: atmel_startup - Can't get irq
> 
> I assumed the pit is just temporary here for the bootstap. The pit irq is
> removed and the system switches to the TCB clocksource which runs at a
> higher rate.
> 
> > I'd say that the proper solution would still be to implement the virtual
> > irqchip because this would still hit people not wanting to use the TCB as
> > their clock source.
> 
> why wouldn't people not want that?

Because they may be using the TCBs for something else: PWM, frequency
measure, quadrature decoder...

> For a virtual irqchip you would need a mask/unmask register in order to
> individual disable/enable the irq and you need something to figure out
> which one of the three is active. You don't have all those things, do
> you?
> 

The proposed solution was software only. It mainly consisted in a simple
irq demuxer.

> > 3/ Finally, the kernel will crash when initializing the PMC driver. This is
> > solved by this series that will hopefully land in the mainline:
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390954.html
> 
> This is new, isn't it? So the series in currently in v3 and people seem
> happy with it. Please poke me once with the commit ids once it is merged
> on its way upstream and I will try cherry-pick them from next or so.
> 

I added that part mainly to inform people were to look to get preemt-rt
working on at91. No action on your side for that one yet.

> All in all, care to forwarded the working pieces from -RT patch set
> upstream? I problem I have here is mostly that I can't the patches on
> actual hardware. Disabling the PIT and running on the other clocksource
> isn't that -RT specific after all :)

I'd say that the only remaining part is the IRQ freeing/requesting but
as I said, this can't land in mainline as is. I still plan to work on
that later.
I'd say that most people running linux on at91 are already using the tcb
as the clocksource, this is already available in the mainline and is the
default unless the TCBs are used for something else.

If you are willing to test, I'm pretty sure we can convince Nicolas to
send you a board. Unfortunately, the main issues appear on old products,
not on sama5.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
