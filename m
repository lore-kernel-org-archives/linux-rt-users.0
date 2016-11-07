From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon,  7 Nov 2016 09:17:55 +0100
Message-ID: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The rt throttling mechanism prevents the starvation of non-real-time
tasks by CPU intensive real-time tasks. In terms of percentage,
the default behavior allows real-time tasks to run up to 95% of a
given period, leaving the other 5% of the period for non-real-time
tasks. In the absence of non-rt tasks, the system goes idle for 5%
of the period.

Although this behavior works fine for the purpose of avoiding
bad real-time tasks that can hang the system, some greed users
want to allow the real-time task to continue running in the absence
of non-real-time tasks starving. In other words, they do not want to
see the system going idle.

This patch implements the RT_RUNTIME_GREED scheduler feature for greedy
users (TM). When enabled, this feature will check if non-rt tasks are
starving before throttling the real-time task. If the real-time task
becomes throttled, it will be unthrottled as soon as the system goes
idle, or when the next period starts, whichever comes first.

This feature is enabled with the following command:
  # echo RT_RUNTIME_GREED > /sys/kernel/debug/sched_features

The user might also want to disable NO_RT_RUNTIME_SHARE logic,
to keep all CPUs with the same rt_runtime.
  # echo NO_RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features

With these two options set, the user will guarantee some runtime
for non-rt-tasks on all CPUs, while keeping real-time tasks running
as much as possible.

The feature is disabled by default, keeping the current behavior.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42d4027..c4c62ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3275,7 +3275,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct pin_cookie cookie
 		if (unlikely(!p))
 			p = idle_sched_class.pick_next_task(rq, prev, cookie);
 
-		return p;
+		if (likely(p != RETRY_TASK))
+			return p;
 	}
 
 again:
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 69631fa..3bd7a6d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -66,6 +66,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(FORCE_SD_OVERLAP, false)
 SCHED_FEAT(RT_RUNTIME_SHARE, true)
+SCHED_FEAT(RT_RUNTIME_GREED, false)
 SCHED_FEAT(LB_MIN, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index 5405d3f..0f23e06 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -26,6 +26,10 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct pin_cookie cookie)
 {
+	if (sched_feat(RT_RUNTIME_GREED))
+		if (try_to_unthrottle_rt_rq(&rq->rt))
+			return RETRY_TASK;
+
 	put_prev_task(rq, prev);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2516b8d..a6961a5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -631,6 +631,22 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+static inline void unthrottle_rt_rq(struct rt_rq *rt_rq)
+{
+	rt_rq->rt_time = 0;
+	rt_rq->rt_throttled = 0;
+	sched_rt_rq_enqueue(rt_rq);
+}
+
+int try_to_unthrottle_rt_rq(struct rt_rq *rt_rq)
+{
+	if (rt_rq_throttled(rt_rq)) {
+		unthrottle_rt_rq(rt_rq);
+		return 1;
+	}
+	return 0;
+}
+
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 {
 	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
@@ -920,6 +936,18 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 * but accrue some time due to boosting.
 		 */
 		if (likely(rt_b->rt_runtime)) {
+			if (sched_feat(RT_RUNTIME_GREED)) {
+				struct rq *rq = rq_of_rt_rq(rt_rq);
+				/*
+				 * If there is no other tasks able to run
+				 * on this rq, lets be greed and reset our
+				 * rt_time.
+				 */
+				if (rq->nr_running == rt_rq->rt_nr_running) {
+					rt_rq->rt_time = 0;
+					return 0;
+				}
+			}
 			rt_rq->rt_throttled = 1;
 			printk_deferred_once("sched: RT throttling activated\n");
 		} else {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 055f935..450ca34 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -502,6 +502,8 @@ struct rt_rq {
 #endif
 };
 
+int try_to_unthrottle_rt_rq(struct rt_rq *rt_rq);
+
 /* Deadline class' related fields in a runqueue */
 struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
-- 
2.7.4
