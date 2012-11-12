From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ARM: mxs: Setup scheduler clock
Date: Mon, 12 Nov 2012 09:54:21 +0800
Message-ID: <20121112015419.GB415@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
 <20121106134630.GD27643@S2100-06.ap.freescale.net>
 <509C3619.30701@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:26930 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142Ab2KLB2e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Nov 2012 20:28:34 -0500
Content-Disposition: inline
In-Reply-To: <509C3619.30701@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 08, 2012 at 11:45:45PM +0100, Stanislav Meduna wrote:
> Hi,
> 
> OK, as the problem with 16-bit fast ticking timer looks to
> be more complicated, I'd like to submit the patch for the 32-bit
> ones.
> 
> Thanks
> -- 
>                                     Stano
> 

> From 74092cc0217a5bab6f80ee07aa188a54f5792634 Mon Sep 17 00:00:00 2001
> From: Stanislav Meduna <stano@meduna.org>
> Date: Mon, 8 Nov 2012 23:39:14 +0100
> Subject: [PATCH] ARM: mxs: Setup scheduler clock
> 
> Setup scheduler clock on ARM MXS platforms with a 32-bit timrot
> such as MX.28. This allows the scheduler to use sub-jiffy resolution.
> 
s/MX.28/i.MX28

I fixed it up and applied the patch.  Thanks.

Shawn

> The corresponding change for 16-bit v1 timrots is not possible
> at the moment due to rounding issues with clock values wrapping
> faster than once per several seconds in the common ARM platform code.
> 
> Signed-off-by: Stanislav Meduna <stano@meduna.org>
> ---
>  arch/arm/mach-mxs/timer.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> index 564a632..4b6e36c 100644
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
> @@ -230,15 +231,22 @@ static struct clocksource clocksource_mxs = {
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +static u32 notrace mxs_read_sched_clock_v2(void)
> +{
> +	return ~readl_relaxed(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
> +}
> +
>  static int __init mxs_clocksource_init(struct clk *timer_clk)
>  {
>  	unsigned int c = clk_get_rate(timer_clk);
>  
>  	if (timrot_is_v1())
>  		clocksource_register_hz(&clocksource_mxs, c);
> -	else
> +	else {
>  		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1),
>  			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
> +		setup_sched_clock(mxs_read_sched_clock_v2, 32, c);
> +	}
>  
>  	return 0;
>  }
> -- 
> 1.7.0.4
> 


