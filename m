From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/15] rcu: Eliminate a few RCU_BOOST #ifdefs in favor of IS_ENABLED()
Date: Tue, 12 May 2015 14:38:09 -0700
Message-ID: <1431466701-653-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150512213756.GA32729@linux.vnet.ibm.com>
 <1431466701-653-1-git-send-email-paulmck@linux.vnet.ibm.com>
Cc: mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
	rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
	dvhart@linux.intel.com, fweisbec@gmail.com, oleg@redhat.com,
	bobby.prani@gmail.com,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	<linux-rt-users@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:38509 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbELVi3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 May 2015 17:38:29 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 12 May 2015 15:38:29 -0600
In-Reply-To: <1431466701-653-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

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
index a69d3dab2ec4..dd5ce4034875 100644
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
index 9a04764dd239..8f8142778684 100644
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
-- 
1.8.1.5

