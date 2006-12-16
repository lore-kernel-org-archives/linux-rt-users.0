From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/10] [ARM] clockevent driver for arm/ep93xx
Date: Sat, 16 Dec 2006 12:23:38 +0100
Message-ID: <1166268218.29505.236.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
	 <20061215224329.323692000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:43878 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030867AbWLPLTo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 06:19:44 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215224329.323692000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:37 +0100, Robert Schwebel wrote:
>  /*************************************************************************
>   * Static I/O mappings that are needed for all EP93xx platforms
> @@ -99,18 +102,15 @@ void __init ep93xx_map_io(void)
>  
>  static int ep93xx_timer_interrupt(int irq, void *dev_id)
>  {
> -	write_seqlock(&xtime_lock);
> -
>  	__raw_writel(1, EP93XX_TIMER1_CLEAR);
>  	while ((signed long)
>  		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
>  						>= TIMER4_TICKS_PER_JIFFY) {
>  		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
> -		timer_tick();
> +		if (clockevent_ep93xx.event_handler)
> +			clockevent_ep93xx.event_handler(regs);

Why is this loop here ? It conflicts nicely with dynamic ticks.

	tglx
