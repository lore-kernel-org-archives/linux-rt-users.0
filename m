From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will stall forever
Date: Thu, 29 Nov 2007 11:14:30 +0100
Message-ID: <3efb10970711290214v37d85a27k9a84876d9099d7c5@mail.gmail.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
	 <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com>
	 <1196176294.13982.58.camel@localhost.localdomain>
	 <1196177122.23808.7.camel@imap.mvista.com>
	 <1196178834.23808.11.camel@imap.mvista.com>
	 <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com>
	 <20071128172509.GA30173@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
	 <20071128200550.GA3494@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0711281510580.4247@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	"Daniel Walker" <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:8199 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbXK2KOc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 05:14:32 -0500
Received: by py-out-1112.google.com with SMTP id u77so3467847pyb
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Nov 2007 02:14:31 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0711281510580.4247@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

> Remy, sorry about this round-a-bout. But I don't have any of the hardware
> that this affects, and I'm just being cautious.

No problem, I expected this discussion when I submitted the patch. It
is logical that everybody is cautious on this subject. But still,
there is a bug here. The question is how to figure out the best
solution. (with the least chance of regression).

I do not think Russell is right here with assuming that the wrong
interrupt handler type is used. Looking at the behaviour of the
mainline kernel (non-RT), the implementation is quite different: On
mainline the handle_simple_irq() in chip.c is not re-entrant, the
masking is **only** done in case of errors, and therefor never
unmasked again, of course.
On RT the masking is done when the next interrupt arrives, while the
1st interrupt is in progress by the interrupt thread, so it is masked
under normal valid conditions, and never unmasked. So, this is where
the real bug is.

So, I see 2 solutions:
* Never mask the interrupt in the first place. (should also work for
this type of interrupt)
* Add an unmask to the interrupt, once it is handled. (I chose this
route with my patch)

It is definitely only related to interrupt threading, and thus only RT related.

Kind Regards,

Remy
