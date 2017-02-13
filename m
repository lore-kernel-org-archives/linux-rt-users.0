From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.47-rt59
Date: Mon, 13 Feb 2017 17:31:19 -0500
Message-ID: <20170213173119.115c900b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdBMWbZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 17:31:25 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 4.4.47-rt59 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 80398f6fc8e4725cd888477650b5f8a4d441b772


Or to build 4.4.47-rt59 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.47.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.47-rt59.patch.xz



You can also build from 4.4.47-rt58 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.47-rt58-rt59.patch.xz



Enjoy,

-- Steve


Changes from v4.4.47-rt58:

---

Sebastian Andrzej Siewior (2):
      net: free the sbs in skbufhead
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (1):
      net: Have __napi_schedule_irqoff() disable interrupts on RT

Steven Rostedt (VMware) (1):
      Linux 4.4.47-rt59

Yang Shi (1):
      arm: kprobe: replace patch_lock to raw lock

----
 arch/arm/kernel/patch.c   |  6 +++---
 include/linux/netdevice.h | 12 ++++++++++++
 kernel/workqueue.c        |  2 ++
 localversion-rt           |  2 +-
 net/core/dev.c            | 10 ++++++++++
 5 files changed, 28 insertions(+), 4 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a5707e..1f665acaa6a9 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -15,7 +15,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -32,7 +32,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -47,7 +47,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0590f5380814..b3fa55658bd2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -390,7 +390,19 @@ typedef enum rx_handler_result rx_handler_result_t;
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
index 965d5f65e847..d5b0f4fc0eb0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1135,9 +1135,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
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
index f9df2cf089cf..8cdeb45db6e2 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt58
+-rt59
diff --git a/net/core/dev.c b/net/core/dev.c
index a48dbd37dd43..d63b1f9ca08f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4714,6 +4714,7 @@ void __napi_schedule(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * __napi_schedule_irqoff - schedule for receive
  * @n: entry to schedule
@@ -4725,6 +4726,7 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 	____napi_schedule(this_cpu_ptr(&softnet_data), n);
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
+#endif
 
 void __napi_complete(struct napi_struct *n)
 {
@@ -4951,13 +4953,21 @@ static void net_rx_action(struct softirq_action *h)
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
 
