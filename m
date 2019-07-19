Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19649C7618F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF221882
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfGSVuv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388771AbfGSVt7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D06218A3;
        Fri, 19 Jul 2019 21:49:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalJ-00083g-N9; Fri, 19 Jul 2019 17:49:57 -0400
Message-Id: <20190719214957.604245348@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 10/16] Revert "futex: Fix bug on when a requeued RT task times out"
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit f1a170cb3289a48df26cae3c60d77608f7a988bb ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c        | 31 +------------------------------
 kernel/locking/rtmutex_common.h |  1 -
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2a9bf2443acc..7f6f402e04ae 100644
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
@@ -2350,34 +2349,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
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
index 546aaf058b9e..a501f3b47081 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -133,7 +133,6 @@ enum rtmutex_chainwalk {
  * PI-futex support (proxy locking functions, etc.):
  */
 #define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
 
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-- 
2.20.1


