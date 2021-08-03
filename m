Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C898C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DEA60525
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHCWzG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:55:06 -0400
Received: from foss.arm.com ([217.140.110.172]:54960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhHCWzG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Aug 2021 18:55:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43627143B;
        Tue,  3 Aug 2021 15:54:54 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 480743F66F;
        Tue,  3 Aug 2021 15:54:52 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/2] rcutorture: Nudge ksoftirqd priority for RCU boost testing
Date:   Tue,  3 Aug 2021 23:54:37 +0100
Message-Id: <20210803225437.3612591-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803225437.3612591-1-valentin.schneider@arm.com>
References: <20210803225437.3612591-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As pointed out by commit 5e59fba573e6 ("rcutorture: Fix testing of RCU
priority boosting"), timer expiry needs to run at a priority higher than
that of the rcu_torture_boost threads (FIFO1) for RCU boost testing to
function. If that's not the case, the rcu_torture_boost threads will
prevent the wakeup of the RCU grace-period kthread, which means no boosting
will be initiated.

Instead of setting this up manually, check the priority of ksoftirqd before
starting the RCU boost test and nudge if required.

Note that this does not attempt to save and restore the scheduler
parameters of ksoftirqd.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 680f66b65f14..3dd5fa75f469 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -948,12 +948,26 @@ static int rcu_torture_boost(void *arg)
 	unsigned long endtime;
 	unsigned long oldstarttime;
 	struct rcu_boost_inflight rbi = { .inflight = 0 };
+	struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
 
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
 	sched_set_fifo_low(current);
 
+	/*
+	 * Boost testing requires TIMER_SOFTIRQ to run at a higher priority
+	 * than the CPU-hogging torture kthreads, otherwise said threads
+	 * will never let timer expiry for the RCU GP kthread happen, which will
+	 * prevent any boosting.
+	 */
+	if (current->normal_prio < ksoftirqd->normal_prio) {
+		struct sched_param sp = { .sched_priority = 2 };
+
+		pr_alert("%s(): Adjusting %s priority\n", __func__, ksoftirqd->comm);
+		sched_setscheduler_nocheck(ksoftirqd, SCHED_FIFO, &sp);
+	}
+
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
-- 
2.25.1

