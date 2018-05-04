From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch-rt] sched,fair: Fix CFS bandwidth control  lockdep
 DEADLOCK report
Date: Fri, 4 May 2018 10:48:02 -0400
Message-ID: <20180504104802.33e9a52f@gandalf.local.home>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
        <1525414478.6761.5.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525414478.6761.5.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 04 May 2018 08:14:38 +0200
Mike Galbraith <efault@gmx.de> wrote:

> CFS bandwidth control yields the inversion gripe below, moving
> handling quells it.
> 
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 4.16.7-rt1-rt #2 Tainted: G            E   
> --------------------------------------------------------
> sirq-hrtimer/0/15 just changed the state of lock:
>  (&cfs_b->lock){+...}, at: [<000000009adb5cf7>] sched_cfs_period_timer+0x28/0x140
> but this lock was taken by another, HARDIRQ-safe lock in the past:
>  (&rq->lock){-...}
> and interrupts could create inverse lock ordering between them.
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario: 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&cfs_b->lock);
>                                local_irq_disable();
>                                lock(&rq->lock);
>                                lock(&cfs_b->lock);
>   <Interrupt>
>     lock(&rq->lock);
> *** DEADLOCK *** 


> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/sched/fair.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandw
>  	cfs_b->period = ns_to_ktime(default_cfs_period());
>  
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> -	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> +	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>  	cfs_b->period_timer.function = sched_cfs_period_timer;
> -	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);

Looks good to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>  }
>  
