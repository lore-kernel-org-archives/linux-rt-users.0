From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Mon, 13 Apr 2015 11:41:45 +0200
Message-ID: <552B8F59.3020708@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>	 <20150410141552.GC3057@linutronix.de> <1428758159.10417.13.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428758159.10417.13.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/11/2015 03:15 PM, Mike Galbraith wrote:
> @@ -117,10 +113,8 @@ bool irq_work_queue(struct irq_work *wor
>         if (work->flags & IRQ_WORK_HARD_IRQ) {
>                 if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
>                         arch_irq_work_raise();
> -       } else {
> -               if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
> -                       arch_irq_work_raise();
> -       }
> +       } /* for lazy_list we have the timer irq */
> 
> If we don't queue work without IRQ_WORK_HARD_IRQ set, how does it run?

We schedule the timer softirq which does the work in the non
IRQ_WORK_HARD_IRQ case.

> Anyway, box did not livelock, nor did it with that bit reverted.
> 
>> you could drop the hrtimer hacks. Is this the remaining part all 
>> that is
>> required or we shorten the following patch a little more?
> 
> rt, nohz_full: fix nohz_full for PREEMPT_RT_FULL
> 
> A task being ticked and trying to shut the tick down will fail due
> to having just awakened ksoftirqd, subtract it from nr_running.

thanks.

> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
>  kernel/sched/core.c      |   17 ++++++++++++++++-
>  kernel/time/tick-sched.c |    5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -781,14 +781,29 @@ static inline bool got_nohz_idle_kick(vo
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> +
> +static int ksoftirqd_running(void)
> +{
> +       struct task_struct *softirqd;
> +
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> +               return 0;
> +       softirqd = this_cpu_ksoftirqd();
> +       if (softirqd && softirqd->on_rq)
> +               return 1;
> +       return 0;
> +}
> +
>  bool sched_can_stop_tick(void)
>  {
>         /*
>          * More than one running task need preemption.
>          * nr_running update is assumed to be visible
>          * after IPI is sent from wakers.
> +        *
> +        * NOTE, RT: if ksoftirqd is awake, subtract it.
>          */
> -       if (this_rq()->nr_running > 1)
> +       if (this_rq()->nr_running - ksoftirqd_running() > 1)
>                 return false;
>  
>         return true;
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -227,7 +227,12 @@ void __tick_nohz_full_check(void)
>  
>  static void nohz_full_kick_work_func(struct irq_work *work)
>  {
> +       unsigned long flags;
> +
> +       /* ksoftirqd processes sirqs with interrupts enabled */
> +       local_irq_save(flags);
>         __tick_nohz_full_check();
> +       local_irq_restore(flags);
>  }
>  
>  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
> 
Sebastian
