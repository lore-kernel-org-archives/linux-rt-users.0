From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Thu, 22 Jun 2017 19:30:07 +0200
Message-ID: <1498152607.5559.19.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
         <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
         <1497867291.19618.52.camel@gmx.de>
         <20170619100838.343faaee@gandalf.local.home>
         <20170619141341.m243ivutmwlzyhc4@linutronix.de>
         <20170619104131.05fdc76f@gandalf.local.home>
         <1497889784.15817.17.camel@gmx.de> <1497944706.5454.7.camel@gmx.de>
         <20170622163453.iymm3ctqv2a76k6k@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170622163453.iymm3ctqv2a76k6k@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-06-22 at 18:34 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-20 09:45:06 [+0200], Mike Galbraith wrote:
> > See ! and ?
> 
> See see.
> What about this:

I'll give it a go, likely during the weekend.

I moved 4.11-rt today (also repros nicely) due to ftrace annoying me.
 After yet more staring at ever more huge traces (opposite of goal;),
then taking a break to stare at source again, I decided that the dual
wake_q business should die.. and the stall died with it.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1014,8 +1014,20 @@ struct wake_q_head {
>  #define WAKE_Q(name)					\
>  	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
>  
> -extern void wake_q_add(struct wake_q_head *head,
> -			      struct task_struct *task);
> +extern void __wake_q_add(struct wake_q_head *head,
> +			 struct task_struct *task, bool sleeper);
> +static inline void wake_q_add(struct wake_q_head *head,
> +			      struct task_struct *task)
> +{
> +	__wake_q_add(head, task, false);
> +}
> +
> +static inline void wake_q_add_sleeper(struct wake_q_head *head,
> +				      struct task_struct *task)
> +{
> +	__wake_q_add(head, task, true);
> +}
> +
>  extern void __wake_up_q(struct wake_q_head *head, bool sleeper);
>  
>  static inline void wake_up_q(struct wake_q_head *head)
> @@ -1745,6 +1757,7 @@ struct task_struct {
>  	raw_spinlock_t pi_lock;
>  
>  	struct wake_q_node wake_q;
> +	struct wake_q_node wake_q_sleeper;
>  
>  #ifdef CONFIG_RT_MUTEXES
>  	/* PI waiters blocked on a rt_mutex held by this task */
> diff --git a/kernel/fork.c b/kernel/fork.c
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -558,6 +558,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	tsk->splice_pipe = NULL;
>  	tsk->task_frag.page = NULL;
>  	tsk->wake_q.next = NULL;
> +	tsk->wake_q_sleeper.next = NULL;
>  
>  	account_kernel_stack(tsk, 1);
>  
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1506,7 +1506,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
>  	 */
>  	preempt_disable();
>  	if (waiter->savestate)
> -		wake_q_add(wake_sleeper_q, waiter->task);
> +		wake_q_add_sleeper(wake_sleeper_q, waiter->task);
>  	else
>  		wake_q_add(wake_q, waiter->task);
>  	raw_spin_unlock(&current->pi_lock);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -430,9 +430,15 @@ static bool set_nr_if_polling(struct task_struct *p)
>  #endif
>  #endif
>  
> -void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> +void __wake_q_add(struct wake_q_head *head, struct task_struct *task,
> +		  bool sleeper)
>  {
> -	struct wake_q_node *node = &task->wake_q;
> +	struct wake_q_node *node;
> +
> +	if (sleeper)
> +		node = &task->wake_q_sleeper;
> +	else
> +		node = &task->wake_q;
>  
>  	/*
>  	 * Atomically grab the task, if ->wake_q is !nil already it means
> @@ -461,11 +467,17 @@ void __wake_up_q(struct wake_q_head *head, bool sleeper)
>  	while (node != WAKE_Q_TAIL) {
>  		struct task_struct *task;
>  
> -		task = container_of(node, struct task_struct, wake_q);
> +		if (sleeper)
> +			task = container_of(node, struct task_struct, wake_q_sleeper);
> +		else
> +			task = container_of(node, struct task_struct, wake_q);
>  		BUG_ON(!task);
>  		/* task can safely be re-inserted now */
>  		node = node->next;
> -		task->wake_q.next = NULL;
> +		if (sleeper)
> +			task->wake_q_sleeper.next = NULL;
> +		else
> +			task->wake_q.next = NULL;
>  
>  		/*
>  		 * wake_up_process() implies a wmb() to pair with the queueing
