From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will
 stall forever
Date: Wed, 28 Nov 2007 14:04:41 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
 <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com>
 <1196176294.13982.58.camel@localhost.localdomain> <1196177122.23808.7.camel@imap.mvista.com>
 <1196178834.23808.11.camel@imap.mvista.com> <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com>
 <20071128172509.GA30173@flint.arm.linux.org.uk>
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760365AbXK1TI1@vger.kernel.org>
In-Reply-To: <20071128172509.GA30173@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 28 Nov 2007, Russell King - ARM Linux wrote:
> On Wed, Nov 28, 2007 at 03:38:11PM +0100, Remy Bohmer wrote:
> > Hello Daniel,
> >
> > >  *      Note: The caller is expected to handle the ack, clear, mask and
> > >  *      unmask issues if necessary.
> > > So we shouldn't need any flow control unless there is some other
> > > factors..
> >
> > This comment can be misinterpreted, I think. Who is assumed to be the
> > caller in this context? The 2 other routines in the driver that
> > actually do the unmasking stuff besides only calling this routine? Is
> > it allowed to call it directly or should it always be done through a
> > wrapper that does all these special things?
>
> The whole point of this simple handler is to accomodate interrupts such
> as those found on the Neponset board.
>
> There, you have a status register in a CPLD but no enable/disable
> registers.  The status register tells you whether the SA1111, ethernet
> or 'USAR' chip asserted its interrupt.
>
> However, as there is no way to disable the sources, this situation has
> to be handled carefully - the function decoding the interrupt source
> needs to mask and unmask the _parent_ interrupt itself, and it's
> exactly that which the comment is directed towards.
>
> See neponset_irq_handler().
>
> The simple IRQ handler is not meant for anything other than that really
> simple implementation.  If people have been using it with interrupts
> which can be individually masked and unmasked, that's where the bug is.
> They should be using one of the other handlers.
>

Russell,

Thanks for the reply and this nice explanation.

I'm taking this as a NACK.

Daniel or Remy, could you find the offending users and make send patches
to fix them.

-- Steve
