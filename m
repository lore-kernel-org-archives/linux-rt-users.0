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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E0C433FE
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD9560E8B
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhIEOht (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhIEOhk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF3C0613CF;
        Sun,  5 Sep 2021 07:36:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so4063018pgk.2;
        Sun, 05 Sep 2021 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsvKcG3Ajg5DdCUJLouM7fhm4o6qAdupWRlaV5uJglw=;
        b=jMlpgPpJ2iIQi0uadeaXBS23IcVwqvSLB7aaRTzMny1ROAGHfrJTlMwP8PUvVT5Z6v
         Gxr+BhLfG0THJKYKddl8HjP2q6j4siKLen6hf8NZBPsS0MP3W9F2lKvmlWq/GVQpFSSz
         IkwiSZxFVhWgkVOm91XM+xMKnFXzTVNH/b5IoMvECBUgxMNL3WcQMqUzlh8eEvk2ynRg
         EbVWSfZzMWcx9O0PmcCfvpvlxj8IHuPWQ5xw6LSlSSHPxT++VzvvkdIhWDwpUVi8Vgja
         UIJbzpnzentSzKeCJuqMgGWOa5LpED0y/RJtsv+zqFXss62PagHJocTElJ2IJOWRQ3yI
         ijTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsvKcG3Ajg5DdCUJLouM7fhm4o6qAdupWRlaV5uJglw=;
        b=EnaiuRoZnFPiZUiSN/DqtNJ6sFv3aUlv/JkJtDlpikpvKsWC01d87+AO3YxZqw4sjQ
         oA+GbL8ZcdoQMzk5RKDXtufLvbqhYhFpzMZNxCLRq5zH4QgZfWNHX8oeLWmP8qBpAaEq
         YvHkzPB3Br3Re7fa7YPTYJ/GDo1rADHAtfoQ7qLozIsBkeLSAuPAP4Xz5zwUo1iGCecG
         n2yz55SqaRE44/HYd3jaMRtUzFsclXD4/hnmZ1wz+h/4SEWUUNyqMZ3kivpC75Jjo/2K
         3YzyoP+O0tk92u1TNtbSQ5hdATiuSOpstyMgcm3PankuHLonJi3JHBzM5PstMGY63ee1
         jeng==
X-Gm-Message-State: AOAM532keWN94LPd8C+efQW7ffLgt0rVlwHrJ5Jekk58lTxIV8MM6L5h
        /XXOGXHzDy3NX5vi9E2Mvkw=
X-Google-Smtp-Source: ABdhPJz6NfVjVEmoKuCRQUw6AukcyG2nwZ4oILfk3/a5uBwppfrkYKyWJStVEEzGTxEvgzBVGqVEwg==
X-Received: by 2002:a63:2243:: with SMTP id t3mr7747619pgm.114.1630852597499;
        Sun, 05 Sep 2021 07:36:37 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:37 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 8/8] sched, dl: support schedstats for deadline sched class
Date:   Sun,  5 Sep 2021 14:35:47 +0000
Message-Id: <20210905143547.4668-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After we make the struct sched_statistics and the helpers of it
independent of fair sched class, we can easily use the schedstats
facility for deadline sched class.

The schedstat usage in DL sched class is similar with fair sched class,
for example,
                    fair                        deadline
    enqueue         update_stats_enqueue_fair   update_stats_enqueue_dl
    dequeue         update_stats_dequeue_fair   update_stats_dequeue_dl
    put_prev_task   update_stats_wait_start     update_stats_wait_start_dl
    set_next_task   update_stats_wait_end       update_stats_wait_end_dl

The user can get the schedstats information in the same way in fair sched
class. For example,
           fair                            deadline
           /proc/[pid]/sched               /proc/[pid]/sched

The output of a deadline task's schedstats as follows,

$ cat /proc/69662/sched
...
se.sum_exec_runtime                          :          3067.696449
se.nr_migrations                             :                    0
sum_sleep_runtime                            :        720144.029661
sum_block_runtime                            :             0.547853
wait_start                                   :             0.000000
sleep_start                                  :      14131540.828955
block_start                                  :             0.000000
sleep_max                                    :          2999.974045
block_max                                    :             0.283637
exec_max                                     :             1.000269
slice_max                                    :             0.000000
wait_max                                     :             0.002217
wait_sum                                     :             0.762179
wait_count                                   :                  733
iowait_sum                                   :             0.547853
iowait_count                                 :                    3
nr_migrations_cold                           :                    0
nr_failed_migrations_affine                  :                    0
nr_failed_migrations_running                 :                    0
nr_failed_migrations_hot                     :                    0
nr_forced_migrations                         :                    0
nr_wakeups                                   :                  246
nr_wakeups_sync                              :                    2
nr_wakeups_migrate                           :                    0
nr_wakeups_local                             :                  244
nr_wakeups_remote                            :                    2
nr_wakeups_affine                            :                    0
nr_wakeups_affine_attempts                   :                    0
nr_wakeups_passive                           :                    0
nr_wakeups_idle                              :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace deadlline tasks as well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/deadline.c | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 73fb33e1868f..d2c072b0ef01 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1474,6 +1474,82 @@ static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
+static inline struct sched_statistics *
+__schedstats_from_dl_se(struct sched_dl_entity *dl_se)
+{
+	return &dl_task_of(dl_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_enqueue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_dl(dl_rq, dl_se);
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	struct task_struct *p = dl_task_of(dl_se);
+
+	if (!schedstat_enabled())
+		return;
+
+	if ((flags & DEQUEUE_SLEEP)) {
+		unsigned int state;
+
+		state = READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+	}
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
@@ -1504,6 +1580,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	BUG_ON(on_dl_rq(dl_se));
 
+	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1600,6 +1678,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
+	check_schedstat_required();
+	update_stats_wait_start_dl(dl_rq_of_se(&p->dl), &p->dl);
+
 	enqueue_dl_entity(&p->dl, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1608,6 +1689,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
+	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
 	dequeue_dl_entity(&p->dl);
 	dequeue_pushable_dl_task(rq, p);
 }
@@ -1827,7 +1909,12 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_dl_entity *dl_se = &p->dl;
+	struct dl_rq *dl_rq = &rq->dl;
+
 	p->se.exec_start = rq_clock_task(rq);
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_end_dl(dl_rq, dl_se);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
@@ -1884,6 +1971,12 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
+	struct sched_dl_entity *dl_se = &p->dl;
+	struct dl_rq *dl_rq = &rq->dl;
+
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_start_dl(dl_rq, dl_se);
+
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
-- 
2.18.2

