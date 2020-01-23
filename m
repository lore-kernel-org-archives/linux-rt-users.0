Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71219C33CAF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B38E24691
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgAWUkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgAWUjr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC92524693;
        Thu, 23 Jan 2020 20:39:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGT-000mfd-SX; Thu, 23 Jan 2020 15:39:45 -0500
Message-Id: <20200123203945.766477535@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>, Scott Wood <swood@redhat.com>
Subject: [PATCH RT 24/30] sched: migrate_enable: Use stop_one_cpu_nowait()
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Scott Wood <swood@redhat.com>

[ Upstream commit 6b39a1fa8c53cae08dc03afdae193b7d3a78a173 ]

migrate_enable() can be called with current->state != TASK_RUNNING.
Avoid clobbering the existing state by using stop_one_cpu_nowait().
Since we're stopping the current cpu, we know that we won't get
past __schedule() until migration_cpu_stop() has run (at least up to
the point of migrating us to another cpu).

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/stop_machine.h |  2 ++
 kernel/sched/core.c          | 23 +++++++++++++----------
 kernel/stop_machine.c        |  7 +++++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbe..82fc686ddd9e 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -26,6 +26,8 @@ struct cpu_stop_work {
 	cpu_stop_fn_t		fn;
 	void			*arg;
 	struct cpu_stop_done	*done;
+	/* Did not run due to disabled stopper; for nowait debug checks */
+	bool			disabled;
 };
 
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e97ac751aad2..e465381b464d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -990,6 +990,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	bool done;
 };
 
 /*
@@ -1025,6 +1026,11 @@ static int migration_cpu_stop(void *data)
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	int dest_cpu = arg->dest_cpu;
+
+	/* We don't look at arg after this point. */
+	smp_mb();
+	arg->done = true;
 
 	/*
 	 * The original target CPU might have gone down and we might
@@ -1047,9 +1053,9 @@ static int migration_cpu_stop(void *data)
 	 */
 	if (task_rq(p) == rq) {
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
-			p->wake_cpu = arg->dest_cpu;
+			p->wake_cpu = dest_cpu;
 	}
 	rq_unlock(rq, &rf);
 	raw_spin_unlock(&p->pi_lock);
@@ -7322,6 +7328,7 @@ void migrate_enable(void)
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
 		struct migration_arg arg = { p };
+		struct cpu_stop_work work;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
@@ -7329,15 +7336,11 @@ void migrate_enable(void)
 		arg.dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
-		preempt_lazy_enable();
-		preempt_enable();
-
-		sleeping_lock_inc();
-		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		sleeping_lock_dec();
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &arg, &work);
 		tlb_migrate_finish(p->mm);
-
-		return;
+		__schedule(true);
+		WARN_ON_ONCE(!arg.done && !work.disabled);
 	}
 
 out:
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 067cb83f37ea..2d15c0d50625 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -86,8 +86,11 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work, &wakeq);
-	else if (work->done)
-		cpu_stop_signal_done(work->done);
+	else {
+		work->disabled = true;
+		if (work->done)
+			cpu_stop_signal_done(work->done);
+	}
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
-- 
2.24.1


