From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: [RFD/RFC PATCH 3/8] locking/mutex: Rework
 task_struct::blocked_on
Date: Wed, 10 Oct 2018 12:43:28 +0200
Message-ID: <20181010124328.16052fd3@luca64>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181009092434.26221-4-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-4-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Tue,  9 Oct 2018 11:24:29 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Track the blocked-on relation for mutexes, this allows following this
> relation at schedule time. Add blocked_task to track the inverse
> relation.
> 
>                 ,-> task
>                 |     | blocked-on
>                 |     v
>    blocked-task |   mutex
>                 |     | owner
>                 |     v
>                 `-- task

I was a little bit confused by this description, because (if I
understand the code well) blocked_task does not actually track the
inverse of the "blocked_on" relationship, but just points to the task
that is _currently_ acting as a proxy for a given task.

In theory, we could have multiple tasks blocked on "mutex" (which is
owned by "task"), so if "blocked_task" tracked the inverse of
"blocked_on" it should have been a list (or a data structure containing
pointers to multiple task structures), no?

I would propose to change "blocked_task" into something like
"current_proxy", or similar, which should be more clear (unless I
completely misunderstood this stuff... In that case, sorry about the
noise)


Also, I suspect that this "blocked_task" (or "current_proxy") field
should be introcuced in patch 5 (same for the "task_is_blocked()"
function from patch 4... Should it go in patch 5?)

				Luca
> 
> This patch only enables blocked-on relation, blocked-task will be
> enabled in a later patch implementing proxy().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [minor changes while rebasing]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  include/linux/sched.h        | 6 ++----
>  kernel/fork.c                | 6 +++---
>  kernel/locking/mutex-debug.c | 7 +++----
>  kernel/locking/mutex.c       | 3 +++
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 977cb57d7bc9..a35e8ab3eef1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -907,10 +907,8 @@ struct task_struct {
>  	struct rt_mutex_waiter		*pi_blocked_on;
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	/* Mutex deadlock detection: */
> -	struct mutex_waiter		*blocked_on;
> -#endif
> +	struct task_struct 	*blocked_task;	/* task
> that's boosting us */
> +	struct mutex 		*blocked_on;	/* lock
> we're blocked on */ 
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	unsigned int			irq_events;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0b58479534f..ef27a675b0d7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1827,9 +1827,9 @@ static __latent_entropy struct task_struct
> *copy_process( lockdep_init_task(p);
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	p->blocked_on = NULL; /* not blocked yet */
> -#endif
> +	p->blocked_task = NULL; /* nobody is boosting us yet*/
> +	p->blocked_on = NULL;  /* not blocked yet */
> +
>  #ifdef CONFIG_BCACHE
>  	p->sequential_io	= 0;
>  	p->sequential_io_avg	= 0;
> diff --git a/kernel/locking/mutex-debug.c
> b/kernel/locking/mutex-debug.c index a660d38b6c29..6605e083a3e9 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -53,8 +53,8 @@ void debug_mutex_add_waiter(struct mutex *lock,
> struct mutex_waiter *waiter, {
>  	SMP_DEBUG_LOCKS_WARN_ON(!raw_spin_is_locked(&lock->wait_lock));
>  
> -	/* Mark the current thread as blocked on the lock: */
> -	task->blocked_on = waiter;
> +	/* Current thread can't be alredy blocked (since it's
> executing!) */
> +	DEBUG_LOCKS_WARN_ON(task->blocked_on);
>  }
>  
>  void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter
> *waiter, @@ -62,8 +62,7 @@ void mutex_remove_waiter(struct mutex
> *lock, struct mutex_waiter *waiter, {
>  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
>  	DEBUG_LOCKS_WARN_ON(waiter->task != task);
> -	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
> -	task->blocked_on = NULL;
> +	DEBUG_LOCKS_WARN_ON(task->blocked_on != lock);
>  
>  	list_del_init(&waiter->list);
>  	waiter->task = NULL;
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index f37402cd8496..76b59b555da3 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -979,6 +979,7 @@ __mutex_lock_common(struct mutex *lock, long
> state, unsigned int subclass, }
>  
>  	waiter.task = current;
> +	current->blocked_on = lock;
>  
>  	set_current_state(state);
>  	for (;;) {
> @@ -1047,6 +1048,8 @@ __mutex_lock_common(struct mutex *lock, long
> state, unsigned int subclass, }
>  
>  	mutex_remove_waiter(lock, &waiter, current);
> +	current->blocked_on = NULL;
> +
>  	if (likely(list_empty(&lock->wait_list)))
>  		__mutex_clear_flag(lock, MUTEX_FLAGS);
>  
