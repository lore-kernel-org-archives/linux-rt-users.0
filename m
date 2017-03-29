From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Thu, 30 Mar 2017 06:46:30 +0800
Message-ID: <CANRm+CzSCJODribK6vPhQVT=CGFX7ewT6K3mTMu4vfZv5r_8LA@mail.gmail.com>
References: <20170323165512.60945ac6@redhat.com> <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
 <1490636129.8850.76.camel@redhat.com> <20170328132406.7d23579c@redhat.com>
 <20170329131656.1d6cb743@redhat.com> <20170329221700.GB23895@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        Rik van Riel <riel@redhat.com>
To: Frederic Weisbecker <fweisbec@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329221700.GB23895@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

2017-03-30 6:17 GMT+08:00 Frederic Weisbecker <fweisbec@gmail.com>:
> On Wed, Mar 29, 2017 at 01:16:56PM -0400, Luiz Capitulino wrote:
>> On Tue, 28 Mar 2017 13:24:06 -0400
>> Luiz Capitulino <lcapitulino@redhat.com> wrote:
>>
>> >  1. In my tracing I'm seeing that sometimes (always?) the
>> >     time interval between two timer interrupts is less than 1ms
>>
>> I think that's the root cause.
>>
>> I'm getting traces like this:
>>
>>    hog-11980 [015]   341.494491: function:             enter_from_user_mode <-- apic_timer_interrupt
>> <idle>-0     [000]   341.494492: function:             smp_apic_timer_interrupt <-- apic_timer_interrupt
>>    hog-11980 [015]   341.494492: function:             __context_tracking_exit <-- enter_from_user_mode
>> <idle>-0     [000]   341.494492: function:             irq_enter <-- smp_apic_timer_interrupt
>>    hog-11980 [015]   341.494492: bprint:               vtime_delta: diff=0 (now=4295008339 vtime_snap=4295008339)
>>    hog-11980 [015]   341.494492: function:             smp_apic_timer_interrupt <-- apic_timer_interrupt
>>    hog-11980 [015]   341.494492: function:             irq_enter <-- smp_apic_timer_interrupt
>>    hog-11980 [015]   341.494493: function:             tick_sched_timer <-- __hrtimer_run_queues
>> <idle>-0     [000]   341.494493: function:             tick_sched_timer <-- __hrtimer_run_queues
>> <idle>-0     [000]   341.494493: function:             tick_do_update_jiffies64.part.14 <-- tick_sched_do_timer
>> <idle>-0     [000]   341.494494: function:             do_timer <-- tick_do_update_jiffies64.part.14
>>    hog-11980 [015]   341.494494: function:             irq_exit <-- smp_apic_timer_interrupt
>> <idle>-0     [000]   341.494494: bprint:               do_timer: updated jiffies_64=4295008340 ticks=1
>>    hog-11980 [015]   341.494494: function:             __context_tracking_enter <-- prepare_exit_to_usermode
>>    hog-11980 [015]   341.494494: function:             vtime_user_enter <-- __context_tracking_enter
>>    hog-11980 [015]   341.494495: bprint:               vtime_delta: diff=1000000 (now=4295008340 vtime_snap=4295008339)
>>    hog-11980 [015]   341.494495: function:             __vtime_account_system <-- vtime_user_enter
>>    hog-11980 [015]   341.494495: bprint:               get_vtime_delta: vtime_snap=4295008339 now=4295008340
>>    hog-11980 [015]   341.494495: function:             account_system_time <-- __vtime_account_system
>>    hog-11980 [015]   341.494495: bprint:               account_system_time: cputime=995488
>> <idle>-0     [000]   341.494497: function:             irq_exit <-- smp_apic_timer_interrupt
>>
>> In this trace, we see the following:
>>
>>  1. On CPU15, we transition from user-space to kernel-space because
>>     of a timer interrupt (it's the tick)
>>
>>  2. vtimer_delta() returns 0, because jiffies didn't change since the
>>     last accounting
>>
>>  3. While CPU15 is executing in kernel-space, jiffies is updated
>>     by CPU0
>>
>>  4. When going back to user-space, vtime_delta() returns non-zero
>>     and the whole time is accounted for system time (observe how
>>     the cputime parameter in account_system_time() is less than 1ms)
>
> Aah, so the issue can indeed happen if all CPUs fire their ticks at the same time:
>
>
>                  CPU 0                         CPU 1
>                  -----                         -----
>                                                exit_user() // no cputime update
> tick X           update_jiffies
>                                                enter_user() // cputime update
>
>
>                                                exit_user() //no cputime update
> tick X+1         update_jiffies
>                                                enter_user() // cputime update
>
>>
>> That's why my patch from yesterday fixed the issue, it increased the
>> tick period to more than 1ms. So vtime_delta() always evaluate to true
>> when transitioning from user-space to kernel-space (because we spend
>> more than 1ms in user-space between ticks). The patch below achieves
>> the same result by adding 10us to the tick period.
>>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 7fe53be..00e46df 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -1165,7 +1165,7 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
>>         if (unlikely(ts->tick_stopped))
>>                 return HRTIMER_NORESTART;
>>
>> -       hrtimer_forward(timer, now, tick_period);
>> +       hrtimer_forward(timer, now, tick_period + 10000);
>
> I'm surprised it works though. If the 10us shift was only applied to CPU 0 and not the
> others then yes, but if it is applied to all CPUs, the ticks stay synchronized and the
> problem should stay...
>
> Ah wait! It can work because the nohz_full CPUs have their ticks sometimes scheduled
> by tick_nohz_stop_sched_tick() or tick_nohz_restart_sched_tick() which don't have the
> 10us shift. So a drift happens everytime the nohz_full CPUs have their tick stopped.
>
>> Now, why is the tick ticking at less than 1ms? I think it's the time
>> difference between "now" (that we pass to hrtimer_forward()) and the
>> time the timer hardware is actually programmed. That should account
>> for a few microseconds.
>
> Right, that's my feeling. And if it is the case, then it shouldn't matter.
>
> So! Now we need to find a proper fix :o)
>
> Hmm, how bad would it be to revert to sched_clock() instead of jiffies in vtime_delta()?
> We could use nanosecond granularity to check deltas but only perform an actual cputime update
> when that delta >= TICK_NSEC. That should keep the load ok.

Yeah, I mentioned something similar before.
https://lkml.org/lkml/2017/3/26/138 However, Rik's commit optimized
syscalls by not utilize sched_clock(), so if we should distinguish
between syscalls/exceptions and irqs?

Regards,
Wanpeng Li
