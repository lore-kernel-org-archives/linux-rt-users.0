From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/10] rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL
Date: Wed, 02 Mar 2016 10:51:08 -0500
Message-ID: <20160302155111.674934063@goodmis.org>
References: <20160302155100.873557484@goodmis.org>
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
Content-Disposition: inline; filename=0008-rcu-torture-Comment-out-rcu_bh-ops-on-PREEMPT_RT_FUL.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.97-rt107-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Clark Williams <williams@redhat.com>

RT has dropped support of rcu_bh, comment out in rcutorture.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcutorture.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index e1f3a8c96724..00dbf08794ba 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -520,6 +520,7 @@ static struct rcu_torture_ops rcu_expedited_ops = {
 	.name		= "rcu_expedited"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -593,6 +594,12 @@ static struct rcu_torture_ops rcu_bh_expedited_ops = {
 	.name		= "rcu_bh_expedited"
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
