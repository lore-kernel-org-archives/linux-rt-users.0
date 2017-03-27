From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Mon, 27 Mar 2017 09:56:47 +0800
Message-ID: <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
References: <20170323165512.60945ac6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323165512.60945ac6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

2017-03-24 4:55 GMT+08:00 Luiz Capitulino <lcapitulino@redhat.com>:
>
> When there are two or more tasks executing in user-space and
> taking 100% of a nohz_full CPU, top reports 70% system time
> and 30% user time utilization. Sometimes I'm even able to get
> 100% system time and 0% user time.
>
> This was reproduced with latest Linus tree (093b995), but I
> don't believe it's a regression (at least not a recent one)
> as I can reproduce it with older kernels. Also, I have
> CONFIG_IRQ_TIME_ACCOUNTING=y and haven't tried to reproduce
> without it yet.
>
> Below you'll find the steps to reproduce and some initial
> analysis.
>
> Steps to reproduce
> ------------------
>
> 1. Set up a CPU for nohz_full with isolcpus= nohz_full=
>
> 2. Pin two tasks that hog the CPU 100% of the time to that CPU
>
> 3. Run top -d1 and check system time
>
> NOTE: When there's only one task hogging a nohz_full CPU, top
>       shows 100% user-time, as expected
>
> Initial analysis
> ----------------
>
> When tracing vtime accounting functions and the user-space/kernel
> transitions when the issue is taking place, I see several of the
> following:
>
> hog-10552 [015]  1132.711104: function:             enter_from_user_mode <-- apic_timer_interrupt
> hog-10552 [015]  1132.711105: function:             __context_tracking_exit <-- enter_from_user_mode
> hog-10552 [015]  1132.711105: bprint:               __context_tracking_exit.part.4: new state=1 cur state=1 active=1
> hog-10552 [015]  1132.711105: function:             vtime_account_user <-- __context_tracking_exit.part.4
> hog-10552 [015]  1132.711105: function:             smp_apic_timer_interrupt <-- apic_timer_interrupt
> hog-10552 [015]  1132.711106: function:             irq_enter <-- smp_apic_timer_interrupt
> hog-10552 [015]  1132.711106: function:             tick_sched_timer <-- __hrtimer_run_queues
> hog-10552 [015]  1132.711108: function:             irq_exit <-- smp_apic_timer_interrupt
> hog-10552 [015]  1132.711108: function:             __context_tracking_enter <-- prepare_exit_to_usermode
> hog-10552 [015]  1132.711108: bprint:               __context_tracking_enter.part.2: new state=1 cur state=0 active=1
> hog-10552 [015]  1132.711109: function:             vtime_user_enter <-- __context_tracking_enter.part.2
> hog-10552 [015]  1132.711109: function:             __vtime_account_system <-- vtime_user_enter
> hog-10552 [015]  1132.711109: function:             account_system_time <-- __vtime_account_system
>
> On entering the kernel due to a timer interrupt, vtime_account_user()
> skips user-time accounting. Then later on when returning to user-space,
> vtime_user_enter() is probably accounting the whole time (ie. user-space
> plus kernel-space) to system time.

Actually after I bisect, the first bad commit is ff9a9b4c4334 ("sched,
time: Switch VIRT_CPU_ACCOUNTING_GEN to jiffy granularity"). The bug
can be reproduced readily if CONFIG_CONTEXT_TRACKING_FORCE is true,
then just stress all the online cpus or just one cpu and leave others
idle(so it stresses the global timekeeping one), top show 100%
sys-time. And another way to reproduce it is by nohz_full, and gives
the stress to the house keeping cpu, the top show 100% sys-time of the
house keeping cpu, and also the other cpus who have at least two tasks
running on and in full_nohz mode.

Let's consider the cpu which has responsibility for the global
timekeeping, as the tracing posted above, the vtime_account_user() is
called before tick_sched_timer() which will update jiffies, so jiffies
is stale in vtime_account_user() and the run time in userspace is
skipped, the vtime_user_enter() is called after jiffies update, so
both the time in userspace and in  kernel are accumulated to sys time.
If the housekeeping cpu is idle when CONFIG_NO_HZ_FULL, everything is
fine. However, if you give stress to the housekeeping cpu, top will
show 100% sys-time of both the housekeeping cpu and the other cpus who
have at least two tasks running on and in full_nohz mode. I think it
is because the stress delays the timer interrupt handling in some
degree, then the jiffies is not updated timely before other cpus
access it in vtime_account_user().

I think we can keep syscalls/exceptions context tracking still in
jiffies based sampling and utilize local_clock() in vtime_delta()
again for irqs which avoids jiffies stale influence. I can make a
patch if the idea is acceptable or there is any better proposal. :)

Regards,
Wanpeng Li
