Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB9FC64E69
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 03:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9924695
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 03:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNwVG2kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKSDxP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 22:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDxP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 22:53:15 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE71C0613D4;
        Wed, 18 Nov 2020 19:53:14 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id t10so1021329oon.4;
        Wed, 18 Nov 2020 19:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hsWjQDyxWDd2bhm3QkmCayCsCjmBgN4mGiJSxm1fk4=;
        b=QNwVG2kHUN6O4vgjmRV9PyIqJuJZqz1FTPZUJaXoUE3Qd+EryKxyfCWiuxowdtcCFO
         2eNyOG6Ni85FT+yJYFq7mQtm4VNouqKMoRdsyDfvGMrgK9kBzroc/Jkc7eQAng5uH8np
         YxQvEI8VRWinEENxHvzihjqhSelxGLw919y3x7XyKPV2gx2HBS6tBHmbVpRq78cKzuPz
         gTISXBWZraXUU3mH9vFTa7L1BE2sH3WlHhQr9FEn3DLdiXf+9rDAoc+VCU5FAYTe72bn
         XMN5zgP5nEVDKPbsrq9fKlaYXspPMPx0Gx7h5hQuawjeMBJBzeIEUUaUHFjUreX/vQvI
         R1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hsWjQDyxWDd2bhm3QkmCayCsCjmBgN4mGiJSxm1fk4=;
        b=tHIjegy4LEQgFS72PVguXn1jGnwiiiL6Ruq4May3vPA2uI6+KLtOvHUR9dtwMAkpeX
         bUmLFQEjvJ6wxVyU+YF2Oxq73EnatdwTyeMmhxuqv/dWB+Wq8ZMkimZhIi+ItF8Cfs/z
         Ir+2tAxoe2yPZtq9TuHVO96bHDfBr11crfqp1nCbJJqBS+/MTFmL++NPZ71E0P/A62P6
         r5vkqfGuQUFvmj6PxQ0fX1grIslpn8+TKGmXmimvRuOsKpVEfKjygrk4M3CxBl4Vphso
         5etGW/jAzoWnVggtJRGdI/7sIFMj6ik4eD3UWmraKSs1UgszADDkhOFrop3apFoEXmHh
         dPhw==
X-Gm-Message-State: AOAM531v5dVvQa3BeefvJIp9UMSys2FSVh9wMtjbsA8GfMTI0smNTQYB
        bB4aCf91ea9VOFbDCTR7qrA=
X-Google-Smtp-Source: ABdhPJzlza1jYndPfwBROBunh9MqmyEKbmFlMfuMjGeWSTHKzoF1Ywq2E3XJqME/ELOoY1AZCtAzkA==
X-Received: by 2002:a4a:ea3c:: with SMTP id y28mr8759070ood.49.1605757994216;
        Wed, 18 Nov 2020 19:53:14 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k20sm8320926ots.53.2020.11.18.19.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:53:13 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 2/4] sched: make schedstats helpers not depend on cfs_rq
Date:   Thu, 19 Nov 2020 11:52:28 +0800
Message-Id: <20201119035230.45330-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201119035230.45330-1-laoar.shao@gmail.com>
References: <20201119035230.45330-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The 'cfs_rq' in these helpers is only used to get the rq_clock, so we
can pass the rq_clock directly. After that, these helpers can be used by
all sched class.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 148 ++-----------------------------------------
 kernel/sched/stats.c | 134 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/stats.h |  11 ++++
 3 files changed, 150 insertions(+), 143 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d73e8e5ebec..aba21191283d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -868,124 +868,6 @@ static void update_curr_fair(struct rq *rq)
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
@@ -1000,10 +882,10 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -1018,7 +900,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end(rq_of(cfs_rq), se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4127,26 +4009,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
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
@@ -4387,7 +4249,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end(rq_of(cfs_rq), se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4488,7 +4350,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start(rq_of(cfs_rq), prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..00ef7676ea36 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -4,6 +4,140 @@
  */
 #include "sched.h"
 
+void update_stats_wait_start(struct rq *rq, struct sched_entity *se)
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
+void update_stats_wait_end(struct rq *rq, struct sched_entity *se)
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
+void update_stats_enqueue_sleeper(struct rq *rq, struct sched_entity *se)
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
+void check_schedstat_required(void)
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
 /*
  * Current schedstat API version.
  *
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf83842..b46612b83896 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -40,6 +40,11 @@ rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
+void update_stats_wait_start(struct rq *rq, struct sched_entity *se);
+void update_stats_wait_end(struct rq *rq, struct sched_entity *se);
+void update_stats_enqueue_sleeper(struct rq *rq, struct sched_entity *se);
+void check_schedstat_required(void);
+
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
@@ -53,6 +58,12 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
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

