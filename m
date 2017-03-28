From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Tue, 28 Mar 2017 15:19:25 +0800
Message-ID: <CANRm+CwHnHp96zZj3bH8CC3-QcE_FwL_1icUm1W_-crzd2=4=g@mail.gmail.com>
References: <20170323165512.60945ac6@redhat.com> <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
 <1490636129.8850.76.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490636129.8850.76.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

2017-03-28 1:35 GMT+08:00 Rik van Riel <riel@redhat.com>:
> On Mon, 2017-03-27 at 09:56 +0800, Wanpeng Li wrote:
>>
>> Actually after I bisect, the first bad commit is ff9a9b4c4334
>> ("sched,
>> time: Switch VIRT_CPU_ACCOUNTING_GEN to jiffy granularity"). The bug
>> can be reproduced readily if CONFIG_CONTEXT_TRACKING_FORCE is true
>
> At the time, we thought it was an "occasionally bad" / "unlucky"
> kind of bug, not a systemic issue, like your observations seem
> to suggest.
>
>> Let's consider the cpu which has responsibility for the global
>> timekeeping, as the tracing posted above, the vtime_account_user() is
>> called before tick_sched_timer() which will update jiffies, so
>> jiffies
>> is stale in vtime_account_user() and the run time in userspace is
>> skipped, the vtime_user_enter() is called after jiffies update, so
>> both the time in userspace and in  kernel are accumulated to sys
>> time.
>> If the housekeeping cpu is idle when CONFIG_NO_HZ_FULL, everything is
>> fine. However, if you give stress to the housekeeping cpu, top will
>> show 100% sys-time of both the housekeeping cpu and the other cpus
>> who
>> have at least two tasks running on and in full_nohz mode. I think it
>> is because the stress delays the timer interrupt handling in some
>> degree, then the jiffies is not updated timely before other cpus
>> access it in vtime_account_user().
>>
>> I think we can keep syscalls/exceptions context tracking still in
>> jiffies based sampling and utilize local_clock() in vtime_delta()
>> again for irqs which avoids jiffies stale influence. I can make a
>> patch if the idea is acceptable or there is any better proposal. :)
>
> Making that patch seems worthwhile, but I would like to
> know what the root cause is of the issue that is being
> observed.
>
> Is the problem due to the nohz_full CPU receiving an
> interrupt at the same time the timer interrupt fires on
> the housekeeping CPU?
>
> Is it due to a nohz_full CPU updating jiffies all by
> itself from irq context?  In that case, could it be
> better to always have that be done by the housekeeping
> CPU?

I observed that the jiffies is always updated by housekeeping CPU as
we expected.

Regards,
Wanpeng Li
