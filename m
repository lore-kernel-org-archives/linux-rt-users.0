From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Disabling lapic timer for a certain core
Date: Fri, 5 Mar 2010 08:05:01 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003050659380.2014@localhost.localdomain>
References: <6756648.1267736627501.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lclaudio@uudg.org, linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:57908 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab0CEHFL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Mar 2010 02:05:11 -0500
In-Reply-To: <6756648.1267736627501.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 4 Mar 2010, M. Koehrer wrote:
> Hi Luis,

Please do _NOT_ top post. Please reply inline and in context.

> thanks for the reply.
> It is an Intel Core2Quad CPU - one CPU with 4 cores,  
> this is a SMP system...
> Concerning the SMI issue:
> I have globally disabled SMI with the LPC registers...

I hope you know what you are doing. Disabling SMIs can be dangerous in
various aspects:

  - thermal protection might be disabled by it
  - SMIs which fix chip(set) erratas are not longer working

You should at least confirm with your hardware vendor whether it's
safe to do so and which side effects you have to take into account.

> The main board is a server board from Supermicro, 
> no USB enabled, VGA text mode only. No X running.
> 
> The total amount of time we have for a cycle is 40us,

FYI, 40us is in the range where the hardware induced latencies can
bite you already badly. You run on a machine with shared L2 caches, so
your other core(s) might evict your code / data and you run into cache
misses which might take a while due to DMAs running etc...

These machines are designed for throughput, not for deterministic
behaviour in the single digit micro seconds range.

> The issue is here, that the interrupt routine of the kernel
> takes too long here.
> It would be fine to have the timer interrupt called more 
> often and to process with each call only a subset of the 
> jobs to be done...
> This would reduce the time the CPU the user mode 
> is interrupted by the timer routine.

Err, by splitting the work you introduce even more overhead. That's
the wrong approach. The first question is which timers are running on
that CPU as you have isolated it.

/proc/timer_stats and /proc/timer_list and the event tracer might help
you to identify them.

In theory it's possible to remove the timer interrupt from such an
isolated core completely, but there needs to be some work done vs. the
scheduler, accounting, RCU etc. There are people looking into this,
but we have no patches yet.

> The idea of running this application in an endless loop is to avoid
> to use timers (including the interrupt latency caused by them).
> By pure polling, no interrupt is required.

What kind of application is that ? Data acquistion or closed loop
processsing ?

Thanks,

	tglx
