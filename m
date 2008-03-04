From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG on 2.6.24.3-rt3.
Date: Tue, 4 Mar 2008 13:54:23 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803041335560.9858@gandalf.stny.rr.com>
References: <200803042249.15945.sripathik@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu
To: Sripathi Kodi <sripathik@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:40276 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbYCDSy0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 13:54:26 -0500
In-Reply-To: <200803042249.15945.sripathik@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Sripathi,

Thanks for reporting this.

On Tue, 4 Mar 2008, Sripathi Kodi wrote:
>
>
> I can recreate the problem easily and can also get a kdump. Please let
> me know if any other information will help in analyzing this.

Could you try this patch and let me know if it fixes your problem.

-- Steve

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

---
 kernel/sched_rt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.24.3-rt3/kernel/sched_rt.c
===================================================================
--- linux-2.6.24.3-rt3.orig/kernel/sched_rt.c	2008-03-04 13:49:53.000000000 -0500
+++ linux-2.6.24.3-rt3/kernel/sched_rt.c	2008-03-04 13:51:27.000000000 -0500
@@ -840,9 +840,11 @@ static void prio_changed_rt(struct rq *r
 			pull_rt_task(rq);
 		/*
 		 * If there's a higher priority task waiting to run
-		 * then reschedule.
+		 * then reschedule. Note, the above pull_rt_task
+		 * can release the rq lock and p could migrate.
+		 * Only reschedule if p is still on the same runqueue.
 		 */
-		if (p->prio > rq->rt.highest_prio)
+		if (p->prio > rq->rt.highest_prio && task_rq(p) == rq)
 			resched_task(p);
 #else
 		/* For UP simply resched on drop of prio */
