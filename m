From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Tue, 28 Mar 2017 09:44:53 -0400
Message-ID: <20170328094453.331ead3c@redhat.com>
References: <20170323165512.60945ac6@redhat.com>
        <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
        <20170327143830.2fbcef90@redhat.com>
        <CANRm+CwYkyzVe1yO0aWP5j5vxmFmSxH9nLd7yvfdUJRLS9G=vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+CwYkyzVe1yO0aWP5j5vxmFmSxH9nLd7yvfdUJRLS9G=vA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 28 Mar 2017 13:28:13 +0800
Wanpeng Li <kernellwp@gmail.com> wrote:

> 2017-03-28 2:38 GMT+08:00 Luiz Capitulino <lcapitulino@redhat.com>:
> > On Mon, 27 Mar 2017 09:56:47 +0800
> > Wanpeng Li <kernellwp@gmail.com> wrote:
> >  
> >> Actually after I bisect, the first bad commit is ff9a9b4c4334 ("sched,
> >> time: Switch VIRT_CPU_ACCOUNTING_GEN to jiffy granularity"). The bug
> >> can be reproduced readily if CONFIG_CONTEXT_TRACKING_FORCE is true,
> >> then just stress all the online cpus or just one cpu and leave others
> >> idle(so it stresses the global timekeeping one), top show 100%
> >> sys-time. And another way to reproduce it is by nohz_full, and gives
> >> the stress to the house keeping cpu, the top show 100% sys-time of the
> >> house keeping cpu, and also the other cpus who have at least two tasks
> >> running on and in full_nohz mode.  
> >
> > We're not short on reproducers, I have a new one too:
> >
> >  http://people.redhat.com/~lcapitul/real-time/acct-bug.c
> >
> > This is a single threaded task that reproduces the issue. If you
> > run it as instructed, you'll get:
> >
> >  - nohz_full CPU: 95% system time 5% idle time
> >  - non-nohz_full CPU: 95% user time 5% idle time (expected behavior)
> >
> > This reproduces the issue, but not for the reasons I expected. I was
> > trying to mimic what I was seeing on my trace when tracing the two
> > task problem. Which is: a task stays 995us in user-space and then
> > enters the kernel. Time won't be accounted for user-space because
> > we're not 1 jiffies yet, but if the task stays in the kernel for more
> > than 5us, then time will be accounted for system time when going
> > back to user-space.
> >
> > However, what really seems to be happening is: acct-bug is causing
> > the tick to be re-activated (why? it shouldn't) and that causes the
> > issue to appear. This is consistent with my other observations: I
> > can only reproduce the issue if the nohz_full CPU re-activates the tick.  
> 
> I see there are other kthreads like migration, kworker,
> torture_shuffle etc on the isolated CPU.

Except for torture_shuffle (which is new to me, and I guess could
be disabled in .config) the other threads should not be runnable
for most of the time.

> 
> Regards,
> Wanpeng Li
> 
> >  
> >> Let's consider the cpu which has responsibility for the global
> >> timekeeping, as the tracing posted above, the vtime_account_user() is
> >> called before tick_sched_timer() which will update jiffies,  
> >
> > But the vtime_account_user() call and the jiffies update happen
> > on different CPUs, no? So the ordering shouldn't matter.
> >  
> >> so jiffies
> >> is stale in vtime_account_user() and the run time in userspace is
> >> skipped, the vtime_user_enter() is called after jiffies update, so
> >> both the time in userspace and in  kernel are accumulated to sys time.
> >>
> >> If the housekeeping cpu is idle when CONFIG_NO_HZ_FULL, everything is
> >> fine. However, if you give stress to the housekeeping cpu, top will
> >> show 100% sys-time of both the housekeeping cpu and the other cpus who
> >> have at least two tasks running on and in full_nohz mode.  
> >
> > The housekeeping CPUs are idle with my reproducers.
> >  
> >> I think it
> >> is because the stress delays the timer interrupt handling in some
> >> degree, then the jiffies is not updated timely before other cpus
> >> access it in vtime_account_user().
> >>
> >> I think we can keep syscalls/exceptions context tracking still in
> >> jiffies based sampling and utilize local_clock() in vtime_delta()
> >> again for irqs which avoids jiffies stale influence. I can make a
> >> patch if the idea is acceptable or there is any better proposal. :)
> >>
> >> Regards,
> >> Wanpeng Li
> >>  
> >  
> 
