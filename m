From: lkml@pengaru.com
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Sun, 26 Mar 2017 22:33:55 -0700
Message-ID: <20170327053355.GP802@shells.gnugeneration.com>
References: <20170323165512.60945ac6@redhat.com>
 <1490316962.8850.59.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Luiz Capitulino <lcapitulino@redhat.com>, fweisbec@gmail.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shells.gnugeneration.com ([66.240.222.126]:52302 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbdC0FdD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Mar 2017 01:33:03 -0400
Content-Disposition: inline
In-Reply-To: <1490316962.8850.59.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 23, 2017 at 08:56:02PM -0400, Rik van Riel wrote:
> On Thu, 2017-03-23 at 16:55 -0400, Luiz Capitulino wrote:
> > When there are two or more tasks executing in user-space and
> > taking 100% of a nohz_full CPU, top reports 70% system time
> > and 30% user time utilization. Sometimes I'm even able to get
> > 100% system time and 0% user time.
> > 
> > This was reproduced with latest Linus tree (093b995), but I
> > don't believe it's a regression (at least not a recent one)
> > as I can reproduce it with older kernels. Also, I have
> > CONFIG_IRQ_TIME_ACCOUNTING=y and haven't tried to reproduce
> > without it yet.
> > 
> > Below you'll find the steps to reproduce and some initial
> > analysis.
> > 
> > Steps to reproduce
> > ------------------
> > 
> > 1. Set up a CPU for nohz_full with isolcpus= nohz_full=
> > 
> > 2. Pin two tasks that hog the CPU 100% of the time to that CPU
> > 
> > 3. Run top -d1 and check system time
> > 
> > NOTE: When there's only one task hogging a nohz_full CPU, top
> >       shows 100% user-time, as expected
> > 
> > Initial analysis
> > ----------------
> > 
> > When tracing vtime accounting functions and the user-space/kernel
> > transitions when the issue is taking place, I see several of the
> > following:
> > 
> > hog-10552 [015]  1132.711104:
> > function:             enter_from_user_mode <-- apic_timer_interrupt
> > hog-10552 [015]  1132.711105:
> > function:             __context_tracking_exit <--
> > enter_from_user_mode
> > hog-10552 [015]  1132.711105:
> > bprint:               __context_tracking_exit.part.4: new state=1 cur
> > state=1 active=1
> > hog-10552 [015]  1132.711105:
> > function:             vtime_account_user <--
> > __context_tracking_exit.part.4
> > hog-10552 [015]  1132.711105:
> > function:             smp_apic_timer_interrupt <--
> > apic_timer_interrupt
> > hog-10552 [015]  1132.711106: function:             irq_enter <--
> > smp_apic_timer_interrupt
> > hog-10552 [015]  1132.711106: function:             tick_sched_timer
> > <-- __hrtimer_run_queues
> > hog-10552 [015]  1132.711108: function:             irq_exit <--
> > smp_apic_timer_interrupt
> > hog-10552 [015]  1132.711108:
> > function:             __context_tracking_enter <--
> > prepare_exit_to_usermode
> > hog-10552 [015]  1132.711108:
> > bprint:               __context_tracking_enter.part.2: new state=1
> > cur state=0 active=1
> > hog-10552 [015]  1132.711109: function:             vtime_user_enter
> > <-- __context_tracking_enter.part.2
> > hog-10552 [015]  1132.711109:
> > function:             __vtime_account_system <-- vtime_user_enter
> > hog-10552 [015]  1132.711109:
> > function:             account_system_time <-- __vtime_account_system
> > 
> > On entering the kernel due to a timer interrupt, vtime_account_user()
> > skips user-time accounting. Then later on when returning to user-
> > space,
> > vtime_user_enter() is probably accounting the whole time (ie. user-
> > space
> > plus kernel-space) to system time.
> > 
> > Now, when does vtime_account_user() skips accounting? Well, when the
> > time delta is less then one jiffie. This would imply that
> > vtime_account_user()
> > is being called less than one jiffie since the last accounting, but I
> > haven't
> > confirmed any of this yet.
> 
> Jiffies should be advanced by the timer interrupt, on the
> housekeeping CPU, which is not doing context tracking.
> 
> Why is the isolated/nohz_full CPU receiving timer interrupts
> at all?
> 
> I thought it would not, but obviously I am wrong. What is
> going on here?

This thread sounds awful familiar to me.

With CONFIG_NO_HZ_FULL=y && CONFIG_VIRT_CPU_ACCOUNTING_GEN=y I observed process
accounting anomalies with user CPU time being misaccounted as system time all
the way back to 4.6.0.

After switching to CONFIG_NO_HZ_IDLE=y && CONFIG_VIRT_CPU_ACCOUNTING_GEN=n the
issues went away.

The lkml thread I had seen at that time which compelled me to suspect these
settings was this:
http://lkml.iu.edu/hypermail/linux/kernel/1608.2/05860.html

It sounds like this issue is finally beginning to be understood though, good
work!

Regards,
Vito Caputo
