From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 6/6] rcu: disable more spots of rcu_bh
Date: Sat, 13 Feb 2016 00:02:48 +0100
Message-ID: <1455318168-7125-6-git-send-email-bigeasy@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We don't use ru_bh on -RT but we still fork a thread for it and keep it
as a flavour. No more.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 6 ++++++
 kernel/rcu/tree.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5359091fecaa..64098d35de19 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -454,11 +454,13 @@ EXPORT_SYMBOL_GPL(rcu_batches_started_sched);
 /*
  * Return the number of RCU BH batches started thus far for debug & stats.
  */
+#ifndef CONFIG_PREEMPT_RT_FULL
 unsigned long rcu_batches_started_bh(void)
 {
 	return rcu_bh_state.gpnum;
 }
 EXPORT_SYMBOL_GPL(rcu_batches_started_bh);
+#endif
 
 /*
  * Return the number of RCU batches completed thus far for debug & stats.
@@ -563,9 +565,11 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 	case RCU_FLAVOR:
 		rsp = rcu_state_p;
 		break;
+#ifndef CONFIG_PREEMPT_RT_FULL
 	case RCU_BH_FLAVOR:
 		rsp = &rcu_bh_state;
 		break;
+#endif
 	case RCU_SCHED_FLAVOR:
 		rsp = &rcu_sched_state;
 		break;
@@ -4695,7 +4699,9 @@ void __init rcu_init(void)
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
+#ifndef CONFIG_PREEMPT_RT_FULL
 	rcu_init_one(&rcu_bh_state, &rcu_bh_data);
+#endif
 	rcu_init_one(&rcu_sched_state, &rcu_sched_data);
 	if (dump_tree)
 		rcu_dump_rcu_node_tree(&rcu_sched_state);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 588509d94bbd..2ba8f6c2e81e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -557,7 +557,9 @@ extern struct list_head rcu_struct_flavors;
  */
 extern struct rcu_state rcu_sched_state;
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 extern struct rcu_state rcu_bh_state;
+#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 extern struct rcu_state rcu_preempt_state;
-- 
2.7.0
