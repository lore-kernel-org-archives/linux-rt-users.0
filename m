Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29901C11F6B
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0401961414
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhGIWDE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhGIWDC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 18:03:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B309B613CA;
        Fri,  9 Jul 2021 22:00:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1yXh-000CJr-PW; Fri, 09 Jul 2021 18:00:17 -0400
Message-ID: <20210709220017.632244614@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 17:59:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH RT 3/8] sched: Collate affine_move_task() stoppers
References: <20210709215953.122804544@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.47-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 58b1a45086b5f80f2b2842aa7ed0da51a64a302b upstream.

The SCA_MIGRATE_ENABLE and task_running() cases are almost identical,
collapse them to avoid further duplication.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.500108964@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d497b13efb53..6880c300c624 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2275,30 +2275,23 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {
-- 
2.30.2
