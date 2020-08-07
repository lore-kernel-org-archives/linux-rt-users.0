Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ACEC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C21620866
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHGOQr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:16:47 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:52489 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGOQr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:16:47 -0400
Received: from [94.37.192.58] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 150296581; Fri, 07 Aug 2020 15:16:43 +0200
Date:   Fri, 7 Aug 2020 15:16:32 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200807151632.36dc6200@nowhere>
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Juri,

thanks for sharing the v2 patchset!

In the next days I'll have a look at it, and try some tests...

In the meanwhile, I have some questions/comments after a first quick
look.

If I understand well, the patchset does not apply deadline servers to
FIFO and RR tasks, right? How does this patchset interact with RT
throttling?

If I understand well, patch 6/6 does something like "use deadline
servers for SCHED_OTHER only if FIFO/RR tasks risk to starve
SCHED_OTHER tasks"... Right? I understand this is because you do not
want to delay RT tasks if they are not starving other tasks. But then,
maybe what you want is not deadline-based scheduling. Maybe a
reservation-based scheduler based on fixed priorities is what you want?
(with SCHED_DEADLINE, you could provide exact performance guarantees to
SCHED_OTHER tasks, but I suspect patch 6/6 breaks these guarantees?)


			Thanks,
				Luca

On Fri,  7 Aug 2020 11:50:45 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi,
> 
> This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].
> 
> SCHED_DEADLINE servers can help fixing starvation issues of low
> priority tasks (e.g., SCHED_OTHER) when higher priority tasks
> monopolize CPU cycles. Today we have RT Throttling; DEADLINE servers
> should be able to replace and improve that.
> 
> I rebased Peter's patches (adding changelogs where needed) on
> tip/sched/core as of today and incorporated fixes to issues discussed
> during RFC v1. Current set seems to even boot on real HW! :-)
> 
> While playing with RFC v1 set (and discussing it further offline with
> Daniel) it has emerged the need to slightly change the behavior. Patch
> 6/6 is a (cumbersome?) attempt to show what's probably needed.
> The problem with "original" implementation is that FIFO tasks might
> suffer preemption from NORMAL even when spare CPU cycles are
> available. In fact, fair deadline server is enqueued right away when
> NORMAL tasks wake up and they are first scheduled by the server, thus
> potentially preempting a well behaving FIFO task. This is of course
> not ideal. So, in patch 6/6 I propose to use some kind of starvation
> monitor/ watchdog that delays enqueuing of deadline servers to the
> point when fair tasks might start to actually suffer from starvation
> (just randomly picked HZ/2 for now). One problem I already see with
> the current implementation is that it adds overhead to fair paths, so
> I'm pretty sure there are better ways to implement the idea (e.g.,
> Daniel already suggested using a starvation monitor kthread sort of
> thing).
> 
> Receiving comments and suggestions is the sole purpose of this posting
> at this stage. Hopefully we can further discuss the idea at Plumbers
> in a few weeks. So, please don't focus too much into actual
> implementation (which I plan to revise anyway after I'm back from pto
> :), but try to see if this might actually fly. The feature seems to
> be very much needed.
> 
> Thanks!
> 
> Juri
> 
> 1 -
> https://lore.kernel.org/lkml/20190726145409.947503076@infradead.org/
> 
> Juri Lelli (1):
>   sched/fair: Implement starvation monitor
> 
> Peter Zijlstra (5):
>   sched: Unify runtime accounting across classes
>   sched/deadline: Collect sched_dl_entity initialization
>   sched/deadline: Move bandwidth accounting into
> {en,de}queue_dl_entity sched/deadline: Introduce deadline servers
>   sched/fair: Add trivial fair server
> 
>  include/linux/sched.h    |  28 ++-
>  kernel/sched/core.c      |  23 +-
>  kernel/sched/deadline.c  | 483
> ++++++++++++++++++++++++--------------- kernel/sched/fair.c      |
> 136 ++++++++++- kernel/sched/rt.c        |  17 +-
>  kernel/sched/sched.h     |  50 +++-
>  kernel/sched/stop_task.c |  16 +-
>  7 files changed, 522 insertions(+), 231 deletions(-)
> 

