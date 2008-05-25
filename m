From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -v3] x86: enable preemption in delay
Date: Sun, 25 May 2008 11:04:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805251104001.23300@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0805242306280.3977@gandalf.stny.rr.com>
 <alpine.LFD.1.10.0805251406260.3295@apollo.tec.linutronix.de>
 <Pine.LNX.4.58.0805250931160.20625@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0805250943010.22651@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0805250948000.22651@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi-suse@firstfloor.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:54740 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbYEYPEx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 May 2008 11:04:53 -0400
In-Reply-To: <Pine.LNX.4.58.0805250948000.22651@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 25 May 2008, Steven Rostedt wrote:
>
> ---
>  arch/x86/lib/delay_32.c |   32 ++++++++++++++++++++++++++++----
>  arch/x86/lib/delay_64.c |   31 +++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 8 deletions(-)
>
> Index: linux-tip.git/arch/x86/lib/delay_32.c
> ===================================================================
> --- linux-tip.git.orig/arch/x86/lib/delay_32.c	2008-05-22 14:51:02.000000000 -0400
> +++ linux-tip.git/arch/x86/lib/delay_32.c	2008-05-25 09:45:24.000000000 -0400
> @@ -44,13 +44,37 @@ static void delay_loop(unsigned long loo
>  static void delay_tsc(unsigned long loops)
>  {
>  	unsigned long bclock, now;
> +	int cpu;
>
> -	preempt_disable();		/* TSC's are per-cpu */
> +	preempt_disable();
> +	cpu = smp_processor_id();
>  	rdtscl(bclock);
> -	do {
> -		rep_nop();
> +	for (;;) {
>  		rdtscl(now);
> -	} while ((now-bclock) < loops);
> +		if ((now - bclock) >= loops)
> +			break;
> +
> +		loops -= (now - bclock);

Bah, this is mathematically incorrect. Going for -v4!

A simple patch like this shouldn't take so much.  I must need more sleep.

-- Steve

> +
> +		/* Allow RT tasks to run */
> +		preempt_enable();
> +		rep_nop();
> +		preempt_disable();
> +
> +		/*
> +		 * It is possible that we moved to another CPU, and
> +		 * since TSC's are per-cpu we need to calculate
> +		 * that. The delay must guarantee that we wait "at
> +		 * least" the amount of time. Being moved to another
> +		 * CPU could make the wait longer but we just need to
> +		 * make sure we waited long enough. Rebalance the
> +		 * counter for this CPU.
> +		 */
> +		if (unlikely(cpu != smp_processor_id())) {
> +			cpu = smp_processor_id();
> +			rdtscl(bclock);
> +		}
> +	}
>  	preempt_enable();
>  }
>
