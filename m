From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/4] rcutiny: Use simple waitqueue
Date: Tue, 19 Feb 2013 00:31:19 -0500
Message-ID: <20130219053200.112311156@goodmis.org>
References: <20130219053116.706325380@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-rcutiny-Use-simple-waitqueue.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Simple waitqueues can be handled from interrupt disabled contexts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcutiny_plugin.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcutiny_plugin.h b/kernel/rcutiny_plugin.h
index f259c67..1cd0c6e 100644
--- a/kernel/rcutiny_plugin.h
+++ b/kernel/rcutiny_plugin.h
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/wait-simple.h>
 
 #ifdef CONFIG_RCU_TRACE
 #define RCU_TRACE(stmt)	stmt
@@ -736,7 +737,7 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-static DECLARE_WAIT_QUEUE_HEAD(sync_rcu_preempt_exp_wq);
+static DEFINE_SWAIT_HEAD(sync_rcu_preempt_exp_wq);
 static unsigned long sync_rcu_preempt_exp_count;
 static DEFINE_MUTEX(sync_rcu_preempt_exp_mutex);
 
@@ -758,7 +759,7 @@ static int rcu_preempted_readers_exp(void)
  */
 static void rcu_report_exp_done(void)
 {
-	wake_up(&sync_rcu_preempt_exp_wq);
+	swait_wake(&sync_rcu_preempt_exp_wq);
 }
 
 /*
@@ -810,8 +811,8 @@ void synchronize_rcu_expedited(void)
 	else {
 		rcu_initiate_boost();
 		local_irq_restore(flags);
-		wait_event(sync_rcu_preempt_exp_wq,
-			   !rcu_preempted_readers_exp());
+		swait_event(sync_rcu_preempt_exp_wq,
+			    !rcu_preempted_readers_exp());
 	}
 
 	/* Clean up and exit. */
-- 
1.7.10.4
