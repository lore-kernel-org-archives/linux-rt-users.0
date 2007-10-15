From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/7] RT: Add a per-cpu rt_overload indication
Date: Mon, 15 Oct 2007 13:42:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710151340390.26495@gandalf.stny.rr.com>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
 <20071013001538.7444.80168.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932859AbXJORm4@vger.kernel.org>
In-Reply-To: <20071013001538.7444.80168.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Fri, 12 Oct 2007, Gregory Haskins wrote:

> The system currently evaluates all online CPUs whenever one or more enters
> an rt_overload condition.  This suffers from scalability limitations as
> the # of online CPUs increases.  So we introduce a cpumask to track
> exactly which CPUs need RT balancing.
>
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> CC: Peter W. Morreale <pmorreale@novell.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

This patch seems reasonable to me. I'll pull it into the queue unless
there's any NACKs.

-- Steve

> ---
>
>  kernel/sched.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 86ff36d..0a1ad0e 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -632,6 +632,7 @@ static inline struct rq *this_rq_lock(void)
>
>  #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
>  static __cacheline_aligned_in_smp atomic_t rt_overload;
> +static cpumask_t rto_cpus;
>  #endif
>
>  static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
> @@ -640,8 +641,11 @@ static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
>  	if (rt_task(p)) {
>  		rq->rt_nr_running++;
>  # ifdef CONFIG_SMP
> -		if (rq->rt_nr_running == 2)
> +		if (rq->rt_nr_running == 2) {
> +			cpu_set(rq->cpu, rto_cpus);
> +			smp_wmb();
>  			atomic_inc(&rt_overload);
> +		}
>  # endif
>  	}
>  #endif
> @@ -654,8 +658,10 @@ static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
>  		WARN_ON(!rq->rt_nr_running);
>  		rq->rt_nr_running--;
>  # ifdef CONFIG_SMP
> -		if (rq->rt_nr_running == 1)
> +		if (rq->rt_nr_running == 1) {
>  			atomic_dec(&rt_overload);
> +			cpu_clear(rq->cpu, rto_cpus);
> +		}
>  # endif
>  	}
>  #endif
> @@ -1624,7 +1630,7 @@ static void balance_rt_tasks(struct rq *this_rq, int this_cpu)
>  	 */
>  	next = pick_next_task(this_rq, this_rq->curr);
>
> -	for_each_online_cpu(cpu) {
> +	for_each_cpu_mask(cpu, rto_cpus) {
>  		if (cpu == this_cpu)
>  			continue;
>  		src_rq = cpu_rq(cpu);
>
>
>
