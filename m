Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38695C76580
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7F24699
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814116;
	bh=6AMIoZ2bBZlvfbk81sl3FlnzSFeiOBjvPHt5xpK0suk=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=YHzNu2+dtaAzoofh8Ko26j7srIdP+wfsQflsF4eWsVge7184pZvVFDi1NVzr/5PRq
	 NH6WudhjbFGMeSta5cSQgZZC7lr0M3wq0v4cglHv5mNTPOzC4ZiFC8CkOSIXY6/ZFm
	 s5oZxOVdNyRm0YY9cJjzcUVejdr4osP1Q60a9cFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgB0OeI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbgB0OeH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:07 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27F5246B2;
        Thu, 27 Feb 2020 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814046;
        bh=6AMIoZ2bBZlvfbk81sl3FlnzSFeiOBjvPHt5xpK0suk=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YSxCHkxrwqDT2xtNFnJgdz0QUoX9dHAy1DzCern7GCLW+6zplRmaXCIoyz19+fA3Z
         sYLDpAdE7HJW0mv34QKAs2L8Ys8fHh7J/tL9Mg+ThBG6lUonby3/PSpN6kTqqZSQ5Z
         QPtW9Uy7eD43VVoPjmqZAX6VN6FVQ4JzEOOP6CcQ=
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
Subject: [PATCH RT 11/23] locking/rtmutex: Clean ->pi_blocked_on in the error case
Date:   Thu, 27 Feb 2020 08:33:22 -0600
Message-Id: <a0c0ec3e8c0cc01f3f495fc54d89b81e88622d18.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 0be4ea6e3ce693101be0fbd55a0cc7ce238ab2eb ]

The function rt_mutex_wait_proxy_lock() cleans ->pi_blocked_on in case
of failure (timeout, signal). The same cleanup is required in
__rt_mutex_start_proxy_lock().
In both the cases the tasks was interrupted by a signal or timeout while
acquiring the lock and after the interruption it longer blocks on the
lock.

Fixes: 1a1fb985f2e2b ("futex: Handle early deadlock return correctly")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/locking/rtmutex.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1177f2815040..4bc01a2a9a88 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2328,6 +2328,26 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
+static void fixup_rt_mutex_blocked(struct rt_mutex *lock)
+{
+	struct task_struct *tsk = current;
+	/*
+	 * RT has a problem here when the wait got interrupted by a timeout
+	 * or a signal. task->pi_blocked_on is still set. The task must
+	 * acquire the hash bucket lock when returning from this function.
+	 *
+	 * If the hash bucket lock is contended then the
+	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
+	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
+	 * clearing task->pi_blocked_on which removes the task from the
+	 * boosting chain of the rtmutex. That's correct because the task
+	 * is not longer blocked on it.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	tsk->pi_blocked_on = NULL;
+	raw_spin_unlock(&tsk->pi_lock);
+}
+
 /**
  * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
  * @lock:		the rt_mutex to take
@@ -2400,6 +2420,9 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
+
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -2480,7 +2503,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
-	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2492,23 +2514,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	 * have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
-	/*
-	 * RT has a problem here when the wait got interrupted by a timeout
-	 * or a signal. task->pi_blocked_on is still set. The task must
-	 * acquire the hash bucket lock when returning from this function.
-	 *
-	 * If the hash bucket lock is contended then the
-	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
-	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
-	 * clearing task->pi_blocked_on which removes the task from the
-	 * boosting chain of the rtmutex. That's correct because the task
-	 * is not longer blocked on it.
-	 */
-	if (ret) {
-		raw_spin_lock(&tsk->pi_lock);
-		tsk->pi_blocked_on = NULL;
-		raw_spin_unlock(&tsk->pi_lock);
-	}
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-- 
2.14.1

