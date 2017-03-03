From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc patch] net/netpoll: don't disable irqs in
 netpoll_send_skb()
Date: Fri, 03 Mar 2017 09:53:03 +0100
Message-ID: <1488531183.4506.27.camel@gmx.de>
References: <1488523005.4506.18.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:55251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdCCJ1z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2017 04:27:55 -0500
In-Reply-To: <1488523005.4506.18.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Not that it matters, but there was a hunk missing.

RT takes sleeping locks, we can't disable irqs.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 include/linux/netpoll.h |    8 ++++++--
 net/core/netpoll.c      |    6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -67,9 +67,13 @@ void netpoll_send_skb_on_dev(struct netp
 static inline void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	unsigned long flags;
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		rcu_read_lock();
 	netpoll_send_skb_on_dev(np, skb, np->dev);
-	local_irq_restore(flags);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		rcu_read_unlock();
+	local_irq_restore_nort(flags);
 }
 
 #ifdef CONFIG_NETPOLL
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -328,7 +328,7 @@ void netpoll_send_skb_on_dev(struct netp
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;
 
-	WARN_ON_ONCE(!irqs_disabled());
+	WARN_ON_ONCE_NONRT(!irqs_disabled());
 
 	npinfo = rcu_dereference_bh(np->dev->npinfo);
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
@@ -362,7 +362,7 @@ void netpoll_send_skb_on_dev(struct netp
 			udelay(USEC_PER_POLL);
 		}
 
-		WARN_ONCE(!irqs_disabled(),
+		WARN_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled(),
 			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pF)\n",
 			dev->name, dev->netdev_ops->ndo_start_xmit);
 
@@ -385,7 +385,7 @@ void netpoll_send_udp(struct netpoll *np
 	static atomic_t ip_ident;
 	struct ipv6hdr *ip6h;
 
-	WARN_ON_ONCE(!irqs_disabled());
+	WARN_ON_ONCE_NONRT(!irqs_disabled());
 
 	udp_len = len + sizeof(*udph);
 	if (np->ipv6)
