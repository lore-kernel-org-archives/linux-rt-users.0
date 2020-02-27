Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CDC76575
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A801D2468F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814092;
	bh=gMfrwv6RHSJ4VB1zJJfyxToAQD1Aw5mPKIjS+nBgdHY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=t7YJKSPmDgKOVG1Ft2lf3QD89QtpLwHWJXOYI42EHSEms1+VSso4fQhoSGJdPgwkZ
	 KxtpG6zyx5/FEYQEFE28DC8R9kKJJsZtELozJ4J8QrG/LndpGcWINczLiqcjH6ghET
	 HTRCCuyjbccseSmHIdOgDZda8jNBlReza3Vu1Y9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgB0Oen (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732925AbgB0OeS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:18 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8E8246BC;
        Thu, 27 Feb 2020 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814058;
        bh=gMfrwv6RHSJ4VB1zJJfyxToAQD1Aw5mPKIjS+nBgdHY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Al50Yy0hvsU18UVtTF2Sqh0BhUul3kzNsKZq+oxHh0DLCAaMqpBW6TYQ1VcDg8wHx
         iOCpVYMTKphUs+GTDryJ4ges7Hrewr54tIsaKQ61Id/Ps9kYCtDGiCEocLfCPvDw5B
         U4vLhu0FXnDWim5JzAwVTVXbhEFfCTco5BdAl+DM=
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
Subject: [PATCH RT 19/23] sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
Date:   Thu, 27 Feb 2020 08:33:30 -0600
Message-Id: <fc234fb7e45164ddd61e0dbf1f8455a8252994c3.1582814004.git.zanussi@kernel.org>
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


[ Upstream commit a61d1977f692e46bad99a100f264981ba08cb4bd ]

The variable takedown_cpu_task is never declared/used on !HOTPLUG_CPU
except for migrate_enable(). This leads to a link error.

Don't use takedown_cpu_task in !HOTPLUG_CPU.

Reported-by: Dick Hollenbeck <dick@softplc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/cpu.c        | 2 ++
 kernel/sched/core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 17b1ed41bc06..861712ebb81d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -858,7 +858,9 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT_BASE
 struct task_struct *takedown_cpu_task;
+#endif
 
 static int takedown_cpu(unsigned int cpu)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ceddb1e27caf..e10e3956bb29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6987,9 +6987,11 @@ void migrate_enable(void)
 
 	p->migrate_disable = 0;
 	rq->nr_pinned--;
+#ifdef CONFIG_HOTPLUG_CPU
 	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
 	    takedown_cpu_task)
 		wake_up_process(takedown_cpu_task);
+#endif
 
 	if (!p->migrate_disable_scheduled)
 		goto out;
-- 
2.14.1

