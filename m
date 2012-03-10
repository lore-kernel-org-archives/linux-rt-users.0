From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: timer signal loss on RT
Date: Sat, 10 Mar 2012 14:44:17 -0500
Message-ID: <1331408658.23363.5.camel@frodo>
References: <4F5B2C50.2090907@cfl.rr.com>
	 <alpine.LFD.2.02.1203101231230.2742@ionos>  <4F5B40BB.9080305@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel-rt <linux-rt-users@vger.kernel.org>,
	Mark Hounschell <markh@compro.net>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18269 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2CJToX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Mar 2012 14:44:23 -0500
In-Reply-To: <4F5B40BB.9080305@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2012-03-10 at 06:53 -0500, Mark Hounschell wrote:
> >
> 
> Does ksoftirqd deliver timer signals in vanilla?

Sometimes :-)

Softirqs in vanilla run in interrupt context. Mostly on return from an
hardware interrupt handler, the softirqs are called and run anytime
interrupts are enabled (and bottom halves enabled). But if there's too
much work to do from the soft interrupt, then it pushes the rest of the
work to ksoftirqd. Which on vanilla runs as a normal SCHED_OTHER task.

In -rt, the hardware handlers are run as thread, and all softirqs are
handled by ksoftirqd. -rt does not process any softirqs in interrupt
context.

The answer to your question is, the timerd softirq runs mostly from
interrupt context, which will preempt your high priority CPU hog, but if
too much work is being done, it may defer it to ksoftirqd, where your
thread might block it. But chances are it wont.

-- Steve


