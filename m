From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: [PATCH RT] - Mellanox IB driver patch
Date: Fri, 24 Aug 2007 02:25:26 -0700
Message-ID: <1187947526.16573.56.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	LKML <Linux-kernel@vger.kernel.org>,
	RT Users List <linux-rt-users@vger.kernel.org>,
	Linux Solutions Group List <lsg@lists.novell.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:55526 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbXHXJZd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 05:25:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi Ingo,

RT driver patch to eliminate in_atomic stack dump.

The problem code was identified by Michael S. Tsirkin, and he suggested
the fix.

I adapted to use RT's _nort primitives- should work correctly in all
configs.

Thanks,

Sven


Fixes in_atomic stack-dump, when Mellanox module 
is loaded into the RT Kernel.

From: Michael S. Tsirkin <mst@dev.mellanox.co.il> 

"Basically, if you just make spin_lock_irqsave (and spin_lock_irq) not disable
interrupts for non-raw spinlocks, I think all of infiniband will be fine without
changes."

signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>


Index: linux-2.6.21/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
===================================================================
--- linux-2.6.21.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ linux-2.6.21/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -788,7 +788,7 @@ void ipoib_mcast_restart_task(struct wor
 
 	ipoib_mcast_stop_thread(dev, 0);
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	netif_tx_lock(dev);
 	spin_lock(&priv->lock);
 
@@ -863,7 +863,7 @@ void ipoib_mcast_restart_task(struct wor
 
 	spin_unlock(&priv->lock);
 	netif_tx_unlock(dev);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 
 	/* We have to cancel outside of the spinlock */
 	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {
