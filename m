From: joe.korty@concurrent-rt.com
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Date: Thu, 5 Jul 2018 12:18:07 -0400
Message-ID: <20180705161807.GA5800@zipoli.concurrent-rt.com>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Cartwright <julia@ni.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 05, 2018 at 05:50:34PM +0200, Sebastian Andrzej Siewior wrote:
> migrate_disable() does nothing !SMP && !RT. This is bad for two reasons:
> - The futex code relies on the fact migrate_disable() is part of spin_lock().
>   There is a workaround for the !in_atomic() case in migrate_disable() which
>   work-arounds the different ordering (non-atomic lock and atomic unlock).
> 
> - we have a few instances where preempt_disable() is replaced with
>   migrate_disable().
> 
> For both cases it is bad if migrate_disable() ends up as barrier() instead of
> preempt_disable(). Let migrate_disable() fallback to preempt_disable().
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 4 ++--
>  kernel/sched/core.c     | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 043e431a7e8e..d46688d521e6 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
>  }
>  
>  #else
> -#define migrate_disable()		barrier()
> -#define migrate_enable()		barrier()
> +#define migrate_disable()		preempt_disable()
> +#define migrate_enable()		preempt_enable()
>  static inline int __migrate_disabled(struct task_struct *p)
>  {
>  	return 0;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ac3fb8495bd5..626a62218518 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7326,6 +7326,7 @@ void migrate_disable(void)
>  #endif
>  
>  	p->migrate_disable++;
> +	preempt_disable();
>  }
>  EXPORT_SYMBOL(migrate_disable);
>  
> @@ -7349,6 +7350,7 @@ void migrate_enable(void)
>  
>  	WARN_ON_ONCE(p->migrate_disable <= 0);
>  	p->migrate_disable--;
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL(migrate_enable);
>  #endif
> -- 
> 2.18.0



Hi Sebastian,
I just verified that this fix does not work for my mix of
config options (smp && preempt && !rt).

Regards,
Joe
