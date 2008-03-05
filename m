From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: BUG on 2.6.24.3-rt3.
Date: Wed, 05 Mar 2008 09:05:50 +0100
Message-ID: <47CE545E.9060406@bull.net>
References: <200803042249.15945.sripathik@in.ibm.com> <Pine.LNX.4.58.0803041335560.9858@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sripathi Kodi <sripathik@in.ibm.com>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51274 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177AbYCEIFj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 03:05:39 -0500
In-Reply-To: <Pine.LNX.4.58.0803041335560.9858@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I had this bug also when testing ltp's hrtimer-prio.c.
So far I could not reproduce it but still I applied your patch.
I'll let you know if I find something useful.

Gilles.



Steven Rostedt wrote:

>Sripathi,
>
>Thanks for reporting this.
>
>On Tue, 4 Mar 2008, Sripathi Kodi wrote:
>  
>
>>I can recreate the problem easily and can also get a kdump. Please let
>>me know if any other information will help in analyzing this.
>>    
>>
>
>Could you try this patch and let me know if it fixes your problem.
>
>-- Steve
>
>Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>
>---
> kernel/sched_rt.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>Index: linux-2.6.24.3-rt3/kernel/sched_rt.c
>===================================================================
>--- linux-2.6.24.3-rt3.orig/kernel/sched_rt.c	2008-03-04 13:49:53.000000000 -0500
>+++ linux-2.6.24.3-rt3/kernel/sched_rt.c	2008-03-04 13:51:27.000000000 -0500
>@@ -840,9 +840,11 @@ static void prio_changed_rt(struct rq *r
> 			pull_rt_task(rq);
> 		/*
> 		 * If there's a higher priority task waiting to run
>-		 * then reschedule.
>+		 * then reschedule. Note, the above pull_rt_task
>+		 * can release the rq lock and p could migrate.
>+		 * Only reschedule if p is still on the same runqueue.
> 		 */
>-		if (p->prio > rq->rt.highest_prio)
>+		if (p->prio > rq->rt.highest_prio && task_rq(p) == rq)
> 			resched_task(p);
> #else
> 		/* For UP simply resched on drop of prio */
>--
>To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>  
>

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Gilles.Carry
Linux Project team
mailto: gilles.carry@bull.net
Phone: +33 (0)4 76 29 74 27
Addr.: BULL S.A.  1 rue de Provence, B.P. 208 38432 Echirolles Cedex
http://www.bull.com
http://www.bullopensource.org/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

