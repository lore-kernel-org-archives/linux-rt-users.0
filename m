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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F0FC63798
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B32222C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adyRdwiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgK0Qce (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbgK0Qcd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 11:32:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F46C0613D1;
        Fri, 27 Nov 2020 08:32:33 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w202so5001603pff.10;
        Fri, 27 Nov 2020 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X2A2gQAekcu/stjcOTnmS6PBV/8nj3HvrMWHRk++src=;
        b=adyRdwiG7CCI9ZjI7CDS4xvKCyd7zkLkF7De3v72/OS5Xbmp27bGBhx2t+EUjcU9ri
         cipJL8Xffnb8Wl6At6uTfwXL0c88lmWOol5VrgC90hXeVvmn7lJgZWNJkY/792yKG43l
         szbPzvrqBpqpANZbelW1b0WCLU61ls0vu9elnV10a2Ik0446K9sTez/RSMvNbanazw/D
         dss4DS9tb41CjZM2gkyVURzP4aC9jOUZ7s+6kCkuO1M/lMc8PEv3ULVw42Wz5bWAhJpJ
         /ksPFTxW9TzRhc5JAutHuidkWTuIn8+gp+GWzJgcykX1ZHuUcoWNCtAXTxRYPBWQbGe9
         Mzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X2A2gQAekcu/stjcOTnmS6PBV/8nj3HvrMWHRk++src=;
        b=hY+PjvuRrD2tjrrmWgEBgh/cywvvwsMR/HIZyuKuKM5ADDG0KJ5m1uo3sY61m1DPTf
         bkL9fWazaBaGWceFxd2w/KU+ZsXrYRwMajA1Dq9dYX4BglTRZbtElwW1+felfPPav9r+
         nAEeRe3bMVq/hqwLj+NYLG4BWuRUUqUcNKFLA/bzKmMOoFXmQcGr45fMRrheASAWDkfv
         FZ603oZX2CCI9HtCBeft9kalyfD4IgpxTtgGKCwvexn7AJBfCaQx14Pkd6SJgj9pTkUk
         o30WW0G5jRXzG/ttwxV6gthU7JXKdmE1trjsefhiKndYfqf6lWAduY7axUL1/R0gPNN2
         LZyg==
X-Gm-Message-State: AOAM533kC1PNQFNSO7d+Z2KLDElr7qPjGP08z3+NjQOfIfWXxS3xRhoC
        KdujZ3HIbkqlRjfliUSq7vM=
X-Google-Smtp-Source: ABdhPJz7eKwu1VENdEI2QXkPwUh1U/3b8g+bpkz3UhNEWX2Uw8W8zjoLpafI8Pq5IhvhdXKUwncDvw==
X-Received: by 2002:a65:688a:: with SMTP id e10mr7208523pgt.347.1606494753341;
        Fri, 27 Nov 2020 08:32:33 -0800 (PST)
Received: from localhost.localdomain ([115.192.120.179])
        by smtp.gmail.com with ESMTPSA id r4sm8132193pgs.54.2020.11.27.08.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:32:32 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 4/5] sched: make schedstats helpers independent of fair sched class
Date:   Sat, 28 Nov 2020 00:32:18 +0800
Message-Id: <20201127163218.21228-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

