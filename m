From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org (v2)
Date: Thu, 22 Oct 2009 14:47:53 -0700
Message-ID: <4AE0D309.9040904@us.ibm.com>
References: <20091022120832.4bfd29e2@torg> <20091022152539.04e2787a@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:41215 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbZJVVrw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 17:47:52 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9MHiipl009533
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 13:44:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n9MLlu9L043704
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 17:47:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n9MLlt72000803
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 17:47:56 -0400
In-Reply-To: <20091022152539.04e2787a@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> Got some good feedback on the first round, but missed CC'ing rostedt,
> since he isn't on linux-rt-users, so here's the revised text with
> the edits from dvhart and sven applied:

OK, now that the first round of content reviews are complete, here are 
my gramatical nit-pics.  Hey, you asked. ;-)

> 
> ---------------------8< snip 8<----------------------------------
> 
> Q. How does Real-Time Linux (aka the PREEMPT_RT patch) improve
> "latency"?
> 
> A. The Linux RT patch modifies the behavior of the most common

s/Linux RT/Real-Time Linux/

> kernel-level locking primitive (the spinlock) and kernel interrupt
> handling logic, to increase the number of points where a preemption or
> reschedule may occur. 


> This reduces the amount of time a high priority
> task must wait to be scheduled when it becomes ready to run, reducing

s/high priority/high-priority/
s/when/after/

> event service time (or "latency"). 

This sentence right here is basically the answer, the rest is 
explanatory.  Suggest opening with this:

Real-Time Linux reduces the amount of time a high-priority task must 
wait to be scheduled after it becomes ready to run, reducing event 
service time (or "latency").

> 
> Most spinlocks in the kernel are converted to a construct called an
> rtmutex, which has the property of *not* disabling interrupts or

s/has the property of *not*/does not/ then switch the gerunds to verbs 
(disabling->disable, etc).

> preventing task switching while the lock is held. It also has the

s/It also has the property of/It also/ same gerund->verb switch)

> property of sleeping on contention rather than spinning (hence the
> sometimes heard term "sleeping spinlocks"). These two properties mean

s/These two properties mean/This means/

> that interrupts may occur while rtmutexes are held and interrupt
> handling is a potential preemption point; on return from handling an
> interrupt, a scheduler check is made as to whether a higher priority
> thread needs to run.

semicolon isn't really necessary here IMO, and it's a long sentence, 
suggest splitting into two.

the second phrase is very wordy, maybe something more concise? like:

After handling an interrupt, the scheduler checks whether a higher 
priority task needs to run.

Hrm, actually, I think the second phrase could be eliminated entirely, 
as it is implicit in "preemption point".

> 
> The rtmutex locking construct also has a property known as "priority

OK, obviously I'm biased against the "has a property" phrase - it seems 
to drag out the sentence.

> inheritance", which is a mechanism for avoiding a deadlock situation
> known as "priority inversion"

Deadlock and Priority Inversion are.... wait, we covered this ;-)

> (http://en.wikipedia.org/wiki/Priority_inversion). In order to prevent
> a low priority thread that is holding a lock from preventing a higher

prevent... from preventing... reads oddly.  Maybe replace the first with 
"avoid"

> priority thread from running, the low priority thread temporarily
> inherits the priority of the highest priority thread that is requesting

s/that is//

> the lock, which allows the low-priority thread to run until it

the lock.  The low-priority thread will complete its critical section 
and release the lock, at which point its original priority will be restored.

> completes its critical section and releases the lock. 
> 
> In addition to changing kernel locking, interrupts have been threaded,

interrupt handlers have been converted into schedulable threads.

> meaning that instead of handling interrupts in a special "interrupt

s/meaning that i/. I/

> context", each interrupt number has a dedicated thread for running its
> service routines. Interrupts go to a common handler and that handler

s/and that handler/which/

> schedules the appropriate thread to service the interrupt. This means
> that interrupt service order may be prioritized by assigning appropriate
> realtime priorities to the interrupt threads.  Further, using realtime
> priorities, user-level threads may be prioritized *above* certain
> device level activity, allowing critical application tasks to take
> precedence over device activity deemed less important.

Suggest sticking to "task" or "thread" throughout to avoid confusion.

Thanks,

Darren

> 
> ---------------------8< snip 8<----------------------------------
> 
> Kinda big for an elevator pitch, but hey, I'm sure the marketing and
> sales guys will paraphrase it into "It makes things go Real Fast!" :)
> 
> Clark
> 
> 
> 
> 
> 	


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
