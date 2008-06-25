From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 1/3] sched: limit "all_pinned" balance attempts to
	sd->span
Date: Wed, 25 Jun 2008 07:19:10 -0600
Message-ID: <48620D8E.BA47.005A.0@novell.com>
References: <20080624141527.28487.77778.stgit@lsg.lsg.lab.novell.com>
 <20080624141602.28487.81775.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <peterz@infradead.org>, "David Bahi" <DBahi@novell.com>,
	<npiggin@suse.de>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>, <rostedt@goodmis.org>, <tglx@linutronix.de>,
	"Gregory Haskins" <GHaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757839AbYFYNTY@vger.kernel.org>
In-Reply-To: <20080624141602.28487.81775.stgit@lsg.lsg.lab.novell.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>>> On Tue, Jun 24, 2008 at 10:16 AM, in message
<20080624141602.28487.81775.stgit@lsg.lsg.lab.novell.com>, Gregory Haskins
<ghaskins@novell.com> wrote: 
> Load-balancing will never terminate if all cpus are "all_pinned" with
> the current algorithm.  This would be pretty unlikely to occur, but we
> should protect against it nonetheless.

Hmm...after thinking about this some more, I think I was wrong and this is unfounded.

The code would eventually terminate when the f_b_g()/f_b_q() cant find a good target.

Pls ignore this patch.

Regards,
-Greg

> 
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
> 
>  kernel/sched.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 31f91d9..54b27b4 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -3178,7 +3178,8 @@ static int load_balance(int this_cpu, struct rq 
> *this_rq,
>  	struct sched_group *group;
>  	unsigned long imbalance;
>  	struct rq *busiest;
> -	cpumask_t cpus = CPU_MASK_ALL;
> +	cpumask_t cpus = sd->span;
> +	int remain = cpus_weight(sd->span) - 1;
>  	unsigned long flags;
>  
>  	/*
> @@ -3237,11 +3238,10 @@ redo:
>  			resched_cpu(this_cpu);
>  
>  		/* All tasks on this runqueue were pinned by CPU affinity */
> -		if (unlikely(all_pinned)) {
> +		if (unlikely(all_pinned && remain)) {
>  			cpu_clear(cpu_of(busiest), cpus);
> -			if (!cpus_empty(cpus))
> -				goto redo;
> -			goto out_balanced;
> +			remain--;
> +			goto redo;
>  		}
>  	}
>  
> @@ -3332,7 +3332,8 @@ load_balance_newidle(int this_cpu, struct rq *this_rq, 
> struct sched_domain *sd)
>  	int ld_moved = 0;
>  	int sd_idle = 0;
>  	int all_pinned = 0;
> -	cpumask_t cpus = CPU_MASK_ALL;
> +	cpumask_t cpus = sd->span;
> +	int remain = cpus_weight(sd->span) - 1;
>  
>  	/*
>  	 * When power savings policy is enabled for the parent domain, idle
> @@ -3375,10 +3376,10 @@ redo:
>  					&all_pinned);
>  		spin_unlock(&busiest->lock);
>  
> -		if (unlikely(all_pinned)) {
> +		if (unlikely(all_pinned && remain)) {
>  			cpu_clear(cpu_of(busiest), cpus);
> -			if (!cpus_empty(cpus))
> -				goto redo;
> +			remain--;
> +			goto redo;
>  		}
>  	}
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
