From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH 6/7] RT: Select tasks based on relative affinity
Date: Mon, 15 Oct 2007 16:08:45 -0400
Message-ID: <1192478925.4067.89.camel@ghaskins-t60p.haskins.net>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
	 <20071013001604.7444.39391.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:54503 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063AbXJOULP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 16:11:15 -0400
In-Reply-To: <20071013001604.7444.39391.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-10-12 at 20:16 -0400, Gregory Haskins wrote:
> In theory, tasks will be most efficient if they are allowed to re-wake to
> the CPU that they last ran on due to cache affinity.  Short of that, it is
> cheaper to wake up the current CPU.  If neither of those two are options,
> than the lowest CPU will do. 
> 
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
> 
>  kernel/sched.c |   72 +++++++++++++++++++++++++++++++++++++++++---------------
>  1 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 3c71156..b79b968 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -1511,6 +1511,15 @@ static int double_lock_balance(struct rq *this_rq, struct rq *busiest);
>  /* Only try this algorithm three times */
>  #define RT_PUSH_MAX_TRIES 3
>  
> +static int non_rt_cpu(cpumask_t *mask, int cpu)
> +{
> +	if (!rt_prio(cpu_rq(cpu)->curr_prio) &&
> +	    cpu_isset(cpu, *mask))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* Will lock the rq it finds */
>  static int find_lowest_cpu(cpumask_t *cpu_mask, struct task_struct *task,
>  				 struct rq *this_rq)
> @@ -1519,32 +1528,57 @@ static int find_lowest_cpu(cpumask_t *cpu_mask, struct task_struct *task,
>  	int dst_cpu = -1;
>  	int cpu;
>  	int tries;
> +	int this_cpu = smp_processor_id();
>  
>  	for (tries = 0; tries < RT_PUSH_MAX_TRIES; tries++) {
> +
>  		/*
> -		 * Scan each rq for the lowest prio.
> +		 * We select a CPU in the following priority:
> +		 *
> +		 *       task_cpu, this_cpu, first_cpu
> +		 *
> +		 * for efficiency.
> +		 *
> +		 * - task_cpu preserves cache affinity

After thinking about this over the weekend, the task_cpu optimization
doesn't make sense.  It made sense in my original design before I
integrated with Steve's series, but not here.  I think the second
optimization (this_cpu) still makes sense though, so I will update this
patch for the next drop.

> +		 * - this_cpu is (presumably) cheaper to preempt
> +		 *   (note that sometimes task_cpu and this_cpu
> +		 *   are the same).
> +		 * - Finally, we will take whatever is available
> +		 *   if the first two don't pan out by scanning.
>  		 */
> -		for_each_cpu_mask(cpu, *cpu_mask) {
> -			struct rq *rq = &per_cpu(runqueues, cpu);
> -
> -			if (cpu == smp_processor_id())
> -				continue;
> -
> -			/* We look for lowest RT prio or non-rt CPU */
> -			if (rq->curr_prio >= MAX_RT_PRIO) {
> -				lowest_rq = rq;
> -				dst_cpu = cpu;
> -				break;
> -			}
> +		if (non_rt_cpu(cpu_mask, task_cpu(task))) {
> +			lowest_rq = task_rq(task);	
> +			dst_cpu = lowest_rq->cpu;
> +		} else if (non_rt_cpu(cpu_mask, this_cpu)) {
> +			dst_cpu = this_cpu;
> +			lowest_rq = cpu_rq(this_cpu);	
> +		} else {
>  
> -			/* no locking for now */
> -			if (rq->curr_prio > task->prio &&
> -			    (!lowest_rq || rq->curr_prio < lowest_rq->curr_prio)) {
> -				dst_cpu = cpu;
> -				lowest_rq = rq;
> +			/*
> +			 * Scan each rq for the lowest prio.
> +			 */
> +			for_each_cpu_mask(cpu, *cpu_mask) {
> +				struct rq *rq = &per_cpu(runqueues, cpu);
> +				
> +				if (cpu == this_cpu)
> +					continue;
> +				
> +				/* We look for lowest RT prio or non-rt CPU */
> +				if (rq->curr_prio >= MAX_RT_PRIO) {
> +					lowest_rq = rq;
> +					dst_cpu = cpu;
> +					break;
> +				}
> +				
> +				/* no locking for now */
> +				if (rq->curr_prio > task->prio &&
> +				    (!lowest_rq || rq->curr_prio < lowest_rq->curr_prio)) {
> +					dst_cpu = cpu;
> +					lowest_rq = rq;
> +				}
>  			}
>  		}
> -
> +			
>  		if (!lowest_rq) {
>  			dst_cpu = -1;
>  			break;
> 
