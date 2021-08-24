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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A989C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DD76135F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhHXLa5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhHXLav (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F1C0613C1;
        Tue, 24 Aug 2021 04:30:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so1789473pjb.1;
        Tue, 24 Aug 2021 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loaHRPIeGMQ85RfdiGbBupQ4rNWPYRIhgiocTz7Ohw0=;
        b=RozjAPdqYcxTPkcccB5tlH5cMKiRP4PA5xEDXzMGAAbo7nfb451s4hEngMgCpqjvsT
         VIon9/xtLe8mGGwZk0SsYxkuVHBXatdLtQAE3xiMsaRRPu2olzaMXmj6ZOgj8KkLVATr
         p+iNsFlGszNa+2SOkYlGQBLTJq9qu9Vy9BXjNuTYRZv53GsQsuhAXIK0Ggxnt4CZdCsC
         ARvBoryVHjGJqn+zBFjOFi2Ob23IKAWtXG3LMqsLPXad+I2S0W0xxKX89lrCFXjvQsA6
         KyUu1EfcNo1GV6pXzXsrB9VJmX/Pa4x+C+lVKniQqCTq4jHxC08JYVJZEmB9qqIPVRCO
         QbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loaHRPIeGMQ85RfdiGbBupQ4rNWPYRIhgiocTz7Ohw0=;
        b=D+EULhTado7jspa2qny9u89PsQLciq4oyCwZRv+HXiqOV5rhv9wbUpBoNyQ0hpO+FK
         5kKAGV3JgBlDZbAptzOv/xhuPIRuTS55PTQFFeFbTvtYDdr7OGxL1ScVC7/1QiK8abgM
         JOuShn6w2Bu8afMd/HxQGVsgzVN834kmVsy5QYmpLDg3UObYHsBMBnLZWoA5zRYXhBSR
         GyDCumj1fWTVLfuR41he6agnh83JGTii+V05R/nSGX9cjz+ANpAFIOxJHI6JFqx2uGBI
         6qpsAkuhJ3YkFudMEZe4QmDK8gOe6UadLd1GYfllWz0nJs7f01ya4P6pneLOlpw7SK8Z
         r1Tw==
X-Gm-Message-State: AOAM5316yDPdIj9SH5pfdIlCwY/xXD6JMyD3cIs5R1uC6FhK5lJTn4IE
        GOxDi1aATW2GKg/0V00DqVA=
X-Google-Smtp-Source: ABdhPJxvjWX46x4kygxVTfwj44zFSHdc78EduREFtGcBVQENQ/1UYhCD8U45UZ3IY2/ReaREQw6+5A==
X-Received: by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP id p12-20020a170902a40cb029012c17cfab6fmr32665043plq.71.1629804606190;
        Tue, 24 Aug 2021 04:30:06 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/7] sched: make schedstats helpers independent of fair sched class
Date:   Tue, 24 Aug 2021 11:29:42 +0000
Message-Id: <20210824112946.9324-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
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

The size of vmlinux as follows,
                      Before          After
  Size of vmlinux     826308552       826304640
The size is a litte smaller as some functions are not inlined again after
the change.

I also compared the sched performance with 'perf bench sched pipe',
suggested by Mel. The result as follows,
                             Before               After
  kernel.sched_schedstats=0  ~5.6                 ~5.6
  kernel.sched_schedstats=1  ~5.7                 ~5.7
[These data is a little difference with the prev version, that is
because my old test machine is destroyed so I have to use a new
different test machine.]
Almost no difference.

No functional change.

[lkp@intel.com: reported build failure in prev version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: kernel test robot <lkp@intel.com>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/fair.c  | 133 +++++++------------------------------------
 kernel/sched/stats.c | 103 +++++++++++++++++++++++++++++++++
 kernel/sched/stats.h |  34 +++++++++++
 3 files changed, 156 insertions(+), 114 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7cb802431cfe..1324000c78bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -902,32 +902,28 @@ static void update_curr_fair(struct rq *rq)
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
 
 	__schedstats_from_sched_entity(se, &stats);
 
-	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(stats->wait_start);
+	if (entity_is_task(se))
+		p = task_of(se);
 
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -= prev_wait_start;
+	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
 
-	__schedstat_set(stats->wait_start, wait_start);
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
@@ -943,105 +939,34 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
-
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
-			return;
-		}
-		trace_sched_stat_wait(p, delta);
-	}
 
-	__schedstat_set(stats->wait_max,
-		      max(schedstat_val(stats->wait_max), delta));
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
 	struct task_struct *tsk = NULL;
-	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
 	__schedstats_from_sched_entity(se, &stats);
 
-	sleep_start = schedstat_val(stats->sleep_start);
-	block_start = schedstat_val(stats->block_start);
-
 	if (entity_is_task(se))
 		tsk = task_of(se);
 
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
-		if (unlikely(delta > schedstat_val(stats->block_max)))
-			__schedstat_set(stats->block_max, delta);
-
-		__schedstat_set(stats->block_start, 0);
-		__schedstat_add(stats->sum_sleep_runtime, delta);
-
-		if (tsk) {
-			if (tsk->in_iowait) {
-				__schedstat_add(stats->iowait_sum, delta);
-				__schedstat_inc(stats->iowait_count);
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
+	__update_stats_enqueue_sleeper(rq_of(cfs_rq), tsk, stats);
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
@@ -1051,14 +976,14 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -1069,7 +994,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4273,26 +4198,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
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
@@ -4366,7 +4271,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		place_entity(cfs_rq, se, 0);
 
 	check_schedstat_required();
-	update_stats_enqueue(cfs_rq, se, flags);
+	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
@@ -4450,7 +4355,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, UPDATE_TG);
 	se_update_runnable(se);
 
-	update_stats_dequeue(cfs_rq, se, flags);
+	update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	clear_buddies(cfs_rq, se);
 
@@ -4537,7 +4442,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4637,7 +4542,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3b5648..b2542f4d3192 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -4,6 +4,109 @@
  */
 #include "sched.h"
 
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats)
+{
+u64 wait_start, prev_wait_start;
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
+	u64 delta = rq_clock(rq) - schedstat_val(stats->wait_start);
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
+
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
+					     (void *)get_wchan(p),
+					     delta >> 20);
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
index e6905e369c5d..9ecd81b91f26 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
 
 #ifdef CONFIG_SCHEDSTATS
 
+extern struct static_key_false sched_schedstats;
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
@@ -40,6 +42,33 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
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
+					"stat_blocked and stat_runtime require the "
+					"kernel parameter schedstats=enable or "
+					"kernel.sched_schedstats=1\n");
+	}
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
@@ -55,6 +84,11 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
 
+# define __update_stats_wait_start(rq, p, stats)       do { } while (0)
+# define __update_stats_wait_end(rq, p, stats)         do { } while (0)
+# define __update_stats_enqueue_sleeper(rq, p, stats)  do { } while (0)
+# define check_schedstat_required()                    do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SCHEDSTATS)
-- 
2.18.2

