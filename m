From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Wed, 12 Dec 2007 23:29:01 +0100
Message-ID: <3efb10970712121429l7b41d57md4f826f6aaf4b71@mail.gmail.com>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
	 <Pine.LNX.4.58.0712121606241.23712@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andrew Victor" <linux@maxim.org.za>,
	RT <linux-rt-users@vger.kernel.org>,
	"David Brownell" <david-b@pacbell.net>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:13472 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXLLW3E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2007 17:29:04 -0500
Received: by wr-out-0506.google.com with SMTP id c49so193426wra.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Dec 2007 14:29:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0712121606241.23712@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

> > So, I have here 3 patches:
> > * atmel_serial_cleanup -> This patch adapts the driver to the coding
> > rules, splits the interrupt handler into 3 routines (cuts the routine
> > in more readable pieces) , but there is no functional change involved.
> > * atmel_serial_irq_splitup -> This patch splits up the interrupt handler.
> > * atmel_serial_irqf_nodelay -> This patch is additionally required to
> > get it properly working on Preempt-RT. (This patch should thus go into
> > the RT-patch, AFTER integration of the other 2 patches into mainline)
> >
> > BUT: I based the patch on the 2.6.23.1 + Andrews patch collection at
> > http://maxim.org.za/AT91RM9200/2.6/2.6.23-at91.patch.gz
>
> I could pull all the patches into RT (although I would like Thomas to take
> a look first and give an OK).

Instead of pulling the complete patchset, we can also pull the minimal
set of patches to make Preempt-RT to work properly on AT91; Preempt-RT
depends on:
1) ClockSource & ClockEvents for AT91RM9200. [David Brownell, and others]
2) Support configurable HZ. [David Brownell]
3) The Serial port interrupt handler splitup patchset.
4) And of course, the
use-edge-irq-instead-of-simple-irq-interrupt-handler patch for AT91, I
posted last week.

Maybe, Andrew can provide the patches 1 and 2 separate from his
patchset, so you can add them to RT for 2.6.23 only? patch 1 seems to
be in 2.6.24-rc4 already.

> And then apply your patches on top. I'm
> assuming that this only affects the ARM architecture and the AT91 device?

The complete patchset from Andrew also effects other Atmel cores, and
I only focussed on AT91sam/at91rm. Andrew mentioned that the DMA patch
for Serial in his set did not work on AVR32, so, we probably do not
want to have that change until it is really stable.
Tomorrow, I can easily make my set separate from that DMA part, so
that the patches 1-4 can be mainlined without other dependencies,
including the irqf_nodelay-patch which can be put in the RT-patchset.
I can post this mainline-able patch (3) tomorrow.

> I'm leaving this out for -rt13 and for the next cut of 2.6.24-rc-rt. But
> if Thomas is OK with pulling in the external patch queue, I'll do it for
> -rt14.

OK.

> It is best if the patch queue in question makes it into mainline.

Agree.


Kind Regards,

Remy
