From: brian@peloton-tech.com
Subject: [PATCH] net: detect recursive dev_queue_xmit() on RT properly
Date: Wed, 12 Oct 2016 22:26:01 -0400
Message-ID: <1476325561-16755-1-git-send-email-brian@peloton-tech.com>
Cc: mark.beauchemin@sycamorenet.com, mbeauch@cox.net, mingo@kernel.org,
        tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
        Brian Silverman <brian@peloton-tech.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33928 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933767AbcJMDTv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 23:19:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id r16so4601789pfg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2016 20:19:51 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: mbeauch <mbeauch@cox.net>

Changed the real-time patch code to detect recursive calls
to dev_queue_xmit and drop the packet when detected.

>From Brian Silverman:
!RT is relying on rcu_read_lock_bh to disable preemption here, so it can
rely a given smp_processor_id() only being in the call stack once.
However, on RT, that's not true when one task preempts another one,
which results in false warnings and dropped packets.

Without this, messages like
"Dead loop on virtual device vcan0, fix it urgently!" show up in dmesg
when multiple processes are sending on the same virtual device at the
same time and sendmsg calls return ENETDOWN at random.

This also includes "543a589a00e8 net: xmit lock owner cleanup" from
v2.6.33.9-rt31 by mingo and tglx, which was just some cleanups to the
original patch which make porting to to current upstream easier.

Signed-off-by: Mark Beauchemin <mark.beauchemin@sycamorenet.com>
[ ported to latest upstream ]
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ ported to 4.8 and used struct task_struct instead of void ]
Signed-off-by: Brian Silverman <brian@peloton-tech.com>

Change-Id: Ieeaf93857f4da8fc5a11c2af6b58539ac031603b
---
 drivers/net/ethernet/broadcom/bnx2.c            |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  2 +-
 drivers/net/ethernet/broadcom/tg3.c             |  2 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c       |  2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c      |  4 +--
 drivers/net/ethernet/marvell/mvneta.c           |  2 +-
 drivers/net/ethernet/nxp/lpc_eth.c              |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c    |  2 +-
 drivers/net/ethernet/sun/niu.c                  |  2 +-
 drivers/net/ethernet/sun/sungem.c               |  6 ++--
 drivers/net/ethernet/sun/sunvnet_common.c       |  2 +-
 include/linux/netdevice.h                       | 38 ++++++++++++++-----------
 net/core/dev.c                                  |  8 ++----
 net/core/netpoll.c                              |  2 +-
 net/core/pktgen.c                               |  2 +-
 net/packet/af_packet.c                          |  2 +-
 net/sched/sch_generic.c                         |  2 +-
 18 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 505ceaf..929e2cc 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -2927,7 +2927,7 @@ bnx2_tx_int(struct bnx2 *bp, struct bnx2_napi *bnapi, int budget)
 
 	if (unlikely(netif_tx_queue_stopped(txq)) &&
 		     (bnx2_tx_avail(bp, txr) > bp->tx_wake_thresh)) {
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if ((netif_tx_queue_stopped(txq)) &&
 		    (bnx2_tx_avail(bp, txr) > bp->tx_wake_thresh))
 			netif_tx_wake_queue(txq);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 0a9108c..ac3800d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -328,7 +328,7 @@ int bnx2x_tx_int(struct bnx2x *bp, struct bnx2x_fp_txdata *txdata)
 		 * stops the queue
 		 */
 
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 
 		if ((netif_tx_queue_stopped(txq)) &&
 		    (bp->state == BNX2X_STATE_OPEN) &&
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 228c964..2727ee8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -560,7 +560,7 @@ next_tx_int:
 
 	if (unlikely(netif_tx_queue_stopped(txq)) &&
 	    (bnxt_tx_avail(bp, txr) > bp->tx_wake_thresh)) {
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if (netif_tx_queue_stopped(txq) &&
 		    bnxt_tx_avail(bp, txr) > bp->tx_wake_thresh &&
 		    txr->dev_state != BNXT_DEV_STATE_CLOSING)
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ea967df..a54be72 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6605,7 +6605,7 @@ static void tg3_tx(struct tg3_napi *tnapi)
 
 	if (unlikely(netif_tx_queue_stopped(txq) &&
 		     (tg3_tx_avail(tnapi) > TG3_TX_WAKEUP_THRESH(tnapi)))) {
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if (netif_tx_queue_stopped(txq) &&
 		    (tg3_tx_avail(tnapi) > TG3_TX_WAKEUP_THRESH(tnapi)))
 			netif_tx_wake_queue(txq);
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 54efa9a..ffe9176 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -872,7 +872,7 @@ static struct ehea_cqe *ehea_proc_cqes(struct ehea_port_res *pr, int my_quota)
 
 	if (unlikely(netif_tx_queue_stopped(txq) &&
 		     (atomic_read(&pr->swqe_avail) >= pr->swqe_refill_th))) {
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if (netif_tx_queue_stopped(txq) &&
 		    (atomic_read(&pr->swqe_avail) >= pr->swqe_refill_th))
 			netif_tx_wake_queue(txq);
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 5583118..4027bb5 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -511,7 +511,7 @@ static void txq_maybe_wake(struct tx_queue *txq)
 	struct netdev_queue *nq = netdev_get_tx_queue(mp->dev, txq->index);
 
 	if (netif_tx_queue_stopped(nq)) {
-		__netif_tx_lock(nq, smp_processor_id());
+		__netif_tx_lock(nq);
 		if (txq->tx_desc_count <= txq->tx_wake_threshold)
 			netif_tx_wake_queue(nq);
 		__netif_tx_unlock(nq);
@@ -1055,7 +1055,7 @@ static void txq_kick(struct tx_queue *txq)
 	u32 hw_desc_ptr;
 	u32 expected_ptr;
 
-	__netif_tx_lock(nq, smp_processor_id());
+	__netif_tx_lock(nq);
 
 	if (rdlp(mp, TXQ_COMMAND) & (1 << txq->index))
 		goto out;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d41c28d..4227124 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2402,7 +2402,7 @@ static void mvneta_tx_done_gbe(struct mvneta_port *pp, u32 cause_tx_done)
 		txq = mvneta_tx_done_policy(pp, cause_tx_done);
 
 		nq = netdev_get_tx_queue(pp->dev, txq->id);
-		__netif_tx_lock(nq, smp_processor_id());
+		__netif_tx_lock(nq);
 
 		if (txq->count)
 			mvneta_txq_done(pp, txq);
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 8e13ec8..9e80d31 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -993,7 +993,7 @@ static int lpc_eth_poll(struct napi_struct *napi, int budget)
 	int rx_done = 0;
 	struct netdev_queue *txq = netdev_get_tx_queue(ndev, 0);
 
-	__netif_tx_lock(txq, smp_processor_id());
+	__netif_tx_lock(txq);
 	__lpc_handle_xmit(ndev);
 	__netif_tx_unlock(txq);
 	rx_done = __lpc_handle_recv(ndev, budget);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 9544e4c..95b1b47a 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -817,7 +817,7 @@ static int qede_tx_int(struct qede_dev *edev,
 		 * stops the queue
 		 */
 
-		__netif_tx_lock(netdev_txq, smp_processor_id());
+		__netif_tx_lock(netdev_txq);
 
 		if ((netif_tx_queue_stopped(netdev_txq)) &&
 		    (edev->state == QEDE_STATE_OPEN) &&
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index a2371aa..066db94 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3633,7 +3633,7 @@ static void niu_tx_work(struct niu *np, struct tx_ring_info *rp)
 out:
 	if (unlikely(netif_tx_queue_stopped(txq) &&
 		     (niu_tx_avail(rp) > NIU_TX_WAKEUP_THRESH(rp)))) {
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if (netif_tx_queue_stopped(txq) &&
 		    (niu_tx_avail(rp) > NIU_TX_WAKEUP_THRESH(rp)))
 			netif_tx_wake_queue(txq);
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index d6ad0fb..7e6305e 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -702,7 +702,7 @@ static __inline__ void gem_tx(struct net_device *dev, struct gem *gp, u32 gem_st
 		     TX_BUFFS_AVAIL(gp) > (MAX_SKB_FRAGS + 1))) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, 0);
 
-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);
 		if (netif_queue_stopped(dev) &&
 		    TX_BUFFS_AVAIL(gp) > (MAX_SKB_FRAGS + 1))
 			netif_wake_queue(dev);
@@ -896,7 +896,7 @@ static int gem_poll(struct napi_struct *napi, int budget)
 			 * chip, but we need to guard it against DMA being
 			 * restarted by the link poll timer
 			 */
-			__netif_tx_lock(txq, smp_processor_id());
+			__netif_tx_lock(txq);
 			reset = gem_abnormal_irq(dev, gp, gp->status);
 			__netif_tx_unlock(txq);
 			if (reset) {
@@ -1367,7 +1367,7 @@ static int gem_set_link_modes(struct gem *gp)
 	/* We take the tx queue lock to avoid collisions between
 	 * this code, the tx path and the NAPI-driven error path
 	 */
-	__netif_tx_lock(txq, smp_processor_id());
+	__netif_tx_lock(txq);
 
 	val = (MAC_TXCFG_EIPG0 | MAC_TXCFG_NGU);
 	if (full_duplex) {
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 904a5a1..1f0455f 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -714,7 +714,7 @@ static void maybe_tx_wakeup(struct vnet_port *port)
 
 	txq = netdev_get_tx_queue(VNET_PORT_TO_NET_DEVICE(port),
 				  port->q_index);
-	__netif_tx_lock(txq, smp_processor_id());
+	__netif_tx_lock(txq);
 	if (likely(netif_tx_queue_stopped(txq))) {
 		struct vio_dring_state *dr;
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e8d79d4..1860aed 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -65,6 +65,8 @@ struct mpls_dev;
 struct udp_tunnel_info;
 struct bpf_prog;
 
+struct task_struct;
+
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops);
 
@@ -581,7 +583,7 @@ struct netdev_queue {
  * write-mostly part
  */
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
-	int			xmit_lock_owner;
+	struct task_struct	*xmit_lock_owner;
 	/*
 	 * Time (in jiffies) of last Tx
 	 */
@@ -3481,41 +3483,49 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	return (1 << debug_value) - 1;
 }
 
-static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
+static inline void __netif_tx_lock(struct netdev_queue *txq)
 {
 	spin_lock(&txq->_xmit_lock);
-	txq->xmit_lock_owner = cpu;
+	txq->xmit_lock_owner = current;
+}
+
+/*
+ * Do we hold the xmit_lock already?
+ */
+static inline int netif_tx_lock_recursion(struct netdev_queue *txq)
+{
+	return txq->xmit_lock_owner == current;
 }
 
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	txq->xmit_lock_owner = smp_processor_id();
+	txq->xmit_lock_owner = current;
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 {
 	bool ok = spin_trylock(&txq->_xmit_lock);
 	if (likely(ok))
-		txq->xmit_lock_owner = smp_processor_id();
+		txq->xmit_lock_owner = current;
 	return ok;
 }
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	txq->xmit_lock_owner = NULL;
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	txq->xmit_lock_owner = NULL;
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
 static inline void txq_trans_update(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (txq->xmit_lock_owner != NULL)
 		txq->trans_start = jiffies;
 }
 
@@ -3537,10 +3547,8 @@ static inline void netif_trans_update(struct net_device *dev)
 static inline void netif_tx_lock(struct net_device *dev)
 {
 	unsigned int i;
-	int cpu;
 
 	spin_lock(&dev->tx_global_lock);
-	cpu = smp_processor_id();
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
 
@@ -3550,7 +3558,7 @@ static inline void netif_tx_lock(struct net_device *dev)
 		 * the ->hard_start_xmit() handler and already
 		 * checked the frozen bit.
 		 */
-		__netif_tx_lock(txq, cpu);
+		__netif_tx_lock(txq);
 		set_bit(__QUEUE_STATE_FROZEN, &txq->state);
 		__netif_tx_unlock(txq);
 	}
@@ -3585,9 +3593,9 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 	local_bh_enable();
 }
 
-#define HARD_TX_LOCK(dev, txq, cpu) {			\
+#define HARD_TX_LOCK(dev, txq) {			\
 	if ((dev->features & NETIF_F_LLTX) == 0) {	\
-		__netif_tx_lock(txq, cpu);		\
+		__netif_tx_lock(txq);			\
 	}						\
 }
 
@@ -3605,14 +3613,12 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 static inline void netif_tx_disable(struct net_device *dev)
 {
 	unsigned int i;
-	int cpu;
 
 	local_bh_disable();
-	cpu = smp_processor_id();
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
 
-		__netif_tx_lock(txq, cpu);
+		__netif_tx_lock(txq);
 		netif_tx_stop_queue(txq);
 		__netif_tx_unlock(txq);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index ea63120..fca86e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3387,9 +3387,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 	   Either shot noqueue qdisc, it is even simpler 8)
 	 */
 	if (dev->flags & IFF_UP) {
-		int cpu = smp_processor_id(); /* ok because BHs are off */
-
-		if (txq->xmit_lock_owner != cpu) {
+		if (!netif_tx_lock_recursion(txq)) {
 			if (unlikely(__this_cpu_read(xmit_recursion) >
 				     XMIT_RECURSION_LIMIT))
 				goto recursion_alert;
@@ -3398,7 +3396,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 			if (!skb)
 				goto out;
 
-			HARD_TX_LOCK(dev, txq, cpu);
+			HARD_TX_LOCK(dev, txq);
 
 			if (!netif_xmit_stopped(txq)) {
 				__this_cpu_inc(xmit_recursion);
@@ -7047,7 +7045,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
 	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
-	queue->xmit_lock_owner = -1;
+	queue->xmit_lock_owner = NULL;
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 53599bd..92335af 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -114,7 +114,7 @@ static void queue_process(struct work_struct *work)
 		txq = skb_get_tx_queue(dev, skb);
 
 		local_irq_save(flags);
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		HARD_TX_LOCK(dev, txq);
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    netpoll_start_xmit(skb, dev, txq) != NETDEV_TX_OK) {
 			skb_queue_head(&npinfo->txq, skb);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index bbd118b..5fdcbb6 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3478,7 +3478,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 
 	local_bh_disable();
 
-	HARD_TX_LOCK(odev, txq, smp_processor_id());
+	HARD_TX_LOCK(odev, txq);
 
 	if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
 		ret = NETDEV_TX_BUSY;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 33a4697..101d855 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -267,7 +267,7 @@ static int packet_direct_xmit(struct sk_buff *skb)
 
 	local_bh_disable();
 
-	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	HARD_TX_LOCK(dev, txq);
 	if (!netif_xmit_frozen_or_drv_stopped(txq))
 		ret = netdev_start_xmit(skb, dev, txq, false);
 	HARD_TX_UNLOCK(dev, txq);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 657c133..2f42472 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -177,7 +177,7 @@ int sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 		skb = validate_xmit_skb_list(skb, dev);
 
 	if (likely(skb)) {
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		HARD_TX_LOCK(dev, txq);
 		if (!netif_xmit_frozen_or_stopped(txq))
 			skb = dev_hard_start_xmit(skb, dev, txq, &ret);
 
-- 
2.1.4

