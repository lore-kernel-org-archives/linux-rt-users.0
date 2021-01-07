Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF5DC433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6713823332
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 09:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAGJKk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:10:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50912 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAGJKk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jan 2021 04:10:40 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A63DB1A0A3A;
        Thu,  7 Jan 2021 10:09:53 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 255421A0A3D;
        Thu,  7 Jan 2021 10:09:48 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0496F402D6;
        Thu,  7 Jan 2021 10:09:40 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiafei Pan <jiafei.pan@nxp.com>, linux-rt-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending too long when CPU un-plugged
Date:   Thu,  7 Jan 2021 17:18:41 +0800
Message-Id: <20210107091841.19798-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When doing CPU un-plug stress test, function smpboot_park_threads() would
get call to park kernel threads (which including ksoftirqd) on that
CPU core, and function wait_task_inactive() would yield for those queued
task(s) by calling schedule_hrtimerout() with mode of HRTIMER_MODE_REL.

stack trace:
...
smpboot_thread_fn
    cpuhp_thread_fun
        cpuhp_invoke_callback
            smpboot_park_threads
              smpboot_park_thread: ksoftirqd/1
                kthread_park
                  wait_task_inactive
                     schedule_hrtimerout

However, when PREEMPT_RT is set, this would cause a pending issue since
schedule_hrtimerout() depend on thread ksoftirqd to complete related
work if it using HRTIMER_MODE_SOFT. So force using HRTIMER_MODE_HARD
in such case.

Suggested-by: Jiafei Pan <jiafei.pan@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 792da55..4cc742a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2054,10 +2054,15 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+
+			if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+			    !strncmp(p->comm, "ksoftirqd/", 10))
+				schedule_hrtimeout(&to,
+					HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
+			else
+				schedule_hrtimeout(&to, HRTIMER_MODE_REL);
 			continue;
 		}
-
 		/*
 		 * Ahh, all good. It wasn't running, and it wasn't
 		 * runnable, which means that it will never become
-- 
2.7.4

