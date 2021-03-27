Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7038C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9556C619A0
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhC0KOQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhC0KON (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:14:13 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC33C0613B1;
        Sat, 27 Mar 2021 03:14:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x16so4236282qvk.3;
        Sat, 27 Mar 2021 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6I9LtmJFnRkyO5caxGSa7Yzy5Msrr9a9zS2NiKpUlc=;
        b=KaLU1cNXEG5zWgdG9lvECZoG3P9fj72C5DsjUYqIcVrAoAj62n2fDRYJ109+oIpZWy
         D3MZbv6rm8ldFfgZlgqQqwWUnIXSCdWNctTqeOSMi849uMjxbLx4amd7oDy57h86ARiH
         7uzt6+2nW8soNgj+lfuBV/L4GPtuy/GMGXA+EP804QUWKYa3CvPVSMgq0hzq2it7V8cK
         9hkEfNKns4Ds/cKUS4LQCrCCuDQLJh8o3Iu0hIC6wV1PGN+0TUaKeGgBBDXTz9WOZ/Kx
         yCdmQCzptwlreifLeDzbuheKI/AIWL4L5e14kAVrl+DnlmfjtjRW+FxTLJs97yOcEY74
         LLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6I9LtmJFnRkyO5caxGSa7Yzy5Msrr9a9zS2NiKpUlc=;
        b=i7MB3Gv+cOrs5cDTU4ULmy7hDRu1Dvlxklqs+oJUUPmDynnqsgNQCRv2FxEzB2cjdD
         IqgBCA8UXJRrOgdSHYpgR/3ucd9NLSjcs8bzcDwExIIYBoimjx7BcnDuelfNwalA99Hq
         xZPanOIg3IgtSms4DvhkRrH1q7+TYbvG+ZFTtEmm8ch8ZjUAnWq8VdoT94N7FgIvY4XE
         A8OXkEmj1k0DdvA+Pn7FufFQKgcBygebLQHieG1h70r/uGbeZdMXukU0zGQ4qS5wfc9a
         yaH3mrJVnORiPvB1OP73zOy+oL8iBN3uOBn4+mOJb3gIjPUKzNI+on2/pdT/0rSEfKSo
         fzIw==
X-Gm-Message-State: AOAM5324/n6s732PaKt+vCvLSmXRBe+fpH1343evdinyaZocMUGGLHHt
        3mT+hRRU7z6Yj3SvcJ+LwOg=
X-Google-Smtp-Source: ABdhPJx0Lx215xa6OpTGXbHrMDENpmNRgcPP2/1lCTF5fH82Qv5gRCrUYB++M5HUV2bHPI44cDqysg==
X-Received: by 2002:a0c:d7d2:: with SMTP id g18mr16942833qvj.42.1616840051662;
        Sat, 27 Mar 2021 03:14:11 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.14.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:14:11 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 4/6] sched: introduce task block time in schedstats
Date:   Sat, 27 Mar 2021 18:12:51 +0800
Message-Id: <20210327101254.56872-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
References: <20210327101254.56872-1-laoar.shao@gmail.com>
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
---
 include/linux/sched.h | 2 ++
 kernel/sched/debug.c  | 6 ++++--
 kernel/sched/stats.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b687bb38897b..2b885481b8bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -428,6 +428,8 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
+	s64				sum_block_runtime;
+
 	u64				exec_max;
 	u64				slice_max;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index d1bc616936d9..0995412dd3c0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -499,10 +499,11 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
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
@@ -941,6 +942,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		u64 avg_atom, avg_per_cpu;
 
 		PN_SCHEDSTAT(stats.sum_sleep_runtime);
+		PN_SCHEDSTAT(stats.sum_block_runtime);
 		PN_SCHEDSTAT(stats.wait_start);
 		PN_SCHEDSTAT(stats.sleep_start);
 		PN_SCHEDSTAT(stats.block_start);
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

