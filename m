From: Rik van Riel <riel@redhat.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Mon, 27 Mar 2017 13:35:29 -0400
Message-ID: <1490636129.8850.76.camel@redhat.com>
References: <20170323165512.60945ac6@redhat.com>
         <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdC0RhM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
In-Reply-To: <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2017-03-27 at 09:56 +0800, Wanpeng Li wrote:
> 
> Actually after I bisect, the first bad commit is ff9a9b4c4334
> ("sched,
> time: Switch VIRT_CPU_ACCOUNTING_GEN to jiffy granularity"). The bug
> can be reproduced readily if CONFIG_CONTEXT_TRACKING_FORCE is true

At the time, we thought it was an "occasionally bad" / "unlucky"
kind of bug, not a systemic issue, like your observations seem
to suggest.

> Let's consider the cpu which has responsibility for the global
> timekeeping, as the tracing posted above, the vtime_account_user() is
> called before tick_sched_timer() which will update jiffies, so
> jiffies
> is stale in vtime_account_user() and the run time in userspace is
> skipped, the vtime_user_enter() is called after jiffies update, so
> both the time in userspace and in  kernel are accumulated to sys
> time.
> If the housekeeping cpu is idle when CONFIG_NO_HZ_FULL, everything is
> fine. However, if you give stress to the housekeeping cpu, top will
> show 100% sys-time of both the housekeeping cpu and the other cpus
> who
> have at least two tasks running on and in full_nohz mode. I think it
> is because the stress delays the timer interrupt handling in some
> degree, then the jiffies is not updated timely before other cpus
> access it in vtime_account_user().
> 
> I think we can keep syscalls/exceptions context tracking still in
> jiffies based sampling and utilize local_clock() in vtime_delta()
> again for irqs which avoids jiffies stale influence. I can make a
> patch if the idea is acceptable or there is any better proposal. :)

Making that patch seems worthwhile, but I would like to
know what the root cause is of the issue that is being
observed.

Is the problem due to the nohz_full CPU receiving an
interrupt at the same time the timer interrupt fires on
the housekeeping CPU?

Is it due to a nohz_full CPU updating jiffies all by
itself from irq context?  In that case, could it be
better to always have that be done by the housekeeping
CPU?

What exactly is going on here?
