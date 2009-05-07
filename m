From: David L <idht4n@gmail.com>
Subject: Re: idle task starvation with rt patch
Date: Thu, 7 May 2009 06:01:41 -0700
Message-ID: <b79371120905070601j60ad1801u65c4ed66a6ccc8f7@mail.gmail.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
	 <4A01FB5E.1000006@us.ibm.com>
	 <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
	 <4A021AB6.3090807@us.ibm.com>
	 <921ca19c0905062229l5302c6d0v69bb54b7cc92f35f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sujit Karataparambil <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:57312 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbZEGNBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 May 2009 09:01:42 -0400
Received: by qyk31 with SMTP id 31so1319337qyk.33
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2009 06:01:42 -0700 (PDT)
In-Reply-To: <921ca19c0905062229l5302c6d0v69bb54b7cc92f35f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, May 6, 2009 at 10:29 PM, Sujit Karataparambil wrote:
> On Thu, May 7, 2009 at 4:48 AM, Nivedita Singhvi wrote:
>> David L wrote:
>>
>>> In mainline, we have our receiver application schedules about
>>> 6 threads, all with SCHED_FIFO priority between about 65 and 97.
>>> After applying the real-time patch, I noticed some IRQ handling
>>> processes that appeared to have a real-time priority of about 50.
>>> So I tried adjusting our application's priority to have only one th=
read
>>> with priority higher than 50 (the one with the real-time requiremen=
ts
>>> that nomincally uses about 250 usec per msec of CPU).
>>
>> Right - the bulk of the interrupt overhead (including
>> processing of softirqs etc) would not occur (or rather,
>> would not be allowed to preempt your SCHED_FIFO task at higher prior=
ity).
>
> Could you be more specific on what part of the Real Time Code is this
> priority being set?

I'm not sure I understand this question, but I'll try to
answer it anyway.  There is one process with a handful
of SCHED_FIFO-scheduled threads.  The highest
priority one blocks on a read from a driver that interfaces
with an FPGA and wakes up every ~950 microseconds.
It seems to consume about 250 microseconds per
msec using the mainline kernel.  That thread can tolerate
frequent delays of a few msec with a rare delay of up to
about 7 msec... after that, we lose track of the RF
signals we're tracking.

There are a few lower priority threads that do some
processing of the data demodulated by the highest
priority thread.  Those have relatively soft real-time
requirements.  Earlier I said they needed a second
of CPU time every few seconds.  Really, it's probably
more like a second every 5 seconds.


> Whether it can be changed to get the current
> application running?
I don't think so, but I haven't exhaustively tried different
priorities.  I've just tried a few that seem reasonable.  I know
it doesn't work with the same priority levels for which it works
almost perfectly without the real-time patches.  And I know it
doesn't work after lowering all of the priorities such that only
one is above 50.  The symptom is 2x higher CPU loading
relative to the non-real-time-patched kernel.


> Also What is the Specific part to PPC32 and PPC64?
PPC32 (specifically, an MPC5200)

>
>>
>>> Our receiver process which tracks RF signals based on the
>>> information from an FPGA that provides baseband accumulated
>>> samples at about 1000 times per second. =A0It has some lower
>>> priority SCHED_FIFO threads that have relatively loose timing
>>> constraints but do need about a second of CPU time every few
>>> seconds to prevent a queue overflow that causes the process
>>> to assert and crash by design.
>>
>> A second of CPU time every few seconds sounds like a
>> lot, actually - even if lower priority, it still sounds
>> like it's a must-happen, and you might need to bump up
>> its priority(?).
>
> Could you tell us some tool that can be used to measure the time take=
n
> other than the time function. Also how much of the time is required b=
y
> the SCHED_FIFO?

Without the real-time patch applied, I used top to watch the CPU
consumption per thread.  I also used the kernel sched_switch
tracing tool and the application monitors its own CPU usage
using clock_gettime with a clock initialized by pthread_getcpuclockid.
With the real-time patch applied, top doesn't run the way I usually
run it because the CPU is starved.  I guess I could run top at a
high priority, but I haven't tried that.  But the kernel trace I showed
with the original email shows what is running when, and it shows
that the CPU is never idle.


>>
>>> The priorities all seem to be set right... without the real-time
>>> patches, it seems that the kernel isn't real-time enough to
>>> meet our timing requirements in some cases. =A0With the real-time
>>> patches, the CPU loading for the identical process goes from
>>> about 50% to about 100%. =A0I'm wondering why there is such
>>> a dramatic difference in CPU usage.
>>
>> You might need to instrument it further or use ftrace
>> to figure out what's happening. RT is slower to process
>> incoming interrupts (kernel threads vs softirqs) so it
>> might be a factor - do you use affinity to pin threads
>> and/or interrupts? You might be able to play with that
>> to perhaps avoid the problem. It should not behave this
>> differently, but I could be wrong...
>
Even without the real-time patches, I've found that the
overhead of the kernel ftrace tracing is so high that
the process doesn't run properly.

> Could you tell whether it is HARD real time or Soft Real Time?

I guess it depends on the exact definition.  The thread that
interacts with the FPGA needs to read the FGPA data typically
within say 2-3 msec with a rare excursion to  ~7 msec.
The mainline kernel does this under most conditions but it seems
like it just barely makes it and some small changes to the system can
cause us to miss those deadlines.

Thanks,

            David
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
