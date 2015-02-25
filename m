From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Wed, 25 Feb 2015 11:35:35 +0100
Message-ID: <20150225103535.GJ5029@twins.programming.kicks-ass.net>
References: <20150224133946.3948c4b7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224133946.3948c4b7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 24, 2015 at 01:39:46PM -0500, Steven Rostedt wrote:
> Index: linux-rt.git/kernel/sched/rt.c
> ===================================================================
> --- linux-rt.git.orig/kernel/sched/rt.c	2015-02-24 10:44:08.798785452 -0500
> +++ linux-rt.git/kernel/sched/rt.c	2015-02-24 13:07:20.154735448 -0500

> @@ -1760,11 +1771,171 @@ static void push_rt_tasks(struct rq *rq)
>  		;
>  }
>  
> +static void tell_cpu_to_push(int cpu, struct rq *rq, int prio)
> +{
> +	/* We should never be here if the IPI is already out. */
> +	BUG_ON(rq->rt.push_csd_pending);
> +
> +	rq->rt.push_csd_pending = 1;
> +	rq->rt.push_csd_cpu = cpu;
> +	/* Save the prio that we used to find this CPU */
> +	rq->rt.push_csd_prio = prio;
> +
> +	/* Make sure csd_cpu is visible before we send the ipi */
> +	smp_mb();

We've architecturally defined the raising of interrupts vs the execution
of the handler to be a serializing event, therefore this full barrier is
not required.

I think we documented it in places, but I never can find it.

> +
> +	smp_call_function_single_async(cpu, &rq->rt.push_csd);

I'm confused why are you mixing smp_call_function_single_async() and
irq_work_queue_on() in the same logic?

Pick one and stick to it.

Also: lkml.kernel.org/r/CA+55aFz492bzLFhdbKN-Hygjcreup7CjMEYk3nTSfRWjppz-OA@mail.gmail.com

Now I would suggest you use irq_wok_queue_on() for this, consistently,
because irq_works are ran after the smp function calls complete and
therefore minimize the latency for people waiting on the (sync) smp
function calls.

> +}
> +
> +static void try_to_push_tasks(void *arg)
> +{
> +	struct rt_rq *rt_rq = arg;
> +	struct rq *rq, *next_rq;
> +	int next_cpu = -1;
> +	int next_prio = MAX_PRIO + 1;
> +	int this_prio;
> +	int src_prio;
> +	int prio;
> +	int this_cpu;
> +	int success;
> +	int cpu;
> +
> +	/* Make sure we can see csd_cpu */
> +	smp_rmb();

As per the above, interrupt are serializing, this is not needed.

> +
> +	this_cpu = rt_rq->push_csd_cpu;
> +
> +	/* Paranoid check */
> +	BUG_ON(this_cpu != smp_processor_id());
> +
> +	rq = cpu_rq(this_cpu);
> +
> +	/*
> +	 * If there's nothing to push here, then see if another queue
> +	 * can push instead.
> +	 */
> +	if (!has_pushable_tasks(rq))
> +		goto pass_the_ipi;
> +
> +	raw_spin_lock(&rq->lock);
> +	success = push_rt_task(rq);
> +	raw_spin_unlock(&rq->lock);
> +
> +	if (success)
> +		goto done;
> +
> +	/* Nothing was pushed, try another queue */
> +pass_the_ipi:
> +
> +	/*
> +	 * We use the priority that determined to send to this CPU
> +	 * even if the priority for this CPU changed. This is used
> +	 * to determine what other CPUs to send to, to keep from
> +	 * doing a ping pong from each CPU.
> +	 */
> +	this_prio = rt_rq->push_csd_prio;
> +	src_prio = rt_rq->highest_prio.curr;

Should we, at this point, not check if the condition that triggered the
pull request is still valid on our src cpu? No point in continuing our
IPI chain if the CPU we're looking for work for is no longer interested
in it.

> +	for_each_cpu(cpu, rq->rd->rto_mask) {
> +		if (this_cpu == cpu)
> +			continue;
> +
> +		/*
> +		 * This function was called because some rq lowered its
> +		 * priority. It then searched for the highest priority
> +		 * rq that had overloaded tasks and sent an smp function
> +		 * call to that cpu to call this function to push its
> +		 * tasks. But when it got here, the task was either
> +		 * already pushed, or due to affinity, could not move
> +		 * the overloaded task.
> +		 *
> +		 * Now we need to see if there's another overloaded rq that
> +		 * has an RT task that can migrate to that CPU.
> +		 *
> +		 * We need to be careful, we do not want to cause a ping
> +		 * pong between this CPU and another CPU that has an RT task
> +		 * that can migrate, but not to the CPU that lowered its
> +		 * priority. Since the lowering priority CPU finds the highest
> +		 * priority rq to send to, we will ignore any rq that is of higher
> +		 * priority than this current one. 

Maybe start a new paragraph here?

		   That is, if a rq scheduled a
> +		 * task of higher priority, the schedule itself would do the
> +		 * push or pull then. We can safely ignore higher priority rqs.
> +		 * And if there's one that is the same priority, since the CPUS
> +		 * are searched in order we will ignore CPUS of the same priority
> +		 * unless the CPU number is greater than this CPU's number.
> +		 */

I would s/CPUS/CPUs/ the plural is not part of the acronym is it?


> +		next_rq = cpu_rq(cpu);
> +
> +		/* Use a single read for the next prio for decision making */
> +		prio = READ_ONCE(next_rq->rt.highest_prio.next);
> +
> +		/* Looking for highest priority */
> +		if (prio >= next_prio)
> +			continue;
> +
> +		/* Make sure that the rq can push to the source rq */
> +		if (prio >= src_prio)
> +			continue;
> +
> +		/* If the prio is higher than the current prio, ignore it */
> +		if (prio < this_prio)
> +			continue;
> +
> +		/*
> +		 * If the prio is equal to the current prio, only use it
> +		 * if the cpu number is greater than the current cpu.
> +		 * This prevents a ping pong effect.
> +		 */
> +		if (prio == this_prio && cpu < this_cpu)
> +			continue;
> +
> +		next_prio = prio;
> +		next_cpu = cpu;
> +	}
> +
> +	/* Nothing found, do nothing */
> +	if (next_cpu < 0)
> +		goto done;
> +
> +	/*
> +	 * Now we can not send another smp async function due to locking,
> +	 * use irq_work instead.
> +	 */
> +
> +	rt_rq->push_csd_cpu = next_cpu;
> +	rt_rq->push_csd_prio = next_prio;
> +
> +	/* Make sure the next cpu is seen on remote CPU */
> +	smp_mb();

Not required,

> +	irq_work_queue_on(&rt_rq->push_csd_work, next_cpu);

And like said before; pick one, stick with it.

> +	return;
> +
> +done:
> +	rt_rq->push_csd_pending = 0;
> +
> +	/* Now make sure the src CPU can see this update */
> +	smp_wmb();


This barrier does not make sense either, for a wmb to make sense you
need two stores:

x := 0, y := 0

	[S] x = 1
	WMB
	[S] y = 1

And one would typically pair that with some loads like:

	[L] r1 = y
	RMB
	[L] r2 = x

Which gives you the guarantee that if r1 is true, l2 must then also be
true.

How in this case, there is no subsequent store.. therefore there is no
order and therefore there is no use of barriers.

> +}
> +
> +static void push_irq_work_func(struct irq_work *work)
> +{
> +	struct rt_rq *rt_rq = container_of(work, struct rt_rq, push_csd_work);
> +
> +	try_to_push_tasks(rt_rq);
> +}
> +
>  static int pull_rt_task(struct rq *this_rq)
>  {
>  	int this_cpu = this_rq->cpu, ret = 0, cpu;
>  	struct task_struct *p;
>  	struct rq *src_rq;
> +	bool push_pending = false;
> +	bool use_ipi;
> +	int next_cpu = -1;
> +	int next_prio = MAX_PRIO + 1;
> +	int src_prio;
>  
>  	if (likely(!rt_overloaded(this_rq)))
>  		return 0;
> @@ -1775,6 +1946,15 @@ static int pull_rt_task(struct rq *this_
>  	 */
>  	smp_rmb();
>  
> +	/* Use local just in case a feature is switched in the middle of this */
> +	if ((use_ipi = sched_feat(RT_PUSH_IPI))) {
> +		/* Make sure the update to pending is visible here. */
> +		smp_rmb();

Another dubious barriers; the sched_feat() 'LOAD' cannot matter,
therefore this barries doesn't add any order over the previous rmb.

And again, you need two loads for an RMB to make sense, and a WMB (or
MB) on the other side with some STORE.

I think this refers to the store of push_csd_pending at the tail of
try_to_push_task(), but as there's no order there, there cannot be any
here either.

> +
> +		/* If a push ipi is out, then we must do the old method */
> +		push_pending = READ_ONCE(this_rq->rt.push_csd_pending);
> +	}

Hmm, this deserves a wee bit more comment I think.

Ideally you'd be able to 'cancel' the active IPI and re-issue it.

> +
>  	for_each_cpu(cpu, this_rq->rd->rto_mask) {
>  		if (this_cpu == cpu)
>  			continue;
> @@ -1793,6 +1973,26 @@ static int pull_rt_task(struct rq *this_
>  			continue;
>  
>  		/*
> +		 * When the RT_PUSH_IPI sched feature is enabled, instead
> +		 * of trying to grab the rq lock of the RT overloaded CPU
> +		 * send an IPI to that CPU instead. This prevents heavy
> +		 * contention from several CPUs lowering its priority
> +		 * and all trying to grab the rq lock of that overloaded CPU.
> +		 */
> +		if (use_ipi && !push_pending) {
> +			/*
> +			 * We need to make sure the prio we use for comparisons
> +			 * is the same throughout.
> +			 */
> +			src_prio = READ_ONCE(src_rq->rt.highest_prio.next);
> +			if (src_prio < next_prio) {
> +				next_prio = src_prio;
> +				next_cpu = cpu;
> +			}
> +			continue;
> +		}
> +
> +		/*
>  		 * We can potentially drop this_rq's lock in
>  		 * double_lock_balance, and another CPU could
>  		 * alter this_rq
> @@ -1839,6 +2039,8 @@ static int pull_rt_task(struct rq *this_
>  skip:
>  		double_unlock_balance(this_rq, src_rq);
>  	}
> +	if (use_ipi && !push_pending && next_cpu >= 0)
> +		tell_cpu_to_push(next_cpu, this_rq, next_prio);
>  
>  	return ret;
>  }

Hohumm,.. so there's still a problem here, and you created it by looking
for the highest prio overloaded cpu.

This means that if multiple CPUs need to go pull, they'll end up sending IPIs
to the same highest overloaded CPU.

It also causes you to do this for_each_cpu(rto_mask) walk in the IPI
again (and again) trying to look for the next highest overloadead CPU.

We should really try and avoid for_each_cpu() loops in interrupts (or
with interrupts disabled for that matter).

So when last we talked about this problem; I suggested two alternatives:

 - pick the next rto cpu after the current and loop around until you're
   past the original cpu again.

 - do that 'randomized' walk over rto and again, terminate when you're
   back where you started.
