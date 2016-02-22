From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/4] sched: Move deadline container_of() helper functions into sched.h
Date: Mon, 22 Feb 2016 14:08:20 -0300
Message-ID: <1f3fee7aae5f682627877d5a3f66087ff7e3f327.1456157869.git.bristot@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456157869.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Move dl_task_of(), dl_rq_of_se() and rq_of_dl_rq() helper functions
from kernel/sched/deadline.c to kernel/sched/sched.h, so they
can be used on other scheduler files.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/sched/deadline.c | 18 ------------------
 kernel/sched/sched.h    | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index cd64c97..2f6d25a 100644
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
index 10f1637..b6e55e1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -749,6 +749,24 @@ static inline void rq_clock_skip_update(struct rq *rq, bool skip)
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
