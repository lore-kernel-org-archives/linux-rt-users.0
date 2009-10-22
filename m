From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 11:16:27 -0700
Message-ID: <4AE0A17B.9020201@us.ibm.com>
References: <20091022120832.4bfd29e2@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:43534 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbZJVSQb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:16:31 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9MIF64A003124
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 14:15:06 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n9MIGXR61179892
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 14:16:33 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n9MIGTtF031655
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 12:16:30 -0600
In-Reply-To: <20091022120832.4bfd29e2@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> Today, for the Nth time, I was asked by a potential customer "How does
> the RT patch improve latency?". I looked at rt.wiki.kernel.org,
> hoping (vainly) that someone had written up an elevator-pitch for the
> RT patch, but it was not to be. So I wrote up something that I hope
> made sense and sent it off. 

I have "elevator pitch" on my todo list as well.  Good timing.

> 
> Since then I did a little bit of tweaking and expansion and thought I'd
> send it to the RT users list to see if we can agree on an answer, then
> put that in the RT FAQ. 
> 
> So, please read and critique the following:
> 
> Q. How does the Linux RT kernel improve "latency"?

"Linux RT" ... pretty close to RTLinux, which of course we can't use, so 
maybe use "Real-Time Linux" or "The PREEMPT_RT patch".

> 
> A. The Linux RT patch modifies the behavior of spinlocks and
> interrupt handling, to increase the number of points where a
> preemption or reschedule may occur. This reduces the amount of time a
> high priority task must wait to be scheduled when it becomes ready to
> run, reducing event service time (or "latency"). 
> 
> Most spinlocks in the kernel are converted to a construct called an
> rtmutex, which has the property of *not* disabling interrupts while
> the lock is held and will sleep rather than spin. This means that
> interrupts will occur while rtmutexes are held and interrupt handling
> is a potential preemption point; on return from handling an interrupt,
> a scheduler check is made as to whether a higher priority thread needs
> to run.
> 
> The rtmutex locking construct also has a property known as "priority
> inheritance", which is a mechanism for avoiding a deadlock situation
> known as "priority inversion". 

A reference might be a good idea. The medium priority tasks not 
interested in the contended resource is a key aspect of priority inversion.

http://en.wikipedia.org/wiki/Priority_inversion

> In order to prevent a low priority
> thread that is holding a lock from preventing a higher priority thread
> from running, the low priority thread temporarily inherits the
> priority of the highest priority thread that is requesting the lock,
> which allows the low-priority thread to run until it completes its
> critical section and releases the lock. 
> 
> In addition to changing spinlocks, interrupts have been threaded,
> meaning that instead of handling interrupts in a special "interrupt
> context", each IRQ has a dedicated thread for running its
> ISRs. Interrupts go to a common handler and the handler schedules the
> appropriate thread to handle the interrupt. This means that sleeping
> spinlocks (rtmutexes) have a context to return to and that interrupt
> handling can be prioritized by assigning appropriate realtime
> priorities to the interrupt threads. 

I think I'd focus a bit more on interrupt threads having configurable 
priorities.

I'm not sure the bit about "spinlocks have a context to return to" makes 
sense in an elevator-type pitch, might be too low level, and detract 
from the high-level message?


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
