From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH RT v2] mm: perform lru_add_drain_all() remotely
Date: Fri, 27 May 2016 16:39:38 -0400
Message-ID: <20160527163938.05c98e39@redhat.com>
References: <20160524151551.08ad534e@redhat.com>
	<20160527131024.GA24120@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbcE0Ujl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 May 2016 16:39:41 -0400
In-Reply-To: <20160527131024.GA24120@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 27 May 2016 15:10:24 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Luiz Capitulino | 2016-05-24 15:15:51 [-0400]:
> 
> >Sebastian,
> >
> >It's not clear to me from our last discussion what's the
> >best plan for this patch. I'm sending v2 with the changes
> >you suggested.  
> 
> The patch at the bottom is what I intend to take into the next v4.6-RT.
> local_lock_irqsave_on() was already part of the first v4.6 release. I
> don't like the part where local_lock_irqsave_on() is a simple
> local_irq_safe() on !RT but that is another story.

Looks good to me.

> 
> diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> index 493e801e0c9b..845c77f1a5ca 100644
> --- a/include/linux/locallock.h
> +++ b/include/linux/locallock.h
> @@ -66,6 +66,9 @@ static inline void __local_lock(struct local_irq_lock *lv)
>  #define local_lock(lvar)					\
>  	do { __local_lock(&get_local_var(lvar)); } while (0)
>  
> +#define local_lock_on(lvar, cpu)				\
> +	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
> +
>  static inline int __local_trylock(struct local_irq_lock *lv)
>  {
>  	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
> @@ -104,6 +107,9 @@ static inline void __local_unlock(struct local_irq_lock *lv)
>  		put_local_var(lvar);				\
>  	} while (0)
>  
> +#define local_unlock_on(lvar, cpu)                       \
> +	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
> +
>  static inline void __local_lock_irq(struct local_irq_lock *lv)
>  {
>  	spin_lock_irqsave(&lv->lock, lv->flags);
> diff --git a/mm/swap.c b/mm/swap.c
> index 892747266c7e..35fab668a782 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -596,9 +596,9 @@ void lru_add_drain_cpu(int cpu)
>  		unsigned long flags;
>  
>  		/* No harm done if a racing interrupt already did this */
> -		local_lock_irqsave(rotate_lock, flags);
> +		local_lock_irqsave_on(rotate_lock, flags, cpu);
>  		pagevec_move_tail(pvec);
> -		local_unlock_irqrestore(rotate_lock, flags);
> +		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
>  	}
>  
>  	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
> @@ -666,12 +666,32 @@ void lru_add_drain(void)
>  	local_unlock_cpu(swapvec_lock);
>  }
>  
> +
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
> +{
> +	local_lock_on(swapvec_lock, cpu);
> +	lru_add_drain_cpu(cpu);
> +	local_unlock_on(swapvec_lock, cpu);
> +}
> +
> +#else
> +
>  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>  {
>  	lru_add_drain();
>  }
>  
>  static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> +static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
> +{
> +	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
> +
> +	INIT_WORK(work, lru_add_drain_per_cpu);
> +	schedule_work_on(cpu, work);
> +	cpumask_set_cpu(cpu, has_work);
> +}
> +#endif
>  
>  void lru_add_drain_all(void)
>  {
> @@ -684,21 +704,18 @@ void lru_add_drain_all(void)
>  	cpumask_clear(&has_work);
>  
>  	for_each_online_cpu(cpu) {
> -		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
> -
>  		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
> -		    need_activate_page_drain(cpu)) {
> -			INIT_WORK(work, lru_add_drain_per_cpu);
> -			schedule_work_on(cpu, work);
> -			cpumask_set_cpu(cpu, &has_work);
> -		}
> +		    need_activate_page_drain(cpu))
> +			remote_lru_add_drain(cpu, &has_work);
>  	}
>  
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	for_each_cpu(cpu, &has_work)
>  		flush_work(&per_cpu(lru_add_drain_work, cpu));
> +#endif
>  
>  	put_online_cpus();
>  	mutex_unlock(&lock);

