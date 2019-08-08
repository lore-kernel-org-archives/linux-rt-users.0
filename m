Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E17C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1955A2189F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294044;
	bh=yKvzDmOwoP6ZRaTvyr3khS9aKMHNufX4h05g7GeRnKY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=SSLO/J/lN8CaI5RKIN3NdS6BQZll5wVskbGvPxsL9i4pc2Kb1HY2CrGndLcWoR7ns
	 SsKWrF3ARewwr2RBHE/BqpKM/nTnQ/ne6JWUEaV+XkmR456LCns+gtSFvPqCdKqG5B
	 rlT+S9iTJZ6F/8PL4xf+dFo1pgV5a5PEW0tkQvq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404530AbfHHTxY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404501AbfHHTxX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:23 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6CA218CD;
        Thu,  8 Aug 2019 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294002;
        bh=yKvzDmOwoP6ZRaTvyr3khS9aKMHNufX4h05g7GeRnKY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RhQHbrdmDul4X7nAkYO7dst2+4yNtmYeQkDgmzUMpAk76lA2Pnj04yGM5zUIAz+X8
         yI2xSZNFlrVfIbBFtl7Okl5a1Xjcd6KTRKHxVmuBFPkZTLLDoafQaQxBfTCk9NmUqS
         1eJYCjgiVW35aJBGtDtYRB15CfJptUB+bftknERY=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 13/19] Revert "futex: Fix bug on when a requeued RT task times out"
Date:   Thu,  8 Aug 2019 14:52:41 -0500
Message-Id: <050713a32b125bb79ad609c7de0de98fd52db92a.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit f1a170cb3289a48df26cae3c60d77608f7a988bb ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/locking/rtmutex.c        | 31 +------------------------------
 kernel/locking/rtmutex_common.h |  1 -
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1177f2815040..62914dde3f1c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -144,8 +144,7 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 
 static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
 {
-	return waiter && waiter != PI_WAKEUP_INPROGRESS &&
-		waiter != PI_REQUEUE_INPROGRESS;
+	return waiter && waiter != PI_WAKEUP_INPROGRESS;
 }
 
 /*
@@ -2358,34 +2357,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	/*
-	 * In PREEMPT_RT there's an added race.
-	 * If the task, that we are about to requeue, times out,
-	 * it can set the PI_WAKEUP_INPROGRESS. This tells the requeue
-	 * to skip this task. But right after the task sets
-	 * its pi_blocked_on to PI_WAKEUP_INPROGRESS it can then
-	 * block on the spin_lock(&hb->lock), which in RT is an rtmutex.
-	 * This will replace the PI_WAKEUP_INPROGRESS with the actual
-	 * lock that it blocks on. We *must not* place this task
-	 * on this proxy lock in that case.
-	 *
-	 * To prevent this race, we first take the task's pi_lock
-	 * and check if it has updated its pi_blocked_on. If it has,
-	 * we assume that it woke up and we return -EAGAIN.
-	 * Otherwise, we set the task's pi_blocked_on to
-	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
-	 * it will know that we are in the process of requeuing it.
-	 */
-	raw_spin_lock(&task->pi_lock);
-	if (task->pi_blocked_on) {
-		raw_spin_unlock(&task->pi_lock);
-		return -EAGAIN;
-	}
-	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
-	raw_spin_unlock(&task->pi_lock);
-#endif
-
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
 				      RT_MUTEX_FULL_CHAINWALK);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 2a157c78e18c..53ca0242101a 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -132,7 +132,6 @@ enum rtmutex_chainwalk {
  * PI-futex support (proxy locking functions, etc.):
  */
 #define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
 
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-- 
2.14.1

