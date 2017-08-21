From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Does calling sched_yield() in a SCHED_DEADLINE thread guarantee
 wakeup at beginning of next period?
Date: Mon, 21 Aug 2017 13:24:51 +0200
Message-ID: <20170821112451.264rytgl3tzzt3em@hirez.programming.kicks-ass.net>
References: <CANf15E_4N-BZDLFmYXUFqfMrX6T+7btTsQGYsYs7J_HNDXzSCg@mail.gmail.com>
 <ef939f8a-dd96-cff2-7f90-6ee8e88737e7@santannapisa.it>
 <CANf15E_hZ69Rds9v0N_--=pu_9+vT_yuO3utcF_wY+QVeO4xXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@arm.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bjarke Freund-Hansen <bjarkefh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38835 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHULY5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Aug 2017 07:24:57 -0400
Content-Disposition: inline
In-Reply-To: <CANf15E_hZ69Rds9v0N_--=pu_9+vT_yuO3utcF_wY+QVeO4xXA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 21, 2017 at 08:16:05AM +0000, Bjarke Freund-Hansen wrote:
> So what I gather from this is that the answer is yes, if and only if the
> SCHED_DEADLINE task is the one with the earliest absolute deadline.
> Otherwise, the task might not be woken up at the exact beginning of the
> next period.

'Exact' is a difficult word. The only hard guarantee we can give is that
you'll not wake up before the beginning. How long after depends on a
number of things:

 - (hardware) timer granularity
 - IRQ disabled regions
 - scheduler lock contention
 - scheduling policy (what Tomaso said)

Linux-RT aims to put bounds on things like IRQ disabled regions, but
you're still subject to them. The (scheduler) locks are FIFO fair, so
depending on the number of CPUs and the worst case section length you
can compute bounds on that.

So in practise it might be good enough (and that's all that counts), but
'exact' things are never :-)

Note that the point of Real-Time programming is to not be late
completing, we don't strictly care about when we start.

> My use case is actually quite simple. I have a period of say 20ms. Within
> this period certain things have to happen at certain points in time. These
> things being (among others) sending a network message and validating
> received messages (received asynchronously from the realtime thread.)
> 
> 0ms                  20ms                 40ms                 60ms
> |--------------------|--------------------|--------------------|
>        ^ 0+7ms              ^ 20+7ms             ^ 40+7ms                 -
> transmit message
>                      ^ 0+20ms             ^ 20+20ms            ^ 40+20ms  -
> validate received messages
> 
> Writing this I am questioning if SCHED_DEADLINE is the correct tool for the
> problem.
> 
> My current approach is to schedule the thread as an SCHED_DEADLINE task
> with period 20ms and runtime ~1ms (less than 1ms is needed).
> The task is the only SCHED_DEADLINE task on the system, so I rely on the
> task being woken up exactly at the start of the period and perform the
> received messages validation. I then calculate how long I have to sleep
> before the +7ms point, perform that sleep for the appropriate time and
> after being woken up I transmit the message. Tolerances are somewhere
> around 100μs.
> 
> Is this a valid approach? I have a sneaking suspicion that I might be
> thinking about all this the wrong way.
> 
> I am open to all and any suggestions, thank you in advance. :)

So if I understand correctly, your TX constraints are:

 - not before +7ms
 - not after  +7ms + 100us

That's a fairly tight set. The traditional way to represent that would
be a task with:

  sched_attr = {
	.sched_period   = 20ms,
	.sched_deadline = 100us,
	.sched_runtime  = ... /* something <= 100us */
  }

Which will get woken at the +7ms edge.

I'm not entirely clear on the RX constraints, are they at all correlated
to the TX other than needing to happen in the same period? If not,
they're an independent task:

  sched_attr = {
	.sched_period   = 20ms,
	.sched_deadline = 20ms,
	.sched_runtime  = ... /* something <= 20ms */
  }

Which get woken at the period edge. But writing that it seems wrong,
supposedly you want to process the packets received in _this_ period, so
you need to better specify by which time you expect them to have been
received and when you need to be done validating them.

In any case, the important point being that you need to specify when you
want to be _done_.
