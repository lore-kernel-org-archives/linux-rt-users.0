From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/20] net: move xmit_recursion to per-task variable on -RT
Date: Wed, 02 Mar 2016 10:37:01 -0500
Message-ID: <20160302153714.582242097@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-net-move-xmit_recursion-to-per-task-variable-on-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A softirq on -RT can be preempted. That means one task is in
__dev_queue_xmit(), gets preempted and another task may enter
__dev_queue_xmit() aw well. netperf together with a bridge device
will then trigger the `recursion alert` because each task increments
the xmit_recursion variable which is per-CPU.
A virtual device like br0 is required to trigger this warning.

This patch moves the counter to per task instead per-CPU so it counts
the recursion properly on -RT.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/netdevice.h |  9 +++++++++
 include/linux/sched.h     |  1 +
 net/core/dev.c            | 41 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ff0f50dcea4a..dab2603bcdba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2130,11 +2130,20 @@ void netdev_freemem(struct net_device *dev);
 void synchronize_net(void);
 int init_dummy_netdev(struct net_device *dev);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline int dev_recursion_level(void)
+{
+	return current->xmit_recursion;
+}
+
+#else
+
 DECLARE_PER_CPU(int, xmit_recursion);
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(xmit_recursion);
 }
+#endif
 
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bdc27dbffbe2..d05f52dcc0f4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1523,6 +1523,7 @@ struct task_struct {
 	struct mutex_waiter *blocked_on;
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
+	int xmit_recursion;
 	int pagefault_disabled;
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/net/core/dev.c b/net/core/dev.c
index 39d2a0ba38ed..b89a1dd9f4d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2861,9 +2861,44 @@ static void skb_update_prio(struct sk_buff *skb)
 #define skb_update_prio(skb)
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+static inline int xmit_rec_read(void)
+{
+       return current->xmit_recursion;
+}
+
+static inline void xmit_rec_inc(void)
+{
+       current->xmit_recursion++;
+}
+
+static inline void xmit_rec_dec(void)
+{
+       current->xmit_recursion--;
+}
+
+#else
+
 DEFINE_PER_CPU(int, xmit_recursion);
 EXPORT_SYMBOL(xmit_recursion);
 
+static inline int xmit_rec_read(void)
+{
+	return __this_cpu_read(xmit_recursion);
+}
+
+static inline void xmit_rec_inc(void)
+{
+	__this_cpu_inc(xmit_recursion);
+}
+
+static inline int xmit_rec_dec(void)
+{
+	__this_cpu_dec(xmit_recursion);
+}
+#endif
+
 #define RECURSION_LIMIT 10
 
 /**
@@ -2965,7 +3000,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 
 		if (txq->xmit_lock_owner != cpu) {
 
-			if (__this_cpu_read(xmit_recursion) > RECURSION_LIMIT)
+			if (xmit_rec_read() > RECURSION_LIMIT)
 				goto recursion_alert;
 
 			skb = validate_xmit_skb(skb, dev);
@@ -2975,9 +3010,9 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
-				__this_cpu_inc(xmit_recursion);
+				xmit_rec_inc();
 				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
-				__this_cpu_dec(xmit_recursion);
+				xmit_rec_dec();
 				if (dev_xmit_complete(rc)) {
 					HARD_TX_UNLOCK(dev, txq);
 					goto out;
-- 
2.7.0
