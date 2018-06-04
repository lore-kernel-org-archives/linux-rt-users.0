Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35129 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeFDVsM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 17:48:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id y72-v6so292580lfd.2
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jun 2018 14:48:11 -0700 (PDT)
Date: Mon, 4 Jun 2018 23:48:07 +0200
From: Henrik Austad <henrik@austad.us>
Subject: Re: ostream::flush in RT
Message-ID: <20180604214806.GA21263@sisyphus.home.austad.us>
References: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
 <20180604210459.GB20752@sisyphus.home.austad.us>
 <CAJ2oMhJ-bkzo87ynSEnfnZfAXOo0opEEQB+djvNbeGeHHvhHag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJ-bkzo87ynSEnfnZfAXOo0opEEQB+djvNbeGeHHvhHag@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Tue, Jun 05, 2018 at 12:30:47AM +0300, Ran Shalit wrote:
> On Tue, Jun 5, 2018 at 12:04 AM, Henrik Austad <henrik@austad.us> wrote:
> > On Mon, Jun 04, 2018 at 10:51:00PM +0300, Ran Shalit wrote:
> >> Hello,
> >
> > Hi,
> > [...]
> >
> >> So, I am not sure why it only sometimes consumes more time then the average.
> >> Is it that there is some kernel thread responsible for disk which only
> >> sometimes consumes more time ?
> >>
> >> I would assume that the flush should always consume the time for write
> >> to disk, is it wrong to assume so ? we always write the same size, so
> >> why is the average different then the maximum ?
> >
> > You cannot assume anything when you do blocking IO from a thread. The rule
> > of thumb is: don't write to disk, or do any other blocking syscalls form an
> > RT thread. Delegate to other helpers, allocate up front etc.
> >
> > [...]
> 
> Thank you very much for the comments. It's Very helpful.
> 
> I have two more question, if I may....
> 
> 1. Are all above suggestions valid also for "soft realtime", i.e.
> linux without rt patch, yet using rt threads priorities, mlock, etc ?

Yes, this goes for all "time-sensitive" threads, avoid unbounded latencies 
and uncertainties where you can.

Steps to do (in no particular order, what is optimal for me may not be 
optimal for you):

- Do a (careful) analysis of your tasks priorities to make sure the most 
  important thread have the highest pri
- Use locks with priority inheritance
- Steer interrupts away from the core with the RT thread (if you have more 
  than 1 core)
- Allocate all memory up front
- Consider SCHED_DEADLINE
- Use preempt-rt patch

In most cases, you don't really need the determinism preemt_rt gives you, 
it all comes down to the consequence of failure. Remember that real-time 
does not mean real-fast. It may in some scenarios run slower. But it will 
run at the same speed every single time, and *that* is important for RT 
systems.

> 2. We have request to "never" miss a gps message, each message arrives
> every 1 second. Is a one second "hard requirements" means that we MUST
> use RT patch, or is it that "1 second" requirements can be achieved
> using "soft realtime" Linux. We use armv7 dual core arm 100MHz (I
> think it is very poor and can explain the 500msec burst which appear
> sometimes in the flush, right ?)

Well, 1 second is a *long* time. What PREEMPT_RT gives you is a 
deterministic OS. In pretty much all scenarios, you can tune a non-rt 
system to handle an event with a 1sec delay, at least for 99.999% of the 
times. But then comes that pesky 0.001%.. as I said, it all comes down to 
the consequence of failure.

However, if you see delays of 500ms, I'd start by throwing some traces at 
this to pinpoint exactly what the core is doing for 500ms first, because 
*that* will be important no matter what kernel you throw at the problem.

-- 
Henrik Austad
