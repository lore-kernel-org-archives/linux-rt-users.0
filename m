From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.6-rt9
Date: Fri, 24 Jan 2014 12:19:52 +0100
Message-ID: <52E24C58.2000205@linutronix.de>
References: <20131223225017.GA8623@linutronix.de> <1387900067.5490.33.camel@marge.simpson.net> <20140117170052.GF5785@linutronix.de> <1390014929.5444.38.camel@marge.simpson.net> <20140120211736.0c97418a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140120211736.0c97418a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/21/2014 03:17 AM, Steven Rostedt wrote:
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> diff --git a/kernel/timer.c b/kernel/timer.c
> index 46467be..8212c10 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1464,13 +1464,11 @@ void run_local_timers(void)
>  		raise_softirq(TIMER_SOFTIRQ);
>  		return;
>  	}
> -	if (!base->active_timers)
> -		goto out;
>  
>  	/* Check whether the next pending timer has expired */
>  	if (time_before_eq(base->next_timer, jiffies))
>  		raise_softirq(TIMER_SOFTIRQ);

Hmmm. If active_timers is 0 and "time_before_eq(base->next_timer,
jiffies))" is true than that timer should have been initialized with
init_timer_deferrable() or we have a serious bug here where
active_timers isn't properly synchronized anymore.

Now. If there is really just a deferrable timer that expired and nothing
else then this would explain it.

> -out:
> +
>  	rt_spin_unlock_after_trylock_in_irq(&base->lock);
>  
>  }

Sebastian
