From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/2] sched: Queue RT tasks to head when prio drops
Date: Tue, 11 Dec 2012 19:53:43 -0500
Message-ID: <20121212005413.333977402@goodmis.org>
References: <20121212005342.348897923@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable@vger.kernel.org>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-sched-Queue-RT-tasks-to-head-when-prio-drops.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The following scenario does not work correctly:

Runqueue of CPU1 contains two runnable and pinned tasks:
	 T1: SCHED_FIFO, prio 80
	 T2: SCHED_FIFO, prio 80

T1 is on the cpu and executes the following syscalls (classic priority
ceiling scenario):

 sys_sched_setscheduler(pid(T1), SCHED_FIFO, .prio = 90);
 ...
 sys_sched_setscheduler(pid(T1), SCHED_FIFO, .prio = 80);
 ...

Now T1 gets preempted by T3 (SCHED_FIFO, prio 95). After T3 goes back
to sleep the scheduler picks T2. Surprise!

The same happens w/o actual preemption when T1 is forced into the
scheduler due to a sporadic NEED_RESCHED event. The scheduler invokes
pick_next_task() which returns T2. So T1 gets preempted and scheduled
out.

This happens because sched_setscheduler() dequeues T1 from the prio 90
list and then enqueues it on the tail of the prio 80 list behind T2.
This violates the POSIX spec and surprises user space which relies on
the guarantee that SCHED_FIFO tasks are not scheduled out unless they
give the CPU up voluntarily or are preempted by a higher priority
task. In the latter case the preempted task must get back on the CPU
after the preempting task schedules out again.

We fixed a similar issue already in commit 60db48c(sched: Queue a
deboosted task to the head of the RT prio queue). The same treatment
is necessary for sched_setscheduler().

While analyzing the problem I noticed that the fix in
rt_mutex_setprio() is one off. The head queueing depends on old
priority greater than new priority (user space view), but in fact it
needs to have the same treatment for equal priority. Instead of
blindly changing the condition to <= it's better to avoid the whole
dequeue/requeue business for the equal priority case completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 2cf4c4b..0977f02 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5021,6 +5021,8 @@ void task_setprio(struct task_struct *p, int prio)
 
 	trace_sched_pi_setprio(p, prio);
 	oldprio = p->prio;
+	if (oldprio == prio)
+		goto out_unlock;
 	prev_class = p->sched_class;
 	on_rq = p->on_rq;
 	running = task_current(rq, p);
@@ -5370,6 +5372,13 @@ recheck:
 		task_rq_unlock(rq, p, &flags);
 		goto recheck;
 	}
+
+	p->sched_reset_on_fork = reset_on_fork;
+
+	oldprio = p->prio;
+	if (oldprio == param->sched_priority)
+		goto out;
+
 	on_rq = p->on_rq;
 	running = task_current(rq, p);
 	if (on_rq)
@@ -5377,18 +5386,17 @@ recheck:
 	if (running)
 		p->sched_class->put_prev_task(rq, p);
 
-	p->sched_reset_on_fork = reset_on_fork;
-
-	oldprio = p->prio;
 	prev_class = p->sched_class;
 	__setscheduler(rq, p, policy, param->sched_priority);
 
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq)
-		activate_task(rq, p, 0);
+		activate_task(rq, p, oldprio < param->sched_priority ?
+			      ENQUEUE_HEAD : 0);
 
 	check_class_changed(rq, p, prev_class, oldprio);
+out:
 	task_rq_unlock(rq, p, &flags);
 
 	rt_mutex_adjust_pi(p);
-- 
1.7.10.4
