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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA1C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEBE60F6D
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhIEOh2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhIEOhZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DFC061757;
        Sun,  5 Sep 2021 07:36:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c17so4088871pgc.0;
        Sun, 05 Sep 2021 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiTgjWXCRRctYdc9wpYqv69fBWjIeBt2mt1XO567JxI=;
        b=Lp8H/Krb9scczsKKPD6U1HNGshnMN6xcnV+WPJP1WH9p7syj1d9bZnYCbREVxZ3DEW
         WL7KofpFwTeZgd4EnERkxy15HINul7NqqewjaeZn06wTjfJXWGijLmwugBJ8IjBVMNfM
         bhfjFGG6gr/ZrehlJHRWoi4QA2eUJhyvn5Jd7qDQDOBChGhIpbA03tl1FcUbCs4XilWZ
         UlbxsXsC9YoheyRFE/RgpvnvuWTegOKS1kw4hIm7viODXoyj2rgrSbRE9Ptj1M80b8oM
         Dsd3dCr6h4W0zt5+V6870XBlwVQ6lwPjJ7k4IFysD9dupztoYSgCwa+dnvYvxwgZcwL7
         Sq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiTgjWXCRRctYdc9wpYqv69fBWjIeBt2mt1XO567JxI=;
        b=lPVDHEqb5dkTy3zBfVy79DhdEJxNJY3G7/pVEp0IdIHhv4FhKWaf9EHPCprzEto07Y
         A+KKVN1ee/ZT2miwWeurbcoi9CZecXLHEcqjE5YdKLQMrcMeDqwPS0ZVfi5yzszoswi3
         czuLuSJcNf3h0f/n04zpeNy2nGAkgI7neqGfo43DV5ZR7VBH1Z/UlF+TNUMk02aw8Oet
         O8OcehyGmbUTXZZg9SvPiC0fq02AD5xO3ohxfPZsaTIpTxu2nxAvhLzoyZTuZitHeQNU
         ZO59kgFKPRSvYseYgzaVcKbY/hggeLvt/6KJzdbDahPG42Bo+xP/t7BQMaqxzRQart1W
         7PcQ==
X-Gm-Message-State: AOAM530ILXIi07byXja8psFNNMoGY1uGjYNaEiVEWDWoJL6Qib+vRGno
        NfWRFRRZa5L1wBDZNLe7n+WSDeCCt+XiHnoZ
X-Google-Smtp-Source: ABdhPJw/w+mWZywpHGZ6uIUK0NXVbmCMjYpjYsNf5vqnHYkq342dn4fjasTq+Fvb5l47ewYy5D5uLg==
X-Received: by 2002:aa7:8e56:0:b029:3cd:c2ec:6c1c with SMTP id d22-20020aa78e560000b02903cdc2ec6c1cmr7681973pfr.80.1630852582162;
        Sun, 05 Sep 2021 07:36:22 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 4/8] sched: introduce task block time in schedstats
Date:   Sun,  5 Sep 2021 14:35:43 +0000
Message-Id: <20210905143547.4668-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
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
index ed4293812ca9..4239a3fbe7f3 100644
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
index e08eee374176..32eb86932bcb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -534,10 +534,11 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
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
@@ -968,6 +969,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		u64 avg_atom, avg_per_cpu;
 
 		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(sum_block_runtime);
 		PN_SCHEDSTAT(wait_start);
 		PN_SCHEDSTAT(sleep_start);
 		PN_SCHEDSTAT(block_start);
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index fad781ca7791..07dde2928c79 100644
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

