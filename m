Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA611C83006
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842DA206A5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZSh3buP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgD1FCy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgD1FCx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588050172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDl3sQy2xPWoJPfIz82TdbtxPmVTWQ6/hkvqo8xQctw=;
        b=DZSh3buPl8zySt12+esayWonifd3zo9lVEU4XG8NTNU18yIZwcRZprzQJhCF6Hc0NyCvwP
        s3J3smm5zvE7kNqFqCBcFtBopVdbUzNpOC9F6UbUyaBDNC/Ys3cAB3QbRcnQoyrJY68goE
        wDfRIfvcH7uzVzGgbkI3LgVVOVE9tdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-u-q3T3I4M4aPB74SmtdMSg-1; Tue, 28 Apr 2020 01:02:49 -0400
X-MC-Unique: u-q3T3I4M4aPB74SmtdMSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D7D1895A28;
        Tue, 28 Apr 2020 05:02:48 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACA019C4F;
        Tue, 28 Apr 2020 05:02:47 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH 3/3] sched,rt: break out of load balancing if an RT task appears
Date:   Tue, 28 Apr 2020 00:02:42 -0500
Message-Id: <20200428050242.17717-4-swood@redhat.com>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
References: <20200428050242.17717-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Rik van Riel <riel@redhat.com>

Bugzilla: 1331562

The CFS load balancer can take a little while, to the point of
it having a special LBF_NEED_BREAK flag, when the task moving
code takes a breather.

However, at that point it will jump right back in to load balancing,
without checking whether the CPU has gained any runnable real time
(or deadline) tasks.

Only idle_balance used to check for runnable real time tasks on a
CPU. This patch moves that check into a separate inline function,
and calls that function in load_balance, at approximately the same
granularity that LBF_NEED_BREAK happens.

Besides breaking out of load_balance, this patch also clears
continue_balancing, in order for rebalance_domains to break out
of its loop when a realtime task becomes runnable.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 kernel/sched/fair.c  | 19 +++++++++++++++++--
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dfde7f0ce3db..e7437e4e40b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9377,10 +9377,16 @@ voluntary_active_balance(struct lb_env *env)
 	return 0;
 }
=20
-static int need_active_balance(struct lb_env *env)
+static int need_active_balance(struct lb_env *env, int *continue_balanci=
ng)
 {
 	struct sched_domain *sd =3D env->sd;
=20
+	/* Run the realtime task now; load balance later. */
+	if (rq_has_runnable_rt_task(env->dst_rq)) {
+		*continue_balancing =3D 0;
+		return 0;
+	}
+
 	if (voluntary_active_balance(env))
 		return 1;
=20
@@ -9394,6 +9400,10 @@ static int should_we_balance(struct lb_env *env)
 	struct sched_group *sg =3D env->sd->groups;
 	int cpu, balance_cpu =3D -1;
=20
+	/* Run the realtime task now; load balance later. */
+	if (rq_has_runnable_rt_task(env->dst_rq))
+		return 0;
+
 	/*
 	 * Ensure the balancing environment is consistent; can happen
 	 * when the softirq triggers 'during' hotplug.
@@ -9521,6 +9531,11 @@ static int load_balance(int this_cpu, struct rq *t=
his_rq,
=20
 		local_irq_restore(rf.flags);
=20
+		if (rq_has_runnable_rt_task(this_rq)) {
+			*continue_balancing =3D 0;
+			goto out;
+		}
+
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &=3D ~LBF_NEED_BREAK;
 			goto more_balance;
@@ -9604,7 +9619,7 @@ static int load_balance(int this_cpu, struct rq *th=
is_rq,
 		if (idle !=3D CPU_NEWLY_IDLE)
 			sd->nr_balance_failed++;
=20
-		if (need_active_balance(&env)) {
+		if (need_active_balance(&env, continue_balancing)) {
 			unsigned long flags;
=20
 			raw_spin_lock_irqsave(&busiest->lock, flags);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d97c51544d7..a2a01dfd2bea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1878,6 +1878,12 @@ static inline struct cpuidle_state *idle_get_state=
(struct rq *rq)
=20
 	return rq->idle_state;
 }
+
+/* Is there a task of a high priority class? */
+static inline bool rq_has_runnable_rt_task(struct rq *rq)
+{
+	return unlikely(rq->nr_running !=3D rq->cfs.h_nr_running);
+}
 #else
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
--=20
2.18.2

