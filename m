Return-Path: <SRS0=1NWT=DN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573AAC41604
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C20C2075A
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFI4Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:56:25 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:31299 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFI4Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Oct 2020 04:56:25 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 04:56:21 EDT
Received: from [151.61.51.211] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 151704067; Tue, 06 Oct 2020 09:56:17 +0200
Date:   Tue, 6 Oct 2020 09:56:12 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 4/6] sched/deadline: Introduce deadline servers
Message-ID: <20201006095612.381d806f@sweethome>
In-Reply-To: <20200807095051.385985-5-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807095051.385985-5-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

sorry for the late reply... Anyway, I am currently testing this
patchset (and trying to use it for the "SCHED_DEADLINE-based cgroup
scheduling" patchset).
And during my tests I had a doubt:



On Fri,  7 Aug 2020 11:50:49 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Low priority tasks (e.g., SCHED_OTHER) can suffer starvation if tasks
> with higher priority (e.g., SCHED_FIFO) monopolize CPU(s).
[...]
> @@ -1024,10 +1062,34 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
>  	struct sched_dl_entity *dl_se = container_of(timer,
>  						     struct sched_dl_entity,
>  						     dl_timer);
> -	struct task_struct *p = dl_task_of(dl_se);
> +	struct task_struct *p;
>  	struct rq_flags rf;
>  	struct rq *rq;
>  
> +	if (dl_server(dl_se)) {
> +		struct rq *rq = rq_of_dl_se(dl_se);
> +		struct rq_flags rf;
> +
> +		rq_lock(rq, &rf);
> +		if (dl_se->dl_throttled) {
> +			sched_clock_tick();
> +			update_rq_clock(rq);
> +
> +			if (dl_se->server_has_tasks(dl_se)) {
> +				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
> +				resched_curr(rq);
> +				__push_dl_task(rq, &rf);
> +			} else {
> +				replenish_dl_entity(dl_se, dl_se);

I am wondering if here we need a "task_non_contending(dl_se)" after
"replenish_dl_entity(dl_se, dl_se);"...

Basically, what happened is that all the served tasks blocked while the
server was throttled... So, now the server should be disabled (so, we
replenish the dl entity but we do not insert it in runqueue).
But when the server finished its budget and has been throttled, it has
not been disabled (so, its utilization is still in running_bw).

I think that if we do not call task_non_contending() the server's
utilization is not correctly removed from running_bw (this does not
happen for regular tasks, because task_non_contending() is invoked when
they block, even if the dl entity is throttled... But for servers I
think we have an issue).

What do you think? Do you agree with this change?

I have no easy way to reproduce the issue, but this change fixed some
strange behaviours I was seeing when using this patch to schedule RT
cgroups.



			Thanks,
				Luca
> +			}
> +
> +		}
> +		rq_unlock(rq, &rf);
> +
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	p = dl_task_of(dl_se);
>  	rq = task_rq_lock(p, &rf);
>  
>  	/*
> @@ -1098,21 +1160,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
>  	else
>  		resched_curr(rq);
>  
> -#ifdef CONFIG_SMP
> -	/*
> -	 * Queueing this task back might have overloaded rq, check if we need
> -	 * to kick someone away.
> -	 */
> -	if (has_pushable_dl_tasks(rq)) {
> -		/*
> -		 * Nothing relies on rq->lock after this, so its safe to drop
> -		 * rq->lock.
> -		 */
> -		rq_unpin_lock(rq, &rf);
> -		push_dl_task(rq);
> -		rq_repin_lock(rq, &rf);
> -	}
> -#endif
> +	__push_dl_task(rq, &rf);
>  
>  unlock:
>  	task_rq_unlock(rq, p, &rf);
> @@ -1154,12 +1202,11 @@ static void init_dl_task_timer(struct sched_dl_entity *dl_se)
>   */
>  static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
>  {
> -	struct task_struct *p = dl_task_of(dl_se);
> -	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
> +	struct rq *rq = rq_of_dl_se(dl_se);
>  
>  	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
>  	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
> -		if (unlikely(dl_se->dl_boosted || !start_dl_timer(p)))
> +		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se)))
>  			return;
>  		dl_se->dl_throttled = 1;
>  		if (dl_se->runtime > 0)
> @@ -1216,29 +1263,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>  	return (delta * u_act) >> BW_SHIFT;
>  }
>  
> -/*
> - * Update the current task's runtime statistics (provided it is still
> - * a -deadline task and has not been removed from the dl_rq).
> - */
> -static void update_curr_dl(struct rq *rq)
> +static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
>  {
> -	struct task_struct *curr = rq->curr;
> -	struct sched_dl_entity *dl_se = &curr->dl;
> -	s64 delta_exec, scaled_delta_exec;
> -	int cpu = cpu_of(rq);
> +	s64 scaled_delta_exec;
>  
> -	if (!dl_task(curr) || !on_dl_rq(dl_se))
> -		return;
> -
> -	/*
> -	 * Consumed budget is computed considering the time as
> -	 * observed by schedulable tasks (excluding time spent
> -	 * in hardirq context, etc.). Deadlines are instead
> -	 * computed using hard walltime. This seems to be the more
> -	 * natural solution, but the full ramifications of this
> -	 * approach need further study.
> -	 */
> -	delta_exec = update_curr_common(rq);
>  	if (unlikely(delta_exec <= 0)) {
>  		if (unlikely(dl_se->dl_yielded))
>  			goto throttle;
> @@ -1256,10 +1284,9 @@ static void update_curr_dl(struct rq *rq)
>  	 * according to current frequency and CPU maximum capacity.
>  	 */
>  	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
> -		scaled_delta_exec = grub_reclaim(delta_exec,
> -						 rq,
> -						 &curr->dl);
> +		scaled_delta_exec = grub_reclaim(delta_exec, rq, dl_se);
>  	} else {
> +		int cpu = cpu_of(rq);
>  		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
>  		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
>  
> @@ -1278,11 +1305,18 @@ static void update_curr_dl(struct rq *rq)
>  		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
>  			dl_se->dl_overrun = 1;
>  
> -		__dequeue_task_dl(rq, curr, 0);
> -		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
> -			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
> +		dequeue_dl_entity(dl_se, 0);
> +		if (!dl_server(dl_se))
> +			dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
>  
> -		if (!is_leftmost(curr, &rq->dl))
> +		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se))) {
> +			if (dl_server(dl_se))
> +				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
> +			else
> +				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
> +		}
> +
> +		if (!is_leftmost(dl_se, &rq->dl))
>  			resched_curr(rq);
>  	}
>  
> @@ -1312,20 +1346,82 @@ static void update_curr_dl(struct rq *rq)
>  	}
>  }
>  
> +void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
> +{
> +	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> +}
> +
> +void dl_server_start(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_server(dl_se)) {
> +		dl_se->dl_server = 1;
> +		setup_new_dl_entity(dl_se);
> +	}
> +	enqueue_dl_entity(dl_se, dl_se, ENQUEUE_WAKEUP);
> +}
> +
> +void dl_server_stop(struct sched_dl_entity *dl_se)
> +{
> +	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
> +}
> +
> +void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> +		    dl_server_has_tasks_f has_tasks,
> +		    dl_server_pick_f pick)
> +{
> +	dl_se->rq = rq;
> +	dl_se->server_has_tasks = has_tasks;
> +	dl_se->server_pick = pick;
> +}
> +
> +/*
> + * Update the current task's runtime statistics (provided it is still
> + * a -deadline task and has not been removed from the dl_rq).
> + */
> +static void update_curr_dl(struct rq *rq)
> +{
> +	struct task_struct *curr = rq->curr;
> +	struct sched_dl_entity *dl_se = &curr->dl;
> +	s64 delta_exec;
> +
> +	if (!dl_task(curr) || !on_dl_rq(dl_se))
> +		return;
> +
> +	/*
> +	 * Consumed budget is computed considering the time as
> +	 * observed by schedulable tasks (excluding time spent
> +	 * in hardirq context, etc.). Deadlines are instead
> +	 * computed using hard walltime. This seems to be the more
> +	 * natural solution, but the full ramifications of this
> +	 * approach need further study.
> +	 */
> +	delta_exec = update_curr_common(rq);
> +	update_curr_dl_se(rq, dl_se, delta_exec);
> +}
> +
>  static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  {
>  	struct sched_dl_entity *dl_se = container_of(timer,
>  						     struct sched_dl_entity,
>  						     inactive_timer);
> -	struct task_struct *p = dl_task_of(dl_se);
> +	struct task_struct *p = NULL;
>  	struct rq_flags rf;
>  	struct rq *rq;
>  
> -	rq = task_rq_lock(p, &rf);
> +	if (!dl_server(dl_se)) {
> +		p = dl_task_of(dl_se);
> +		rq = task_rq_lock(p, &rf);
> +	} else {
> +		rq = dl_se->rq;
> +		rq_lock(rq, &rf);
> +	}
>  
>  	sched_clock_tick();
>  	update_rq_clock(rq);
>  
> +	if (dl_server(dl_se))
> +		goto no_task;
> +
>  	if (!dl_task(p) || p->state == TASK_DEAD) {
>  		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
>  
> @@ -1342,14 +1438,21 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  
>  		goto unlock;
>  	}
> +
> +no_task:
>  	if (dl_se->dl_non_contending == 0)
>  		goto unlock;
>  
>  	sub_running_bw(dl_se, &rq->dl);
>  	dl_se->dl_non_contending = 0;
>  unlock:
> -	task_rq_unlock(rq, p, &rf);
> -	put_task_struct(p);
> +
> +	if (!dl_server(dl_se)) {
> +		task_rq_unlock(rq, p, &rf);
> +		put_task_struct(p);
> +	} else {
> +		rq_unlock(rq, &rf);
> +	}
>  
>  	return HRTIMER_NORESTART;
>  }
> @@ -1402,34 +1505,35 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
>  static inline void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
>  static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
>  
> +static inline void update_dl_migration(struct dl_rq *dl_rq) {}
> +
>  #endif /* CONFIG_SMP */
>  
>  static inline
>  void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  {
> -	int prio = dl_task_of(dl_se)->prio;
>  	u64 deadline = dl_se->deadline;
>  
> -	WARN_ON(!dl_prio(prio));
>  	dl_rq->dl_nr_running++;
>  	add_nr_running(rq_of_dl_rq(dl_rq), 1);
>  
>  	inc_dl_deadline(dl_rq, deadline);
> -	inc_dl_migration(dl_se, dl_rq);
> +	if (!dl_server(dl_se))
> +		inc_dl_migration(dl_se, dl_rq);
> +	update_dl_migration(dl_rq);
>  }
>  
>  static inline
>  void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  {
> -	int prio = dl_task_of(dl_se)->prio;
> -
> -	WARN_ON(!dl_prio(prio));
>  	WARN_ON(!dl_rq->dl_nr_running);
>  	dl_rq->dl_nr_running--;
>  	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
>  
>  	dec_dl_deadline(dl_rq, dl_se->deadline);
> -	dec_dl_migration(dl_se, dl_rq);
> +	if (!dl_server(dl_se))
> +		dec_dl_migration(dl_se, dl_rq);
> +	update_dl_migration(dl_rq);
>  }
>  
>  static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> @@ -1524,8 +1628,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se, pi_se);
>  	} else if ((flags & ENQUEUE_RESTORE) &&
> -		  dl_time_before(dl_se->deadline,
> -				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
> +		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> @@ -1592,14 +1695,6 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  		enqueue_pushable_dl_task(rq, p);
>  }
>  
> -static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
> -{
> -	dequeue_dl_entity(&p->dl, flags);
> -
> -	if (!p->dl.dl_throttled)
> -		dequeue_pushable_dl_task(rq, p);
> -}
> -
>  static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	update_curr_dl(rq);
> @@ -1607,7 +1702,9 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  	if (p->on_rq == TASK_ON_RQ_MIGRATING)
>  		flags |= DEQUEUE_MIGRATING;
>  
> -	__dequeue_task_dl(rq, p, flags);
> +	dequeue_dl_entity(&p->dl, flags);
> +	if (!p->dl.dl_throttled)
> +		dequeue_pushable_dl_task(rq, p);
>  }
>  
>  /*
> @@ -1789,12 +1886,12 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
>  }
>  
>  #ifdef CONFIG_SCHED_HRTICK
> -static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
> +static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
>  {
> -	hrtick_start(rq, p->dl.runtime);
> +	hrtick_start(rq, dl_se->runtime);
>  }
>  #else /* !CONFIG_SCHED_HRTICK */
> -static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
> +static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
>  {
>  }
>  #endif
> @@ -1809,9 +1906,6 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
>  	if (!first)
>  		return;
>  
> -	if (hrtick_enabled(rq))
> -		start_hrtick_dl(rq, p);
> -
>  	if (rq->curr->sched_class != &dl_sched_class)
>  		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
>  
> @@ -1835,13 +1929,30 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	struct dl_rq *dl_rq = &rq->dl;
>  	struct task_struct *p;
>  
> +again:
>  	if (!sched_dl_runnable(rq))
>  		return NULL;
>  
>  	dl_se = pick_next_dl_entity(rq, dl_rq);
>  	BUG_ON(!dl_se);
> -	p = dl_task_of(dl_se);
> -	set_next_task_dl(rq, p, true);
> +	if (dl_server(dl_se)) {
> +		p = dl_se->server_pick(dl_se);
> +		if (!p) {
> +			// XXX should not happen, warn?!
> +			dl_se->dl_yielded = 1;
> +			update_curr_dl_se(rq, dl_se, 0);
> +			goto again;
> +		}
> +		p->server = dl_se;
> +	} else {
> +		p = dl_task_of(dl_se);
> +		set_next_task_dl(rq, p, true);
> +	}
> +
> +	/* XXX not quite right */
> +	if (hrtick_enabled(rq))
> +		start_hrtick_dl(rq, dl_se);
> +
>  	return p;
>  }
>  
> @@ -1873,8 +1984,8 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
>  	 * be set and schedule() will start a new hrtick for the next task.
>  	 */
>  	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
> -	    is_leftmost(p, &rq->dl))
> -		start_hrtick_dl(rq, p);
> +	    is_leftmost(&p->dl, &rq->dl))
> +		start_hrtick_dl(rq, &p->dl);
>  }
>  
>  static void task_fork_dl(struct task_struct *p)
> @@ -2771,6 +2882,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
>  	dl_se->dl_yielded		= 0;
>  	dl_se->dl_non_contending	= 0;
>  	dl_se->dl_overrun		= 0;
> +	dl_se->dl_server		= 0;
>  }
>  
>  void init_dl_entity(struct sched_dl_entity *dl_se)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 10a230d85104a..5130239c0e1e5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -868,6 +868,8 @@ s64 update_curr_common(struct rq *rq)
>  
>  	account_group_exec_runtime(curr, delta_exec);
>  	cgroup_account_cputime(curr, delta_exec);
> +	if (curr->server)
> +		dl_server_update(curr->server, delta_exec);
>  
>  	return delta_exec;
>  }
> @@ -897,6 +899,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>  		cgroup_account_cputime(curtask, delta_exec);
>  		account_group_exec_runtime(curtask, delta_exec);
> +		if (curtask->server)
> +			dl_server_update(curtask->server, delta_exec);
>  	}
>  
>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d3db8c7d8b641..f035cd8ccd224 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -346,6 +346,35 @@ extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_c
>  extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
>  extern bool dl_cpu_busy(unsigned int cpu);
>  
> +/*
> + * SCHED_DEADLINE supports servers (nested scheduling) with the following
> + * interface:
> + *
> + *   dl_se::rq -- runqueue we belong to.
> + *
> + *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
> + *                                server when it runs out of tasks to run.
> + *
> + *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
> + *                           returns NULL.
> + *
> + *   dl_server_update() -- called from update_curr_common(), propagates runtime
> + *                         to the server.
> + *
> + *   dl_server_start()
> + *   dl_server_stop()  -- start/stop the server when it has (no) tasks
> + *
> + *   dl_server_init()
> + *
> + * XXX
> + */
> +extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
> +extern void dl_server_start(struct sched_dl_entity *dl_se);
> +extern void dl_server_stop(struct sched_dl_entity *dl_se);
> +extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> +		    dl_server_has_tasks_f has_tasks,
> +		    dl_server_pick_f pick);
> +
>  #ifdef CONFIG_CGROUP_SCHED
>  
>  #include <linux/cgroup.h>

