Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B34C32771
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071D524682
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGKBOwvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgAXLKH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:10:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389813AbgAXLKF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 06:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579864204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=K3NBi6Sf5iK2lQ6XY2SqwGkLxd++w8nf2TJFIHAXCmc=;
        b=hGKBOwvYEEClCbhvS+zbwqTZUuc736K2vRUguzwNgiH4nrwK2K92EXHzKZeQHwlTd5so0l
        Ixj1fa23qgjQI2AtMFMLaygWwgjM8QZz9X8S9hd77kYeRz3W/WzrXVIk/jeUTLZL06Besj
        GBg+CzGS8J9rzECJ/wAAjUu3TC2wm4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-THEMo_z8NGO3QyxfJlrVUQ-1; Fri, 24 Jan 2020 06:10:02 -0500
X-MC-Unique: THEMo_z8NGO3QyxfJlrVUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32658017CC;
        Fri, 24 Jan 2020 11:10:00 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 352A219C69;
        Fri, 24 Jan 2020 11:10:00 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH 1/2] sched: migrate_enable: Use per-cpu cpu_stop_work
Date:   Fri, 24 Jan 2020 06:09:58 -0500
Message-Id: <1579864199-13036-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

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
---
 kernel/sched/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 754f6afb438d..7713e9c34ad1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8189,6 +8189,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -8227,22 +8230,25 @@ void migrate_enable(void)
 
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
 		__schedule(true);
-		if (!work.disabled) {
-			while (!arg.done)
-				cpu_relax();
-		}
 	}
 
 out:
-- 
1.8.3.1

