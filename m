From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Scheduling behaviour of 23-rc4-rt1 on my intel centrino Duo.
Date: Fri, 5 Oct 2007 09:48:22 -0700
Message-ID: <200710050948.22319.dvhltc@us.ibm.com>
References: <34ac6d890709251935x390bee54ma761ed05f73d95a1@mail.gmail.com> <34ac6d890710042340j2a087190qa09ad8e9504e2bac@mail.gmail.com> <200710050906.11961.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Girish kathalagiri" <girish.sk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49071 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372AbXJEQs0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Oct 2007 12:48:26 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l95GmNMo031346
	for <linux-rt-users@vger.kernel.org>; Fri, 5 Oct 2007 12:48:23 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l95GmN9Y452206
	for <linux-rt-users@vger.kernel.org>; Fri, 5 Oct 2007 12:48:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l95GmNnW011624
	for <linux-rt-users@vger.kernel.org>; Fri, 5 Oct 2007 12:48:23 -0400
In-Reply-To: <200710050906.11961.dvhltc@us.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday 05 October 2007 09:06:11 Darren Hart wrote:
> On Thursday 04 October 2007 23:40:53 Girish kathalagiri wrote:
> > Hi Daren,
> >
> > > 1) How are you determining which CPUs these threads spend their time
> > > on?
> >
> > The hourglass test's  stores the execution trace . The trace is
> > generated as the threads are run , each time the thread detects a gap
> > in the execution, it records a trace , which includes start time and
> > end time of the continuous block of  CPU time that a thread received.
> >   output looks something like this
> > tracerec: 3 4569.581302 4669.572704 99.991402 400.007546
> > tracerec: 1 4669.581304 4769.572370 99.991066 400.007679
> > tracerec: 2 4769.581030 4869.572168 99.991138 400.007727
> > tracerec: 4 4869.580624 4969.571912 99.991288 400.007546
> >  (columns: thread id , strat time and end time of gap free time of
> > CPU, duration of the interval, last column shows the time it has taken
> > from the end of the previous schedule of the thread)
> > The values are plotted and the graph is attached.
> > It can be noted that the thread 0 runs all the time and the thread 1-5
> > gets time equal slices. Hence it can be seen that thread 0 is hogging
> > a cpu completely and thread 1-5 are hogging the other cpu.
>
> OK, looking at your output, I'd have to agree (although your plot doesn't
> show thread 0 running at all, I presume it should have a gray bar that is a
> full 10 seconds long?).
>
> I usually deal with SCHED_FIFO threads, so I'm going to take a look at the
> SCHED_RR behavior to see how it's implemented.


I think I understand what is going on.  When the 6 threads are initially 
scheduled, T0 is placed on CPU0 and T[1-5] are placed on CPU 1.  Since they 
are very high priority, and all the same priority, they are never preempted, 
and they never "wake up", missing those opportunities for the rt_pulled code 
(which wouldn't pull them anyway since they are the same priority, not 
greater, than the threads on the other runqueues).  The scheduler doesn't 
prefer one task a given priority over any other of the same priority.  When 
they expire, they get sent to the back of the current runqueue, and the next 
SCHED_RR thread on the local runqueue would be scheduled to run (relying on 
the FIFO behavior of the array for ordering).  Since there is no way to do 
global RR ordering across all runqueues without some nasty logic looking at 
the last time each was scheduled, the scheduler appears to only guarantee a 
local runqueue RR policy.  If you want to better balance a SCHED_RR 
application, I suggest you look into CPU pinning.

Regards,

Darren Hart

>
> --Darren
>
> > > 2) RTHIGH doesn't do anything for us.  What is the value of the
> > > SCHED_FIFO priority those threads run at?  Is it the same for every
> > > one?
> >
> > All the threads are running at an RT priority of 97 (maxrt prio - 2).
> > code:
> >
> >  max_realtime_pri = sched_get_priority_max (SCHED_RR);
> >
> > and
> >
> > case RTHIGH:
> >     param->sched_priority = max_realtime_pri - 2;
> >
> > > Note that depending on exactly what those threads do (I am unfamiliar
> > > with the hourglass testcase) it isn't unreasonable for them to all run
> > > on the same CPU if their runnable/sleeping states happen to line up
> > > just right.  It is also very possible that they bounce around from CPU
> > > to CPU in rapid succession if the runnable/sleeping windows overlap in
> > > exactly the wrong way :-)
> >
> > All the thread does is it hogs the CPU whenever it can.I have also
> > attached the test result and the graph that has run for 10s. Graph
> > basically shows the context switches that has happened between the
> > thread 1-5 (round robin).Thread 0 does not record any context switch
> > as it runs fully
> > thread 0 recorded 10.039664 seconds (99.999746 %)



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
