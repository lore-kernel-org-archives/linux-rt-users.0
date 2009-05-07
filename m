From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: idle task starvation with rt patch
Date: Thu, 7 May 2009 10:59:49 +0530
Message-ID: <921ca19c0905062229l5302c6d0v69bb54b7cc92f35f@mail.gmail.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
	 <4A01FB5E.1000006@us.ibm.com>
	 <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
	 <4A021AB6.3090807@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David L <idht4n@gmail.com>, linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:57982 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZEGF3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 May 2009 01:29:48 -0400
Received: by wf-out-1314.google.com with SMTP id 26so532352wfd.4
        for <linux-rt-users@vger.kernel.org>; Wed, 06 May 2009 22:29:49 -0700 (PDT)
In-Reply-To: <4A021AB6.3090807@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 7, 2009 at 4:48 AM, Nivedita Singhvi <niv@us.ibm.com> wrote=
:
> David L wrote:
>
>> In mainline, we have our receiver application schedules about
>> 6 threads, all with SCHED_FIFO priority between about 65 and 97.
>> After applying the real-time patch, I noticed some IRQ handling
>> processes that appeared to have a real-time priority of about 50.
>> So I tried adjusting our application's priority to have only one thr=
ead
>> with priority higher than 50 (the one with the real-time requirement=
s
>> that nomincally uses about 250 usec per msec of CPU).
>
> Right - the bulk of the interrupt overhead (including
> processing of softirqs etc) would not occur (or rather,
> would not be allowed to preempt your SCHED_FIFO task at higher priori=
ty).

Could you be more specific on what part of the Real Time Code is this
priority being set? Whether it can be changed to get the current
application running? Also What is the Specific part to PPC32 and PPC64?

>
>> Our receiver process which tracks RF signals based on the
>> information from an FPGA that provides baseband accumulated
>> samples at about 1000 times per second. =A0It has some lower
>> priority SCHED_FIFO threads that have relatively loose timing
>> constraints but do need about a second of CPU time every few
>> seconds to prevent a queue overflow that causes the process
>> to assert and crash by design.
>
> A second of CPU time every few seconds sounds like a
> lot, actually - even if lower priority, it still sounds
> like it's a must-happen, and you might need to bump up
> its priority(?).

Could you tell us some tool that can be used to measure the time taken
other than the time function. Also how much of the time is required by
the SCHED_FIFO?

>
>> The priorities all seem to be set right... without the real-time
>> patches, it seems that the kernel isn't real-time enough to
>> meet our timing requirements in some cases. =A0With the real-time
>> patches, the CPU loading for the identical process goes from
>> about 50% to about 100%. =A0I'm wondering why there is such
>> a dramatic difference in CPU usage.
>
> You might need to instrument it further or use ftrace
> to figure out what's happening. RT is slower to process
> incoming interrupts (kernel threads vs softirqs) so it
> might be a factor - do you use affinity to pin threads
> and/or interrupts? You might be able to play with that
> to perhaps avoid the problem. It should not behave this
> differently, but I could be wrong...

Could you tell whether it is HARD real time or Soft Real Time?
>
> thanks,
> Nivedita
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
