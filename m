From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Thu, 5 Feb 2015 15:58:33 +0100
Message-ID: <20150205145833.GJ5029@twins.programming.kicks-ass.net>
References: <20150204143906.742287b4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150204143906.742287b4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 04, 2015 at 02:39:06PM -0500, Steven Rostedt wrote:
> Can this be wildly non-deterministic? 

You're not actually answering the question here; so basically its doing
push_rt_tasks() - and you 'need' to show that that has bounded behaviour.

Saying the current thing is bad doesn't mean the proposed thing is good.

Now clearly spinlock contention is O(nr_cpus) and while that sucks rock,
its actually fairly bounded.

> Comments?

A few.. find below.

>  kernel/sched/core.c     |   18 ++++++++++++++++++
>  kernel/sched/features.h |   14 ++++++++++++++
>  kernel/sched/rt.c       |   37 +++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h    |    5 +++++
>  4 files changed, 74 insertions(+)
> 
> Index: linux-rt.git/kernel/sched/core.c
> ===================================================================
> --- linux-rt.git.orig/kernel/sched/core.c	2015-02-04 14:08:15.688111069 -0500
> +++ linux-rt.git/kernel/sched/core.c	2015-02-04 14:08:17.382088074 -0500
> @@ -1582,6 +1582,9 @@
>  	 */
>  	preempt_fold_need_resched();
>  
> +	if (sched_feat(RT_PUSH_IPI))
> +		sched_rt_push_check();

This should be in the irq_enter()/exit() part, but better still, move
this into an smp_call_fuction_single_async() or queue_irq_work_on(), no
reason to make the scheduler IPI do yet more work.

>  	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
>  		return;
>  
> @@ -7271,6 +7274,21 @@
>  		zalloc_cpumask_var(&cpu_isolated_map, GFP_NOWAIT);
>  	idle_thread_set_boot_cpu();
>  	set_cpu_rq_start_time();
> +
> +	/*
> +	 * To avoid heavy contention on large CPU boxes,
> +	 * when there is an RT overloaded CPU (two or more RT tasks
> +	 * queued to run on a CPU and one of the waiting RT tasks
> +	 * can migrate) and another CPU lowers its priority, instead
> +	 * of grabbing both rq locks of the CPUS (as many CPUs lowering
> +	 * their priority at the same time may create large latencies)
> +	 * send an IPI to the CPU that is overloaded so that it can
> +	 * do an efficent push.
> +	 */
> +	if (num_possible_cpus() > 16) {
> +		sched_feat_enable(__SCHED_FEAT_RT_PUSH_IPI);
> +		sysctl_sched_features |= (1UL << __SCHED_FEAT_RT_PUSH_IPI);
> +	}

*boom* this won't compile for !CONFIG_SCHED_DEBUG, sysctl_sched_features
is const in that case.

So I'm sure that it doesn't make sense to tie to an arbitrary CPU
number, better tie it to a topology property, like the machine having
two LLC cache domains -- or just always enable the thing.

>  #endif
>  	init_sched_fair_class();
>  
> Index: linux-rt.git/kernel/sched/rt.c
> ===================================================================
> --- linux-rt.git.orig/kernel/sched/rt.c	2015-02-04 14:08:15.688111069 -0500
> +++ linux-rt.git/kernel/sched/rt.c	2015-02-04 14:08:17.383088061 -0500
> @@ -1760,6 +1760,31 @@
>  		;
>  }
>  
> +/**
> + * sched_rt_push_check - check if we can push waiting RT tasks
> + *
> + * Called from sched IPI when sched feature RT_PUSH_IPI is enabled.
> + *
> + * Checks if there is an RT task that can migrate and there exists
> + * a CPU in its affinity that only has tasks lower in priority than
> + * the waiting RT task. If so, then it will push the task off to that
> + * CPU.
> + */
> +void sched_rt_push_check(void)
> +{
> +	struct rq *rq = cpu_rq(smp_processor_id());
> +
> +	if (WARN_ON_ONCE(!irqs_disabled()))
> +		return;
> +
> +	if (!has_pushable_tasks(rq))
> +		return;
> +
> +	raw_spin_lock(&rq->lock);
> +	push_rt_tasks(rq);

So this, on first sight, looks like an unbounded while loop; better
present some runtime bound analysis on it.

At present I find a worst case O(inf * nr_tries * nr_prios * nr_cpus),
which while on average might run faster, is actually quite horrible.

RT isn't won on avg or median execution times :-)

> +	raw_spin_unlock(&rq->lock);
> +}
> +
>  static int pull_rt_task(struct rq *this_rq)
>  {
>  	int this_cpu = this_rq->cpu, ret = 0, cpu;
> Index: linux-rt.git/kernel/sched/sched.h
> ===================================================================
> --- linux-rt.git.orig/kernel/sched/sched.h	2015-02-04 14:08:15.688111069 -0500
> +++ linux-rt.git/kernel/sched/sched.h	2015-02-04 14:08:17.392087939 -0500
> @@ -1540,6 +1542,9 @@
>  	__release(rq2->lock);
>  }
>  
> +void sched_rt_push_check(void)

I'm very sure you mean static inline there.. otherwise the linker will
get upset about multiple instances of the same symbol.

> +{
> +}
>  #endif
>  
>  extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
