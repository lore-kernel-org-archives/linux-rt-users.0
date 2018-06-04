Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40139 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDVat (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 17:30:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so200006qtn.7
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jun 2018 14:30:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604210459.GB20752@sisyphus.home.austad.us>
References: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
 <20180604210459.GB20752@sisyphus.home.austad.us>
From: Ran Shalit <ranshalit@gmail.com>
Date: Tue, 5 Jun 2018 00:30:47 +0300
Message-ID: <CAJ2oMhJ-bkzo87ynSEnfnZfAXOo0opEEQB+djvNbeGeHHvhHag@mail.gmail.com>
Subject: Re: ostream::flush in RT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Henrik Austad <henrik@austad.us>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Tue, Jun 5, 2018 at 12:04 AM, Henrik Austad <henrik@austad.us> wrote:
> On Mon, Jun 04, 2018 at 10:51:00PM +0300, Ran Shalit wrote:
>> Hello,
>
> Hi,
>
>> I currently use Linux without rt patch, yet we have some timing
>> requirements, and we consider moving to RT linux.
>>
>> We tried to measure time in threads, in order to build a better rt application.
>>
>> I hope I can ask a question about one issue, which we are not sure about:
>>
>> We have a thread which does:
>> ...
>>  <-- start time measurement
>> {
>> osteam::write
>> ostream::flush
>> .}
>> <-- end time measurement
>> ...
>
> I am unsure, are you using writing to disk as a test for RT performance, or
> are you testing the RT performance of disk IO?
>
>> It seems that in general, the write to disk using these functions add
>> time for the thread between entrace to main function of thread.
>>
>> But  the time difference of these two commands behaves strangely: we
>> see that in of the measurements it's 10msec,  and only once in a while
>> it gets up to 500msec.
>
> 10ms for a simple flush? Do you use rotational media?
>
> The 500ms timeout can be a lot of things, extra data being flushed, once
> you write to disk, you run the risk of writing data for other processes as
> well. You also do a detour inside the kernel, interrupts can happen,
> network softirqs, if you block on IO, then another thread can grab the CPU
> delaying you even further etc.
>
> That being said, 500ms is a pretty long delay.
>
>> So, I am not sure why it only sometimes consumes more time then the average.
>> Is it that there is some kernel thread responsible for disk which only
>> sometimes consumes more time ?
>>
>> I would assume that the flush should always consume the time for write
>> to disk, is it wrong to assume so ? we always write the same size, so
>> why is the average different then the maximum ?
>
> You cannot assume anything when you do blocking IO from a thread. The rule
> of thumb is: don't write to disk, or do any other blocking syscalls form an
> RT thread. Delegate to other helpers, allocate up front etc.
>
>> Will it help to put it in another RT thread with lower priority ?
>
> It will help doing it from /another/ thread yes. It will also help to
> shield the core where you run your RT app, make sure no other interrupts
> are delivered there etc.
>
> A good starting point is to use the tracing infrastructure in the kernel to
> measure delays. Instead of writing to disk, write to the trace_marker and
> stop the trace when you hit a 500ms delay. Enable a few events (I like
> syscalls, sched and irq as a start)
>
> Have a look at Stevens intro to using ftrace for debugging:
> https://lwn.net/Articles/365835/ (part 1)
> https://lwn.net/Articles/366796/ (part 2)
>

Thank you very much for the comments. It's Very helpful.

I have two more question, if I may....

1. Are all above suggestions valid also for "soft realtime", i.e.
linux without rt patch, yet using rt threads priorities, mlock, etc ?

2. We have request to "never" miss a gps message, each message arrives
every 1 second. Is a one second "hard requirements" means that we MUST
use RT patch, or is it that "1 second" requirements can be achieved
using "soft realtime" Linux. We use armv7 dual core arm 100MHz (I
think it is very poor and can explain the 500msec burst which appear
sometimes in the flush, right ?)


Thanks again!
Ranran

>
> Good luck!
>
> --
> Henrik Austad
