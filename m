From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 11:18:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
References: <200708081514.31864.jbe@pengutronix.de>  <200708081409.28105.dvhltc@us.ibm.com>
  <200708091610.58134.jbe@pengutronix.de>  <200708091128.44043.dvhltc@us.ibm.com>
 <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44905 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758760AbXHJPTI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 11:19:08 -0400
In-Reply-To: <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
When I'm asked what language is my mother tongue,
I simply answer "C".

On Fri, 10 Aug 2007, Remy Bohmer wrote:
> Hello Darren, Juergen and Ingo,
>
> Maybe Ingo can look at it, and find a way to implement it more
> generic? (In the softirq_info struct we could default set all prios
> back to 50, and than from functional point of view there will be no
> change for other RT-patch users, but makes Embedded-users life easier.

Hi Remy,

I'm taking your concern seriously, and we are seeing other areas that it
would be nice to set up a different irq priority than the default at boot.
Perhaps adding in a new command line interface (We may need to extend the
command line size limit). Where one could do
irq_priority_map=10-51,21-40,...  Where the first number is the irq number
followed by the irq priority. We can also do something similar to
softirqs.

Would something like that satisfy your needs?

>
> While looking at the IRQ-threads: Notice that setting all IRQ-threads
> priorities to 50 with SCHED_FIFO is a bit strange to begin with,
> because on a non-RT kernel all IRQ's have different priorities and a
> higher prio irq can preempt a lower prio one. (on X86) The current

Only if the lower one enabled interrupts ;-)

Also that's hardware defined, not user defined. Note that the sofitrqs are
not prioritized either. Well, they are by their position in the pending
bitmask. But one softirq will not preempt another.

> implementation will not preempt another irq-thread due to the same
> prios and fifo scheduling.
> The implementation I have in this patch follows the original behaviour
> more closely, but changing that also could lead to some discussion...
>

We originally had a special "priority" for each new irq, but found that it
really didn't make sense, and we had pressure to make them all the same,
and let the user change them. What we need is a way to pass information to
the kernel to set a userdefined default.

When I get time, I can write up a patch to do something like this.

-- Steve
