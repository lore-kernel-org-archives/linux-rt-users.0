Return-Path: <SRS0=AM/X=2C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD2DC2D0CA
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 11:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4647922B48
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 11:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfLLL1U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:27:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45621 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLLL1U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Dec 2019 06:27:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifMcn-0002q3-Fu; Thu, 12 Dec 2019 12:27:17 +0100
Date:   Thu, 12 Dec 2019 12:27:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT] sched: migrate_enable: Busy loop until the migration
 request is completed
Message-ID: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If user task changes the CPU affinity mask of a running task it will
dispatch migration request if the current CPU is no longer allowed. This
might happen shortly before a task enters a migrate_disable() section.
Upon leaving the migrate_disable() section, the task will notice that
the current CPU is no longer allowed and will will dispatch its own
migration request to move it off the current CPU.
While invoking __schedule() the first migration request will be
processed and the task returns on the "new" CPU with "arg.done = 0". Its
own migration request will be processed shortly after and will result in
memory corruption if the stack memory, designed for request, was used
otherwise in the meantime.

Spin until the migration request has been processed if it was accepted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8bea013b2baf5..5c7be96ca68c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8227,7 +8227,7 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { p };
+		struct migration_arg arg = { .task = p };
 		struct cpu_stop_work work;
 		struct rq_flags rf;
 
@@ -8239,7 +8239,10 @@ void migrate_enable(void)
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &arg, &work);
 		__schedule(true);
-		WARN_ON_ONCE(!arg.done && !work.disabled);
+		if (!work.disabled) {
+			while (!arg.done)
+				cpu_relax();
+		}
 	}
 
 out:
-- 
2.24.0

