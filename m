From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v2 1/7] Add rt_nr_running accounting
Date: Mon, 22 Oct 2007 22:59:01 -0400
Message-ID: <20071023032916.168288851@goodmis.org>
References: <20071023025900.927578809@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Paul Jackson <pj@sgi.com>,
	Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59060 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXJWD3h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2007 23:29:37 -0400
Content-Disposition: inline; filename=count-rt-queued.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch adds accounting to keep track of the number of RT tasks running
on a runqueue. This information will be used in later patches.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

---
 kernel/sched.c    |    1 +
 kernel/sched_rt.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

Index: linux-test.git/kernel/sched.c
===================================================================
--- linux-test.git.orig/kernel/sched.c	2007-10-22 22:18:53.000000000 -0400
+++ linux-test.git/kernel/sched.c	2007-10-22 22:31:51.000000000 -0400
@@ -266,6 +266,7 @@ struct rt_rq {
 	struct rt_prio_array active;
 	int rt_load_balance_idx;
 	struct list_head *rt_load_balance_head, *rt_load_balance_curr;
+	unsigned long rt_nr_running;
 };
 
 /*
Index: linux-test.git/kernel/sched_rt.c
===================================================================
--- linux-test.git.orig/kernel/sched_rt.c	2007-10-22 22:18:53.000000000 -0400
+++ linux-test.git/kernel/sched_rt.c	2007-10-22 22:31:51.000000000 -0400
@@ -25,12 +25,27 @@ static void update_curr_rt(struct rq *rq
 	curr->se.exec_start = rq->clock;
 }
 
+static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
+{
+	WARN_ON(!rt_task(p));
+	rq->rt.rt_nr_running++;
+}
+
+static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
+{
+	WARN_ON(!rt_task(p));
+	WARN_ON(!rq->rt.rt_nr_running);
+	rq->rt.rt_nr_running--;
+}
+
 static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int wakeup)
 {
 	struct rt_prio_array *array = &rq->rt.active;
 
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
+
+	inc_rt_tasks(p, rq);
 }
 
 /*
@@ -45,6 +60,8 @@ static void dequeue_task_rt(struct rq *r
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
+
+	dec_rt_tasks(p, rq);
 }
 
 /*

-- 
