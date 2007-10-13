From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 7/7] RT: (RFC) Only try to pull tasks in if we are downgrading
	our priority
Date: Fri, 12 Oct 2007 20:16:09 -0400
Message-ID: <20071013001609.7444.60149.stgit@novell1.haskins.net>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:33511
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760924AbXJMA3a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 20:29:30 -0400
In-Reply-To: <20071013001052.7444.8363.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current code runs the balance_rt_tasks() on every _schedule()
once the system enters an overload state.  Now that we have better
distribution on the push side, we can reduce the conditions that
require us to pull tasks.  They are as follows:

At the time of a _schedule(), if our priority is staying the same or
going logically higher between _prev_ and _next_ we can skip trying
to balance tasks because any tasks that were runnable by our queue
have already been pushed to us.  However, if our priority is
transitioning lower AND some CPUs out there are in overload, we
should check to see if we can pull some over.

Note: DO NOT RUN TEST WITH THIS PATCH APPLIED !

This patch is a concept only (for now) and is here for
demonstration/comment purposes only.  The current series is still
racy with respect to acquiring the lowest RQ in the system.  The
concept in this patch is predicated on raceless distribution to our
current priority level.  So the current balancer is a nice big
safety net to cleanup any issues related to that. This patch
effectively takes that net away, so we need to be sure we have all
our ducks lined up before turning this one on.  But once we do we can
eliminate the (fairly expensive) checks (e.g. rq double-locks, etc)
in a subset (hopefully significant #) of the calls to schedule(),
which sounds like a good optimization to me ;)  We shall see if that
pans out.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index b79b968..9e1f3ec 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4118,8 +4118,20 @@ asmlinkage void __sched __schedule(void)
 		sub_preempt_count(PREEMPT_ACTIVE);
 
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
-	if (unlikely(atomic_read(&rt_overload)))
-		balance_rt_tasks(rq, cpu);
+	/*
+	 * If we are switching away from an RT task while the system is in
+	 * overload, we need to see if there is a way we can help a different
+	 * cpu.  If the next task to run is not RT, or if it *is* RT but
+	 * is a logically lower priority, try to balance the system.  Otherwise
+	 * we can skip it, because anyone that could have pushed their tasks
+	 * to us already did.
+	 */
+	if (unlikely(rt_task(prev) && atomic_read(&rt_overload))) {
+		struct task_struct *preview = pick_rt_task(rq, cpu);
+
+		if (!preview || (preview->prio > prev->prio))
+			balance_rt_tasks(rq, cpu);
+	}
 #endif
 
 	if (unlikely(!rq->nr_running))
