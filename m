Return-Path: <SRS0=SBQw=YF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9099ECE599
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Oct 2019 06:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17492089C
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Oct 2019 06:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfJLGwX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfJLGwX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 12 Oct 2019 02:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BDCD3082B02;
        Sat, 12 Oct 2019 06:52:23 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6301060A97;
        Sat, 12 Oct 2019 06:52:22 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v2 3/3] sched: migrate_enable: Use stop_one_cpu_nowait()
Date:   Sat, 12 Oct 2019 01:52:14 -0500
Message-Id: <20191012065214.28109-4-swood@redhat.com>
In-Reply-To: <20191012065214.28109-1-swood@redhat.com>
References: <20191012065214.28109-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 12 Oct 2019 06:52:23 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

migrate_enable() can be called with current->state != TASK_RUNNING.
Avoid clobbering the existing state by using stop_one_cpu_nowait().
Since we're stopping the current cpu, we know that we won't get
past __schedule() until migration_cpu_stop() has run (at least up to
the point of migrating us to another cpu).

Signed-off-by: Scott Wood <swood@redhat.com>
---
 include/linux/stop_machine.h |  2 ++
 kernel/sched/core.c          | 22 +++++++++++++---------
 kernel/stop_machine.c        |  7 +++++--
 3 files changed, 20 insertions(+), 11 deletions(-)

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
index 5cb2a519b8bf..6383ade320f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1051,6 +1051,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	bool done;
 };
 
 /*
@@ -1086,6 +1087,11 @@ static int migration_cpu_stop(void *data)
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
@@ -1108,9 +1114,9 @@ static int migration_cpu_stop(void *data)
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
@@ -7392,6 +7398,7 @@ void migrate_enable(void)
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
 		struct migration_arg arg = { p };
+		struct cpu_stop_work work;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
@@ -7399,13 +7406,10 @@ void migrate_enable(void)
 		arg.dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
-		preempt_lazy_enable();
-		preempt_enable();
-
-		sleeping_lock_inc();
-		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		sleeping_lock_dec();
-		return;
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &arg, &work);
+		__schedule(true);
+		WARN_ON_ONCE(!arg.done && !work.disabled);
 	}
 
 out:
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f..fa53a472dd44 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -85,8 +85,11 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
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
1.8.3.1

