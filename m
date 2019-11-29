Return-Path: <SRS0=xxJu=ZV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8EC432C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 16:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153C208E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfK2QnK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:43:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49152 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2QnK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Nov 2019 11:43:10 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iajMJ-0002CQ-Gs; Fri, 29 Nov 2019 17:43:07 +0100
Date:   Fri, 29 Nov 2019 17:43:07 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Dick Hollenbeck <dick@softplc.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH] sched/core: migrate_enable() must access takedown_cpu_task
 on !HOTPLUG_CPU
Message-ID: <20191129164307.mvhdaliovxanmsf5@linutronix.de>
References: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
 <CAD56B7cgt704nWrowch8KrcT7e6ASr5Hi9FQ8-xmgztYcdceyA@mail.gmail.com>
 <adcdeaa2-69e0-9f61-35c9-888e2a281f37@softplc.com>
 <CAD56B7ej=hR0ye-ser9P3ROraBr2PJABD64K=w2XG7fwfozToQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7ej=hR0ye-ser9P3ROraBr2PJABD64K=w2XG7fwfozToQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The variable takedown_cpu_task is never declared/used on !HOTPLUG_CPU
except for migrate_enable(). This leads to a link error.

Don't use takedown_cpu_task in !HOTPLUG_CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cpu.c        | 2 ++
 kernel/sched/core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 123ad9626cc7f..81a6e5068972c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -887,7 +887,9 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT
 struct task_struct *takedown_cpu_task;
+#endif
 
 static int takedown_cpu(unsigned int cpu)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bd26257eb2358..8bea013b2baf5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8212,9 +8212,11 @@ void migrate_enable(void)
 
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
2.24.0

