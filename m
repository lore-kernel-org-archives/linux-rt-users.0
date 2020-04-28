Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66277C83006
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D274206A5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGYaifW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD1FDA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:03:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgD1FCx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588050172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8AnwssMec4bN9ikPbusn6L4zc5XI0ZnQgvCyhcoSGk=;
        b=YGYaifW6b4ATZ/oqIBVgC1tIjTXdB+9T8Et7o/1SRspHf5Og00OLN3lFk5VS07bgUtS3SC
        /0aJvw0gUUmipDwGMP+wzk1/F6AIWndoAiI7IZ+jAUP+H1fb7uetNCE2+1swEkAPKF1Yr+
        EidfFU+i0xUKk2vGrKglLD1xuCZWRV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-v75qX_yPPRCpWyCxQYaKOg-1; Tue, 28 Apr 2020 01:02:47 -0400
X-MC-Unique: v75qX_yPPRCpWyCxQYaKOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4554653;
        Tue, 28 Apr 2020 05:02:46 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B6B9390;
        Tue, 28 Apr 2020 05:02:45 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Scott Wood <swood@redhat.com>
Subject: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from finish_task_switch()
Date:   Tue, 28 Apr 2020 00:02:40 -0500
Message-Id: <20200428050242.17717-2-swood@redhat.com>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
References: <20200428050242.17717-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thus, newidle_balance() is entered with interrupts enabled, which allows
(in the next patch) enabling interrupts when the lock is dropped.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c  |  7 ++++---
 kernel/sched/fair.c  | 45 ++++++++++++++++----------------------------
 kernel/sched/sched.h |  6 ++----
 3 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..0294beb8d16c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
 	}
=20
 	tick_nohz_task_switch();
+
+	if (is_idle_task(current))
+		newidle_balance();
+
 	return rq;
 }
=20
@@ -3919,8 +3923,6 @@ pick_next_task(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
 		   rq->nr_running =3D=3D rq->cfs.h_nr_running)) {
=20
 		p =3D pick_next_task_fair(rq, prev, rf);
-		if (unlikely(p =3D=3D RETRY_TASK))
-			goto restart;
=20
 		/* Assumes fair_sched_class->next =3D=3D idle_sched_class */
 		if (!p) {
@@ -3931,7 +3933,6 @@ pick_next_task(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
 		return p;
 	}
=20
-restart:
 #ifdef CONFIG_SMP
 	/*
 	 * We must do the balancing pass before put_next_task(), such
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..74c3c5280d6b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6758,8 +6758,6 @@ balance_fair(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 {
 	if (rq->nr_running)
 		return 1;
-
-	return newidle_balance(rq, rf) !=3D 0;
 }
 #endif /* CONFIG_SMP */
=20
@@ -6934,9 +6932,7 @@ pick_next_task_fair(struct rq *rq, struct task_stru=
ct *prev, struct rq_flags *rf
 	struct cfs_rq *cfs_rq =3D &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
-	int new_tasks;
=20
-again:
 	if (!sched_fair_runnable(rq))
 		goto idle;
=20
@@ -7050,19 +7046,6 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;
=20
-	new_tasks =3D newidle_balance(rq, rf);
-
-	/*
-	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
-
-	if (new_tasks > 0)
-		goto again;
-
 	/*
 	 * rq is about to be idle, check if we need to update the
 	 * lost_idle_time of clock_pelt
@@ -10425,14 +10408,23 @@ static inline void nohz_newidle_balance(struct =
rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(void)
 {
 	unsigned long next_balance =3D jiffies + HZ;
-	int this_cpu =3D this_rq->cpu;
+	int this_cpu;
 	struct sched_domain *sd;
+	struct rq *this_rq;
 	int pulled_task =3D 0;
 	u64 curr_cost =3D 0;
=20
+	preempt_disable();
+	this_rq =3D this_rq();
+	this_cpu =3D this_rq->cpu;
+	local_bh_disable();
+	raw_spin_lock_irq(&this_rq->lock);
+
+	update_rq_clock(this_rq);
+
 	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
@@ -10444,15 +10436,7 @@ int newidle_balance(struct rq *this_rq, struct r=
q_flags *rf)
 	 * Do not pull tasks towards !active CPUs...
 	 */
 	if (!cpu_active(this_cpu))
-		return 0;
-
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
+		goto out_unlock;
=20
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
 	    !READ_ONCE(this_rq->rd->overload)) {
@@ -10534,7 +10518,10 @@ int newidle_balance(struct rq *this_rq, struct r=
q_flags *rf)
 	if (pulled_task)
 		this_rq->idle_stamp =3D 0;
=20
-	rq_repin_lock(this_rq, rf);
+out_unlock:
+	raw_spin_unlock_irq(&this_rq->lock);
+	local_bh_enable();
+	preempt_enable();
=20
 	return pulled_task;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..3d97c51544d7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1504,13 +1504,13 @@ static inline void unregister_sched_domain_sysctl=
(void)
 }
 #endif
=20
-extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+extern int newidle_balance(void);
=20
 #else
=20
 static inline void sched_ttwu_pending(void) { }
=20
-static inline int newidle_balance(struct rq *this_rq, struct rq_flags *r=
f) { return 0; }
+static inline int newidle_balance(void) { return 0; }
=20
 #endif /* CONFIG_SMP */
=20
@@ -1742,8 +1742,6 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATED	0x00
 #endif
=20
-#define RETRY_TASK		((void *)-1UL)
-
 struct sched_class {
 	const struct sched_class *next;
=20
--=20
2.18.2

