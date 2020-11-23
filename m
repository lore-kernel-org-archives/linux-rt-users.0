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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8DC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9634D206D9
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9BX3hPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbgKWM7p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbgKWM70 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 07:59:26 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F0C0613CF;
        Mon, 23 Nov 2020 04:59:19 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id v8so8563797vso.2;
        Mon, 23 Nov 2020 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otvHsBK309Im5qDvFzb2gsetTyToE9JqIm2soMTdgKc=;
        b=a9BX3hPRtuylw57ie+8VSJSYjteS5JLiGpzK97bXfrzcifbK594dVob++o6eKfvIPJ
         0vY2WZdC0vP/kvP8qZdW26FCfK0ZTgI136EIxKN5NqOtW4+QRxPQrGaH2eeV//rYO4Yx
         bmGE79hwyqjJbEvwjOSC8OC73W1LK29n2l5U0chP24hrUB0pLsDlnUK4lRBOyJBKklQs
         r3KXeiJe2pqocQyBvgYElIYHEPRXZ7LPPYTBBZTHTrPVzMVUBG2x+tfMjYEfyVGxrO6S
         vH2t/8JsstWj5nsqZfbCYu4YYxEUIgB4DaYeOsuDfgUvlJQ00jg2/s1RoM1xl4T7cFPD
         fegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otvHsBK309Im5qDvFzb2gsetTyToE9JqIm2soMTdgKc=;
        b=otBujbOSHRLStsJfcrWuUbwUnvgcTvdmbEaBodPYCvi4EGp3JwUENjG13eZ0hV0wa7
         C/r7GJ+eiwVyIzEeLtKd6hb59q2pcsBUQ5poGlOCbLgA+AvzgfCBobq9DSyczdBTm6W+
         8FwXIFLryDcULQyK0uwdG04YsCOwf+ZcA9m6xDknsLKqOJXsdlvM6V7IJEPUhc1GDueT
         xCLTf0a4kifPugBfMeoPBeDcoZ0fSfIIlWsvMpSJ3Ype5zfq6Y34uYe1YPptnHPUv1c4
         k0ogg3TF8VTPvOirPeoUgsOP6c3ewjScU7vRykAFObQQjYfGk4H9mzAxLx8ufRcAmc52
         u12A==
X-Gm-Message-State: AOAM533kfFyTU+F46fGSGu9I1PAPXlpwl3XPFyW9jnt74Bqnl0l1Korn
        ysBU0C3LWe4zdsxEDao8/Jg=
X-Google-Smtp-Source: ABdhPJyzwdKNtQSGxNKjIfRgUaQlIa+Mi0EKZPRjf5lpDjS0xnlzGa3djEXLu5ttt8y1kPgGLtswgQ==
X-Received: by 2002:a67:1783:: with SMTP id 125mr18926084vsx.36.1606136358803;
        Mon, 23 Nov 2020 04:59:18 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:59:18 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 5/5] sched, rt: support schedstat for RT sched class
Date:   Mon, 23 Nov 2020 20:58:08 +0800
Message-Id: <20201123125808.50896-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201123125808.50896-1-laoar.shao@gmail.com>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstat facility, but currently schedstat is only
supported for fair sched class. This patch enable it for RT sched class
as well.

The schedstat statistics are define in struct sched_entity, which is a
member of struct task_struct, so we can resue it for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
		fair				RT
enqueue		update_stats_enqueue_fair	update_stats_enqueue_rt
dequeue		update_stats_dequeue_fair	update_stats_dequeue_rt
put_prev_task	update_stats_wait_start		update_stats_wait_start
set_next_task	update_stats_wait_end		update_stats_wait_end
show		/proc/[pid]/sched		/proc/[pid]/sched

The sched:sched_stats_* tracepoints can be used to trace RT tasks as
well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/rt.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++
 2 files changed, 94 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3422dd85cfb4..f2eff92275f0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1246,6 +1246,75 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	dec_rt_group(rt_se, rt_rq);
 }
 
+#ifdef CONFIG_SCHEDSTATS
+
+static inline bool
+rt_se_is_waiting(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	return rt_se != rt_rq->curr;
+}
+
+static inline void
+rt_rq_curr_set(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	rt_rq->curr = rt_se;
+}
+
+#else
+
+static inline bool
+rt_se_is_waiting(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	return false;
+}
+
+static inline void
+rt_rq_curr_set(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+}
+
+#endif
+
+static inline void
+update_stats_enqueue_rt(struct rq *rq, struct sched_entity *se,
+			struct sched_rt_entity *rt_se, int flags)
+{
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_se_is_waiting(rt_rq, rt_se))
+		update_stats_wait_start(rq, se);
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper(rq, se);
+}
+
+static inline void
+update_stats_dequeue_rt(struct rq *rq, struct sched_entity *se,
+			struct sched_rt_entity *rt_se, int flags)
+{
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_se_is_waiting(rt_rq, rt_se))
+		update_stats_wait_end(rq, se);
+
+	if ((flags & DEQUEUE_SLEEP) && rt_entity_is_task(rt_se)) {
+		struct task_struct *tsk = rt_task_of(rt_se);
+
+		if (tsk->state & TASK_INTERRUPTIBLE)
+			__schedstat_set(se->statistics.sleep_start,
+					rq_clock(rq));
+		if (tsk->state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(se->statistics.block_start,
+					rq_clock(rq));
+	}
+}
+
 /*
  * Change rt_se->run_list location unless SAVE && !MOVE
  *
@@ -1275,6 +1344,7 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 	struct rt_prio_array *array = &rt_rq->active;
 	struct rt_rq *group_rq = group_rt_rq(rt_se);
 	struct list_head *queue = array->queue + rt_se_prio(rt_se);
+	struct task_struct *task = rt_task_of(rt_se);
 
 	/*
 	 * Don't enqueue the group if its throttled, or when empty.
@@ -1288,6 +1358,8 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 		return;
 	}
 
+	update_stats_enqueue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, flags);
+
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(rt_se->on_list);
 		if (flags & ENQUEUE_HEAD)
@@ -1307,7 +1379,9 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 	struct rt_prio_array *array = &rt_rq->active;
+	struct task_struct *task = rt_task_of(rt_se);
 
+	update_stats_dequeue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, flags);
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(!rt_se->on_list);
 		__delist_rt_entity(rt_se, array);
@@ -1374,6 +1448,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1574,6 +1649,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end(rq, &p->se);
+
 	update_stats_curr_start(rq, &p->se);
 
 	/* The running task is never eligible for pushing */
@@ -1591,6 +1672,8 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
+
+	rt_rq_curr_set(rt_rq, rt_se);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1638,6 +1721,11 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_start(rq, &p->se);
+
 	update_curr_rt(rq);
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
@@ -1648,6 +1736,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	rt_rq_curr_set(rt_rq, NULL);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3948112dc31c..a9a2f579f50c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -652,6 +652,10 @@ struct rt_rq {
 	struct rq		*rq;
 	struct task_group	*tg;
 #endif
+
+#ifdef CONFIG_SCHEDSTATS
+	struct sched_rt_entity  *curr;
+#endif
 };
 
 static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
-- 
2.18.4

