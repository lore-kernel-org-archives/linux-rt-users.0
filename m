From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: AW: [PATCH RT 1/2] sched: Queue RT tasks to head when prio drops
Date: Fri, 14 Dec 2012 17:23:58 -0500
Message-ID: <1355523838.17101.410.camel@gandalf.local.home>
References: <20121212004557.110050982@goodmis.org>
	 <20121212004820.598190405@goodmis.org>
	 <12C1B74BDFD05D40B2356A9B12DFA339629E283782@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:22548 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab2LNWYA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Dec 2012 17:24:00 -0500
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA339629E283782@KEBMXSPMB01.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-14 at 09:13 +0100, eg Engleder Gerhard wrote:
> Hello,
> 
> we tested this patch successfully with 3.2.35-rt53-rc1. The failure
> could not be reproduced in a 16 hours test run, so we are pretty
> sure that the failure is gone.
> 
> Thanks for the quick inclusion of this pacth in stable-rt series!

Unfortunately there seems to be a bug in the patch, and it needs to be
fixed in Thomas's tree before I take it.


> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 1f9d6f5..054e669 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4117,6 +4117,8 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
>  
>  	trace_sched_pi_setprio(p, prio);
>  	oldprio = p->prio;
> +	if (oldprio == prio)
> +		goto out_unlock;
>  	prev_class = p->sched_class;
>  	on_rq = p->on_rq;
>  	running = task_current(rq, p);
> @@ -4472,6 +4474,13 @@ recheck:
>  		task_rq_unlock(rq, p, &flags);
>  		goto recheck;
>  	}
> +
> +	p->sched_reset_on_fork = reset_on_fork;
> +
> +	oldprio = p->prio;
> +	if (oldprio == param->sched_priority)

Needs to be:

	if (oldprio == (MAX_RT_PRIO - 1) - param->sched_priority)


-- Steve

> +		goto out;
> +
>  	on_rq = p->on_rq;
>  	running = task_current(rq, p);
>  	if (on_rq)
> @@ -4479,18 +4488,17 @@ recheck:
>  	if (running)
>  		p->sched_class->put_prev_task(rq, p);
>  
> -	p->sched_reset_on_fork = reset_on_fork;
> -
> -	oldprio = p->prio;
>  	prev_class = p->sched_class;
>  	__setscheduler(rq, p, policy, param->sched_priority);
>  
>  	if (running)
>  		p->sched_class->set_curr_task(rq);
>  	if (on_rq)
> -		enqueue_task(rq, p, 0);
> +		enqueue_task(rq, p, oldprio < param->sched_priority ?
> +			     ENQUEUE_HEAD : 0);
>  
>  	check_class_changed(rq, p, prev_class, oldprio);
> +out:
>  	task_rq_unlock(rq, p, &flags);
>  
>  	rt_mutex_adjust_pi(p);
> --
> 1.7.10.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


