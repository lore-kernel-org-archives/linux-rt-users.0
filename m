Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50318 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbeH3SVW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Aug 2018 14:21:22 -0400
Date: Thu, 30 Aug 2018 16:18:56 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180830141856.tjvispfgqrnz727b@linutronix.de>
References: <20180827033922.GA28188@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827033922.GA28188@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

On 2018-08-26 20:39:22 [-0700], Ramesh Thomas wrote:
> Case #2 with CONFIG_PREEMPT_RT_FULL=y (First run after boot)
> S [cpuhp/3]
> S [migration/3]
> S [posixcputmr/3]
> S [rcuc/3]
> S [ktimersoftd/3]
> S [ksoftirqd/3]
> I [kworker/3:0-mm_]
> I [kworker/3:0H]
> R [irq/125-nvme0q4]
> R [kworker/3:1-mm_]
> R ./jitter

irq/125 shouldn't be there, right?

> Case #3 with CONFIG_PREEMPT_RT_FULL=y (Second run after boot)
> S [cpuhp/3]
> S [migration/3]
> S [posixcputmr/3]
> S [rcuc/3]
> R [ktimersoftd/3]
> S [ksoftirqd/3]
> I [kworker/3:0-mm_]
> I [kworker/3:0H]
> S [irq/125-nvme0q4]
> R [kworker/3:1-mm_]
> R ./jitter
> 
> In Case #3, /proc/interupts show timer interrupts occuring on CPU 3 while it
> is stopped in the other cases. ktimersoftd is in runnable state in Case #3

can you trace down who or what is arming the timer on CPU3?

> Is this a known issue and is it being looked at by anyone?

now that I know of. Do you happen to know if this is a regression
compared to v4.14-RT?

> If it is an issue, I would be glad to help in any way to get these 2 very
> important features compatible with each other.

So if the ktimersoftd runs and you see the interrupt counter
incrementing for CPU3 then it would be interesting to figure out why
there is an armed timer on the second invocation (and none on the first
one).

> Thanks,
> Ramesh

Sebastian
