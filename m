From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] sched/migrate_disable: fallback to
 preempt_disable() instead barrier()
Date: Wed, 11 Jul 2018 17:39:52 +0200
Message-ID: <20180711153952.2fcniletg62hy7xf@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
 <20180705165937.5orx3md3krg4akaz@linutronix.de>
 <20180706105857.5tgi5irdxdryet64@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
To: Joe Korty <joe.korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706105857.5tgi5irdxdryet64@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-06 12:58:57 [+0200], To Joe Korty wrote:
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
> v1…v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
>        if migrate_disable() is used.

If there are no objections I would pick this up for next v4.16.

Sebastian
