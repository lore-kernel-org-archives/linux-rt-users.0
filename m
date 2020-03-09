Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA6C10F27
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA7F20828
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783323;
	bh=mwLZ286x7XYeLHI44bgDH//pIpUrLibz0FHQxNuqI/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=KGIDqqd5SxhVBLJ229tUTDhsMwbwvR8CPqlmm4FmdpejPo83hUBi+vZ/MacFcVTgh
	 I5T0CQFuDForAPtlJyb7vAoGqbBfHeOPzo4Yt4LczkZlgBIk5hq1hnNQG63MTg/KMg
	 K7VuLkVbMgIXbllpxHITGdpQ/PNmJ42IRtvF8KWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgCITsS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCITsR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:17 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85B624654;
        Mon,  9 Mar 2020 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783296;
        bh=mwLZ286x7XYeLHI44bgDH//pIpUrLibz0FHQxNuqI/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TbOS3pSYqRKeQygu0uEMq/KK0vB1VBaL/rVOlycu2UFqMUhVHIfkOAdH7/4QiwRPD
         ig6g+KVUDhdwT73i6Vo6EtsT4z75/KCir57K7sVsAlgwrbt9oPTiY63Hnd8eDCUyr4
         pmwk/deyWoZK3IaA/LPlVNvIN0BgmG9EbRDBQ2us=
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
Cc:     Scott Wood <swood@redhat.com>
Subject: [PATCH RT 2/8] sched: migrate_enable: Use per-cpu cpu_stop_work
Date:   Mon,  9 Mar 2020 14:47:47 -0500
Message-Id: <22f22176ee9dae01a6f45d9f0064a1a1e9f913a5.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
---
 kernel/sched/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f30bb249123b5..960daa6bc7f04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6964,6 +6964,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -7002,23 +7005,26 @@ void migrate_enable(void)
 
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
2.14.1

