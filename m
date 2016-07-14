From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH 2/2] timers: wakeup all timer waiters without holding
 the base lock
Date: Thu, 14 Jul 2016 12:09:17 -0400
Message-ID: <20160714120917.038b215b@gandalf.local.home>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
	<1468512304-15310-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468512304-15310-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jul 2016 18:05:04 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> There should be no need to hold the base lock during the wakeup. There
> should be no boosting involved, the wakeup list has its own lock so it
> should be safe to do this without the lock.
> 
> Cc: stable-rt@vger.kernel.org

Nothing against this patch, but as you marked it for stable, can you
add to the change log what issue you had that caused you to make this
change?

-- Steve

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index b3c3d3a6216f..716ef84a5d87 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1313,8 +1313,8 @@ static inline void __run_timers(struct tvec_base *base)
>  			}
>  		}
>  	}
> -	wakeup_timer_waiters(base);
>  	spin_unlock_irq(&base->lock);
> +	wakeup_timer_waiters(base);
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
