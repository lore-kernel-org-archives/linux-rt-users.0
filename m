From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Wed, 25 Feb 2015 12:50:15 -0500
Message-ID: <20150225125015.6c5110ca@gandalf.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
	<20150225103535.GJ5029@twins.programming.kicks-ass.net>
	<20150225105116.7fa03cc9@gandalf.local.home>
	<20150225171110.GO21418@twins.programming.kicks-ass.net>
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
In-Reply-To: <20150225171110.GO21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 25 Feb 2015 18:11:10 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

>
> > Actually, this is a speed up, but if exiting a irq handler is also a
> > full barrier, then it is not needed. 
> 
> Barrieres are _NEVER_ about speedups, they're either required or not.

"speed up" was a wrong word. "correct state" is what I should have said.

I meant "speed up" the getting of the "correct state" :-)

> 
> > Here's what I have:
> > 
> > 	rmb();
> > 	if (!pending)
> > 		send ipi;
> > 
> > 
> > The above is to make sure we see the pending bit before making the
> > decision. It would suck if it was already cleared, but because we never
> > flushed the cache, that it always sees it as pending.
> 
> barriers are not about flushing store buffers (although some
> implementations might do so we cannot rely on that in general).
> 
> The above rmb is entirely without function; as stated you need at least
> two loads for an rmb to make sense.

It can't be used for state?

If one CPU writes "zero", and the other CPU wants to decide if the
system is in the state to do something, isn't a rmb() fine to use?


CPU 1:

	x = 0;
	/* Tell other CPUs they can now do something */
	smp_wmb();

CPU 2:
	/* Make sure we see current state of x */
	smp_rmb();
	if (x == 0)
		do_something();

The above situation is not acceptable?

Otherwise, we fail to be able to do_something() when it is perfectly
fine to do so.


> 
> > > > @@ -1775,6 +1946,15 @@ static int pull_rt_task(struct rq *this_
> > > >  	 */
> > > >  	smp_rmb();
> > > >  
> > > > +	/* Use local just in case a feature is switched in the middle of this */
> > > > +	if ((use_ipi = sched_feat(RT_PUSH_IPI))) {
> > > > +		/* Make sure the update to pending is visible here. */
> > > > +		smp_rmb();
> > > 
> > > Another dubious barriers; the sched_feat() 'LOAD' cannot matter,
> > > therefore this barries doesn't add any order over the previous rmb.
> > 
> > I added it before noticing that there was an rmb() above :-)
> > 
> > > 
> > > And again, you need two loads for an RMB to make sense, and a WMB (or
> > > MB) on the other side with some STORE.
> > > 
> > > I think this refers to the store of push_csd_pending at the tail of
> > > try_to_push_task(), but as there's no order there, there cannot be any
> > > here either.
> > 
> > Right, but it's more of making sure that the state of the system is
> > correct at that point than a correctness thing.
> 
> -ENOPARSE, there appear to be two different definitions of correct going
> about in the above sentence.
> 
> Outside of arch code (and rarely there) should we use barriers for
> anything other than ordering guarantees. And there is no 'order' in a
> single variable.

Can they not be used for passing of state as mentioned above?

> 
> > > > +
> > > > +		/* If a push ipi is out, then we must do the old method */
> > > > +		push_pending = READ_ONCE(this_rq->rt.push_csd_pending);
> > > > +	}
> > > 
> > > Hmm, this deserves a wee bit more comment I think.
> > > 
> > > Ideally you'd be able to 'cancel' the active IPI and re-issue it.
> > 
> > Right, but 'canceling' is really racy. The thing is, there's no locks
> > out there to serialize this. And due to the nature of this code, we
> > don't want any locks either.
> > 
> > Since I was using smp_call_function I also could not start one until
> > the previous one was finished, as it uses the same data structures to
> > do the send.
> > 
> > Even if I switch this to irq_work, I still have no good way to
> > cancel it without introducing a race. How do I cancel it and know that
> > it is canceled before starting a new ipi? I'm not sure I can use the
> > same irq_work struct for two calls of queue_work_on().
> > 
> > I tried several ways but always found a new mole to whack. I decided to
> > punt and just fall back to the old "safe" way if this case happens. It
> > seldom does even on stress tests.
> > 
> > If you can think of a safe way to do this, please enlighten me :-)
> 
> You could put a lock around your IPI state; that is:
> 
> #define IPS_BUSY	0x01
> #define IPS_LOOPED	0x02
> 
> struct ipi_pull_struct {
> 	struct irq_work work;
> 	raw_spinlock_t	lock;
> 	int flags;
> 	int dst_cpu;	/* CPU that issued this search */
> 	int dst_prio;	/* Prio of the originating CPU */
> 	int src_cpu;	/* CPU where the IPI is running */
> 	int stop_cpu;	/* cpu where we can stop iterating */
> 	...
> };
> 
> Where you can increase seq every time you change it and the IPI will
> continue at least one more rto mask round for every change?
> 
> > > Hohumm,.. so there's still a problem here, and you created it by looking
> > > for the highest prio overloaded cpu.
> > > 
> > > This means that if multiple CPUs need to go pull, they'll end up sending IPIs
> > > to the same highest overloaded CPU.
> > 
> > Sure, and if you like, I'll post timings of the cost of this.
> > 
> > I can add tests to try to trigger the worse case scenario, and we can
> > see what this actually is. So far, it is much better than the current
> > everyone grabbing that lock, as that blocks everything, and has a
> > really nasty cascading effect.
> 
> But what is wrong with maintaining the current behaviour -- or something
> similar -- where you just try the 'first' one?

Because that first one will be what all CPUs try, and we cause the lock
contention again.

> 
> The current code of pull_rt_task() does not do the n^2 loop trying to
> pull from the highest prio cpu first and then the second, third.. etc
> highest cpu.
> 
> It just walks the rto_mask and pulls from whatever it finds first.

Actually, it pulls everything it can. It doesn't stop at the first one
it finds as there may be a higher priority task to pull.

Now, I also notice a problem with the current approach. It pulls what
ever can preempt the current process. It doesn't look like it updates
what it pulls. That is, it can pull the highest prio task, and then
pull a lower prio task as long as it is higher than what is current
running. That is, it only checks this_rq->rt.highest_prio.curr, which
may not be the highest priority task queued. It also needs to check
this_rq->rt.highest_prio.next.

> 
> You're changing that for no real reason afaict.

It was an optimization. Now, I did say we can maintain this behavior
with the IPIs as well.

> 
> > > We should really try and avoid for_each_cpu() loops in interrupts (or
> > > with interrupts disabled for that matter).
> > > 
> > > So when last we talked about this problem; I suggested two alternatives:
> > > 
> > >  - pick the next rto cpu after the current and loop around until you're
> > >    past the original cpu again.
> > 
> > OK, I realized that my patch did change something. It sends to the
> > highest prio CPU first, and stops when it gets a task. This is
> > different than what the original code does (and IMO better), where the
> > original code pulls all tasks that it can pull, thus adding a bunch of
> > RT tasks on this queue. At least this keeps the number of RT overloaded
> > bits in the rto_mask down.
> > 
> > But, I can keep this nastiness and still do the same. Instead of
> > stopping after a push, keep sending the IPI around and let all RT
> > overloaded CPUs try to push their tasks.
> 
> Well, the problem with it is one of collisions. So the 'easy' solution I
> proposed would be something like:
> 
> int ips_next(struct ipi_pull_struct *ips)
> {
> 	int cpu = ips->src_cpu;
> 	cpu = cpumask_next(cpu, rto_mask);
> 	if (cpu >= nr_cpu_ids) {

Do we really need to loop? Just start with the first one, and go to the
end.

> 		cpu = 0;
> 		ips->flags |= IPS_LOOPED;
> 		cpu = cpumask_next(cpu, rto_mask);
> 		if (cpu >= nr_cpu_ids) /* empty mask *;
> 			return cpu;
> 	}
> 	if (ips->flags & IPS_LOOPED && cpu >= ips->stop_cpu)
> 		return nr_cpu_ids;
> 	return cpu;
> }
> 
> 
> 
> 	struct ipi_pull_struct *ips = __this_cpu_ptr(ips);
> 
> 	raw_spin_lock(&ips->lock);
> 	if (ips->flags & IPS_BUSY) {
> 		/* there is an IPI active; update state */
> 		ips->dst_prio = current->prio;
> 		ips->stop_cpu = ips->src_cpu;
> 		ips->flags &= ~IPS_LOOPED;

I guess the loop is needed for continuing the work, in case the
scheduling changed?


> 	} else {
> 		/* no IPI active, make one go */
> 		ips->dst_cpu = smp_processor_id();
> 		ips->dst_prio = current->prio;
> 		ips->src_cpu = ips->dst_cpu;
> 		ips->stop_cpu = ips->dst_cpu;
> 		ips->flags = IPS_BUSY;
> 
> 		cpu = ips_next(ips);
> 		ips->src_cpu = cpu;
> 		if (cpu < nr_cpu_ids)
> 			irq_work_queue_on(&ips->work, cpu);
> 	}
> 	raw_spin_unlock(&ips->lock);

I'll have to spend some time comprehending this.

> 
> 
> Where you would simply start walking the RTO mask from the current
> position -- it also includes some restart logic, and you'd only take
> ips->lock when your ipi handler starts and when it needs to migrate to
> another cpu.
> 
> This way, on big systems, there's at least some chance different CPUs
> find different targets to pull from.

OK, makes sense. I can try that.

> 
> > >  - do that 'randomized' walk over rto and again, terminate when you're
> > >    back where you started.
> > 
> > 
> > Not sure what you mean by a randomized walk?
> 
> lkml.kernel.org/r/20150206135945.GM24151@twins.programming.kicks-ass.net
> 
> Where instead of a linear rto walk it does a random walk over the
> bitmap -- bit over the top maybe ;-)

Yeah, I think just starting from smp_processor_id()+1 is sufficient.

-- Steve
