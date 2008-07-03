From: Darren Hart <dvhltc@us.ibm.com>
Subject: [RFC][PATCH] fix SCHED_FIFO spec violation (backport)
Date: Thu, 03 Jul 2008 15:41:38 -0700
Message-ID: <1215124898.11333.20.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:49154 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbYGCWli (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jul 2008 18:41:38 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63MfbqW015027
	for <linux-rt-users@vger.kernel.org>; Thu, 3 Jul 2008 18:41:37 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m63Mfbb5174872
	for <linux-rt-users@vger.kernel.org>; Thu, 3 Jul 2008 16:41:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m63MfaOP003292
	for <linux-rt-users@vger.kernel.org>; Thu, 3 Jul 2008 16:41:37 -0600
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Enqueue deprioritized RT tasks to head of prio array

This patch backports Peter Z's enqueue to head of prio array on 
de-prioritization to 2.6.24.7-rt14 which doesn't have the 
enqueue_rt_entity and associated changes.

I've run several long running real-time java benchmarks and it's
holding so far.  Steven, please consider this patch for inclusion
in the next 2.6.24.7-rtX release.

Peter, I didn't include your Signed-off-by as only about half your
original patch applied to 2.6.24.7-r14.  If you're happy with this
version, would you also sign off?

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>


---
Index: linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
===================================================================
--- linux-2.6.24.7-ibmrt2.6-view.orig/include/linux/sched.h
+++ linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
@@ -897,11 +897,16 @@ struct uts_namespace;
 struct rq;
 struct sched_domain;
 
+#define ENQUEUE_WAKEUP	0x01
+#define ENQUEUE_HEAD	0x02
+
+#define DEQUEUE_SLEEP	0x01
+
 struct sched_class {
 	const struct sched_class *next;
 
-	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int wakeup);
-	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int sleep);
+	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
+	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task) (struct rq *rq);
 	int  (*select_task_rq)(struct task_struct *p, int sync);
 
Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched.c
===================================================================
--- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched.c
+++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched.c
@@ -1046,7 +1046,7 @@ static const u32 prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-static void activate_task(struct rq *rq, struct task_struct *p, int wakeup);
+static void activate_task(struct rq *rq, struct task_struct *p, int flags);
 
 /*
  * runqueue iterator, to support SMP load-balancing between different
@@ -1155,16 +1155,16 @@ static void set_load_weight(struct task_
 	p->se.load.inv_weight = prio_to_wmult[p->static_prio - MAX_RT_PRIO];
 }
 
-static void enqueue_task(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	sched_info_queued(p);
-	p->sched_class->enqueue_task(rq, p, wakeup);
+	p->sched_class->enqueue_task(rq, p, flags);
 	p->se.on_rq = 1;
 }
 
-static void dequeue_task(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	p->sched_class->dequeue_task(rq, p, sleep);
+	p->sched_class->dequeue_task(rq, p, flags);
 	p->se.on_rq = 0;
 }
 
@@ -1219,26 +1219,26 @@ static int effective_prio(struct task_st
 /*
  * activate_task - move a task to the runqueue.
  */
-static void activate_task(struct rq *rq, struct task_struct *p, int wakeup)
+static void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible--;
 
 	ftrace_event_task_activate(p, cpu_of(rq));
-	enqueue_task(rq, p, wakeup);
+	enqueue_task(rq, p, flags);
 	inc_nr_running(p, rq);
 }
 
 /*
  * deactivate_task - remove a task from the runqueue.
  */
-static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep)
+static void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 
 	ftrace_event_task_deactivate(p, cpu_of(rq));
-	dequeue_task(rq, p, sleep);
+	dequeue_task(rq, p, flags);
 	dec_nr_running(p, rq);
 }
 
@@ -1759,7 +1759,7 @@ out_activate:
 	else
 		schedstat_inc(p, se.nr_wakeups_remote);
 	update_rq_clock(rq);
-	activate_task(rq, p, 1);
+	activate_task(rq, p, ENQUEUE_WAKEUP);
 	check_preempt_curr(rq, p);
 	success = 1;
 
@@ -3968,7 +3968,7 @@ asmlinkage void __sched __schedule(void)
 			prev->state = TASK_RUNNING;
 		} else {
 			touch_softlockup_watchdog();
-			deactivate_task(rq, prev, 1);
+			deactivate_task(rq, prev, DEQUEUE_SLEEP);
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -4431,7 +4431,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void task_setprio(struct task_struct *p, int prio)
 {
 	unsigned long flags;
-	int oldprio, prev_resched, on_rq, running;
+	int oldprio, prev_resched, on_rq, running, down;
 	struct rq *rq;
 	const struct sched_class *prev_class = p->sched_class;
 
@@ -4472,6 +4472,7 @@ void task_setprio(struct task_struct *p,
 	else
 		p->sched_class = &fair_sched_class;
 
+ 	down = (prio > p->prio) ? ENQUEUE_HEAD : 0;
 	p->prio = prio;
 
 //	trace_special_pid(p->pid, __PRIO(oldprio), PRIO(p));
@@ -4480,7 +4481,7 @@ void task_setprio(struct task_struct *p,
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq) {
-		enqueue_task(rq, p, 0);
+ 		enqueue_task(rq, p, down);
 		check_class_changed(rq, p, prev_class, oldprio, running);
 	}
 //	trace_special(prev_resched, _need_resched(), 0);
Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
===================================================================
--- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_fair.c
+++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
@@ -756,10 +756,11 @@ static inline struct sched_entity *paren
  * increased. Here we update the fair scheduling stats and
  * then put the task into the rbtree:
  */
-static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int wakeup = flags & ENQUEUE_WAKEUP;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -775,10 +776,11 @@ static void enqueue_task_fair(struct rq 
  * decreased. We remove the task from the rbtree and
  * update the fair scheduling stats:
  */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int sleep = flags & DEQUEUE_SLEEP;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_idletask.c
===================================================================
--- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_idletask.c
+++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_idletask.c
@@ -31,7 +31,7 @@ static struct task_struct *pick_next_tas
  * message if some code attempts to do it:
  */
 static void
-dequeue_task_idle(struct rq *rq, struct task_struct *p, int sleep)
+dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	spin_unlock_irq(&rq->lock);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_rt.c
===================================================================
--- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_rt.c
+++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_rt.c
@@ -181,11 +181,16 @@ unsigned long rt_nr_uninterruptible_cpu(
 	return cpu_rq(cpu)->rt.rt_nr_uninterruptible;
 }
 
-static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct rt_prio_array *array = &rq->rt.active;
 
-	list_add_tail(&p->run_list, array->queue + p->prio);
+
+ 	if (unlikely(flags & ENQUEUE_HEAD))
+		list_add(&p->run_list, array->queue + p->prio);
+ 	else
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
 	__set_bit(p->prio, array->bitmap);
 	inc_rt_tasks(p, rq);
 
@@ -196,7 +201,7 @@ static void enqueue_task_rt(struct rq *r
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct rt_prio_array *array = &rq->rt.active;
 
@@ -306,7 +311,7 @@ static void put_prev_task_rt(struct rq *
 #define RT_MAX_TRIES 3
 
 static int double_lock_balance(struct rq *this_rq, struct rq *busiest);
-static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep);
+static void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {


