From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Date: Thu, 5 Jul 2018 18:59:37 +0200
Message-ID: <20180705165937.5orx3md3krg4akaz@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
To: Joe Korty <joe.korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705161807.GA5800@zipoli.concurrent-rt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-05 12:18:07 [-0400], joe.korty@concurrent-rt.com wrote:
> Hi Sebastian,
Hi Joe,

> I just verified that this fix does not work for my mix of
> config options (smp && preempt && !rt).

Okay. So for !RT+SMP we keep migrate_disable() around and it almost
nothing. And it is not referenced anywhere so it does not matter as long
as it not used directly.

We could turn migrate_disable() into a nop/barrier but then we have
three uses which do preempt_disable() -> migrate_disable() (see other
thread).
For the futex code it should not matter much because at this point
preemption is disabled due to the spin_lock() (so we would just extend
it past the spin_unlock() or wake_futex_pi() which ends with
preempt_enable()).


> Regards,
> Joe

Sebastian
