From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] futex/rtmutex: Cure RT double blocking issue
Date: Tue, 9 May 2017 11:49:01 -0400
Message-ID: <20170509114901.42a6c3eb@gandalf.local.home>
References: <alpine.DEB.2.20.1705091707180.1798@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Engleder Gerhard <eg@keba.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1705091707180.1798@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 May 2017 17:11:10 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> RT has a problem when the wait on a futex/rtmutex got interrupted by a
> timeout or a signal. task->pi_blocked_on is still set when returning from
> rt_mutex_wait_proxy_lock(). The task must acquire the hash bucket lock
> after this.
> 
> If the hash bucket lock is contended then the
> BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
> task_blocks_on_rt_mutex() will trigger.
> 
> This can be avoided by clearing task->pi_blocked_on in the return path of
> rt_mutex_wait_proxy_lock() which removes the task from the boosting chain
> of the rtmutex. That's correct because the task is not longer blocked on

 s/not/no/

> it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Engleder Gerhard <eg@keba.com>
> ---
>  kernel/locking/rtmutex.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -2380,6 +2380,7 @@ int rt_mutex_wait_proxy_lock(struct rt_m
>  			       struct hrtimer_sleeper *to,
>  			       struct rt_mutex_waiter *waiter)
>  {
> +	struct task_struct *tsk = current;
>  	int ret;
>  
>  	raw_spin_lock_irq(&lock->wait_lock);
> @@ -2389,6 +2390,22 @@ int rt_mutex_wait_proxy_lock(struct rt_m
>  	/* sleep on the mutex */
>  	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
>  
> +	/*
> +	 * RT has a problem here when the wait got interrupted by a timeout
> +	 * or a signal. task->pi_blocked_on is still set. The task must
> +	 * acquire the hash bucket lock when returning from this function.
> +	 *
> +	 * If the hash bucket lock is contended then the
> +	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
> +	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
> +	 * clearing task->pi_blocked_on which removes the task from the
> +	 * boosting chain of the rtmutex. That's correct because the task
> +	 * is not longer blocked on it.

  s/not/no/


I looked at the users of pi_blocked_on, and this appears to be fine.
I don't see it used by remove_waiter() where it clears it at the start.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> +	 */
> +	raw_spin_lock(&tsk->pi_lock);
> +	tsk->pi_blocked_on = NULL;
> +	raw_spin_unlock(&tsk->pi_lock);
> +
>  	raw_spin_unlock_irq(&lock->wait_lock);
>  
>  	return ret;
