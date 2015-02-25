From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Wed, 25 Feb 2015 10:51:16 -0500
Message-ID: <20150225105116.7fa03cc9@gandalf.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
	<20150225103535.GJ5029@twins.programming.kicks-ass.net>
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
In-Reply-To: <20150225103535.GJ5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 25 Feb 2015 11:35:35 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 24, 2015 at 01:39:46PM -0500, Steven Rostedt wrote:
> > Index: linux-rt.git/kernel/sched/rt.c
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/rt.c	2015-02-24 10:44:08.798785452 -0500
> > +++ linux-rt.git/kernel/sched/rt.c	2015-02-24 13:07:20.154735448 -0500
> 
> > @@ -1760,11 +1771,171 @@ static void push_rt_tasks(struct rq *rq)
> >  		;
> >  }
> >  
> > +static void tell_cpu_to_push(int cpu, struct rq *rq, int prio)
> > +{
> > +	/* We should never be here if the IPI is already out. */
> > +	BUG_ON(rq->rt.push_csd_pending);
> > +
> > +	rq->rt.push_csd_pending = 1;
> > +	rq->rt.push_csd_cpu = cpu;
> > +	/* Save the prio that we used to find this CPU */
> > +	rq->rt.push_csd_prio = prio;
> > +
> > +	/* Make sure csd_cpu is visible before we send the ipi */
> > +	smp_mb();
> 
> We've architecturally defined the raising of interrupts vs the execution
> of the handler to be a serializing event, therefore this full barrier is
> not required.
> 
> I think we documented it in places, but I never can find it.
> 
> > +
> > +	smp_call_function_single_async(cpu, &rq->rt.push_csd);
> 
> I'm confused why are you mixing smp_call_function_single_async() and
> irq_work_queue_on() in the same logic?

I originally started with smp_call_function_single_async(), but found
that it takes csd locks and holds them while the functions are
executed. Meaning, you can not call another
smp_call_function_single_async() from within a previous call. I left
the code that starts the IPI as the smp_call_function but changed the
internal calls to use irq_queue_work_on(). I guess I can switch all to
just use that if you want only one, as the
smp_call_function_single_async() is not even an option.

> 
> Pick one and stick to it.
> 
> Also: lkml.kernel.org/r/CA+55aFz492bzLFhdbKN-Hygjcreup7CjMEYk3nTSfRWjppz-OA@mail.gmail.com

Ah that would have helped. I talked about doing this too in the past.
I think I mentioned it to you on IRC.

But I believe this still requires the user making sure the original
call is synchronized, which breaks making a change for you below. I'll
discuss that further down.

> 
> Now I would suggest you use irq_wok_queue_on() for this, consistently,
> because irq_works are ran after the smp function calls complete and
> therefore minimize the latency for people waiting on the (sync) smp
> function calls.

Well, we still want the pull to happen as fast as possible. But sure,
I get your point.

> 
> > +}
> > +
> > +static void try_to_push_tasks(void *arg)
> > +{
> > +	struct rt_rq *rt_rq = arg;
> > +	struct rq *rq, *next_rq;
> > +	int next_cpu = -1;
> > +	int next_prio = MAX_PRIO + 1;
> > +	int this_prio;
> > +	int src_prio;
> > +	int prio;
> > +	int this_cpu;
> > +	int success;
> > +	int cpu;
> > +
> > +	/* Make sure we can see csd_cpu */
> > +	smp_rmb();
> 
> As per the above, interrupt are serializing, this is not needed.

Because entering an interrupt is a serializing point with other CPUs?

> 
> > +
> > +	this_cpu = rt_rq->push_csd_cpu;
> > +
> > +	/* Paranoid check */
> > +	BUG_ON(this_cpu != smp_processor_id());
> > +
> > +	rq = cpu_rq(this_cpu);
> > +
> > +	/*
> > +	 * If there's nothing to push here, then see if another queue
> > +	 * can push instead.
> > +	 */
> > +	if (!has_pushable_tasks(rq))
> > +		goto pass_the_ipi;
> > +
> > +	raw_spin_lock(&rq->lock);
> > +	success = push_rt_task(rq);
> > +	raw_spin_unlock(&rq->lock);
> > +
> > +	if (success)
> > +		goto done;
> > +
> > +	/* Nothing was pushed, try another queue */
> > +pass_the_ipi:
> > +
> > +	/*
> > +	 * We use the priority that determined to send to this CPU
> > +	 * even if the priority for this CPU changed. This is used
> > +	 * to determine what other CPUs to send to, to keep from
> > +	 * doing a ping pong from each CPU.
> > +	 */
> > +	this_prio = rt_rq->push_csd_prio;
> > +	src_prio = rt_rq->highest_prio.curr;
> 
> Should we, at this point, not check if the condition that triggered the
> pull request is still valid on our src cpu? No point in continuing our
> IPI chain if the CPU we're looking for work for is no longer interested
> in it.

But how do we know that?

I added logic here to do exactly that, but then realized I need to keep
track of too much information. The pull happens when the rq schedules a
task of lower priority. That new task can still be an RT task. To know
we do not need to do the pull, we need to keep track of what the
original priority was.

Hmm, but that said, we can add an optimization here and do this:

	if (src_prio <= this_prio)
		goto done;

As "this_prio" is what we saw that we could pull. Thus, if the rq that
is asking to do the pull schedules a task that is equal or higher in
priority than the highest rq it sent a pull request for, then we do not
need to continue this IPI.

I'll add that.


> 
> > +	for_each_cpu(cpu, rq->rd->rto_mask) {
> > +		if (this_cpu == cpu)
> > +			continue;
> > +
> > +		/*
> > +		 * This function was called because some rq lowered its
> > +		 * priority. It then searched for the highest priority
> > +		 * rq that had overloaded tasks and sent an smp function
> > +		 * call to that cpu to call this function to push its
> > +		 * tasks. But when it got here, the task was either
> > +		 * already pushed, or due to affinity, could not move
> > +		 * the overloaded task.
> > +		 *
> > +		 * Now we need to see if there's another overloaded rq that
> > +		 * has an RT task that can migrate to that CPU.
> > +		 *
> > +		 * We need to be careful, we do not want to cause a ping
> > +		 * pong between this CPU and another CPU that has an RT task
> > +		 * that can migrate, but not to the CPU that lowered its
> > +		 * priority. Since the lowering priority CPU finds the highest
> > +		 * priority rq to send to, we will ignore any rq that is of higher
> > +		 * priority than this current one. 
> 
> Maybe start a new paragraph here?

OK.

> 
> 		   That is, if a rq scheduled a
> > +		 * task of higher priority, the schedule itself would do the
> > +		 * push or pull then. We can safely ignore higher priority rqs.
> > +		 * And if there's one that is the same priority, since the CPUS
> > +		 * are searched in order we will ignore CPUS of the same priority
> > +		 * unless the CPU number is greater than this CPU's number.
> > +		 */
> 
> I would s/CPUS/CPUs/ the plural is not part of the acronym is it?

Heh, I usually do, but then I noticed that I did it consistently (I was
probably tired, and I use capslock to write acronyms), that I just
left it.

> 
> 
> > +		next_rq = cpu_rq(cpu);
> > +
> > +		/* Use a single read for the next prio for decision making */
> > +		prio = READ_ONCE(next_rq->rt.highest_prio.next);
> > +
> > +		/* Looking for highest priority */
> > +		if (prio >= next_prio)
> > +			continue;
> > +
> > +		/* Make sure that the rq can push to the source rq */
> > +		if (prio >= src_prio)
> > +			continue;
> > +
> > +		/* If the prio is higher than the current prio, ignore it */
> > +		if (prio < this_prio)
> > +			continue;
> > +
> > +		/*
> > +		 * If the prio is equal to the current prio, only use it
> > +		 * if the cpu number is greater than the current cpu.
> > +		 * This prevents a ping pong effect.
> > +		 */
> > +		if (prio == this_prio && cpu < this_cpu)
> > +			continue;
> > +
> > +		next_prio = prio;
> > +		next_cpu = cpu;
> > +	}
> > +
> > +	/* Nothing found, do nothing */
> > +	if (next_cpu < 0)
> > +		goto done;
> > +
> > +	/*
> > +	 * Now we can not send another smp async function due to locking,
> > +	 * use irq_work instead.
> > +	 */
> > +
> > +	rt_rq->push_csd_cpu = next_cpu;
> > +	rt_rq->push_csd_prio = next_prio;
> > +
> > +	/* Make sure the next cpu is seen on remote CPU */
> > +	smp_mb();
> 
> Not required,

Because irq_work_queue_on() is a full barrier, right?

> 
> > +	irq_work_queue_on(&rt_rq->push_csd_work, next_cpu);
> 
> And like said before; pick one, stick with it.

Yep, it will have to be irq_work_queue_on(), as the other is not
possible to use this way (yet).

> 
> > +	return;
> > +
> > +done:
> > +	rt_rq->push_csd_pending = 0;
> > +
> > +	/* Now make sure the src CPU can see this update */
> > +	smp_wmb();
> 
> 
> This barrier does not make sense either, for a wmb to make sense you
> need two stores:
> 
> x := 0, y := 0
> 
> 	[S] x = 1
> 	WMB
> 	[S] y = 1
> 
> And one would typically pair that with some loads like:
> 
> 	[L] r1 = y
> 	RMB
> 	[L] r2 = x
> 
> Which gives you the guarantee that if r1 is true, l2 must then also be
> true.
> 
> How in this case, there is no subsequent store.. therefore there is no
> order and therefore there is no use of barriers.

Actually, this is a speed up, but if exiting a irq handler is also a
full barrier, then it is not needed. Here's what I have:

	rmb();
	if (!pending)
		send ipi;


The above is to make sure we see the pending bit before making the
decision. It would suck if it was already cleared, but because we never
flushed the cache, that it always sees it as pending.

I still like that rmb() there, as there's nothing that guarantees that
we have that flushed coming in. Hmm, perhaps the rq lock taken when
entering into the schedule could be considered a serialization point.

> 
> > +}
> > +
> > +static void push_irq_work_func(struct irq_work *work)
> > +{
> > +	struct rt_rq *rt_rq = container_of(work, struct rt_rq, push_csd_work);
> > +
> > +	try_to_push_tasks(rt_rq);
> > +}
> > +
> >  static int pull_rt_task(struct rq *this_rq)
> >  {
> >  	int this_cpu = this_rq->cpu, ret = 0, cpu;
> >  	struct task_struct *p;
> >  	struct rq *src_rq;
> > +	bool push_pending = false;
> > +	bool use_ipi;
> > +	int next_cpu = -1;
> > +	int next_prio = MAX_PRIO + 1;
> > +	int src_prio;
> >  
> >  	if (likely(!rt_overloaded(this_rq)))
> >  		return 0;
> > @@ -1775,6 +1946,15 @@ static int pull_rt_task(struct rq *this_
> >  	 */
> >  	smp_rmb();
> >  
> > +	/* Use local just in case a feature is switched in the middle of this */
> > +	if ((use_ipi = sched_feat(RT_PUSH_IPI))) {
> > +		/* Make sure the update to pending is visible here. */
> > +		smp_rmb();
> 
> Another dubious barriers; the sched_feat() 'LOAD' cannot matter,
> therefore this barries doesn't add any order over the previous rmb.

I added it before noticing that there was an rmb() above :-)

> 
> And again, you need two loads for an RMB to make sense, and a WMB (or
> MB) on the other side with some STORE.
> 
> I think this refers to the store of push_csd_pending at the tail of
> try_to_push_task(), but as there's no order there, there cannot be any
> here either.

Right, but it's more of making sure that the state of the system is
correct at that point than a correctness thing.

> 
> > +
> > +		/* If a push ipi is out, then we must do the old method */
> > +		push_pending = READ_ONCE(this_rq->rt.push_csd_pending);
> > +	}
> 
> Hmm, this deserves a wee bit more comment I think.
> 
> Ideally you'd be able to 'cancel' the active IPI and re-issue it.

Right, but 'canceling' is really racy. The thing is, there's no locks
out there to serialize this. And due to the nature of this code, we
don't want any locks either.

Since I was using smp_call_function I also could not start one until
the previous one was finished, as it uses the same data structures to
do the send.

Even if I switch this to irq_work, I still have no good way to
cancel it without introducing a race. How do I cancel it and know that
it is canceled before starting a new ipi? I'm not sure I can use the
same irq_work struct for two calls of queue_work_on().

I tried several ways but always found a new mole to whack. I decided to
punt and just fall back to the old "safe" way if this case happens. It
seldom does even on stress tests.

If you can think of a safe way to do this, please enlighten me :-)


> 
> > +
> >  	for_each_cpu(cpu, this_rq->rd->rto_mask) {
> >  		if (this_cpu == cpu)
> >  			continue;
> > @@ -1793,6 +1973,26 @@ static int pull_rt_task(struct rq *this_
> >  			continue;
> >  
> >  		/*
> > +		 * When the RT_PUSH_IPI sched feature is enabled, instead
> > +		 * of trying to grab the rq lock of the RT overloaded CPU
> > +		 * send an IPI to that CPU instead. This prevents heavy
> > +		 * contention from several CPUs lowering its priority
> > +		 * and all trying to grab the rq lock of that overloaded CPU.
> > +		 */
> > +		if (use_ipi && !push_pending) {
> > +			/*
> > +			 * We need to make sure the prio we use for comparisons
> > +			 * is the same throughout.
> > +			 */
> > +			src_prio = READ_ONCE(src_rq->rt.highest_prio.next);
> > +			if (src_prio < next_prio) {
> > +				next_prio = src_prio;
> > +				next_cpu = cpu;
> > +			}
> > +			continue;
> > +		}
> > +
> > +		/*
> >  		 * We can potentially drop this_rq's lock in
> >  		 * double_lock_balance, and another CPU could
> >  		 * alter this_rq
> > @@ -1839,6 +2039,8 @@ static int pull_rt_task(struct rq *this_
> >  skip:
> >  		double_unlock_balance(this_rq, src_rq);
> >  	}
> > +	if (use_ipi && !push_pending && next_cpu >= 0)
> > +		tell_cpu_to_push(next_cpu, this_rq, next_prio);
> >  
> >  	return ret;
> >  }
> 
> Hohumm,.. so there's still a problem here, and you created it by looking
> for the highest prio overloaded cpu.
> 
> This means that if multiple CPUs need to go pull, they'll end up sending IPIs
> to the same highest overloaded CPU.

Sure, and if you like, I'll post timings of the cost of this.

I can add tests to try to trigger the worse case scenario, and we can
see what this actually is. So far, it is much better than the current
everyone grabbing that lock, as that blocks everything, and has a
really nasty cascading effect.

> 
> It also causes you to do this for_each_cpu(rto_mask) walk in the IPI
> again (and again) trying to look for the next highest overloadead CPU.

Of course this requires all CPUs to have more than one RT task queued
on it.

> 
> We should really try and avoid for_each_cpu() loops in interrupts (or
> with interrupts disabled for that matter).
> 
> So when last we talked about this problem; I suggested two alternatives:
> 
>  - pick the next rto cpu after the current and loop around until you're
>    past the original cpu again.

OK, I realized that my patch did change something. It sends to the
highest prio CPU first, and stops when it gets a task. This is
different than what the original code does (and IMO better), where the
original code pulls all tasks that it can pull, thus adding a bunch of
RT tasks on this queue. At least this keeps the number of RT overloaded
bits in the rto_mask down.

But, I can keep this nastiness and still do the same. Instead of
stopping after a push, keep sending the IPI around and let all RT
overloaded CPUs try to push their tasks.


> 
>  - do that 'randomized' walk over rto and again, terminate when you're
>    back where you started.


Not sure what you mean by a randomized walk?


I wonder if we can add another cpufind that deals with not the highest
running RT task on a CPU, but the next highest RT task. Where it
returns quickly the CPU with the next highest RT task to run.

-- Steve
