From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: idle task starvation with rt patch
Date: Wed, 06 May 2009 16:18:14 -0700
Message-ID: <4A021AB6.3090807@us.ibm.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>  <4A01FB5E.1000006@us.ibm.com> <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David L <idht4n@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:47326 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZEFXSK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 May 2009 19:18:10 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n46NFaXF009656
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 17:15:36 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n46NIAlr188306
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 17:18:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n46NIAEf001058
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 17:18:10 -0600
In-Reply-To: <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David L wrote:

> In mainline, we have our receiver application schedules about
> 6 threads, all with SCHED_FIFO priority between about 65 and 97.
> After applying the real-time patch, I noticed some IRQ handling
> processes that appeared to have a real-time priority of about 50.
> So I tried adjusting our application's priority to have only one thread
> with priority higher than 50 (the one with the real-time requirements
> that nomincally uses about 250 usec per msec of CPU).

Right - the bulk of the interrupt overhead (including
processing of softirqs etc) would not occur (or rather,
would not be allowed to preempt your SCHED_FIFO task at 
higher priority).

> Our receiver process which tracks RF signals based on the
> information from an FPGA that provides baseband accumulated
> samples at about 1000 times per second.  It has some lower
> priority SCHED_FIFO threads that have relatively loose timing
> constraints but do need about a second of CPU time every few
> seconds to prevent a queue overflow that causes the process
> to assert and crash by design.

A second of CPU time every few seconds sounds like a
lot, actually - even if lower priority, it still sounds
like it's a must-happen, and you might need to bump up
its priority(?).

> The priorities all seem to be set right... without the real-time
> patches, it seems that the kernel isn't real-time enough to
> meet our timing requirements in some cases.  With the real-time
> patches, the CPU loading for the identical process goes from
> about 50% to about 100%.  I'm wondering why there is such
> a dramatic difference in CPU usage.

You might need to instrument it further or use ftrace
to figure out what's happening. RT is slower to process
incoming interrupts (kernel threads vs softirqs) so it
might be a factor - do you use affinity to pin threads
and/or interrupts? You might be able to play with that
to perhaps avoid the problem. It should not behave this
differently, but I could be wrong...

thanks,
Nivedita
