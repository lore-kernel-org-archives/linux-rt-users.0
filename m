Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17891C64E7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDB221D7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8k2Fs0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgK0QN2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgK0QN2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 11:13:28 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A923C0613D1;
        Fri, 27 Nov 2020 08:13:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t21so4699476pgl.3;
        Fri, 27 Nov 2020 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HW2RmeLpCXEqafqo6N6XE/32NCCeTkabMd+FGlX+jE=;
        b=g8k2Fs0UFarBmdDvrTzblpoJ+ZaTUdcuPLJSfUW2FLUZjIEbv/F48UsqWYtyb64VIY
         Zu938f1mb+NM37RhRi2UfSARnrIXZdMmTg29ktLEPdrrT6etcmZl382sVryiEyehNnsX
         zKreVJsSlQkaArzv5SgRcSoWJ0ozL048CxEIcZe34SLXzq9Qlv+IuGCk5t1fL2GRrRXW
         rVsudfNKp3owgBiQzxsGnUaJCkC0rUsCiePXtPsDOnGlVtfddBgog1k4pZp/p8OosmeX
         ZEpLlYn75pmDHaYEtzyUuAwx6/6OicRYimAIntOaTM4hN+bKCvFqgxAInl+OwiU2Wcdf
         RpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HW2RmeLpCXEqafqo6N6XE/32NCCeTkabMd+FGlX+jE=;
        b=kEwg3Fv7xcgJrDC6mXuQNt00+oVaIgm8/ucOmyZaQbghJeGbalO+uBN1v4h31vI3B2
         nw3Zq88227FF2przys8dsUguhahUxSivl2OU2ADUQJ6o+GI2+QZsubuqIq9TozFfbvT0
         IAIBOJMSpAUQHYFVTfSZEmSSraNryf0MkWEZGvojggtbKb1IRiL2xiyx99qhKevnqjBo
         dskJbPyoiqiLhk91Py6g0WdInPbwrmMXoySWBhUU12RvhGGhR6+4RsU3jTPkN89O/hI9
         gZTMxm/lwUL+Gt25QC0Cec4hMU5wzkpHV7xv76b/oQVyrO+IwQ5VFHTIMPxS4jC8Zbck
         9ohQ==
X-Gm-Message-State: AOAM533EG0r+UX/Z0t6tl149pFX744SbLL+PSAROUQLbu1LYWNZn3m9i
        qhC3CwRce8RWntDO27m9jU0=
X-Google-Smtp-Source: ABdhPJyPJCOdW1P1q4QaIVy4b44qwSkQIYIZaX9TnpRk3Gpp4jNhO6Oj4jvjHrKCCb8y1OyBVKxJQA==
X-Received: by 2002:aa7:953c:0:b029:18b:bfb:9fa1 with SMTP id c28-20020aa7953c0000b029018b0bfb9fa1mr7704404pfp.14.1606493607454;
        Fri, 27 Nov 2020 08:13:27 -0800 (PST)
Received: from localhost.localdomain ([115.192.120.179])
        by smtp.gmail.com with ESMTPSA id v126sm7992715pfb.137.2020.11.27.08.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:13:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 3/5] sched: make struct sched_statistics independent of fair sched class
Date:   Sat, 28 Nov 2020 00:12:27 +0800
Message-Id: <20201127161229.19336-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201127161229.19336-1-laoar.shao@gmail.com>
References: <20201127161229.19336-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If we want to use schedstats facility, we should move out of
struct sched_statistics from the struct sched_entity or add it into other
sctructs of sched entity as well. Obviously the latter one is bad because
that requires more spaces. So we should move it into a common struct which
can be used by all sched classes.

The struct sched_statistics is the schedular statistics of a task_struct
or a task_group. So we can move it into struct task_struct and
struct task_group to achieve the goal.

Below is the detailed explaination of the change in the structs.

- Before this patch

struct task_struct {            |-> struct sched_entity {
    ...                         |       ...
    struct sched_entity *se; ---|       struct sched_statistics statistics;
    struct sched_rt_entity *rt;         ...
    ... 	                        ...
};				    };

struct task_group {             |--> se[0]->statistics : schedstats of CPU0
    ...                         |
 #ifdef CONFIG_FAIR_GROUP_SCHED |
    struct sched_entity **se; --|--> se[1]->statistics : schedstats of CPU1
                                |
 #endif                         |
                                |--> se[N]->statistics : schedstats of CPUn

 #ifdef CONFIG_FAIR_GROUP_SCHED
    struct sched_rt_entity  **rt_se; (N/A)
 #endif
    ...
};

The '**se' in task_group is allocated in the fair sched class, which is
hard to be reused by other sched class.

- After this patch

struct task_struct {
    ...
    struct sched_statistics statistics;
    ...
    struct sched_entity *se;
    struct sched_rt_entity *rt;
    ...
};

struct task_group {                    |---> stats[0] : of CPU0
    ...                                |
    struct sched_statistics **stats; --|---> stats[1] : of CPU1
    ...                                |
                                       |---> stats[n] : of CPUn
 #ifdef CONFIG_FAIR_GROUP_SCHED
    struct sched_entity **se;
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
    struct sched_rt_entity  **rt_se;
 #endif
    ...
};

After the patch it is clearly that both of se or rt_se can easily get the
sched_statistics by a task_struct or a task_group.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched.h    |   3 +-
 kernel/sched/core.c      |  24 ++++---
 kernel/sched/deadline.c  |   4 +-
 kernel/sched/debug.c     |  81 +++++++++++-----------
 kernel/sched/fair.c      | 142 ++++++++++++++++++++++++++-------------
 kernel/sched/rt.c        |   4 +-
 kernel/sched/sched.h     |   3 +
 kernel/sched/stats.h     |  46 +++++++++++++
 kernel/sched/stop_task.c |   4 +-
 9 files changed, 206 insertions(+), 105 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..f8e969be4bee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -462,8 +462,6 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -681,6 +679,7 @@ struct task_struct {
 	unsigned int			rt_priority;
 
 	const struct sched_class	*sched_class;
+	struct sched_statistics         stats;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd76628778f7..081b4f1f2cb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2427,11 +2427,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 #ifdef CONFIG_SMP
 	if (cpu == rq->cpu) {
 		__schedstat_inc(rq->ttwu_local);
-		__schedstat_inc(p->se.statistics.nr_wakeups_local);
+		__schedstat_inc(p->stats.nr_wakeups_local);
 	} else {
 		struct sched_domain *sd;
 
-		__schedstat_inc(p->se.statistics.nr_wakeups_remote);
+		__schedstat_inc(p->stats.nr_wakeups_remote);
 		rcu_read_lock();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
@@ -2443,14 +2443,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 	}
 
 	if (wake_flags & WF_MIGRATED)
-		__schedstat_inc(p->se.statistics.nr_wakeups_migrate);
+		__schedstat_inc(p->stats.nr_wakeups_migrate);
 #endif /* CONFIG_SMP */
 
 	__schedstat_inc(rq->ttwu_count);
-	__schedstat_inc(p->se.statistics.nr_wakeups);
+	__schedstat_inc(p->stats.nr_wakeups);
 
 	if (wake_flags & WF_SYNC)
-		__schedstat_inc(p->se.statistics.nr_wakeups_sync);
+		__schedstat_inc(p->stats.nr_wakeups_sync);
 }
 
 /*
@@ -3075,7 +3075,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -7347,9 +7347,9 @@ void normalize_rt_tasks(void)
 			continue;
 
 		p->se.exec_start = 0;
-		schedstat_set(p->se.statistics.wait_start,  0);
-		schedstat_set(p->se.statistics.sleep_start, 0);
-		schedstat_set(p->se.statistics.block_start, 0);
+		schedstat_set(p->stats.wait_start,  0);
+		schedstat_set(p->stats.sleep_start, 0);
+		schedstat_set(p->stats.block_start, 0);
 
 		if (!dl_task(p) && !rt_task(p)) {
 			/*
@@ -7439,6 +7439,7 @@ static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
+	free_tg_schedstats(tg);
 	autogroup_free(tg);
 	kmem_cache_free(task_group_cache, tg);
 }
@@ -7458,6 +7459,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_tg_schedstats(tg))
+		goto err;
+
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -8144,7 +8148,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		int i;
 
 		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			ws += schedstat_val(tg->stats[i]->wait_sum);
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7a0124f81a4f..315d140b8f0e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1245,8 +1245,8 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9758aa1bba1e..8c646fcb89de 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -444,16 +444,16 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	PN(se->sum_exec_runtime);
 
 	if (schedstat_enabled()) {
-		PN_SCHEDSTAT(se->statistics.wait_start);
-		PN_SCHEDSTAT(se->statistics.sleep_start);
-		PN_SCHEDSTAT(se->statistics.block_start);
-		PN_SCHEDSTAT(se->statistics.sleep_max);
-		PN_SCHEDSTAT(se->statistics.block_max);
-		PN_SCHEDSTAT(se->statistics.exec_max);
-		PN_SCHEDSTAT(se->statistics.slice_max);
-		PN_SCHEDSTAT(se->statistics.wait_max);
-		PN_SCHEDSTAT(se->statistics.wait_sum);
-		P_SCHEDSTAT(se->statistics.wait_count);
+		PN_SCHEDSTAT(tg->stats[cpu]->wait_start);
+		PN_SCHEDSTAT(tg->stats[cpu]->sleep_start);
+		PN_SCHEDSTAT(tg->stats[cpu]->block_start);
+		PN_SCHEDSTAT(tg->stats[cpu]->sleep_max);
+		PN_SCHEDSTAT(tg->stats[cpu]->block_max);
+		PN_SCHEDSTAT(tg->stats[cpu]->exec_max);
+		PN_SCHEDSTAT(tg->stats[cpu]->slice_max);
+		PN_SCHEDSTAT(tg->stats[cpu]->wait_max);
+		PN_SCHEDSTAT(tg->stats[cpu]->wait_sum);
+		P_SCHEDSTAT(tg->stats[cpu]->wait_count);
 	}
 
 	P(se->load.weight);
@@ -499,9 +499,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		p->prio);
 
 	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -938,34 +938,33 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 	if (schedstat_enabled()) {
 		u64 avg_atom, avg_per_cpu;
-
-		PN_SCHEDSTAT(se.statistics.sum_sleep_runtime);
-		PN_SCHEDSTAT(se.statistics.wait_start);
-		PN_SCHEDSTAT(se.statistics.sleep_start);
-		PN_SCHEDSTAT(se.statistics.block_start);
-		PN_SCHEDSTAT(se.statistics.sleep_max);
-		PN_SCHEDSTAT(se.statistics.block_max);
-		PN_SCHEDSTAT(se.statistics.exec_max);
-		PN_SCHEDSTAT(se.statistics.slice_max);
-		PN_SCHEDSTAT(se.statistics.wait_max);
-		PN_SCHEDSTAT(se.statistics.wait_sum);
-		P_SCHEDSTAT(se.statistics.wait_count);
-		PN_SCHEDSTAT(se.statistics.iowait_sum);
-		P_SCHEDSTAT(se.statistics.iowait_count);
-		P_SCHEDSTAT(se.statistics.nr_migrations_cold);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_affine);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_running);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_hot);
-		P_SCHEDSTAT(se.statistics.nr_forced_migrations);
-		P_SCHEDSTAT(se.statistics.nr_wakeups);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_sync);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_migrate);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_local);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_remote);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine_attempts);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_passive);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_idle);
+		PN_SCHEDSTAT(stats.sum_sleep_runtime);
+		PN_SCHEDSTAT(stats.wait_start);
+		PN_SCHEDSTAT(stats.sleep_start);
+		PN_SCHEDSTAT(stats.block_start);
+		PN_SCHEDSTAT(stats.sleep_max);
+		PN_SCHEDSTAT(stats.block_max);
+		PN_SCHEDSTAT(stats.exec_max);
+		PN_SCHEDSTAT(stats.slice_max);
+		PN_SCHEDSTAT(stats.wait_max);
+		PN_SCHEDSTAT(stats.wait_sum);
+		P_SCHEDSTAT(stats.wait_count);
+		PN_SCHEDSTAT(stats.iowait_sum);
+		P_SCHEDSTAT(stats.iowait_count);
+		P_SCHEDSTAT(stats.nr_migrations_cold);
+		P_SCHEDSTAT(stats.nr_failed_migrations_affine);
+		P_SCHEDSTAT(stats.nr_failed_migrations_running);
+		P_SCHEDSTAT(stats.nr_failed_migrations_hot);
+		P_SCHEDSTAT(stats.nr_forced_migrations);
+		P_SCHEDSTAT(stats.nr_wakeups);
+		P_SCHEDSTAT(stats.nr_wakeups_sync);
+		P_SCHEDSTAT(stats.nr_wakeups_migrate);
+		P_SCHEDSTAT(stats.nr_wakeups_local);
+		P_SCHEDSTAT(stats.nr_wakeups_remote);
+		P_SCHEDSTAT(stats.nr_wakeups_affine);
+		P_SCHEDSTAT(stats.nr_wakeups_affine_attempts);
+		P_SCHEDSTAT(stats.nr_wakeups_passive);
+		P_SCHEDSTAT(stats.nr_wakeups_idle);
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
@@ -1031,6 +1030,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e7c03cede94..14d8df308d44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -837,12 +837,44 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
+static inline void
+__schedstat_from_sched_entity(struct sched_entity *se,
+			      struct sched_statistics **stats)
+{
+	struct task_struct *p;
+	struct task_group *tg;
+	struct cfs_rq *cfs_rq;
+	int cpu;
+
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		*stats = &p->stats;
+	} else {
+		cfs_rq = group_cfs_rq(se);
+		tg = cfs_rq->tg;
+		cpu = cpu_of(rq_of(cfs_rq));
+		*stats = tg->stats[cpu];
+	}
+}
+
+static inline void
+schedstat_from_sched_entity(struct sched_entity *se,
+			    struct sched_statistics **stats)
+{
+	if (!schedstat_enabled())
+		return;
+
+	__schedstat_from_sched_entity(se, stats);
+}
+
 /*
  * Update the current task's runtime statistics.
  */
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_statistics *stats = NULL;
+
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
 
@@ -855,8 +887,12 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->exec_start = now;
 
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		__schedstat_from_sched_entity(curr, &stats);
+
+		__schedstat_set(stats->exec_max,
+		      max(delta_exec, stats->exec_max));
+	}
 
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -883,67 +919,78 @@ static void update_curr_fair(struct rq *rq)
 static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
 	u64 wait_start, prev_wait_start;
 
 	if (!schedstat_enabled())
 		return;
 
+	__schedstat_from_sched_entity(se, &stats);
+
 	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(se->statistics.wait_start);
+	prev_wait_start = schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
 	    likely(wait_start > prev_wait_start))
 		wait_start -= prev_wait_start;
 
-	__schedstat_set(se->statistics.wait_start, wait_start);
+	__schedstat_set(stats->wait_start, wait_start);
 }
 
 static inline void
 update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct task_struct *p;
+	struct sched_statistics *stats = NULL;
+	struct task_struct *p = NULL;
 	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
+	__schedstat_from_sched_entity(se, &stats);
 
+	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
 	if (entity_is_task(se)) {
 		p = task_of(se);
+
 		if (task_on_rq_migrating(p)) {
 			/*
 			 * Preserve migrating task's wait time so wait_start
 			 * time stamp can be adjusted to accumulate wait time
 			 * prior to migration.
 			 */
-			__schedstat_set(se->statistics.wait_start, delta);
+			__schedstat_set(stats->wait_start, delta);
+
 			return;
 		}
+
 		trace_sched_stat_wait(p, delta);
 	}
 
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
+	__schedstat_set(stats->wait_max,
+			max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
 }
 
 static inline void
 update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct task_struct *tsk = NULL;
+	struct sched_statistics *stats = NULL;
+	struct task_struct *p = NULL;
 	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
-
 	if (entity_is_task(se))
-		tsk = task_of(se);
+		p = task_of(se);
+
+	__schedstat_from_sched_entity(se, &stats);
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
 
 	if (sleep_start) {
 		u64 delta = rq_clock(rq_of(cfs_rq)) - sleep_start;
@@ -951,15 +998,15 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
-			__schedstat_set(se->statistics.sleep_max, delta);
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
 
-		__schedstat_set(se->statistics.sleep_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
-		if (tsk) {
-			account_scheduler_latency(tsk, delta >> 10, 1);
-			trace_sched_stat_sleep(tsk, delta);
+		if (p) {
+			account_scheduler_latency(p, delta >> 10, 1);
+			trace_sched_stat_sleep(p, delta);
 		}
 	}
 	if (block_start) {
@@ -968,20 +1015,20 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
-			__schedstat_set(se->statistics.block_max, delta);
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
 
-		__schedstat_set(se->statistics.block_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
-		if (tsk) {
-			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
-				trace_sched_stat_iowait(tsk, delta);
+		if (p) {
+			if (p->in_iowait) {
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
+				trace_sched_stat_iowait(p, delta);
 			}
 
-			trace_sched_stat_blocked(tsk, delta);
+			trace_sched_stat_blocked(p, delta);
 
 			/*
 			 * Blocking time is in units of nanosecs, so shift by
@@ -990,10 +1037,10 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			 */
 			if (unlikely(prof_on == SLEEP_PROFILING)) {
 				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(tsk),
+						(void *)get_wchan(p),
 						delta >> 20);
 			}
-			account_scheduler_latency(tsk, delta >> 10, 0);
+			account_scheduler_latency(p, delta >> 10, 0);
 		}
 	}
 }
@@ -1036,10 +1083,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		struct task_struct *tsk = task_of(se);
 
 		if (tsk->state & TASK_INTERRUPTIBLE)
-			__schedstat_set(se->statistics.sleep_start,
+			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		if (tsk->state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(se->statistics.block_start,
+			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
 }
@@ -4392,6 +4439,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
+
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -4414,8 +4463,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		__schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
+		__schedstat_from_sched_entity(se, &stats);
+		__schedstat_set(stats->slice_max,
+			max((u64)schedstat_val(stats->slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
@@ -5862,12 +5912,12 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
-	schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
+	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	schedstat_inc(p->stats.nr_wakeups_affine);
 	return target;
 }
 
@@ -7533,7 +7583,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -7564,7 +7614,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -7582,12 +7632,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
 		if (tsk_cache_hot == 1) {
 			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->se.statistics.nr_forced_migrations);
+			schedstat_inc(p->stats.nr_forced_migrations);
 		}
 		return 1;
 	}
 
-	schedstat_inc(p->se.statistics.nr_failed_migrations_hot);
+	schedstat_inc(p->stats.nr_failed_migrations_hot);
 	return 0;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index af772ac0f32d..2d543a270dfe 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1008,8 +1008,8 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 871544bb9a38..b1cdb942c67d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -387,6 +387,9 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+	/* schedstats of this group on each CPU */
+	struct sched_statistics **stats;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index c23b653ffc53..87242968712e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -42,6 +42,42 @@ rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
+static inline void free_tg_schedstats(struct task_group *tg)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		if (tg->stats)
+			kfree(tg->stats[i]);
+	}
+
+	kfree(tg->stats);
+}
+
+static inline int alloc_tg_schedstats(struct task_group *tg)
+{
+	struct sched_statistics *stats;
+	int i;
+
+	/*
+	 * This memory should be allocated whatever schedstat_enabled() or
+	 * not.
+	 */
+	tg->stats = kcalloc(nr_cpu_ids, sizeof(stats), GFP_KERNEL);
+	if (!tg->stats)
+		return 0;
+
+	for_each_possible_cpu(i) {
+		stats = kzalloc_node(sizeof(struct sched_statistics),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!stats)
+			return 0;
+		tg->stats[i] = stats;
+	}
+
+	return 1;
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
@@ -55,6 +91,16 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
+static inline void free_tg_schedstats(struct task_group *tg)
+{
+}
+
+static inline int alloc_tg_schedstats(struct task_group *tg)
+{
+	return 1;
+}
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_PSI
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index a5d289049388..f35cd67a0881 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -70,8 +70,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+			max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
-- 
2.18.4

