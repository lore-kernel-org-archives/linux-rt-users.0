From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 12:29:12 +0200
Message-ID: <20150407102912.GK23123@twins.programming.kicks-ass.net>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
 <1428369962-74723-2-git-send-email-tmac@hp.com>
 <20150406215959.4e8ad37b@grimm.local.home>
 <1428383383.3152.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428383383.3152.5.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Apr 07, 2015 at 07:09:43AM +0200, Mike Galbraith wrote:
> On Mon, 2015-04-06 at 21:59 -0400, Steven Rostedt wrote:
> > 
> > We really should have a rt_spin_trylock_in_irq() and not have the
> > below if conditional.
> > 
> > The paths that will be executed in hard irq context are static. They
> > should be labeled as such.
> 
> +/*
> + * Special purpose for locks taken in interrupt context: Take and hold
> + * ->wait_lock lest PI catching us with our fingers in the cookie jar.
> + * Do NOT abuse.
> + */
> +int __lockfunc rt_spin_trylock_in_irq(spinlock_t *lock)
> +{
> +       struct task_struct *owner;
> +       if (!raw_spin_trylock(&lock->lock.wait_lock))
> +               return 0;
> +       owner = idle_task(raw_smp_processor_id());
> +       if (!(rt_mutex_cmpxchg(&lock->lock, NULL, owner))) {
> +               raw_spin_unlock(&lock->lock.wait_lock);
> +               return 0;
> +       }
> +       spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> +       return 1;
> +}
> +
> +/* ONLY for use with rt_spin_trylock_in_irq(), do NOT abuse. */
> +void __lockfunc rt_spin_trylock_in_irq_unlock(spinlock_t *lock)
> +{
> +       struct task_struct *owner = idle_task(raw_smp_processor_id());
> +       /* NOTE: we always pass in '1' for nested, for simplicity */
> +       spin_release(&lock->dep_map, 1, _RET_IP_);
> +       BUG_ON(!(rt_mutex_cmpxchg(&lock->lock, owner, NULL)));
> +       raw_spin_unlock(&lock->lock.wait_lock);
> +}
> +

Can someone explain this braindamage? You should _NOT_ take mutexes in
hardirq context.

And if its an irq thread, then the irq thread _IS_ the right owner, the
thread needs to be boosted by waiters.

The idle thread cannot ever be owner of a mutex, that's complete and
utter bullshit.
