Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C1DC47082
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFF16127C
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEaVat (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 17:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhEaVaq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 17:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622496546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3G+tak1oB/Ueukgrnfm7HbGiH6sVyxPuqRZwncdpvaQ=;
        b=Ja9JuZnhYsN5mjniRemfbLXDQykkLWoaaUHwxknviBiyCajTm6Gw2puwIcRhUXb/v/17IS
        vtqHSF8Tik+S4rKBcUQqaC2OhJkWx42AEwuChf9uZfxVlxwY9km3ObvU2Ye+a3rfFsURcy
        SmBjHt3AtvG2E99LdyD7uYaRXV2KErI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-IJOO6qE_Nu6bMIQ_f5nUYw-1; Mon, 31 May 2021 17:29:04 -0400
X-MC-Unique: IJOO6qE_Nu6bMIQ_f5nUYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22D280ED8D;
        Mon, 31 May 2021 21:29:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE274166CA;
        Mon, 31 May 2021 21:29:01 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 198F53C016F; Mon, 31 May 2021 18:29:00 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 1/3] futex: Fix mis-merge of 4.9-stable changes with 4.9-rt
Date:   Mon, 31 May 2021 18:28:58 -0300
Message-Id: <20210531212900.37969-2-lgoncalv@redhat.com>
In-Reply-To: <20210531212900.37969-1-lgoncalv@redhat.com>
References: <20210531212900.37969-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

v4.9.268-rt180-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


The recent merges of futex changes from 4.9-stable into the 4.9-rt
tree effectively reverted:

* The deletion of calls to rt_mutex_futex_unlock() from futex_lock_pi()
  and futex_wait_requeue_pi() by commit b960d9ae7f76 "futex: Handle
  faults correctly for PI futexes".

* The deletion of uninitialized_var() by commit 48ab8e8e4059 "futex:
  Simplify fixup_pi_state_owner()".

* Commit c59b46c53fa1 "rtmutex: Handle non enqueued waiters gracefully".

Restore those changes.

Also resolve some other cosmetic differences from the 4.9-stable
version of futex.c and rtmutex_common.h due to slightly different
backports.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/futex.c                  | 39 ++++++++++++---------------------
 kernel/locking/rtmutex.c        |  3 +--
 kernel/locking/rtmutex_common.h |  1 -
 3 files changed, 15 insertions(+), 28 deletions(-)

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
 
-- 
2.31.1

