Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6247C10F25
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90052084E
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCFSky (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFSkx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35803206D7;
        Fri,  6 Mar 2020 18:40:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jAHu0-002dya-4p; Fri, 06 Mar 2020 13:40:52 -0500
Message-Id: <20200306184052.026866157@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 13:40:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 2/8] sched: migrate_enable: Use per-cpu cpu_stop_work
References: <20200306184035.948924528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.106-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Scott Wood <swood@redhat.com>

[ Upstream commit 2dcd94b443c5dcbc20281666321b7f025f9cc85c ]

Commit e6c287b1512d ("sched: migrate_enable: Use stop_one_cpu_nowait()")
adds a busy wait to deal with an edge case where the migrated thread
can resume running on another CPU before the stopper has consumed
cpu_stop_work.  However, this is done with preemption disabled and can
potentially lead to deadlock.

While it is not guaranteed that the cpu_stop_work will be consumed before
the migrating thread resumes and exits the stack frame, it is guaranteed
that nothing other than the stopper can run on the old cpu between the
migrating thread scheduling out and the cpu_stop_work being consumed.
Thus, we can store cpu_stop_work in per-cpu data without it being
reused too early.

Fixes: e6c287b1512d ("sched: migrate_enable: Use stop_one_cpu_nowait()")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Scott Wood <swood@redhat.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4616c086dd26..c4290fa5c0b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7291,6 +7291,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -7329,23 +7332,26 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { .task = p };
-		struct cpu_stop_work work;
+		struct migration_arg __percpu *arg;
+		struct cpu_stop_work __percpu *work;
 		struct rq_flags rf;
 
+		work = this_cpu_ptr(&migrate_work);
+		arg = this_cpu_ptr(&migrate_arg);
+		WARN_ON_ONCE(!arg->done && !work->disabled && work->arg);
+
+		arg->task = p;
+		arg->done = false;
+
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-		arg.dest_cpu = select_fallback_rq(cpu, p);
+		arg->dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
-				    &arg, &work);
+				    arg, work);
 		tlb_migrate_finish(p->mm);
 		__schedule(true);
-		if (!work.disabled) {
-			while (!arg.done)
-				cpu_relax();
-		}
 	}
 
 out:
-- 
2.25.0


