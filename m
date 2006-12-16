From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/10] [ARM] clockevent driver for arm/netx
Date: Sat, 16 Dec 2006 12:34:53 +0100
Message-ID: <1166268893.29505.244.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
	 <20061215224328.103209000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:47939 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753609AbWLPLa6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 06:30:58 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215224328.103209000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:37 +0100, Robert Schwebel wrote:
>  /*
>   * IRQ handler for the timer
>   */
>  static irqreturn_t
>  netx_timer_interrupt(int irq, void *dev_id)
>  {
> -	write_seqlock(&xtime_lock);
> -
> -	timer_tick();
> -
> -	write_sequnlock(&xtime_lock);
> -
>  	/* acknowledge interrupt */
>  	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
>  
> +	if (clockevent_netx.event_handler)
> +		clockevent_netx.event_handler();

Why is this conditional? The timer interrupt should only happen, when
the clock event devices has been registerd and the ->set_mode function
has been called.

> +static void netx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
> +{
> +	clockevent_mode = mode;
> +}

set_mode() is there on purpose. It is used by the generic framework to
control the timer (enable in periodic/oneshot mode) or shutdown the
timer. 

	tglx
