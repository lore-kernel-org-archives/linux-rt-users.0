Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C8C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC02184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294046;
	bh=Q7a7toSwjYlIKOOL6FEBcKtAEjui1gb9OltKjkfy2Xs=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=zxX6sMfjqRY0Tg927v9y2EwdcMg9ftJW3i0ZRpb4zvpWL9f7cc+rHnQY07HV1Bqa5
	 M5/Q2qnPVnp+m6iL5K8eehecGOkFWhmiQ2NU9qv6Qu5bl+ZmOBboCGrhB/CsPL1OhC
	 LYc1oOXAPTRmd/+4Ble8TRTvdEz/7GGqdFKI4c8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbfHHTyF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404516AbfHHTxX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:23 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C49218CA;
        Thu,  8 Aug 2019 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294002;
        bh=Q7a7toSwjYlIKOOL6FEBcKtAEjui1gb9OltKjkfy2Xs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DoavRUntlqGgywgy4o6zImzgRb7bfuBSszj5hq1AbPUwVCHWHrdFzXuUUE/5XCcbo
         wWRLhLOud3ZORva0JBmdCtWf7QE5lgBBJeSoADKSSskIu0ipWcJIhTOcmw05QMfwMT
         qj/zofc5KejJc4873SzdmM2bxU8ZQQHLEcZylr1g=
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
Subject: [PATCH RT 14/19] Revert "rtmutex: Handle the various new futex race conditions"
Date:   Thu,  8 Aug 2019 14:52:42 -0500
Message-Id: <1e48db2eb9d5da42929694bef8f158a117f28ab2.1565293934.git.zanussi@kernel.org>
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


[ Upstream commit 9e0265c21af4d6388d47dcd5ce20f76ec3a2e468 ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/futex.c                  | 77 ++++++++---------------------------------
 kernel/locking/rtmutex.c        | 36 ++++---------------
 kernel/locking/rtmutex_common.h |  2 --
 3 files changed, 21 insertions(+), 94 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 07b148ad703a..cb7e212fba0f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2165,16 +2165,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				requeue_pi_wake_futex(this, &key2, hb2);
 				drop_count++;
 				continue;
-			} else if (ret == -EAGAIN) {
-				/*
-				 * Waiter was woken by timeout or
-				 * signal and has set pi_blocked_on to
-				 * PI_WAKEUP_INPROGRESS before we
-				 * tried to enqueue it on the rtmutex.
-				 */
-				this->pi_state = NULL;
-				put_pi_state(pi_state);
-				continue;
 			} else if (ret) {
 				/*
 				 * rt_mutex_start_proxy_lock() detected a
@@ -3253,7 +3243,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb, *hb2;
+	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3311,55 +3301,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	/*
-	 * On RT we must avoid races with requeue and trying to block
-	 * on two mutexes (hb->lock and uaddr2's rtmutex) by
-	 * serializing access to pi_blocked_on with pi_lock.
-	 */
-	raw_spin_lock_irq(&current->pi_lock);
-	if (current->pi_blocked_on) {
-		/*
-		 * We have been requeued or are in the process of
-		 * being requeued.
-		 */
-		raw_spin_unlock_irq(&current->pi_lock);
-	} else {
-		/*
-		 * Setting pi_blocked_on to PI_WAKEUP_INPROGRESS
-		 * prevents a concurrent requeue from moving us to the
-		 * uaddr2 rtmutex. After that we can safely acquire
-		 * (and possibly block on) hb->lock.
-		 */
-		current->pi_blocked_on = PI_WAKEUP_INPROGRESS;
-		raw_spin_unlock_irq(&current->pi_lock);
-
-		spin_lock(&hb->lock);
-
-		/*
-		 * Clean up pi_blocked_on. We might leak it otherwise
-		 * when we succeeded with the hb->lock in the fast
-		 * path.
-		 */
-		raw_spin_lock_irq(&current->pi_lock);
-		current->pi_blocked_on = NULL;
-		raw_spin_unlock_irq(&current->pi_lock);
-
-		ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-		spin_unlock(&hb->lock);
-		if (ret)
-			goto out_put_keys;
-	}
+	spin_lock(&hb->lock);
+	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	spin_unlock(&hb->lock);
+	if (ret)
+		goto out_put_keys;
 
 	/*
-	 * In order to be here, we have either been requeued, are in
-	 * the process of being requeued, or requeue successfully
-	 * acquired uaddr2 on our behalf.  If pi_blocked_on was
-	 * non-null above, we may be racing with a requeue.  Do not
-	 * rely on q->lock_ptr to be hb2->lock until after blocking on
-	 * hb->lock or hb2->lock. The futex_requeue dropped our key1
-	 * reference and incremented our key2 reference count.
+	 * In order for us to be here, we know our q.key == key2, and since
+	 * we took the hb->lock above, we also know that futex_requeue() has
+	 * completed and we no longer have to concern ourselves with a wakeup
+	 * race with the atomic proxy lock acquisition by the requeue code. The
+	 * futex_requeue dropped our key1 reference and incremented our key2
+	 * reference count.
 	 */
-	hb2 = hash_futex(&key2);
 
 	/* Check if the requeue code acquired the second futex for us. */
 	if (!q.rt_waiter) {
@@ -3368,8 +3323,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(&hb2->lock);
-			BUG_ON(&hb2->lock != q.lock_ptr);
+			spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
 				pi_state = q.pi_state;
@@ -3380,7 +3334,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * the requeue_pi() code acquired for us.
 			 */
 			put_pi_state(q.pi_state);
-			spin_unlock(&hb2->lock);
+			spin_unlock(q.lock_ptr);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
@@ -3394,8 +3348,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		spin_lock(&hb2->lock);
-		BUG_ON(&hb2->lock != q.lock_ptr);
+		spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 62914dde3f1c..e1497623780b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -142,11 +142,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
-{
-	return waiter && waiter != PI_WAKEUP_INPROGRESS;
-}
-
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -420,8 +415,7 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return rt_mutex_real_waiter(p->pi_blocked_on) ?
-		p->pi_blocked_on->lock : NULL;
+	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -557,7 +551,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!rt_mutex_real_waiter(waiter))
+	if (!waiter)
 		goto out_unlock_pi;
 
 	/*
@@ -1340,22 +1334,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
-	/*
-	 * In the case of futex requeue PI, this will be a proxy
-	 * lock. The task will wake unaware that it is enqueueed on
-	 * this lock. Avoid blocking on two locks and corrupting
-	 * pi_blocked_on via the PI_WAKEUP_INPROGRESS
-	 * flag. futex_wait_requeue_pi() sets this when it wakes up
-	 * before requeue (due to a signal or timeout). Do not enqueue
-	 * the task if PI_WAKEUP_INPROGRESS is set.
-	 */
-	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
-		raw_spin_unlock(&task->pi_lock);
-		return -EAGAIN;
-	}
-
-       BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
-
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
@@ -1379,7 +1357,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1479,7 +1457,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock = NULL;
+	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1505,8 +1483,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	if (rt_mutex_real_waiter(owner->pi_blocked_on))
-		next_lock = task_blocked_on_lock(owner);
+	next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1542,8 +1519,7 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!rt_mutex_real_waiter(waiter) ||
-	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 53ca0242101a..2f6662d052d6 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -131,8 +131,6 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
-- 
2.14.1

