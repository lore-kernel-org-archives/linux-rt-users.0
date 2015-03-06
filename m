From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: 3.18.7-rt2: NOHZ_FULL warning at boot
Date: Fri, 06 Mar 2015 20:28:52 +0100
Message-ID: <54F9FFF4.9080303@osadl.org>
References: <20150226200547.GL4111@uudg.org> <20150306181345.GD10155@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:40757 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbbCFT3H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 14:29:07 -0500
In-Reply-To: <20150306181345.GD10155@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/06/2015 07:13 PM, Sebastian Andrzej Siewior wrote:
> * Luis Claudio R. Goncalves | 2015-02-26 17:05:47 [-0300]:
>
>> I have been seeing the warning below at boot time on 3.18.7-rt2. Anybody
>> else seeing it?
>
> This should fix it.
>
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 19c363a..0c64912 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -71,6 +71,8 @@ void __weak arch_irq_work_raise(void)
>    */
>   bool irq_work_queue_on(struct irq_work *work, int cpu)
>   {
> +	bool raise_irqwork;
> +
>   	/* All work should have been flushed before going offline */
>   	WARN_ON_ONCE(cpu_is_offline(cpu));
>
> @@ -81,7 +83,19 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>   	if (!irq_work_claim(work))
>   		return false;
>
> -	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	if (work->flags & IRQ_WORK_HARD_IRQ)
> +		raise_irqwork = llist_add(&work->llnode,
> +					  &per_cpu(hirq_work_list, cpu));
> +	else
> +		raise_irqwork = llist_add(&work->llnode,
> +					  &per_cpu(lazy_list, cpu));
> +#else
> +		raise_irqwork = llist_add(&work->llnode,
> +					  &per_cpu(raised_list, cpu));
> +#endif
> +
> +	if (raise_irqwork)
>   		arch_send_call_function_single_ipi(cpu);
>
>   	return true;
> @@ -101,19 +115,14 @@ bool irq_work_queue(struct irq_work *work)
>
>   #ifdef CONFIG_PREEMPT_RT_FULL
>   	if (work->flags & IRQ_WORK_HARD_IRQ) {
> -		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list))) {
> -			if (work->flags & IRQ_WORK_LAZY) {
> -				if (tick_nohz_tick_stopped())
> -					arch_irq_work_raise();
> -			} else {
> -				arch_irq_work_raise();
> -			}
> -		}
> -	/* If the work is "lazy", handle it from next tick if any */
> -	} else if (work->flags & IRQ_WORK_LAZY) {
> +		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
> +			arch_irq_work_raise();
> +	} else {
> +		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
> +			arch_irq_work_raise();
> +	}
>   #else
>   	if (work->flags & IRQ_WORK_LAZY) {
> -#endif
>   		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
>   		    tick_nohz_tick_stopped())
>   			arch_irq_work_raise();
> @@ -121,6 +130,7 @@ bool irq_work_queue(struct irq_work *work)
>   		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
>   			arch_irq_work_raise();
>   	}
> +#endif
>
>   	preempt_enable();
>
> @@ -137,7 +147,8 @@ bool irq_work_needs_cpu(void)
>
>   	if (llist_empty(raised))
>   		if (llist_empty(lazy))
> -			return false;
> +			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
> +				return false;
>
>   	/* All work should have been flushed before going offline */
>   	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));

I can confirm that the warning is no longer issued when this patch is 
applied.

Thanks,
	-Carsten.
