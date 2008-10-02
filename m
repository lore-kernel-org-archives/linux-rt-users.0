From: Gilles Carry <gilles.carry@bull.net>
Subject: [PATCH][RT] Fix pushable_tasks list corruption
Date: Thu,  2 Oct 2008 13:06:13 +0200
Message-ID: <1222945573-29082-1-git-send-email-gilles.carry@bull.net>
Cc: rostedt@goodmis.org, tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net, gilles.carry@bull.net,
	ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41172 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYJBLKl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Oct 2008 07:10:41 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: gilles.carry <gilles.carry@bull.net>

Symptoms:
System hang (endless loop in plist_check_list) or BUG because
of faulty prev/next pointers in pushable_task node.


When push_rt_task successes finding a task to push away, it
performs a double lock on the runqueues (local and target) but
before getting both locks, it releases the local rq lock letting
other cpus grab the task in between. (eg. pull_rt_task, timers...)
When push_rt_task calls deactivate_task (which calls
dequeue_pushable_task) the task may have already been removed
from the pushable_tasks list by another cpu.
Removing the node again corrupts the list.

This patch adds a test to dequeue_pushable_task which only
removes the node if it's still on the original list.

Signed-off-by: Gilles Carry <gilles.carry@bull.net>
Cc: ghaskins@novell.com


---
 kernel/sched_rt.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 57a0c0d..b6ec458 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -62,6 +62,20 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 
 static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 {
+	struct plist_node *next;
+	int	on = 0;
+
+	/* Check if node is still on this list */
+	plist_for_each(next, &rq->rt.pushable_tasks) {
+		if (&p->pushable_tasks == next) {
+			on = 1;
+			break;
+		}
+	}
+
+	if (!on)
+		return;
+
 	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
 }
 
@@ -1109,6 +1123,15 @@ static int push_rt_task(struct rq *rq)
 		goto out;
 	}
 
+	/*
+	 * Here is a critical point since next_task may have migrated.
+	 * find_lock_lowest/double_lock releases rq->lock for a while
+	 * which allows other cpus to grab the task and remove it from
+	 * the pushable list. This is why dequeue_pushable_task
+	 * (called by deactivate_task) now checks node is actually on
+	 * the list before any removal. Failing to do this check causes
+	 * pushable_tasks list corruption.
+	 */
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-- 
1.5.5.GIT

