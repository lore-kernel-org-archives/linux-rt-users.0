From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/10] net: Make synchronize_rcu_expedited() conditional on !RT_FULL
Date: Fri, 26 Feb 2016 16:41:05 -0500
Message-ID: <20160226214119.770047617@goodmis.org>
References: <20160226214100.390136141@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Cartwright <joshc@ni.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-net-Make-synchronize_rcu_expedited-conditional-on-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.97-rt106-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Josh Cartwright <joshc@ni.com>

While the use of synchronize_rcu_expedited() might make
synchronize_net() "faster", it does so at significant cost on RT
systems, as expediting a grace period forcibly preempts any
high-priority RT tasks (via the stop_machine() mechanism).

Without this change, we can observe a latency spike up to 30us with
cyclictest by rapidly unplugging/reestablishing an ethernet link.

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
Cc: bigeasy@linutronix.de
Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20151027123153.GG8245@jcartwri.amer.corp.natinst.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a478f77e4322..3a531a6fec33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5838,7 +5838,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
-- 
2.7.0
