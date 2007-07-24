From: John Sigler <linux.kernel@free.fr>
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Tue, 24 Jul 2007 12:36:22 +0200
Message-ID: <46A5D626.6070009@free.fr>
References: <20070723125925.GE8055@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:46519 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222AbXGXKf7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:35:59 -0400
In-Reply-To: <20070723125925.GE8055@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ankita Garg wrote:

> This patch adds support to display captured -rt stats under /proc/schedstat.
> 
> Signed-off-by: Ankita Garg <ankita@in.ibm.com>
> --
>  sched_stats.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.22.1/kernel/sched_stats.h
> ===================================================================
> --- linux-2.6.22.1.orig/kernel/sched_stats.h	2007-07-23 18:15:57.000000000 +0530
> +++ linux-2.6.22.1/kernel/sched_stats.h	2007-07-23 18:24:03.000000000 +0530
> @@ -21,12 +21,15 @@
>  
>  		/* runqueue-specific stats */
>  		seq_printf(seq,
> -		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %llu %lu",
> +		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %lu %lu %lu %llu %lu",
>  		    cpu, rq->yld_both_empty,
>  		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
>  		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
>  		    rq->ttwu_cnt, rq->ttwu_local,
>  		    rq->rq_sched_info.cpu_time,
> +#ifdef CONFIG_PREEMPT_RT
> +		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled,
> +#endif
>  		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
>  
>  		seq_printf(seq, "\n");

I know you've written a new patch that makes this one obsolete, but I 
wanted to discuss this specific patch.

Originally, there were 13 conversion specifications, and your patch
adds 3, for a total of 16 conversion specifications.

However, if CONFIG_PREEMPT_RT is not defined, then seq_printf is
called with only 13 arguments.

Is it safe to call seq_printf with too few arguments?

Calling printf(3) with too few arguments leads to undefined behavior.

seq_printf is a wrapper around vsnprintf() so there might be no issue?

Regards.
