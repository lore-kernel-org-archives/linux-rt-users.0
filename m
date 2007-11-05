From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/8] RT: Break out the search function
Date: Mon, 05 Nov 2007 16:45:33 -0700
Message-ID: <20071105234533.25384.5565.stgit@lsg>
References: <20071105234517.25384.5143.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, dvhltc@us.ibm.com, zijlstra@redhat.com,
	"linux-kernel@vger"@kernel.org, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:9649 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755389AbXKFARS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2007 19:17:18 -0500
In-Reply-To: <20071105234517.25384.5143.stgit@lsg>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Isolate the search logic into a function so that it can be used later
in places other than find_locked_lowest_rq().

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |   62 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index f1fc1b4..fbe7b8a 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -312,43 +312,55 @@ static struct task_struct *pick_next_highest_task_rt(struct rq *rq,
 	return next;
 }
 
-/* Will lock the rq it finds */
-static struct rq *find_lock_lowest_rq(struct task_struct *task,
-				      struct rq *rq)
+static int find_lowest_rq(struct task_struct *task)
 {
-	struct rq *lowest_rq = NULL;
-	cpumask_t cpu_mask;
 	int cpu;
-	int tries;
+	cpumask_t cpu_mask;
+	struct rq *lowest_rq = NULL;
 
 	cpus_and(cpu_mask, cpu_online_map, task->cpus_allowed);
 
-	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
-		/*
-		 * Scan each rq for the lowest prio.
-		 */
-		for_each_cpu_mask(cpu, cpu_mask) {
-			struct rq *curr_rq = &per_cpu(runqueues, cpu);
+	/*
+	 * Scan each rq for the lowest prio.
+	 */
+	for_each_cpu_mask(cpu, cpu_mask) {
+		struct rq *rq = cpu_rq(cpu);
 
-			if (cpu == rq->cpu)
-				continue;
+		if (cpu == rq->cpu)
+			continue;
 
-			/* We look for lowest RT prio or non-rt CPU */
-			if (curr_rq->rt.highest_prio >= MAX_RT_PRIO) {
-				lowest_rq = curr_rq;
-				break;
-			}
+		/* We look for lowest RT prio or non-rt CPU */
+		if (rq->rt.highest_prio >= MAX_RT_PRIO) {
+			lowest_rq = rq;
+			break;
+		}
 
-			/* no locking for now */
-			if (curr_rq->rt.highest_prio > task->prio &&
-			    (!lowest_rq || curr_rq->rt.highest_prio > lowest_rq->rt.highest_prio)) {
-				lowest_rq = curr_rq;
-			}
+		/* no locking for now */
+		if (rq->rt.highest_prio > task->prio &&
+		    (!lowest_rq || rq->rt.highest_prio > lowest_rq->rt.highest_prio)) {
+			lowest_rq = rq;
 		}
+	}
+
+	return lowest_rq ? lowest_rq->cpu : -1;
+}
+
+/* Will lock the rq it finds */
+static struct rq *find_lock_lowest_rq(struct task_struct *task,
+				      struct rq *rq)
+{
+	struct rq *lowest_rq = NULL;
+	int cpu;
+	int tries;
+
+	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
+		cpu = find_lowest_rq(task);
 
-		if (!lowest_rq)
+		if (cpu == -1)
 			break;
 
+		lowest_rq = cpu_rq(cpu);
+
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
 			/*
