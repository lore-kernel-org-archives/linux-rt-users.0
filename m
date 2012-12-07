From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 1/4] sched/rt: Fix push_rt_task() to have the same checks as the caller did
Date: Fri, 07 Dec 2012 18:56:16 -0500
Message-ID: <20121208000900.355567465@goodmis.org>
References: <20121207235615.206108556@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=fix-push-rt-task-check.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Currently, the push_rt_task() only pushes the task if it is lower
priority than the currently running task.

But this is not the only check. If the currently running task is also
pinned, we may want to push as well, and we do this check when we wake
up a task, but then we are guaranteed to fail pushing the task because
the internal checks may fail.

Make the check the same as the wakeup checks. We could remove the
check in the wake up and just let the push_rt_task() do the work,
but this makes the wake up exit this check on the likely case that
"ok_to_push_task()" will fail, and that we don't need to do the
iterative loop of checks on the pushable task list.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c
+++ linux-rt.git/kernel/sched/rt.c
@@ -1615,6 +1615,15 @@ static struct task_struct *pick_next_pus
 	return p;
 }
 
+static int ok_to_push_task(struct task_struct *p, struct task_struct *curr)
+{
+	return p->nr_cpus_allowed > 1 &&
+		rt_task(curr) &&
+		(curr->migrate_disable ||
+		 curr->nr_cpus_allowed < 2 ||
+		 curr->prio <= p->prio);
+}
+
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
@@ -1649,7 +1658,7 @@ retry:
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (!ok_to_push_task(next_task, rq->curr)) {
 		resched_task(rq->curr);
 		return 0;
 	}
@@ -1814,10 +1823,7 @@ static void task_woken_rt(struct rq *rq,
 	if (!task_running(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    has_pushable_tasks(rq) &&
-	    p->nr_cpus_allowed > 1 &&
-	    rt_task(rq->curr) &&
-	    (rq->curr->nr_cpus_allowed < 2 ||
-	     rq->curr->prio <= p->prio))
+	    ok_to_push_task(p, rq->curr))
 		push_rt_tasks(rq);
 }
 
