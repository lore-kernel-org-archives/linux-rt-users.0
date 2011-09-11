From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Sun, 11 Sep 2011 19:01:22 +0200
Message-ID: <1315760482.6352.10.camel@marge.simson.net>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315737307.6544.1.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:60433 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752172Ab1IKRB0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Sep 2011 13:01:26 -0400
In-Reply-To: <1315737307.6544.1.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2011-09-11 at 12:35 +0200, Mike Galbraith wrote:
> On Sat, 2011-09-10 at 11:12 +0200, Thomas Gleixner wrote: 
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 3.0.4-rt13 release.
> > 
> > Changes versus 3.0.2-rt11
> > 
> >   * Migrate disable cure (Mike, Peter)
> 
> The warning triggers.

Seems in_atomic() is not pair inclusive.  This does not gripe.

---
 include/linux/sched.h |    3 ---
 kernel/sched.c        |   15 ++-------------
 2 files changed, 2 insertions(+), 16 deletions(-)

Index: linux-3.0-tip/kernel/sched.c
===================================================================
--- linux-3.0-tip.orig/kernel/sched.c
+++ linux-3.0-tip/kernel/sched.c
@@ -6317,16 +6317,10 @@ void migrate_disable(void)
 	struct rq *rq;
 
 	if (in_atomic()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic++;
-#endif
+		p->migrate_disable++;
 		return;
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(p->migrate_disable_atomic);
-#endif
-
 	preempt_disable();
 	if (p->migrate_disable) {
 		p->migrate_disable++;
@@ -6376,15 +6370,10 @@ void migrate_enable(void)
 	struct rq *rq;
 
 	if (in_atomic()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic--;
-#endif
+		p->migrate_disable--;
 		return;
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(p->migrate_disable_atomic);
-#endif
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 
 	preempt_disable();
Index: linux-3.0-tip/include/linux/sched.h
===================================================================
--- linux-3.0-tip.orig/include/linux/sched.h
+++ linux-3.0-tip/include/linux/sched.h
@@ -1262,9 +1262,6 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
-#ifdef CONFIG_SCHED_DEBUG
-	int migrate_disable_atomic;
-#endif
 #endif
 	cpumask_t cpus_allowed;
 


