Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B55C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD74613A7
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhHXLbJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbhHXLay (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5BC0613CF;
        Tue, 24 Aug 2021 04:30:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so19476640pgl.10;
        Tue, 24 Aug 2021 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zm5J1NbSAv3TdiryGrbNnK0wLWnfsAGlTXyiy0Xe10=;
        b=a2PIZ+La9zU57Y18HTm6bWATO20DaJ6YSqmOX+Y7Z6m6Gtef65SuzOrEd3i9EbJaRo
         FXBn0yCFYqrg4PkA2HQZpyn6yMtpfMv/ejX67KRnb/3PYgHp9SUQaI+i3iQmdW+4gKrp
         uhJJI37FdgluSOHX91OmbaxBxfGt/uGxNXA0pOTKW8ajIs3pogYVn4E+zqr+G3orWXCK
         U1rfw85WdxKJXGHQ9DryjE1Elkvc6q7LgLFHHtB9x/g8nqFFEYLqTQ65kTxRryhsTqL5
         RkL1+lGqWVA2yuXVm+4A6V5rz8TStFK5mRDjhi4viByTogB/KsxCUDwPEsGOTNKGsqE1
         ShFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zm5J1NbSAv3TdiryGrbNnK0wLWnfsAGlTXyiy0Xe10=;
        b=ZCGf05+DFJBKXLHo/M774OLGHEgfksvlERoYsmE78J1g2JrSQaWcWUS61PkB7kmSCG
         CUaZ7j+BXmH/w6HC9AxZn4B6oLdSySueUKZGTUSlBESO+foNasdlBtYE/tK8REJqWfGd
         I2BFKqpZ4NYpdEX4gUqmCgNAKEu4NVbH6CiXQMW2K6W0aC469H7j4/sJ+YNhEPC5uA4I
         S+UX/Jygzki516xHRCWP9GjsQMaoWos1jvN67KDghV9IJWAMl3fxiXOJELMK0qy1s/JW
         6PW7Wy9FwIQMzP815CPfW2uI2QL7QjFL0OV7vQ8L91dXXnCdJgCCTT/coSGw0QafwXIW
         UL3Q==
X-Gm-Message-State: AOAM532zdElTdUhswdLTEJQ2HMThWPdQRhyB/1BYLjl3GIT1IVU2vRzP
        WHKKr4Hxyfc2/amRJVLy/Vg=
X-Google-Smtp-Source: ABdhPJzPJJ+t84WA7ZilqmCYK56gWc6BPMwkORW3LDFBA4mrU0+Plk7hI2aUzOOc2Rm0FfirEBQurQ==
X-Received: by 2002:aa7:8e4f:0:b0:3ee:27d5:28bc with SMTP id d15-20020aa78e4f000000b003ee27d528bcmr2194660pfr.24.1629804609612;
        Tue, 24 Aug 2021 04:30:09 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:09 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 4/7] sched: make the output of schedstats independent of fair sched class
Date:   Tue, 24 Aug 2021 11:29:43 +0000
Message-Id: <20210824112946.9324-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The per cpu stats can be show with /proc/sched_debug, which includes the
per cpu schedstats of each task group. Currently these per cpu
schedstats only show for the fair sched class. If we want to support
other sched classes, we have to make these output independent of fair
sched class.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/debug.c | 70 +++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4cfee2aa1a2d..705987aed658 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -442,11 +442,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	struct sched_entity *se = tg->se[cpu];
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
-		"se->statistics."#F, (long long)schedstat_val(tg->stats[cpu]->F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
-		"se->statistics."#F, SPLIT_NS((long long)schedstat_val(tg->stats[cpu]->F)))
 
 	if (!se)
 		return;
@@ -454,20 +450,6 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	PN(se->exec_start);
 	PN(se->vruntime);
 	PN(se->sum_exec_runtime);
-
-	if (schedstat_enabled()) {
-		PN_SCHEDSTAT(wait_start);
-		PN_SCHEDSTAT(sleep_start);
-		PN_SCHEDSTAT(block_start);
-		PN_SCHEDSTAT(sleep_max);
-		PN_SCHEDSTAT(block_max);
-		PN_SCHEDSTAT(exec_max);
-		PN_SCHEDSTAT(slice_max);
-		PN_SCHEDSTAT(wait_max);
-		PN_SCHEDSTAT(wait_sum);
-		P_SCHEDSTAT(wait_count);
-	}
-
 	P(se->load.weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
@@ -475,13 +457,60 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	P(se->avg.runnable_avg);
 #endif
 
-#undef PN_SCHEDSTAT
 #undef PN
-#undef P_SCHEDSTAT
 #undef P
 }
 #endif
 
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+struct tg_schedstats {
+	struct seq_file *m;
+	int cpu;
+};
+
+static int tg_show_schedstats(struct task_group *tg, void *data)
+{
+	struct tg_schedstats *p = data;
+	struct seq_file *m = p->m;
+	int cpu = p->cpu;
+
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
+		"se->statistics."#F, (long long)schedstat_val(tg->stats[cpu]->F))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
+		"se->statistics."#F, SPLIT_NS((long long)schedstat_val(tg->stats[cpu]->F)))
+
+	PN_SCHEDSTAT(wait_start);
+	PN_SCHEDSTAT(sleep_start);
+	PN_SCHEDSTAT(block_start);
+	PN_SCHEDSTAT(sleep_max);
+	PN_SCHEDSTAT(block_max);
+	PN_SCHEDSTAT(exec_max);
+	PN_SCHEDSTAT(slice_max);
+	PN_SCHEDSTAT(wait_max);
+	PN_SCHEDSTAT(wait_sum);
+	P_SCHEDSTAT(wait_count);
+
+#undef P_SCHEDSTAT
+#undef PN_SCHEDSTAT
+
+return 0;
+}
+
+static void print_task_group_stats(struct seq_file *m, int cpu)
+{
+	struct tg_schedstats data = {
+		.m = m,
+		.cpu = cpu,
+	};
+
+	if (!schedstat_enabled())
+		return;
+
+	walk_tg_tree(tg_show_schedstats, tg_nop, &data);
+}
+#endif
+
+
 #ifdef CONFIG_CGROUP_SCHED
 static DEFINE_SPINLOCK(sched_debug_lock);
 static char group_path[PATH_MAX];
@@ -756,6 +785,7 @@ do {									\
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
+	print_task_group_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
 	SEQ_printf(m, "\n");
-- 
2.18.2

