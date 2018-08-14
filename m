Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVna (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:30 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 07/15] net: use task_struct instead of CPU number as the queue owner on -RT
Date: Tue, 14 Aug 2018 13:54:00 -0500
Message-Id: <bba6ca9aa1af1624f3c255dd1103138afb35217e.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream rt-devel commit 910142bad86ec1031c63b0b37575b2537ef5c27d ]

In commit ("net: move xmit_recursion to per-task variable on -RT") the
recursion level was changed to be per-task since we can get preempted in
BH on -RT. The lock owner should consequently be recorded as the task
that holds the lock and not the CPU. Otherwise we trigger the "Dead loop
on virtual device" warning on SMP systems.

Cc: stable-rt@vger.kernel.org
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	net/core/dev.c
---
 include/linux/netdevice.h | 54 +++++++++++++++++++++++++++++++++++++++++------
 net/core/dev.c            |  6 +++++-
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2bb8ddaf641e..9cc578ba2037 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -556,7 +556,11 @@ struct netdev_queue {
  * write mostly part
  */
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct task_struct	*xmit_lock_owner;
+#else
 	int			xmit_lock_owner;
+#endif
 	/*
 	 * please use this field instead of dev->trans_start
 	 */
@@ -3080,41 +3084,79 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	return (1 << debug_value) - 1;
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = current;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = NULL;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != NULL)
+		return true;
+	return false;
+}
+
+#else
+
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = cpu;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = -1;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != -1)
+		return true;
+	return false;
+}
+#endif
+
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
-	txq->xmit_lock_owner = cpu;
+	netdev_queue_set_owner(txq, cpu);
 }
 
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	txq->xmit_lock_owner = smp_processor_id();
+	netdev_queue_set_owner(txq, smp_processor_id());
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 {
 	bool ok = spin_trylock(&txq->_xmit_lock);
 	if (likely(ok))
-		txq->xmit_lock_owner = smp_processor_id();
+		netdev_queue_set_owner(txq, smp_processor_id());
 	return ok;
 }
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
 static inline void txq_trans_update(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (netdev_queue_has_owner(txq))
 		txq->trans_start = jiffies;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index eb39270ac306..bbdec43abe1c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3028,7 +3028,11 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 	if (dev->flags & IFF_UP) {
 		int cpu = smp_processor_id(); /* ok because BHs are off */
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		if (txq->xmit_lock_owner != current) {
+#else
 		if (txq->xmit_lock_owner != cpu) {
+#endif
 
 			if (xmit_rec_read() > RECURSION_LIMIT)
 				goto recursion_alert;
@@ -6233,7 +6237,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
 	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
-	queue->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(queue);
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL
-- 
2.14.1
