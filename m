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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC3C4332F
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D5600D0
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhIEOhe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhIEOhd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72979C061575;
        Sun,  5 Sep 2021 07:36:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c17so4089067pgc.0;
        Sun, 05 Sep 2021 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WW7v+yEz4Kwl/5xSjXrMs7ysyHAEbAfgGR2qFWeYHYw=;
        b=TRfYx3k/pFPsxq2BcVNRR8q8dm8+RPgbjLAB9hnR4Pt4R4sPGdJzF47UG0a3X9UYmi
         1/yDWv8hkZv+EZauTlFhTzP5EFR4rmlaVgDqPqG0myapiVMNIMR2fMQuo9grMCM8NKNX
         yg5uzymFHUN5HxJ/FjCX9/FgjPgXuzhhJe3/lcKmyblkvTKXfs+zOwWsUB5aIP3zDu16
         CfUMw1TPCJ0BmbkS8FmIM9ee8Te+o6PlJaQ2uKEGBUQRhFhPG5EWKK952ke35Bbm4c4R
         AV+ppt681MrDXdiUycz+aazBjQtXukbnd/tyfYwvbo7nOopHij8EErOjkQZmM8qN/UEX
         M3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WW7v+yEz4Kwl/5xSjXrMs7ysyHAEbAfgGR2qFWeYHYw=;
        b=rRnQ3TBzP6HbT9DC7LfzhmXydMa7wUKjWXLFvYRd1C1oclLp208GhXUXDbT37ZyJ0Z
         c3f471GfoqVk/9ioQnK76gOMWBiwQ89PAcvOzYmjpbc3pMzcSqow6zhXjGfJHAA6b4d1
         fCIAm8Jvak2imOgpvvwh/OjLnJpru6ka9fThU55NYNTwOcr/9ebCvW6Bl/E5LVJytCXY
         xZSPlhLR2no4apsEyaVH3vhNghncTSFRLAtEGaSWzqaaZhd9PCpFhDuuCt+mNr/oX77K
         E1ZRRiZg5HqqBKtbBHo1h+qCzDblYB30s5gz77IW5azt3rqOf+G7AM/DOJhQw8yQMnLM
         tQ6A==
X-Gm-Message-State: AOAM532s2M9Rt3RMR5AfMN5SM3e5P/I1K+i/QF5uzyZ+xejh0mkEspu/
        BjhMgBO71EXZC0yGn9g5M8k=
X-Google-Smtp-Source: ABdhPJyB+uDaSMcLttmMFYtpWUIihHcdVnLIEjFJbOPIF56vdrQBHfHl/6wcUgXZf4jbuIVw/EZhjA==
X-Received: by 2002:aa7:8510:0:b0:3f8:f367:4890 with SMTP id v16-20020aa78510000000b003f8f3674890mr7827943pfn.49.1630852589994;
        Sun, 05 Sep 2021 07:36:29 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:29 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 6/8] sched, rt: support schedstats for RT sched class
Date:   Sun,  5 Sep 2021 14:35:45 +0000
Message-Id: <20210905143547.4668-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
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

schedstats is not supported for RT group.

The output of a RT task's schedstats as follows,
$ cat /proc/10349/sched
...
sum_sleep_runtime                            :           972.434535
sum_block_runtime                            :           960.433522
wait_start                                   :        188510.871584
sleep_start                                  :             0.000000
block_start                                  :             0.000000
sleep_max                                    :            12.001013
block_max                                    :           952.660622
exec_max                                     :             0.049629
slice_max                                    :             0.000000
wait_max                                     :             0.018538
wait_sum                                     :             0.424340
wait_count                                   :                   49
iowait_sum                                   :           956.495640
iowait_count                                 :                   24
nr_migrations_cold                           :                    0
nr_failed_migrations_affine                  :                    0
nr_failed_migrations_running                 :                    0
nr_failed_migrations_hot                     :                    0
nr_forced_migrations                         :                    0
nr_wakeups                                   :                   49
nr_wakeups_sync                              :                    0
nr_wakeups_migrate                           :                    0
nr_wakeups_local                             :                   49
nr_wakeups_remote                            :                    0
nr_wakeups_affine                            :                    0
nr_wakeups_affine_attempts                   :                    0
nr_wakeups_passive                           :                    0
nr_wakeups_idle                              :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well. The output of these tracepoints for a
RT tasks as follows,

- runtime
          stress-10352   [004] d.h.  1035.382286: sched_stat_runtime: comm=stress pid=10352 runtime=995769 [ns] vruntime=0 [ns]
          [vruntime=0 means it is a RT task]

- wait
          <idle>-0       [004] dN..  1227.688544: sched_stat_wait: comm=stress pid=10352 delay=46849882 [ns]

- blocked
     kworker/4:1-465     [004] dN..  1585.676371: sched_stat_blocked: comm=stress pid=17194 delay=189963 [ns]

- iowait
     kworker/4:1-465     [004] dN..  1585.675330: sched_stat_iowait: comm=stress pid=17189 delay=182848 [ns]

- sleep
           sleep-18194   [023] dN..  1780.891840: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001160770 [ns]
           sleep-18196   [023] dN..  1781.893208: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001161970 [ns]
           sleep-18197   [023] dN..  1782.894544: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001128840 [ns]
           [ In sleep.sh, it sleeps 1 sec each time. ]

[lkp@intel.com: reported build failure in earlier version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/rt.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5d251112e51c..bb945f8faeca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1273,6 +1273,112 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
+static inline struct sched_statistics *
+__schedstats_from_rt_se(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	/* schedstats is not supported for rt group. */
+	if (!rt_entity_is_task(rt_se))
+		return NULL;
+#endif
+
+	return &rt_task_of(rt_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
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
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
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
@@ -1346,6 +1452,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1356,6 +1464,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 
 	for_each_sched_rt_entity(rt_se) {
@@ -1378,6 +1488,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1578,7 +1691,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
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
@@ -1652,6 +1770,12 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
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

