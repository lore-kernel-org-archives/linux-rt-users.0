Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF13C55191
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADF720767
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587675278;
	bh=gyZAwgmPaK8zYXmD0ixa6pkKsbm6sspxAs1P6OP69EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=aimaePs4aogmLPI6Afg96XGTCFkL6RaAVGCE3Uu0yUVRjv/o+kR/GHDzY6j1T5UDB
	 WQ+EH62aqbvqQDNKJJ3tG/qa2hGXWg3txEVM8Qnmo7+xYl0sxNn5D0BccQLRVTpSAq
	 //JIAxlQ1cl2SvzcK8ViAC16r+6BNsWpggHaJ1x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDWUyb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUya (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 16:54:30 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B018F20776;
        Thu, 23 Apr 2020 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587675269;
        bh=gyZAwgmPaK8zYXmD0ixa6pkKsbm6sspxAs1P6OP69EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=je9RtKM0tsdF3oNGTwgp/NcFhIbZ/EMQ+J5K67tL3bmQndcXa5E3Rat87+Le6/v57
         VKFQX+scmBitD7op5+Kz2UhFaNo5lepdScTlwb8ytj6sIlruv00OWi4m3jxM+cRs5D
         5JoE9aGmdIuIFuvjds3yuIC1n+0UrlzZEYuTsP+Y=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Zhang Xiao <xiao.zhang@windriver.com>
Subject: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
Date:   Thu, 23 Apr 2020 15:54:25 -0500
Message-Id: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587675252.git.zanussi@kernel.org>
References: <cover.1587675252.git.zanussi@kernel.org>
In-Reply-To: <cover.1587675252.git.zanussi@kernel.org>
References: <cover.1587675252.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Zhang Xiao <xiao.zhang@windriver.com>

v4.19.115-rt49-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/interrupt.h | 5 ++++-
 kernel/softirq.c          | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 97d9ba26915e..a3b5edb26bc5 100644
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
index 25bcf2f2714b..73dae64bfc9c 100644
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
2.17.1

