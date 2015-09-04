From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 1/3] locking: Add spin_try_or_boost_lock()
 infrastructure
Date: Thu, 3 Sep 2015 21:48:34 -0400
Message-ID: <20150903214834.0caddb8d@grimm.local.home>
References: <20150904011900.730816481@goodmis.org>
	<20150904012118.201373918@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150904012118.201373918@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 03 Sep 2015 21:19:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>					\
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 2822aceb8dfb..2830c17dc3e4 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -253,6 +253,65 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
>  	RB_CLEAR_NODE(&waiter->pi_tree_entry);
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static inline int task_normal_prio(struct task_struct *task)
> +{
> +	return min(task->normal_prio, task->trylock_prio);
> +}
> +
> +static inline int task_top_waiter_prio(struct task_struct *task)
> +{
> +	return min3(task_top_pi_waiter(task)->prio,
> +		    task->normal_prio, task->trylock_prio);
> +}
> +
> +static inline void clear_trylock_prio(struct task_struct *task)
> +{
> +	task->trylock_prio = MAX_PRIO;
> +}
> +
> +static inline bool current_boosted(void)
> +{
> +	return current->trylock_prio < MAX_PRIO;
> +}
> +
> +static void __rt_mutex_adjust_prio(struct task_struct *task);
> +
> +/* Must call rt_mutex_adjust_prio_chain() if an owner is returned */
> +static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
> +{
> +	struct task_struct *owner;
> +
> +	owner = rt_mutex_owner(lock);
> +	if (!owner)
> +		return NULL;
> +
> +	/* Will be released by rt_mutex_adjust_prio_chain() */
> +	get_task_struct(owner);
> +
> +	raw_spin_lock_irq(&owner->pi_lock);
> +	if (owner->trylock_prio > current->prio) {
> +		owner->trylock_prio = current->prio;
> +		__rt_mutex_adjust_prio(owner);
> +	}
> +	raw_spin_unlock_irq(&owner->pi_lock);
> +
> +	return owner;
> +}
> +#else

I forgot to add:

static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
{
	return NULL;
}

See, I didn't test the non PREEMPT_RT cases ;-)

-- Steve

> +static inline int task_normal_prio(struct task_struct *task)
> +{
> +	return task->normal_prio;
> +}
> +static inline int task_top_waiter_prio(struct task_struct *task)
> +{
> +	return min(task_top_pi_waiter(task)->prio,
> +		   task->normal_prio);
> +}
> +# define current_boosted()	0
> +# define clear_trylock_prio(tsk)	do {} while (0)
> +#endif
> +



> @@ -1717,26 +1790,34 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
>  /*
>   * Slow path try-lock function:
>   */
> -static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
> +static inline int rt_mutex_slowtrylock(struct rt_mutex *lock, bool boost)
>  {
> +	struct task_struct *owner;
>  	int ret;
>  
>  	/*
>  	 * If the lock already has an owner we fail to get the lock.
>  	 * This can be done without taking the @lock->wait_lock as
>  	 * it is only being read, and this is a trylock anyway.
> +	 *
> +	 * Only do the short cut if we do not need to boost the task
> +	 * if we fail to get the lock.
>  	 */
> -	if (rt_mutex_owner(lock))
> +	if (!boost && rt_mutex_owner(lock))
>  		return 0;
>  
>  	/*
> -	 * The mutex has currently no owner. Lock the wait lock and
> -	 * try to acquire the lock.
> +	 * The mutex has currently no owner or we need to boost the task
> +	 * if we fail to grab the lock. Lock the wait lock and try to
> +	 * acquire the lock.
>  	 */
>  	raw_spin_lock(&lock->wait_lock);
>  
>  	ret = try_to_take_rt_mutex(lock, current, NULL);
>  
> +	if (!ret && boost)
> +		owner = trylock_boost_owner(lock);
> +
>  	/*
>  	 * try_to_take_rt_mutex() sets the lock waiters bit
>  	 * unconditionally. Clean this up.
> @@ -1745,6 +1826,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
>  
>  	raw_spin_unlock(&lock->wait_lock);
>  
> +	if (!ret && boost && owner)
> +		rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK,
> +					   lock, NULL, NULL, NULL);
> +
>  	return ret;
>  }
>  
