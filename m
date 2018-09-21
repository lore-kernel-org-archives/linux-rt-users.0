Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mga17.intel.com ([192.55.52.151]:26317 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeIUGGS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Sep 2018 02:06:18 -0400
Message-ID: <5BA43906.2070800@intel.com>
Date: Thu, 20 Sep 2018 17:19:18 -0700
From: "Bowles, Matthew K" <Matthew.K.Bowles@intel.com>
MIME-Version: 1.0
Subject: Re: yielding while running SCHED_DEADLINE
In-Reply-To: <20180917114219.GE24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

I’m fine with not fixing this behavior since Vedang has mentioned, we 
can use different mechanisms to achieve the same goal.  However, I would 
like to go on the record as someone that cares about this functionality. 
  Assuming that sched_yield was counted as part of nr_voluntary 
switches, then the specific scenario in which I would find this 
statistic useful is during debug of latency spikes on a realtime thread. 
  In particular, I could quickly correlate whether or not a latency 
spike occurred due to being swapped out by the scheduler.

On Mon, 2018-09-17 at 13:42 +0200, Peter Zijlstra wrote:
 > On Mon, Sep 17, 2018 at 11:26:48AM +0200, Juri Lelli wrote:
 > >
 > > Hi,
 > >
 > > On 14/09/18 23:13, Patel, Vedang wrote:
 > > >
 > > > Hi all,
 > > >
 > > > We have been playing around with SCHED_DEADLINE and found some
 > > > discrepancy around the calculation of nr_involuntary_switches and
 > > > nr_voluntary_switches in /proc/${PID}/sched.
 > > >
 > > > Whenever the task is done with it's work earlier and executes
 > > > sched_yield() to voluntarily gives up the CPU this increments
 > > > nr_involuntary_switches. It should have incremented
 > > > nr_voluntary_switches.
 > > Mmm, I see what you are saying.
 > >
 > > [...]
 > >
 > > >
 > > > Looking at __schedule() in kernel/sched/core.c, the switch is
 > > > counted
 > > > as part of nr_involuntary_switches if the task has not been
 > > > preempted
 > > > and the task is TASK_RUNNING state. This does not seem to happen
 > > > when
 > > > sched_yield() is called.
 > > Mmm,
 > >
 > >  - nr_voluntary_switches++ if !preempt && !RUNNING
 > >  - nr_involuntary_switches++ otherwise (yield fits this as the task
 > > is
 > >    still RUNNING, even though throttled for DEADLINE)
 > >
 > > Not sure this is the same as what you say above..
 > >
 > > >
 > > > Is there something we are missing over here? OR Is this a known
 > > > issue
 > > > and is planned to be fixed later?
 > > .. however, not sure. Peter, what you say. It looks like we might
 > > indeed
 > > want to account yield as a voluntary switch, seems to fit. In this
 > > case
 > > I guess we could use a flag or add a sched_ bit to task_struct to
 > > handle
 > > the case?
 > It's been like this _forever_ afaict. This isn't deadline specific
 > afaict, all yield callers will end up in non-voluntary switches.
 >
 > I don't know anybody that cares and I don't think this is something
 > worth fixing. If someone did rely on this behaviour we'd break them,
 > and
 > i'd much rather save a cycle than add more stupid stats crap to the
 > scheduler.
Thanks Peter and Juri for the response.

We will try to use a different mechanism to account for this.

-Vedang
