Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95977C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7524B613FA
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhD1X3b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234298AbhD1X33 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Apr 2021 19:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619652523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8foyHQlNkbGET6ChRpZL7Zd/zRUdjQXUGk2lF+yl4Q=;
        b=Wjbaew9i8GU2fnnJezb9lS5nQcn5MLh2tQ6XZt2yvhHoV206CZTZADWn7F5RWl4P483kTf
        uo+slu/iKxfrRqsSg6pL1OEZCRkVR0rIQNYtiCTE33OWZ+fpyq+coDEsCSKjB1v86tHs83
        HsTJkanfBfGE7BOLnKB1/+n1QioqOIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-yw8Y_fgQN-K7prP6lG3Geg-1; Wed, 28 Apr 2021 19:28:39 -0400
X-MC-Unique: yw8Y_fgQN-K7prP6lG3Geg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 581BC10054F6;
        Wed, 28 Apr 2021 23:28:37 +0000 (UTC)
Received: from p1g2.redhat.com (ovpn-114-20.rdu2.redhat.com [10.10.114.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51FF161008;
        Wed, 28 Apr 2021 23:28:35 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH v2 3/3] sched/fair: break out of newidle balancing if an RT task appears
Date:   Wed, 28 Apr 2021 18:28:21 -0500
Message-Id: <20210428232821.2506201-4-swood@redhat.com>
In-Reply-To: <20210428232821.2506201-1-swood@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The CFS load balancer can take a little while, to the point of it having
a special LBF_NEED_BREAK flag, when the task moving code takes a
breather.

However, at that point it will jump right back in to load balancing,
without checking whether the CPU has gained any runnable real time
(or deadline) tasks.

Break out of load balancing in the CPU_NEWLY_IDLE case, to allow the
scheduling of the RT task.  Without this, latencies of over 1ms are
seen on large systems.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>
[swood: Limit change to newidle]
Signed-off-by: Scott Wood <swood@redhat.com>
---
v2: Only break out of newidle balancing

 kernel/sched/fair.c  | 24 ++++++++++++++++++++----
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa8c87b6aff8..c3500c963af2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9502,10 +9502,21 @@ imbalanced_active_balance(struct lb_env *env)
 	return 0;
 }
 
-static int need_active_balance(struct lb_env *env)
+static bool stop_balance_early(struct lb_env *env)
+{
+	return env->idle == CPU_NEWLY_IDLE && rq_has_higher_tasks(env->dst_rq);
+}
+
+static int need_active_balance(struct lb_env *env, int *continue_balancing)
 {
 	struct sched_domain *sd = env->sd;
 
+	/* Run the realtime task now; load balance later. */
+	if (stop_balance_early(env)) {
+		*continue_balancing = 0;
+		return 0;
+	}
+
 	if (asym_active_balance(env))
 		return 1;
 
@@ -9550,7 +9561,7 @@ static int should_we_balance(struct lb_env *env)
 	 * to do the newly idle load balance.
 	 */
 	if (env->idle == CPU_NEWLY_IDLE)
-		return 1;
+		return !rq_has_higher_tasks(env->dst_rq);
 
 	/* Try to find first idle CPU */
 	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
@@ -9660,6 +9671,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 		local_irq_restore(rf.flags);
 
+		if (stop_balance_early(&env)) {
+			*continue_balancing = 0;
+			goto out;
+		}
+
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
 			goto more_balance;
@@ -9743,7 +9759,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if (idle != CPU_NEWLY_IDLE)
 			sd->nr_balance_failed++;
 
-		if (need_active_balance(&env)) {
+		if (need_active_balance(&env, continue_balancing)) {
 			unsigned long flags;
 
 			raw_spin_lock_irqsave(&busiest->lock, flags);
@@ -9787,7 +9803,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		sd->nr_balance_failed = 0;
 	}
 
-	if (likely(!active_balance) || need_active_balance(&env)) {
+	if (likely(!active_balance) || need_active_balance(&env, continue_balancing)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..88be4ed58924 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1987,6 +1987,12 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 
 	return rq->idle_state;
 }
+
+/* Is there a task of a high priority class? */
+static inline bool rq_has_higher_tasks(struct rq *rq)
+{
+	return unlikely(rq->nr_running != rq->cfs.h_nr_running);
+}
 #else
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
-- 
2.27.0

