Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E2C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC65C613ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhGIWDF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhGIWDC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 18:03:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47C3613E1;
        Fri,  9 Jul 2021 22:00:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1yXh-000CKP-Va; Fri, 09 Jul 2021 18:00:17 -0400
Message-ID: <20210709220017.813653831@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 17:59:57 -0400
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
Subject: [PATCH RT 4/8] sched: Optimize migration_cpu_stop()
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

commit 3f1bc119cd7fc987c8ed25ffb717f99403bb308c upstream.

When the purpose of migration_cpu_stop() is to migrate the task to
'any' valid CPU, don't migrate the task when it's already running on a
valid CPU.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.569238629@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6880c300c624..9cbe12d8c5bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1972,14 +1972,25 @@ static int migration_cpu_stop(void *data)
 			complete = true;
 		}
 
-		if (dest_cpu < 0)
+		if (dest_cpu < 0) {
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
+				goto out;
+
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
+
 	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
-- 
2.30.2
