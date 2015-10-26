From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Mon, 26 Oct 2015 14:14:55 -0500
Message-ID: <1445886895-3692-1-git-send-email-joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
To: tglx@linutronix.de, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This reverts commit be3fc413da9eb17cce0991f214ab019d16c88c41.

While the use of synchronize_rcu_expedited() might make
synchronize_net() "faster", it does so at significant cost on RT
systems, as expediting a grace period forcibly preempts any
high-priority RT tasks (via the stop_machine() mechanism).

Without be3fc413da9e reverted, we can observe a latency spike up to 30us
with cyclictest by rapidly unplugging/reestablishing an ethernet link.

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 net/core/dev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f8c23de..869ef62 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6969,10 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
-		synchronize_rcu_expedited();
-	else
-		synchronize_rcu();
+	synchronize_rcu();
 }
 EXPORT_SYMBOL(synchronize_net);
 
-- 
2.5.1
