Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664F4C33CB6
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38440246B1
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAWUjo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgAWUjo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64952467E;
        Thu, 23 Jan 2020 20:39:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGQ-000mVT-Rv; Thu, 23 Jan 2020 15:39:42 -0500
Message-Id: <20200123203942.751467858@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:33 -0500
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
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH RT 03/30] sched/deadline: Ensure inactive_timer runs in hardirq context
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

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit ba94e7aed7405c58251b1380e6e7d73aa8284b41 ]

SCHED_DEADLINE inactive timer needs to run in hardirq context (as
dl_task_timer already does) on PREEMPT_RT

Change the mode to HRTIMER_MODE_REL_HARD.

[ tglx: Fixed up the start site, so mode debugging works ]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190731103715.4047-1-juri.lelli@redhat.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 974a8f9b615a..929167a1d991 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -287,7 +287,7 @@ static void task_non_contending(struct task_struct *p)
 
 	dl_se->dl_non_contending = 1;
 	get_task_struct(p);
-	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
+	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
 static void task_contending(struct sched_dl_entity *dl_se, int flags)
@@ -1325,7 +1325,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
-- 
2.24.1


