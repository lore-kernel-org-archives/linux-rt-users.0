From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt 5/9] net: fix mis-merge in qdisc_restart
Date: Sun, 29 Jul 2007 19:45:39 -0700
Message-ID: <20070730024720.116454959@mvista.com>
References: <20070730024534.369897977@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41606 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932933AbXG3CrW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jul 2007 22:47:22 -0400
Content-Disposition: inline; filename=preempt-realtime-net-mismerge.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This mismerge caused my networking to malfunction. The interface would
come up, but no traffic would make it in/out ..

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 net/sched/sch_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/net/sched/sch_generic.c
===================================================================
--- linux-2.6.22.orig/net/sched/sch_generic.c
+++ linux-2.6.22/net/sched/sch_generic.c
@@ -156,7 +156,7 @@ static inline int qdisc_restart(struct n
 #ifdef CONFIG_PREEMPT_RT
 		netif_tx_lock(dev);
 #else
-		if (netif_tx_trylock(dev))
+		if (!netif_tx_trylock(dev))
 			/* Another CPU grabbed the driver tx lock */
 			return handle_dev_cpu_collision(skb, dev, q);
 #endif

-- 
