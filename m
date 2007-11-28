From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will stall forever
Date: Wed, 28 Nov 2007 15:38:11 +0100
Message-ID: <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
	 <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com>
	 <1196176294.13982.58.camel@localhost.localdomain>
	 <1196177122.23808.7.camel@imap.mvista.com>
	 <1196178834.23808.11.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: "Daniel Walker" <dwalker@mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761825AbXK1Oik@vger.kernel.org>
In-Reply-To: <1196178834.23808.11.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Daniel,

>  *      Note: The caller is expected to handle the ack, clear, mask and
>  *      unmask issues if necessary.
> So we shouldn't need any flow control unless there is some other
> factors..

This comment can be misinterpreted, I think. Who is assumed to be the
caller in this context? The 2 other routines in the driver that
actually do the unmasking stuff besides only calling this routine? Is
it allowed to call it directly or should it always be done through a
wrapper that does all these special things?

Either way, only masking interrupts, and never unmasking it, is a bug.
If interrupts come and go slow enough you never run into this problem,
and if this type is not used often, nobody will notice it.
Usually interrupts needs clearence of the source before the hardware
can generate a new one. GPIO interrupts are different, they are
generated whenever a IO-level changes, there is no acknowledge or
clearing of the interupt needed. These types of interrupts are never
'pending' from hardware point of view. So, with these type of
interrupts, a new one can occur while the interrupt handler has not
handled the previous one yet, and therefor these interrupt-types will
show this bug.

>
> Additionally, we have a patch in the real time tree called
> "irq-mask-fix.patch" which adds an "unmask" to handle_simple_irq, but as
> the note says we don't need flow control..

You mean the Montavista real time tree?

Kind Regards,

Remy
