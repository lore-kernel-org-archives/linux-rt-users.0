From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [RFC 1/3] rt: Increase/decrease the nr of migratable tasks when enabling/disabling migration
Date: Fri, 16 Jun 2017 12:39:46 +0200
Message-ID: <86cc5abeb6b71445d5c940053525a9b5fe8bea66.1497607974.git.bristot@redhat.com>
References: <cover.1497607974.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497607974.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

There is a problem in the migrate_disable()/enable() implementation
regarding the number of migratable tasks in the rt/dl RQs. The problem
is the following:

When a task is attached to the rt runqueue, it is checked if it either
can run in more than one CPU, or if it is with migration disable. If
either check is true, the rt_rq->rt_nr_migratory counter is not
increased. The counter increases otherwise.

When the task is detached, the same check is done. If either check is
true, the rt_rq->rt_nr_migratory counter is not decreased. The counter
decreases otherwise. The same check is done in the dl scheduler.

One important thing is that, migrate disable/enable does not touch this
counter for tasks attached to the rt rq. So suppose the following chain
of events.

Assumptions:
Task A is the only runnable task in A      Task B runs on the CPU B
Task A runs on CFS (non-rt)                Task B has RT priority
Thus, rt_nr_migratory is 0                 B is running
Task A can run on all CPUS.

Timeline:
        CPU A/TASK A                        CPU B/TASK B
A takes the rt mutex X                           .
A disables migration                             .
           .                          B tries to take the rt mutex X
           .                          As it is held by A {
           .                            A inherits the rt priority of B
           .                            A is dequeued from CFS RQ of CPU A
           .                            A is enqueued in the RT RQ of CPU A
           .                            As migration is disabled
           .                              rt_nr_migratory in A is not increased
           .
A enables migration
A releases the rt mutex X {
  A returns to its original priority
  A ask to be dequeued from RT RQ {
    As migration is now enabled and it can run on all CPUS {
       rt_nr_migratory should be decreased
       As rt_nr_migratory is 0, rt_nr_migratory under flows
    }
}

This variable is important because it notifies if there are more than one
runnable & migratable task in the runqueue. If there are more than one
tasks, the rt_rq is set as overloaded, and then tries to migrate some
tasks. This rule is important to keep the scheduler working conserving,
that is, in a system with M CPUs, the M highest priority tasks should be
running.

As rt_nr_migratory is unsigned, it will become > 0, notifying that the
RQ is overloaded, activating pushing mechanism without need.

This patch fixes this problem by decreasing/increasing the
rt/dl_nr_migratory in the migrate disable/enable operations.

Reported-by: Pei Zhang <pezhang@redhat.com>
Reported-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 10e832d..aeb3e12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3376,6 +3376,8 @@ static inline void schedule_debug(struct task_struct *prev)
 void migrate_disable(void)
 {
 	struct task_struct *p = current;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
@@ -3399,7 +3401,19 @@ void migrate_disable(void)
 	preempt_disable();
 	preempt_lazy_disable();
 	pin_current_cpu();
+	rq = task_rq_lock(p, &rf);
 	p->migrate_disable = 1;
+
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory--;
+		else
+			task_rq(p)->dl.dl_nr_migratory--;
+	}
+
+	task_rq_unlock(rq, p, &rf);
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_disable);
@@ -3407,6 +3421,8 @@ EXPORT_SYMBOL(migrate_disable);
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
@@ -3429,12 +3445,24 @@ void migrate_enable(void)
 	}
 
 	preempt_disable();
+	rq = task_rq_lock(p, &rf);
+
 	/*
 	 * Clearing migrate_disable causes tsk_cpus_allowed to
 	 * show the tasks original cpu affinity.
 	 */
 	p->migrate_disable = 0;
 
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory++;
+		else
+			task_rq(p)->dl.dl_nr_migratory++;
+	}
+
+	task_rq_unlock(rq, p, &rf);
 	unpin_current_cpu();
 	preempt_enable();
 	preempt_lazy_enable();
-- 
2.9.4
