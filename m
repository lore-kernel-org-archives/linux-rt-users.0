Return-Path: <SRS0=S77f=VY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D9C7618B
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6072D20840
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfG0F5D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbfG0F4u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC96730872C5;
        Sat, 27 Jul 2019 05:56:49 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7CDE19C71;
        Sat, 27 Jul 2019 05:56:48 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in .migrate_task_rq()
Date:   Sat, 27 Jul 2019 00:56:35 -0500
Message-Id: <20190727055638.20443-6-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 27 Jul 2019 05:56:49 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With the changes to migrate disabling, ->set_cpus_allowed() no longer
gets deferred until migrate_enable().  To avoid releasing the bandwidth
while the task may still be executing on the old CPU, move the subtraction
to ->migrate_task_rq().

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/deadline.c | 67 +++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c18be51f7608..2f18d0cf1b56 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
 	return cpu;
 }
 
+static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
+{
+	struct root_domain *src_rd = rq->rd;
+
+	/*
+	 * Migrating a SCHED_DEADLINE task between exclusive
+	 * cpusets (different root_domains) entails a bandwidth
+	 * update. We already made space for us in the destination
+	 * domain (see cpuset_can_attach()).
+	 */
+	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
+		struct dl_bw *src_dl_b;
+
+		src_dl_b = dl_bw_of(cpu_of(rq));
+		/*
+		 * We now free resources of the root_domain we are migrating
+		 * off. In the worst case, sched_setattr() may temporary fail
+		 * until we complete the update.
+		 */
+		raw_spin_lock(&src_dl_b->lock);
+		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+		raw_spin_unlock(&src_dl_b->lock);
+	}
+}
+
 static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
-	if (p->state != TASK_WAKING)
+	rq = task_rq(p);
+
+	if (p->state != TASK_WAKING) {
+		free_old_cpuset_bw_dl(rq, p);
 		return;
+	}
 
-	rq = task_rq(p);
 	/*
 	 * Since p->state == TASK_WAKING, set_task_cpu() has been called
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
@@ -2220,39 +2248,6 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	}
 }
 
-static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
-{
-	struct root_domain *src_rd;
-	struct rq *rq;
-
-	BUG_ON(!dl_task(p));
-
-	rq = task_rq(p);
-	src_rd = rq->rd;
-	/*
-	 * Migrating a SCHED_DEADLINE task between exclusive
-	 * cpusets (different root_domains) entails a bandwidth
-	 * update. We already made space for us in the destination
-	 * domain (see cpuset_can_attach()).
-	 */
-	if (!cpumask_intersects(src_rd->span, new_mask)) {
-		struct dl_bw *src_dl_b;
-
-		src_dl_b = dl_bw_of(cpu_of(rq));
-		/*
-		 * We now free resources of the root_domain we are migrating
-		 * off. In the worst case, sched_setattr() may temporary fail
-		 * until we complete the update.
-		 */
-		raw_spin_lock(&src_dl_b->lock);
-		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-		raw_spin_unlock(&src_dl_b->lock);
-	}
-
-	set_cpus_allowed_common(p, new_mask);
-}
-
 /* Assumes rq->lock is held */
 static void rq_online_dl(struct rq *rq)
 {
@@ -2407,7 +2402,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
-	.set_cpus_allowed       = set_cpus_allowed_dl,
+	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
-- 
1.8.3.1

