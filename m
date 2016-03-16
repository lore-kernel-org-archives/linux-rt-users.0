From: eg Engleder Gerhard <eg@keba.com>
Subject: RE: Eliminating Packet Latency [ NOT ENCRYPTED ] [ SIGNATURE_OK ]
Date: Wed, 16 Mar 2016 08:34:10 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA3396C365B9764@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Dave Rolenc <drolenc@rtlogic.com>,
	Michael Hewitt <mhewitt@aha.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam01.mdcs.at ([217.13.183.26]:6205 "EHLO xlspam01.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbcCPHoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 03:44:39 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I found that sometimes when sending network packets, the kernel would hijack the
> thread of the sender when the queue was empty. This would cause issues, since I
> had no control over the priority of that thread, since it could be anything. My fix
> was to never allow the kernel to send in the context of the sending userspace

We had a similar problem and solved it with changed locking:

diff --git a/net/core/dev.c b/net/core/dev.c
index 16fbef8..8f32ac7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2812,20 +2812,24 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, st
ruct Qdisc *q,
                                 struct netdev_queue *txq)
 {
        spinlock_t *root_lock = qdisc_lock(q);
-       bool contended;
        int rc;

        qdisc_pkt_len_init(skb);
        qdisc_calculate_pkt_len(skb, q);
        /*
+        * Always take busylock to enable priority boosting with PREEMPT_RT.
+        * Otherwise the __QDISC_STATE_RUNNING owner can block the transmission
+        * of network packets indefinitly. Without PREEMPT_RT this is not
+        * possible, because the soft IRQ lock done in dev_queue_xmit() is not
+        * interruptible.
+        *
+        * This use of busylock is different to its actual intention:
         * Heuristic to force contended enqueues to serialize on a
         * separate lock before trying to get qdisc main lock.
         * This permits __QDISC___STATE_RUNNING owner to get the lock more
         * often and dequeue packets faster.
         */
-       contended = qdisc_is_running(q);
-       if (unlikely(contended))
-               spin_lock(&q->busylock);
+       spin_lock(&q->busylock);

        spin_lock(root_lock);
        if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
@@ -2841,29 +2845,20 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,

                qdisc_bstats_update(q, skb);

-               if (sch_direct_xmit(skb, q, dev, txq, root_lock, true)) {
-                       if (unlikely(contended)) {
-                               spin_unlock(&q->busylock);
-                               contended = false;
-                       }
+               if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
                        __qdisc_run(q);
-               } else
+               else
                        qdisc_run_end(q);

                rc = NET_XMIT_SUCCESS;
        } else {
                rc = q->enqueue(skb, q) & NET_XMIT_MASK;
                if (qdisc_run_begin(q)) {
-                       if (unlikely(contended)) {
-                               spin_unlock(&q->busylock);
-                               contended = false;
-                       }
                        __qdisc_run(q);
                }
        }
        spin_unlock(root_lock);
-       if (unlikely(contended))
-               spin_unlock(&q->busylock);
+       spin_unlock(&q->busylock);
        return rc;
 }

> thread. I suspect that most uses of the real time  kernel don't expect the real time
> nature of things to extend across the network, but I could be wrong.
I also would not expect real-time properties from the network stack. With the patch
a transmission deadline of 10ms was met.

gerhard
