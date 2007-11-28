From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will stall forever
Date: Wed, 28 Nov 2007 20:05:50 +0000
Message-ID: <20071128200550.GA3494@flint.arm.linux.org.uk>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com> <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com> <1196176294.13982.58.camel@localhost.localdomain> <1196177122.23808.7.camel@imap.mvista.com> <1196178834.23808.11.camel@imap.mvista.com> <3efb10970711280638l3f57104y8cf9f2e58235c3@mail.gmail.com> <20071128172509.GA30173@flint.arm.linux.org.uk> <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Remy Bohmer <linux@bohmer.net>, Daniel Walker <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ARM Linux Mailing List
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60862 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997AbXK1UG5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 15:06:57 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0711281402210.3341@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Nov 28, 2007 at 02:04:41PM -0500, Steven Rostedt wrote:
> Thanks for the reply and this nice explanation.
> 
> I'm taking this as a NACK.
> 
> Daniel or Remy, could you find the offending users and make send patches
> to fix them.

Note that I'm not acking nor nacking the patch; I'm not involved with
the RT stuff and I've never looked at the code, so I don't know what
the implications of the patch itself are.

I've merely explained the point of the simple irq handler.

Maybe the simple irq handler should never have been something that got
sucked into the generic IRQ stuff, but kept as something specific to
Neponset.
