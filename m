Return-Path: <SRS0=iQLd=5C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30065C2BB1D
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 11:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A1D206EC
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 11:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQLrs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:47:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54280 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQLrs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Mar 2020 07:47:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jEAhD-0008Rw-BX; Tue, 17 Mar 2020 12:47:43 +0100
Date:   Tue, 17 Mar 2020 12:47:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Xiao <xiao.zhang@windriver.com>
Subject: [PATCH RT] tasklet: Address a race resulting in double-enqueue
Message-ID: <20200317114743.3btcqt6b2a77yhfl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Zhang Xiao <xiao.zhang@windriver.com>

The kernel bugzilla has the following race condition reported:

CPU0                    CPU1            CPU2
------------------------------------------------
test_set SCHED
 test_set RUN
   if SCHED
    add_list
    raise
    clear RUN
<softirq>
test_set RUN
test_clear SCHED
 ->func
                        test_set SCHED
tasklet_try_unlock ->0
test_clear SCHED
                                        test_set SCHED
 ->func
tasklet_try_unlock ->1
                                        test_set RUN
                                        if SCHED
                                        add list
                                        raise
                                        clear RUN
                        test_set RUN
                        if SCHED
                         add list
                         raise
                         clear RUN

As a result the tasklet is enqueued on both CPUs and run on both CPUs. Due
to the nature of the list used here, it is possible that further
(different) tasklets, which are enqueued after this double-enqueued
tasklet, are scheduled on CPU2 but invoked on CPU1. It is also possible
that these tasklets won't be invoked at all, because during the second
enqueue process the t->next pointer is set to NULL - dropping everything
from the list.

This race will trigger one or two of the WARN_ON() in
tasklet_action_common().
The problem is that the tasklet may be invoked multiple times and clear
SCHED bit on each invocation. This makes it possible to enqueue the
very same tasklet on different CPUs.

Current RT-devel is using the upstream implementation which does not
re-run tasklets if they have SCHED set again and so it does not clear
the SCHED bit multiple times on a single invocation.

Introduce the CHAINED flag. The tasklet will only be enqueued if the
CHAINED flag has been set successfully.
If it is possible to exchange the flags (CHAINED | RUN) -> 0 then the
tasklet won't be re-run. Otherwise the possible SCHED flag is removed
and the tasklet is re-run again.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61451
Not-signed-off-by: Zhang Xiao <xiao.zhang@windriver.com>
[bigeasy: patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 5 ++++-
 kernel/softirq.c          | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 97d9ba26915e8..a3b5edb26bc51 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -579,12 +579,15 @@ enum
 {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
 	TASKLET_STATE_RUN,	/* Tasklet is running (SMP only) */
-	TASKLET_STATE_PENDING	/* Tasklet is pending */
+	TASKLET_STATE_PENDING,	/* Tasklet is pending */
+	TASKLET_STATE_CHAINED	/* Tasklet is chained */
 };
 
 #define TASKLET_STATEF_SCHED	(1 << TASKLET_STATE_SCHED)
 #define TASKLET_STATEF_RUN	(1 << TASKLET_STATE_RUN)
 #define TASKLET_STATEF_PENDING	(1 << TASKLET_STATE_PENDING)
+#define TASKLET_STATEF_CHAINED	(1 << TASKLET_STATE_CHAINED)
+#define TASKLET_STATEF_RC	(TASKLET_STATEF_RUN | TASKLET_STATEF_CHAINED)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 static inline int tasklet_trylock(struct tasklet_struct *t)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 25bcf2f2714ba..73dae64bfc9c2 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -947,6 +947,10 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	 * is locked before adding it to the list.
 	 */
 	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
+			tasklet_unlock(t);
+			return;
+		}
 		t->next = NULL;
 		*head->tail = t;
 		head->tail = &(t->next);
@@ -1040,7 +1044,7 @@ static void tasklet_action_common(struct softirq_action *a,
 again:
 		t->func(t->data);
 
-		while (!tasklet_tryunlock(t)) {
+		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
 			/*
 			 * If it got disabled meanwhile, bail out:
 			 */
-- 
2.25.1

