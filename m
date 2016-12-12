From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.8.14-rt9
Date: Mon, 12 Dec 2016 20:09:41 +0100
Message-ID: <20161212190940.mnmgukn3gnuknaxq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.8.14-rt9 patch set. 

Changes since v4.8.14-rt8:

  - If a network interface is removed we move all skbs which are active to
    a list and free it later. The hunk where the list was cleaned up was
    lost and is back.

  - bnx2x and a few others could corrupt their ->poll_list. Patch by
    Steven Rostedt.

  - A missing RCU section in the workqueue code could lead to a "use after
    free" condition if the workqueue was removed. Reported by John Keeping.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.8.14-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/incr/patch-4.8.14-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.8.14-rt9

The RT patch against v4.8.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patch-4.8.14-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patches-4.8.14-rt9.tar.xz

Sebastian
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -395,7 +395,19 @@ typedef enum rx_handler_result rx_handler_result_t;
 typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
 
 void __napi_schedule(struct napi_struct *n);
+
+/*
+ * When PREEMPT_RT_FULL is defined, all device interrupt handlers
+ * run as threads, and they can also be preempted (without PREEMPT_RT
+ * interrupt threads can not be preempted). Which means that calling
+ * __napi_schedule_irqoff() from an interrupt handler can be preempted
+ * and can corrupt the napi->poll_list.
+ */
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define __napi_schedule_irqoff(n) __napi_schedule(n)
+#else
 void __napi_schedule_irqoff(struct napi_struct *n);
+#endif
 
 static inline bool napi_disable_pending(struct napi_struct *n)
 {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1127,9 +1127,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
+		rcu_read_lock();
 		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
 		put_pwq(pwq);
 		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
+		rcu_read_unlock();
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4912,6 +4912,7 @@ void __napi_schedule(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * __napi_schedule_irqoff - schedule for receive
  * @n: entry to schedule
@@ -4923,6 +4924,7 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 	____napi_schedule(this_cpu_ptr(&softnet_data), n);
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
+#endif
 
 void __napi_complete(struct napi_struct *n)
 {
@@ -5212,13 +5214,21 @@ static void net_rx_action(struct softirq_action *h)
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
 
