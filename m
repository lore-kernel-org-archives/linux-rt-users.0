From: Mike Galbraith <efault@gmx.de>
Subject: Re: timerfd functions hang on both x86 and ARM with RT patch and
 RT scheduling policies
Date: Wed, 25 Jan 2012 11:24:48 +0100
Message-ID: <1327487088.6973.17.camel@marge.simson.net>
References: <CAFQPvXdTb-=oo8OC6MAa++X6u4ZoWM2XXmKog-WK6DPookJyvg@mail.gmail.com>
	 <CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com>
	 <1327478618.6973.2.camel@marge.simson.net>
	 <alpine.LFD.2.02.1201251110190.2716@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:42225 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750865Ab2AYKYw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 05:24:52 -0500
In-Reply-To: <alpine.LFD.2.02.1201251110190.2716@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-25 at 11:11 +0100, Thomas Gleixner wrote:
> On Wed, 25 Jan 2012, Mike Galbraith wrote:
> > On Tue, 2012-01-24 at 10:04 -0600, Sankara Muthukrishnan wrote:
> >  		spin_unlock_irq(&ctx->wqh.lock);
> > +#ifndef CONFIG_PREEMPT_RT_BASE
> 
> Bah.
> 
> >  		cpu_relax();
> > +#else
> > +		/*
> > +		 * Current may be an RT task with priority high enough
> > +		 * to prevent the thread currently _wanting_ to execute
> > +		 * the timer callback function from receiving the CPU.
> > +		 */
> > +		usleep_range(1, 10);
> 
> Even more bah.
> 
> > +#endif
> >  	}
> 
> Index: linux-3.2/fs/timerfd.c
> ===================================================================
> --- linux-3.2.orig/fs/timerfd.c
> +++ linux-3.2/fs/timerfd.c
> @@ -313,7 +313,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, uf
>  		if (hrtimer_try_to_cancel(&ctx->tmr) >= 0)
>  			break;
>  		spin_unlock_irq(&ctx->wqh.lock);
> -		cpu_relax();
> +		hrtimer_wait_for_timer(&ctx->tmr);
>  	}
>  
>  	/*

Oh goodie, bugs-- without uglies++ :)

	-Mike


