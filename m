From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 17:58:59 -0800
Message-ID: <AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>
	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63678 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1BOB7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 20:59:00 -0500
Received: by qyj19 with SMTP id 19so1971593qyj.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 17:59:00 -0800 (PST)
In-Reply-To: <AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 14, 2011 at 5:10 PM, Peter LaDow <petela@gocougs.wsu.edu> w=
rote:
> On Mon, Feb 14, 2011 at 3:30 PM, Frank Rowand <frank.rowand@gmail.com=
> wrote:
>> On Mon, Feb 14, 2011 at 2:31 PM, Peter LaDow <petela@gocougs.wsu.edu=
> wrote:
>>> How is the scheduling of the hrtimers softirq thread handled?
>>>
>>> When querying the RT priority of the hrtimer softirq, I get a prior=
ity
>>> of 50. =A0But when running a priority 99 thread, we still seem to b=
e
>>> getting interrupted. =A0Shouldn't the hrtimer softirq be put off un=
til
>>> the CPU is idle or a lower priority task is running?
>>
>> Is the hrtimer softirq executing when the priority 99 thread is spin=
ning
>> in it's for loop? =A0Your "jitter Due to Large Number of Timers" ema=
il
>> said that the lower priority tasks don't seem to be interrupting the
>> priority 99 thread.
>
> Did I? =A0Hmm, well I mean the lower priority task with 100 threads. =
=A0At
> least I think so. =A0It is hard to tell.
>
> It seems to me that the softirq thread is the source of the problem.
> Since the tight loop is getting such a variety of times (400us of
> jitter only while the other process is running) that it does seem tha=
t
> the loop is getting interrupt.

Just so we are speaking with a common definition of jitter, your first =
email
said that the duration of the priority 99 thread loop increased by
around 350us (average and maximum) when the lower priority task
timers were added to the system.

>
>> The hardware timer interupts will interrupt the priority 99 thread. =
=A0The
>> cost of these interrupts and the resultant calls to try_to_wake_up()
>> of the hrtimer softirq might be quite large considering the rate of
>> timer expires you mentioned in your first email.
>
> Sure, we expect the timer interrupt to interfere. =A0But as we

So what is the overhead of the timer interrupt?

1) All 100 of the the test100 timers pop at the same time:

  - 1 hardware interrupt
  - Chasing through an hrtimer list of size 100
  - call try_to_wake_up() for the hrtimer softirq
    (I don't remember whether try_to_wake_up() will be called just once=
,
    or once per timer.  But even if called 100 times, the first call is
    "expensive" and the other 99 will be very cheap).

2) Each of the 100 test100 timers pop at a separate, unique time:

  - 100 hardware interrupts
  - For each interrupt, chase through an hrtimer list of size 1
  - For each interrupt, call try_to_wake_up().  The first call is
    "expensive", for the other 99 interrupts the call will be cheap.

3) Then every other possible combination of clumps of timers popping
at the same time.

4) Just for completeness, not all of the test100 timers has to pop
during each iteration of the priority 99 thread loop, but that does not
impact the analysis of the worst case scenario, so we can just ignore
that.

I would expect scenario 1 to have the lowest overhead, scenario 2 to
have the highest overhead, and scenario 3 to be in the middle.

=46or a 533 Mhz PPC, I would not be surprised if the overhead of these
three scenarios is as large as 350 us.

> understand it, the softirq is what schedules the task switch. =A0The =
top
> half only schedules the bottom half. =A0But since the bottom half is
> priority 50, there shouldn't be any interruption of the priority 99
> expect to handle the low level IRQ.

You can verify whether any other process is executing through a variety
of tools.  LTT if you have it in your kernel. I think 2.6.29 had ftrace
"Trace process context switches" (CONFIG_CONTEXT_SWITCH_TRACER),
I don't think there was a perf option for context switches in 2.6.29.

>
>> Out of curiosity, is the system UP or SMP?
>
> UP. =A0Just a single MPC5349.
>
> pete
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
