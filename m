Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB3C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1F761A0D
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhC0KO1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhC0KOY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:14:24 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4903C0613B1;
        Sat, 27 Mar 2021 03:14:23 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dc12so4244614qvb.4;
        Sat, 27 Mar 2021 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yf69iFiJtCw/IzfPF2Ay7ufynUhDqTGUs6lw9ppor50=;
        b=VNPAm/hv1sPuVF0s2HCiYGrcGEqEZq+BZpiMZ6iWXKzuIy0/aXpLpEsY30F17j2PvO
         Lara+5WPGiBY8lYZzVhiUfofqWARxzOGhzEXC826O/pSrfSFJ0ly3GWPIaBrclUIR2+C
         gEYCgxz8szp4u+9NTXFjulF4qtElToVaB5eoXs4lScxBZTvsQHoZpwcKbm7VboXi0L2k
         M4zezh6xJxdMl4bXRj28CuEko3bbZUimaLS4d4YBgTgFHvshavsGTkZZ7kQLlJfxJ92+
         0yLOwMUUYfRROmLqdSZwhNQmcCXmRPbpqUftmMce+ShkdSka7snpqKf2uUAFA7ATEmOA
         1Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf69iFiJtCw/IzfPF2Ay7ufynUhDqTGUs6lw9ppor50=;
        b=loXY7E53azjmZEnHSS/61+BGXy+IrJkKKi0L+If4SF7AjpxLKTn0bDLVLztitlgfGi
         H1iCVynSsG1eqATrfyBl3bl5no6tByXg+7e1T4khW6oHSSlzKHuXfGROOsvn/+tSaMYp
         Aw/Fac+X0h59TgYo61STWlv0dOyMSqDbnun9lwV/7XHRZ7BWpXjsCjrP2gm17NtWU1AA
         T9rGV2gIobCzbfQJMP6CuRucNk6K23gdVXYMP23eH8Sz7sM497Hb7jmk1QxIC4PjNAYm
         aKfIrd01lC+josXMWsAHFsNWi1m6QIAkm+gcBuldRCE8PbCNspj/+uBYGN1FrUXtUyNH
         pWfg==
X-Gm-Message-State: AOAM533pXvOnT3ccx/jJBj5Y5yKlgI9fv5w548TZXc5//mqtDlcnD7li
        gQdz/gVKw/7ebLle4RuLuJU=
X-Google-Smtp-Source: ABdhPJxXo15+vU3cx2WoCYzeyEiTjTA8LG6/Hz6F1CSuTpGEa+69Xc6PkqQlBHmKlk0NGXYcBLCb3g==
X-Received: by 2002:ad4:5887:: with SMTP id dz7mr17658183qvb.12.1616840063059;
        Sat, 27 Mar 2021 03:14:23 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.14.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:14:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 6/6] sched, rt: support schedstats for RT sched class
Date:   Sat, 27 Mar 2021 18:12:53 +0800
Message-Id: <20210327101254.56872-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
References: <20210327101254.56872-1-laoar.shao@gmail.com>
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
                    Interface File
  task schedstats : /proc/[pid]/sched
  group schedstats: /proc/sched_debug

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well. The output of these tracepoints for a
RT tasks as follows,

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

[lkp@intel.com: reported build failure in prev version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: kernel test robot <lkp@intel.com>
---
 kernel/sched/rt.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ae5282484710..e5f706ffcdbc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1273,6 +1273,125 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
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
@@ -1346,6 +1465,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1356,6 +1477,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 
 	for_each_sched_rt_entity(rt_se) {
@@ -1378,6 +1501,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1578,7 +1704,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
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
@@ -1642,6 +1773,12 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
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

