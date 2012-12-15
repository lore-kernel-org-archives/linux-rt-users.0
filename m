From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.6.9-rt21
Date: Sat, 15 Dec 2012 04:52:09 +0100
Message-ID: <1355543529.20987.6.camel@marge.simpson.net>
References: <alpine.LFD.2.02.1212051659160.2701@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:65175 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab2LODwN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Dec 2012 22:52:13 -0500
In-Reply-To: <alpine.LFD.2.02.1212051659160.2701@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-12-05 at 17:05 +0100, Thomas Gleixner wrote: 
> Dear RT Folks,
> 
> I'm pleased to announce the 3.6.9-rt21 release. 3.6.7-rt18, 3.6.8-rt19
> and 3.6.9-rt20 are not announced updates to the respective 3.6.y
> stable releases without any RT changes
> 
> Changes since 3.6.9-rt20:
> 
>    * Fix the PREEMPT_LAZY implementation on ARM
> 
>    * Fix the RCUTINY issues
> 
>    * Fix a long standing scheduler bug (See commit log of
>      sched-enqueue-to-head.patch)

That last has an oversight buglet.

sched: add missing userspace->kernel struct sched_param.sched_priority inversion

Signed-off-by: Mike Galbraith <bitbucket@online.de>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4624,7 +4624,7 @@ static int __sched_setscheduler(struct t
 	p->sched_reset_on_fork = reset_on_fork;
 
 	oldprio = p->prio;
-	if (oldprio == param->sched_priority)
+	if (oldprio == (MAX_RT_PRIO - 1) - param->sched_priority)
 		goto out;
 
 	on_rq = p->on_rq;


