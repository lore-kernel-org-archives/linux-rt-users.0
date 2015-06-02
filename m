From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] Clocksource: Add sched_clock to Atmel TCB
 clocksource
Date: Tue, 2 Jun 2015 22:38:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506022230590.20347@nanos>
References: <20150602134631.969367833@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53052 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbbFBUit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 16:38:49 -0400
In-Reply-To: <20150602134631.969367833@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2 Jun 2015, Carsten Emde wrote:
>  static void __iomem *tcaddr;
> +static cycle_t (*do_sched_clock_get_cycles)(struct clocksource *cs);

what's that for? Indirection for indirection sake?

>  static cycle_t tc_get_cycles(struct clocksource *cs)
>  {
> @@ -61,6 +63,13 @@ static cycle_t tc_get_cycles32(struct cl
>  	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
>  }
>  
> +u64 sched_clock_get_cycles(void)

Static? 

> +{
> +	struct clocksource *cs = NULL;
> +
> +	return (u64) do_sched_clock_get_cycles(cs);


What's wrong with implementing this like:

static u64 sched_clock_get_cycles(void)
{
	return tc_get_cycles(NULL); 
}

Hmm?

> @@ -273,6 +282,7 @@ static int __init tcb_clksrc_init(void)
>  	int clk32k_divisor_idx = -1;
>  	int i;
>  	int ret;
> +	unsigned long flags;
>  
>  	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
>  	if (!tc) {
> @@ -339,6 +349,11 @@ static int __init tcb_clksrc_init(void)
>  	if (ret)
>  		goto err_disable_t1;
>  
> +	do_sched_clock_get_cycles = clksrc.read;

Sigh.

> +	local_irq_save(flags);

What's the purpose of this?

Thanks,

	tglx
