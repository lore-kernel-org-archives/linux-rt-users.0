From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Thu, 29 Jun 2017 02:30:12 +0200
Message-ID: <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:37319 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdF2AaS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2017 20:30:18 -0400
In-Reply-To: <20170627135750.dezrobqd4twryeeb@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm unable to compile the ndiswrapper extramodule against 4.11.7-rt3

I get lots of errors of the kind

'struct task_struct' has no member named 'cpus_allowed'; did you mean 
'nr_cpus_allowed'?

What can I do?

kind regards
Bernhard


On 27/06/17 15:57, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.11.7-rt3 patch set.
>
> Changes since v4.11.7-rt2:
>
>    - Clearing a swap-slot took a sleeping lock in a preempt-disable
>      region. Fixed by dropping the preempt-disable region.
>
>    - The capability check code on arm64 took a mutex in a atomic section.
>      The backport of a few patches from upstream made this visible and
>      now the fix for this has been also backported.
>
>    - The removal of TASK_ALL in the last release uncovered a bug where we
>      mixed normal wake ups and wake ups made for waiters of sleeping
>      spinlock. Reported by Mike Galbraith.
>
>    - Lock stealing for RTMutex wasn't working in v4.11. Reported and
>      fixed by Mike Galbraith.
>
>    - Code now compiles for RT + !CONFIG_POSIX_TIMERS. Reported by kbuild
>      test robot.
>
> Known issues
> 	- CPU hotplug got a little better but can deadlock.
>
> The delta patch against v4.11.7-rt2 is appended below and can be found here:
>   
>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.7-rt2-rt3.patch.xz
>
> You can get this release via the git tree at:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.7-rt3
>
> The RT patch against v4.11.7 can be found here:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.7-rt3.patch.xz
>
> The split quilt queue is available at:
>
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.7-rt3.tar.xz
>
> Sebastian
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -115,6 +115,7 @@ struct arm64_cpu_capabilities {
>   
>   extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>   extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
> +extern struct static_key_false arm64_const_caps_ready;
>   
>   bool this_cpu_has_cap(unsigned int cap);
>   
> @@ -124,7 +125,7 @@ static inline bool cpu_have_feature(unsigned int num)
>   }
>   
>   /* System capability check for constant caps */
> -static inline bool cpus_have_const_cap(int num)
> +static inline bool __cpus_have_const_cap(int num)
>   {
>   	if (num >= ARM64_NCAPS)
>   		return false;
> @@ -138,6 +139,14 @@ static inline bool cpus_have_cap(unsigned int num)
>   	return test_bit(num, cpu_hwcaps);
>   }
>   
> +static inline bool cpus_have_const_cap(int num)
> +{
> +	if (static_branch_likely(&arm64_const_caps_ready))
> +		return __cpus_have_const_cap(num);
> +	else
> +		return cpus_have_cap(num);
> +}
> +
>   static inline void cpus_set_cap(unsigned int num)
>   {
>   	if (num >= ARM64_NCAPS) {
> @@ -145,7 +154,6 @@ static inline void cpus_set_cap(unsigned int num)
>   			num, ARM64_NCAPS);
>   	} else {
>   		__set_bit(num, cpu_hwcaps);
> -		static_branch_enable(&cpu_hwcap_keys[num]);
>   	}
>   }
>   
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -24,6 +24,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/kvm_types.h>
> +#include <asm/cpufeature.h>
>   #include <asm/kvm.h>
>   #include <asm/kvm_asm.h>
>   #include <asm/kvm_mmio.h>
> @@ -356,9 +357,12 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>   				       unsigned long vector_ptr)
>   {
>   	/*
> -	 * Call initialization code, and switch to the full blown
> -	 * HYP code.
> +	 * Call initialization code, and switch to the full blown HYP code.
> +	 * If the cpucaps haven't been finalized yet, something has gone very
> +	 * wrong, and hyp will crash and burn when it uses any
> +	 * cpus_have_const_cap() wrapper.
>   	 */
> +	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
>   	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
>   }
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -975,8 +975,16 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>    */
>   void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>   {
> -	for (; caps->matches; caps++)
> -		if (caps->enable && cpus_have_cap(caps->capability))
> +	for (; caps->matches; caps++) {
> +		unsigned int num = caps->capability;
> +
> +		if (!cpus_have_cap(num))
> +			continue;
> +
> +		/* Ensure cpus_have_const_cap(num) works */
> +		static_branch_enable(&cpu_hwcap_keys[num]);
> +
> +		if (caps->enable) {
>   			/*
>   			 * Use stop_machine() as it schedules the work allowing
>   			 * us to modify PSTATE, instead of on_each_cpu() which
> @@ -984,6 +992,8 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>   			 * we return.
>   			 */
>   			stop_machine(caps->enable, NULL, cpu_online_mask);
> +		}
> +	}
>   }
>   
>   /*
> @@ -1086,6 +1096,14 @@ static void __init setup_feature_capabilities(void)
>   	enable_cpu_capabilities(arm64_features);
>   }
>   
> +DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
> +EXPORT_SYMBOL(arm64_const_caps_ready);
> +
> +static void __init mark_const_caps_ready(void)
> +{
> +	static_branch_enable(&arm64_const_caps_ready);
> +}
> +
>   /*
>    * Check if the current CPU has a given feature capability.
>    * Should be called from non-preemptible context.
> @@ -1112,6 +1130,7 @@ void __init setup_cpu_features(void)
>   	/* Set the CPU feature capabilies */
>   	setup_feature_capabilities();
>   	enable_errata_workarounds();
> +	mark_const_caps_ready();
>   	setup_elf_hwcaps(arm64_elf_hwcaps);
>   
>   	if (system_supports_32bit_el0())
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -167,7 +167,7 @@ extern struct cred init_cred;
>   # define INIT_PERF_EVENTS(tsk)
>   #endif
>   
> -#ifdef CONFIG_PREEMPT_RT_BASE
> +#if defined(CONFIG_POSIX_TIMERS) && defined(CONFIG_PREEMPT_RT_BASE)
>   # define INIT_TIMER_LIST		.posix_timer_list = NULL,
>   #else
>   # define INIT_TIMER_LIST
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -797,6 +797,7 @@ struct task_struct {
>   	raw_spinlock_t			pi_lock;
>   
>   	struct wake_q_node		wake_q;
> +	struct wake_q_node		wake_q_sleeper;
>   
>   #ifdef CONFIG_RT_MUTEXES
>   	/* PI waiters blocked on a rt_mutex held by this task: */
> diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
> --- a/include/linux/sched/wake_q.h
> +++ b/include/linux/sched/wake_q.h
> @@ -46,8 +46,20 @@ static inline void wake_q_init(struct wake_q_head *head)
>   	head->lastp = &head->first;
>   }
>   
> -extern void wake_q_add(struct wake_q_head *head,
> -		       struct task_struct *task);
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
>   extern void __wake_up_q(struct wake_q_head *head, bool sleeper);
>   static inline void wake_up_q(struct wake_q_head *head)
>   {
> diff --git a/kernel/fork.c b/kernel/fork.c
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -575,6 +575,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>   	tsk->splice_pipe = NULL;
>   	tsk->task_frag.page = NULL;
>   	tsk->wake_q.next = NULL;
> +	tsk->wake_q_sleeper.next = NULL;
>   
>   	account_kernel_stack(tsk, 1);
>   
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -236,26 +236,19 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
>   }
>   #endif
>   
> -#define STEAL_NORMAL  0
> -#define STEAL_LATERAL 1
> -
>   /*
>    * Only use with rt_mutex_waiter_{less,equal}()
>    */
> -#define task_to_waiter(p)	\
> -	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
> +#define task_to_waiter(p) &(struct rt_mutex_waiter) \
> +	{ .prio = (p)->prio, .deadline = (p)->dl.deadline, .task = (p) }
>   
>   static inline int
>   rt_mutex_waiter_less(struct rt_mutex_waiter *left,
> -		     struct rt_mutex_waiter *right, int mode)
> +		     struct rt_mutex_waiter *right)
>   {
> -	if (mode == STEAL_NORMAL) {
> -		if (left->prio < right->prio)
> -			return 1;
> -	} else {
> -		if (left->prio <= right->prio)
> -			return 1;
> -	}
> +	if (left->prio < right->prio)
> +		return 1;
> +
>   	/*
>   	 * If both waiters have dl_prio(), we check the deadlines of the
>   	 * associated tasks.
> @@ -287,6 +280,27 @@ rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
>   	return 1;
>   }
>   
> +#define STEAL_NORMAL  0
> +#define STEAL_LATERAL 1
> +
> +static inline int
> +rt_mutex_steal(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, int mode)
> +{
> +	struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
> +
> +	if (waiter == top_waiter || rt_mutex_waiter_less(waiter, top_waiter))
> +		return 1;
> +
> +	/*
> +	 * Note that RT tasks are excluded from lateral-steals
> +	 * to prevent the introduction of an unbounded latency.
> +	 */
> +	if (mode == STEAL_NORMAL || rt_task(waiter->task))
> +		return 0;
> +
> +	return rt_mutex_waiter_equal(waiter, top_waiter);
> +}
> +
>   static void
>   rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
>   {
> @@ -298,7 +312,7 @@ rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
>   	while (*link) {
>   		parent = *link;
>   		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
> -		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
> +		if (rt_mutex_waiter_less(waiter, entry)) {
>   			link = &parent->rb_left;
>   		} else {
>   			link = &parent->rb_right;
> @@ -337,7 +351,7 @@ rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
>   	while (*link) {
>   		parent = *link;
>   		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
> -		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
> +		if (rt_mutex_waiter_less(waiter, entry)) {
>   			link = &parent->rb_left;
>   		} else {
>   			link = &parent->rb_right;
> @@ -847,6 +861,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
>    * @task:   The task which wants to acquire the lock
>    * @waiter: The waiter that is queued to the lock's wait tree if the
>    *	    callsite called task_blocked_on_lock(), otherwise NULL
> + * @mode:   Lock steal mode (STEAL_NORMAL, STEAL_LATERAL)
>    */
>   static int __try_to_take_rt_mutex(struct rt_mutex *lock,
>   				  struct task_struct *task,
> @@ -886,14 +901,11 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
>   	 */
>   	if (waiter) {
>   		/*
> -		 * If waiter is not the highest priority waiter of
> -		 * @lock, give up.
> +		 * If waiter is not the highest priority waiter of @lock,
> +		 * or its peer when lateral steal is allowed, give up.
>   		 */
> -		if (waiter != rt_mutex_top_waiter(lock)) {
> -			/* XXX rt_mutex_waiter_less() ? */
> +		if (!rt_mutex_steal(lock, waiter, mode))
>   			return 0;
> -		}
> -
>   		/*
>   		 * We can acquire the lock. Remove the waiter from the
>   		 * lock waiters tree.
> @@ -910,25 +922,12 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
>   		 * not need to be dequeued.
>   		 */
>   		if (rt_mutex_has_waiters(lock)) {
> -			struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
> -
> -			if (task != pown)
> -				return 0;
> -
>   			/*
> -			 * Note that RT tasks are excluded from lateral-steals
> -			 * to prevent the introduction of an unbounded latency.
> +			 * If @task->prio is greater than the top waiter
> +			 * priority (kernel view), or equal to it when a
> +			 * lateral steal is forbidden, @task lost.
>   			 */
> -			if (rt_task(task))
> -				mode = STEAL_NORMAL;
> -			/*
> -			 * If @task->prio is greater than or equal to
> -			 * the top waiter priority (kernel view),
> -			 * @task lost.
> -			 */
> -			if (!rt_mutex_waiter_less(task_to_waiter(task),
> -						  rt_mutex_top_waiter(lock),
> -						  mode))
> +			if (!rt_mutex_steal(lock, task_to_waiter(task), mode))
>   				return 0;
>   			/*
>   			 * The current top waiter stays enqueued. We
> @@ -1507,7 +1506,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
>   	 */
>   	preempt_disable();
>   	if (waiter->savestate)
> -		wake_q_add(wake_sleeper_q, waiter->task);
> +		wake_q_add_sleeper(wake_sleeper_q, waiter->task);
>   	else
>   		wake_q_add(wake_q, waiter->task);
>   	raw_spin_unlock(&current->pi_lock);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -437,9 +437,15 @@ static bool set_nr_if_polling(struct task_struct *p)
>   #endif
>   #endif
>   
> -void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> +void __wake_q_add(struct wake_q_head *head, struct task_struct *task,
> +		  bool sleeper)
>   {
> -	struct wake_q_node *node = &task->wake_q;
> +	struct wake_q_node *node;
> +
> +	if (sleeper)
> +		node = &task->wake_q_sleeper;
> +	else
> +		node = &task->wake_q;
>   
>   	/*
>   	 * Atomically grab the task, if ->wake_q is !nil already it means
> @@ -468,12 +474,17 @@ void __wake_up_q(struct wake_q_head *head, bool sleeper)
>   	while (node != WAKE_Q_TAIL) {
>   		struct task_struct *task;
>   
> -		task = container_of(node, struct task_struct, wake_q);
> +		if (sleeper)
> +			task = container_of(node, struct task_struct, wake_q_sleeper);
> +		else
> +			task = container_of(node, struct task_struct, wake_q);
>   		BUG_ON(!task);
>   		/* Task can safely be re-inserted now: */
>   		node = node->next;
> -		task->wake_q.next = NULL;
> -
> +		if (sleeper)
> +			task->wake_q_sleeper.next = NULL;
> +		else
> +			task->wake_q.next = NULL;
>   		/*
>   		 * wake_up_process() implies a wmb() to pair with the queueing
>   		 * in wake_q_add() so as not to miss wakeups.
> diff --git a/localversion-rt b/localversion-rt
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt2
> +-rt3
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -267,11 +267,11 @@ int free_swap_slot(swp_entry_t entry)
>   {
>   	struct swap_slots_cache *cache;
>   
> -	cache = &get_cpu_var(swp_slots);
> +	cache = raw_cpu_ptr(&swp_slots);
>   	if (use_swap_slot_cache && cache->slots_ret) {
>   		spin_lock_irq(&cache->free_lock);
>   		/* Swap slots cache may be deactivated before acquiring lock */
> -		if (!use_swap_slot_cache) {
> +		if (!use_swap_slot_cache || !cache->slots_ret) {
>   			spin_unlock_irq(&cache->free_lock);
>   			goto direct_free;
>   		}
> @@ -291,7 +291,6 @@ int free_swap_slot(swp_entry_t entry)
>   direct_free:
>   		swapcache_free_entries(&entry, 1);
>   	}
> -	put_cpu_var(swp_slots);
>   
>   	return 0;
>   }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

