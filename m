From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: timerfd functions hang on both x86 and ARM with RT patch and RT
 scheduling policies
Date: Wed, 25 Jan 2012 11:11:01 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1201251110190.2716@ionos>
References: <CAFQPvXdTb-=oo8OC6MAa++X6u4ZoWM2XXmKog-WK6DPookJyvg@mail.gmail.com>  <CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com> <1327478618.6973.2.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57640 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2AYKLE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 05:11:04 -0500
In-Reply-To: <1327478618.6973.2.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 25 Jan 2012, Mike Galbraith wrote:
> On Tue, 2012-01-24 at 10:04 -0600, Sankara Muthukrishnan wrote:
>  		spin_unlock_irq(&ctx->wqh.lock);
> +#ifndef CONFIG_PREEMPT_RT_BASE

Bah.

>  		cpu_relax();
> +#else
> +		/*
> +		 * Current may be an RT task with priority high enough
> +		 * to prevent the thread currently _wanting_ to execute
> +		 * the timer callback function from receiving the CPU.
> +		 */
> +		usleep_range(1, 10);

Even more bah.

> +#endif
>  	}

Index: linux-3.2/fs/timerfd.c
===================================================================
--- linux-3.2.orig/fs/timerfd.c
+++ linux-3.2/fs/timerfd.c
@@ -313,7 +313,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, uf
 		if (hrtimer_try_to_cancel(&ctx->tmr) >= 0)
 			break;
 		spin_unlock_irq(&ctx->wqh.lock);
-		cpu_relax();
+		hrtimer_wait_for_timer(&ctx->tmr);
 	}
 
 	/*
