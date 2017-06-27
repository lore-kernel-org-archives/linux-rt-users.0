From: Henri Roosen <henri.roosen@ginzinger.com>
Subject: Re: [PATCH V2 2/2] rt: Increase/decrease the nr of migratory tasks
 when enabling/disabling migration
Date: Tue, 27 Jun 2017 16:55:27 +0200
Message-ID: <94154431-a0b2-b106-8c23-519ce866271f@ginzinger.com>
References: <cover.1498482127.git.bristot@redhat.com>
 <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:36254 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdF0Ozi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 10:55:38 -0400
In-Reply-To: <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/26/2017 05:07 PM, Daniel Bristot de Oliveira wrote:
> There is a problem in the migrate_disable()/enable() implementation
> regarding the number of migratory tasks in the rt/dl RQs. The problem
> is the following:
>
> When a task is attached to the rt runqueue, it is checked if it either
> can run in more than one CPU, or if it is with migration disable. If
> either check is true, the rt_rq->rt_nr_migratory counter is not
> increased. The counter increases otherwise.
>
> When the task is detached, the same check is done. If either check is
> true, the rt_rq->rt_nr_migratory counter is not decreased. The counter
> decreases otherwise. The same check is done in the dl scheduler.
>
> One important thing is that, migrate disable/enable does not touch this
> counter for tasks attached to the rt rq. So suppose the following chain
> of events.
>
> Assumptions:
> Task A is the only runnable task in A      Task B runs on the CPU B
> Task A runs on CFS (non-rt)                Task B has RT priority
> Thus, rt_nr_migratory is 0                 B is running
> Task A can run on all CPUS.
>
> Timeline:
>         CPU A/TASK A                        CPU B/TASK B
> A takes the rt mutex X                           .
> A disables migration                             .
>            .                          B tries to take the rt mutex X
>            .                          As it is held by A {
>            .                            A inherits the rt priority of B
>            .                            A is dequeued from CFS RQ of CPU A
>            .                            A is enqueued in the RT RQ of CPU A
>            .                            As migration is disabled
>            .                              rt_nr_migratory in A is not increased
>            .
> A enables migration
> A releases the rt mutex X {
>   A returns to its original priority
>   A ask to be dequeued from RT RQ {
>     As migration is now enabled and it can run on all CPUS {
>        rt_nr_migratory should be decreased
>        As rt_nr_migratory is 0, rt_nr_migratory under flows
>     }
> }
>
> This variable is important because it notifies if there are more than one
> runnable & migratory task in the runqueue. If there are more than one
> tasks, the rt_rq is set as overloaded, and then tries to migrate some
> tasks. This rule is important to keep the scheduler working conserving,
> that is, in a system with M CPUs, the M highest priority tasks should be
> running.
>
> As rt_nr_migratory is unsigned, it will become > 0, notifying that the
> RQ is overloaded, activating pushing mechanism without need.

What kind of symptoms might be triggered by this? I'm currently facing a 
problem with a continuous-reboot-test where the kernel seems to hang 
sometimes at a (seemingly) random place during kernel boot, on 
4.9.33-rt23 with iMX6Q. A back-port of this patch to 4.9-rt seems to fix 
it. Or is it covering up a different problem?

Thanks,
Henri
-- 

>
> This patch fixes this problem by decreasing/increasing the
> rt/dl_nr_migratory in the migrate disable/enable operations.
>
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Reported-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/core.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ce34e4f..7d3565e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7566,6 +7566,47 @@ const u32 sched_prio_to_wmult[40] = {
>
>  #if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
>
> +static inline void
> +update_nr_migratory(struct task_struct *p, long delta)
> +{
> +	if (unlikely((p->sched_class == &rt_sched_class ||
> +		      p->sched_class == &dl_sched_class) &&
> +		      p->nr_cpus_allowed > 1)) {
> +		if (p->sched_class == &rt_sched_class)
> +			task_rq(p)->rt.rt_nr_migratory += delta;
> +		else
> +			task_rq(p)->dl.dl_nr_migratory += delta;
> +	}
> +}
> +
> +static inline void
> +migrate_disable_update_cpus_allowed(struct task_struct *p)
> +{
> +	struct rq *rq;
> +	struct rq_flags rf;
> +
> +	p->cpus_ptr = cpumask_of(smp_processor_id());
> +
> +	rq = task_rq_lock(p, &rf);
> +	update_nr_migratory(p, -1);
> +	p->nr_cpus_allowed = 1;
> +	task_rq_unlock(rq, p, &rf);
> +}
> +
> +static inline void
> +migrate_enable_update_cpus_allowed(struct task_struct *p)
> +{
> +	struct rq *rq;
> +	struct rq_flags rf;
> +
> +	p->cpus_ptr = &p->cpus_mask;
> +
> +	rq = task_rq_lock(p, &rf);
> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> +	update_nr_migratory(p, 1);
> +	task_rq_unlock(rq, p, &rf);
> +}
> +
>  void migrate_disable(void)
>  {
>  	struct task_struct *p = current;
> @@ -7593,10 +7634,9 @@ void migrate_disable(void)
>  	preempt_disable();
>  	preempt_lazy_disable();
>  	pin_current_cpu();
> -	p->migrate_disable = 1;
>
> -	p->cpus_ptr = cpumask_of(smp_processor_id());
> -	p->nr_cpus_allowed = 1;
> +	migrate_disable_update_cpus_allowed(p);
> +	p->migrate_disable = 1;
>
>  	preempt_enable();
>  }
> @@ -7628,9 +7668,8 @@ void migrate_enable(void)
>
>  	preempt_disable();
>
> -	p->cpus_ptr = &p->cpus_mask;
> -	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
>  	p->migrate_disable = 0;
> +	migrate_enable_update_cpus_allowed(p);
>
>  	if (p->migrate_disable_update) {
>  		struct rq *rq;
>
