From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/5] net: free the sbs in skbufhead
Date: Thu, 09 Feb 2017 10:32:54 -0500
Message-ID: <20170209153304.288796607@goodmis.org>
References: <20170209153252.869145006@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        stable@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-net-free-the-sbs-in-skbufhead.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In "skbufhead-raw-lock.patch" we moved the memory to a list and the hunk that
cleared the list got misplaced.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f1c1a198d4b7..6b2436f0fc66 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4764,13 +4764,21 @@ static void net_rx_action(struct softirq_action *h)
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies + 2;
 	int budget = netdev_budget;
+	struct sk_buff_head tofree_q;
+	struct sk_buff *skb;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	__skb_queue_head_init(&tofree_q);
+
 	local_irq_disable();
+	skb_queue_splice_init(&sd->tofree_queue, &tofree_q);
 	list_splice_init(&sd->poll_list, &list);
 	local_irq_enable();
 
+	while ((skb = __skb_dequeue(&tofree_q)))
+		kfree_skb(skb);
+
 	for (;;) {
 		struct napi_struct *n;
 
-- 
2.10.2
