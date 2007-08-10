From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 12:18:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708101209350.21632@gandalf.stny.rr.com>
References: <200708081514.31864.jbe@pengutronix.de>  <200708081409.28105.dvhltc@us.ibm.com>
  <200708091610.58134.jbe@pengutronix.de>  <200708091128.44043.dvhltc@us.ibm.com>
  <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
 <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
 <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:45291 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934891AbXHJQTl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 12:19:41 -0400
In-Reply-To: <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 10 Aug 2007, Remy Bohmer wrote:

> Hello Steven,
>
> > Perhaps adding in a new command line interface (We may need to extend the
> > command line size limit). Where one could do
> > irq_priority_map=10-51,21-40,...  Where the first number is the irq number
> > followed by the irq priority. We can also do something similar to
> > softirqs.
> >
> > Would something like that satisfy your needs?
>
> Yeah, it would at least suit my needs :-)
> But, the irq-numbers to be defined is hardware specific, and even

Yeah, but they should be the same on boot up. A command line is something
one would add in the boot loader (grub for example). It's not hard coded.

> board specific on X86. Maybe someone wants to give a certain interrupt
> handler a different priority, but not a certain IRQ-number to keep it

Actually, the handler thread runs _all_ register interrupt handlers. So
there's no way to make one a higher priority than the other. This is a
tough problem. If you have two shared handlers on the same irq line,
and think you can make one a higher priority than the other, you can't.
If the lower one is running (at the lower priority), and it gets
preempted by an RT task with a priority that is between the lower
priority handler and the higher priority handler, the higher priority
handler may never run. The interrupt line for the IRQ is masked while
the handlers are running. So by preempting the lower priority handler
you are also preempting the higher priority IRQ from coming in.

> possible to use 1 target image usable on multiple boards with  1
> single kernel and 1 single config.

You can still have one kernel and one config. A command line is separate.

> How to define that on a kernel commandline is still a question to me...

Don't worry about labeling handlers. We will only need to know the IRQ #.

If we can redesign the IRQ handlers of all drivers, where they can pass in
a function to disable the device so we don't need to mask the IRQ line
if another device exists with a higher IRQ, then we may have a solution
there. But don't expect that to happen anytime soon.

>
> > When I get time, I can write up a patch to do something like this.

Sure go ahead :-)

>
> I could write a proposal on a solution for this, and if we all agree
> for one solution, I could make the patch for this. (Maybe I have more
> time free than you ;-) )

You probably do ;-)  I'm struggling with four projects at the moment,
five if you count my writing of the chapter in the O'Reilly book
"Building Embedded Linux Systems" about RT.  But these are some of the
things that I'm talking about in that.

Thanks,

-- Steve
