From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/7] rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL
Date: Wed, 02 Mar 2016 21:21:38 -0500
Message-ID: <20160303022156.059254908@goodmis.org>
References: <20160303022133.583693153@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-rcu-torture-Comment-out-rcu_bh-ops-on-PREEMPT_RT_FUL.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.77-rt112-rc1 stable review patch.
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
index 764825c2685c..3cd7834c7da6 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -455,6 +455,7 @@ static struct rcu_torture_ops rcu_expedited_ops = {
 	.name		= "rcu_expedited"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -528,6 +529,12 @@ static struct rcu_torture_ops rcu_bh_expedited_ops = {
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
