Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1539C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817DE60F02
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 08:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJRItY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhJRItX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 04:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BDC06161C;
        Mon, 18 Oct 2021 01:47:11 -0700 (PDT)
Date:   Mon, 18 Oct 2021 10:47:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634546828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6qEXpASRT/Mdf2JdBoGJ5KAHrs4QH3Dl2IvgDP1C9Ig=;
        b=wckAzQscC9k8rvScf36KbNkI/fp/a3eIYVEkkeKEReBc57gj0986emb56SxUfVOcn34olS
        SUR+QHV6VUVOSxfYhEYTPLR4KTCQhfpjR0TjdFXsupcmxabIeLhY4s1WQCY6/s69yDA/q4
        MqSyn5c0VOlNVqpgpxiq67Q49fvdA0sl4SdXe/2sAtniOI8gkkVK1XWO9gtwq4hW5HrEfd
        6VuUJXN/qXyTaBqxeq7GrfgGhONxxbMsJqYN0phPMtnNKxu/7tLCkU7JB4vUNFf5fMJrSn
        g+jzmLZbdqq6cFLGGbRwTV0bJ1XZbjRFPErZtY4aDwjc0oFLCNnl2PpHcFvn7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634546828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6qEXpASRT/Mdf2JdBoGJ5KAHrs4QH3Dl2IvgDP1C9Ig=;
        b=DTOylqALIa4c6UMSbySyBMfhW0uXc4L4u/G8gbzpzN+MItW1Rb5IVST3Bupqf0yG3VTUuk
        dsyP4VK1fgY3PhBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc6-rt12
Message-ID: <20211018084707.gljgxvigefrotvzm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc6-rt12 patch set. 

Changes since v5.15-rc6-rt11:

  - Remove printk_deferred_*() from workqueue. It was recently added and
    is no needed due to the printk rework.

  - The net related series which removes seqcount_t from Qdisc has been
    updated to the version posted upstream for review.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rc6-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc6-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc6-rt12

The RT patch against v5.15-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc6-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc6-rt12.tar.xz

Sebastian

diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 4578bbf3fc1f5..7aa2b8e1fb298 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -13,7 +13,7 @@
  * If no reads can ever occur parallel to writes (e.g. stack-allocated
  * bstats), then the internal stat values can be written to and read
  * from directly. Otherwise, use _bstats_set/update() for writes and
- * __gnet_stats_copy_basic() for reads.
+ * gnet_stats_add_basic() for reads.
  */
 struct gnet_stats_basic_sync {
 	u64_stats_t bytes;
@@ -21,19 +21,6 @@ struct gnet_stats_basic_sync {
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
-#ifdef CONFIG_LOCKDEP
-void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b);
-
-#else
-
-static inline void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
-{
-	u64_stats_set(&b->bytes, 0);
-	u64_stats_set(&b->packets, 0);
-	u64_stats_init(&b->syncp);
-}
-#endif
-
 struct net_rate_estimator;
 
 struct gnet_dump {
@@ -50,6 +37,7 @@ struct gnet_dump {
 	struct tc_stats   tc_stats;
 };
 
+void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b);
 int gnet_stats_start_copy(struct sk_buff *skb, int type, spinlock_t *lock,
 			  struct gnet_dump *d, int padattr);
 
@@ -60,24 +48,21 @@ int gnet_stats_start_copy_compat(struct sk_buff *skb, int type,
 
 int gnet_stats_copy_basic(struct gnet_dump *d,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b,
-			  bool running);
-void __gnet_stats_copy_basic(struct gnet_stats_basic_sync *bstats,
-			     struct gnet_stats_basic_sync __percpu *cpu,
-			     struct gnet_stats_basic_sync *b,
-			     bool running);
+			  struct gnet_stats_basic_sync *b, bool running);
+void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
+			  struct gnet_stats_basic_sync __percpu *cpu,
+			  struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_basic_hw(struct gnet_dump *d,
 			     struct gnet_stats_basic_sync __percpu *cpu,
-			     struct gnet_stats_basic_sync *b,
-			     bool unning);
+			     struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_rate_est(struct gnet_dump *d,
 			     struct net_rate_estimator __rcu **ptr);
 int gnet_stats_copy_queue(struct gnet_dump *d,
 			  struct gnet_stats_queue __percpu *cpu_q,
 			  struct gnet_stats_queue *q, __u32 qlen);
-void __gnet_stats_copy_queue(struct gnet_stats_queue *qstats,
-			     const struct gnet_stats_queue __percpu *cpu_q,
-			     const struct gnet_stats_queue *q, __u32 qlen);
+void gnet_stats_add_queue(struct gnet_stats_queue *qstats,
+			  const struct gnet_stats_queue __percpu *cpu_q,
+			  const struct gnet_stats_queue *q);
 int gnet_stats_copy_app(struct gnet_dump *d, void *st, int len);
 
 int gnet_stats_finish_copy(struct gnet_dump *d);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 023322c8d7c0e..21fd95665ca02 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -849,22 +849,6 @@ static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
 	u64_stats_update_end(&bstats->syncp);
 }
 
-static inline void bstats_read_add(struct gnet_stats_basic_sync *bstats,
-				   __u64 *bytes, __u64 *packets)
-{
-	u64 t_bytes, t_packets;
-	unsigned int start;
-
-	do {
-		start = u64_stats_fetch_begin_irq(&bstats->syncp);
-		t_bytes = u64_stats_read(&bstats->bytes);
-		t_packets = u64_stats_read(&bstats->packets);
-	} while (u64_stats_fetch_retry_irq(&bstats->syncp, start));
-
-	*bytes = t_bytes;
-	*packets = t_packets;
-}
-
 static inline void bstats_update(struct gnet_stats_basic_sync *bstats,
 				 const struct sk_buff *skb)
 {
@@ -965,10 +949,9 @@ static inline void qdisc_qstats_qlen_backlog(struct Qdisc *sch,  __u32 *qlen,
 					     __u32 *backlog)
 {
 	struct gnet_stats_queue qstats = { 0 };
-	__u32 len = qdisc_qlen_sum(sch);
 
-	__gnet_stats_copy_queue(&qstats, sch->cpu_qstats, &sch->qstats, len);
-	*qlen = qstats.qlen;
+	gnet_stats_add_queue(&qstats, sch->cpu_qstats, &sch->qstats);
+	*qlen = qstats.qlen + qdisc_qlen(sch);
 	*backlog = qstats.backlog;
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1b3eb1e9531f4..a25b9abc918a0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4836,9 +4836,7 @@ void show_workqueue_state(void)
 				 * drivers that queue work while holding locks
 				 * also taken in their write paths.
 				 */
-				printk_deferred_enter();
 				show_pwq(pwq);
-				printk_deferred_exit();
 			}
 			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
@@ -4862,7 +4860,6 @@ void show_workqueue_state(void)
 		 * queue work while holding locks also taken in their write
 		 * paths.
 		 */
-		printk_deferred_enter();
 		pr_info("pool %d:", pool->id);
 		pr_cont_pool_info(pool);
 		pr_cont(" hung=%us workers=%d",
@@ -4877,7 +4874,6 @@ void show_workqueue_state(void)
 			first = false;
 		}
 		pr_cont("\n");
-		printk_deferred_exit();
 	next_pool:
 		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index db5f0a77f4b38..4fcbdd71c59fa 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -66,7 +66,7 @@ static void est_fetch_counters(struct net_rate_estimator *e,
 	if (e->stats_lock)
 		spin_lock(e->stats_lock);
 
-	__gnet_stats_copy_basic(b, e->cpu_bstats, e->bstats, e->running);
+	gnet_stats_add_basic(b, e->cpu_bstats, e->bstats, e->running);
 
 	if (e->stats_lock)
 		spin_unlock(e->stats_lock);
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index b7d8e477897e1..5516ea0d5da0b 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -114,7 +114,6 @@ gnet_stats_start_copy(struct sk_buff *skb, int type, spinlock_t *lock,
 }
 EXPORT_SYMBOL(gnet_stats_start_copy);
 
-#ifdef CONFIG_LOCKDEP
 /* Must not be inlined, due to u64_stats seqcount_t lockdep key */
 void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 {
@@ -123,11 +122,9 @@ void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 	u64_stats_init(&b->syncp);
 }
 EXPORT_SYMBOL(gnet_stats_basic_sync_init);
-#endif
 
-static void
-__gnet_stats_copy_basic_cpu(struct gnet_stats_basic_sync *bstats,
-			    struct gnet_stats_basic_sync __percpu *cpu)
+static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
+				     struct gnet_stats_basic_sync __percpu *cpu)
 {
 	u64 t_bytes = 0, t_packets = 0;
 	int i;
@@ -149,20 +146,18 @@ __gnet_stats_copy_basic_cpu(struct gnet_stats_basic_sync *bstats,
 	_bstats_update(bstats, t_bytes, t_packets);
 }
 
-void
-__gnet_stats_copy_basic(struct gnet_stats_basic_sync *bstats,
-			struct gnet_stats_basic_sync __percpu *cpu,
-			struct gnet_stats_basic_sync *b,
-			bool running)
+void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
+			  struct gnet_stats_basic_sync __percpu *cpu,
+			  struct gnet_stats_basic_sync *b, bool running)
 {
 	unsigned int start;
-	__u64 bytes = 0;
-	__u64 packets = 0;
+	u64 bytes = 0;
+	u64 packets = 0;
 
 	WARN_ON_ONCE((cpu || running) && !in_task());
 
 	if (cpu) {
-		__gnet_stats_copy_basic_cpu(bstats, cpu);
+		gnet_stats_add_basic_cpu(bstats, cpu);
 		return;
 	}
 	do {
@@ -174,7 +169,7 @@ __gnet_stats_copy_basic(struct gnet_stats_basic_sync *bstats,
 
 	_bstats_update(bstats, bytes, packets);
 }
-EXPORT_SYMBOL(__gnet_stats_copy_basic);
+EXPORT_SYMBOL(gnet_stats_add_basic);
 
 static int
 ___gnet_stats_copy_basic(struct gnet_dump *d,
@@ -186,7 +181,7 @@ ___gnet_stats_copy_basic(struct gnet_dump *d,
 	u64 bstats_bytes, bstats_packets;
 
 	gnet_stats_basic_sync_init(&bstats);
-	__gnet_stats_copy_basic(&bstats, cpu, b, running);
+	gnet_stats_add_basic(&bstats, cpu, b, running);
 
 	bstats_bytes = u64_stats_read(&bstats.bytes);
 	bstats_packets = u64_stats_read(&bstats.packets);
@@ -311,16 +306,15 @@ gnet_stats_copy_rate_est(struct gnet_dump *d,
 }
 EXPORT_SYMBOL(gnet_stats_copy_rate_est);
 
-static void
-__gnet_stats_copy_queue_cpu(struct gnet_stats_queue *qstats,
-			    const struct gnet_stats_queue __percpu *q)
+static void gnet_stats_add_queue_cpu(struct gnet_stats_queue *qstats,
+				     const struct gnet_stats_queue __percpu *q)
 {
 	int i;
 
 	for_each_possible_cpu(i) {
 		const struct gnet_stats_queue *qcpu = per_cpu_ptr(q, i);
 
-		qstats->qlen = 0;
+		qstats->qlen += qcpu->backlog;
 		qstats->backlog += qcpu->backlog;
 		qstats->drops += qcpu->drops;
 		qstats->requeues += qcpu->requeues;
@@ -328,13 +322,12 @@ __gnet_stats_copy_queue_cpu(struct gnet_stats_queue *qstats,
 	}
 }
 
-void __gnet_stats_copy_queue(struct gnet_stats_queue *qstats,
-			     const struct gnet_stats_queue __percpu *cpu,
-			     const struct gnet_stats_queue *q,
-			     __u32 qlen)
+void gnet_stats_add_queue(struct gnet_stats_queue *qstats,
+			  const struct gnet_stats_queue __percpu *cpu,
+			  const struct gnet_stats_queue *q)
 {
 	if (cpu) {
-		__gnet_stats_copy_queue_cpu(qstats, cpu);
+		gnet_stats_add_queue_cpu(qstats, cpu);
 	} else {
 		qstats->qlen += q->qlen;
 		qstats->backlog += q->backlog;
@@ -342,10 +335,8 @@ void __gnet_stats_copy_queue(struct gnet_stats_queue *qstats,
 		qstats->requeues += q->requeues;
 		qstats->overlimits += q->overlimits;
 	}
-
-	qstats->qlen += qlen;
 }
-EXPORT_SYMBOL(__gnet_stats_copy_queue);
+EXPORT_SYMBOL(gnet_stats_add_queue);
 
 /**
  * gnet_stats_copy_queue - copy queue statistics into statistics TLV
@@ -368,7 +359,8 @@ gnet_stats_copy_queue(struct gnet_dump *d,
 {
 	struct gnet_stats_queue qstats = {0};
 
-	__gnet_stats_copy_queue(&qstats, cpu_q, q, qlen);
+	gnet_stats_add_queue(&qstats, cpu_q, q);
+	qstats.qlen = qlen;
 
 	if (d->compat_tc_stats) {
 		d->tc_stats.drops = qstats.drops;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 4133b8ea5a57a..3258da3d5bed5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1174,7 +1174,7 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 		goto errout;
 
 	if (gnet_stats_copy_basic(&d, p->cpu_bstats,
-				  &p->tcfa_bstats, false ) < 0 ||
+				  &p->tcfa_bstats, false) < 0 ||
 	    gnet_stats_copy_basic_hw(&d, p->cpu_bstats_hw,
 				     &p->tcfa_bstats_hw, false) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &p->tcfa_rate_est) < 0 ||
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 661d5f7faea8d..cf1d45db4e84b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1324,10 +1324,12 @@ static void htb_offload_aggregate_stats(struct htb_sched *q,
 			if (p != cl)
 				continue;
 
-			bstats_read_add(&c->bstats_bias, &bytes, &packets);
-			if (c->level == 0)
-				bstats_read_add(&c->leaf.q->bstats,
-						&bytes, &packets);
+			bytes += u64_stats_read(&c->bstats_bias.bytes);
+			packets += u64_stats_read(&c->bstats_bias.packets);
+			if (c->level == 0) {
+				bytes += u64_stats_read(&c->leaf.q->bstats.bytes);
+				packets += u64_stats_read(&c->leaf.q->bstats.packets);
+			}
 		}
 	}
 	_bstats_update(&cl->bstats, bytes, packets);
@@ -1354,15 +1356,13 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 
 	if (q->offload) {
 		if (!cl->level) {
-			u64 bytes = 0, packets = 0;
-
 			if (cl->leaf.q)
 				cl->bstats = cl->leaf.q->bstats;
 			else
 				gnet_stats_basic_sync_init(&cl->bstats);
-
-			bstats_read_add(&cl->bstats_bias, &bytes, &packets);
-			_bstats_update(&cl->bstats, bytes, packets);
+			_bstats_update(&cl->bstats,
+				       u64_stats_read(&cl->bstats_bias.bytes),
+				       u64_stats_read(&cl->bstats_bias.packets));
 		} else {
 			htb_offload_aggregate_stats(q, cl);
 		}
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 94bc53475a0b6..ad3d7220709e2 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -130,7 +130,6 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *qdisc;
 	unsigned int ntx;
-	__u32 qlen = 0;
 
 	sch->q.qlen = 0;
 	gnet_stats_basic_sync_init(&sch->bstats);
@@ -145,14 +144,12 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
 
-		qlen = qdisc_qlen_sum(qdisc);
+		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, false);
+		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+				     &qdisc->qstats);
+		sch->q.qlen += qdisc_qlen(qdisc);
 
-		__gnet_stats_copy_basic(&sch->bstats, qdisc->cpu_bstats,
-					&qdisc->bstats, false);
-		__gnet_stats_copy_queue(&sch->qstats,
-					qdisc->cpu_qstats,
-					&qdisc->qstats, qlen);
-		sch->q.qlen		+= qlen;
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index c9dc0cec12b95..5cc86c7cbe826 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -399,17 +399,14 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		u32 qlen = qdisc_qlen_sum(qdisc);
-
 		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
 
-		__gnet_stats_copy_basic(&sch->bstats, qdisc->cpu_bstats,
-					&qdisc->bstats, false);
-		__gnet_stats_copy_queue(&sch->qstats,
-					qdisc->cpu_qstats,
-					&qdisc->qstats, qlen);
-		sch->q.qlen		+= qlen;
+		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, false);
+		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+				     &qdisc->qstats);
+		sch->q.qlen += qdisc_qlen(qdisc);
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
@@ -501,7 +498,7 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	if (cl >= TC_H_MIN_PRIORITY) {
 		int i;
-		__u32 qlen = 0;
+		__u32 qlen;
 		struct gnet_stats_queue qstats = {0};
 		struct gnet_stats_basic_sync bstats;
 		struct net_device *dev = qdisc_dev(sch);
@@ -522,15 +519,15 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 
 			spin_lock_bh(qdisc_lock(qdisc));
 
-			qlen = qdisc_qlen_sum(qdisc);
-			__gnet_stats_copy_basic(&bstats, qdisc->cpu_bstats,
-						&qdisc->bstats, false);
-			__gnet_stats_copy_queue(&qstats,
-						qdisc->cpu_qstats,
-						&qdisc->qstats,
-						qlen);
+			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
+					     &qdisc->bstats, false);
+			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
+					     &qdisc->qstats);
+			sch->q.qlen += qdisc_qlen(qdisc);
+
 			spin_unlock_bh(qdisc_lock(qdisc));
 		}
+		qlen = qdisc_qlen(sch) + qstats.qlen;
 
 		/* Reclaim root sleeping lock before completing stats */
 		if (d->lock)
