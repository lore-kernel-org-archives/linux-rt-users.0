Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD2C7656E
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADDA24656
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814080;
	bh=Sy9jfvG4hbrvYVDo6cy+cJejN6vAL21ZAoPDo/x87JY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=wh6uFI+yF0E/BezTJlWjubtBWQn8V7pfhKNkxsnAuyN7l5snCTdd8uCBm1I2tX9jq
	 QpYbE1rAnbBXvyh8N/8D5chxYjgAY1i58yM3MmJrWTDuJpw6wlx0DXIMVwKxPh6Nml
	 XoqssC7uGOwymj8PRgIKynp2uWIZ5UlFj2LzXpHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgB0OeV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388319AbgB0OeU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:20 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE23246BF;
        Thu, 27 Feb 2020 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814060;
        bh=Sy9jfvG4hbrvYVDo6cy+cJejN6vAL21ZAoPDo/x87JY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SSis0gJkRwHfsbIF4u48iRggj1XnwszikkB/T8n3FHmZFGtq1zArY3Av9Zcatin5z
         QnflyxMYRE8rA0mTDbnvq7FteYAiPcT1aEWGLnGVioAFbc5sR1M+ocrccR20hmL94U
         FqMRoQawk2jrCkcdoant9DJHJx3ee3rIyk76rOMU=
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
Subject: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the migration request is completed
Date:   Thu, 27 Feb 2020 08:33:32 -0600
Message-Id: <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]

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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e10e3956bb29..f30bb249123b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7002,7 +7002,7 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { p };
+		struct migration_arg arg = { .task = p };
 		struct cpu_stop_work work;
 		struct rq_flags rf;
 
@@ -7015,7 +7015,10 @@ void migrate_enable(void)
 				    &arg, &work);
 		tlb_migrate_finish(p->mm);
 		__schedule(true);
-		WARN_ON_ONCE(!arg.done && !work.disabled);
+		if (!work.disabled) {
+			while (!arg.done)
+				cpu_relax();
+		}
 	}
 
 out:
-- 
2.14.1

