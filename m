From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 2/4 v2] sched/rt: Try to migrate task if preempting pinned rt task
Date: Wed, 12 Dec 2012 14:27:35 -0500
Message-ID: <20121212193920.529719829@goodmis.org>
References: <20121212192733.221810086@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=fix-post-sched-push.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If a higher priority task is about to preempt a task that has been
pinned to a CPU. Try to first see if the higher priority task can
preempt another task instead.

That is, a high priority process wakes up on a CPU while a currently
running task can still migrate, it will miss pushing that high priority
task to another CPU. If by the time the task schedules, the task
that it's about to preempt could have changed its affinity and
is pinned. At this time, it may be better to move the task to another
CPU if one exists that is currently running a lower priority task
than the one about to be preempted.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c
+++ linux-rt.git/kernel/sched/rt.c
@@ -1804,8 +1804,22 @@ skip:
 
 static void pre_schedule_rt(struct rq *rq, struct task_struct *prev)
 {
+	struct task_struct *p = prev;
+
+	/*
+	 * If we are preempting a pinned task see if we can push
+	 * the higher priority task first.
+	 */
+	if (prev->on_rq && (prev->nr_cpus_allowed <= 1 || prev->migrate_disable) &&
+	    has_pushable_tasks(rq) && rq->rt.highest_prio.next < prev->prio) {
+		p = _pick_next_task_rt(rq);
+
+		if (p != prev && p->nr_cpus_allowed > 1 && push_rt_task(rq))
+			p = _pick_next_task_rt(rq);
+	}
+
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	if (rq->rt.highest_prio.curr > prev->prio)
+	if (rq->rt.highest_prio.curr > p->prio)
 		pull_rt_task(rq);
 }
 
