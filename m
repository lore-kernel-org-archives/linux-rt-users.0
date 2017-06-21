From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when enabling/disabling migration
Date: Wed, 21 Jun 2017 21:29:01 +0200
Message-ID: <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498068819.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

There is a problem in the migrate_disable()/enable() implementation
regarding the number of migratory tasks in the rt/dl RQs. The problem
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
runnable & migratory task in the runqueue. If there are more than one
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
Cc: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/core.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ce34e4f..2b78189 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7569,6 +7569,9 @@ const u32 sched_prio_to_wmult[40] = {
 void migrate_disable(void)
 {
 	struct task_struct *p = current;
+	struct rq *rq;
+	struct rq_flags rf;
+
 
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
@@ -7593,10 +7596,21 @@ void migrate_disable(void)
 	preempt_disable();
 	preempt_lazy_disable();
 	pin_current_cpu();
-	p->migrate_disable = 1;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
+	rq = task_rq_lock(p, &rf);
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory--;
+		else
+			task_rq(p)->dl.dl_nr_migratory--;
+	}
 	p->nr_cpus_allowed = 1;
+	task_rq_unlock(rq, p, &rf);
+	p->cpus_ptr = cpumask_of(smp_processor_id());
+	p->migrate_disable = 1;
+
 
 	preempt_enable();
 }
@@ -7605,6 +7619,9 @@ EXPORT_SYMBOL(migrate_disable);
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
+	struct rq *rq;
+	struct rq_flags rf;
+
 
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
@@ -7628,17 +7645,24 @@ void migrate_enable(void)
 
 	preempt_disable();
 
-	p->cpus_ptr = &p->cpus_mask;
-	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	p->migrate_disable = 0;
+	p->cpus_ptr = &p->cpus_mask;
 
-	if (p->migrate_disable_update) {
-		struct rq *rq;
-		struct rq_flags rf;
+	rq = task_rq_lock(p, &rf);
+	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory++;
+		else
+			task_rq(p)->dl.dl_nr_migratory++;
+	}
+	task_rq_unlock(rq, p, &rf);
 
+	if (unlikely(p->migrate_disable_update)) {
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-
 		__do_set_cpus_allowed_tail(p, &p->cpus_mask);
 		task_rq_unlock(rq, p, &rf);
 
-- 
2.9.4
