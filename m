Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F238DC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D683D6103D
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJUNZd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJUNZc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Oct 2021 09:25:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957CBC0613B9;
        Thu, 21 Oct 2021 06:23:16 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634822594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9rHdmQC6XkgQSam2feozxixRKu5fHntEqaFo4ZzArYk=;
        b=1TfukFhHA8U3fzY+2BzZxBS2qjpf8o/23aCavyVzEgwTAEBUHyCQ3Vaq24oTk3BJpt0gWx
        G52+6IpWy3Duy1i4voQxsQaUjjcvkvCe70u7cgiT3R10BiVHKKEGr7fvxIt4kMlPJL7MZP
        kFVYAtcHvNpNEaQHbYujI6v85mxeoS6wofY77jU7E1NN0yliOCvCgF1j+O6HhL+DhxrO01
        M99JCnO4QBOS12BSj1yTdOVrYjqjaV7hDyNsp7SZ+Gn1JnSxcbhDRbAmktYiCILKLVjNj1
        nBHJ32uOnB8OPDIDHoMoez/luRMliJUDVjK1vsZyDYGG1GxNEK/UoQFJSpGNPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634822594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9rHdmQC6XkgQSam2feozxixRKu5fHntEqaFo4ZzArYk=;
        b=l/wQjsbnTs+cwYHnZCvWokUOp9t3hSZY8qQ5mZ0aidpTyNvJkivIio7vjIxmXsfoM26umR
        Gs5O7rWyrMDe9/Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc6-rt13
Message-ID: <20211021132312.r3dxtyqbkie3mpb4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc6-rt13 patch set. 

Changes since v5.15-rc6-rt12:

  - The net series, which removes seqcount_t from Qdisc, has been updated
    to the vesion which upstream applied plus a few fixes.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rc6-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc6-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc6-rt13

The RT patch against v5.15-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc6-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc6-rt13.tar.xz

Sebastian

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 21fd95665ca02..bb10190d726d2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -38,10 +38,13 @@ enum qdisc_state_t {
 	__QDISC_STATE_DEACTIVATED,
 	__QDISC_STATE_MISSED,
 	__QDISC_STATE_DRAINING,
+};
+
+enum qdisc_state2_t {
 	/* Only for !TCQ_F_NOLOCK qdisc. Never access it directly.
 	 * Use qdisc_run_begin/end() or qdisc_is_running() instead.
 	 */
-	__QDISC_STATE_RUNNING,
+	__QDISC_STATE2_RUNNING,
 };
 
 #define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
@@ -114,6 +117,7 @@ struct Qdisc {
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
 	unsigned long		state;
+	unsigned long		state2; /* must be written under qdisc spinlock */
 	struct Qdisc            *next_sched;
 	struct sk_buff_head	skb_bad_txq;
 
@@ -154,7 +158,7 @@ static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK)
 		return spin_is_locked(&qdisc->seqlock);
-	return test_bit(__QDISC_STATE_RUNNING, &qdisc->state);
+	return test_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
 }
 
 static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
@@ -217,7 +221,7 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 */
 		return spin_trylock(&qdisc->seqlock);
 	}
-	return test_and_set_bit(__QDISC_STATE_RUNNING, &qdisc->state);
+	return !__test_and_set_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
 }
 
 static inline void qdisc_run_end(struct Qdisc *qdisc)
@@ -229,7 +233,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
 	} else {
-		clear_bit(__QDISC_STATE_RUNNING, &qdisc->state);
+		__clear_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index 5516ea0d5da0b..a10335b4ba2d0 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -154,7 +154,7 @@ void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 	u64 bytes = 0;
 	u64 packets = 0;
 
-	WARN_ON_ONCE((cpu || running) && !in_task());
+	WARN_ON_ONCE((cpu || running) && in_hardirq());
 
 	if (cpu) {
 		gnet_stats_add_basic_cpu(bstats, cpu);
@@ -171,20 +171,51 @@ void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 }
 EXPORT_SYMBOL(gnet_stats_add_basic);
 
+static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
+				  struct gnet_stats_basic_sync __percpu *cpu,
+				  struct gnet_stats_basic_sync *b, bool running)
+{
+	unsigned int start;
+
+	if (cpu) {
+		u64 t_bytes = 0, t_packets = 0;
+		int i;
+
+		for_each_possible_cpu(i) {
+			struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
+			unsigned int start;
+			u64 bytes, packets;
+
+			do {
+				start = u64_stats_fetch_begin_irq(&bcpu->syncp);
+				bytes = u64_stats_read(&bcpu->bytes);
+				packets = u64_stats_read(&bcpu->packets);
+			} while (u64_stats_fetch_retry_irq(&bcpu->syncp, start));
+
+			t_bytes += bytes;
+			t_packets += packets;
+		}
+		*ret_bytes = t_bytes;
+		*ret_packets = t_packets;
+		return;
+	}
+	do {
+		if (running)
+			start = u64_stats_fetch_begin_irq(&b->syncp);
+		*ret_bytes = u64_stats_read(&b->bytes);
+		*ret_packets = u64_stats_read(&b->packets);
+	} while (running && u64_stats_fetch_retry_irq(&b->syncp, start));
+}
+
 static int
 ___gnet_stats_copy_basic(struct gnet_dump *d,
 			 struct gnet_stats_basic_sync __percpu *cpu,
 			 struct gnet_stats_basic_sync *b,
 			 int type, bool running)
 {
-	struct gnet_stats_basic_sync bstats;
 	u64 bstats_bytes, bstats_packets;
 
-	gnet_stats_basic_sync_init(&bstats);
-	gnet_stats_add_basic(&bstats, cpu, b, running);
-
-	bstats_bytes = u64_stats_read(&bstats.bytes);
-	bstats_packets = u64_stats_read(&bstats.packets);
+	gnet_stats_read_basic(&bstats_bytes, &bstats_packets, cpu, b, running);
 
 	if (d->compat_tc_stats && type == TCA_STATS_BASIC) {
 		d->tc_stats.bytes = bstats_bytes;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 52b9b0dcf88c6..0eae9ff5edf6f 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -660,8 +660,6 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	q->nbands = nbands;
 	for (i = nstrict; i < q->nstrict; i++) {
-		INIT_LIST_HEAD(&q->classes[i].alist);
-		gnet_stats_basic_sync_init(&q->classes[i].bstats);
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
 			q->classes[i].deficit = quanta[i];
@@ -687,7 +685,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	ets_offload_change(sch);
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
-		memset(&q->classes[i], 0, sizeof(q->classes[i]));
+		q->classes[i].qdisc = NULL;
+		q->classes[i].quantum = 0;
+		q->classes[i].deficit = 0;
+		gnet_stats_basic_sync_init(&q->classes[i].bstats);
+		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
 	}
 	return 0;
 }
@@ -696,7 +698,7 @@ static int ets_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			  struct netlink_ext_ack *extack)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	int err;
+	int err, i;
 
 	if (!opt)
 		return -EINVAL;
@@ -706,6 +708,9 @@ static int ets_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	INIT_LIST_HEAD(&q->active);
+	for (i = 0; i < TCQ_ETS_MAX_BANDS; i++)
+		INIT_LIST_HEAD(&q->classes[i].alist);
+
 	return ets_qdisc_change(sch, opt, extack);
 }
 
