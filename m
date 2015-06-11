From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 RESEND  1/1] Clocksource: Add sched_clock to Atmel TCB
 clocksource
Date: Thu, 11 Jun 2015 17:15:33 +0200
Message-ID: <20150611151533.GK16115@linutronix.de>
References: <20150602215215.577791619@osadl.org>
 <556E2945.4090800@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57088 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbFKPPe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 11:15:34 -0400
Content-Disposition: inline
In-Reply-To: <556E2945.4090800@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2015-06-03 00:08:05 [+0200]:

>@@ -339,6 +346,10 @@ static int __init tcb_clksrc_init(void)
> 	if (ret)
> 		goto err_disable_t1;
>
>+	local_irq_save(flags);
>+	sched_clock_register(sched_clock_get_cycles, 32, divided_rate);
>+	local_irq_restore(flags);

The other sched_clock_register() users don't do this and are invoked via
CLOCKSOURCE_OF_DECLARE / clocksource_of_init() and this is probably
early enough so the irqs stay off.
Since this is not -RT specific at all, do you mind routing it via ARM/
clocksource folks? They also may have an idea what is stopping them from
using clocksource_of_init() so you wouldn't have to disable interrupts
here.

> 	/* channel 2:  periodic and oneshot timer support */
> 	ret = setup_clkevents(tc, clk32k_divisor_idx);
> 	if (ret)

Sebastian
