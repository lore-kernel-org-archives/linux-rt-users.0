From: Mike Galbraith <bitbucket@online.de>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Wed, 27 Feb 2013 05:19:14 +0100
Message-ID: <1361938754.4599.88.camel@marge.simpson.net>
References: <1361551010.32441.50.camel@marge.simpson.net>
	 <1361907944.11373.57.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60889 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3B0ET0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 23:19:26 -0500
In-Reply-To: <1361907944.11373.57.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-02-26 at 14:45 -0500, Steven Rostedt wrote: 
> On Fri, 2013-02-22 at 17:36 +0100, Mike Galbraith wrote:
>   
> >  128    169392  9712.52 MB/sec  cleanup  10 sec   
> > 
> 
> Wow, that's some result!

That's the interesting bit.  With the delayed preempt stuff applied, on
a small box I got ~30%, but when I tried it on a big box, nada.

> > Throughput 9727.56 MB/sec 128 procs
> > 2150132 packets/sec
> > /root/bin/tbench.sh: line 34: 11568 Killed                  tbench_srv
> > 
> > ---
> >  include/linux/sched.h   |    7 +++++--
> >  kernel/rtmutex.c        |   48 +++++++++++++++++++++++++++++++++++++++++-------
> >  kernel/rtmutex_common.h |   42 +++++++++++++++++++++++++++++++++++++++---
> >  kernel/sched.c          |   31 ++++++++++++++++++++++++++++---
> >  kernel/sched_fair.c     |    5 +++++
> >  kernel/sched_rt.c       |    3 +++
> >  kernel/sysctl.c         |   11 +++++++++++
> >  7 files changed, 132 insertions(+), 15 deletions(-)
> > 
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2083,6 +2083,9 @@ extern unsigned int sysctl_sched_latency
> >  extern unsigned int sysctl_sched_min_granularity;
> >  extern unsigned int sysctl_sched_wakeup_granularity;
> >  extern unsigned int sysctl_sched_child_runs_first;
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +extern unsigned int sysctl_sched_rt_spin_yield;
> > +#endif
> 
> I'm not sure we want this. I think it makes sense to either always do
> it, or never do it.

For SCHED_OTHER, I think it makes sense to let always tasks spin if they
can.  For rt, well, box tells _always_ doing it is a bad idea.  Pinning
and spinning when a CPU is trying to go down doesn't go well, nor does
spinning while exiting, but I found no rt testcase breakage within the
constraints shown in patchlet.

> > @@ -702,8 +702,8 @@ static int adaptive_wait(struct rt_mutex
> >  		 * checking the above to be valid.
> >  		 */
> >  		barrier();
> > -		if (!owner->on_cpu) {
> > -			res = 1;
> > +		if (!owner || !owner->on_cpu) {
> > +			res = !spin;
> >  			break;
> 
> Hmm, if spin is set, this function *always* returns zero. Ug, don't do
> this, a better solution below (where adaptive_wait() is called).

That's a remnant from when I was trying to use adaptive_wait() for rt
tasks, only yielding when it would be a very bad idea to not do so.
That tactic worked fine on a 4 core box no matter how hard I beat on it,
but lasted.. oh, about a microsecond or so on big box when firing up 60
core all isolated, pinned and synchronized jitter test.

> > @@ -761,6 +761,17 @@ static void  noinline __sched rt_spin_lo
> >  	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
> >  	BUG_ON(ret);
> >  
> > +	/* basic spin/yield sanity checks */
> > +	if (rt_spin_yield_enabled()) {
> > +		rt_spin = !self->saved_state;
> > +		/* Here there be dragons */
> > +		rt_spin &= !(self->flags & PF_EXITING);
> > +		other_spin = rt_spin;
> > +		rt_spin &= rt_task(self);
> > +		other_spin &= !rt_spin;
> 
> The multiple assigning is very ugly.
> 
> 	int self_state = !self->saved_state && !(self->flags & PF_EXITING);
> 
> 	rt_spin = self_state && rt_task(self);
> 	other_spin = self_state && !rt_task(self);
> 
> Much easier to read.

I like them compact like this, but yeah, non-compliant kernel style.

> > +	}
> > +	cpu = raw_smp_processor_id();
> > +
> >  	for (;;) {
> >  		/* Try to acquire the lock again. */
> >  		if (__try_to_take_rt_mutex(lock, self, &waiter, STEAL_LATERAL))
> > @@ -769,12 +780,25 @@ static void  noinline __sched rt_spin_lo
> >  		top_waiter = rt_mutex_top_waiter(lock);
> >  		lock_owner = rt_mutex_owner(lock);
> >  
> > +		if (rt_spin)
> > +			wait = 1;
> > +		else
> > +			wait = top_waiter != &waiter;
> > +
> > +		/* SCHED_OTHER can laterally steal, let them try */
> > +		if (other_spin) {
> > +			wait &= task_cpu(top_waiter->task) == cpu;
> > +			wait |= top_waiter->task->prio < self->prio;
> > +			wait |= lock_owner && !lock_owner->on_cpu;
> > +			wait |= lock_owner && !lock_owner->prio < self->prio;
> 
> Again very ugly and hard to read.
> 
> Let's see. If other_spin is set, this also means that rt_spin is not, so
> wait is only set if top_waiter != &waiter (current is not top_waiter).
> OK, if current is top waiter, we don't want to wait. That makes sense.
> 
> Now, if top_waiter->task cpu != current cpu, we don't wait. Ah, even if
> we are not the top waiter, we can still spin if the top_waiter is on
> another CPU. But if top_waiter is higher priority, then we still wait.
> Or if the lock owner is not on a CPU, or if the lock owner is not higher
> priority than current???
> 
> I'm confused to why you did this. This requires a hell of a lot of
> explanation.

That last is a brain-o.

> > +		}
> > +
> >  		raw_spin_unlock(&lock->wait_lock);
> >  
> >  		debug_rt_mutex_print_deadlock(&waiter);
> >  
> > -		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
> > -			schedule_rt_mutex(lock);
> > +		if (wait || adaptive_wait(lock, lock_owner, rt_spin))
> > +			schedule_rt_spinlock(lock, rt_spin);
> 
> I'm also confused, if rt_spin is set, we have wait = 1. wait can only be
> cleared, if other_spin is set, but other_spin can't be set if rt_spin is
> set.

Yeah, passing rt_spin is leftover cruft not in the somewhat cleaner
version I later posted.

> > @@ -826,6 +850,16 @@ static void  noinline __sched rt_spin_lo
> >  		return;
> >  	}
> >  
> > +	if (rt_spin_yield_enabled() && rt_task(current)) {
> > +		struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
> > +		struct task_struct *next = top_waiter->task;
> > +
> > +		/* Move next in line to head of its queue */
> > +		pi_lock(&next->pi_lock);
> > +		task_setprio(next, next->prio, 1);
> > +		pi_unlock(&next->pi_lock);
> 
> You need to explain why this is done.

Because nothing else worked :)  No rt spin+yield variant worked on the
big box, you interleave, you die.  Only after thinking of making it a
global thing that you miss the lock, you yield, acquisition puts you
back at the head of your queue, did big box stop screeching to a halt.

> > @@ -32,9 +32,45 @@ extern void schedule_rt_mutex_test(struc
> >  		schedule_rt_mutex_test(_lock);			\
> >    } while (0)
> >  
> > -#else
> > -# define schedule_rt_mutex(_lock)			schedule()
> > -#endif
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +#define rt_spin_yield_enabled()					\
> > +	(sysctl_sched_rt_spin_yield && system_state == SYSTEM_RUNNING)
> > +
> > +#define schedule_rt_spinlock(_lock, _spin)			\
> > +  do {								\
> > +	if (!(current->flags & PF_MUTEX_TESTER)) {		\
> > +		if (!_spin)					\
> > +			schedule();				\
> > +		else						\
> > +			yield();				\
> > +	} else							\
> > +		schedule_rt_mutex_test(_lock);			\
> 
> I'm wondering if this is the only thing you needed to get your
> performance boost.

I think it's more about SCHED_OTHER and ->migrate_disable, these are the
times when preempting just stacks tasks up, and lets more in to just
stack up.  If we leave these alone and let tasks spin, less sleeping
logjam, so more work gets done.

> > @@ -5346,8 +5354,25 @@ void task_setprio(struct task_struct *p,
> >  
> >  	if (running)
> >  		p->sched_class->set_curr_task(rq);
> > -	if (on_rq)
> > -		enqueue_task(rq, p, oldprio < prio ? ENQUEUE_HEAD : 0);
> > +	if (on_rq) {
> > +		if (!sysctl_sched_rt_spin_yield) {
> > +			enqueue_task(rq, p, oldprio < prio ? ENQUEUE_HEAD : 0);
> > +		} else {
> > +			enqueue_task(rq, p, ENQUEUE_HEAD);
> > +
> > +			/*
> > +			 * If we're requeueing a spinlock waiter, preempt any
> > +			 * peer in the way, waiter involuntarily blocked, so
> > +			 * has the right to use this CPU before its peers.
> > +			 */
> > +			requeue &= p->prio <= rq->curr->prio;
> > +			requeue &= rq->curr->state == TASK_RUNNING;
> > +			requeue &= rq->curr != current;
> > +
> > +			if (requeue)
> > +				resched_task(rq->curr);
> 
> This too is interesting.

Regardless of patchlet, I don't see why we take a boosted task, who was
at the head of its queue when it took the lock, and requeue it to tail
on de-boost when releasing that lock.

> I would be interested in seeing what happens if we just made rt_tasks
> spin instead of sleep (call yield). Actually, if we made real-time tasks
> always spin (never sleep), just yield, if this would give us much better
> performance.

Maybe you can get that working without the requeueing  Without it being
a global head -> tail -> head thing, my big box died and died and.. 

-Mike

