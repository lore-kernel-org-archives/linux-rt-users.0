From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Thu, 14 Jan 2016 15:29:11 +0100
Message-ID: <1452781751.3460.102.camel@gmail.com>
References: <20151223225755.GA21121@linutronix.de>
	 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
	 <1451632781.9800.22.camel@gmail.com> <20160113175845.GK29964@linutronix.de>
	 <20160114141744.GB17776@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33900 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbcANO3P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jan 2016 09:29:15 -0500
In-Reply-To: <20160114141744.GB17776@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2016-01-14 at 15:17 +0100, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2016-01-13 18:58:45 [+0100]:
> 
> > This is due to NO_HZ as far as I can tell. My AMD A10 in idle mode
> > has
> > 0.7% utilisation of ksoftirqd/ with CONFIG_HZ_PERIODIC and with
> > CONFIG_NO_HZ_FULL it shows about 25% on all CPU threads.
> 
> This should fixed it:
> 
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1453,7 +1453,7 @@ u64 get_next_timer_interrupt(unsigned long
> basej, u64 basem)
>  	 * the base lock to check when the next timer is pending and
> so
>  	 * we assume the next jiffy.
>  	 */
> -	return basej;
> +	return basem + TICK_NSEC;
>  #endif
>  	spin_lock(&base->lock);
>  	if (base->active_timers) {

That's what I had done to stop the screaming interrupt, but box still
behaved very badly.

	-Mike

