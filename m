From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Subject: [tip:core/rcu] rcu:
  Eliminate a few RCU_BOOST #ifdefs in favor of IS_ENABLED()
Date: Tue, 2 Jun 2015 00:50:22 -0700
Message-ID: <tip-727b705baf7d091a9bc5494d7f1d9699b6932531@git.kernel.org>
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
	  linux-rt-users@vger.kernel.org, hpa@zytor.com,
	  paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: mingo@kernel.org, linux-rt-users@vger.kernel.org, hpa@zytor.com,
	paulmck@linux.vnet.ibm.com, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44937 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbbFBHuf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 03:50:35 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit-ID:  727b705baf7d091a9bc5494d7f1d9699b6932531
Gitweb:     http://git.kernel.org/tip/727b705baf7d091a9bc5494d7f1d9699b6932531
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 3 Mar 2015 14:49:26 -0800
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Wed, 27 May 2015 12:57:59 -0700

rcu: Eliminate a few RCU_BOOST #ifdefs in favor of IS_ENABLED()

This commit removes a few RCU_BOOST #ifdefs, replacing them with
IS_ENABLED()-protected return statements.  This relies on the
optimizer to remove any resulting dead code.  There are several other
RCU_BOOST #ifdefs, however these rely on some per-CPU variables that
are available only under RCU_BOOST.  These might be converted later,
if the simplification proves to outweigh the increase in memory footprint.
One hoped-for advantage is more easily locating compiler errors in
obscure combinations of Kconfig parameters.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: <linux-rt-users@vger.kernel.org>
---
 kernel/rcu/tree.h        |  2 --
 kernel/rcu/tree_plugin.h | 35 ++++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a69d3da..dd5ce40 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -170,7 +170,6 @@ struct rcu_node {
 				/*  if there is no such task.  If there */
 				/*  is no current expedited grace period, */
 				/*  then there can cannot be any such task. */
-#ifdef CONFIG_RCU_BOOST
 	struct list_head *boost_tasks;
 				/* Pointer to first task that needs to be */
 				/*  priority boosted, or NULL if no priority */
@@ -208,7 +207,6 @@ struct rcu_node {
 	unsigned long n_balk_nos;
 				/* Refused to boost: not sure why, though. */
 				/*  This can happen due to race conditions. */
-#endif /* #ifdef CONFIG_RCU_BOOST */
 #ifdef CONFIG_RCU_NOCB_CPU
 	wait_queue_head_t nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9a04764..8f81427 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -43,7 +43,17 @@ DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
 DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_loops);
 DEFINE_PER_CPU(char, rcu_cpu_has_work);
 
-#endif /* #ifdef CONFIG_RCU_BOOST */
+#else /* #ifdef CONFIG_RCU_BOOST */
+
+/*
+ * Some architectures do not define rt_mutexes, but if !CONFIG_RCU_BOOST,
+ * all uses are in dead code.  Provide a definition to keep the compiler
+ * happy, but add WARN_ON_ONCE() to complain if used in the wrong place.
+ * This probably needs to be excluded from -rt builds.
+ */
+#define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
+
+#endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 #ifdef CONFIG_RCU_NOCB_CPU
 static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
@@ -180,10 +190,9 @@ static void rcu_preempt_note_context_switch(void)
 		if ((rnp->qsmask & rdp->grpmask) && rnp->gp_tasks != NULL) {
 			list_add(&t->rcu_node_entry, rnp->gp_tasks->prev);
 			rnp->gp_tasks = &t->rcu_node_entry;
-#ifdef CONFIG_RCU_BOOST
-			if (rnp->boost_tasks != NULL)
+			if (IS_ENABLED(CONFIG_RCU_BOOST) &&
+			    rnp->boost_tasks != NULL)
 				rnp->boost_tasks = rnp->gp_tasks;
-#endif /* #ifdef CONFIG_RCU_BOOST */
 		} else {
 			list_add(&t->rcu_node_entry, &rnp->blkd_tasks);
 			if (rnp->qsmask & rdp->grpmask)
@@ -263,9 +272,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 	bool empty_exp_now;
 	unsigned long flags;
 	struct list_head *np;
-#ifdef CONFIG_RCU_BOOST
 	bool drop_boost_mutex = false;
-#endif /* #ifdef CONFIG_RCU_BOOST */
 	struct rcu_node *rnp;
 	union rcu_special special;
 
@@ -331,12 +338,12 @@ void rcu_read_unlock_special(struct task_struct *t)
 			rnp->gp_tasks = np;
 		if (&t->rcu_node_entry == rnp->exp_tasks)
 			rnp->exp_tasks = np;
-#ifdef CONFIG_RCU_BOOST
-		if (&t->rcu_node_entry == rnp->boost_tasks)
-			rnp->boost_tasks = np;
-		/* Snapshot ->boost_mtx ownership with rcu_node lock held. */
-		drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
-#endif /* #ifdef CONFIG_RCU_BOOST */
+		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
+			if (&t->rcu_node_entry == rnp->boost_tasks)
+				rnp->boost_tasks = np;
+			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
+			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
+		}
 
 		/*
 		 * If this was the last task on the current list, and if
@@ -358,11 +365,9 @@ void rcu_read_unlock_special(struct task_struct *t)
 			raw_spin_unlock_irqrestore(&rnp->lock, flags);
 		}
 
-#ifdef CONFIG_RCU_BOOST
 		/* Unboost if we were boosted. */
-		if (drop_boost_mutex)
+		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
 			rt_mutex_unlock(&rnp->boost_mtx);
-#endif /* #ifdef CONFIG_RCU_BOOST */
 
 		/*
 		 * If this was the last task on the expedited lists,
