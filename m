Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6249C47082
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B8461108
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGSXI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhFGSXH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jun 2021 14:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623090075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=9ZstW4Az4zorBABR/Nkvgl7+MNQoaeykacQwAk1yjwo=;
        b=ISK12MHK0GEBkEwT9Kb2/ZMwiYnTt1sFIvBPz/SnIk+ViKFGagz2eypTriVAEBV6uJECtw
        qUczP7tl0MEuB9kjpRljU9TTfejr/ZtgLwcdcun/pVP21n1boVApLSgoNrj6K+3E1w1CRk
        S1QEaNybZQjcresdmMuYHeB9OCM9Ggg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-1mgUvy8eOMOF4FTV-c4SmQ-1; Mon, 07 Jun 2021 14:21:12 -0400
X-MC-Unique: 1mgUvy8eOMOF4FTV-c4SmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD29800FF3;
        Mon,  7 Jun 2021 18:21:10 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DD475D6D5;
        Mon,  7 Jun 2021 18:21:09 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id CEE913C0174; Mon,  7 Jun 2021 15:21:07 -0300 (-03)
Date:   Mon, 7 Jun 2021 15:21:07 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.268-rt180
Message-ID: <162308986436.368951.10865950937928205599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.268-rt180 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 638b7f082fa5d11c2b1375f9d32eca9b2d162cd9

Or to build 4.9.268-rt180 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.268.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.268-rt180.patch.xz


Enjoy!
Luis

Changes from v4.9.268-rt179:
---

Ben Hutchings (1):
      futex: Fix mis-merge of 4.9-stable changes with 4.9-rt

Luis Claudio R. Goncalves (1):
      Linux 4.9.268-rt180

Oleg Nesterov (1):
      ptrace: fix ptrace_unfreeze_traced() race with rt-lock
---
kernel/futex.c                  | 39 ++++++++++++++-------------------------
 kernel/locking/rtmutex.c        |  3 +--
 kernel/locking/rtmutex_common.h |  1 -
 kernel/ptrace.c                 | 23 +++++++++++++++--------
 localversion-rt                 |  2 +-
 5 files changed, 31 insertions(+), 37 deletions(-)
---
diff --git a/kernel/futex.c b/kernel/futex.c
index 93f2fb5b21b2d..7679831ed8094 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2465,9 +2465,9 @@ static void unqueue_me_pi(struct futex_q *q)
 static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 				  struct task_struct *argowner)
 {
-	u32 uval, uninitialized_var(curval), newval, newtid;
 	struct futex_pi_state *pi_state = q->pi_state;
 	struct task_struct *oldowner, *newowner;
+	u32 uval, curval, newval, newtid;
 	int err = 0;
 
 	oldowner = pi_state->owner;
@@ -3005,9 +3005,10 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * and BUG when futex_unlock_pi() interleaves with this.
 	 *
 	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling rt_mutex_start_proxy_lock(). This still fully
-	 * serializes against futex_unlock_pi() as that does the exact same
-	 * lock handoff sequence.
+	 * latter before calling __rt_mutex_start_proxy_lock(). This
+	 * interleaves with futex_unlock_pi() -- which does a similar lock
+	 * handoff -- such that the latter can observe the futex_q::pi_state
+	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
 	/*
@@ -3019,6 +3020,11 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	migrate_disable();
 
 	spin_unlock(q.lock_ptr);
+	/*
+	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+	 * it sees the futex_q::pi_state.
+	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
 	migrate_enable();
@@ -3037,10 +3043,10 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 cleanup:
 	spin_lock(q.lock_ptr);
 	/*
-	 * If we failed to acquire the lock (signal/timeout), we must
+	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
-	 * wait lists consistent.
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
+	 * lists consistent.
 	 *
 	 * In particular; it is important that futex_unlock_pi() can not
 	 * observe this inconsistency.
@@ -3061,13 +3067,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	if (res)
 		ret = (res < 0) ? res : 0;
 
-	/*
-	 * If fixup_owner() faulted and was unable to handle the fault, unlock
-	 * it and return the fault to userspace.
-	 */
-	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current))
-		rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
-
 	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
 
@@ -3170,7 +3169,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		migrate_disable();
 		spin_unlock(&hb->lock);
 
-		/* Drops pi_state->pi_mutex.wait_lock */
+		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
 		migrate_enable();
@@ -3460,8 +3459,6 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			spin_lock(&hb2->lock);
 			BUG_ON(&hb2->lock != q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
-			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current)
-				rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
@@ -3504,14 +3501,6 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (res)
 			ret = (res < 0) ? res : 0;
 
-		/*
-		 * If fixup_pi_state_owner() faulted and was unable to handle
-		 * the fault, unlock the rt_mutex and return the fault to
-		 * userspace.
-		 */
-		if (ret && rt_mutex_owner(pi_mutex) == current)
-			rt_mutex_futex_unlock(pi_mutex);
-
 		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
 	}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 9816892558b82..a7f971a601919 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2397,7 +2397,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
@@ -2526,7 +2526,6 @@ bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 		remove_waiter(lock, waiter);
 		cleanup = true;
 	}
-
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 750bad6849e21..98debc11953fb 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -119,7 +119,6 @@ extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct rt_mutex_waiter *waiter);
 extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 				 struct rt_mutex_waiter *waiter);
-
 extern int rt_mutex_futex_trylock(struct rt_mutex *l);
 extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 7245160f37801..809840af4ab60 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -187,8 +187,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -197,12 +197,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 326e314b799eb..bcba77f19f793 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt179
+-rt180

