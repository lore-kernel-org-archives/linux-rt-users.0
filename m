Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E4C433C1
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEDA6196C
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC0KOC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhC0KOA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:14:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E2C0613B1;
        Sat, 27 Mar 2021 03:14:00 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id c3so3082488qvz.7;
        Sat, 27 Mar 2021 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vkud8Ra5QU19oAl3pkp5GrgUngD3fKEJYiQtrcbRqM=;
        b=hK3vuKsPKYc9CBvKCmyYNnUECnQWLqL7b+dYpw94jcOTfXEX4Rdik1FYWOVnNhhb1M
         a2EB0ocndF+k8NbmfU/cmoeRhSnu/J2hS+iK533Mvkqtu7DGDeAcnGbw5DFzTpIxferl
         no15798/+CnFZGiPAEQBd8Y/cJBX4szLrxqJsWr9ER8xTtT9qBUQtAEKw8d7mfFng5vg
         l2PANoJYR0sS+nT/tmZtfU9dwMOmQy0WLegZhL0fa6TyTNSt7XW3+1S0F4nM7aVOxXF0
         fZdXdQJNfLCSb45TTAo5542dDHeKcFaX8gUq7zE0eECO/d56R2RwyBk1rSkT118ScMlJ
         jydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vkud8Ra5QU19oAl3pkp5GrgUngD3fKEJYiQtrcbRqM=;
        b=K2/y9pPe/6Mq6LxaDnHdRjAmSItTzbut1hyH/FauUFwyGHPgPY6uo5FjrdaLWjQIeY
         T7beFDz83Zm5+IFTF8GdTi7mujv4ZZNz+VcOi/U5wxUxoKJ6iDWTN58Ii9V06hgfHLyI
         3arNMjcnhQG4cIpJVV96pAwwCF51nI+1PzIJqrwi3TmS0FO2pKRWAfjWKaSPzWlk1+qy
         UfgIm/zKGDx8Be+2sj05CgRAQV9+raLFHSQzNiWHwr7JhVwgw0Wc6HAPtzjeUluwpAjS
         VeJOEHhOkM8W987X8v6sf021C1rKerx08IQn6opy64UItS0OCqyZKcYC83nslZ3rC/Tq
         yPNQ==
X-Gm-Message-State: AOAM533rWLPh+CZUk3wXVRmnjL9tSKYXn1ICdjcgco413SYL2a3VY3gV
        2EbPkblXZMl/xHnjC8rbjZA=
X-Google-Smtp-Source: ABdhPJyXFi1go0ufCcS93uHCSHn1d1YAabyN37iJD0zDXXfV/mPj9NNtoZ4e1AacL6cNDXN1vSAKcA==
X-Received: by 2002:a0c:ed45:: with SMTP id v5mr16969680qvq.13.1616840039703;
        Sat, 27 Mar 2021 03:13:59 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.13.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:13:59 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/6] sched: make struct sched_statistics independent of fair sched class
Date:   Sat, 27 Mar 2021 18:12:49 +0800
Message-Id: <20210327101254.56872-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
References: <20210327101254.56872-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If we want to use the schedstats facility to trace other sched classes, we
should make it independent of fair sched class. The struct sched_statistics
is the schedular statistics of a task_struct or a task_group. So we can
move it into struct task_struct and struct task_group to achieve the goal.

After the patch, schestats are orgnized as follows,

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

The sched_statistics members may be frequently modified when schedstats is
enabled, in order to avoid impacting on random data which may in the same
cacheline with them, the struct sched_statistics is defined as cacheline
aligned.

As this patch changes the core struct of scheduler, so I verified the
performance it may impact on the scheduler with 'perf bench sched
pipe', suggested by Mel. Below is the result, in which all the values
are in usecs/op.

			     Before		After
  kernel.sched_schedstats=0  6.0~6.1		6.0~6.1
  kernel.sched_schedstats=1  6.2~6.4		6.2~6.4

No obvious impact on the sched performance.

No functional change.

[lkp@intel.com: reported build failure in prev version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: kernel test robot <lkp@intel.com>
---
 include/linux/sched.h    |   5 +-
 kernel/sched/core.c      |  24 ++++----
 kernel/sched/deadline.c  |   4 +-
 kernel/sched/debug.c     |  86 ++++++++++++++--------------
 kernel/sched/fair.c      | 121 ++++++++++++++++++++++++++++-----------
 kernel/sched/rt.c        |   4 +-
 kernel/sched/sched.h     |   3 +
 kernel/sched/stats.h     |  55 ++++++++++++++++++
 kernel/sched/stop_task.c |   4 +-
 9 files changed, 210 insertions(+), 96 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 05572e2140ad..b687bb38897b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -447,7 +447,7 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 #endif
-};
+} ____cacheline_aligned;
 
 struct sched_entity {
 	/* For load-balancing: */
@@ -463,8 +463,6 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -697,6 +695,7 @@ struct task_struct {
 	unsigned int			rt_priority;
 
 	const struct sched_class	*sched_class;
+	struct sched_statistics         stats;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3384ea74cad4..d55681b4f9a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2913,11 +2913,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
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
@@ -2929,14 +2929,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
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
@@ -3572,7 +3572,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -8415,9 +8415,9 @@ void normalize_rt_tasks(void)
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
@@ -8507,6 +8507,7 @@ static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
+	free_tg_schedstats(tg);
 	autogroup_free(tg);
 	kmem_cache_free(task_group_cache, tg);
 }
@@ -8526,6 +8527,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_tg_schedstats(tg))
+		goto err;
+
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -9212,7 +9216,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		int i;
 
 		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			ws += schedstat_val(tg->stats[i]->wait_sum);
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9a2989749b8d..2d67b3ec880f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1265,8 +1265,8 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4b49cc2af5c4..d1bc616936d9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -428,12 +428,13 @@ void unregister_sched_domain_sysctl(void)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
+	struct sched_statistics statistics =  *(tg->stats[cpu]);
 	struct sched_entity *se = tg->se[cpu];
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .se->%-30s: %lld\n",	#F, (long long)schedstat_val(F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .se->%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
 
 	if (!se)
 		return;
@@ -443,16 +444,17 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
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
+		/* Make the output backward compatible */
+		PN_SCHEDSTAT(statistics.wait_start);
+		PN_SCHEDSTAT(statistics.sleep_start);
+		PN_SCHEDSTAT(statistics.block_start);
+		PN_SCHEDSTAT(statistics.sleep_max);
+		PN_SCHEDSTAT(statistics.block_max);
+		PN_SCHEDSTAT(statistics.exec_max);
+		PN_SCHEDSTAT(statistics.slice_max);
+		PN_SCHEDSTAT(statistics.wait_max);
+		PN_SCHEDSTAT(statistics.wait_sum);
+		P_SCHEDSTAT(statistics.wait_count);
 	}
 
 	P(se->load.weight);
@@ -498,9 +500,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		p->prio);
 
 	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -938,33 +940,33 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (schedstat_enabled()) {
 		u64 avg_atom, avg_per_cpu;
 
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
@@ -1030,6 +1032,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 114eec730698..5f72fef1cc0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -821,6 +821,41 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline void
+__schedstats_from_sched_entity(struct sched_entity *se,
+			      struct sched_statistics **stats)
+{
+	struct task_group *tg;
+	struct task_struct *p;
+	struct cfs_rq *cfs;
+	int cpu;
+
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		*stats = &p->stats;
+	} else {
+		cfs = group_cfs_rq(se);
+		tg = cfs->tg;
+		cpu = cpu_of(rq_of(cfs));
+		*stats = tg->stats[cpu];
+	}
+}
+
+#else
+
+static inline void
+__schedstats_from_sched_entity(struct sched_entity *se,
+			      struct sched_statistics **stats)
+{
+	struct task_struct *p;
+
+	p = task_of(se);
+	*stats = &p->stats;
+}
+
+#endif
+
 /*
  * Update the current task's runtime statistics.
  */
@@ -828,6 +863,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
+	struct sched_statistics *stats = NULL;
 	u64 delta_exec;
 
 	if (unlikely(!curr))
@@ -839,8 +875,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->exec_start = now;
 
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		__schedstats_from_sched_entity(curr, &stats);
+		__schedstat_set(stats->exec_max,
+				max(delta_exec, stats->exec_max));
+	}
 
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -867,40 +906,46 @@ static void update_curr_fair(struct rq *rq)
 static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
 	u64 wait_start, prev_wait_start;
 
 	if (!schedstat_enabled())
 		return;
 
+	__schedstats_from_sched_entity(se, &stats);
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
 
+	__schedstats_from_sched_entity(se, &stats);
+
 	/*
 	 * When the sched_schedstat changes from 0 to 1, some sched se
 	 * maybe already in the runqueue, the se->statistics.wait_start
 	 * will be 0.So it will let the delta wrong. We need to avoid this
 	 * scenario.
 	 */
-	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
+	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -910,30 +955,33 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			 * time stamp can be adjusted to accumulate wait time
 			 * prior to migration.
 			 */
-			__schedstat_set(se->statistics.wait_start, delta);
+			__schedstat_set(stats->wait_start, delta);
 			return;
 		}
 		trace_sched_stat_wait(p, delta);
 	}
 
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
+	__schedstat_set(stats->wait_max,
+		      max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
 }
 
 static inline void
 update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
 	struct task_struct *tsk = NULL;
 	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
+	__schedstats_from_sched_entity(se, &stats);
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
 
 	if (entity_is_task(se))
 		tsk = task_of(se);
@@ -944,11 +992,11 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
 
 		if (tsk) {
 			account_scheduler_latency(tsk, delta >> 10, 1);
@@ -961,16 +1009,16 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
 
 		if (tsk) {
 			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
 				trace_sched_stat_iowait(tsk, delta);
 			}
 
@@ -1029,10 +1077,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -4407,6 +4455,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
+
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -4429,8 +4479,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		__schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
+		__schedstats_from_sched_entity(se, &stats);
+		__schedstat_set(stats->slice_max,
+			max((u64)schedstat_val(stats->slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
@@ -5892,12 +5943,12 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
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
 
@@ -7570,7 +7621,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -7601,7 +7652,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -7619,12 +7670,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
index c286e5ba3c94..34ad07fb924e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1009,8 +1009,8 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cbb0b011e9e0..a0ca95d64b4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -385,6 +385,9 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+	/* schedstats of this group on each CPU */
+	struct sched_statistics **stats;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index dc218e9f4558..6c810388a897 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -41,6 +41,7 @@ rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
@@ -53,8 +54,62 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
 #endif /* CONFIG_SCHEDSTATS */
 
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SCHEDSTATS)
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
+
+		tg->stats[i] = stats;
+	}
+
+	return 1;
+}
+
+#else
+
+static inline void free_tg_schedstats(struct task_group *tg)
+{
+
+}
+
+static inline int alloc_tg_schedstats(struct task_group *tg)
+{
+	return 1;
+}
+
+#endif
+
+
 #ifdef CONFIG_PSI
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 55f39125c0e1..970266205b76 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -69,8 +69,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
-- 
2.18.2

