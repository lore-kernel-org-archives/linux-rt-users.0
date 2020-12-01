Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE2C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370FA20770
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHxmXJeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgLAL4Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbgLAL4Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:24 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9085C0613D3;
        Tue,  1 Dec 2020 03:55:43 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n12so1390210otk.0;
        Tue, 01 Dec 2020 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2A2gQAekcu/stjcOTnmS6PBV/8nj3HvrMWHRk++src=;
        b=JHxmXJeIn2M3ucjCy4xFIv2ZkLnB7qLYacBpZiEyVBVkJjaF1sPQMiiRhUmR02ZsQI
         BuGAxiuhRfDKrf+p3dGeQ9f6F14unv8XVHk+cc2iXV8FydoVTJ4UVVa4xs7KSAcA+zFf
         5vUEU3R8klhN5aHaZx3sRXQ1HkY40McNJgHVMjSSdwZfwfmFp8H9fA6X7kWXrysnEh+Y
         gV6gFUnBfXRTsRUZ7YfZbo31oepCYSjUdZmKKmGd3fPpPOS6t0dVEb5Nh9wxwImAN380
         VybCAW4ugZFMcX2hU7KcERt4XQiJFKCVFiEEEiupb/eHtCitOkmifzV+7Q3Wen47ss49
         A0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2A2gQAekcu/stjcOTnmS6PBV/8nj3HvrMWHRk++src=;
        b=ktYx6Fk1qS8FINsFeQWpVFE98dV6NovrfQROsq0XKD+a01X/wMe74sGvc9rDzBTspV
         K1OtmWBCTm3bpnLB9B8G945TAOE175L+JekPQ2T6KjeEZNBn/PCGw5TZ/9L2i4xSd6Am
         s7AVBZDUyuqoHvukv1Y35Q/Ddna5tsz6m9vgLD7fQfZtDtqhX5YHQ7fsBmQ1K8Mr36im
         J1JR0qCK9ZiEHux3bnMDrlKd30HCpZyP9PDwS1mmoB4cuSKZjFZTYhDEo4+g9wPdjFYu
         lDquzCeutHpEV74198ITw4gSyGj8DJRsnc16zM7CKxrwwoCBmij9wDPVX5CAdSj4LaO4
         CFAQ==
X-Gm-Message-State: AOAM530vLLky+RsTHC27v3Zy3LfWCmok4+mfGCiAQcNZl/9J9Jj9U6kA
        bwtbXaMsHqugqDfujbGVFKU=
X-Google-Smtp-Source: ABdhPJxzr8YHVsfMWFGF/v++FWGh18bkSvu4cmXmuh3c6YBQUx3mQ1+pAjWzCFXMachR+7JBJshpHw==
X-Received: by 2002:a05:6830:441:: with SMTP id d1mr1470302otc.337.1606823743303;
        Tue, 01 Dec 2020 03:55:43 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id o6sm342592oon.7.2020.12.01.03.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:55:42 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 4/6] sched: make schedstats helpers independent of fair sched class
Date:   Tue,  1 Dec 2020 19:54:14 +0800
Message-Id: <20201201115416.26515-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201201115416.26515-1-laoar.shao@gmail.com>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The original prototype of the schedstats helpers are

update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)

The cfs_rq in these helpers is used to get the rq_clock, and the se is
used to get the struct sched_statistics and the struct task_struct. In
order to make these helpers available by all sched classes, we can pass
the rq, sched_statistics and task_struct directly.

Then the new helpers are

update_stats_wait_*(struct rq *rq, struct task_struct *p,
		    struct sched_statistics *stats)

which are independent of fair sched class.

To avoid vmlinux growing too large or introducing ovehead when
!schedstat_enabled(), some new helpers after schedstat_enabled() are also
introduced, Suggested by Mel. These helpers are in sched/stats.c,

__update_stats_wait_*(struct rq *rq, struct task_struct *p,
		      struct sched_statistics *stats)

Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 140 +++++++------------------------------------
 kernel/sched/stats.c | 104 ++++++++++++++++++++++++++++++++
 kernel/sched/stats.h |  32 ++++++++++
 3 files changed, 157 insertions(+), 119 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 14d8df308d44..b869a83fac29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -917,69 +917,44 @@ static void update_curr_fair(struct rq *rq)
 }
 
 static inline void
-update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats = NULL;
-	u64 wait_start, prev_wait_start;
+	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
-	__schedstat_from_sched_entity(se, &stats);
-
-	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(stats->wait_start);
+	if (entity_is_task(se))
+		p = task_of(se);
 
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -= prev_wait_start;
+	__schedstat_from_sched_entity(se, &stats);
 
-	__schedstat_set(stats->wait_start, wait_start);
+	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
 }
 
 static inline void
-update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats = NULL;
 	struct task_struct *p = NULL;
-	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
 
-	__schedstat_from_sched_entity(se, &stats);
-
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
-	if (entity_is_task(se)) {
+	if (entity_is_task(se))
 		p = task_of(se);
 
-		if (task_on_rq_migrating(p)) {
-			/*
-			 * Preserve migrating task's wait time so wait_start
-			 * time stamp can be adjusted to accumulate wait time
-			 * prior to migration.
-			 */
-			__schedstat_set(stats->wait_start, delta);
-
-			return;
-		}
-
-		trace_sched_stat_wait(p, delta);
-	}
+	__schedstat_from_sched_entity(se, &stats);
 
-	__schedstat_set(stats->wait_max,
-			max(schedstat_val(stats->wait_max), delta));
-	__schedstat_inc(stats->wait_count);
-	__schedstat_add(stats->wait_sum, delta);
-	__schedstat_set(stats->wait_start, 0);
+	__update_stats_wait_end(rq_of(cfs_rq), p, stats);
 }
 
 static inline void
-update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_enqueue_sleeper_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats = NULL;
 	struct task_struct *p = NULL;
-	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
@@ -989,67 +964,14 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	__schedstat_from_sched_entity(se, &stats);
 
-	sleep_start = schedstat_val(stats->sleep_start);
-	block_start = schedstat_val(stats->block_start);
-
-	if (sleep_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - sleep_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(stats->sleep_max)))
-			__schedstat_set(stats->sleep_max, delta);
-
-		__schedstat_set(stats->sleep_start, 0);
-		__schedstat_add(stats->sum_sleep_runtime, delta);
-
-		if (p) {
-			account_scheduler_latency(p, delta >> 10, 1);
-			trace_sched_stat_sleep(p, delta);
-		}
-	}
-	if (block_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - block_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(stats->block_max)))
-			__schedstat_set(stats->block_max, delta);
-
-		__schedstat_set(stats->block_start, 0);
-		__schedstat_add(stats->sum_sleep_runtime, delta);
-
-		if (p) {
-			if (p->in_iowait) {
-				__schedstat_add(stats->iowait_sum, delta);
-				__schedstat_inc(stats->iowait_count);
-				trace_sched_stat_iowait(p, delta);
-			}
-
-			trace_sched_stat_blocked(p, delta);
-
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on == SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(p),
-						delta >> 20);
-			}
-			account_scheduler_latency(p, delta >> 10, 0);
-		}
-	}
+	__update_stats_enqueue_sleeper(rq_of(cfs_rq), p, stats);
 }
 
 /*
  * Task is being enqueued - update stats:
  */
 static inline void
-update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	if (!schedstat_enabled())
 		return;
@@ -1059,14 +981,14 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * a dequeue/enqueue event is a NOP)
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_start(cfs_rq, se);
+		update_stats_wait_start_fair(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
-		update_stats_enqueue_sleeper(cfs_rq, se);
+		update_stats_enqueue_sleeper_fair(cfs_rq, se);
 }
 
 static inline void
-update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 
 	if (!schedstat_enabled())
@@ -1077,7 +999,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4186,26 +4108,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 
-static inline void check_schedstat_required(void)
-{
-#ifdef CONFIG_SCHEDSTATS
-	if (schedstat_enabled())
-		return;
-
-	/* Force schedstat enabled if a dependent tracepoint is active */
-	if (trace_sched_stat_wait_enabled()    ||
-			trace_sched_stat_sleep_enabled()   ||
-			trace_sched_stat_iowait_enabled()  ||
-			trace_sched_stat_blocked_enabled() ||
-			trace_sched_stat_runtime_enabled())  {
-		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
-			     "stat_blocked and stat_runtime require the "
-			     "kernel parameter schedstats=enable or "
-			     "kernel.sched_schedstats=1\n");
-	}
-#endif
-}
-
 static inline bool cfs_bandwidth_used(void);
 
 /*
@@ -4279,7 +4181,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		place_entity(cfs_rq, se, 0);
 
 	check_schedstat_required();
-	update_stats_enqueue(cfs_rq, se, flags);
+	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
@@ -4363,7 +4265,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, UPDATE_TG);
 	se_update_runnable(se);
 
-	update_stats_dequeue(cfs_rq, se, flags);
+	update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	clear_buddies(cfs_rq, se);
 
@@ -4448,7 +4350,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4550,7 +4452,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 844bd9dbfbf0..1a9614c69669 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -5,6 +5,110 @@
 #include "sched.h"
 #include "stats.h"
 
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats)
+{
+	u64 wait_start, prev_wait_start;
+
+	wait_start = rq_clock(rq);
+	prev_wait_start = schedstat_val(stats->wait_start);
+
+	if (p && likely(wait_start > prev_wait_start))
+		wait_start -= prev_wait_start;
+
+	__schedstat_set(stats->wait_start, wait_start);
+}
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats)
+{
+	u64 delta;
+
+	delta = rq_clock(rq) - schedstat_val(stats->wait_start);
+
+	if (p) {
+		if (task_on_rq_migrating(p)) {
+			/*
+			 * Preserve migrating task's wait time so wait_start
+			 * time stamp can be adjusted to accumulate wait time
+			 * prior to migration.
+			 */
+			__schedstat_set(stats->wait_start, delta);
+
+			return;
+		}
+
+		trace_sched_stat_wait(p, delta);
+	}
+
+	__schedstat_set(stats->wait_max,
+			max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
+}
+
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats)
+{
+	u64 sleep_start, block_start;
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
+
+	if (sleep_start) {
+		u64 delta = rq_clock(rq) - sleep_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
+
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+
+		if (p) {
+			account_scheduler_latency(p, delta >> 10, 1);
+			trace_sched_stat_sleep(p, delta);
+		}
+	}
+	if (block_start) {
+		u64 delta = rq_clock(rq) - block_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
+
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+
+		if (p) {
+			if (p->in_iowait) {
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
+				trace_sched_stat_iowait(p, delta);
+			}
+
+			trace_sched_stat_blocked(p, delta);
+
+			/*
+			 * Blocking time is in units of nanosecs, so shift by
+			 * 20 to get a milliseconds-range estimation of the
+			 * amount of time that the task spent sleeping:
+			 */
+			if (unlikely(prof_on == SLEEP_PROFILING)) {
+				profile_hits(SLEEP_PROFILING,
+						(void *)get_wchan(p),
+						delta >> 20);
+			}
+			account_scheduler_latency(p, delta >> 10, 0);
+		}
+	}
+}
+
 /*
  * Current schedstat API version.
  *
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 87242968712e..b8e3d4ee21e1 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -78,6 +78,33 @@ static inline int alloc_tg_schedstats(struct task_group *tg)
 	return 1;
 }
 
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats);
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats);
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats);
+
+static inline void
+check_schedstat_required(void)
+{
+	if (schedstat_enabled())
+		return;
+
+	/* Force schedstat enabled if a dependent tracepoint is active */
+	if (trace_sched_stat_wait_enabled()    ||
+		trace_sched_stat_sleep_enabled()   ||
+		trace_sched_stat_iowait_enabled()  ||
+		trace_sched_stat_blocked_enabled() ||
+		trace_sched_stat_runtime_enabled())  {
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
+				     "stat_blocked and stat_runtime require the "
+				     "kernel parameter schedstats=enable or "
+				     "kernel.sched_schedstats=1\n");
+	}
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
@@ -101,6 +128,11 @@ static inline int alloc_tg_schedstats(struct task_group *tg)
 	return 1;
 }
 
+# define __update_stats_wait_start(rq, p, stats)	do { } while (0)
+# define __update_stats_wait_end(rq, p, stats)		do { } while (0)
+# define __update_stats_enqueue_sleeper(rq, p, stats)	do { } while (0)
+# define check_schedstat_required()			do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_PSI
-- 
2.18.4

