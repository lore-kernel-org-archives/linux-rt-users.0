From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: net: free the sbs in skbufhead
Date: Mon, 12 Dec 2016 17:54:13 +0100
Message-ID: <20161212165413.23036-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In "skbufhead-raw-lock.patch" we moved the memory to a list and the hunk th=
at
cleared the list got misplaced.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5201,13 +5201,21 @@ static void net_rx_action(struct softirq
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
 	unsigned long time_limit =3D jiffies + 2;
 	int budget =3D netdev_budget;
+	struct sk_buff_head tofree_q;
+	struct sk_buff *skb;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
=20
+	__skb_queue_head_init(&tofree_q);
+
 	local_irq_disable();
+	skb_queue_splice_init(&sd->tofree_queue, &tofree_q);
 	list_splice_init(&sd->poll_list, &list);
 	local_irq_enable();
=20
+	while ((skb =3D __skb_dequeue(&tofree_q)))
+		kfree_skb(skb);
+
 	for (;;) {
 		struct napi_struct *n;
=20
