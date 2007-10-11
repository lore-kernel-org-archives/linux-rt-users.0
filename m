From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: [PATCH] RT: Fix special-case exception for preempting the local CPU
Date: Thu, 11 Oct 2007 16:21:23 +0530
Message-ID: <20071011105123.GE6721@in.ibm.com>
References: <20071010144824.21333.52155.stgit@novell1.haskins.net> <20071010162248.GB5049@monkey.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: mike kravetz <kravetz@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:33383 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168AbXJKKwS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 06:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20071010162248.GB5049@monkey.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 10, 2007 at 09:22:48AM -0700, mike kravetz wrote:
> On Wed, Oct 10, 2007 at 10:49:35AM -0400, Gregory Haskins wrote:
> > diff --git a/kernel/sched.c b/kernel/sched.c
> > index 3e75c62..b7f7a96 100644
> > --- a/kernel/sched.c
> > +++ b/kernel/sched.c
> > @@ -1869,7 +1869,8 @@ out_activate:
> >  		 * extra locking in this particular case, because
> >  		 * we are on the current CPU.)
> >  		 */
> > -		if (TASK_PREEMPTS_CURR(p, this_rq))
> > +		if (TASK_PREEMPTS_CURR(p, this_rq)
> > +		    && cpu_isset(this_cpu, p->cpus_allowed))
> >  			set_tsk_need_resched(this_rq->curr);
> >  		else
> >  			/*
> 
> I wonder if it might better to explicitly take the rq lock and try to
> put the task on this_rq in this situation?  Rather than waiting for
> schedule to pull it from a remote rq as part of balance_rt_tasks.
> 
> A question that has passed through my head a few times is:  When waking
> a RT task is it better to:
> 1) run on current CPU if possible
> 2) run on CPU task previously ran on
> 
> I think #1 may result in lower latency.  But, if the task has lots of
> cache warmth the lower wakeup latency may be negated by running on a
> 'remote' cpu.

Could we use task_hot() routine to find if the task is cache hot? If it
isn't, if possible, we could run on current CPU, else, if possible, on
the CPU it last ran on?


-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
