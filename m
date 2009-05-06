From: David L <idht4n@gmail.com>
Subject: Re: idle task starvation with rt patch
Date: Wed, 6 May 2009 15:19:12 -0700
Message-ID: <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
	 <4A01FB5E.1000006@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:10931 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762618AbZEFWTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 May 2009 18:19:13 -0400
Received: by qw-out-2122.google.com with SMTP id 5so310616qwd.37
        for <linux-rt-users@vger.kernel.org>; Wed, 06 May 2009 15:19:13 -0700 (PDT)
In-Reply-To: <4A01FB5E.1000006@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, May 6, 2009 at 2:04 PM, Nivedita Singhvi wrote:
> David L wrote:
>>
>> Hi,
>>
>> I'm a newbie trying to see if the rt patch will improve
>> the performance of a PPC Linux receiver. =A0We need
>> to read data from an FGPA correlator about every msec
>> although we can tolerate 5-10 msecs from time to time.
>>
>> Without the real-time patches, we find that we sometimes
>> miss our timing deadlines especially when we have multiple
>> processes with "real-time" (SCHED_FIFO) threads. =A0I tried
>
> I take it you weren't seeing crashes on mainline?
No, our system works pretty well with the mainline kernel,
but it seems to very occasionally not meet our real-time
timing requirements.


>
>> to use the 2.6.29.2-rt11 patch to see if it helped, but things
>> got much worse. =A0We have about 30-60 percent idle CPU
>> without the patches... after applying the patches, I found
>> that we had essentially no idle time. =A0Below are excepts
>> from the kernel sched_switch trace file while our process
>> is running with and without the real-time patches applied.
>
> What priority are you running your real time tasks at?
In mainline, we have our receiver application schedules about
6 threads, all with SCHED_FIFO priority between about 65 and 97.
After applying the real-time patch, I noticed some IRQ handling
processes that appeared to have a real-time priority of about 50.
So I tried adjusting our application's priority to have only one thread
with priority higher than 50 (the one with the real-time requirements
that nomincally uses about 250 usec per msec of CPU).


>
>> I notice there are IRQ-related processes with the real-time
>> patches that don't exist in without the patches. =A0But the main
>> thing to notice is that there is no idle time which eventually
>> causes the process to crash because low priority threads
>
> Which process crashed?
Our receiver process which tracks RF signals based on the
information from an FPGA that provides baseband accumulated
samples at about 1000 times per second.  It has some lower
priority SCHED_FIFO threads that have relatively loose timing
constraints but do need about a second of CPU time every few
seconds to prevent a queue overflow that causes the process
to assert and crash by design.

>>
>> are starved for too long. =A0Am I doing something wrong or
>> is it expected overhead of the real-time patches will cause
>> problems like this under this kind of interrupt load?
>
> Making sure your priorities are set right so you don't
> starve essential processes is important...rt makes it
> easy to shoot yourself in the foot...

The priorities all seem to be set right... without the real-time
patches, it seems that the kernel isn't real-time enough to
meet our timing requirements in some cases.  With the real-time
patches, the CPU loading for the identical process goes from
about 50% to about 100%.  I'm wondering why there is such
a dramatic difference in CPU usage.


Thanks,

                  David
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
