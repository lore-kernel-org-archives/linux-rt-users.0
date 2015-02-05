From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 5 Feb 2015 11:04:20 -0500
Message-ID: <20150205110420.398fb3c8@gandalf.local.home>
References: <20150204143906.742287b4@gandalf.local.home>
	<20150205145833.GJ5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150205145833.GJ5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 5 Feb 2015 15:58:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 04, 2015 at 02:39:06PM -0500, Steven Rostedt wrote:
> > Can this be wildly non-deterministic? 
> 
> You're not actually answering the question here; so basically its doing
> push_rt_tasks() - and you 'need' to show that that has bounded behaviour.
> 
> Saying the current thing is bad doesn't mean the proposed thing is good.
> 
> Now clearly spinlock contention is O(nr_cpus) and while that sucks rock,
> its actually fairly bounded.

And so is the solution. The solution is O(nr_cpus). Because it only
pushes tasks to CPUs that have lowered its priority. And you also need
to have nr_cpus tasks on that queue to hit this worse case scenario.

Now we have the current code which is O(nr_cpus) and a new solution
which is also O(nr_cpus). But the current code can easily trigger that
worse case, just by having all cpus drop their priorities. The new
solution needs that, plus you also need to have nr_cpus tasks waiting
for a cpu to go to. (once there's no more cpus to push to, even if
there's more than nr_cpus tasks, the algorithm stops).

> 
> > Comments?
> 
> A few.. find below.
> 
> >  kernel/sched/core.c     |   18 ++++++++++++++++++
> >  kernel/sched/features.h |   14 ++++++++++++++
> >  kernel/sched/rt.c       |   37 +++++++++++++++++++++++++++++++++++++
> >  kernel/sched/sched.h    |    5 +++++
> >  4 files changed, 74 insertions(+)
> > 
> > Index: linux-rt.git/kernel/sched/core.c
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/core.c	2015-02-04 14:08:15.688111069 -0500
> > +++ linux-rt.git/kernel/sched/core.c	2015-02-04 14:08:17.382088074 -0500
> > @@ -1582,6 +1582,9 @@
> >  	 */
> >  	preempt_fold_need_resched();
> >  
> > +	if (sched_feat(RT_PUSH_IPI))
> > +		sched_rt_push_check();
> 
> This should be in the irq_enter()/exit() part, but better still, move
> this into an smp_call_fuction_single_async() or queue_irq_work_on(), no
> reason to make the scheduler IPI do yet more work.

OK, the smp_call_function_single_async() may be better. Question is, do
they too grab spinlocks to send? I'm trying to avoid the lock
contention that will happen when we have 100 CPUs all seeing that one
CPU and grabbing the same lock. This happens in the scheduler code,
with rq locks held.

If they do not grab any locks, then they would be fine to use.

> 
> >  	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
> >  		return;
> >  
> > @@ -7271,6 +7274,21 @@
> >  		zalloc_cpumask_var(&cpu_isolated_map, GFP_NOWAIT);
> >  	idle_thread_set_boot_cpu();
> >  	set_cpu_rq_start_time();
> > +
> > +	/*
> > +	 * To avoid heavy contention on large CPU boxes,
> > +	 * when there is an RT overloaded CPU (two or more RT tasks
> > +	 * queued to run on a CPU and one of the waiting RT tasks
> > +	 * can migrate) and another CPU lowers its priority, instead
> > +	 * of grabbing both rq locks of the CPUS (as many CPUs lowering
> > +	 * their priority at the same time may create large latencies)
> > +	 * send an IPI to the CPU that is overloaded so that it can
> > +	 * do an efficent push.
> > +	 */
> > +	if (num_possible_cpus() > 16) {
> > +		sched_feat_enable(__SCHED_FEAT_RT_PUSH_IPI);
> > +		sysctl_sched_features |= (1UL << __SCHED_FEAT_RT_PUSH_IPI);
> > +	}
> 
> *boom* this won't compile for !CONFIG_SCHED_DEBUG, sysctl_sched_features
> is const in that case.

Heh, well that's solved with an #ifdef.

> 
> So I'm sure that it doesn't make sense to tie to an arbitrary CPU
> number, better tie it to a topology property, like the machine having
> two LLC cache domains -- or just always enable the thing.

Yeah, I thought about this. Probably best to just enable it. I did
notice on a 4 CPU box, that it tend to give a little more latency than
with it off. But it wasn't much. I'll have to benchmark this some more.

> 
> >  #endif
> >  	init_sched_fair_class();
> >  
> > Index: linux-rt.git/kernel/sched/rt.c
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/rt.c	2015-02-04 14:08:15.688111069 -0500
> > +++ linux-rt.git/kernel/sched/rt.c	2015-02-04 14:08:17.383088061 -0500
> > @@ -1760,6 +1760,31 @@
> >  		;
> >  }
> >  
> > +/**
> > + * sched_rt_push_check - check if we can push waiting RT tasks
> > + *
> > + * Called from sched IPI when sched feature RT_PUSH_IPI is enabled.
> > + *
> > + * Checks if there is an RT task that can migrate and there exists
> > + * a CPU in its affinity that only has tasks lower in priority than
> > + * the waiting RT task. If so, then it will push the task off to that
> > + * CPU.
> > + */
> > +void sched_rt_push_check(void)
> > +{
> > +	struct rq *rq = cpu_rq(smp_processor_id());
> > +
> > +	if (WARN_ON_ONCE(!irqs_disabled()))
> > +		return;
> > +
> > +	if (!has_pushable_tasks(rq))
> > +		return;
> > +
> > +	raw_spin_lock(&rq->lock);
> > +	push_rt_tasks(rq);
> 
> So this, on first sight, looks like an unbounded while loop; better
> present some runtime bound analysis on it.
> 
> At present I find a worst case O(inf * nr_tries * nr_prios * nr_cpus),
> which while on average might run faster, is actually quite horrible.

Again, the algorithm stops when no task is pushed, so it's not inf.

I could add a flag to not do the retry in this case. And, yeah, the
nr_prios could happen if the waiting task is of high priority (but that
task would need to be of lower priority than all the other CPUs that are
asking for the pull, otherwise it would have pushed to those CPUs in
the first place).

> 
> RT isn't won on avg or median execution times :-)

Totally agree. And I'm willing to write up more analysis, because the
worse case scenario, would require a lot of things to happen that would
take a lot of work to do so, and not something that would randomly
happen.

Even the retry only happens if it could not find a CPU that had a lower
priority than the task it was looking for, and the task either somehow
migrated, or a higher priority task some how got queued instead when
the lock was released.

And this retry case is in today's code, and any problem we have with
it, should be solved today as well.

Lets go back to how to get into a situation where this code is
activated. You need to have a bunch of RT tasks queue on one run queue,
which happens only if when they were queued all other CPUs were running
RT tasks of higher priority than the queued tasks.

When one of the other CPUS stops running the high priority task, it
sees that there's a queue that has RT tasks that are waiting and sends
an IPI to that queue to push off its RT tasks. (Note, I do see a flaw
in this patch, and it should send an IPI to all CPUS that has
overloaded RT tasks.) Then that queue will try to push off the RT task
to available CPUS. If there's no CPU to push to, or when it runs out of
RT tasks, then the algorithm stops.

Now I guess you could argue that if you have > nr_cpus tasks on your
queue, and when you push one task off, and it runs on the other CPU and
finishes, which would mean you could push the next RT task off. If that
task finishes before we get to the next task, it could be nr_tasks
algorithm. But that's more than unlikely that a task could schedule on
another CPU and finish, and schedule out, before we do the next task on
the loop.

And, again, that algorithm exists today, and would cause issues. I bet
I could come up with some scenario that would cause the current code to
have an infinite worse case scenario as well.

This isn't just avg or median times. When the current code is
constantly hitting 1ms latencies in the scheduler, and this patch nukes
it down to 50us max latencies, I think we should seriously think about
it. Because today, the code is not acceptable.

I'm willing to massage this patch and do a full analysis on it. I just
don't want this discussion to end like it did last time.

> 
> > +	raw_spin_unlock(&rq->lock);
> > +}
> > +
> >  static int pull_rt_task(struct rq *this_rq)
> >  {
> >  	int this_cpu = this_rq->cpu, ret = 0, cpu;
> > Index: linux-rt.git/kernel/sched/sched.h
> > ===================================================================
> > --- linux-rt.git.orig/kernel/sched/sched.h	2015-02-04 14:08:15.688111069 -0500
> > +++ linux-rt.git/kernel/sched/sched.h	2015-02-04 14:08:17.392087939 -0500
> > @@ -1540,6 +1542,9 @@
> >  	__release(rq2->lock);
> >  }
> >  
> > +void sched_rt_push_check(void)
> 
> I'm very sure you mean static inline there.. otherwise the linker will
> get upset about multiple instances of the same symbol.

ug, yeah.

Thanks,

-- Steve

> 
> > +{
> > +}
> >  #endif
> >  
> >  extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
