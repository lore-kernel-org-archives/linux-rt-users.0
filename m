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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B9C83017
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612442084C
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEW3lBtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbgLAL4k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389039AbgLAL4k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:40 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F2C0613CF;
        Tue,  1 Dec 2020 03:55:59 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so1451190oij.6;
        Tue, 01 Dec 2020 03:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViWMHVnO4QkV2f+4zPtCPy/g805uGF4Vy6ueDDWHRXk=;
        b=MEW3lBtfEvke21o5oATpCyDtegW9Q7RlG4n8OOXhze1vaszlMfyOMWUs88yOIZAMiA
         gx1Q3tQppzDiFUf42z06BlLrNvsaHj3BD+kzvlA6XxhMwRmQpFYHdr8SrS5ioBbvzoK3
         CioQzwL4cjlE/ndmCzW+O8OoNiFTN/2GGRA9z8ZaCXXnctKIqfayU2HUwWHG2C7PZ+h+
         9fxiGDnR4/1g1JMUnoqhDwO6p7LQ6TsmvBICTbr3vXQywMlXxRumW0FCG9yo48CepzpC
         rCKXYBcqcblK+GPXvSeNMR/Obd2A9yf4CqdkZ4AZz8PEb6CeIYBp1fX4JLdUSF2yAew0
         XvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViWMHVnO4QkV2f+4zPtCPy/g805uGF4Vy6ueDDWHRXk=;
        b=XS6MNV+hKjR6s2bBn/qRiJrkWrgDK60khsemGGzzzlpUi5RSX5Wnt4oUGsIxoQAolH
         dR27sDiy7UkF/S7DRDbfVuH/MCy6FxQooMZNFcZ0XwobbcMkCO0WjduMZRHFzOmrFYaA
         mlkWxhLpajGnnd1bgjKe/5/jYupTwvbl7TxNMQWX/xAOfVLK3NFyh8M7b4gJd65NfJfw
         z21rYiPff7peII6obQUZTGp8BWx/Fwvt2lVpomHTK0e+QaSRU1SXo7wEgrWLG7az2HYM
         NJSI+9jnG/nYMcNoxbqkix962lf1ltjxi4OCKQAa6rEHtzUtt5wcvKjGTUyMAQn+Obor
         tRWA==
X-Gm-Message-State: AOAM533fmotDFsvvYmynjxPsDiaf0sNC7O2dWpovVm9uK+7BjmD6bJ2X
        35khKtEfiw+g5BPaq4feUGQ=
X-Google-Smtp-Source: ABdhPJz5CYTXbPjCN7diXrPr6clLeo2TrjxDq+z5N9LmoRSg9Cd0hUsp2sTRU3X2X+gCaBpkHrrR4Q==
X-Received: by 2002:aca:cc08:: with SMTP id c8mr1336856oig.161.1606823759140;
        Tue, 01 Dec 2020 03:55:59 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id o6sm342592oon.7.2020.12.01.03.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:55:58 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 6/6] sched, rt: support schedstats for RT sched class
Date:   Tue,  1 Dec 2020 19:54:16 +0800
Message-Id: <20201201115416.26515-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201201115416.26515-1-laoar.shao@gmail.com>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstats facility, but currently schedstats is only
supported for fair sched class. This patch enable it for RT sched class
as well.

After we make the struct sched_statistics and the helpers of it
independent of fair sched class, we can easily use the schedstats
facility for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
                fair                            RT
enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
put_prev_task   update_stats_wait_start         update_stats_wait_start
set_next_task   update_stats_wait_end           update_stats_wait_end

The user can get the schedstats information in the same way in fair sched
class. For example,
		fair				RT
task show	/proc/[pid]/sched               /proc/[pid]/sched
group show	cpu.stat in cgroup		cpu.stat in cgroup

The output of a RT task's schedstats as follows,
$ cat /proc/10461/sched
...
stats.sum_sleep_runtime                      :         37966.502936
stats.wait_start                             :             0.000000
stats.sleep_start                            :             0.000000
stats.block_start                            :        279182.986012
stats.sleep_max                              :             9.001121
stats.block_max                              :             9.292692
stats.exec_max                               :             0.090009
stats.slice_max                              :             0.000000
stats.wait_max                               :             0.005305
stats.wait_sum                               :             0.352352
stats.wait_count                             :               236173
stats.iowait_sum                             :         37875.625128
stats.iowait_count                           :               235933
stats.nr_migrations_cold                     :                    0
stats.nr_failed_migrations_affine            :                    0
stats.nr_failed_migrations_running           :                    0
stats.nr_failed_migrations_hot               :                    0
stats.nr_forced_migrations                   :                    0
stats.nr_wakeups                             :               236172
stats.nr_wakeups_sync                        :                    0
stats.nr_wakeups_migrate                     :                    2
stats.nr_wakeups_local                       :               235865
stats.nr_wakeups_remote                      :                  307
stats.nr_wakeups_affine                      :                    0
stats.nr_wakeups_affine_attempts             :                    0
stats.nr_wakeups_passive                     :                    0
stats.nr_wakeups_idle                        :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well.

The output of these tracepoints for a RT tasks as follows,

- blocked & iowait
    kworker/48:1-442     [048] d...   539.830872: sched_stat_iowait: comm=stress pid=10461 delay=158242 [ns]
    kworker/48:1-442     [048] d...   539.830872: sched_stat_blocked: comm=stress pid=10461 delay=158242 [ns]

- wait
          stress-10460   [001] dN..   813.965304: sched_stat_wait: comm=stress pid=10462 delay=99997536 [ns]
          stress-10462   [001] d.h.   813.966300: sched_stat_runtime: comm=stress pid=10462 runtime=993812 [ns] vruntime=0 [ns]
          [...]
          stress-10462   [001] d.h.   814.065300: sched_stat_runtime: comm=stress pid=10462 runtime=994484 [ns] vruntime=0 [ns]
          [ totally 100 times of sched_stat_runtime for pid 10462]
          [ The delay of pid 10462 is the sum of above runtime ]
          stress-10462   [001] dN..   814.065307: sched_stat_wait: comm=stress pid=10460 delay=100001089 [ns]
          stress-10460   [001] d.h.   814.066299: sched_stat_runtime: comm=stress pid=10460 runtime=991934 [ns] vruntime=0 [ns]

- sleep
           sleep-15582   [041] dN..  1732.814348: sched_stat_sleep: comm=sleep.sh pid=15474 delay=1001223130 [ns]
           sleep-15584   [041] dN..  1733.815908: sched_stat_sleep: comm=sleep.sh pid=15474 delay=1001238954 [ns]
           [ In sleep.sh, it sleeps 1 sec each time. ]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/rt.c | 134 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index da989653b0a2..f764c2b9070d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1271,6 +1271,121 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
+static inline void
+__schedstat_from_sched_rt_entity(struct sched_rt_entity *rt_se,
+				 struct sched_statistics **stats)
+{
+	struct task_struct *p;
+	struct task_group *tg;
+	struct rt_rq *rt_rq;
+	int cpu;
+
+	if (rt_entity_is_task(rt_se)) {
+		p = rt_task_of(rt_se);
+		*stats = &p->stats;
+	} else {
+		rt_rq = group_rt_rq(rt_se);
+		tg = rt_rq->tg;
+		cpu = cpu_of(rq_of_rt_rq(rt_rq));
+		*stats = tg->stats[cpu];
+	}
+}
+
+static inline void
+schedstat_from_sched_rt_entity(struct sched_rt_entity *rt_se,
+			       struct sched_statistics **stats)
+{
+	if (!schedstat_enabled())
+		return;
+
+	__schedstat_from_sched_rt_entity(rt_se, stats);
+}
+
+static inline void
+update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats = NULL;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	__schedstat_from_sched_rt_entity(rt_se, &stats);
+
+	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats = NULL;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	__schedstat_from_sched_rt_entity(rt_se, &stats);
+
+	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_rt(rt_rq, rt_se);
+}
+
+static inline void
+update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats = NULL;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	__schedstat_from_sched_rt_entity(rt_se, &stats);
+
+	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	if ((flags & DEQUEUE_SLEEP) && p) {
+		if (p->state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+
+		if (p->state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+	}
+}
+
 static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
@@ -1344,6 +1459,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1354,6 +1471,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
 	dequeue_rt_stack(rt_se, flags);
 
 	for_each_sched_rt_entity(rt_se) {
@@ -1376,6 +1494,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1574,9 +1695,14 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
-static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
+void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
 	p->se.exec_start = rq_clock_task(rq);
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
@@ -1640,6 +1766,12 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_start_rt(rt_rq, rt_se);
+
 	update_curr_rt(rq);
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
-- 
2.18.4

