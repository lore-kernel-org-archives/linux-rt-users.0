From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.7-rt29 PREEMPT_RT worse latency than PREEMPT_DESKTOP on
 AT91?
Date: Fri, 27 Aug 2010 12:35:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008271234300.2768@localhost.localdomain>
References: <4C72A438.2080301@cgglobal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Agustin Ferrin Pozuelo <agustin.ferrin@cgglobal.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42290 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab0H0Kft (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 06:35:49 -0400
In-Reply-To: <4C72A438.2080301@cgglobal.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 23 Aug 2010, Agustin Ferrin Pozuelo wrote:

> Hello,
> 
> I am fine tuning the configuration for an ARM system derived from
> AT91SAM9263-EK.
> 
> My goal is to minimize latency, and I am using "cyclictest" from rt-tools
> v0.78 for measuring it.
> 
> I get consistently better latency with PREEMPT_DESKTOP over what I get with
> PREEMPT_RT. This is an example for a very simple test run, which reflects the
> overall results I am getting:
> 
>    ### PREEMPT-RT, HRT, no NO_HZ, no RTC, no USE_SLOW_CLOCK
> 
>    root@at91sam9263cpc:~# time cyclictest -i 700000 -r -p 80 -l 33
>    Clock resolution: 0.000000001 (s.ns)
>    policy: fifo: loadavg: 0.11 0.10 0.04 1/49 884
> 
>    T: 0 (  861) P:80 I:700000 C:     33 Min:    370 Act:  627 Avg:  437 Max:
> 627
>    real	0m 23.51s
>    user	0m 0.38s
>    sys	0m 2.20s
> 
>    ### PREEMPT-DESKTOP (no RT), HRT, no NO_HZ, no USE_SLOW_CLOCK
>    root@at91sam9263cpc:~# time cyclictest -i 700000 -r -p 80 -l 33
>    Clock resolution: 0.000000001 (s.ns)
>    policy: fifo: loadavg: 0.24 0.08 0.03 1/46 600
> 
>    T: 0 (  574) P:80 I:700000 C:     33 Min:    173 Act:  196 Avg:  222 Max:
> 378
>    real	0m 23.66s
>    user	0m 0.32s
>    sys	0m 1.29s

33 loops are not really giving you any useful information. Also run
both tests with some background load and not on a fully idle system.

Thanks,

	tglx

