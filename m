From: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: [PATCH][UPSTREAM]net,RT:Remove preemption disabling in netif_rx()
Date: Thu, 17 May 2012 09:35:11 +0530
Message-ID: <1337227511-2271-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <tglx@linutronix.de>, <rostedt@goodmis.orgn>,
	<Rajan.Srivastava@freescale.com>,
	Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:49197 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab2EQEFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 May 2012 00:05:37 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

1)enqueue_to_backlog() (called from netif_rx) should be
  bind to a particluar CPU. This can be achieved by
  disabling migration. No need to disable preemption

2)Fixes crash "BUG: scheduling while atomic: ksoftirqd"
  in case of RT.
  If preemption is disabled, enqueue_to_backog() is called
  in atomic context. And if backlog exceeds its count,
  kfree_skb() is called. But in RT, kfree_skb() might
  gets scheduled out, so it expects non atomic context.

3)When CONFIG_PREEMPT_RT_FULL is not defined,
 migrate_enable(), migrate_disable() maps to
 preempt_enable() and preempt_disable(), so no
 change in functionality in case of non-RT.

-Replace preempt_enable(), preempt_disable() with
 migrate_enable(), migrate_disable() respectively
-Replace get_cpu(), put_cpu() with get_cpu_light(),
 put_cpu_light() respectively

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Acked-by: Rajan Srivastava <Rajan.Srivastava@freescale.com>
---
 Testing: Tested successfully on p4080ds(8-core SMP system)  

 net/core/dev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 452db70..4017820 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2940,7 +2940,7 @@ int netif_rx(struct sk_buff *skb)
 		struct rps_dev_flow voidflow, *rflow = &voidflow;
 		int cpu;
 
-		preempt_disable();
+		migrate_disable();
 		rcu_read_lock();
 
 		cpu = get_rps_cpu(skb->dev, skb, &rflow);
@@ -2950,13 +2950,13 @@ int netif_rx(struct sk_buff *skb)
 		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
 
 		rcu_read_unlock();
-		preempt_enable();
+		migrate_enable();
 	} else
 #endif
 	{
 		unsigned int qtail;
-		ret = enqueue_to_backlog(skb, get_cpu(), &qtail);
-		put_cpu();
+		ret = enqueue_to_backlog(skb, get_cpu_light(), &qtail);
+		put_cpu_light();
 	}
 	return ret;
 }
-- 
1.7.4.1



