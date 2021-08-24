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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD7C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A272661184
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHXLay (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhHXLar (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37DC0613CF;
        Tue, 24 Aug 2021 04:30:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h1so8177574pjs.2;
        Tue, 24 Aug 2021 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJRc1IGJooe37yaS2cWWgxiC9DlWZ8UbzXcrx731grY=;
        b=cwpkkKBKNcpT9gyT7cAOEDs4gJcYgc2LKIItlK7xwjFEx2oaujeJdjMlMTRk7u4jHj
         rZ5Ix0CYoM1M2KVp/y/0lc59pLjzO3JKi2FSZmMlqdStJA9zbjPAFWE8hNMk1JzvDrsP
         c8nW342MylykES6i+VHwjjKoE2g/d3qd5N/i0DB55x56jbMmIoNjx279/Im/W2cs8ALa
         gC6qC5JOM7UjI1hPhTGPFUadx+xXi0Au2e3G3NNV4xl1VmfZLWmxFXpoGU+RdyoidUnZ
         NHoS7koyn0WpLsu2q7jOjo9Ju+Ms4hLvnKzgZqLIYEVpR6r07LkXsjtGWiQWmtdX7eFp
         7Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJRc1IGJooe37yaS2cWWgxiC9DlWZ8UbzXcrx731grY=;
        b=iRo3ZyFEKctAzTJCyAZRUHCLt21LqxXcGXZbK4r4QPr1y1ivV8WKGjcbD7ibJ0u9KC
         RVXRq5ixR+PVGzl3bfLBczzFMKLtXfu0u5GlOjkwLsdp+Z3mubuRJ51HAEjPnpfa7TQt
         tld/+yGc/OhBPRJ6SaVmJJKXbVkQ0YfV1rVN6SkSzcOiwJv2yHB269n2jfD0WcLnBcSz
         TXJkUBa+ZFfwX0BFH2nfM7ZH/lhjZjF+yu+IsO6mwbgGpYZIsxVxR8rpbkmlk6aQi/5x
         RR/RiWksiwIRRL0AxN5g6zQKy5o9CMGpEj69pOfpiMV7NGcaIkagrhc42eukmHt0K2SR
         1k0w==
X-Gm-Message-State: AOAM530JKz8xXGht6vuWkn/2AKqxVtFPgenR9cmNYmyFXGNc1nrc3YJ7
        DyST6aJf/0ffDNlBrzhv5Js=
X-Google-Smtp-Source: ABdhPJwsFd+YmgIHw1zPjLXo5hHIbX66/OHhAzv+zrWoj4eRZl4fxFBZHhUui6XbZzXjoq7mVfdDUg==
X-Received: by 2002:a17:902:edd0:b0:135:b351:bd5a with SMTP id q16-20020a170902edd000b00135b351bd5amr4721611plk.52.1629804602752;
        Tue, 24 Aug 2021 04:30:02 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:02 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/7] sched: make struct sched_statistics independent of fair sched class
Date:   Tue, 24 Aug 2021 11:29:41 +0000
Message-Id: <20210824112946.9324-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
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
                                  Before               After
      kernel.sched_schedstats=0  ~5.6                 ~5.6
      kernel.sched_schedstats=1  ~5.7                 ~5.7
[These data is a little difference with the prev version, that is
 because my old test machine is destroyed so I have to use a new
 different test machine.]

Almost no impact on the sched performance.

No functional change.

[lkp@intel.com: reported build failure in earlier version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: kernel test robot <lkp@intel.com>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 include/linux/sched.h    |   5 +-
 kernel/sched/core.c      |  24 ++++----
 kernel/sched/deadline.c  |   4 +-
 kernel/sched/debug.c     |  90 +++++++++++++++--------------
 kernel/sched/fair.c      | 121 ++++++++++++++++++++++++++++-----------
 kernel/sched/rt.c        |   4 +-
 kernel/sched/sched.h     |   3 +
 kernel/sched/stats.h     |  55 ++++++++++++++++++
 kernel/sched/stop_task.c |   4 +-
 9 files changed, 212 insertions(+), 98 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f43fb7a32a9c..39c29eae1af9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -521,7 +521,7 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 #endif
-};
+} ____cacheline_aligned;
 
 struct sched_entity {
 	/* For load-balancing: */
@@ -537,8 +537,6 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -775,6 +773,7 @@ struct task_struct {
 	unsigned int			rt_priority;
 
 	const struct sched_class	*sched_class;
+	struct sched_statistics         stats;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21d633971fcf..38bb7afb396c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3489,11 +3489,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
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
@@ -3505,14 +3505,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
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
@@ -4196,7 +4196,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -9608,9 +9608,9 @@ void normalize_rt_tasks(void)
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
@@ -9700,6 +9700,7 @@ static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
+	free_tg_schedstats(tg);
 	autogroup_free(tg);
 	kmem_cache_free(task_group_cache, tg);
 }
@@ -9719,6 +9720,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_tg_schedstats(tg))
+		goto err;
+
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -10456,7 +10460,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		int i;
 
 		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			ws += schedstat_val(tg->stats[i]->wait_sum);
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e94314633b39..51dd30990042 100644
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
index 49716228efb4..4cfee2aa1a2d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -442,9 +442,11 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	struct sched_entity *se = tg->se[cpu];
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
+		"se->statistics."#F, (long long)schedstat_val(tg->stats[cpu]->F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
+		"se->statistics."#F, SPLIT_NS((long long)schedstat_val(tg->stats[cpu]->F)))
 
 	if (!se)
 		return;
@@ -454,16 +456,16 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
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
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
 	}
 
 	P(se->load.weight);
@@ -530,9 +532,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		p->prio);
 
 	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -948,8 +950,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		"---------------------------------------------------------"
 		"----------\n");
 
-#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
-#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
+#define P_SCHEDSTAT(F)  __PS("se.statistics."#F, schedstat_val(p->stats.F))
+#define PN_SCHEDSTAT(F) __PSN("se.statistics."#F, schedstat_val(p->stats.F))
 
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -962,33 +964,33 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
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
+		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
+		PN_SCHEDSTAT(iowait_sum);
+		P_SCHEDSTAT(iowait_count);
+		P_SCHEDSTAT(nr_migrations_cold);
+		P_SCHEDSTAT(nr_failed_migrations_affine);
+		P_SCHEDSTAT(nr_failed_migrations_running);
+		P_SCHEDSTAT(nr_failed_migrations_hot);
+		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_wakeups);
+		P_SCHEDSTAT(nr_wakeups_sync);
+		P_SCHEDSTAT(nr_wakeups_migrate);
+		P_SCHEDSTAT(nr_wakeups_local);
+		P_SCHEDSTAT(nr_wakeups_remote);
+		P_SCHEDSTAT(nr_wakeups_affine);
+		P_SCHEDSTAT(nr_wakeups_affine_attempts);
+		P_SCHEDSTAT(nr_wakeups_passive);
+		P_SCHEDSTAT(nr_wakeups_idle);
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
@@ -1054,7 +1056,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 422426768b84..7cb802431cfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -819,6 +819,41 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
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
@@ -826,6 +861,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
+	struct sched_statistics *stats = NULL;
 	u64 delta_exec;
 
 	if (unlikely(!curr))
@@ -837,8 +873,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
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
@@ -865,40 +904,46 @@ static void update_curr_fair(struct rq *rq)
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
@@ -908,30 +953,33 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -942,11 +990,11 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -959,16 +1007,16 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
 
@@ -1030,10 +1078,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		/* XXX racy against TTWU */
 		state = READ_ONCE(tsk->__state);
 		if (state & TASK_INTERRUPTIBLE)
-			__schedstat_set(se->statistics.sleep_start,
+			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		if (state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(se->statistics.block_start,
+			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
 }
@@ -4478,6 +4526,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats = NULL;
+
 	clear_buddies(cfs_rq, se);
 
 	/* 'current' is not kept within the tree. */
@@ -4502,8 +4552,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
 
@@ -5993,12 +6044,12 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
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
 
@@ -7802,7 +7853,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -7836,7 +7887,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -7858,12 +7909,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
index 3daf42a0f462..95a7c3ad2dc3 100644
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
index e6347c88c467..6a4541d7d659 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,9 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+	/* schedstats of this group on each CPU */
+	struct sched_statistics **stats;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d8f8eb0c655b..e6905e369c5d 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -41,6 +41,7 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
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
index f988ebe3febb..0b165a25f22f 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
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

