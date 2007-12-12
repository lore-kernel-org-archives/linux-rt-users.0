From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Wed, 12 Dec 2007 16:10:03 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712121606241.23712@gandalf.stny.rr.com>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Victor <linux@maxim.org.za>,
	RT <linux-rt-users@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:55434 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbXLLVKk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2007 16:10:40 -0500
In-Reply-To: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


[ keeping full email for Ingo and Thomas ]

On Fri, 7 Dec 2007, Remy Bohmer wrote:

> Hello Andrew,
>
> Attached I have put 3 patches for the AT91-series for the serial port
> driver on AT91.
> The interrupt handler of the serial console is quite long, and if
> Preempt-RT is used on AT91 the interrupt handler is even doing illegal
> things. These illegal things are related to the DBGU port of which the
> interrupt handler is shared with the system_interrupt which
> automagically runs in IRQF_NODELAY context due to the timer interrupt.
> The old interrupt handler calls some kernel interfaces that can block
> on a mutex.
>
> To solve this, I have split up the interrupt handler in a IRQF_NODELAY
> safe/unsafe part, with as result that the code running in real
> interrupt context is shortened a lot (the tty driver part is now
> called from a tasklet). On AT91 David Brownell noticed several months
> ago that the DBGU can miss some characters on NO_HZ. I would expect
> that this would be better now due to the shorter interrupt handler,
> although it was not my goal to solve it with these patches. (David can
> you verify if this is better now?)
>
> So, I have here 3 patches:
> * atmel_serial_cleanup -> This patch adapts the driver to the coding
> rules, splits the interrupt handler into 3 routines (cuts the routine
> in more readable pieces) , but there is no functional change involved.
> * atmel_serial_irq_splitup -> This patch splits up the interrupt handler.
> * atmel_serial_irqf_nodelay -> This patch is additionally required to
> get it properly working on Preempt-RT. (This patch should thus go into
> the RT-patch, AFTER integration of the other 2 patches into mainline)
>
> BUT: I based the patch on the 2.6.23.1 + your patch collection at
> http://maxim.org.za/AT91RM9200/2.6/2.6.23-at91.patch.gz
>
> I did this because this driver conflicts with the DMA(PDC) patches
> that are in the patchset on  maxim.org.za. I found out that these DMA
> patches are still not integrated into mainline, although it is in your
> patchset for several kernel releases. I can make a series based on
> kernel mainline, but that would harden the integration for you in your
> patchset.
> The patchset itself is not dependant on the DMA changes, so I can
> split it up, but the DMA changes itself are quite heavy.
>
> But there is also a relation with Preempt-RT. To get the patch in
> preempt RT the other patches has to be in mainline, so things are
> stacking up now.

Not really.

>
> What is wise here? should I create a new patchset for mainline? Or can
> you push the DMA patch also to mainline together with this set? I have
> it working here for months, so I see no reason not to, maybe you have
> a reason?
>
> I tested it on AT91rm9200-EK (+proprietary boards) + AT91SAM9261-EK,
> in combination with: 2.6.23.1 and 2.6.23.1-rt5 up to serial speed to
> 115200 (also with 99% CPU load on prio 99 on RT, no missing characters
> detected.)
>
> Note: Preempt-RT CANNOT run without these patches on AT91.

I could pull all the patches into RT (although I would like Thomas to take
a look first and give an OK). And then apply your patches on top. I'm
assuming that this only affects the ARM architecture and the AT91 device?

I'm leaving this out for -rt13 and for the next cut of 2.6.24-rc-rt. But
if Thomas is OK with pulling in the external patch queue, I'll do it for
-rt14.

It is best if the patch queue in question makes it into mainline.

-- Steve
