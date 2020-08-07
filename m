Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431DBC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C67122CAF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+juc2rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgHGJvr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40664 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgHGJva (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlmTabovXZ2fgjLtcolsd78Ty7R3ImRLaiM37Al4fII=;
        b=I+juc2rlm00Cyr1eiYMoJjn9yWd7i8RranJ7Pqsd5D5f06Z1IUZDjkKHb49WoShcXRmRbb
        AWJiXxC3NXLS29Adgkk5Dg5jGZsmPHRrKaOhA4b5C43Wvm6fHSdAu19qDnrHkSvhZ+XO90
        37PbTm9Tw02r0n/wO0D2gKiE/ol66P0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-mR9JUJpfMNi0aBdIQigk9Q-1; Fri, 07 Aug 2020 05:51:26 -0400
X-MC-Unique: mR9JUJpfMNi0aBdIQigk9Q-1
Received: by mail-wm1-f69.google.com with SMTP id a5so579222wmj.5
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlmTabovXZ2fgjLtcolsd78Ty7R3ImRLaiM37Al4fII=;
        b=hhWbYgwZkkOIezBTKO3Vo249uqYE2fSg2gF7xFQyDuG8kDBnTQ+kzY4mSmp1s52ahZ
         B5WCaQ2waONco+n6YXvVwE8hLnQcFkcIVIVfvojqyoQ4haVpYw5Srt7nW+raCSGezlsI
         dgH3J4VpJW8jCyqqWV+vpF+tezYK4NXGxXUDxYGerzCSjz5ndaqkzWwhyk/jphqehUuy
         yhdLyy28vEiy0Avh+NWBZbr7eaN9h4oguBg8+HJNV/euq1UGDoSSeqK1l7JaxzTAukvT
         xn753zWZN7LGP/kaBPxNb1vo0VEGt+FgMSXvlcU7zfmaxDcyUmColVB9IwDj2Qv+wOGe
         3RjA==
X-Gm-Message-State: AOAM533Iw43Vz2N9SBIrQQPoQOJrhUaAm+CpT2UjGrkU4eigWklj+fNn
        YBuk4xE/4eyaCTG+CU6JNwF4P4U/bDf8gkRwf8p1mY4ZOK6bkrwgBN+OhzHAVy2okjLX8isGfvk
        jgMQpt+da3OLTQuEAVj9BuYHvW3U=
X-Received: by 2002:adf:bc13:: with SMTP id s19mr11310634wrg.412.1596793885094;
        Fri, 07 Aug 2020 02:51:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylQnElTj7b7gZGH/WtYS0FK/MtmHyuLL9MvzxAkcJAbc6UMM9KREiGoVELmDlyGkfAE5uonQ==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr11310594wrg.412.1596793884582;
        Fri, 07 Aug 2020 02:51:24 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:23 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 3/6] sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
Date:   Fri,  7 Aug 2020 11:50:48 +0200
Message-Id: <20200807095051.385985-4-juri.lelli@redhat.com>
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

In preparation of introducing !task sched_dl_entity; move the
bandwidth accounting into {en.de}queue_dl_entity().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c | 128 ++++++++++++++++++++++------------------
 kernel/sched/sched.h    |   6 ++
 2 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8d909bdb9a119..d4007d1461522 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -275,12 +275,12 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct task_struct *p)
+static void task_non_contending(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct task_struct *p = dl_task_of(dl_se);
 	s64 zerolag_time;
 
 	/*
@@ -312,13 +312,14 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
+
 		if (!dl_task(p) || p->state == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 			if (p->state == TASK_DEAD)
-				sub_rq_bw(&p->dl, &rq->dl);
+				sub_rq_bw(dl_se, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
 			__dl_clear_params(dl_se);
 			raw_spin_unlock(&dl_b->lock);
 		}
@@ -1477,6 +1478,41 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 {
 	BUG_ON(on_dl_rq(dl_se));
 
+	/*
+	 * Check if a constrained deadline task was activated
+	 * after the deadline but before the next period.
+	 * If that is the case, the task will be throttled and
+	 * the replenishment timer will be set to the next period.
+	 */
+	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
+		dl_check_constrained_dl(dl_se);
+
+	if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		add_rq_bw(dl_se, dl_rq);
+		add_running_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
+	 * its budget it needs a replenishment and, since it now is on
+	 * its rq, the bandwidth timer callback (which clearly has not
+	 * run yet) will take care of this.
+	 * However, the active utilization does not depend on the fact
+	 * that the task is on the runqueue or not (but depends on the
+	 * task's state - in GRUB parlance, "inactive" vs "active contending").
+	 * In other words, even if a task is throttled its utilization must
+	 * be counted in the active utilization; hence, we need to call
+	 * add_running_bw().
+	 */
+	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+		if (flags & ENQUEUE_WAKEUP)
+			task_contending(dl_se, flags);
+
+		return;
+	}
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1496,9 +1532,28 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	__enqueue_dl_entity(dl_se);
 }
 
-static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	__dequeue_dl_entity(dl_se);
+
+	if (flags & (DEQUEUE_SAVE|DEQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		sub_running_bw(dl_se, dl_rq);
+		sub_rq_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * This check allows to start the inactive timer (or to immediately
+	 * decrease the active utilization, if needed) in two cases:
+	 * when the task blocks and when it is terminating
+	 * (p->state == TASK_DEAD). We can handle the two cases in the same
+	 * way, because from GRUB's point of view the same thing is happening
+	 * (the task moves from "active contending" to "active non contending"
+	 * or "inactive")
+	 */
+	if (flags & DEQUEUE_SLEEP)
+		task_non_contending(dl_se);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -1528,72 +1583,31 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	/*
-	 * Check if a constrained deadline task was activated
-	 * after the deadline but before the next period.
-	 * If that is the case, the task will be throttled and
-	 * the replenishment timer will be set to the next period.
-	 */
-	if (!p->dl.dl_throttled && !dl_is_implicit(&p->dl))
-		dl_check_constrained_dl(&p->dl);
-
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & ENQUEUE_RESTORE) {
-		add_rq_bw(&p->dl, &rq->dl);
-		add_running_bw(&p->dl, &rq->dl);
-	}
-
-	/*
-	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
-	 * its budget it needs a replenishment and, since it now is on
-	 * its rq, the bandwidth timer callback (which clearly has not
-	 * run yet) will take care of this.
-	 * However, the active utilization does not depend on the fact
-	 * that the task is on the runqueue or not (but depends on the
-	 * task's state - in GRUB parlance, "inactive" vs "active contending").
-	 * In other words, even if a task is throttled its utilization must
-	 * be counted in the active utilization; hence, we need to call
-	 * add_running_bw().
-	 */
-	if (p->dl.dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
-		if (flags & ENQUEUE_WAKEUP)
-			task_contending(&p->dl, flags);
-
-		return;
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= ENQUEUE_MIGRATING;
 
 	enqueue_dl_entity(&p->dl, pi_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
-	dequeue_dl_entity(&p->dl);
-	dequeue_pushable_dl_task(rq, p);
+	dequeue_dl_entity(&p->dl, flags);
+
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
-	__dequeue_task_dl(rq, p, flags);
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
-		sub_running_bw(&p->dl, &rq->dl);
-		sub_rq_bw(&p->dl, &rq->dl);
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= DEQUEUE_MIGRATING;
 
-	/*
-	 * This check allows to start the inactive timer (or to immediately
-	 * decrease the active utilization, if needed) in two cases:
-	 * when the task blocks and when it is terminating
-	 * (p->state == TASK_DEAD). We can handle the two cases in the same
-	 * way, because from GRUB's point of view the same thing is happening
-	 * (the task moves from "active contending" to "active non contending"
-	 * or "inactive")
-	 */
-	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(p);
+	__dequeue_task_dl(rq, p, flags);
 }
 
 /*
@@ -2373,7 +2387,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(p);
+		task_non_contending(&p->dl);
 
 	if (!task_on_rq_queued(p)) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62304d4de99cc..d3db8c7d8b641 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1741,6 +1741,10 @@ extern const u32		sched_prio_to_wmult[40];
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
  *        in the runqueue.
  *
+ * NOCLOCK - skip the update_rq_clock() (avoids double updates)
+ *
+ * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -1751,6 +1755,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_MIGRATING	0x80 /* Matches ENQUEUE_MIGRATING */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -1764,6 +1769,7 @@ extern const u32		sched_prio_to_wmult[40];
 #else
 #define ENQUEUE_MIGRATED	0x00
 #endif
+#define ENQUEUE_MIGRATING	0x80
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.26.2

