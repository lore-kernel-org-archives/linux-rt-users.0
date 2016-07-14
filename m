From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH 1/2] timers: wakeup all timer waiters
Date: Thu, 14 Jul 2016 12:13:41 -0400
Message-ID: <20160714121341.2b0e70f5@gandalf.local.home>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jul 2016 18:05:03 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The base lock is dropped during the invocation if the timer. That means
> it is possible that we have one waiter while timer1 is running and once
> this one finished, we get another waiter while timer2 is running. Since
> we wake up only one waiter it is possible that we miss the other one.
> This will probably heal itself over time because most of the time we
> complete timers without an active wake up.
> To avoid the scenario where we don't wake up all waiters at once,
> wake_up_all() is used.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 5f9d3599ef0a..b3c3d3a6216f 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1051,7 +1051,7 @@ static void wait_for_running_timer(struct timer_list *timer)
>  		   base->running_timer != timer);
>  }
>  
> -# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
> +# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)

OK, I just received this patch (way after patch 2)

I'm assuming that patch two was done such that you don't do a
"wake_up_all" under a spinlock.

-- Steve

>  #else
>  static inline void wait_for_running_timer(struct timer_list *timer)
>  {
