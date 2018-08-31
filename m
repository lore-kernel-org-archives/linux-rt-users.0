Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:52982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeHaUkL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Aug 2018 16:40:11 -0400
Date: Fri, 31 Aug 2018 18:31:52 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180831163152.vrrntdy7xsej2kwv@linutronix.de>
References: <20180827033922.GA28188@intel.com>
 <20180830141856.tjvispfgqrnz727b@linutronix.de>
 <20180831081819.GB23052@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831081819.GB23052@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

On 2018-08-31 01:18:20 [-0700], Ramesh Thomas wrote:
> Yes. Also posixcputmr and ktimersoftd are not seen if PREEMPT_RT_FULL is not 
> enabled. They don't seem to be running when the timer interrupts occur. But 
> they being there by itself indicates something different is happening.

both threads are created on RT and should be idle unless used.

> I see the issue in 4.14.63 RT as well. There are slight differences in 
> behavior due to changes that went in 4.17, but the main issue is seen there 
> also.

okay, so it is not a regression. Thanks for confirming.

> > > If it is an issue, I would be glad to help in any way to get these 2 very
> > > important features compatible with each other.
> > 
> > So if the ktimersoftd runs and you see the interrupt counter
> > incrementing for CPU3 then it would be interesting to figure out why
> > there is an armed timer on the second invocation (and none on the first
> > one).
> > 
> 
> In 4.18.5 RT, the issue does not always happen in the second invocation.  
> Sometimes it works as expected, but the issue will show up after a few 
> tries.
> 
> Looks like there are 2 issues when PREEMPT_RT_FULL is enabled
> 1. Some additional processes are pinned to isolated cores.

as explained, above that is expected.

> 2. Timer is armed even though only a single high priority task is running.

something must have armed that timer. The clock_nanosleep() API won't
use those new threads but for instance timer_create() / timer_settime()
will.

> > > Thanks,
> > > Ramesh

Sebastian
