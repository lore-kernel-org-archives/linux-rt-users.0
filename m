From: yjin <yanjiang.jin@windriver.com>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in push_irq_work_func
Date: Mon, 16 Nov 2015 13:26:42 +0800
Message-ID: <56496912.4090001@windriver.com>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com> <20151113232512.53df431f@gandalf.local.home> <5646BB4A.50307@windriver.com> <alpine.DEB.2.11.1511150914240.3761@nanos> <alpine.DEB.2.11.1511150925040.3761@nanos> <alpine.DEB.2.11.1511151204050.3761@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>, <mingo@redhat.com>,
	<bigeasy@linutronix.de>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <jinyanjiang@gmail.com>,
	<stable-rt@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Yang Shi <yang.shi@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:40214 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbbKPF1V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2015 00:27:21 -0500
In-Reply-To: <alpine.DEB.2.11.1511151204050.3761@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Thanks for your help.
I have tested your patch this morning, it seems well.
Could you tell me when will you send your formal patch? And please CC m=
e=20
when you send your patch.

Regards!
Yanjiang

On 2015=E5=B9=B411=E6=9C=8815=E6=97=A5 19:05, Thomas Gleixner wrote:
> On Sun, 15 Nov 2015, Thomas Gleixner wrote:
>> Which does not happen on MIPS as it uses the generic
>> arch_irq_work_has_interrupt() implementation which returns 'false'.
> So the proper fix is to ensure that the irq safe irq work actually
> happens in interrupt context. Patch below.
>
> Thanks,
>
> 	tglx
>
> 8<-------------
>
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 0e427a9997f3..2543aab05daa 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -52,4 +52,10 @@ static inline bool irq_work_needs_cpu(void) { retu=
rn false; }
>   static inline void irq_work_run(void) { }
>   #endif
>  =20
> +#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
> +void irq_work_tick_soft(void);
> +#else
> +static inline void irq_work_tick_soft(void) { }
> +#endif
> +
>   #endif /* _LINUX_IRQ_WORK_H */
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 5a0f4525139c..58cf46638ca0 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -200,8 +200,17 @@ void irq_work_tick(void)
>  =20
>   	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
>   		irq_work_run_list(raised);
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> +		irq_work_run_list(this_cpu_ptr(&lazy_list));
> +}
> +
> +#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
> +void irq_work_tick_soft(void)
> +{
>   	irq_work_run_list(this_cpu_ptr(&lazy_list));
>   }
> +#endif
>  =20
>   /*
>    * Synchronize against the irq_work @entry, ensures the entry is no=
t
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index adb1d82d6631..c68ba873da3c 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1455,7 +1455,7 @@ void update_process_times(int user_tick)
>   	scheduler_tick();
>   	run_local_timers();
>   	rcu_check_callbacks(user_tick);
> -#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
> +#if defined(CONFIG_IRQ_WORK)
>   	if (in_irq())
>   		irq_work_tick();
>   #endif
> @@ -1471,9 +1471,7 @@ static void run_timer_softirq(struct softirq_ac=
tion *h)
>  =20
>   	hrtimer_run_pending();
>  =20
> -#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
> -	irq_work_tick();
> -#endif
> +	irq_work_tick_soft();
>  =20
>   	if (time_after_eq(jiffies, base->timer_jiffies))
>   		__run_timers(base);

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
