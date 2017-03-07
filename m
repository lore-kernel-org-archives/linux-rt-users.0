From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/10] sched/rt: Add a missing rescheduling point
Date: Tue, 07 Mar 2017 16:20:47 -0500
Message-ID: <20170307212314.039140627@goodmis.org>
References: <20170307212041.431615000@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-sched-rt-Add-a-missing-rescheduling-point.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.50-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Since the change in commit:

  fd7a4bed1835 ("sched, rt: Convert switched_{from, to}_rt() / prio_changed_rt() to balance callbacks")

... we don't reschedule a task under certain circumstances:

Lets say task-A, SCHED_OTHER, is running on CPU0 (and it may run only on
CPU0) and holds a PI lock. This task is removed from the CPU because it
used up its time slice and another SCHED_OTHER task is running. Task-B on
CPU1 runs at RT priority and asks for the lock owned by task-A. This
results in a priority boost for task-A. Task-B goes to sleep until the
lock has been made available. Task-A is already runnable (but not active),
so it receives no wake up.

The reality now is that task-A gets on the CPU once the scheduler decides
to remove the current task despite the fact that a high priority task is
enqueued and waiting. This may take a long time.

The desired behaviour is that CPU0 immediately reschedules after the
priority boost which made task-A the task with the lowest priority.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: fd7a4bed1835 ("sched, rt: Convert switched_{from, to}_rt() prio_changed_rt() to balance callbacks")
Link: http://lkml.kernel.org/r/20170124144006.29821-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 3 +--
 kernel/sched/rt.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7a72e69fcf65..20e0c9b9ace5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1772,12 +1772,11 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 #ifdef CONFIG_SMP
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->dl.overloaded)
 			queue_push_tasks(rq);
-#else
+#endif
 		if (dl_task(rq->curr))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
-#endif
 	}
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8cf360d309ec..4ac6937f4a65 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2138,10 +2138,9 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 #ifdef CONFIG_SMP
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->rt.overloaded)
 			queue_push_tasks(rq);
-#else
+#endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio)
 			resched_curr(rq);
-#endif /* CONFIG_SMP */
 	}
 }
 
-- 
2.10.2
