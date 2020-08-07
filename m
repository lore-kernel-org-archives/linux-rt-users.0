Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E488C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6112177B
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMdcDvdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHGJvh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728255AbgHGJve (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pK2z2VcBLNAEzGDAQCc8iy+75f/eH9XSaSQL8jV1GDI=;
        b=bMdcDvdAqKvjc6gTObHwkRnihsCrFp26wgyW7u9XDLHPu4Kl2TY+cqoawucHnVIkmAtTSy
        TCGtUa2XHCGCBCKJgeCgzEZFwGoAxEwDGexa1mKhEUQ71qdfdwYj3D20pCAznptTD7ad9e
        A4L9aB7xjlHoKibHIzHB1T6QjeKlnHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-TuRzrmtGMkyeMWla5nE-Pg-1; Fri, 07 Aug 2020 05:51:29 -0400
X-MC-Unique: TuRzrmtGMkyeMWla5nE-Pg-1
Received: by mail-wm1-f71.google.com with SMTP id g72so449998wme.4
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pK2z2VcBLNAEzGDAQCc8iy+75f/eH9XSaSQL8jV1GDI=;
        b=rgrBqElIkssrEwuPTek6djSa54DVfx545BT/e3EnY/2LnPzmElTb9De0b4k6Vj9D0e
         29887D3ifUnSlPnwYw9o6QqT0iW+wod0bUCvIBB14IDql4v9044liaS5jbY98QttVbyq
         3+GSz80FQqeX7E0mVcnY9EAxUOY72xG+sBSfvT6F/QVKKa4u0O4jjfmDVAijymFdDcNB
         jeqEfYmNIxy8du8YSe1vePkhZXbucMIHW3GKOdOdKPAIQZw/ki/eFoE1kbBMGPLU9bpg
         t6SfH91MrfOCf5EGuUE9LWgL7Q1CewkqLxHj7mtnA6/fP7CBDzCl5qfUqVtJTgPlcHxs
         J0SA==
X-Gm-Message-State: AOAM531RmEoyJtjdrdaUxUegyI3Geq/eMEPd7P/FC+g2zcOEHEpH5Nco
        gNEcpMo/bsIxjFwwY1i9qdPhs7BhqSIhGGc1oro89UsTSm2fHyQlejwn5YpZ45CkJL4Ln4E7Zw7
        nqOpXXwoWwY3GPY/9D7YHBFQ0VFE=
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr11646252wrr.156.1596793887472;
        Fri, 07 Aug 2020 02:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu74aOFxNAtxQLC+QKzfr6Y/HgdD4DlNDRjv+xxLf6K/pB8ZzahfQJvgHJMyh9esmwBdi/Hg==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr11646210wrr.156.1596793886912;
        Fri, 07 Aug 2020 02:51:26 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:25 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 4/6] sched/deadline: Introduce deadline servers
Date:   Fri,  7 Aug 2020 11:50:49 +0200
Message-Id: <20200807095051.385985-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Low priority tasks (e.g., SCHED_OTHER) can suffer starvation if tasks
with higher priority (e.g., SCHED_FIFO) monopolize CPU(s).

RT Throttling has been introduced a while ago as a (mostly debug)
countermeasure one can utilize to reserve some CPU time for low priority
tasks (usually background type of work, e.g. workqueues, timers, etc.).
It however has its own problems (see documentation) and the undesired
effect of unconditionally throttling FIFO tasks even when no lower
priority activity needs to run (there are mechanisms to fix this issue
as well, but, again, with their own problems).

Introduce deadline servers to service low priority tasks needs under
starvation conditions. Deadline servers are built extending SCHED_DEADLINE
implementation to allow 2-level scheduling (a sched_deadline entity
becomes a container for lower priority scheduling entities).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |  26 +++-
 kernel/sched/core.c     |  17 ++
 kernel/sched/deadline.c | 336 ++++++++++++++++++++++++++--------------
 kernel/sched/fair.c     |   4 +
 kernel/sched/sched.h    |  29 ++++
 5 files changed, 298 insertions(+), 114 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f7b9ba04970bc..3ede6dd39e55e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -55,12 +55,14 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
+struct sched_dl_entity;
 struct sched_param;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct task_struct;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -501,6 +503,9 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
+typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+
 struct sched_dl_entity {
 	struct rb_node			rb_node;
 
@@ -553,6 +558,7 @@ struct sched_dl_entity {
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
+	unsigned int			dl_server         : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
@@ -567,7 +573,20 @@ struct sched_dl_entity {
 	 * timer is needed to decrease the active utilization at the correct
 	 * time.
 	 */
-	struct hrtimer inactive_timer;
+	struct hrtimer			inactive_timer;
+
+	/*
+	 * Bits for DL-server functionality. Also see the comment near
+	 * dl_server_update().
+	 *
+	 * @rq the runqueue this server is for
+	 *
+	 * @server_has_tasks() returns true if @server_pick return a
+	 * runnable task.
+	 */
+	struct rq			*rq;
+	dl_server_has_tasks_f		server_has_tasks;
+	dl_server_pick_f		server_pick;
 };
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -680,10 +699,13 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+	struct sched_dl_entity		*server;
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6b36bf82b53c2..7c471961fd0b8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3100,6 +3100,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 #endif
+
+	p->server = NULL;
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -4348,12 +4350,27 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is the fast path; it cannot be a DL server pick;
+		 * therefore even if @p == @prev, ->server must be NULL.
+		 */
+		if (p->server)
+			p->server = NULL;
+
 		return p;
 	}
 
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->server.
+	 */
+	if (prev->server)
+		prev->server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d4007d1461522..26dd82f0a586a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -20,8 +20,14 @@
 
 struct dl_bandwidth def_dl_bandwidth;
 
+static bool dl_server(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server;
+}
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
+	BUG_ON(dl_server(dl_se));
 	return container_of(dl_se, struct task_struct, dl);
 }
 
@@ -30,14 +36,22 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 	return container_of(dl_rq, struct rq, dl);
 }
 
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
+	struct rq *rq = dl_se->rq;
+
+	if (!dl_server(dl_se))
+		rq = task_rq(dl_task_of(dl_se));
 
-	return &rq->dl;
+	return rq;
 }
 
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	return &rq_of_dl_se(dl_se)->dl;
+}
+
+
 static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 {
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
@@ -278,9 +292,8 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
 static void task_non_contending(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = rq_of_dl_se(dl_se);
+	struct dl_rq *dl_rq = &rq->dl;
 	s64 zerolag_time;
 
 	/*
@@ -310,25 +323,32 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	 * utilization now, instead of starting a timer
 	 */
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
-		if (dl_task(p))
+		if (dl_server(dl_se)) {
 			sub_running_bw(dl_se, dl_rq);
+		} else {
+			struct task_struct *p = dl_task_of(dl_se);
+
+			if (dl_task(p))
+				sub_running_bw(dl_se, dl_rq);
 
-		if (!dl_task(p) || p->state == TASK_DEAD) {
-			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+			if (!dl_task(p) || p->state == TASK_DEAD) {
+				struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-			if (p->state == TASK_DEAD)
-				sub_rq_bw(dl_se, &rq->dl);
-			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
-			__dl_clear_params(dl_se);
-			raw_spin_unlock(&dl_b->lock);
+				if (p->state == TASK_DEAD)
+					sub_rq_bw(dl_se, &rq->dl);
+				raw_spin_lock(&dl_b->lock);
+				__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
+				__dl_clear_params(dl_se);
+				raw_spin_unlock(&dl_b->lock);
+			}
 		}
 
 		return;
 	}
 
 	dl_se->dl_non_contending = 1;
-	get_task_struct(p);
+	if (!dl_server(dl_se))
+		get_task_struct(dl_task_of(dl_se));
 	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
@@ -355,8 +375,10 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1)
-			put_task_struct(dl_task_of(dl_se));
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -369,10 +391,8 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 	}
 }
 
-static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
+static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	return dl_rq->root.rb_leftmost == &dl_se->rb_node;
 }
 
@@ -468,8 +488,6 @@ static void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory++;
-
-	update_dl_migration(dl_rq);
 }
 
 static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
@@ -478,8 +496,6 @@ static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory--;
-
-	update_dl_migration(dl_rq);
 }
 
 /*
@@ -680,8 +696,11 @@ static inline void deadline_queue_pull_task(struct rq *rq)
 }
 #endif /* CONFIG_SMP */
 
+static void
+enqueue_dl_entity(struct sched_dl_entity *dl_se,
+		  struct sched_dl_entity *pi_se, int flags);
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
 /*
@@ -928,8 +947,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
 static void update_dl_entity(struct sched_dl_entity *dl_se,
 			     struct sched_dl_entity *pi_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
@@ -961,11 +979,11 @@ static inline u64 dl_next_period(struct sched_dl_entity *dl_se)
  * actually started or not (i.e., the replenishment instant is in
  * the future or in the past).
  */
-static int start_dl_timer(struct task_struct *p)
+static int start_dl_timer(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->dl_timer;
-	struct rq *rq = task_rq(p);
+	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 	ktime_t now, act;
 	s64 delta;
 
@@ -999,13 +1017,33 @@ static int start_dl_timer(struct task_struct *p)
 	 * and observe our state.
 	 */
 	if (!hrtimer_is_queued(timer)) {
-		get_task_struct(p);
+		if (!dl_server(dl_se))
+			get_task_struct(dl_task_of(dl_se));
 		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
 }
 
+static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Queueing this task back might have overloaded rq, check if we need
+	 * to kick someone away.
+	 */
+	if (has_pushable_dl_tasks(rq)) {
+		/*
+		 * Nothing relies on rq->lock after this, so its safe to drop
+		 * rq->lock.
+		 */
+		rq_unpin_lock(rq, rf);
+		push_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+#endif
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1024,10 +1062,34 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     dl_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p;
 	struct rq_flags rf;
 	struct rq *rq;
 
+	if (dl_server(dl_se)) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+		if (dl_se->dl_throttled) {
+			sched_clock_tick();
+			update_rq_clock(rq);
+
+			if (dl_se->server_has_tasks(dl_se)) {
+				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
+				resched_curr(rq);
+				__push_dl_task(rq, &rf);
+			} else {
+				replenish_dl_entity(dl_se, dl_se);
+			}
+
+		}
+		rq_unlock(rq, &rf);
+
+		return HRTIMER_NORESTART;
+	}
+
+	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -1098,21 +1160,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	else
 		resched_curr(rq);
 
-#ifdef CONFIG_SMP
-	/*
-	 * Queueing this task back might have overloaded rq, check if we need
-	 * to kick someone away.
-	 */
-	if (has_pushable_dl_tasks(rq)) {
-		/*
-		 * Nothing relies on rq->lock after this, so its safe to drop
-		 * rq->lock.
-		 */
-		rq_unpin_lock(rq, &rf);
-		push_dl_task(rq);
-		rq_repin_lock(rq, &rf);
-	}
-#endif
+	__push_dl_task(rq, &rf);
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -1154,12 +1202,11 @@ static void init_dl_task_timer(struct sched_dl_entity *dl_se)
  */
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(p)))
+		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se)))
 			return;
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
@@ -1216,29 +1263,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-/*
- * Update the current task's runtime statistics (provided it is still
- * a -deadline task and has not been removed from the dl_rq).
- */
-static void update_curr_dl(struct rq *rq)
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
-	s64 delta_exec, scaled_delta_exec;
-	int cpu = cpu_of(rq);
+	s64 scaled_delta_exec;
 
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
-		return;
-
-	/*
-	 * Consumed budget is computed considering the time as
-	 * observed by schedulable tasks (excluding time spent
-	 * in hardirq context, etc.). Deadlines are instead
-	 * computed using hard walltime. This seems to be the more
-	 * natural solution, but the full ramifications of this
-	 * approach need further study.
-	 */
-	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1256,10 +1284,9 @@ static void update_curr_dl(struct rq *rq)
 	 * according to current frequency and CPU maximum capacity.
 	 */
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
-		scaled_delta_exec = grub_reclaim(delta_exec,
-						 rq,
-						 &curr->dl);
+		scaled_delta_exec = grub_reclaim(delta_exec, rq, dl_se);
 	} else {
+		int cpu = cpu_of(rq);
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
 		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
@@ -1278,11 +1305,18 @@ static void update_curr_dl(struct rq *rq)
 		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
 			dl_se->dl_overrun = 1;
 
-		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
-			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
+		dequeue_dl_entity(dl_se, 0);
+		if (!dl_server(dl_se))
+			dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
 
-		if (!is_leftmost(curr, &rq->dl))
+		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se))) {
+			if (dl_server(dl_se))
+				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
+			else
+				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
+		}
+
+		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
 	}
 
@@ -1312,20 +1346,82 @@ static void update_curr_dl(struct rq *rq)
 	}
 }
 
+void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+}
+
+void dl_server_start(struct sched_dl_entity *dl_se)
+{
+	if (!dl_server(dl_se)) {
+		dl_se->dl_server = 1;
+		setup_new_dl_entity(dl_se);
+	}
+	enqueue_dl_entity(dl_se, dl_se, ENQUEUE_WAKEUP);
+}
+
+void dl_server_stop(struct sched_dl_entity *dl_se)
+{
+	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+}
+
+void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick)
+{
+	dl_se->rq = rq;
+	dl_se->server_has_tasks = has_tasks;
+	dl_se->server_pick = pick;
+}
+
+/*
+ * Update the current task's runtime statistics (provided it is still
+ * a -deadline task and has not been removed from the dl_rq).
+ */
+static void update_curr_dl(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct sched_dl_entity *dl_se = &curr->dl;
+	s64 delta_exec;
+
+	if (!dl_task(curr) || !on_dl_rq(dl_se))
+		return;
+
+	/*
+	 * Consumed budget is computed considering the time as
+	 * observed by schedulable tasks (excluding time spent
+	 * in hardirq context, etc.). Deadlines are instead
+	 * computed using hard walltime. This seems to be the more
+	 * natural solution, but the full ramifications of this
+	 * approach need further study.
+	 */
+	delta_exec = update_curr_common(rq);
+	update_curr_dl_se(rq, dl_se, delta_exec);
+}
+
 static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 {
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     inactive_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(p, &rf);
+	if (!dl_server(dl_se)) {
+		p = dl_task_of(dl_se);
+		rq = task_rq_lock(p, &rf);
+	} else {
+		rq = dl_se->rq;
+		rq_lock(rq, &rf);
+	}
 
 	sched_clock_tick();
 	update_rq_clock(rq);
 
+	if (dl_server(dl_se))
+		goto no_task;
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1342,14 +1438,21 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 		goto unlock;
 	}
+
+no_task:
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
-	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+
+	if (!dl_server(dl_se)) {
+		task_rq_unlock(rq, p, &rf);
+		put_task_struct(p);
+	} else {
+		rq_unlock(rq, &rf);
+	}
 
 	return HRTIMER_NORESTART;
 }
@@ -1402,34 +1505,35 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 static inline void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 
+static inline void update_dl_migration(struct dl_rq *dl_rq) {}
+
 #endif /* CONFIG_SMP */
 
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
 	u64 deadline = dl_se->deadline;
 
-	WARN_ON(!dl_prio(prio));
 	dl_rq->dl_nr_running++;
 	add_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	inc_dl_deadline(dl_rq, deadline);
-	inc_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		inc_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static inline
 void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
-
-	WARN_ON(!dl_prio(prio));
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
 	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
-	dec_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		dec_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
@@ -1524,8 +1628,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se, pi_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
-		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1592,14 +1695,6 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
-{
-	dequeue_dl_entity(&p->dl, flags);
-
-	if (!p->dl.dl_throttled)
-		dequeue_pushable_dl_task(rq, p);
-}
-
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
@@ -1607,7 +1702,9 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	if (p->on_rq == TASK_ON_RQ_MIGRATING)
 		flags |= DEQUEUE_MIGRATING;
 
-	__dequeue_task_dl(rq, p, flags);
+	dequeue_dl_entity(&p->dl, flags);
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 /*
@@ -1789,12 +1886,12 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 }
 
 #ifdef CONFIG_SCHED_HRTICK
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	hrtick_start(rq, p->dl.runtime);
+	hrtick_start(rq, dl_se->runtime);
 }
 #else /* !CONFIG_SCHED_HRTICK */
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 }
 #endif
@@ -1809,9 +1906,6 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, p);
-
 	if (rq->curr->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
@@ -1835,13 +1929,30 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
 
+again:
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
-	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p, true);
+	if (dl_server(dl_se)) {
+		p = dl_se->server_pick(dl_se);
+		if (!p) {
+			// XXX should not happen, warn?!
+			dl_se->dl_yielded = 1;
+			update_curr_dl_se(rq, dl_se, 0);
+			goto again;
+		}
+		p->server = dl_se;
+	} else {
+		p = dl_task_of(dl_se);
+		set_next_task_dl(rq, p, true);
+	}
+
+	/* XXX not quite right */
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, dl_se);
+
 	return p;
 }
 
@@ -1873,8 +1984,8 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
 	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
-	    is_leftmost(p, &rq->dl))
-		start_hrtick_dl(rq, p);
+	    is_leftmost(&p->dl, &rq->dl))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static void task_fork_dl(struct task_struct *p)
@@ -2771,6 +2882,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+	dl_se->dl_server		= 0;
 }
 
 void init_dl_entity(struct sched_dl_entity *dl_se)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 10a230d85104a..5130239c0e1e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -868,6 +868,8 @@ s64 update_curr_common(struct rq *rq)
 
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
+	if (curr->server)
+		dl_server_update(curr->server, delta_exec);
 
 	return delta_exec;
 }
@@ -897,6 +899,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
+		if (curtask->server)
+			dl_server_update(curtask->server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3db8c7d8b641..f035cd8ccd224 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -346,6 +346,35 @@ extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_c
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern bool dl_cpu_busy(unsigned int cpu);
 
+/*
+ * SCHED_DEADLINE supports servers (nested scheduling) with the following
+ * interface:
+ *
+ *   dl_se::rq -- runqueue we belong to.
+ *
+ *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
+ *                                server when it runs out of tasks to run.
+ *
+ *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
+ *                           returns NULL.
+ *
+ *   dl_server_update() -- called from update_curr_common(), propagates runtime
+ *                         to the server.
+ *
+ *   dl_server_start()
+ *   dl_server_stop()  -- start/stop the server when it has (no) tasks
+ *
+ *   dl_server_init()
+ *
+ * XXX
+ */
+extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
+extern void dl_server_start(struct sched_dl_entity *dl_se);
+extern void dl_server_stop(struct sched_dl_entity *dl_se);
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
-- 
2.26.2

