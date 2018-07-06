From: joe.korty@concurrent-rt.com
Subject: Re: [PATCH RT v2] sched/migrate_disable: fallback to
 preempt_disable() instead barrier()
Date: Fri, 6 Jul 2018 15:05:02 -0400
Message-ID: <20180706190502.GA26154@zipoli.concurrent-rt.com>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
 <20180705165937.5orx3md3krg4akaz@linutronix.de>
 <20180706105857.5tgi5irdxdryet64@linutronix.de>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Cartwright <julia@ni.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706105857.5tgi5irdxdryet64@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jul 06, 2018 at 12:58:57PM +0200, Sebastian Andrzej Siewior wrote:
> On SMP + !RT migrate_disable() is still around. It is not part of spin_lock()
> anymore so it has almost no users. However the futex code has a workaround for
> the !in_atomic() part of migrate disable which fails because the matching
> migrade_disable() is no longer part of spin_lock().
> 
> On !SMP + !RT migrate_disable() is reduced to barrier(). This is not optimal
> because we few spots where a "preempt_disable()" statement was replaced with
> "migrate_disable()".
> 
> We also used the migration_disable counter to figure out if a sleeping lock is
> acquired so RCU does not complain about schedule() during rcu_read_lock() while
> a sleeping lock is held. This changed, we no longer use it, we have now a
> sleeping_lock counter for the RCU purpose.
> 
> This means we can now:
> - for SMP + RT_BASE
>   full migration program, nothing changes here
> 
> - for !SMP + RT_BASE
>   the migration counting is no longer required. It used to ensure that the task
>   is not migrated to another CPU and that this CPU remains online. !SMP ensures
>   that already.
>   Move it to CONFIG_SCHED_DEBUG so the counting is done for debugging purpose
>   only.
> 
> - for all other cases including !RT
>   fallback to preempt_disable(). The only remaining users of migrate_disable()
>   are those which were converted from preempt_disable() and the futex
>   workaround which is already in the preempt_disable() section due to the
>   spin_lock that is held.
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1???v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
>        if migrate_disable() is used.
> 
>  include/linux/preempt.h |    6 +++---
>  include/linux/sched.h   |    4 ++--
>  kernel/sched/core.c     |   23 +++++++++++------------
>  kernel/sched/debug.c    |    2 +-
>  4 files changed, 17 insertions(+), 18 deletions(-)


Hi Sebastian,
v2 works for me.

I compiled and booted both smp+preempt+!rt and
smp+preempt+rt kernels, no splats on boot for either.

I ran the futex selftests on both kernels, both passed.

I ran a selection of posix tests from an old version of
the Linux Test Project, both kernels passed all tests.

Regards, and thanks,
Joe
