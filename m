From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 11:12:08 -0800
Message-ID: <AANLkTi=ajLEV2S_6RcHKE8w82DSTMObg3TXFOjoZCdmF@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>
	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
	<AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com>
	<AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com>
	<4D5AC80F.1090205@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Rowand <frank.rowand@gmail.com>,
	linux-rt-users@vger.kernel.org
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63735 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab1BOTMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 14:12:09 -0500
Received: by gxk9 with SMTP id 9so251145gxk.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2011 11:12:08 -0800 (PST)
In-Reply-To: <4D5AC80F.1090205@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I made an error in my last post.  My call tree wasn't accurate since I
was looking at unpatched code.  After applying the RT patch, the call
tree changes a bit:

timer_interrupt
=A0|
=A0+ hrtimer_interrupt
=A0 =A0 |
=A0 =A0 + raise_softirq_irqoff
        |
       + wakeup_softirqd
             |
            + wake_up_process
                   |
                  + try_to_wakeup

It indeed does offload the timer expirations to the hrtimer softirq.
And the only task that try_to_wakeup works on is the softirq handler.
So this overhead is even less than I thought.  Indeed it is quite
light.

So it seems that I was on track before.  The hrtimer softirq task is
running at a priority of 50:

# ps | grep irq
   10 root         0 SW<  [sirq-hrtimer/0]
# chrt -p 10
pid 10's current scheduling policy: SCHED_FIFO
pid 10's current scheduling priority: 50

And I run my program with 'chrt -f 99'.  So it does seem that the
hrtimer softirq task should not interfere.

So I'm back to the scenarios you described earlier.  I suppose if the
timers are close in proximity, there would be a flurry of interrupts
frequently occurring.  Each of these could in fact slow things down.
So to prevent this deluge, we tried something.  We bumped up the
minimum resolution on the decrementer to something closer to 1ms.
This means the decrementer would interrupt us no more often than 1ms.
We modified arch/powerpc/kernel/time.c to set the min_delta_ns of the
decrement to a larger value (large enough to equal about 1ms) rather
than the default 2.  The jitter disappeared.  Now, I know that doing
this effectively eliminates their use as "high resolution", but it
proves the point that it is the flurry of interrupts causing the
problems.

So it does seem that it is the interrupt overhead that is the problem.
 So if we want high resolution, but low overhead, we have to get
around the problem of lots of tasks using clock_nanosleep.  In our
real-world system, we have only 1 high priority task that must run
every 500us.  More than 99% of the time, it gets to run and completes
its work very quickly.  However, than <1% of the time, it doesn't run
for 1ms to 2ms, breaking our requirements.  We have several lower
priority tasks running, each using clock_nanosleep or pending on an
I/O event.  It may be in our system that the relatively large number
of timers is occasionally causing a flurry of interrupts increasing
the jitter.  So how do we get rid of it?

I see only 2 ways:  1) stop using clock_nanosleep or 2) stop using
high resolution timers.  Implementation of both is problematic.
Eliminating use of clock_nanosleep would require replacing it with
something that didn't resolve to an underlying nanosleep system call,
which I think is impossible (except for using sleep, but that only
gives us 1sec resolution).  And turning off the high resolution timers
makes it impossible for us to wake every 500us.

Hmmm....I guess this really is a limitation of our platform.  We are
just up against the wall in terms of burden and processing power.
There just isn't enough horsepower to do everything we want at the
time we want.

On Tue, Feb 15, 2011 at 10:38 AM, Frank Rowand <frank.rowand@gmail.com>=
 wrote:
> On 02/15/11 08:42, Peter LaDow wrote:
>> On Mon, Feb 14, 2011 at 5:58 PM, Frank Rowand <frank.rowand@gmail.co=
m> wrote:
>>> Just so we are speaking with a common definition of jitter, your fi=
rst email
>>> said that the duration of the priority 99 thread loop increased by
>>> around 350us (average and maximum) when the lower priority task
>>> timers were added to the system.
>>
>> Well, I'm only speaking to the maximum. =A0We do expect some increas=
e in
>> the maximum runtime of the loop when those other timers are added.
>> However, we did not expect it to occasionally spike by 350us.
>>
>>>> Sure, we expect the timer interrupt to interfere. =A0But as we
>>>
>>> So what is the overhead of the timer interrupt?
>>
>> We are on a PPC platform, and the decrementer interrupt is in
>> arch/powerpc/kernel/time.c on lines 541-593. =A0The only line that s=
eems
>> that it can have an impact (at least with regard to the timers) is o=
n
>> line 576:
>>
>> =A0 evt->event_handler(evt);
>>
>> Which according to /proc/timer_list is hrtimer_interrupt. =A0This is
>> found in kernel/hrtimer.c (lines 1195-1267). =A0And this does indeed
>> seem to be where the bulk of the problem lies. =A0On line 1226 we ha=
ve:
>>
>> =A0 while ((node =3D base->first)) {
>>
>> Which loops through all the clock bases. =A0This only checks the fir=
st
>> timer on the rbtree (uses base-->first). =A0It then calls __run_time=
r
>> with the timer at the head of the tree. =A0And __run_hrtimer calls t=
he
>> timer callback function. =A0In the case of these timers it is
>> hrtimer_wakeup. =A0And each of these calls wake_up_process().
>>
>> So hmm, perhaps this is it. =A0There is no softirq that calls the wa=
keup
>> function. =A0In fact, there doesn't seem to be a bottom half in this
>> case at all. =A0The decrementer interrupt does all the work, rather =
than
>> postpone it to a bottom half. =A0Looking at the call tree:
>>
>> timer_interrupt
>> =A0 |
>> =A0 + hrtimer_interrupt
>> =A0 =A0 =A0|
>> =A0 =A0 =A0+ __run_timer
>> =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 + hrtimer_wakeup
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 + wake_up_process
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ try_to_wake_up
>>
>> And the try_to_wake_up is the scheduler (no?).
>
> try_to_wake_up() is in the scheduler code (kernel/sched.c), but it is
> not "the scheduler". =A0If the task is not already running,
> try_to_wake_up() will put the task on the run queue and set it's stat=
e
> to TASK_RUNNING. =A0If the priority of the newly woken thread was hig=
her
> than the current thread, then the newly woken thread would preempt
> current. =A0If a preemption occurred, then TIF_NEED_RESCHED is set.
>
> The actual "schedule" will occur on the exit path of the interrupt
> only if TIF_NEED_RESCHED is set (see the call of preempt_schedule_irq=
()).
>
>>
>> So, if this is the chain of events, then what is sirq-hrtimer for? =A0=
I
>> see in hrtimers_init (lines 1642-1650):
>>
>> =A0 open_softirq(HRTIMER_SOFTIRQ, run_hrtimer_softirq);
>>
>> And run_hrtimer_softirq eventually calls hrtimer_interrupt. =A0But t=
he
>> prior mechanism seems to be the standard means. =A0Even on my x86 bo=
x
>> (2.6.32-28) it shows hrtimer_interrupt as the event handler for the
>> clocks. =A0And looking in arch/x86/kernel/time_32.c and
>> arch/x86/kernel/time_64.c both take the same route.
>>
>> So, it seems to me that run_hrtimer_softirq never gets called via an=
y
>> interrupt mechanism. =A0In fact, it only seems to be called when
>> creating timers such as in nanosleep. =A0The HRTIMER_SOFTIRQ is only
>> raised in hrtimer_enqueue_reprogram, which is called in
>> hrtimer_start_range_ns. =A0And none of these have to do with timer
>> expiration.
>>
>> So, it seems the problem really is interrupt overhead. =A0We had
>> presumed that the timer sirq-hrtimer handled these timer expirations=
,
>> and thus the scheduler. =A0Rather, we find that a full reschedule is
>> being done every interrupt.
>
> You should not have a full reschedule when a timer interrupt occurs
> for a priority 50 process while the priority 99 process is executing
> (see earlier explanation).
>
> But yes, there is a possibility that the problem is interrupt
> overhead. =A0You could measure it to verify the theory.
>
>>
>> Does my analysis make sense?
>
> Yes. =A0I did not double check the actual code that you described,
> and I haven't been poking around in PPC for a while, but what you
> describe sounds reasonable.
>
>>
>> Thanks,
>> Pete
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
