Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A900C76571
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A332468F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814085;
	bh=7GtESXN04drRYoCCmcFRzXL9BHZcnKELFXz/0PkE3wE=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=KEMHCjQVFThPUYxZqd9yEuojQETLxV5vaiwC/dTVZ/884Zf5/XGOihVWp++HuLyDu
	 cS4XNAHgvWDcxLArLJ+YY8I3O7ZsBfNRAwcQCfEUH1bTg+9auySJ2V8PZnJL9WxBpY
	 5Lu/1ywCp2a6OVWp0cH1z5aB0R/t0iZLQBEZKiS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgB0Oen (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733228AbgB0OeS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:18 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3E0246A0;
        Thu, 27 Feb 2020 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814057;
        bh=7GtESXN04drRYoCCmcFRzXL9BHZcnKELFXz/0PkE3wE=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XGR2UVt0ADfUsa0M0dSPU/V9+ZZvFxLA5NAQGJU3OGo8fZuvXpgRTg5GfZSRcNigP
         hFSg2tYGNr6S3PshnkBPto0zC2AC1gN18f+Jbsp8N6qVHmLuDoDAs7DrtSRXy6TsVb
         TXvtCY+1KIZipJdd/8dte1fCI9BSqNN71q1M/vHE=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 18/23] sched: migrate_enable: Use stop_one_cpu_nowait()
Date:   Thu, 27 Feb 2020 08:33:29 -0600
Message-Id: <65505472099d581142aadd054b4e71b2b2e50cac.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 6b39a1fa8c53cae08dc03afdae193b7d3a78a173 ]

migrate_enable() can be called with current->state != TASK_RUNNING.
Avoid clobbering the existing state by using stop_one_cpu_nowait().
Since we're stopping the current cpu, we know that we won't get
past __schedule() until migration_cpu_stop() has run (at least up to
the point of migrating us to another cpu).

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
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
index 6066dc7bd7b2..ceddb1e27caf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1025,6 +1025,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	bool done;
 };
 
 /*
@@ -1060,6 +1061,11 @@ static int migration_cpu_stop(void *data)
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
@@ -1082,9 +1088,9 @@ static int migration_cpu_stop(void *data)
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
@@ -6995,6 +7001,7 @@ void migrate_enable(void)
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
 		struct migration_arg arg = { p };
+		struct cpu_stop_work work;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
@@ -7002,15 +7009,11 @@ void migrate_enable(void)
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
index 56f2f2e01229..0e2fc590ba88 100644
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
2.14.1

