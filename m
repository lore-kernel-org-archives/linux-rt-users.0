From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v4] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Fri, 27 Feb 2015 09:29:43 -0500
Message-ID: <20150227092943.00cbe7ea@gandalf.local.home>
References: <20150226112635.69b5870f@gandalf.local.home>
	<20150227090830.GF21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150227090830.GF21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 27 Feb 2015 10:08:30 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Feb 26, 2015 at 11:26:35AM -0500, Steven Rostedt wrote:
> > Index: linux-rt.git/kernel/sched/rt.c
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/rt.c	2015-02-26 10:55:26.107945935 -0500
> > +++ linux-rt.git/kernel/sched/rt.c	2015-02-26 10:55:38.277777892 -0500
> 
> > +/* Called from hardirq context */
> > +static void try_to_push_tasks(void *arg)
> > +{
> > +	struct rt_rq *rt_rq = arg;
> > +	struct rq *rq, *src_rq;
> > +	int this_cpu;
> > +	int cpu;
> > +
> > +	this_cpu = rt_rq->push_cpu;
> > +
> > +	/* Paranoid check */
> > +	BUG_ON(this_cpu != smp_processor_id());
> > +
> > +	rq = cpu_rq(this_cpu);
> > +	src_rq = rq_of_rt_rq(rt_rq);
> > +
> > + again:
> 
> Superfluous space there!

I like to give homes to superfluous spaces.

> 
> > +	if (has_pushable_tasks(rq)) {
> > +		raw_spin_lock(&rq->lock);
> > +		push_rt_task(rq);
> > +		raw_spin_unlock(&rq->lock);
> > +	}
> 
> So push_rt_task() has a return value; should we use it?
> 
> That is, currently we iterate the entire rto mask and migrate everything
> we come across, is there an argument to be had to only migrate 1 task
> and then call it quits?

No we can't do that. We want the highest priority task that isn't
running to be able to run. We can't stop when we migrate one, because
that may be the lowest priority task waiting. There may still be a
higher priority task on another rq that can run on the newly opened CPU.

In fact, I was thinking that we do use the return value, but in a
different way:

	raw_spin_lock(&rq->lock);
	while (push_rt_task(rq))
		;
	raw_spin_unlock(&rq->lock);

and unload all waiting tasks on this rq if possible.

Hmm, maybe not. The IPI gets sent out because a single rq has just
lowered its priority, and is looking for the highest priority task to
migrate to it. The first one to succeed to migrate would be the
highest prio task on this rq. It makes sense to then check other run
queues on other CPUs.

> 
> > Index: linux-rt.git/kernel/sched/sched.h
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/sched.h	2015-02-26 10:55:26.107945935 -0500
> > +++ linux-rt.git/kernel/sched/sched.h	2015-02-26 10:55:28.082918664 -0500
> > @@ -6,6 +6,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/stop_machine.h>
> > +#include <linux/irq_work.h>
> >  #include <linux/tick.h>
> >  #include <linux/slab.h>
> >  
> > @@ -435,6 +436,11 @@ struct rt_rq {
> >  	unsigned long rt_nr_total;
> >  	int overloaded;
> >  	struct plist_head pushable_tasks;
> > +	struct call_single_data push_csd;
> 
> You waaztin' maa spaaz!

This space didn't want to go homeless. But I need to kick him out
regardless.

> 
> > +	int push_flags;
> > +	int push_cpu;
> > +	struct irq_work push_work;
> > +	raw_spinlock_t push_lock;
> >  #endif
> >  	int rt_queued;
> >  
> 
> One could make an argument for using a separate per-cpu variable and
> cacheline align the thing...

We could. Think it's worth it, or should I just keep this for now?

> 
> > Index: linux-rt.git/kernel/sched/features.h
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/features.h	2015-02-26 10:55:26.107945935 -0500
> > +++ linux-rt.git/kernel/sched/features.h	2015-02-26 10:55:28.083918650 -0500
> > @@ -56,6 +56,17 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
> >   */
> >  SCHED_FEAT(TTWU_QUEUE, true)
> >  
> > +/*
> > + * In order to avoid a thundering herd attack of CPUS that are
> 
> I would suggest you remap your caps-lock to some useful key :-)

I have short stubby fingers. I can't hit the shift key and another key
at the same time very well. CAPS LOCK is my friend (I use it much more
than Ctrl, and I'm an emacs user!)

-- Steve

> 
> > + * lowering their priorities at the same time, and there being
> > + * a single CPU that has an RT task that can migrate and is waiting
> > + * to run, where the other CPUs will try to take that CPUs
> > + * rq lock and possibly create a large contention, sending an
> > + * IPI to that CPU and let that CPU push the RT task to where
> > + * it should go may be a better scenario.
> > + */
> > +SCHED_FEAT(RT_PUSH_IPI, true)
> > +
> >  SCHED_FEAT(FORCE_SD_OVERLAP, false)
> >  SCHED_FEAT(RT_RUNTIME_SHARE, true)
> >  SCHED_FEAT(LB_MIN, false)
