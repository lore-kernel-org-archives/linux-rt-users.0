From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v2] timers: Don't wake ktimersoftd on every tick
Date: Thu, 3 Aug 2017 16:04:18 -0500
Message-ID: <1f71fbdb-810a-06b8-c652-d8b560f64e2a@ni.com>
References: <alpine.DEB.2.20.1706041558150.2813@nanos>
 <20170717220430.20117-1-haris.okanovic@ni.com>
 <alpine.DEB.2.20.1707182206110.2425@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, bigeasy@linutronix.de, julia.cartwright@ni.com,
        gratian.crisan@ni.com, anna-maria@linutronix.de
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1707182206110.2425@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

Apologies on the late response. I've been busy last few weeks.

On 07/18/2017 04:33 PM, Thomas Gleixner wrote:
> On Mon, 17 Jul 2017, Haris Okanovic wrote:
>> We recently upgraded from 4.1 to 4.6 and noticed a minor latency
>> regression caused by an additional thread wakeup (ktimersoftd) in
>> interrupt context on every tick. The wakeups are from
>> run_local_timers() raising TIMER_SOFTIRQ. Both TIMER and SCHED softirq
>> coalesced into one ksoftirqd wakeup prior to Sebastian's change to split
>> timers into their own thread.
>>
>> There's already logic in run_local_timers() to avoid some unnecessary
>> wakeups of ksoftirqd, but it doesn't seems to catch them all. In
>> particular, I've seen many unnecessary wakeups when jiffies increments
>> prior to run_local_timers().
>>
>> Change the way timers are collected per Julia and Thomas'
>> recommendation: Expired timers are now collected in interrupt context
>> and fired in ktimersoftd to avoid double-walk of `pending_map`.
>>
>> Collect expired timers in interrupt context to avoid overhead of waking
>> ktimersoftd on every tick. ktimersoftd now wakes only when one or more
>> timers are ready, which yields a minor reduction in small latency spikes.
>>
>> This is implemented by storing lists of expired timers in timer_base,
>> updated on each tick. Any addition to the lists wakes ktimersoftd
>> (softirq) to process those timers.
> 
> One thing which would be really good to have in the changelog is the
> overhead of that collection operation in hard irq context.
> 

Added testing note: Execution time of run_local_timers() increases by 
0.2us to 2.5us as measured by TSC on a 2core Intel Atom E3825 system.

I'm guessing the variance is spin lock contention caused by timers being 
added/removed by different threads.

I also verified the average case latency decrease in cyclictest and 
reran Anna-Maria's test on a qemu 4core Nehalem VM; latency decreases 
and no stalls.

>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 5730d42bfd67..e5b537f2308c 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -209,9 +209,12 @@ struct timer_base {
>>   	bool			is_idle;
>>   	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
>>   	struct hlist_head	vectors[WHEEL_SIZE];
>> +	struct hlist_head	expired_lists[LVL_DEPTH];
>> +	int			expired_count;
> 
> You need to look at the cache layout of that whole thing. My gut feeling
> tells me that that count is at the wrong place.
> 

You're right, there's a 4-byte hole after `lock` we can use. I'll move
`expired_count` there.

>>   } ____cacheline_aligned;
>>   
>>   static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
>> +static DEFINE_PER_CPU(int, block_softirqs);
> 
> Why are you putting that into a seperate per cpu variable instead of adding
> a bool to the base struct as I suggested in my example:
> 
>         base->softirq_activated = false;
> 
> Having that separate makes no sense conceptually and cache wise it can
> force to touch yet another cacheline depending on the placement by
> compiler/linker. Looking at your implementation it does in 100% of the
> cases.
> 
> You can use the first base for that, as that is going to be touched anyway
> and is cache hot in any case.
> 

I was trying to avoid using twice as much memory in the NOHZ case and
didn't consider cache implications. There's actually another 1-byte hole
after `timer_base.is_idle` which can fit this bool.

>> -static void expire_timers(struct timer_base *base, struct hlist_head *head)
>> +static inline void __expire_timers(struct timer_base *base,
> 
> What's the purpose of this change? If it makes sense to inline it, then the
> compiler will do so.
> 

I inlined it because it only has one call site, but I'm sure the
compiler will figure that out as well. Dropped.

>> +				   struct hlist_head *head)
>>   {
>>   	while (!hlist_empty(head)) {
>>   		struct timer_list *timer;
>> @@ -1344,21 +1348,45 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
>>   	}
>>   }
>>   
>> -static int __collect_expired_timers(struct timer_base *base,
>> -				    struct hlist_head *heads)
>> +static void expire_timers(struct timer_base *base)
>>   {
>> -	unsigned long clk = base->clk;
>> +	struct hlist_head *head;
>> +	int count = READ_ONCE(base->expired_count);
> 
> Please keep the reverse fir tree ordering based on length for the variables
> as we have it throughout that code.
> 

Moved clk.

>> +
>> +	while (count--) {
> 
> So this changed vs. the previous implementation and in this case the
> READ_ONCE() is pointless as the compiler CANNOT reevaluate base->foo inside
> that loop.
> 

Removed.

>> +		head = base->expired_lists + count;
>> +		__expire_timers(base, head);
>> +	}
>> +
>> +	/* Zero base->expired_count after processing all base->expired_lists
>> +	 * to signal it's ready to get re-populated. Otherwise, we race with
>> +	 * tick_find_expired() when base->lock is temporarily dropped in
>> +	 * __expire_timers() */
> 
> Please stick to the two sane comment styles:
> 
>         /* Single line comment */
> 
>         /*
>          * Multi line comment
>          * Multi line comment
>          * Multi line comment
> 	*/
> 
> For further enlightment: http://marc.info/?l=linux-kernel&m=146799838429328&w=2
> 

Fixed.

>> +	base->expired_count = 0;
>> +}
>> +
>> +static int __collect_expired_timers(struct timer_base *base)
>> +{
>> +	unsigned long clk;
>>   	struct hlist_head *vec;
>> -	int i, levels = 0;
>> +	int i;
>>   	unsigned int idx;
> 
> See above
> 
>> +	/*
>> +	 * expire_timers() must be called at least once before we can
>> +	 * collect more timers
>> +	 */
>> +	if (base->expired_count)
>> +		goto end;
>> +
>> +	clk = base->clk;
>>   	for (i = 0; i < LVL_DEPTH; i++) {
>>   		idx = (clk & LVL_MASK) + i * LVL_SIZE;
>>   
>>   		if (__test_and_clear_bit(idx, base->pending_map)) {
>>   			vec = base->vectors + idx;
>> -			hlist_move_list(vec, heads++);
>> -			levels++;
>> +			hlist_move_list(vec,
>> +				&base->expired_lists[base->expired_count++]);
> 
> Eew. What's wrong with local variables ?
> 
>       struct hist_head *list = &base->expired_vectors;
> 
> at the top of this function and then do
> 
> 			hlist_move_list(vec, list++);
> 			base->expired_levels++;
> 
> or have a local count and use it as index to list[]. The code generation
> should be roughly the same, but I expect it to be better with the seperate
> increments.
> 

Done, looks nicer. I was trying to keep changes to existing code minimal.

>>   		}
>>   		/* Is it time to look at the next level? */
>>   		if (clk & LVL_CLK_MASK)
>> @@ -1366,7 +1394,8 @@ static int __collect_expired_timers(struct timer_base *base,
>>   		/* Shift clock for the next level granularity */
>>   		clk >>= LVL_CLK_SHIFT;
>>   	}
>> -	return levels;
>> +
>> +	end: return base->expired_count;
> 
> More Eeew! Can you please look how labels are placed in the
> kernel. Certainly not that way.
> 
> Aside of that the goto is silly. You can just return expired_count up at
> that conditional, or move the conditional to the caller.
> 

Replaced goto with simple return.

> Actually I do not understand that conditional at the top at all. The call
> site breaks out of the loop when the return value is > 0. So what's that
> for? Paranoia? If that's the case then you want a WARN_ONCE there, because
> that should never happen. Otherwise it's just pointless. If actually
> something relies on that, then it's disgusting.
> 
Paranoia. We should never hit this case unless TIMER_SOFTIRQ got raised
without expired timers. Added WARN_ONCE().

>>   }
>>   
>>   #ifdef CONFIG_NO_HZ_COMMON
>> @@ -1559,8 +1588,7 @@ void timer_clear_idle(void)
>>   	base->is_idle = false;
>>   }
>>   
>> -static int collect_expired_timers(struct timer_base *base,
>> -				  struct hlist_head *heads)
>> +static int collect_expired_timers(struct timer_base *base)
>>   {
>>   	/*
>>   	 * NOHZ optimization. After a long idle sleep we need to forward the
>> @@ -1581,16 +1609,41 @@ static int collect_expired_timers(struct timer_base *base,
>>   		}
>>   		base->clk = next;
>>   	}
>> -	return __collect_expired_timers(base, heads);
>> +	return __collect_expired_timers(base);
>>   }
>>   #else
>> -static inline int collect_expired_timers(struct timer_base *base,
>> -					 struct hlist_head *heads)
>> +static inline int collect_expired_timers(struct timer_base *base)
>>   {
>> -	return __collect_expired_timers(base, heads);
>> +	return __collect_expired_timers(base);
>>   }
>>   #endif
>>   
>> +/* Increments timer_base to current jiffies or until first expired
>> + * timer is found. Return number of expired timers. */
> 
> Sigh.
> 

Fixed comment formatting.

>> +static int find_expired_timers(struct timer_base *base)
>> +{
>> +	const unsigned long int end_clk = jiffies;
> 
> const ? unsigned long int ?
> 

Dropped the const. Didn't realize it violated a coding convention.

>> +	int expired_count;
>> +
>> +	while ( !(expired_count = collect_expired_timers(base)) &&
>> +			time_after_eq(end_clk, base->clk) ) {
> 
> These extra white spaces after ( and before ) are pointless and not kernel
> coding style.
> 
> What's worse is the order of your conditionals. Just look at the original
> code.
> 
>> +		base->clk++;
>> +	}
> 

Fixed.

> Aside of that this loop is fricking hard to read.
> 
> 	int levels = 0;
> 
> 	while (!levels && time_after_eq(jiffies, base->clk)) {
> 	      levels = collect_expired_timers(base, heads);
> 	      base->clk++;
> 	}
> 	
> 	return levels;
> 
> Is all what you need here, right? That's what the original loop does as
> well.
> 

Correct, but the original loop was in __run_timers() and this one is 
called from both __run_timers() and run_local_timers(), which is why I 
moved it to a separate function.

>> +
>> +	return expired_count;
>> +}
>> +
>> +/* Called from CPU tick routine to collect expired timers up to current
>> + * jiffies. Return number of expired timers. */
> 
> Wrong. It returns the number of levels which have expired timers. The
> number of actual timers per level is unknown as we move the complete list.
> 

Fixed comment.

>> +static int tick_find_expired(struct timer_base *base)
>> +{
>> +	int count;
> 
> Missing new line between declaration and code. checkpatch.pl is wrong on a
> lot of things, but it would have told you.
> 

Fixed.

>> +	raw_spin_lock(&base->lock);
>> +	count = find_expired_timers(base);
>> +	raw_spin_unlock(&base->lock);
>> +	return count;
> 
> Please be consistent with the names. We use 'levels' throughout all the other
> functions. Random variable names are just confusing.
> 

Renamed "count" to "levels" in timer_base and various functions.

>> +}
>> +
>>   /*
>>    * Called from the timer interrupt handler to charge one tick to the current
>>    * process.  user_tick is 1 if the tick is user time, 0 for system.
>> @@ -1618,22 +1671,11 @@ void update_process_times(int user_tick)
>>    */
>>   static inline void __run_timers(struct timer_base *base)
>>   {
>> -	struct hlist_head heads[LVL_DEPTH];
>> -	int levels;
>> -
>> -	if (!time_after_eq(jiffies, base->clk))
>> -		return;
>> -
>>   	raw_spin_lock_irq(&base->lock);
>>   
>> -	while (time_after_eq(jiffies, base->clk)) {
>> +	while (find_expired_timers(base))
>> +		expire_timers(base);
> 
> Now I understand that extra conditional above. That's crap, really. Two
> ways to solve that:
> 
> 	do {
>         		expire_timers(base);
> 	} while (find_expired_timers(base));
> 
> 	which requires a check for base->expired_levels inside of
> 	expire_timers().
> 
> or
> 
>         if (base->expired_levels)
>         		expire_timers(base);
> 
> 	while (find_expired_timers(base))
>         		expire_timers(base);
> 

The do-while approach works for me. expire_timers() already noops when
expired_levels is zero. However, I would like to keep the
WARN_ONCE(expired_levels) check in __collect_expired_timers() as a
sanity check.

>>   	raw_spin_unlock_irq(&base->lock);
>>   	wakeup_timer_waiters(base);
> 
> Errm. Please submit patches against mainline. This is RT only. On mainline
> the overhead of raising the softirq is not that big, but the exercise is
> the same.
> 

I have been submitting to both mailing lists simultaneously.

>> @@ -1644,12 +1686,16 @@ static inline void __run_timers(struct timer_base *base)
>>   static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>>   {
>>   	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>> +	int* block_softirq = this_cpu_ptr(&block_softirqs);
> 
> Sigh. A pointer is declared with:
> 
> 	int *p;
> 
> and not
> 
> 	int* p;
> 
>>   	irq_work_tick_soft();
>>   
>>   	__run_timers(base);
>>   	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
>>   		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
>> +
>> +	/* Allow new TIMER_SOFTIRQs to get scheduled by run_local_timers() */
>> +	WRITE_ONCE(*block_softirq, 0);
> 
> You are in interrupt enabled code here. So you actually might miss a wakeup
> and delay it to the next tick. If that's your intention then please
> document it proper. If not, you need to disable interrupts around the write
> and recheck stuff.
> 

I'm not sure what you mean exaclty. My intention here is to only permit 
new TIMER_SOFTIRQs to get raised by run_local_timers(). See updated 
commit message for details.

> Also the WRITE_ONCE() is pointless. The compiler cannot reorder the
> write. And it does not protect you from racing with the hard interrupt. So
> for the sloppy variant a simple:
> 
>         base->softirq_activated = false;
> 
> is sufficient.
> 
>>   }
>>   
>>   /*
>> @@ -1657,18 +1703,28 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>>    */
>>   void run_local_timers(void)
>>   {
>> -	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>> +	int* block_softirq = this_cpu_ptr(&block_softirqs);
>> +	struct timer_base *base;
>>   
>>   	hrtimer_run_queues();
>> +
>> +	/* Skip if TIMER_SOFTIRQ is already running for this CPU */
>> +	if (READ_ONCE(*block_softirq))
>> +		return;
>> +
>> +	base = this_cpu_ptr(&timer_bases[BASE_STD]);
> 
> And this here becomes:
> 
>      	if (base->softirq_activated)
>      		return;
> 
>> +
>>   	/* Raise the softirq only if required. */
>> -	if (time_before(jiffies, base->clk)) {
>> +	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
>>   		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
>>   			return;
>>   		/* CPU is awake, so check the deferrable base. */
>>   		base++;
>> -		if (time_before(jiffies, base->clk))
>> +		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
>>   			return;
> 
> To make that work, all you need here is:
> 
> 		base--;
> 
>>   	}
> 
> and
> 	base->softirq_activated = true;
> 

Done. Dropped WRITE_ONCE().

>>   static void __init init_timer_cpu(int cpu)
>>   {
>>   	struct timer_base *base;
>> +	int* block_softirq;
>>   	int i;
>>   
>>   	for (i = 0; i < NR_BASES; i++) {
>> @@ -1852,6 +1910,10 @@ static void __init init_timer_cpu(int cpu)
>>   #ifdef CONFIG_PREEMPT_RT_FULL
>>   		init_swait_queue_head(&base->wait_for_running_timer);
>>   #endif
>> +		base->expired_count = 0;
>> +
>> +		block_softirq = per_cpu_ptr(&block_softirqs, cpu);
>> +		*block_softirq = 0;
> 
> What kind of voodoo initialization is this? Do you not trust BSS? Or do you
> not make sure that the stuff is brought into proper state when a CPU goes
> offline?
> 

Yea, this is pointless. Not sure what I was thinking. Removed.

> Aside of the above, this patch wants to be split into two pieces:
> 
>    1) Embedd the hlist heads for expired bucket collection into base
>       struct and adjust the code accordingly.
> 
>    2) Implement the conditional softirq raise machinery
> 

I agree. I split it and will submit a PATCH v3 shortly.

> Thanks,
> 
> 	tglx
> 

Thanks,
Haris
