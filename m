From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will stall forever
Date: Thu, 29 Nov 2007 16:33:39 +0100
Message-ID: <3efb10970711290733m59e30b5eyf96b914d63a72058@mail.gmail.com>
References: <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com>
	 <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
	 <20071128200550.GA3494@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0711281510580.4247@gandalf.stny.rr.com>
	 <3efb10970711290214v37d85a27k9a84876d9099d7c5@mail.gmail.com>
	 <20071129102506.GB22793@flint.arm.linux.org.uk>
	 <3efb10970711290327s3c60da1ey3b6fae738090ca5@mail.gmail.com>
	 <20071129133604.GA23845@flint.arm.linux.org.uk>
	 <3efb10970711290618v2bd93edfrbc53d9df4b73b33b@mail.gmail.com>
	 <20071129142920.GB23845@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Daniel Walker" <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:14575 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113AbXK2PeC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 10:34:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1578424rvb
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Nov 2007 07:33:59 -0800 (PST)
In-Reply-To: <20071129142920.GB23845@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Russell,

> While I realise that, I'm telling you that the _problem_ is being
> caused by the wrong handler being used.

Okay, I believe you... (someone told me once, Russell is right, and if
you do not believe him, he is still right ;-)

> SA1100 and PXA have exactly the same setup.  They use the correct
> handler.  Why is AT91 special?

This remark is what convinced me :-))

I changed the interrupt handler from the simple_irq to the edge_irq,
and it works...!!
(I added a noop routine for that .ack part, because there is no ack)

I believe I was too focussed on the masking bug in the RT kernel on
the simple_irq() that I did not see that for the AT91 series the edge
type interrupt handler also works... (even better...) What I thought
was 1 single bug in the RT-kernel turned out to be a number of things
together that aren't correct, even for mainline.

So, to come to a conclusion: The masking bug in RT is still there in
the simple_irq path, and masking has to be removed from the simple_irq
code. Also for mainline. AT91 can live without simple_irq.
I think we are in sync again...

I will post a patch for the AT91 later on, after some more testing.


Kind Regards,

Remy
