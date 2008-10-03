From: Gilles Carry <gilles.carry@bull.net>
Subject: [PATCH replace] Fix pushable_tasks list corruption
Date: Fri,  3 Oct 2008 10:24:35 +0200
Message-ID: <1223022275-6626-1-git-send-email-gilles.carry@bull.net>
Cc: rostedt@goodmis.org, tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net, gilles.carry@bull.net,
	ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:37228 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYJCI3J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 04:29:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: gilles.carry <gilles.carry@bull.net>

Symptoms:
System hang (endless loop in plist_check_list)
or BUG because of faulty prev/next pointers in
pushable_task node.

When push_rt_task successes finding a task to push away, it
performs a double lock on the runqueues (local and target) but
before getting both locks, it releases the local rq lock allowing
other cpus grab the task in between. (eg. pull_rt_task, timers...)
In some situations, when push_rt_task calls dequeue_pushable_task
the task may have already been removed from the pushable_tasks
list by another cpu. Removing the node again corrupts the list.

This patch adds a sanity check to dequeue_pushable_task which only
removes the node if it's still on the original list.

Signed-off-by: Gilles Carry <gilles.carry@bull.net>
Cc: ghaskins@novell.com
---
 kernel/sched_rt.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 57a0c0d..7aa4450 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -62,7 +62,17 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 
 static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 {
-	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	struct plist_node *next;
+
+	/* Sanity check: delete only if node is still on this list */
+	plist_for_each(next, &rq->rt.pushable_tasks) {
+		if (&p->pushable_tasks == next) {
+			plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+			return;
+		}
+	}
+
+
 }
 
 #else
@@ -1105,6 +1115,12 @@ static int push_rt_task(struct rq *rq)
 		 * try again, since the other cpus will pull from us
 		 * when they are ready
 		 */
+
+		/*
+		 * If we reach here and the task has migrated to another cpu
+		 * (paranoid == 0?) calling dequeue_pushable_task may cause
+		 * pushable_tasks list corruption.
+		 */
 		dequeue_pushable_task(rq, next_task);
 		goto out;
 	}
-- 
1.5.5.GIT

