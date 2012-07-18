From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Avoid updating RT entry timeout twice within
 one tick period
Date: Wed, 18 Jul 2012 13:34:26 -0400
Message-ID: <1342632866.11900.12.camel@gandalf.stny.rr.com>
References: <1342508623-2887-1-git-send-email-ying.xue@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	peterz@infradead.org, tglx@linutronix.de, mingo@elte.hu,
	yong.zhang0@gmail.com
To: Ying Xue <ying.xue@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19871 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab2GRRe3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jul 2012 13:34:29 -0400
In-Reply-To: <1342508623-2887-1-git-send-email-ying.xue@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-07-17 at 15:03 +0800, Ying Xue wrote:

> To solve the issue, we prevent the timeout value from increasing twice
> within one tick time by remembering the jiffies value of lastly updating
> the timeout. As long as the RT task's jiffies is different with the
> global jiffies value, we allow its timeout to be updated.

Peter, I'm fine with this change. Do you want to pick it up. It looks
like it can affect mainline as well.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Ying Xue <ying.xue@windriver.com>
> Signed-off-by: Fan Du <fan.du@windriver.com>
> Reviewed-by: Yong Zhang <yong.zhang0@gmail.com>
> ---
>  include/linux/sched.h |    1 +
>  kernel/sched/rt.c     |    6 +++++-
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4a1f493..f0656a2 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1199,6 +1199,7 @@ struct sched_entity {
>  struct sched_rt_entity {
>  	struct list_head run_list;
>  	unsigned long timeout;
> +	unsigned long watchdog_stamp;
>  	unsigned int time_slice;
>  
>  	struct sched_rt_entity *back;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 573e1ca..8240d4f 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1976,7 +1976,11 @@ static void watchdog(struct rq *rq, struct task_struct *p)
>  	if (soft != RLIM_INFINITY) {
>  		unsigned long next;
>  
> -		p->rt.timeout++;
> +		if (p->rt.watchdog_stamp != jiffies) {
> +			p->rt.timeout++;
> +			p->rt.watchdog_stamp = jiffies;
> +		}
> +
>  		next = DIV_ROUND_UP(min(soft, hard), USEC_PER_SEC/HZ);
>  		if (p->rt.timeout > next)
>  			p->cputime_expires.sched_exp = p->se.sum_exec_runtime;


