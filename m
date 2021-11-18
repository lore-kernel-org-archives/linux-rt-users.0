Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF43C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEE361A58
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 15:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhKRPLX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:11:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhKRPLW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Nov 2021 10:11:22 -0500
Date:   Thu, 18 Nov 2021 16:08:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637248101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7oCS5/LWeYjZJXu87vNtdEWguj2/WRSfIFf6f9r11ls=;
        b=Nn1VMC3KaG1Q+ssNoNiHwLVb7kopMd4SqsWWx+LLTT8ttg2GUeyqa86VmawCcJ8vZ3DMz+
        LzYaBsBrz6Pvzwq2fEuDeDNzl2znUk/r3+zet8aIRDYmLCTA8wwNMJ65vpDz/jJSfpfiz8
        jwPATle1O9vWmwPhOuSyxCaD/tyzCp2i9Lui5caooOEW6LM5lk049vbmJKwvUdcbmmx9he
        X0WipT5Jz9mUEK4JnS6UuvksLA7xrMpQHZuqMZh90XRCQVp4EpqhjOeywfRA6QUrFB+ay5
        VLcNknvsSNOyYCflzfKQjhM/eayvmZMRbeBA/4MYXVoM7M2DONHwCsBElKyudA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637248101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7oCS5/LWeYjZJXu87vNtdEWguj2/WRSfIFf6f9r11ls=;
        b=XvfZRAFgSlZTQ1ZCO4c/6dbxiZZYqDk8FxgMBtIWEOYZ6lwWGajgkrj20RXJRxh11s8wA7
        xhC4lzx+fFcZlfCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15.2-rt20
Message-ID: <20211118150820.j45sben45nthrs4t@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15.2-rt20 patch set. 

Changes since v5.15.2-rt19:

  - A patch from upstream to avoid a "larg stack frame" warning.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15.2-rt19 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.2-rt19-rt20.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15.2-rt20

The RT patch against v5.15.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15.2-rt20.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15.2-rt20.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 483ad771f201a..e095ab8197147 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt19
+-rt20
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 72de08ef8335e..1073c76d05c45 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -56,6 +56,7 @@ struct gred_sched {
 	u32 		DPs;
 	u32 		def;
 	struct red_vars wred_set;
+	struct tc_gred_qopt_offload *opt;
 };
 
 static inline int gred_wred_mode(struct gred_sched *table)
@@ -311,42 +312,43 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 {
 	struct gred_sched *table = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct tc_gred_qopt_offload opt = {
-		.command	= command,
-		.handle		= sch->handle,
-		.parent		= sch->parent,
-	};
+	struct tc_gred_qopt_offload *opt = table->opt;
 
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
+	memset(opt, 0, sizeof(*opt));
+	opt->command = command;
+	opt->handle = sch->handle;
+	opt->parent = sch->parent;
+
 	if (command == TC_GRED_REPLACE) {
 		unsigned int i;
 
-		opt.set.grio_on = gred_rio_mode(table);
-		opt.set.wred_on = gred_wred_mode(table);
-		opt.set.dp_cnt = table->DPs;
-		opt.set.dp_def = table->def;
+		opt->set.grio_on = gred_rio_mode(table);
+		opt->set.wred_on = gred_wred_mode(table);
+		opt->set.dp_cnt = table->DPs;
+		opt->set.dp_def = table->def;
 
 		for (i = 0; i < table->DPs; i++) {
 			struct gred_sched_data *q = table->tab[i];
 
 			if (!q)
 				continue;
-			opt.set.tab[i].present = true;
-			opt.set.tab[i].limit = q->limit;
-			opt.set.tab[i].prio = q->prio;
-			opt.set.tab[i].min = q->parms.qth_min >> q->parms.Wlog;
-			opt.set.tab[i].max = q->parms.qth_max >> q->parms.Wlog;
-			opt.set.tab[i].is_ecn = gred_use_ecn(q);
-			opt.set.tab[i].is_harddrop = gred_use_harddrop(q);
-			opt.set.tab[i].probability = q->parms.max_P;
-			opt.set.tab[i].backlog = &q->backlog;
+			opt->set.tab[i].present = true;
+			opt->set.tab[i].limit = q->limit;
+			opt->set.tab[i].prio = q->prio;
+			opt->set.tab[i].min = q->parms.qth_min >> q->parms.Wlog;
+			opt->set.tab[i].max = q->parms.qth_max >> q->parms.Wlog;
+			opt->set.tab[i].is_ecn = gred_use_ecn(q);
+			opt->set.tab[i].is_harddrop = gred_use_harddrop(q);
+			opt->set.tab[i].probability = q->parms.max_P;
+			opt->set.tab[i].backlog = &q->backlog;
 		}
-		opt.set.qstats = &sch->qstats;
+		opt->set.qstats = &sch->qstats;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_GRED, &opt);
+	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
 }
 
 static int gred_offload_dump_stats(struct Qdisc *sch)
@@ -731,6 +733,7 @@ static int gred_change(struct Qdisc *sch, struct nlattr *opt,
 static int gred_init(struct Qdisc *sch, struct nlattr *opt,
 		     struct netlink_ext_ack *extack)
 {
+	struct gred_sched *table = qdisc_priv(sch);
 	struct nlattr *tb[TCA_GRED_MAX + 1];
 	int err;
 
@@ -754,6 +757,12 @@ static int gred_init(struct Qdisc *sch, struct nlattr *opt,
 		sch->limit = qdisc_dev(sch)->tx_queue_len
 		             * psched_mtu(qdisc_dev(sch));
 
+	if (qdisc_dev(sch)->netdev_ops->ndo_setup_tc) {
+		table->opt = kzalloc(sizeof(*table->opt), GFP_KERNEL);
+		if (!table->opt)
+			return -ENOMEM;
+	}
+
 	return gred_change_table_def(sch, tb[TCA_GRED_DPS], extack);
 }
 
@@ -910,6 +919,7 @@ static void gred_destroy(struct Qdisc *sch)
 			gred_destroy_vq(table->tab[i]);
 	}
 	gred_offload(sch, TC_GRED_DESTROY);
+	kfree(table->opt);
 }
 
 static struct Qdisc_ops gred_qdisc_ops __read_mostly = {
