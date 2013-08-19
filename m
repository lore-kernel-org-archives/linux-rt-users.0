From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] rcu/swait: Fix RCU conversion of wake_up_all() to swait_wake()
Date: Mon, 19 Aug 2013 11:35:31 -0400
Message-ID: <20130819153618.854174262@goodmis.org>
References: <20130819153530.409041534@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-rcu-swait-Fix-RCU-conversion-of-wake_up_all-to-swait.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Reverting the rcu swait patches fixed the boot problem. Then when I was
looking at the revert itself, this stood out like a sore thumb.

 static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp) {
-       swait_wake(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
+       wake_up_all(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
 }

See the problem there?

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcutree_plugin.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 684b762..dc0c4b2 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -2036,7 +2036,7 @@ static int rcu_nocb_needs_gp(struct rcu_state *rsp)
  */
 static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
-	swait_wake(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
+	swait_wake_all(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
 }
 
 /*
-- 
1.7.10.4
