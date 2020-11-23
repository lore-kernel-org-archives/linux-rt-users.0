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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF05C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05CE206D9
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMmMAv6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgKWM7M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgKWM7F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 07:59:05 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC66C0613CF;
        Mon, 23 Nov 2020 04:59:05 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id m16so9049605vsl.8;
        Mon, 23 Nov 2020 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDqxy4X5OFQBUDeCEVBKG5rePCFX8nWXr8Neh5nJ1RU=;
        b=gMmMAv6jaXZFd5o1se00f05ZJ5GUehedj3/M38ZiqGkCylzHX7ZnDRL4xAfmXuz3oA
         ZabWA5aFUy3XlatKQUxGY94scKVuSJe08bVi8HDG42ln3dyRQq7t+R03xTdko4zfuhS4
         uTxpv8zak0BCBEY+ishjaE8Olcz2KvtFiRCC43Q2L1/4RVKIzfLMWcTG+Rtm3GY4nMVF
         bqLUUREvK/UhMlIaDFMVAZXa4hu+w7bR60icB+xeeU2GKbJ5aWViFRrW/Q+zo7+9FFix
         3ijc/Vr7rjUKiHFUSQ8ZKl0wsrJS0GliBgUWmkz8iw4Qlk7ThEySD0W5zwLhbDZOq8Tu
         4w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDqxy4X5OFQBUDeCEVBKG5rePCFX8nWXr8Neh5nJ1RU=;
        b=oXHh0+6xMPu2atJeuMwCpIbpw0gMX+ZA9zd4SxpVjpdw0G4hVzwO7IYIm/9nqtl9ZD
         sRLQXFC7NWCsyfjHe4R7Jp+L5jTakHexcNusGjIDh70jB24iIr3hy8KIhXglTi3Z0Q0a
         VLY+hIEqr69v7HzDYnvjmw8bGFVVJzw1KLy5p8YZF3XiwqR13zBpJpDrcJrENXpegJUP
         /O0QgjVIDwPinNQ4RExJZtoMxcCNypVmS30ETErd+EdG+C0+dCjc3z4GOHQl0MzXbgHW
         +9QSGxbaFS+eQNAbBJ+fS1/otyqEguT23yb1+EuIbZCVo/S/gSbWwwfYdd51xfX7q8fO
         Xulg==
X-Gm-Message-State: AOAM530qm61aJg1BCgMSaZAG1C4BMsgDee9T9whxO+eUr96AVSUc/WgE
        YZB75N12WiqsH6DlUWxwYyE=
X-Google-Smtp-Source: ABdhPJwlkKilqFmlE0l/4zfJV3n5VUETRvimMqIB9xSvtLaafp05gqire01GGTUEqKae/jH9921zGw==
X-Received: by 2002:a67:ad16:: with SMTP id t22mr4212354vsl.43.1606136344263;
        Mon, 23 Nov 2020 04:59:04 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:59:03 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 3/5] sched: make schedstats helper independent of cfs_rq
Date:   Mon, 23 Nov 2020 20:58:06 +0800
Message-Id: <20201123125808.50896-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201123125808.50896-1-laoar.shao@gmail.com>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The 'cfs_rq' in these helpers
update_stats_{wait_start, wait_end, enqueue_sleeper} is only used to get
the rq_clock, so we can pass the rq directly. Then these helpers can be
used by all sched class after being moved into stats.h.

After that change, the size of vmlinux is increased around 824Bytes.
			w/o this patch, with this patch
Size of vmlinux:	78443832	78444656

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 148 ++-----------------------------------------
 kernel/sched/stats.h | 144 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 143 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59e454cae3be..946b60f586e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -869,124 +869,6 @@ static void update_curr_fair(struct rq *rq)
 	update_curr(cfs_rq_of(&rq->curr->se));
 }
 
-static inline void
-update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	u64 wait_start, prev_wait_start;
-
-	if (!schedstat_enabled())
-		return;
-
-	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(se->statistics.wait_start);
-
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -= prev_wait_start;
-
-	__schedstat_set(se->statistics.wait_start, wait_start);
-}
-
-static inline void
-update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	struct task_struct *p;
-	u64 delta;
-
-	if (!schedstat_enabled())
-		return;
-
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
-
-	if (entity_is_task(se)) {
-		p = task_of(se);
-		if (task_on_rq_migrating(p)) {
-			/*
-			 * Preserve migrating task's wait time so wait_start
-			 * time stamp can be adjusted to accumulate wait time
-			 * prior to migration.
-			 */
-			__schedstat_set(se->statistics.wait_start, delta);
-			return;
-		}
-		trace_sched_stat_wait(p, delta);
-	}
-
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
-}
-
-static inline void
-update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	struct task_struct *tsk = NULL;
-	u64 sleep_start, block_start;
-
-	if (!schedstat_enabled())
-		return;
-
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
-
-	if (entity_is_task(se))
-		tsk = task_of(se);
-
-	if (sleep_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - sleep_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
-			__schedstat_set(se->statistics.sleep_max, delta);
-
-		__schedstat_set(se->statistics.sleep_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
-
-		if (tsk) {
-			account_scheduler_latency(tsk, delta >> 10, 1);
-			trace_sched_stat_sleep(tsk, delta);
-		}
-	}
-	if (block_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - block_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
-			__schedstat_set(se->statistics.block_max, delta);
-
-		__schedstat_set(se->statistics.block_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
-
-		if (tsk) {
-			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
-				trace_sched_stat_iowait(tsk, delta);
-			}
-
-			trace_sched_stat_blocked(tsk, delta);
-
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on == SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(tsk),
-						delta >> 20);
-			}
-			account_scheduler_latency(tsk, delta >> 10, 0);
-		}
-	}
-}
-
 /*
  * Task is being enqueued - update stats:
  */
@@ -1001,10 +883,10 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * a dequeue/enqueue event is a NOP)
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_start(cfs_rq, se);
+		update_stats_wait_start(rq_of(cfs_rq), se);
 
 	if (flags & ENQUEUE_WAKEUP)
-		update_stats_enqueue_sleeper(cfs_rq, se);
+		update_stats_enqueue_sleeper(rq_of(cfs_rq), se);
 }
 
 static inline void
@@ -1019,7 +901,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end(rq_of(cfs_rq), se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4128,26 +4010,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
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
@@ -4388,7 +4250,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end(rq_of(cfs_rq), se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4489,7 +4351,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start(rq_of(cfs_rq), prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index c23b653ffc53..966cc408bd8b 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -42,6 +42,144 @@ rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
+static inline void
+update_stats_wait_start(struct rq *rq, struct sched_entity *se)
+{
+	u64 wait_start, prev_wait_start;
+
+	if (!schedstat_enabled())
+		return;
+
+	wait_start = rq_clock(rq);
+	prev_wait_start = schedstat_val(se->statistics.wait_start);
+
+	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
+	    likely(wait_start > prev_wait_start))
+		wait_start -= prev_wait_start;
+
+	__schedstat_set(se->statistics.wait_start, wait_start);
+}
+
+static inline void
+update_stats_wait_end(struct rq *rq, struct sched_entity *se)
+{
+	struct task_struct *p;
+	u64 delta;
+
+	if (!schedstat_enabled())
+		return;
+
+	delta = rq_clock(rq) - schedstat_val(se->statistics.wait_start);
+
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		if (task_on_rq_migrating(p)) {
+			/*
+			 * Preserve migrating task's wait time so wait_start
+			 * time stamp can be adjusted to accumulate wait time
+			 * prior to migration.
+			 */
+			__schedstat_set(se->statistics.wait_start, delta);
+			return;
+		}
+		trace_sched_stat_wait(p, delta);
+	}
+
+	__schedstat_set(se->statistics.wait_max,
+		      max(schedstat_val(se->statistics.wait_max), delta));
+	__schedstat_inc(se->statistics.wait_count);
+	__schedstat_add(se->statistics.wait_sum, delta);
+	__schedstat_set(se->statistics.wait_start, 0);
+}
+
+static inline void
+update_stats_enqueue_sleeper(struct rq *rq, struct sched_entity *se)
+{
+	struct task_struct *tsk = NULL;
+	u64 sleep_start, block_start;
+
+	if (!schedstat_enabled())
+		return;
+
+	sleep_start = schedstat_val(se->statistics.sleep_start);
+	block_start = schedstat_val(se->statistics.block_start);
+
+	if (entity_is_task(se))
+		tsk = task_of(se);
+
+	if (sleep_start) {
+		u64 delta = rq_clock(rq) - sleep_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
+			__schedstat_set(se->statistics.sleep_max, delta);
+
+		__schedstat_set(se->statistics.sleep_start, 0);
+		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+
+		if (tsk) {
+			account_scheduler_latency(tsk, delta >> 10, 1);
+			trace_sched_stat_sleep(tsk, delta);
+		}
+	}
+
+	if (block_start) {
+		u64 delta = rq_clock(rq) - block_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
+			__schedstat_set(se->statistics.block_max, delta);
+
+		__schedstat_set(se->statistics.block_start, 0);
+		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+
+		if (tsk) {
+			if (tsk->in_iowait) {
+				__schedstat_add(se->statistics.iowait_sum, delta);
+				__schedstat_inc(se->statistics.iowait_count);
+				trace_sched_stat_iowait(tsk, delta);
+			}
+
+			trace_sched_stat_blocked(tsk, delta);
+
+			/*
+			 * Blocking time is in units of nanosecs, so shift by
+			 * 20 to get a milliseconds-range estimation of the
+			 * amount of time that the task spent sleeping:
+			 */
+			if (unlikely(prof_on == SLEEP_PROFILING)) {
+				profile_hits(SLEEP_PROFILING,
+						(void *)get_wchan(tsk),
+						delta >> 20);
+			}
+			account_scheduler_latency(tsk, delta >> 10, 0);
+		}
+	}
+}
+
+static inline void
+check_schedstat_required(void)
+{
+	if (schedstat_enabled())
+		return;
+
+	/* Force schedstat enabled if a dependent tracepoint is active */
+	if (trace_sched_stat_wait_enabled()    ||
+			trace_sched_stat_sleep_enabled()   ||
+			trace_sched_stat_iowait_enabled()  ||
+			trace_sched_stat_blocked_enabled() ||
+			trace_sched_stat_runtime_enabled())  {
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
+			     "stat_blocked and stat_runtime require the "
+			     "kernel parameter schedstats=enable or "
+			     "kernel.sched_schedstats=1\n");
+	}
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
@@ -55,6 +193,12 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
+# define update_stats_wait_start(rq, se)	do { } while (0)
+# define update_stats_wait_end(rq, se)		do { } while (0)
+# define update_stats_enqueue_sleeper(rq, se)	do { } while (0)
+# define check_schedstat_required()		do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_PSI
-- 
2.18.4

