From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: Add a per-cpu rt_overload indication
Date: Fri, 05 Oct 2007 10:23:49 -0400
Message-ID: <20071005142230.23643.28807.stgit@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ghaskins@novell.com
To: mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763164AbXJEO0X@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The -rt scheduler currently evaluates all online CPUs whenever one or more
enters an rt_overload condition.  This suffers from scalability limitations
as the # of online CPUs increases since each rq->lock needs to be acquired by
each cpu.  So we introduce a cpumask to track exactly which CPUs need RT
balancing.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 93fd6de..aaacec2 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -631,6 +631,7 @@ static inline struct rq *this_rq_lock(void)
 
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
 static __cacheline_aligned_in_smp atomic_t rt_overload;
+static cpumask_t rto_cpus;
 #endif
 
 static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
@@ -639,8 +640,11 @@ static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
 	if (rt_task(p)) {
 		rq->rt_nr_running++;
 # ifdef CONFIG_SMP
-		if (rq->rt_nr_running == 2)
+		if (rq->rt_nr_running == 2) {
+			cpu_set(rq->cpu, rto_cpus);
+			smp_wmb();
 			atomic_inc(&rt_overload);
+		}
 # endif
 	}
 #endif
@@ -653,8 +657,10 @@ static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
 		WARN_ON(!rq->rt_nr_running);
 		rq->rt_nr_running--;
 # ifdef CONFIG_SMP
-		if (rq->rt_nr_running == 1)
+		if (rq->rt_nr_running == 1) {
 			atomic_dec(&rt_overload);
+			cpu_clear(rq->cpu, rto_cpus);
+		}
 # endif
 	}
 #endif
@@ -1503,7 +1509,7 @@ static void balance_rt_tasks(struct rq *this_rq, int this_cpu)
 	 */
 	next = pick_next_task(this_rq, this_rq->curr);
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu_mask(cpu, rto_cpus) {
 		if (cpu == this_cpu)
 			continue;
 		src_rq = cpu_rq(cpu);
