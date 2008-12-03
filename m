From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH v2 3/4] sched: use highest_prio.curr for pull threshold
Date: Wed, 03 Dec 2008 17:09:46 -0500
Message-ID: <20081203220945.11729.10327.stgit@dev.haskins.net>
References: <20081203220628.11729.42174.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, rostedt@goodmis.org, ghaskins@novell.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756310AbYLCWG7@vger.kernel.org>
In-Reply-To: <20081203220628.11729.42174.stgit@dev.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

highest_prio.curr is actually a more accurate way to keep track of
the pull_rt_task() threshold since it is always up to date, even
if the "next" task migrates during double_lock.  Therefore, stop
looking at the "next" task object and simply use the highest_prio.curr.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |   31 ++++++-------------------------
 1 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index a4022b6..7431d19 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -1209,14 +1209,12 @@ static void push_rt_tasks(struct rq *rq)
 static int pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, ret = 0, cpu;
-	struct task_struct *p, *next;
+	struct task_struct *p;
 	struct rq *src_rq;
 
 	if (likely(!rt_overloaded(this_rq)))
 		return 0;
 
-	next = pick_next_task_rt(this_rq);
-
 	for_each_cpu(cpu, this_rq->rd->rto_mask) {
 		if (this_cpu == cpu)
 			continue;
@@ -1225,17 +1223,9 @@ static int pull_rt_task(struct rq *this_rq)
 		/*
 		 * We can potentially drop this_rq's lock in
 		 * double_lock_balance, and another CPU could
-		 * steal our next task - hence we must cause
-		 * the caller to recalculate the next task
-		 * in that case:
+		 * alter this_rq
 		 */
-		if (double_lock_balance(this_rq, src_rq)) {
-			struct task_struct *old_next = next;
-
-			next = pick_next_task_rt(this_rq);
-			if (next != old_next)
-				ret = 1;
-		}
+		double_lock_balance(this_rq, src_rq);
 
 		/*
 		 * Are there still pullable RT tasks?
@@ -1249,7 +1239,7 @@ static int pull_rt_task(struct rq *this_rq)
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (!next || (p->prio < next->prio))) {
+		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!p->se.on_rq);
 
@@ -1259,12 +1249,9 @@ static int pull_rt_task(struct rq *this_rq)
 			 * This is just that p is wakeing up and hasn't
 			 * had a chance to schedule. We only pull
 			 * p if it is lower in priority than the
-			 * current task on the run queue or
-			 * this_rq next task is lower in prio than
-			 * the current task on that rq.
+			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio ||
-			    (next && next->prio < src_rq->curr->prio))
+			if (p->prio < src_rq->curr->prio)
 				goto skip;
 
 			ret = 1;
@@ -1277,13 +1264,7 @@ static int pull_rt_task(struct rq *this_rq)
 			 * case there's an even higher prio task
 			 * in another runqueue. (low likelyhood
 			 * but possible)
-			 *
-			 * Update next so that we won't pick a task
-			 * on another cpu with a priority lower (or equal)
-			 * than the one we just picked.
 			 */
-			next = p;
-
 		}
  skip:
 		double_unlock_balance(this_rq, src_rq);
