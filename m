From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: BUG on 2.6.24.3-rt3.
Date: Wed, 5 Mar 2008 14:14:34 +0530
Message-ID: <200803051414.34607.sripathik@in.ibm.com>
References: <200803042249.15945.sripathik@in.ibm.com> <Pine.LNX.4.58.0803041335560.9858@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP01.au.ibm.com ([202.81.18.162]:51352 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbYCEIn6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 03:43:58 -0500
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m258igL5001980
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 19:44:42 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m258lZ3U235062
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 19:47:35 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m258htWM001422
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 19:43:55 +1100
In-Reply-To: <Pine.LNX.4.58.0803041335560.9858@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 05 March 2008 00:24, Steven Rostedt wrote:
> Sripathi,
>
> Thanks for reporting this.
>
> On Tue, 4 Mar 2008, Sripathi Kodi wrote:
> > I can recreate the problem easily and can also get a kdump. Please
> > let me know if any other information will help in analyzing this.
>
> Could you try this patch and let me know if it fixes your problem.

Steve, this patch seems to solve the problem. Thanks a lot!

There seems to be another problem that leads to a system hang. I will 
report it as soon as I can gather more information about it.

Thanks,
Sripathi.


>
> -- Steve
>
> Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>
> ---
>  kernel/sched_rt.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-2.6.24.3-rt3/kernel/sched_rt.c
> ===================================================================
> --- linux-2.6.24.3-rt3.orig/kernel/sched_rt.c	2008-03-04
> 13:49:53.000000000 -0500 +++
> linux-2.6.24.3-rt3/kernel/sched_rt.c	2008-03-04 13:51:27.000000000
> -0500 @@ -840,9 +840,11 @@ static void prio_changed_rt(struct rq *r
> pull_rt_task(rq);
>  		/*
>  		 * If there's a higher priority task waiting to run
> -		 * then reschedule.
> +		 * then reschedule. Note, the above pull_rt_task
> +		 * can release the rq lock and p could migrate.
> +		 * Only reschedule if p is still on the same runqueue.
>  		 */
> -		if (p->prio > rq->rt.highest_prio)
> +		if (p->prio > rq->rt.highest_prio && task_rq(p) == rq)
>  			resched_task(p);
>  #else
>  		/* For UP simply resched on drop of prio */
