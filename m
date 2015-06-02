From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH 1/1] Clocksource: Add sched_clock to Atmel TCB clocksource
Date: Tue, 02 Jun 2015 23:06:04 +0200
Message-ID: <556E1ABC.8090907@osadl.org>
References: <20150602134631.969367833@osadl.org> <alpine.DEB.2.11.1506022230590.20347@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55624 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbbFBVGX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:06:23 -0400
In-Reply-To: <alpine.DEB.2.11.1506022230590.20347@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

>>   static void __iomem *tcaddr;
>> +static cycle_t (*do_sched_clock_get_cycles)(struct clocksource *cs);
>
> what's that for? Indirection for indirection sake?
The code apparently provides two different functions to read the current 
clock - depending on whether the clock is setup in single-channel mode 
or not.

The default function is predefined in the struct clocksource clksrc:
   .read = tc_get_cycles
This structure element may later on be overwritten, if the counter is 
configured in single-channel mode:
   clksrc.read = tc_get_cycles32;

This is why my code sets do_sched_clock_get_cycles to clksrc.read before 
sched_clock is registered to make sure the appropriate read function 
will be used.

>> +u64 sched_clock_get_cycles(void)
> Static?
Yes, sure, should be static. Will fix it.

> What's wrong with implementing this like:
>
> static u64 sched_clock_get_cycles(void)
> {
> 	return tc_get_cycles(NULL);
> }
> Hmm?
See above.

>> +	local_irq_save(flags);
> What's the purpose of this?
The sched_clock_register() function contains
   WARN_ON(!irqs_disabled());
which I did not want to trigger.

Thanks,
	-Carsten.
