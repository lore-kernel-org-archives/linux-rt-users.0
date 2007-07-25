From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Wed, 25 Jul 2007 11:38:43 +0530
Message-ID: <20070725060843.GB7745@in.ibm.com>
References: <20070723125925.GE8055@in.ibm.com> <46A5D626.6070009@free.fr>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:46749 "EHLO
	ausmtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbXGYGJJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 02:09:09 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6P69WVx4435980
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 16:09:34 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6P6CJvZ210530
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 16:12:19 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6P68iYf031598
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 16:08:45 +1000
Content-Disposition: inline
In-Reply-To: <46A5D626.6070009@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 12:36:22PM +0200, John Sigler wrote:
> Ankita Garg wrote:
> 
> >This patch adds support to display captured -rt stats under 
> >/proc/schedstat.
> >
> >Signed-off-by: Ankita Garg <ankita@in.ibm.com>
> >--
> > sched_stats.h |    5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >Index: linux-2.6.22.1/kernel/sched_stats.h
> >===================================================================
> >--- linux-2.6.22.1.orig/kernel/sched_stats.h	2007-07-23 
> >18:15:57.000000000 +0530
> >+++ linux-2.6.22.1/kernel/sched_stats.h	2007-07-23 
> >18:24:03.000000000 +0530
> >@@ -21,12 +21,15 @@
> > 
> > 		/* runqueue-specific stats */
> > 		seq_printf(seq,
> >-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %llu 
> >%lu",
> >+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %lu %lu 
> >%lu %llu %lu",
> > 		    cpu, rq->yld_both_empty,
> > 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
> > 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
> > 		    rq->ttwu_cnt, rq->ttwu_local,
> > 		    rq->rq_sched_info.cpu_time,
> >+#ifdef CONFIG_PREEMPT_RT
> >+		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled,
> >+#endif
> > 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
> > 
> > 		seq_printf(seq, "\n");
> 
> I know you've written a new patch that makes this one obsolete, but I 
> wanted to discuss this specific patch.
> 
> Originally, there were 13 conversion specifications, and your patch
> adds 3, for a total of 16 conversion specifications.
> 
> However, if CONFIG_PREEMPT_RT is not defined, then seq_printf is
> called with only 13 arguments.
> 
> Is it safe to call seq_printf with too few arguments?

So I tried to run the code disabling CONFIG_PREEMPT_RT, to see the
behavior vsnprintf() on supplying fewer arguments. Arbit/garbage value is 
printed for conversion specifications that do not have a matching argument.
It did not cause any issue at all beyond that point. But considering the
correctness and quality of code, was going to post the updated patch (if
the re-work had not happened)!

> 
> Calling printf(3) with too few arguments leads to undefined behavior.
> 
> seq_printf is a wrapper around vsnprintf() so there might be no issue?
> 
> Regards.

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
