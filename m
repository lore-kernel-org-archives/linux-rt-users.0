From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH V2 2/3] sched: Move deadline container_of() helper functions into sched.h
Date: Mon, 28 Mar 2016 13:50:50 -0300
Message-ID: <77a446ab71d35b5b5f758b05fbbe6ec7cff669d4.1459182044.git.bristot@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459182044.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Move dl_task_of(), dl_rq_of_se() and rq_of_dl_rq() helper functions
from kernel/sched/deadline.c to kernel/sched/sched.h, so they
can be used on other scheduler files.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index affd97e..f6bfb0a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -20,24 +20,6 @@
 
 struct dl_bandwidth def_dl_bandwidth;
 
-static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
-{
-	return container_of(dl_se, struct task_struct, dl);
-}
-
-static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
-{
-	return container_of(dl_rq, struct rq, dl);
-}
-
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
-{
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->dl;
-}
-
 static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 {
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec2e8d2..8671291 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -750,6 +750,24 @@ static inline void rq_clock_skip_update(struct rq *rq, bool skip)
 		rq->clock_skip_update &= ~RQCF_REQ_SKIP;
 }
 
+static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
+{
+	return container_of(dl_se, struct task_struct, dl);
+}
+
+static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
+{
+	return container_of(dl_rq, struct rq, dl);
+}
+
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->dl;
+}
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
-- 
2.5.0
