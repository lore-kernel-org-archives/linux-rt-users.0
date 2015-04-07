From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 07 Apr 2015 12:49:16 +0200
Message-ID: <1428403756.3152.56.camel@gmail.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-2-git-send-email-tmac@hp.com>
	 <20150406215959.4e8ad37b@grimm.local.home>
	 <1428383383.3152.5.camel@gmail.com>
	 <20150407102912.GK23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150407102912.GK23123@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-04-07 at 12:29 +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2015 at 07:09:43AM +0200, Mike Galbraith wrote:
> > On Mon, 2015-04-06 at 21:59 -0400, Steven Rostedt wrote:
> > > 
> > > We really should have a rt_spin_trylock_in_irq() and not have the
> > > below if conditional.
> > > 
> > > The paths that will be executed in hard irq context are static. 
> > > They
> > > should be labeled as such.
> > 
> > +/*
> > + * Special purpose for locks taken in interrupt context: Take and 
> > hold
> > + * ->wait_lock lest PI catching us with our fingers in the cookie 
> > jar.
> > + * Do NOT abuse.
> > + */
> > +int __lockfunc rt_spin_trylock_in_irq(spinlock_t *lock)
> > +{
> > +       struct task_struct *owner;
> > +       if (!raw_spin_trylock(&lock->lock.wait_lock))
> > +               return 0;
> > +       owner = idle_task(raw_smp_processor_id());
> > +       if (!(rt_mutex_cmpxchg(&lock->lock, NULL, owner))) {
> > +               raw_spin_unlock(&lock->lock.wait_lock);
> > +               return 0;
> > +       }
> > +       spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> > +       return 1;
> > +}
> > +
> > +/* ONLY for use with rt_spin_trylock_in_irq(), do NOT abuse. */
> > +void __lockfunc rt_spin_trylock_in_irq_unlock(spinlock_t *lock)
> > +{
> > +       struct task_struct *owner = 
> > idle_task(raw_smp_processor_id());
> > +       /* NOTE: we always pass in '1' for nested, for simplicity 
> > */
> > +       spin_release(&lock->dep_map, 1, _RET_IP_);
> > +       BUG_ON(!(rt_mutex_cmpxchg(&lock->lock, owner, NULL)));
> > +       raw_spin_unlock(&lock->lock.wait_lock);
> > +}
> > +
> 
> Can someone explain this braindamage? You should _NOT_ take mutexes 
> in
> hardirq context.

No.. really? ;-)

If you have a spot where it'd be nice to do that despite it being 
somewhat (koff).. discouraged shall we say, you have to do something 
funky.  Thomas had a patch to not raise sirq unconditionally for -rt 
to let nohz_full work, but it needs a lock that's converted to an 
rtmutex in -rt, and which doesn't want to be un-converted.  Ergo, get 
funky.

> And if its an irq thread, then the irq thread _IS_ the right owner, 
> the
> thread needs to be boosted by waiters.

No irq thread.

> The idle thread cannot ever be owner of a mutex, that's complete and
> utter bullshit.

Not if you want to hide current from the deadlock detector lest it get 
upset and make box go boom.

        -Mike
