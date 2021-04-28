Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA4C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE3661446
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhD1X3U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhD1X3T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Apr 2021 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619652514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GRJSxYqohIAi6+ZzHY/JtjImlf9ZaUqAHDwatNr7fQ=;
        b=aalMFPp/dy8pDrisqVCr6kQBMUfGmm9C4+3GF5uaSgdhdi+SUrGvbK/fgZnU9WYacM/6mO
        CAzysbDwvgLWkVMhsswr19gW4Omo1L6NHI6HW9MSU3XYADXkqgnml3Cx9wUOD7jmCu4IGS
        wvNfHQ/j4K/RMA2UkyTWWSQdmFZgX9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-qwPpvhqmPPWhVErgTeizqQ-1; Wed, 28 Apr 2021 19:28:31 -0400
X-MC-Unique: qwPpvhqmPPWhVErgTeizqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1705F18B9F49;
        Wed, 28 Apr 2021 23:28:30 +0000 (UTC)
Received: from p1g2.redhat.com (ovpn-114-20.rdu2.redhat.com [10.10.114.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE4861094;
        Wed, 28 Apr 2021 23:28:24 +0000 (UTC)
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
Subject: [PATCH v2 1/3] sched/fair: Call newidle_balance() from balance_callback on PREEMPT_RT
Date:   Wed, 28 Apr 2021 18:28:19 -0500
Message-Id: <20210428232821.2506201-2-swood@redhat.com>
In-Reply-To: <20210428232821.2506201-1-swood@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is required in order to be able to enable interrupts in the next
patch.  This is limited to PREEMPT_RT to avoid adding potentially
measurable overhead to the non-RT case (requiring a double switch when
pulling a task onto a newly idle cpu).

update_misfit_status() is factored out for the PREEMPT_RT case, to ensure
that the misfit status is kept consistent before dropping the lock.

Signed-off-by: Scott Wood <swood@redhat.com>
---
v2: Use a balance callback, and limit to PREEMPT_RT

 kernel/sched/fair.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..ff369c38a5b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5660,6 +5660,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
+static const bool newidle_balance_in_callback = IS_ENABLED(CONFIG_PREEMPT_RT);
+static DEFINE_PER_CPU(struct callback_head, rebalance_head);
+
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
@@ -10549,7 +10552,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int do_newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -10557,7 +10560,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
-	update_misfit_status(NULL, this_rq);
+	if (!newidle_balance_in_callback)
+		update_misfit_status(NULL, this_rq);
+
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
@@ -10576,7 +10581,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 * further scheduler activity on it and we're being very careful to
 	 * re-start the picking loop.
 	 */
-	rq_unpin_lock(this_rq, rf);
+	if (!newidle_balance_in_callback)
+		rq_unpin_lock(this_rq, rf);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
 	    !READ_ONCE(this_rq->rd->overload)) {
@@ -10655,11 +10661,31 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
 
-	rq_repin_lock(this_rq, rf);
+	if (!newidle_balance_in_callback)
+		rq_repin_lock(this_rq, rf);
 
 	return pulled_task;
 }
 
+static void newidle_balance_cb(struct rq *this_rq)
+{
+	update_rq_clock(this_rq);
+	do_newidle_balance(this_rq, NULL);
+}
+
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+{
+	if (newidle_balance_in_callback) {
+		update_misfit_status(NULL, this_rq);
+		queue_balance_callback(this_rq,
+				       &per_cpu(rebalance_head, this_rq->cpu),
+				       newidle_balance_cb);
+		return 0;
+	}
+
+	return do_newidle_balance(this_rq, rf);
+}
+
 /*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
  * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
-- 
2.27.0

