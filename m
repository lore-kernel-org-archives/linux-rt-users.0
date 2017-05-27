From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.9.30-rt20
Date: Sat, 27 May 2017 19:19:51 +0200
Message-ID: <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
References: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thanks a lot as always!
I have a question regarding packager keys:
It seems this time the patch has been signed with a different key than 
usual:

unknown public key 4FE5E3262872E4CC

Could you please let me know where you packager keys can be looked up?
Thanks

regards
Bernhard


On 27/05/17 18:32, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.9.30-rt20 patch set.
>
> Changes since v4.9.30-rt19:
>
>    - The patch "timers: Don't wake ktimersoftd on every tick" has been
>      reverted because this optimisation can lead to timers not getting
>      expired. Reported by Klaus Gusenleitner, debugged by Anna-Maria
>      Gleixner.
>
>    - Markus Trippelsdorf reported that the new futex code makes the
>      glibc/nptl/tst-robustpi8 test fail. Patch by Peter Zijlstra.
>
> Known issues
> 	- CPU hotplug got a little better but can deadlock.
>
> 	- gdb. While gdb is following a task it is possible that after a
> 	  fork() operation the task is waiting for gdb and gdb waiting
> 	  for the task.
>
> The delta patch against v4.9.30-rt19 is appended below and can be found here:
>   
>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.30-rt19-rt20.patch.xz
>
> You can get this release via the git tree at:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.30-rt20
>
> The RT patch against v4.9.30 can be found here:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.30-rt20.patch.xz
>
> The split quilt queue is available at:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.30-rt20.tar.xz
>
> Sebastian
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -2400,11 +2400,14 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
>   	int ret;
>   
>   	raw_spin_lock_irq(&lock->wait_lock);
> -
> -	set_current_state(TASK_INTERRUPTIBLE);
> -
>   	/* sleep on the mutex */
> +	set_current_state(TASK_INTERRUPTIBLE);
>   	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
> +	/*
> +	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
> +	 * have to fix that up.
> +	 */
> +	fixup_rt_mutex_waiters(lock);
>   
>   	/*
>   	 * RT has a problem here when the wait got interrupted by a timeout
> @@ -2423,7 +2426,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
>   		tsk->pi_blocked_on = NULL;
>   		raw_spin_unlock(&tsk->pi_lock);
>   	}
> -
>   	raw_spin_unlock_irq(&lock->wait_lock);
>   
>   	return ret;
> @@ -2455,15 +2457,25 @@ bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
>   
>   	raw_spin_lock_irq(&lock->wait_lock);
>   	/*
> +	 * Do an unconditional try-lock, this deals with the lock stealing
> +	 * state where __rt_mutex_futex_unlock() -> mark_wakeup_next_waiter()
> +	 * sets a NULL owner.
> +	 *
> +	 * We're not interested in the return value, because the subsequent
> +	 * test on rt_mutex_owner() will infer that. If the trylock succeeded,
> +	 * we will own the lock and it will have removed the waiter. If we
> +	 * failed the trylock, we're still not owner and we need to remove
> +	 * ourselves.
> +	 */
> +	try_to_take_rt_mutex(lock, current, waiter);
> +	/*
>   	 * Unless we're the owner; we're still enqueued on the wait_list.
>   	 * So check if we became owner, if not, take us off the wait_list.
>   	 */
>   	if (rt_mutex_owner(lock) != current) {
>   		remove_waiter(lock, waiter);
> -		fixup_rt_mutex_waiters(lock);
>   		cleanup = true;
>   	}
> -
>   	/*
>   	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
>   	 * have to fix that up.
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -206,8 +206,6 @@ struct timer_base {
>   	bool			is_idle;
>   	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
>   	struct hlist_head	vectors[WHEEL_SIZE];
> -	struct hlist_head	expired_lists[LVL_DEPTH];
> -	int			expired_count;
>   } ____cacheline_aligned;
>   
>   static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
> @@ -1355,8 +1353,7 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
>   	}
>   }
>   
> -static inline void __expire_timers(struct timer_base *base,
> -				   struct hlist_head *head)
> +static void expire_timers(struct timer_base *base, struct hlist_head *head)
>   {
>   	while (!hlist_empty(head)) {
>   		struct timer_list *timer;
> @@ -1387,38 +1384,21 @@ static inline void __expire_timers(struct timer_base *base,
>   	}
>   }
>   
> -static void expire_timers(struct timer_base *base)
> -{
> -	struct hlist_head *head;
> -
> -	while (base->expired_count--) {
> -		head = base->expired_lists + base->expired_count;
> -		__expire_timers(base, head);
> -	}
> -	base->expired_count = 0;
> -}
> -
> -static void __collect_expired_timers(struct timer_base *base)
> +static int __collect_expired_timers(struct timer_base *base,
> +				    struct hlist_head *heads)
>   {
>   	unsigned long clk = base->clk;
>   	struct hlist_head *vec;
> -	int i;
> +	int i, levels = 0;
>   	unsigned int idx;
>   
> -	/*
> -	 * expire_timers() must be called at least once before we can
> -	 * collect more timers
> -	 */
> -	if (WARN_ON(base->expired_count))
> -		return;
> -
>   	for (i = 0; i < LVL_DEPTH; i++) {
>   		idx = (clk & LVL_MASK) + i * LVL_SIZE;
>   
>   		if (__test_and_clear_bit(idx, base->pending_map)) {
>   			vec = base->vectors + idx;
> -			hlist_move_list(vec,
> -				&base->expired_lists[base->expired_count++]);
> +			hlist_move_list(vec, heads++);
> +			levels++;
>   		}
>   		/* Is it time to look at the next level? */
>   		if (clk & LVL_CLK_MASK)
> @@ -1426,6 +1406,7 @@ static void __collect_expired_timers(struct timer_base *base)
>   		/* Shift clock for the next level granularity */
>   		clk >>= LVL_CLK_SHIFT;
>   	}
> +	return levels;
>   }
>   
>   #ifdef CONFIG_NO_HZ_COMMON
> @@ -1618,7 +1599,8 @@ void timer_clear_idle(void)
>   	base->is_idle = false;
>   }
>   
> -static void collect_expired_timers(struct timer_base *base)
> +static int collect_expired_timers(struct timer_base *base,
> +				  struct hlist_head *heads)
>   {
>   	/*
>   	 * NOHZ optimization. After a long idle sleep we need to forward the
> @@ -1635,49 +1617,20 @@ static void collect_expired_timers(struct timer_base *base)
>   		if (time_after(next, jiffies)) {
>   			/* The call site will increment clock! */
>   			base->clk = jiffies - 1;
> -			return;
> +			return 0;
>   		}
>   		base->clk = next;
>   	}
> -	__collect_expired_timers(base);
> +	return __collect_expired_timers(base, heads);
>   }
>   #else
> -static inline void collect_expired_timers(struct timer_base *base)
> +static inline int collect_expired_timers(struct timer_base *base,
> +					 struct hlist_head *heads)
>   {
> -	__collect_expired_timers(base);
> +	return __collect_expired_timers(base, heads);
>   }
>   #endif
>   
> -static int find_expired_timers(struct timer_base *base)
> -{
> -	const unsigned long int end_clk = jiffies;
> -
> -	while (!base->expired_count && time_after_eq(end_clk, base->clk)) {
> -		collect_expired_timers(base);
> -		base->clk++;
> -	}
> -
> -	return base->expired_count;
> -}
> -
> -/* Called from CPU tick routine to quickly collect expired timers */
> -static int tick_find_expired(struct timer_base *base)
> -{
> -	int count;
> -
> -	raw_spin_lock(&base->lock);
> -
> -	if (unlikely(time_after(jiffies, base->clk + HZ))) {
> -		/* defer to ktimersoftd; don't spend too long in irq context */
> -		count = -1;
> -	} else
> -		count = find_expired_timers(base);
> -
> -	raw_spin_unlock(&base->lock);
> -
> -	return count;
> -}
> -
>   /*
>    * Called from the timer interrupt handler to charge one tick to the current
>    * process.  user_tick is 1 if the tick is user time, 0 for system.
> @@ -1704,11 +1657,22 @@ void update_process_times(int user_tick)
>    */
>   static inline void __run_timers(struct timer_base *base)
>   {
> +	struct hlist_head heads[LVL_DEPTH];
> +	int levels;
> +
> +	if (!time_after_eq(jiffies, base->clk))
> +		return;
> +
>   	raw_spin_lock_irq(&base->lock);
>   
> -	while (find_expired_timers(base))
> -		expire_timers(base);
> +	while (time_after_eq(jiffies, base->clk)) {
>   
> +		levels = collect_expired_timers(base, heads);
> +		base->clk++;
> +
> +		while (levels--)
> +			expire_timers(base, heads + levels);
> +	}
>   	raw_spin_unlock_irq(&base->lock);
>   	wakeup_timer_waiters(base);
>   }
> @@ -1736,12 +1700,12 @@ void run_local_timers(void)
>   
>   	hrtimer_run_queues();
>   	/* Raise the softirq only if required. */
> -	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
> +	if (time_before(jiffies, base->clk)) {
>   		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
>   			return;
>   		/* CPU is awake, so check the deferrable base. */
>   		base++;
> -		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
> +		if (time_before(jiffies, base->clk))
>   			return;
>   	}
>   	raise_softirq(TIMER_SOFTIRQ);
> @@ -1911,7 +1875,6 @@ int timers_dead_cpu(unsigned int cpu)
>   		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
>   
>   		BUG_ON(old_base->running_timer);
> -		BUG_ON(old_base->expired_count);
>   
>   		for (i = 0; i < WHEEL_SIZE; i++)
>   			migrate_timer_list(new_base, old_base->vectors + i);
> @@ -1938,7 +1901,6 @@ static void __init init_timer_cpu(int cpu)
>   #ifdef CONFIG_PREEMPT_RT_FULL
>   		init_swait_queue_head(&base->wait_for_running_timer);
>   #endif
> -		base->expired_count = 0;
>   	}
>   }
>   
> diff --git a/localversion-rt b/localversion-rt
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt19
> +-rt20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
