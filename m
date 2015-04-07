From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Mon, 6 Apr 2015 21:59:59 -0400
Message-ID: <20150406215959.4e8ad37b@grimm.local.home>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	<1428369962-74723-1-git-send-email-tmac@hp.com>
	<1428369962-74723-2-git-send-email-tmac@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:29950 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752935AbbDGCAH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2015 22:00:07 -0400
In-Reply-To: <1428369962-74723-2-git-send-email-tmac@hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon,  6 Apr 2015 19:26:01 -0600
Thavatchai Makphaibulchoke <tmac@hp.com> wrote:

> This patch fixes the problem that the ownership of a mutex acquired by an
> interrupt handler(IH) gets incorrectly attributed to the interrupted thread.
> 
> This could result in an incorrect deadlock detection in function
> rt_mutex_adjust_prio_chain(), causing thread to be killed and possibly leading
> up to a system hang.
> 
> Here is the approach taken: when calling from an interrupt handler, instead of
> attributing ownership to the interrupted task, use the idle task on the processor
> to indicate that the owner is a interrupt handler.  This approach avoids the
> above incorrect deadlock detection.
> 
> This also includes changes to disable priority boosting when lock owner is
> the idle_task, as it is not allowed.

Hmm, why is it not allowed?

If we just let it boost it, it will cut down on the code changes and
checks that add to the hot paths.

> 
> Kernel version 3.14.25 + patch-3.14.25-rt22
> 
> Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
> ---
> Changed in v2:
>         - Use idle_task on the processor as rtmutex's owner instead of the
>           reserved interrupt handler task value.
>         - Removed code to hadle the reserved interrupt handler's task value.
>  kernel/locking/rtmutex.c | 77 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 6c40660..ae5c13f 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -26,6 +26,9 @@
>  
>  #include "rtmutex_common.h"
>  
> +static int __sched __rt_mutex_trylock(struct rt_mutex *lock,
> +		struct task_struct *caller);
> +
>  /*
>   * lock->owner state tracking:
>   *
> @@ -51,6 +54,9 @@
>   * waiters. This can happen when grabbing the lock in the slow path.
>   * To prevent a cmpxchg of the owner releasing the lock, we need to
>   * set this bit before looking at the lock.
> + *
> + * Owner can also be reserved value, INTERRUPT_HANDLER. In this case the mutex
> + * is owned by idle_task on the processor.
>   */
>  
>  static void
> @@ -298,7 +304,7 @@ static void __rt_mutex_adjust_prio(struct task_struct *task)
>  {
>  	int prio = rt_mutex_getprio(task);
>  
> -	if (task->prio != prio || dl_prio(prio))
> +	if (!is_idle_task(task) && (task->prio != prio || dl_prio(prio)))
>  		rt_mutex_setprio(task, prio);
>  }
>  
> @@ -730,7 +736,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
>  	if (waiter == rt_mutex_top_waiter(lock)) {
>  		rt_mutex_dequeue_pi(owner, top_waiter);
>  		rt_mutex_enqueue_pi(owner, waiter);
> -

I don't think this whitespace change needs to be done. The space does
split up the dequeue and enqueue from the rest.

>  		__rt_mutex_adjust_prio(owner);
>  		if (rt_mutex_real_waiter(owner->pi_blocked_on))
>  			chain_walk = 1;
> @@ -777,10 +782,11 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
>   */
>  static void wakeup_next_waiter(struct rt_mutex *lock)
>  {
> +	struct task_struct *owner = rt_mutex_owner(lock);
>  	struct rt_mutex_waiter *waiter;
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&current->pi_lock, flags);
> +	raw_spin_lock_irqsave(&owner->pi_lock, flags);
>  
>  	waiter = rt_mutex_top_waiter(lock);
>  
> @@ -790,7 +796,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
>  	 * boosted mode and go back to normal after releasing
>  	 * lock->wait_lock.
>  	 */
> -	rt_mutex_dequeue_pi(current, waiter);
> +	rt_mutex_dequeue_pi(owner, waiter);
>  
>  	/*
>  	 * As we are waking up the top waiter, and the waiter stays
> @@ -802,7 +808,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
>  	 */
>  	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
>  
> -	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
> +	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
>  
>  	/*
>  	 * It's safe to dereference waiter as it cannot go away as
> @@ -902,6 +908,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
>  static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
>  					 void  (*slowfn)(struct rt_mutex *lock))
>  {
> +	/* Might sleep, should not be called in interrupt context. */
> +	BUG_ON(in_interrupt());

You're right it shouldn't. But that's why might_sleep() will give us a
nice big warning if it is. Don't add the BUG_ON().

>  	might_sleep();
>  
>  	if (likely(rt_mutex_cmpxchg(lock, NULL, current)))
> @@ -911,12 +919,12 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
>  }
>  
>  static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
> -					   void  (*slowfn)(struct rt_mutex *lock))
> +	void (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
>  {
>  	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
>  		rt_mutex_deadlock_account_unlock(current);
>  	else
> -		slowfn(lock);
> +		slowfn(lock, current);
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -1047,11 +1055,12 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
>  /*
>   * Slow path to release a rt_mutex spin_lock style
>   */
> -static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock)
> +static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock,
> +	struct task_struct *task)
>  {
>  	debug_rt_mutex_unlock(lock);
>  
> -	rt_mutex_deadlock_account_unlock(current);
> +	rt_mutex_deadlock_account_unlock(task);
>  
>  	if (!rt_mutex_has_waiters(lock)) {
>  		lock->owner = NULL;
> @@ -1064,24 +1073,33 @@ static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock)
>  	raw_spin_unlock(&lock->wait_lock);
>  
>  	/* Undo pi boosting.when necessary */
> -	rt_mutex_adjust_prio(current);
> +	rt_mutex_adjust_prio(task);
>  }
>  
> -static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
> +static noinline void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock,
> +	struct task_struct *task)
>  {
>  	raw_spin_lock(&lock->wait_lock);
> -	__rt_spin_lock_slowunlock(lock);
> +	__rt_spin_lock_slowunlock(lock, task);
>  }
>  
> -static void  noinline __sched rt_spin_lock_slowunlock_hirq(struct rt_mutex *lock)
> +static inline void rt_spin_lock_fastunlock_in_irq(struct rt_mutex *lock,

Why the name change?

> +	void (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
>  {
>  	int ret;
> +	struct task_struct *intr_owner = current;
>  
> +	if (unlikely(in_irq()))

Why unlikely? This should only be called in interrupt context.

In fact, perhaps we should have a:

	WARN_ON(!in_irq());

Then we don't need this test at all, and just assign the owner the idle
task.

> +		intr_owner = idle_task(smp_processor_id());

Also, never butt a single if statement up against another if statement.
Add a space, otherwise it gives the impression of being an
  if () else if ()

> +	if (likely(rt_mutex_cmpxchg(lock, intr_owner, NULL))) {
> +		rt_mutex_deadlock_account_unlock(intr_owner);
> +		return;
> +	}

And add a space here. Don't butt conditionals together unless they are
related (if else if, etc)

>  	do {
>  		ret = raw_spin_trylock(&lock->wait_lock);
>  	} while (!ret);

I know this isn't part of the patch, but that do loop needs a comment
(this is more toward Sebastian, and not you). It looks buggy, and I
think we do it this way just so that lockdep doesn't complain. We need
a comment here that states something like:

	/*
	 * To get this rt_mutex from interrupt context, we had to have
	 * taken the wait_lock once before. Thus, nothing can deadlock
	 * us now. The wait_lock is internal to the rt_mutex, and
	 * anything that may have it now, will soon release it, because
	 * we own the rt_mutex but do not hold anything that the owner
	 * of the wait_lock would need to grab.
	 *
	 * The do { } while() is to keep lockdep from complaining.
	 */

I wonder if there's another way to just take the wait_lock and tell
lockdep not to complain?

Peter?

>  
> -	__rt_spin_lock_slowunlock(lock);
> +	slowfn(lock, intr_owner);
>  }
>  
>  void __lockfunc rt_spin_lock(spinlock_t *lock)
> @@ -1118,7 +1136,7 @@ void __lockfunc rt_spin_unlock_after_trylock_in_irq(spinlock_t *lock)
>  {
>  	/* NOTE: we always pass in '1' for nested, for simplicity */
>  	spin_release(&lock->dep_map, 1, _RET_IP_);
> -	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_hirq);
> +	rt_spin_lock_fastunlock_in_irq(&lock->lock, __rt_spin_lock_slowunlock);
>  }
>  
>  void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
> @@ -1146,8 +1164,12 @@ int __lockfunc __rt_spin_trylock(struct rt_mutex *lock)
>  
>  int __lockfunc rt_spin_trylock(spinlock_t *lock)

We really should have a rt_spin_trylock_in_irq() and not have the
below if conditional.

The paths that will be executed in hard irq context are static. They
should be labeled as such.

-- Steve

>  {
> -	int ret = rt_mutex_trylock(&lock->lock);
> +	struct task_struct *intr_owner = current;
> +	int ret;
>  
> +	if (unlikely(in_irq()))
> +		intr_owner = idle_task(smp_processor_id());
> +	ret = __rt_mutex_trylock(&lock->lock, intr_owner);
>  	if (ret)
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>  	return ret;
> @@ -1466,16 +1488,16 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
>   * Slow path try-lock function:
>   */
>  static inline int
> -rt_mutex_slowtrylock(struct rt_mutex *lock)
> +rt_mutex_slowtrylock(struct rt_mutex *lock, struct task_struct *task)
>  {
>  	int ret = 0;
>  
>  	if (!raw_spin_trylock(&lock->wait_lock))
>  		return ret;
>  
> -	if (likely(rt_mutex_owner(lock) != current)) {
> +	if (likely(rt_mutex_owner(lock) != task)) {
>  
> -		ret = try_to_take_rt_mutex(lock, current, NULL);
> +		ret = try_to_take_rt_mutex(lock, task, NULL);
>  		/*
>  		 * try_to_take_rt_mutex() sets the lock waiters
>  		 * bit unconditionally. Clean this up.
> @@ -1589,14 +1611,14 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
>  }
>  
>  static inline int
> -rt_mutex_fasttrylock(struct rt_mutex *lock,
> -		     int (*slowfn)(struct rt_mutex *lock))
> +rt_mutex_fasttrylock(struct rt_mutex *lock, struct task_struct *caller,
> +	int (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
>  {
> -	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
> -		rt_mutex_deadlock_account_lock(lock, current);
> +	if (likely(rt_mutex_cmpxchg(lock, NULL, caller))) {
> +		rt_mutex_deadlock_account_lock(lock, caller);
>  		return 1;
>  	}
> -	return slowfn(lock);
> +	return slowfn(lock, caller);
>  }
>  
>  static inline void
> @@ -1690,6 +1712,11 @@ rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout,
>  }
>  EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
>  
> +static int __sched __rt_mutex_trylock(struct rt_mutex *lock,
> +		struct task_struct *caller)
> +{
> +	return rt_mutex_fasttrylock(lock, caller, rt_mutex_slowtrylock);
> +}
>  /**
>   * rt_mutex_trylock - try to lock a rt_mutex
>   *
> @@ -1699,7 +1726,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
>   */
>  int __sched rt_mutex_trylock(struct rt_mutex *lock)
>  {
> -	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
> +	return __rt_mutex_trylock(lock, current);
>  }
>  EXPORT_SYMBOL_GPL(rt_mutex_trylock);
>  

