From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 15/17] rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL
Date: Wed, 02 Mar 2016 10:44:48 -0500
Message-ID: <20160302154502.198479523@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0015-rcu-torture-Comment-out-rcu_bh-ops-on-PREEMPT_RT_FUL.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Clark Williams <williams@redhat.com>

RT has dropped support of rcu_bh, comment out in rcutorture.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcu/torture.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/torture.c b/kernel/rcu/torture.c
index 732f8ae3086a..042c8f1f0d30 100644
--- a/kernel/rcu/torture.c
+++ b/kernel/rcu/torture.c
@@ -477,6 +477,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.name		= "rcu"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -519,6 +520,12 @@ static struct rcu_torture_ops rcu_bh_ops = {
 	.name		= "rcu_bh"
 };
 
+#else
+static struct rcu_torture_ops rcu_bh_ops = {
+	.ttype		= INVALID_RCU_FLAVOR,
+};
+#endif
+
 /*
  * Definitions for srcu torture testing.
  */
-- 
2.7.0
