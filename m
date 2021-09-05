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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7354C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B151600D0
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhIEOhW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhIEOhV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA37C061575;
        Sun,  5 Sep 2021 07:36:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so2392308plo.10;
        Sun, 05 Sep 2021 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9E/2ChZxBzNPIZVVt0dF460jWVoyqMGuh7VA2HP2Vk=;
        b=Zaehv7XAeOvozkt73MD6CRNKvsccSqTiWYxZoG0fGI0iHirw/KG2msclBQMVTENdnW
         Ds1I7dWSvRD3WnSq4xGedxR4PN2O8y/sx7gx3B9GbfGd2qv1OmN/5GpZ5ax+FTTJOtWV
         VQ6NVwb0EuC38IthlFg5/DnX6DgxoejQceUc3GsjkT96PcXUC0tWBT+3qnhy2qPiC265
         TZTZJdqReqWXh4MzhJ/TrbzGlui9btXJqjBOb/47lg9XHQuOm5+JoCZNZ/Xiu9JOjSLA
         cZJKrbddb73xeONay4vKUvNZtXlStchbEPRVHA/MKpipn4S/PEJaYinF2w/hFCL8JS5i
         NKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9E/2ChZxBzNPIZVVt0dF460jWVoyqMGuh7VA2HP2Vk=;
        b=ItOMhkj7DRvdiU0pyeRpX8vqLrnj/5hWIh8DCpM74qnym8Y3g/kspHpr4nbC1EOy5t
         XNNju2Ut6tqDs2RxlpYKuT5HLx1Ms1Pq93qdd7NgX4B7l0ggjVKKDC/VFMBNdnH4MjZG
         kuZZfT1Ttyga2pDFWuNBO6gNPbYuVeWD2UBuh0IPZUUMKNbki6N7OOyF85o/EqaAQtr9
         Eaq6x5s9qBCo4ETzJyzpawlcLmK07HdetgkXA5ov+TZyvXi/i4u2oaYUEqK8qvHG39+e
         TgBfqv+GpsV4I7xm2B1SUYmPnHzEceKelzV+ba0nEtSgBR79bU8pce1/sWuVMK+GzRLU
         1L0Q==
X-Gm-Message-State: AOAM532V2VLQ14ELOKsG1wO0pkxxAVHCPyz7/RXV/3nZ+zG1EoInEjRg
        SjfdCN8DT8bDzEzpuDCRVH4=
X-Google-Smtp-Source: ABdhPJwoUOpSFGa93VtnFjV7hasdMtCaExExZtgwCBeFQ6gMpwg/KpXuGl8X03hcYXoRlnS1v2sw4w==
X-Received: by 2002:a17:90a:6f24:: with SMTP id d33mr9336595pjk.239.1630852578366;
        Sun, 05 Sep 2021 07:36:18 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 3/8] sched: make schedstats helpers independent of fair sched class
Date:   Sun,  5 Sep 2021 14:35:42 +0000
Message-Id: <20210905143547.4668-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
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
suggested by Mel. The result as followsi (in usecs/op),
                             Before                After
  kernel.sched_schedstats=0  5.2~5.4               5.2~5.4
  kernel.sched_schedstats=1  5.3~5.5               5.3~5.5

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
 kernel/sched/debug.c |   4 +-
 kernel/sched/fair.c  | 140 +++++++------------------------------------
 kernel/sched/stats.c | 103 +++++++++++++++++++++++++++++++
 kernel/sched/stats.h |  30 ++++++++++
 4 files changed, 159 insertions(+), 118 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index da923347c8f3..e08eee374176 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -439,8 +439,10 @@ void dirty_sched_domain_sysctl(int cpu)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
+	struct sched_statistics __maybe_unused *stats;
 	struct sched_entity *se = tg->se[cpu];
-	struct sched_statistics *stats = __schedstats_from_se(se);
+
+	stats = __schedstats_from_se(se);
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
 #define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8b4b97453cca..219ad90a1762 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -838,8 +838,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->exec_start = now;
 
 	if (schedstat_enabled()) {
-		struct sched_statistics *stats = __schedstats_from_se(curr);
+		struct sched_statistics __maybe_unused *stats;
 
+		stats = __schedstats_from_se(curr);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
@@ -867,32 +868,27 @@ static void update_curr_fair(struct rq *rq)
 }
 
 static inline void
-update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 wait_start, prev_wait_start;
 	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
-	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(stats->wait_start);
-
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -= prev_wait_start;
+	if (entity_is_task(se))
+		p = task_of(se);
 
-	__schedstat_set(stats->wait_start, wait_start);
+	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
 }
 
 static inline void
-update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
 	struct task_struct *p = NULL;
-	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
@@ -908,105 +904,34 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
 	struct sched_statistics *stats;
 	struct task_struct *tsk = NULL;
-	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
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
@@ -1016,14 +941,14 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -1034,7 +959,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4238,26 +4163,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
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
@@ -4331,7 +4236,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		place_entity(cfs_rq, se, 0);
 
 	check_schedstat_required();
-	update_stats_enqueue(cfs_rq, se, flags);
+	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
@@ -4415,7 +4320,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, UPDATE_TG);
 	se_update_runnable(se);
 
-	update_stats_dequeue(cfs_rq, se, flags);
+	update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	clear_buddies(cfs_rq, se);
 
@@ -4500,7 +4405,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4515,8 +4420,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		struct sched_statistics *stats = __schedstats_from_se(se);
+		struct sched_statistics __maybe_unused *stats;
 
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->slice_max,
 			max((u64)schedstat_val(stats->slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
@@ -4601,7 +4507,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3b5648..fad781ca7791 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -4,6 +4,109 @@
  */
 #include "sched.h"
 
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
index fb6022e860af..cfb0893a83d4 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
 
 #ifdef CONFIG_SCHEDSTATS
 
+extern struct static_key_false sched_schedstats;
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
@@ -40,6 +42,29 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
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
+	    trace_sched_stat_sleep_enabled()   ||
+	    trace_sched_stat_iowait_enabled()  ||
+	    trace_sched_stat_blocked_enabled() ||
+	    trace_sched_stat_runtime_enabled())
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1\n");
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
@@ -55,6 +80,11 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
 
+# define __update_stats_wait_start(rq, p, stats)       do { } while (0)
+# define __update_stats_wait_end(rq, p, stats)         do { } while (0)
+# define __update_stats_enqueue_sleeper(rq, p, stats)  do { } while (0)
+# define check_schedstat_required()                    do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.18.2

