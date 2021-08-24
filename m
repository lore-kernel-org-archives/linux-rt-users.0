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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49854C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F56C61184
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhHXLbA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhHXLa5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2FC061764;
        Tue, 24 Aug 2021 04:30:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j187so18075482pfg.4;
        Tue, 24 Aug 2021 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z/mcAy0AwiMUi0p/QTC0GnZiW2ukvf/TDSTvscZh4g=;
        b=fWGzZmB2V5fJVKJv2PVaan7zHWI+8TWC8cTiV5HibtIABww1Hlx1mO9TQRrDWfc//J
         mIdfg2K6z3SlLu3uMqFYWSpDaCOSZxj9QM3SrmcjmmAmAJgNKY+vJy+hwm2PKeBY1wuG
         NMDiVtylNkNwtnxDnL80ve950a+9lOlrdKQrJgjBSZujGqNjXNC/W7nZAtFjlx6Z7Mw9
         A8WVXAosSDWGQPm9UvOqTcHdtMibCIpcXIrM0E0T3n7k3oXAPBwld5e2aKLri+R4kANe
         vQpW2PxB+7d2cP8JhJlUzATGETU9pYm9s1/bWcMYGXMpMUxZBifcATqzxLdHG7huUmc3
         FR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z/mcAy0AwiMUi0p/QTC0GnZiW2ukvf/TDSTvscZh4g=;
        b=bPMT2raKPuGO4inuuwarDQNPZoqwSwy34/XYhQLLVpjyo5cAi+blSE3lKxGD2nK2R4
         On4gnicVhz0qzTd1tM7UzSaKTKWNgcVOraTbrc1iGu7bCo1qDW2VK8188eYXd5G4MxNv
         gmP0QmFvv2Mjp+9bJJHjaWvMlskTuT/zhPA70L7QLVLXFa8i5GgEcmJmRyc0jOZjR52f
         MBBRPDBvNgXGbN8JXhZoskrVFJSBN1Zf3+ZwlGwMWhr03cJT1KRSDnY86CBPGWoj86Ig
         0XWC5pxt/RoKc369BcHs6LKMVUB1MFJ2m1odKx7NPK2eVclwLyDUvonCQajVCuaz/M1y
         bITg==
X-Gm-Message-State: AOAM533L0xx80ysDE4ZGENKRCqv3VuQxQypQumpIbAa3sxAS9WIrp7nD
        43HPT4kzYLPfsXc2BasGWBA=
X-Google-Smtp-Source: ABdhPJx7q6DYUPXPo7wmC9La9yOcbba+MOoCx3CxVmU4jxXAwbKJcH3XxOsoTgLpqD13zSWrbjsImg==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr32730434pgq.451.1629804612995;
        Tue, 24 Aug 2021 04:30:12 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:12 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 5/7] sched: introduce task block time in schedstats
Date:   Tue, 24 Aug 2021 11:29:44 +0000
Message-Id: <20210824112946.9324-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Currently in schedstats we have sum_sleep_runtime and iowait_sum, but
there's no metric to show how long the task is in D state.  Once a task in
D state, it means the task is blocked in the kernel, for example the
task may be waiting for a mutex. The D state is more frequent than
iowait, and it is more critital than S state. So it is worth to add a
metric to measure it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 include/linux/sched.h | 2 ++
 kernel/sched/debug.c  | 6 ++++--
 kernel/sched/stats.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39c29eae1af9..7888ad8384ba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -502,6 +502,8 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
+	s64				sum_block_runtime;
+
 	u64				exec_max;
 	u64				slice_max;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 705987aed658..5c6bc3f373f0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -560,10 +560,11 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
-	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
 		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -995,6 +996,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		u64 avg_atom, avg_per_cpu;
 
 		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(sum_block_runtime);
 		PN_SCHEDSTAT(wait_start);
 		PN_SCHEDSTAT(sleep_start);
 		PN_SCHEDSTAT(block_start);
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index b2542f4d3192..21fae41c06f5 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -82,6 +82,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
 
 		__schedstat_set(stats->block_start, 0);
 		__schedstat_add(stats->sum_sleep_runtime, delta);
+		__schedstat_add(stats->sum_block_runtime, delta);
 
 		if (p) {
 			if (p->in_iowait) {
-- 
2.18.2

