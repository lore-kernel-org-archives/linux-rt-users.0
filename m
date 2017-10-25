From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH] PREEMPT_RT: sched/rr, sched/fair: defer CFS scheduler put_prev_task()
Date: Wed, 25 Oct 2017 15:26:43 -0700
Message-ID: <1508970403-19912-1-git-send-email-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Allen Martin" <amartin@nvidia.com>
To: <mingo@kernel.org>, <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Defer calling put_prev_task() on a CFS task_struct when there is a
pending RT task to run.  Instead wait until the next
pick_next_task_fair() and do the work there.

The put_prev_task() call for a SCHED_OTHER task is currently a source
of non determinism in the latency of scheduling a SCHED_FIFO task.
This results in a priority inversion as the CFS scheduler is updating
load average and balancing the rq rbtree while the SCHED_FIFO task is
waiting to run.

Instrumented results on a quad core ARM A57.  This is measured just
across the put_prev_task() in pick_next_task_rt().

before patch

cpu: 0
max_instr: 1114
min_instr: 9
avg_instr: 11
min_time: 32ns
max_time: 2528ns
avg_time: 64ns

cpu: 1
max_instr: 1122
min_instr: 9
avg_instr: 11
min_time: 32ns
max_time: 3040ns
avg_time: 64ns

cpu: 2
max_instr: 1118
min_instr: 9
avg_instr: 11
min_time: 32ns
max_time: 3584ns
avg_time: 64ns

cpu: 3
max_instr: 1122
min_instr: 9
avg_instr: 11
min_time: 32ns
max_time: 3456ns
avg_time: 64ns

after patch

cpu: 0
max_instr: 23
min_instr: 9
avg_instr: 11
min_time: 64ns
max_time: 480ns
avg_time: 64ns

cpu: 1
max_instr: 23
min_instr: 9
avg_instr: 11
min_time: 64ns
max_time: 224ns
avg_time: 64ns

cpu: 2
max_instr: 12
min_instr: 9
avg_instr: 10
min_time: 64ns
max_time: 224ns
avg_time: 64ns

cpu: 3
max_instr: 44
min_instr: 9
avg_instr: 11
min_time: 64ns
max_time: 160ns
avg_time: 64ns

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   |  4 ++++
 kernel/sched/fair.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/rt.c     |  6 ++++++
 kernel/sched/sched.h  |  3 +++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7ae9273a809..fdaf4ae2383e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1126,6 +1126,10 @@ struct task_struct {
 	void				*security;
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	int				rt_preempt;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a9899fc26f7..5cd3e1d25238 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6016,6 +6016,10 @@ void __init sched_init(void)
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		rq->cfs_deferred_task = NULL;
+#endif
+
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
 		rq->last_load_update_tick = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1a7ea8662c4..79cc22cb9698 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4858,6 +4858,13 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static int is_task_deferred(struct rq *rq, struct task_struct *prev)
+{
+	return rq->cfs_deferred_task == prev;
+}
+#endif
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -4926,6 +4933,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/* see if this was the deferred task */
+	if (is_task_deferred(rq, p)) {
+		/* reinsert it and then go through normal dequeue path */
+		rq->cfs_deferred_task = NULL;
+		put_prev_task(rq, p);
+	}
+#endif
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
@@ -6186,6 +6202,14 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct task_struct *p;
 	int new_tasks;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (rq->cfs_deferred_task) {
+		p = rq->cfs_deferred_task;
+		rq->cfs_deferred_task = NULL;
+		put_prev_task(rq, p);
+	}
+#endif
+
 again:
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (!cfs_rq->nr_running)
@@ -6310,6 +6334,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (unlikely(prev->rt_preempt && prev->on_rq)) {
+		rq->cfs_deferred_task = prev;
+		return;
+	}
+#endif
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
@@ -9105,6 +9136,16 @@ static void detach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct rq *rq = rq_of(cfs_rq);
+
+	/* see if this was in the deferred list */
+	if (is_task_deferred(rq, p)) {
+		/* reinsert it and then go through normal detach path */
+		rq->cfs_deferred_task = NULL;
+		put_prev_task(rq, p);
+	}
+#endif
 
 	if (!vruntime_normalized(p)) {
 		/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3249423cdabd..45c7ff1a30ac 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1571,7 +1571,13 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (!rt_rq->rt_queued)
 		return NULL;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	prev->rt_preempt = true;
+#endif
 	put_prev_task(rq, prev);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	prev->rt_preempt = false;
+#endif
 
 	p = _pick_next_task_rt(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72983b9066c5..0da3dd449676 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -742,6 +742,9 @@ struct rq {
 	int online;
 
 	struct list_head cfs_tasks;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct task_struct *cfs_deferred_task;
+#endif
 
 	u64 rt_avg;
 	u64 age_stamp;
-- 
2.7.4
