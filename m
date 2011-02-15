From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 10:38:07 -0800
Message-ID: <4D5AC80F.1090205@am.sony.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>	<AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com> <AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Rowand <frank.rowand@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63930 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1BOSiO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 13:38:14 -0500
Received: by pwj3 with SMTP id 3so119199pwj.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2011 10:38:13 -0800 (PST)
In-Reply-To: <AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/15/11 08:42, Peter LaDow wrote:
> On Mon, Feb 14, 2011 at 5:58 PM, Frank Rowand <frank.rowand@gmail.com> wrote:
>> Just so we are speaking with a common definition of jitter, your first email
>> said that the duration of the priority 99 thread loop increased by
>> around 350us (average and maximum) when the lower priority task
>> timers were added to the system.
> 
> Well, I'm only speaking to the maximum.  We do expect some increase in
> the maximum runtime of the loop when those other timers are added.
> However, we did not expect it to occasionally spike by 350us.
> 
>>> Sure, we expect the timer interrupt to interfere.  But as we
>>
>> So what is the overhead of the timer interrupt?
> 
> We are on a PPC platform, and the decrementer interrupt is in
> arch/powerpc/kernel/time.c on lines 541-593.  The only line that seems
> that it can have an impact (at least with regard to the timers) is on
> line 576:
> 
>   evt->event_handler(evt);
> 
> Which according to /proc/timer_list is hrtimer_interrupt.  This is
> found in kernel/hrtimer.c (lines 1195-1267).  And this does indeed
> seem to be where the bulk of the problem lies.  On line 1226 we have:
> 
>   while ((node = base->first)) {
> 
> Which loops through all the clock bases.  This only checks the first
> timer on the rbtree (uses base-->first).  It then calls __run_timer
> with the timer at the head of the tree.  And __run_hrtimer calls the
> timer callback function.  In the case of these timers it is
> hrtimer_wakeup.  And each of these calls wake_up_process().
> 
> So hmm, perhaps this is it.  There is no softirq that calls the wakeup
> function.  In fact, there doesn't seem to be a bottom half in this
> case at all.  The decrementer interrupt does all the work, rather than
> postpone it to a bottom half.  Looking at the call tree:
> 
> timer_interrupt
>   |
>   + hrtimer_interrupt
>      |
>      + __run_timer
>           |
>           + hrtimer_wakeup
>               |
>               + wake_up_process
>                    |
>                    + try_to_wake_up
> 
> And the try_to_wake_up is the scheduler (no?).

try_to_wake_up() is in the scheduler code (kernel/sched.c), but it is
not "the scheduler".  If the task is not already running,
try_to_wake_up() will put the task on the run queue and set it's state
to TASK_RUNNING.  If the priority of the newly woken thread was higher
than the current thread, then the newly woken thread would preempt
current.  If a preemption occurred, then TIF_NEED_RESCHED is set.

The actual "schedule" will occur on the exit path of the interrupt
only if TIF_NEED_RESCHED is set (see the call of preempt_schedule_irq()).

> 
> So, if this is the chain of events, then what is sirq-hrtimer for?  I
> see in hrtimers_init (lines 1642-1650):
> 
>   open_softirq(HRTIMER_SOFTIRQ, run_hrtimer_softirq);
> 
> And run_hrtimer_softirq eventually calls hrtimer_interrupt.  But the
> prior mechanism seems to be the standard means.  Even on my x86 box
> (2.6.32-28) it shows hrtimer_interrupt as the event handler for the
> clocks.  And looking in arch/x86/kernel/time_32.c and
> arch/x86/kernel/time_64.c both take the same route.
> 
> So, it seems to me that run_hrtimer_softirq never gets called via any
> interrupt mechanism.  In fact, it only seems to be called when
> creating timers such as in nanosleep.  The HRTIMER_SOFTIRQ is only
> raised in hrtimer_enqueue_reprogram, which is called in
> hrtimer_start_range_ns.  And none of these have to do with timer
> expiration.
> 
> So, it seems the problem really is interrupt overhead.  We had
> presumed that the timer sirq-hrtimer handled these timer expirations,
> and thus the scheduler.  Rather, we find that a full reschedule is
> being done every interrupt.

You should not have a full reschedule when a timer interrupt occurs
for a priority 50 process while the priority 99 process is executing
(see earlier explanation).

But yes, there is a possibility that the problem is interrupt
overhead.  You could measure it to verify the theory.

> 
> Does my analysis make sense?

Yes.  I did not double check the actual code that you described,
and I haven't been poking around in PPC for a while, but what you
describe sounds reasonable.

> 
> Thanks,
> Pete
> 

