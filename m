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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DAC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F096613AB
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhHXLbK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbhHXLbD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:31:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03641C061764;
        Tue, 24 Aug 2021 04:30:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fz10so2628499pjb.0;
        Tue, 24 Aug 2021 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BC48mUfzqeHfpAPYKOs+JM4+J7ZU0EAvwJIUR4SbHpo=;
        b=EZ9yClD57uCA8gv4I6chiV+z30+uN7w2XNNKSPeETd4xz7l3x7wEMbb5PzdD/rTGJg
         ivbBENrO7SY5paGJjTcD2pPxxIo4coTDK0M7gI1rw4LBpeKsoQKwB2Ltvo7/Q8vQX5s3
         0hrZZ/Iq2whSxE8CGVXg07+kNw2btw+UBr9aq47s3yO/rCOisWzwStkMn5FNREmSPKes
         hOnGXVDhSQKXo4qFfhB2GyHwLla+xU5lfEdszVFWEi3MSjmvvKJ+DU5TRLh7j1sB3ezF
         tvqdJG4uiLQijTO6jRSS+dGXITwZi6nQhTJF7yO2fakmoTcRC0eWOKqkdLfcX9/n0fcw
         3djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BC48mUfzqeHfpAPYKOs+JM4+J7ZU0EAvwJIUR4SbHpo=;
        b=F3ETIxIlKpqPzwvwnrcypCnK6Ciq0Iq8/CCKPeTxMakBp9M2bhxtt+RaX5UtePvRGK
         3iHEdCvnQJglEh4eGcEg9qx3KT62rP3c1r/CAADuqr90DGfTDgkhk4Zk7fqmkOaPY7OK
         6nGTQlNbxeGZf/0b6At/c2mBOj1mBNv8Es4PRJaeVo032ugyTuwp42fU7FETAF/+Of5b
         ahZn1iA1VzhX3lgww4MLwqO9IF8efoIHP3oyHhmVecQ1SqkLW3lFBf3lg1IW3fEiWrTo
         vEs5BtXaVp8py6eNIIlIACkESZjWmEj/eRIby9KPYWFXDJDuFRfRLqlOdgKvMIoh4E3P
         MKyA==
X-Gm-Message-State: AOAM5318rbAzFVpD3IzV57EHr6QaCFHoFnriwJj1Gr38KL+WPxqIS0xM
        sXAcCS0HE0/88LCOhKMpVM4=
X-Google-Smtp-Source: ABdhPJzRmtJHvQ65vG90SGgZ7YN4I3APMRiEUiz2zxmRpX0CFGNpAUStcgOK1ITQ2wH0BGj+yVqRkA==
X-Received: by 2002:a17:90a:44:: with SMTP id 4mr3859918pjb.130.1629804619503;
        Tue, 24 Aug 2021 04:30:19 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 7/7] sched, rt: support schedstats for RT sched class
Date:   Tue, 24 Aug 2021 11:29:46 +0000
Message-Id: <20210824112946.9324-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
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
                fair                        RT
enqueue         update_stats_enqueue_fair   update_stats_enqueue_rt
dequeue         update_stats_dequeue_fair   update_stats_dequeue_rt
put_prev_task   update_stats_wait_start     update_stats_wait_start_rt
set_next_task   update_stats_wait_end       update_stats_wait_end_rt

The user can get the schedstats information in the same way in fair sched
class. For example,
       fair                            RT
       /proc/[pid]/sched               /proc/[pid]/sched

The output of a RT task's schedstats as follows,
$ cat /proc/227408/sched
...
se.statistics.sum_sleep_runtime              :        402284.476088
se.statistics.sum_block_runtime              :        402272.475254
se.statistics.wait_start                     :             0.000000
se.statistics.sleep_start                    :             0.000000
se.statistics.block_start                    :      46903176.965093
se.statistics.sleep_max                      :            12.000834
se.statistics.block_max                      :          1446.963040
se.statistics.exec_max                       :             0.463806
se.statistics.slice_max                      :             0.000000
se.statistics.wait_max                       :           146.656326
se.statistics.wait_sum                       :         81741.944704
se.statistics.wait_count                     :                 1004
se.statistics.iowait_sum                     :         77875.399958
se.statistics.iowait_count                   :                  142
se.statistics.nr_migrations_cold             :                    0
se.statistics.nr_failed_migrations_affine    :                    0
se.statistics.nr_failed_migrations_running   :                    0
se.statistics.nr_failed_migrations_hot       :                    0
se.statistics.nr_forced_migrations           :                    0
se.statistics.nr_wakeups                     :                 1003
se.statistics.nr_wakeups_sync                :                    0
se.statistics.nr_wakeups_migrate             :                    0
se.statistics.nr_wakeups_local               :                  351
se.statistics.nr_wakeups_remote              :                  652
se.statistics.nr_wakeups_affine              :                    0
se.statistics.nr_wakeups_affine_attempts     :                    0
se.statistics.nr_wakeups_passive             :                    0
se.statistics.nr_wakeups_idle                :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well. The output of these tracepoints for a
RT tasks as follows,

- blocked
  kworker/u113:0-230817  [000] d... 47197.452940: sched_stat_blocked: comm=stress pid=227408 delay=4096 [ns]

- iowait
     kworker/3:1-222921  [003] d... 47492.211521: sched_stat_iowait: comm=stress pid=227408 delay=905187613 [ns]

- wait
          stress-227400  [003] d... 47202.283021: sched_stat_wait: comm=stress pid=227408 delay=67958890 [ns]

- runtime
          stress-227408  [003] d... 47202.283027: sched_stat_runtime: comm=stress pid=227408 runtime=7815 [ns] vruntime=0 [ns]

- sleep
           sleep-244868  [022] dN.. 50070.614833: sched_stat_sleep: comm=sleep.sh pid=244300 delay=1001131165 [ns]
           sleep-244869  [022] dN.. 50071.616222: sched_stat_sleep: comm=sleep.sh pid=244300 delay=1001100486 [ns]
           sleep-244879  [022] dN.. 50072.617628: sched_stat_sleep: comm=sleep.sh pid=244300 delay=1001137198 [ns]
           [ In sleep.sh, it sleeps 1 sec each time. ]

[lkp@intel.com: reported build failure in earlier version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/rt.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5d251112e51c..446164597232 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1273,6 +1273,129 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static inline void
+__schedstats_from_sched_rt_entity(struct sched_rt_entity *rt_se,
+				  struct sched_statistics **stats)
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
+#else
+
+static inline void
+__schedstats_from_sched_rt_entity(struct sched_rt_entity *rt_se,
+				  struct sched_statistics **stats)
+{
+	struct task_struct *p;
+
+	p = rt_task_of(rt_se);
+	*stats = &p->stats;
+}
+
+#endif
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
+	__schedstats_from_sched_rt_entity(rt_se, &stats);
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
+	__schedstats_from_sched_rt_entity(rt_se, &stats);
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
+	__schedstats_from_sched_rt_entity(rt_se, &stats);
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
+		unsigned int state;
+
+		state = READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+	}
+}
+
 static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
@@ -1346,6 +1469,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1356,6 +1481,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 
 	for_each_sched_rt_entity(rt_se) {
@@ -1378,6 +1505,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1578,7 +1708,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
 	p->se.exec_start = rq_clock_task(rq);
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
@@ -1652,6 +1787,12 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
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
2.18.2

