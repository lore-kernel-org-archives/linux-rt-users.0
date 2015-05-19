From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: softirq behavior during a UDP flood
Date: Tue, 19 May 2015 09:55:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505190940480.4225@nanos>
References: <20150501150412.GA15483@nathan3500-linux-VM> <20150514193214.GH13442@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nathan Sullivan <nathan.sullivan@ni.com>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52983 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbbESHzE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2015 03:55:04 -0400
In-Reply-To: <20150514193214.GH13442@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 14 May 2015, Sebastian Andrzej Siewior wrote:
> * Nathan Sullivan | 2015-05-01 10:04:12 [-0500]:
> 
> >Hello all,
> >
> >We are running 3.14.37-rt on a Xilinx Zynq based board, and have noticed some
> >unfortunate behavior with NAPI polling during heavy incoming traffic.  Since,
> >as I understand it, softirqs are scheduled on the thread that caused them in
> >rt, the netowrk RX softirq simply runs over and over on one CPU of the system.
> >The network device never re-enables interupts, basically NAPI polling runs
> >forever and weight/budget are irrelevant with preempt-rt on.
> >
> >Since we set IRQ affinity to CPU 0 for everything, this leads to the system
> >live-locking and becoming unusable.  With full RT preemption off, things are
> >fine.  In addition, 3.2 kernels with RT are fine as well under heavy net load.
> >Is this behavior due to a design tradeoff, or is it a bug?

Hmm. That's interesting. There should be no significant change in the
handling of the softirq between 3.2 and 3.14. I introduced the 'run
softirq' from tail of the network irq thread in 3.0. It might be a
different timing behaviour of the network driver or something
else. Might be worthwhile to investigate with tracing what the
difference is.
 
> The rx-napi softirq runs once the threaded handler is done with the
> handler. Comparing with vanilla there a little difference: vanilla
> repeats the softirq a number of times and has a time budget. Once it
> decides that it runs for too long it moves into softirqd. -RT on the
> other hand repeats the softirq processing as long as there is work to
> do. Since it is done after the thread handler completes it work it is
> done at the priority of the threaded handler - so if your -RT task has
> a higher priority it won't be disturbed by it.
> 
> If you put your shell above the threaded handler of the network handler
> (or the handler as SCHED_OTHER) then things should be back to normal.
> I'm not sure if moving network (after a while of processing) to ksoftirq
> is a good idea because we lose the priority then.

Yes, it's tricky. The idea was to run the softirq in the context of
the interrupt thread, which raised the softirq to avoid the extra
overhead of scheduling. And it really gave us a network performance
boost vs. the old variant.

Though, if the network is faster than the softirq can shuffle away the
packets we run into the situation Nathan described.

I have no immediate good idea how to deal with that. Offloading the
softirq to a different (SCHED_OTHER) thread might work, but it's not
pretty.

Another variant would be to temporalily lower the priority of the
thread which runs the softirq, but that's going to be a mess all over
the place.

A very simplistic solution which might be not the worst after all
would be to record the runtime of the softirq handler and if it raises
the softirq again within a very short timespan let the thread sleep
for exactly that amount of runtime.

Not sure yet. That needs some experimentation, but the latter is
probably quick to implement and will handle the above problem
gracefully. 

Thanks,

	tglx
