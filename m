From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will
 stall forever
Date: Thu, 29 Nov 2007 08:57:01 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711290849140.21439@gandalf.stny.rr.com>
References: <1196177122.23808.7.camel@imap.mvista.com>
 <1196178834.23808.11.camel@imap.mvista.com> <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com>
 <20071128172509.GA30173@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
 <20071128200550.GA3494@flint.arm.linux.org.uk> <Pine.LNX.4.58.0711281510580.4247@gandalf.stny.rr.com>
 <3efb10970711290214v37d85a27k9a84876d9099d7c5@mail.gmail.com>
 <20071129102506.GB22793@flint.arm.linux.org.uk>
 <3efb10970711290327s3c60da1ey3b6fae738090ca5@mail.gmail.com>
 <20071129133604.GA23845@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Remy Bohmer <linux@bohmer.net>, Daniel Walker <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ARM Linux Mailing List
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:59332 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733AbXK2OAW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 09:00:22 -0500
In-Reply-To: <20071129133604.GA23845@flint.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Thu, 29 Nov 2007, Russell King - ARM Linux wrote:

> On Thu, Nov 29, 2007 at 12:27:30PM +0100, Remy Bohmer wrote:
>
> Ah, and looking at the changes to the file, the addition of the mask
> and unmask was done by someone who didn't understand what this was
> trying to do.  So that change should be backed out.
>

Perhaps only part of the change should be backed out.  The part that masks
the irq in the handle_simple_irq code.

That's from commit 76d2160147f43f982dfe881404cfde9fd0a9da21 which is to
not disable an irq line when disable_irq is called.  A form of lazy
disable irq.

This speeds up code that uses disable_irq, since the line is only masked
when an interrupt actually arrives. Using disable_irq / enable_irq does no
IRQ chip modifications if an interrupt from the IRQ line does not arrive
between the two.

Now the question is, can something that uses handle_simple_irq call
disable_irq?  If there is no mask function, I would assume that this would
be a noop in such a case. If this is true, then we could remove the mask
from handle_simple_irq. But then we might want to add a BUG() in
disable_irq for simple_irqs.

-- Steve
