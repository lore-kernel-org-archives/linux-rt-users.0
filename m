From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Long max latencies on Wandbaord / Freescale i.MX6
Date: Sun, 27 Sep 2015 13:49:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509271346160.4500@nanos>
References: <5606677A.1020705@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Matthias Meier <matthias.j.meier@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56834 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbI0Lti (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Sep 2015 07:49:38 -0400
In-Reply-To: <5606677A.1020705@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 26 Sep 2015, Matthias Meier wrote:

> Hi,
> 
> using cyclictest I measure long max latencies of >10ms on a Wandboard dual
> (Freescale i.MX6 dual Cortex-A9 SoC).
> 
> The latency problem happens with diffent scenarios:
> - without or with rt-patch  (4.1.7-rt8 w. CONFIG_PREEMPT_RT_FULL)
> - different Kernels (3.17, 4.1, 4.2 w. CONFIG_PREEMPT__LL)
> - different CPU governors including 'performance'
> - independant of CPU load
> - even with no other userspace processes but init, the login sh and cyclictest
> (I use a minimal builroot rfs).
> - independant of cyclictest prio
> 
> Using the same buildroot rfs on a A20 SoC (bananapro) with 4.1.7-rt8 shows
> acceptable rt-latencies of ~ 200us.
> 
> Ftracing 'irqsoff' on the rt-patched 4.1 kernel shows always long latency
> after 'raw_spin_lock_irq' (see log below).
> 
> Do you think it is a driver which stalls or hrtimer not working correctly on
> this SoC or someting else?
> If it is a driver, how could I find out which it is?

Try to capture the issue with full function tracing.

cyclictest --smp -p80 -m -f -b 5000

That stops the tracer when the latency is > 5ms. You might have to
increase the trace buffer size. Please upload the trace to some place
or send it to me privately (it's over the size limit of the list).

Thanks,

	tglx

