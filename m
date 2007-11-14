From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: Fix a bug for properly setting the priority on rt-dequeue
Date: Wed, 14 Nov 2007 14:31:55 -0700
Message-ID: <20071114213046.32720.57104.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com, linux-rt-users@vger.kernel.org, mingo@elte.hu
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:2885 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764907AbXKNVb5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2007 16:31:57 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,
  This patch applies to 23-rt11 to fix that bug you found in the git-HEAD
  merge.  I will fold this patch into my 24 series so it is fixed there.  Feel
  free to fold this into patch "#8" instead of maintaining it seperately, if
  you prefer.

--------------------------

RT: Fix a bug for properly setting the priority on rt-dequeue

We need to update the priority on task-dequeue whenever it changes, not just
if more RT tasks are pending.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index f05912a..864d18a 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -85,6 +85,8 @@ static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
 
 static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
 {
+	int highest_prio = rq->rt.highest_prio;
+
 	WARN_ON(!rt_task(p));
 	WARN_ON(!rq->rt.rt_nr_running);
 	rq->rt.rt_nr_running--;
@@ -98,13 +100,15 @@ static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
 			array = &rq->rt.active;
 			rq->rt.highest_prio =
 				sched_find_first_bit(array->bitmap);
-			cpupri_set(rq->cpu, rq->rt.highest_prio);
 		} /* otherwise leave rq->highest prio alone */
 	} else
 		rq->rt.highest_prio = MAX_RT_PRIO;
 	if (p->nr_cpus_allowed > 1)
 		rq->rt.rt_nr_migratory--;
 
+	if (rq->rt.highest_prio != highest_prio)
+		cpupri_set(rq->cpu, rq->rt.highest_prio);
+
 	update_rt_migration(p, rq);
 #endif /* CONFIG_SMP */
 }
