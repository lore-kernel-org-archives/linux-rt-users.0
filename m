From: Mike Galbraith <bitbucket@online.de>
Subject: [rfc][patch] sched,rt: enqueue spinlock waiters to the head of
 their queue
Date: Sun, 14 Apr 2013 15:34:05 +0200
Message-ID: <1365946445.6105.3.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63911 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3DNNeQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 09:34:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


If a task blocks on a spinlock, give the CPU back as soon as possible so
we can turn over the lock as quickly as possible.  The task was at HEAD
when it blocked, put it back, and tell everyone else to get the hell out
of the way.

Signed-off-by: Mike Galbraith <bitbucket@online.de>
---
 include/linux/sched.h |    1 +
 kernel/rtmutex.c      |   13 +++++++++++--
 kernel/sched/core.c   |    9 +++++++--
 kernel/sched/fair.c   |    4 ++++
 kernel/sched/rt.c     |   29 +++++++++++++++++++++++++++--
 5 files changed, 50 insertions(+), 6 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1064,6 +1064,7 @@ struct sched_domain;
 #define WF_FORK		0x02		/* child wakeup after fork */
 #define WF_MIGRATED	0x04		/* internal use, task got migrated */
 #define WF_LOCK_SLEEPER	0x08		/* wakeup spinlock "sleeper" */
+#define WF_REQUEUE	0x10		/* requeue spinlock "sleeper" */
 
 #define ENQUEUE_WAKEUP		1
 #define ENQUEUE_HEAD		2
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -722,7 +722,7 @@ static void  noinline __sched rt_spin_lo
 {
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
-	int ret;
+	int ret, wait, cpu = raw_smp_processor_id();
 
 	rt_mutex_init_waiter(&waiter, true);
 
@@ -757,12 +757,21 @@ static void  noinline __sched rt_spin_lo
 
 		top_waiter = rt_mutex_top_waiter(lock);
 		lock_owner = rt_mutex_owner(lock);
+		wait = top_waiter != &waiter;
+
+		/*
+		 * If we preempt the lock owner, just preempt ourselves.
+		 * the now boosted lock owner is queued to queue head.
+		 * When we release the wait lock, lock owner runs.
+		 */
+		if (!wait && task_cpu(lock_owner) == cpu)
+			set_tsk_need_resched(self);
 
 		raw_spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
+		if (wait || adaptive_wait(lock, lock_owner))
 			schedule_rt_mutex(lock);
 
 		raw_spin_lock(&lock->wait_lock);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1611,7 +1611,12 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	int flags = WF_LOCK_SLEEPER;
+
+	if (rt_task(p))
+		flags |= WF_REQUEUE;
+
+	return try_to_wake_up(p, TASK_ALL, flags);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
@@ -3815,7 +3820,7 @@ void rt_mutex_setprio(struct task_struct
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq)
-		enqueue_task(rq, p, oldprio < prio ? ENQUEUE_HEAD : 0);
+		enqueue_task(rq, p, ENQUEUE_HEAD);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3522,6 +3522,10 @@ static void check_preempt_wakeup(struct
 	if (unlikely(se == pse))
 		return;
 
+	/* Preempting SCHED_OTHER lock holders harms throughput for no good reason */
+	if (__migrate_disabled(curr))
+		return;
+
 	/*
 	 * This is possible from callers such as move_task(), in which we
 	 * unconditionally check_prempt_curr() after an enqueue (which may have
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1180,6 +1180,10 @@ enqueue_task_rt(struct rq *rq, struct ta
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	/* The wakee is a FIFO lock sleeper */
+	if (flags & WF_REQUEUE)
+		flags |= ENQUEUE_HEAD;
+
 	enqueue_rt_entity(rt_se, flags & ENQUEUE_HEAD);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1295,8 +1299,29 @@ select_task_rq_rt(struct task_struct *p,
 	return cpu;
 }
 
-static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
+static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p, int wake_flags)
 {
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (wake_flags & WF_REQUEUE) {
+		if (!p->on_cpu)
+			requeue_task_rt(rq, p, 1);
+
+		/*
+		 * The lock owner was here first, top waiter
+		 * must follow.  If the owner was PI boosted,
+		 * it's gone RSN.  All others need to get off
+		 * this CPU ASAP, this waiter had it first.
+		 */
+		if (rq == this_rq())
+			requeue_task_rt(rq, rq->curr, 1);
+		else if (__migrate_disabled(rq->curr))
+			set_tsk_need_resched(rq->curr);
+		else
+			resched_task(rq->curr);
+
+		return;
+	}
+#endif
 	if (rq->curr->nr_cpus_allowed == 1)
 		return;
 
@@ -1342,7 +1367,7 @@ static void check_preempt_curr_rt(struct
 	 * task.
 	 */
 	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
-		check_preempt_equal_prio(rq, p);
+		check_preempt_equal_prio(rq, p, flags);
 #endif
 }
 


