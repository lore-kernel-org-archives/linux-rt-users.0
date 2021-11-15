Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE46C4321E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Nov 2021 23:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3F61B53
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Nov 2021 23:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349492AbhKOXjh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353456AbhKOXg7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Nov 2021 18:36:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5640561B60;
        Mon, 15 Nov 2021 23:34:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mmlUA-000osx-E4;
        Mon, 15 Nov 2021 18:34:02 -0500
Message-ID: <20211115233402.293121919@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Nov 2021 18:33:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 3/9] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
References: <20211115233339.509057092@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
During boot kthread_bind() is used for the creation of per-CPU threads
and then hangs in wait_task_inactive() if the ksoftirqd is not
yet up and running.
The hang disappeared since commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

but enabling function trace on boot reliably leads to the freeze on boot
behaviour again.
The timer in wait_task_inactive() can not be directly used by an user
interface to abuse it and create a mass wake of several tasks at the
same time which would to long sections with disabled interrupts.
Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.

Switch the timer to HRTIMER_MODE_REL_HARD.

Cc: stable-rt@vger.kernel.org
Link: https://lkml.kernel.org/r/20210826170408.vm7rlj7odslshwch@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f638d9420553..54fa3bb1b7c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2734,7 +2734,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
-- 
2.33.0
