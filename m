From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Quick review of -rt RCU-related patches
Date: Tue, 4 Oct 2011 16:15:04 -0700
Message-ID: <20111004231504.GG2223@linux.vnet.ibm.com>
References: <20111004174755.GA4762@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1110042322450.18778@ionos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110042322450.18778@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 05, 2011 at 12:05:47AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Tue, 4 Oct 2011, Paul E. McKenney wrote:
> > rcu-reduce-lock-section.patch
> > 
> > 	Prevents a wakeup within an irq-disabled raw spinlock.
> > 	But which wakeup?
> 
> The call comes from:
> 
>     synchronize_rcu_expedited()
> 	raw_spin_lock_irqsave(&rsp->onofflock, flags);
>         sync_rcu_preempt_exp_init()
> 	   rcu_report_exp_rnp()
>     
> 
> > 	o	rcu_report_exp_rnp() is only permitted to do a wakeup
> > 		if called with rrupts enabled.
> 
> That's not what the code does, obviously.
> 
> > 	o	All calls enable wakeups -except- for the call from
> > 		sync_rcu_preempt_exp_init(), but in that case, there
> > 		is nothing to wake up -- it is in fact running doing
> > 		the initialization.
> 
> Right, though the problem is that rcu_report_exp_rnp() unconditionally
> calls wake_up() which takes the wait_queue lock (a "sleeping spinlock"
> on RT). So the patch merily prevents the call when called from
> synchronize_rcu_expedited() ...

OK, got it.

> > signal-fix-up-rcu-wreckage.patch
> > 
> > 	Makes __lock_task_sighand() do local_irq_save_nort() instead
> > 	of local_irq_save().  The RCU implementation should be OK with
> > 	this.  The signal implementation might or might not.
> 
> It does :)
> 
> > sched-might-sleep-do-not-account-rcu-depth.patch
> > 
> > 	Yow!!!  For CONFIG_PREEMPT_RT_FULL, this redefines
> > 	sched_rcu_preempt_depth() to always return zero.
> > 
> > 	This means that might_sleep() will never complain about
> > 	blocking in an RCU read-side critical section.  I guess that
> > 	this is necessary, though it would be better to have some
> > 	way to complain for general sleeping (e.g., waiting on
> > 	network receive) as opposed to blocking on a lock that is
> > 	subject to priority inheritance.
> 
> Well, there's always a remaining problem. We need that stuff fully
> preemptible on rt. Any ideas ?

Not yet.  We would have to classify context switches into two groups:

1.	Preemptions or blocking waiting for sleeping spinlocks.

2.	Everything else.

Given that classification, it would be straightforward: prohibit
group #2 context switches while in RCU-preempt read-side critical
sections.  I know, easy for me to say!  ;-)

> > rcu-force-preempt-rcu-for-rt.patch
> > 
> > 	This one should be obsoleted by commit 8008e129dc9, which is
> > 	queued in -tip, hopefully for 3.2.
> 
> Ok.
> 
> > 	Except for the RT_GROUP_SCHED change, which is unrelated.
> 
> Huch, that should be in a different patch

I was wondering about that.

> > rcu-disable-the-rcu-bh-stuff-for-rt.patch
> > 
> > 	This implements RCU-bh in terms of RCU-preempt, but disables
> > 	BH around the resulting RCU-preempt read-side critical section.
> > 	May be vulnerable to network-based denial-of-service attacks,
> > 	which could OOM a system with this patch.
> > 
> > 	The implementation of rcu_read_lock_bh_held() is weak, but OK.	In
> > 	an ideal world, it would also complain if not local_bh_disable().
> 
> Well, I dropped that after our IRC conversation, but we still need to
> have some extra debugging for RT to diagnose situations where we break
> those rcu_bh assumptions. That _bh rcu stuff should have never been
> there, we'd rather should drop the softirq processing back to
> ksoftirqd in such an overload case (in mainline) and voluntary
> schedule away from ksoftirqd until the situation is resolved.
> 
> I consider rcu_bh a bandaid for the nasty implict semantics of BH
> processing and I'm looking really forward to Peters analysis of the
> modern cpu local BKL constructs at RTLWS.
> 
> The patch stemmed from an earlier discussion about getting rid of
> those special rcu_bh semantics even in mainline for the sake of not
> making a special case for a completely over(ab)used construct which
> originates from the historically grown softirq behaviour. I think that
> keeping the special cased rcu_bh stuff around is just taking any
> incentive away from moving that whole softirq processing into a
> scheduler controllable environment (i.e. threaded interrupts). 

Between -rt and the guys pushing packets, I can tell that this is going
to be a fun one.  ;-)

I will see if I can come up with a way to make that patch safe to
apply.  Might not be all that hard.

> > _paul_e__mckenney_-eliminate_-_rcu_boosted.patch
> > 
> > 	Looks fine, but I might not be the best reviewer for this one.
> 
> :)
> 
> > peter_zijlstra-frob-rcu.patch
> > 
> > 	Looks OK.  Hmmm...  Should this one go to mainline?
> > 	Oh, looks equivalent, actually.  So why the change?
> 
> Peter ?
> 
> > Possible fixes from the 3.2-bound RCU commits in -tip:
> > 
> > 7eb4f455 (Make rcu_implicit_dynticks_qs() locals be correct size)
> > 
> > 	Symptoms: misbehavior on 32-bit systems after a given CPU went
> > 		through about 2^30 dyntick-idle transitions.  You would
> > 		have to work pretty hard to get this one to happen.
> 
> Definitley and most of our test systems run with nohz=off
> 
> > 5c51dd73 (Prevent early boot set_need_resched() from __rcu_pending())
> > 
> > 	Symptoms: boot-time hangs for rare configurations.
> 
> Never seen that one
> 
> > 037067a1 (Prohibit grace periods during early boot)
> > 
> > 	Symptoms: boot-time hangs for rare configurations.
> 
> Ditto
> 
> > 06ae115a (Avoid having just-onlined CPU resched itself when RCU is idle)
> > 
> > 	Symptoms: boot-time hangs for rare configurations.
> 
> Ditto
> 
> > 5b61b0ba (Wire up RCU_BOOST_PRIO for rcutree)
> > 
> > 	Symptoms: The system uses RT priority 1 for boosting regardless
> > 		of the value of CONFIG_RCU_BOOST_PRIO.
> 
> Makes sense
> 
> > e90c53d3 (Remove rcu_needs_cpu_flush() to avoid false quiescent states)
> > 
> > 	Symptoms: Too-short grace periods for RCU_FAST_NO_HZ=y.
> > 		But simpler to set RCU_FAST_NO_HZ=n.
> 
> We probably don't have that on

I hope not.  ;-)

> > And the following is a patch to a theoretical problem with expedited
> > grace periods.
> > 
> > ------------------------------------------------------------------------
> > 
> > rcu: Avoid RCU-preempt expedited grace-period botch
> 
> Were you able to actually trigger that?

Nope, by inspection only.  Which is a good thing, as this would likely
be very hard to reproduce and even harder to debug.

							Thanx, Paul

> Thanks,
> 
> 	tglx
> 
