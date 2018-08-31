Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mga01.intel.com ([192.55.52.88]:36451 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbeHaMfN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Aug 2018 08:35:13 -0400
Date: Fri, 31 Aug 2018 01:18:20 -0700
From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180831081819.GB23052@intel.com>
Reply-To: ramesh.thomas@intel.com
References: <20180827033922.GA28188@intel.com>
 <20180830141856.tjvispfgqrnz727b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830141856.tjvispfgqrnz727b@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

On 2018-08-30 at 16:18:56 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-08-26 20:39:22 [-0700], Ramesh Thomas wrote:
> > Case #2 with CONFIG_PREEMPT_RT_FULL=y (First run after boot)
> > S [cpuhp/3]
> > S [migration/3]
> > S [posixcputmr/3]
> > S [rcuc/3]
> > S [ktimersoftd/3]
> > S [ksoftirqd/3]
> > I [kworker/3:0-mm_]
> > I [kworker/3:0H]
> > R [irq/125-nvme0q4]
> > R [kworker/3:1-mm_]
> > R ./jitter
> 
> irq/125 shouldn't be there, right?
> 
Yes. Also posixcputmr and ktimersoftd are not seen if PREEMPT_RT_FULL is not 
enabled. They don't seem to be running when the timer interrupts occur. But 
they being there by itself indicates something different is happening.
		     Sched    RT_Prio   Cpu_Time
S [posixcputmr/3]      FF      99 	00:00:00
R [ktimersoftd/3]      FF       1 	00:00:00
S [irq/125-nvme0q4]    FF      50 	00:00:00
R ./jitter             FF      99 	00:01:53

> > Case #3 with CONFIG_PREEMPT_RT_FULL=y (Second run after boot)
> > S [cpuhp/3]
> > S [migration/3]
> > S [posixcputmr/3]
> > S [rcuc/3]
> > R [ktimersoftd/3]
> > S [ksoftirqd/3]
> > I [kworker/3:0-mm_]
> > I [kworker/3:0H]
> > S [irq/125-nvme0q4]
> > R [kworker/3:1-mm_]
> > R ./jitter
> > 
> > In Case #3, /proc/interupts show timer interrupts occuring on CPU 3 while it
> > is stopped in the other cases. ktimersoftd is in runnable state in Case #3
> 
> can you trace down who or what is arming the timer on CPU3?
> 

Ok, I will take a look.

> > Is this a known issue and is it being looked at by anyone?
> 
> now that I know of. Do you happen to know if this is a regression
> compared to v4.14-RT?
> 

I see the issue in 4.14.63 RT as well. There are slight differences in 
behavior due to changes that went in 4.17, but the main issue is seen there 
also.

> > If it is an issue, I would be glad to help in any way to get these 2 very
> > important features compatible with each other.
> 
> So if the ktimersoftd runs and you see the interrupt counter
> incrementing for CPU3 then it would be interesting to figure out why
> there is an armed timer on the second invocation (and none on the first
> one).
> 

In 4.18.5 RT, the issue does not always happen in the second invocation.  
Sometimes it works as expected, but the issue will show up after a few 
tries.

Looks like there are 2 issues when PREEMPT_RT_FULL is enabled
1. Some additional processes are pinned to isolated cores.
2. Timer is armed even though only a single high priority task is running.


> > Thanks,
> > Ramesh
> 
> Sebastian
