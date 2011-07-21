From: andi <andi.platschek@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Thu, 21 Jul 2011 20:28:16 +0200
Message-ID: <4E286FC0.9000307@gmail.com>
References: <1311265361.2323.6.camel@box> <alpine.LFD.2.02.1107211932440.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: hermann <brummer-@web.de>, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60267 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab1GUS2V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2011 14:28:21 -0400
Received: by fxd18 with SMTP id 18so3912226fxd.11
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jul 2011 11:28:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1107211932440.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

Actually, I think, the last line added in this patch is wrong...

+	spinlock_t b_state_lock;

leads to duplication of b_state_lock...

regards,
Andi


On 07/21/2011 07:35 PM, Thomas Gleixner wrote:
> On Thu, 21 Jul 2011, hermann wrote:
>    
>> I try to build the 3.0-rc7-rt0 but fail with the following message:
>>   CC [M]  fs/ext3/balloc.o
>> In file included from include/linux/jbd.h:247:0,
>>                   from fs/ext3/balloc.c:18:
>>      
> Find below a patch on top of rt0 which fixes this build failure and
> some other stuff.
>
> Thanks,
>
> 	tglx
>
> -----------
>
> Index: linux-2.6/kernel/timer.c
> ===================================================================
> --- linux-2.6.orig/kernel/timer.c
> +++ linux-2.6/kernel/timer.c
> @@ -654,6 +654,36 @@ static struct tvec_base *lock_timer_base
>   	}
>   }
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> +static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
> +						  struct tvec_base *old,
> +						  struct tvec_base *new)
> +{
> +	/* See the comment in lock_timer_base() */
> +	timer_set_base(timer, NULL);
> +	spin_unlock(&old->lock);
> +	spin_lock(&new->lock);
> +	timer_set_base(timer, new);
> +	return new;
> +}
> +#else
> +static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
> +						  struct tvec_base *old,
> +						  struct tvec_base *new)
> +{
> +	/*
> +	 * We cannot do the above because we might be preempted and
> +	 * then the preempter would see NULL and loop forever.
> +	 */
> +	if (spin_trylock(&new->lock)) {
> +		timer_set_base(timer, new);
> +		spin_unlock(&old->lock);
> +		return new;
> +	}
> +	return old;
> +}
> +#endif
> +
>   static inline int
>   __mod_timer(struct timer_list *timer, unsigned long expires,
>   						bool pending_only, int pinned)
> @@ -699,14 +729,8 @@ __mod_timer(struct timer_list *timer, un
>   		 * handler yet has not finished. This also guarantees that
>   		 * the timer is serialized wrt itself.
>   		 */
> -		if (likely(base->running_timer != timer)) {
> -			/* See the comment in lock_timer_base() */
> -			timer_set_base(timer, NULL);
> -			spin_unlock(&base->lock);
> -			base = new_base;
> -			spin_lock(&base->lock);
> -			timer_set_base(timer, base);
> -		}
> +		if (likely(base->running_timer != timer))
> +			base = switch_timer_base(timer, base, new_base);
>   	}
>
>   	timer->expires = expires;
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -1943,8 +1943,8 @@ __alloc_pages_direct_compact(gfp_t gfp_m
>   	if (*did_some_progress != COMPACT_SKIPPED) {
>
>   		/* Page migration frees to the PCP lists but we want merging */
> -		drain_pages(get_cpu());
> -		put_cpu();
> +		drain_pages(get_cpu_light());
> +		put_cpu_light();
>
>   		page = get_page_from_freelist(gfp_mask, nodemask,
>   				order, zonelist, high_zoneidx,
> Index: linux-2.6/include/linux/buffer_head.h
> ===================================================================
> --- linux-2.6.orig/include/linux/buffer_head.h
> +++ linux-2.6/include/linux/buffer_head.h
> @@ -74,7 +74,9 @@ struct buffer_head {
>   	atomic_t b_count;		/* users using this buffer_head */
>   #ifdef CONFIG_PREEMPT_RT_BASE
>   	spinlock_t b_uptodate_lock;
> -#if defined(CONFIG_JBD) || defined(CONFIG_JBD2)
> +#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || \
> +    defined(CONFIG_JBD2) || defined(CONFIG_JBD2_MODULE)
> +	spinlock_t b_state_lock;
>   	spinlock_t b_state_lock;
>   	spinlock_t b_journal_head_lock;
>   #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

