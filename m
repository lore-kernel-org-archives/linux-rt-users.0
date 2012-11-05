From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: Wakeup latency measured with SCHED_TRACER depends on HZ
Date: Mon, 5 Nov 2012 10:57:54 +0800
Message-ID: <20121105025753.GA26528@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:48656 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751541Ab2KECc1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Nov 2012 21:32:27 -0500
Content-Disposition: inline
In-Reply-To: <5093D8DE.70505@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 02, 2012 at 03:29:50PM +0100, Stanislav Meduna wrote:
> On 31.10.2012 22:41, Stanislav Meduna wrote:
> 
> > on an embedded platform using a Freescale i.MX28 ARM processor
> > I am experiencing a strange phenomenon - the latencies reported
> > are dependent of HZ
> 
> OK, the problem is that the MXS platform does not setup
> the scheduler clock so the scheduler only sees the HZ one.
> 
> The patch in attach fixes this. I can only test the MX28 part -
> I don't have any timrot_is_v1() (MX23) hardware and I don't
> know whether a source that wraps after ~2 seconds is OK at all.

>From my quick testing on imx23 with printk timestamp, it's not OK,
so we may need to leave imx23 out there.

> 
> Please Cc: when replying, I am not subscribed to linux-kernel

linux-arm-kernel is better than linux-kernel for this patch.

> (only to linux-rt-users).
> 
> Regards
> -- 
>                                       Stano
> 

> From ddeed3c83d48e8ce33b36bd964572756354e7feb Mon Sep 17 00:00:00 2001
> From: Stanislav Meduna <stano@meduna.org>
> Date: Fri, 2 Nov 2012 15:00:44 +0100
> Subject: [PATCH] Setup scheduler clock for MXS
> 

Generally, empty commit log is not welcomed.  Also, please add prefix
"ARM: mxs: " to patch subject.

> ---
>  arch/arm/mach-mxs/timer.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> index 564a632..0ab86a2 100644
> --- a/arch/arm/mach-mxs/timer.c
> +++ b/arch/arm/mach-mxs/timer.c
> @@ -26,6 +26,7 @@
>  #include <linux/clk.h>
>  
>  #include <asm/mach/time.h>
> +#include <asm/sched_clock.h>
>  #include <mach/mxs.h>
>  #include <mach/common.h>
>  
> @@ -243,6 +244,16 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
>  	return 0;
>  }
>  
> +static u32 notrace mxs_read_sched_clock_v1(void)
> +{
> +	return timrotv1_get_cycles(&clocksource_mxs);
> +}
> +
> +static u32 notrace mxs_read_sched_clock_v2(void)
> +{
> +	return ~readl_relaxed(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
> +}
> +
>  void __init mxs_timer_init(struct clk *timer_clk, int irq)
>  {
>  	clk_prepare_enable(timer_clk);
> @@ -285,6 +296,14 @@ void __init mxs_timer_init(struct clk *timer_clk, int irq)
>  	mxs_clocksource_init(timer_clk);
>  	mxs_clockevent_init(timer_clk);
>  
> +	/* Register scheduler clocksource */
> +	if (timrot_is_v1())
> +		setup_sched_clock(mxs_read_sched_clock_v1,
> +			16, clk_get_rate(timer_clk));
> +	else
> +		setup_sched_clock(mxs_read_sched_clock_v2,
> +			32, clk_get_rate(timer_clk));
> +

It should better be done in mxs_clocksource_init().

Shawn

>  	/* Make irqs happen */
>  	setup_irq(irq, &mxs_timer_irq);
>  }
> -- 
> 1.7.0.4
> 


