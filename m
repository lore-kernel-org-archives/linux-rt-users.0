From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling
	can/will stall forever
Date: Wed, 28 Nov 2007 12:44:31 -0800
Message-ID: <1196282672.27964.32.camel@imap.mvista.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ARM Linux Mailing List
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:10639 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202AbXK1Uw5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 15:52:57 -0500
In-Reply-To: <Pine.LNX.4.58.0711281510580.4247@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 15:16 -0500, Steven Rostedt wrote:

> 
> This could also simply be unique to the interrupt threads (only in RT). So
> perhaps the patch is OK.
> 
> Remy, sorry about this round-a-bout. But I don't have any of the hardware
> that this affects, and I'm just being cautious.

Ignoring the ARM side of things for a sec, handle_simple_irq() will
mask() the interrupt in the special case that an interrupt is already in
the processes of being handled.. handle_simple_irq() also unmasks when
it finishes handling an interrupt (something real time adds for some
reason) ..

In terms of threading the irq everything is the same except there is no
unmask() call when the thread finishes .. 

Daniel
