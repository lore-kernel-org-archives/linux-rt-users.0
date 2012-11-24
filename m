From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: genirq: Add default affinity mask command line option: optimization
 and cleanup
Date: Sat, 24 Nov 2012 15:58:36 +0100
Message-ID: <50B0E09C.209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58807 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2KXO7i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Nov 2012 09:59:38 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3798379eek.19
        for <linux-rt-users@vger.kernel.org>; Sat, 24 Nov 2012 06:59:36 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I'd like to propose a couple of minor changes to the patch
genirq-add-default-mask-cmdline-option, part of the RT patch series for
3.4 and above.

>From genirq-add-default-mask-cmdline-option.patch:
> Subject: genirq: Add default affinity mask command line option
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 25 May 2012 16:59:47 +0200
> 
> If we isolate CPUs, then we don't want random device interrupts on
> them. Even w/o the user space irq balancer enabled we can end up with
> irqs on non boot cpus.
> 
> Allow to restrict the default irq affinity mask.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/kernel-parameters.txt |    9 +++++++++
>  kernel/irq/irqdesc.c                |   21 +++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> Index: linux-stable/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-stable.orig/Documentation/kernel-parameters.txt
> +++ linux-stable/Documentation/kernel-parameters.txt
> @@ -1157,6 +1157,15 @@ bytes respectively. Such letter suffixes
>  			See comment before ip2_setup() in
>  			drivers/char/ip2/ip2base.c.
>  
> +	irqaffinity=	[SMP] Set the default irq affinity mask
> +			Format:
> +			<cpu number>,...,<cpu number>
> +			or
> +			<cpu number>-<cpu number>
> +			(must be a positive range in ascending order)
> +			or a mixture
> +			<cpu number>,...,<cpu number>-<cpu number>
> +
>  	irqfixup	[HW]
>  			When an interrupt is not handled search all handlers
>  			for it. Intended to get systems with badly broken
> Index: linux-stable/kernel/irq/irqdesc.c
> ===================================================================
> --- linux-stable.orig/kernel/irq/irqdesc.c
> +++ linux-stable/kernel/irq/irqdesc.c
> @@ -23,10 +23,27 @@
>  static struct lock_class_key irq_desc_lock_class;
>  
>  #if defined(CONFIG_SMP)
> +static int __init irq_affinity_setup(char *str)
> +{
> +	zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
> +	cpulist_parse(str, irq_default_affinity);

Since cpulist_parse() sets all the bits of its cpumask argument, it's
not necessary to initialize them to zero during allocation, so I would
use alloc_cpumask_var() instead of zalloc_cpumask_var().

> +	/*
> +	 * Set at least the boot cpu. We don't want to end up with
> +	 * bugreports caused by random comandline masks
> +	 */
> +	cpumask_set_cpu(smp_processor_id(), irq_default_affinity);
> +	return 1;
> +}
> +__setup("irqaffinity=", irq_affinity_setup);
> +
>  static void __init init_irq_default_affinity(void)
>  {
> -	alloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
> -	cpumask_setall(irq_default_affinity);
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +	if (!irq_default_affinity)
> +		zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
> +#endif

The #ifdefery is not necessary here, because if CONFIG_CPUMASK_OFFSTACK
is not defined irq_default_affinity cannot be NULL.

> +	if (cpumask_empty(irq_default_affinity))
> +		cpumask_setall(irq_default_affinity);
>  }
>  #else
>  static void __init init_irq_default_affinity(void)

--
Francesco
