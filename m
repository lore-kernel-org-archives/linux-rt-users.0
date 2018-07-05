From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Date: Thu, 5 Jul 2018 18:38:38 +0200
Message-ID: <20180705163838.7ejxmlpdebuateuy@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705122300.42164577@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joe Korty <joe.korty@concurrent-rt.com>,
        Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705122300.42164577@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-05 12:23:00 [-0400], Steven Rostedt wrote:
> [ Added Peter ]
> 
> On Thu, 5 Jul 2018 17:50:34 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > migrate_disable() does nothing !SMP && !RT. This is bad for two reasons:
> > - The futex code relies on the fact migrate_disable() is part of spin_lock().
> >   There is a workaround for the !in_atomic() case in migrate_disable() which
> >   work-arounds the different ordering (non-atomic lock and atomic unlock).
> 
> But isn't it only part of spin_lock() in the RT case?

that is correct. so in the !RT case if it remains a barrier then nothing
bad happens. So this should not affect futex case at all. Let me retry
this (Joe also says that this patch does not fix it).

> > 
> > - we have a few instances where preempt_disable() is replaced with
> >   migrate_disable().
> 
> What? Really? I thought we only replace preempt_disable() with a
> local_lock(). Which gives annotation to why a preempt_disable() exists.
> And on non-RT, local_lock() is preempt_disable().

KVM-arm-arm64-downgrade-preempt_disable-d-region-to-.patch
printk-rt-aware.patch
upstream-net-rt-remove-preemption-disabling-in-netif_rx.patch

> > For both cases it is bad if migrate_disable() ends up as barrier() instead of
> > preempt_disable(). Let migrate_disable() fallback to preempt_disable().
> > 
> 
> I still don't understand exactly what is "bad" about it.
> 
> IIRC, I remember Peter not wanting any open coded "migrate_disable"
> calls. It was to be for internal use cases only, and specifically, only
> for RT.

the futex code locks in !ATOMIC context and unlocks the same lock in
ATOMIC context which is not balanced on RT. This is the only case where
we do migrate_disable magic.

> Personally, I think making migrate_disable() into preempt_disable() on
> NON_RT is incorrect too.

For the three patches I mentioned above, the migrate_disable() was
preempt_disable() for !RT before the RT patch was applied. So nothing
changes here. It should only matter for the case where migrate_disable()
was used explicit.

> -- Steve

Sebastian
