Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33288 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeFDVFD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 17:05:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so154907lfy.0
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jun 2018 14:05:03 -0700 (PDT)
Date: Mon, 4 Jun 2018 23:04:59 +0200
From: Henrik Austad <henrik@austad.us>
Subject: Re: ostream::flush in RT
Message-ID: <20180604210459.GB20752@sisyphus.home.austad.us>
References: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Mon, Jun 04, 2018 at 10:51:00PM +0300, Ran Shalit wrote:
> Hello,

Hi,

> I currently use Linux without rt patch, yet we have some timing
> requirements, and we consider moving to RT linux.
> 
> We tried to measure time in threads, in order to build a better rt application.
> 
> I hope I can ask a question about one issue, which we are not sure about:
> 
> We have a thread which does:
> ...
>  <-- start time measurement
> {
> osteam::write
> ostream::flush
> .}
> <-- end time measurement
> ...

I am unsure, are you using writing to disk as a test for RT performance, or 
are you testing the RT performance of disk IO?

> It seems that in general, the write to disk using these functions add
> time for the thread between entrace to main function of thread.
> 
> But  the time difference of these two commands behaves strangely: we
> see that in of the measurements it's 10msec,  and only once in a while
> it gets up to 500msec.

10ms for a simple flush? Do you use rotational media?

The 500ms timeout can be a lot of things, extra data being flushed, once 
you write to disk, you run the risk of writing data for other processes as 
well. You also do a detour inside the kernel, interrupts can happen, 
network softirqs, if you block on IO, then another thread can grab the CPU 
delaying you even further etc.

That being said, 500ms is a pretty long delay.

> So, I am not sure why it only sometimes consumes more time then the average.
> Is it that there is some kernel thread responsible for disk which only
> sometimes consumes more time ?
> 
> I would assume that the flush should always consume the time for write
> to disk, is it wrong to assume so ? we always write the same size, so
> why is the average different then the maximum ?

You cannot assume anything when you do blocking IO from a thread. The rule 
of thumb is: don't write to disk, or do any other blocking syscalls form an 
RT thread. Delegate to other helpers, allocate up front etc.

> Will it help to put it in another RT thread with lower priority ?

It will help doing it from /another/ thread yes. It will also help to 
shield the core where you run your RT app, make sure no other interrupts 
are delivered there etc.

A good starting point is to use the tracing infrastructure in the kernel to 
measure delays. Instead of writing to disk, write to the trace_marker and 
stop the trace when you hit a 500ms delay. Enable a few events (I like 
syscalls, sched and irq as a start)

Have a look at Stevens intro to using ftrace for debugging:
https://lwn.net/Articles/365835/ (part 1)
https://lwn.net/Articles/366796/ (part 2)


Good luck!

-- 
Henrik Austad
