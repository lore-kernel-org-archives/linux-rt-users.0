Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D574C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A6360F23
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhHaKpu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbhHaKpt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 06:45:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D6C061575;
        Tue, 31 Aug 2021 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fcq0Vj8dz4GfpImmXhE/w+/OCqqc9iyFgNrysUGvKgY=; b=rFZhxj9FaxRd5jlpzADAkSh+FQ
        2T2vZQCrxN6sH/vERrmZzU6bZ3+Mu4B3Fh6cGRpn5e0rVrW0huU9Gh0eiOtnVAc6gnp4venls+6Bk
        Mor7TBXFEW46m+nsJolC0zEifUguyCetEZSceLkjrqVBzuQ50Br03kMaT0+jGTsEhgvU6m5u+sAtd
        hpbqxcAwF46mm2zKsGaW6vQzgpYgfLpCYQ7iJBBO+OwfsQY7M1Z9Mx4+G1mdYdQ9tQ57dGX2eJ/Qp
        IzNDXj9iXOX9A9d0GWWOX7VEntc0TzoreZyDCrH3Qkeu1MJcmP6PVs7eoeYdx5V/jnR6qvZqYOeZs
        xG34pQKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL1Fs-00Eg7q-Sc; Tue, 31 Aug 2021 10:44:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFF73300109;
        Tue, 31 Aug 2021 12:44:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 904732C7E2CC8; Tue, 31 Aug 2021 12:44:35 +0200 (CEST)
Date:   Tue, 31 Aug 2021 12:44:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 0/7] sched: support schedstats for RT sched class
Message-ID: <YS4IE1Dxf0ite81A@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
 <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 31, 2021 at 12:08:15PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 24, 2021 at 11:29:39AM +0000, Yafang Shao wrote:

> > After the patchset, schestats are orgnized as follows,
> > struct task_struct {
> >     ...
> >     struct sched_statistics statistics;
> >     ...
> >     struct sched_entity *se;
> >     struct sched_rt_entity *rt;
> >     ...
> > };
> > 
> > struct task_group {                    |---> stats[0] : of CPU0
> >     ...                                |
> >     struct sched_statistics **stats; --|---> stats[1] : of CPU1
> >     ...                                |
> >                                        |---> stats[n] : of CPUn
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >     struct sched_entity **se;
> >  #endif
> >  #ifdef CONFIG_RT_GROUP_SCHED
> >     struct sched_rt_entity  **rt_se;
> >  #endif
> >     ...
> > };
> 
> Yeah, this seems to give a terrible mess, let me see if I can come up
> with anything less horrible.

Here, isn't this *MUCH* saner ?

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
@@ -802,6 +800,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	struct sched_statistics         stats;
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3489,11 +3489,11 @@ ttwu_stat(struct task_struct *p, int cpu
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
@@ -3505,14 +3505,14 @@ ttwu_stat(struct task_struct *p, int cpu
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
@@ -4196,7 +4196,7 @@ static void __sched_fork(unsigned long c
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -9619,9 +9619,9 @@ void normalize_rt_tasks(void)
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
@@ -10467,7 +10467,7 @@ static int cpu_cfs_stat_show(struct seq_
 		int i;
 
 		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			ws += schedstat_val(tg->stats[i]->wait_sum);
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1265,8 +1265,8 @@ static void update_curr_dl(struct rq *rq
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -819,6 +819,21 @@ static void update_tg_load_avg(struct cf
 }
 #endif /* CONFIG_SMP */
 
+struct sched_entity_stats {
+	struct sched_entity	se;
+	struct sched_statistics	stats;
+} __no_randomize_layout;
+
+static inline struct sched_statistics *
+__schedstats_from_se(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!entity_is_task(se))
+		return &container_of(se, struct sched_entity_stats, se)->stats;
+#endif
+	return &task_of(se)->stats;
+}
+
 /*
  * Update the current task's runtime statistics.
  */
@@ -837,8 +852,10 @@ static void update_curr(struct cfs_rq *c
 
 	curr->exec_start = now;
 
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		struct sched_statistics *stats = __schedstats_from_se(curr);
+		__schedstat_set(stats->exec_max, max(delta_exec, stats->exec_max));
+	}
 
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -866,39 +883,45 @@ static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 wait_start, prev_wait_start;
+	struct sched_statistics *stats;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
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
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
 	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
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
@@ -908,30 +931,33 @@ update_stats_wait_end(struct cfs_rq *cfs
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
+	struct sched_statistics *stats;
 	struct task_struct *tsk = NULL;
 	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
+	stats = __schedstats_from_se(se);
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
 
 	if (entity_is_task(se))
 		tsk = task_of(se);
@@ -942,11 +968,11 @@ update_stats_enqueue_sleeper(struct cfs_
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
@@ -959,16 +985,16 @@ update_stats_enqueue_sleeper(struct cfs_
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
 
@@ -1030,10 +1056,10 @@ update_stats_dequeue(struct cfs_rq *cfs_
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
@@ -4502,9 +4528,10 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		__schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
-			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
+		struct sched_statistics *stats = __schedstats_from_se(se);
+		__schedstat_set(stats->slice_max,
+				max((u64)stats->slice_max,
+				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
@@ -5993,12 +6020,12 @@ static int wake_affine(struct sched_doma
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
 
@@ -7802,7 +7829,7 @@ int can_migrate_task(struct task_struct
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -7836,7 +7863,7 @@ int can_migrate_task(struct task_struct
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -7858,12 +7885,12 @@ int can_migrate_task(struct task_struct
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
 
@@ -11390,7 +11417,7 @@ int alloc_fair_sched_group(struct task_g
 		if (!cfs_rq)
 			goto err;
 
-		se = kzalloc_node(sizeof(struct sched_entity),
+		se = kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1009,8 +1009,8 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -41,6 +41,7 @@ rq_sched_info_dequeue(struct rq *rq, uns
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
@@ -53,6 +54,7 @@ static inline void rq_sched_info_depart
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_PSI
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
