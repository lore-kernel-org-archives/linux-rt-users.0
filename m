Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F73C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Sep 2021 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C28360FDA
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Sep 2021 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348994AbhICKEg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348929AbhICKEf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Sep 2021 06:04:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D347C061575;
        Fri,  3 Sep 2021 03:03:35 -0700 (PDT)
Date:   Fri, 3 Sep 2021 12:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630663413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8odQuRIiNmimnCVq/uA6lVwCG7drjg1Ctrghf7N9w4s=;
        b=u1sNFGkuN88aZrSguXUryDfGPhlQdkQvKtMMNwtlTMQZh+VgE9eHbP71VvN9Xk+h6Xy0NW
        4Q8m1Q5onfxKnTDsK44UhjNzV0Ke9DAQ4RaPzTLkiZwhfr4ByNiAX7kfV+MSctumcaEnDZ
        eWYAkl5iN7a0h2TrD/klNNS17/INHCPaBHQtn+Wg6KrSim3KP3JcaYU/7tvZCfv6C6Vurr
        WHVBTQt7fgNsyFIGoRAQV4q+3B2L/NY9Jf/h6VVKA4ngsY9OZzvpIKOstRUhqRi/LlZqxk
        dk2tTmQhfBUNDcg/Kyfvj+/J+W54hiJZwXTT5/u7RpuJR3IY529MOd96XA2u9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630663413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8odQuRIiNmimnCVq/uA6lVwCG7drjg1Ctrghf7N9w4s=;
        b=2qmDkkFlx7NtE9H3V4GJCyyHtibGfDoJQJ36siNcK9BtMewm93ippVVjUME6zLKMdACLu2
        e8jYF4+GWWQLK2Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rt17
Message-ID: <20210903100331.zadkeppw7wnwa6md@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rt17 patch set. 

Changes since v5.14-rt16:

  - Teach lockdep to recognize read-locks on configurations without QRW
    locks.

  - Various futex patches addressing fallout reported by syzbot caused
    by the locking rework. Patches by Thomas Gleixner.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rt17

The RT patch against v5.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rt17.tar.xz

Sebastian

diff --git a/kernel/futex.c b/kernel/futex.c
index e7b4c6121da4e..a316dce74c3db 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1263,6 +1263,36 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	return -ESRCH;
 }
 
+static void __attach_to_pi_owner(struct task_struct *p, union futex_key *key,
+				 struct futex_pi_state **ps)
+{
+	/*
+	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
+	 */
+	struct futex_pi_state *pi_state = alloc_pi_state();
+
+	/*
+	 * Initialize the pi_mutex in locked state and make @p
+	 * the owner of it:
+	 */
+	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
+
+	/* Store the key for possible exit cleanups: */
+	pi_state->key = *key;
+
+	WARN_ON(!list_empty(&pi_state->list));
+	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
+	pi_state->owner = p;
+
+	*ps = pi_state;
+}
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
@@ -1272,7 +1302,6 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 			      struct task_struct **exiting)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
-	struct futex_pi_state *pi_state;
 	struct task_struct *p;
 
 	/*
@@ -1324,36 +1353,11 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return ret;
 	}
 
-	/*
-	 * No existing pi state. First waiter. [2]
-	 *
-	 * This creates pi_state, we have hb->lock held, this means nothing can
-	 * observe this state, wait_lock is irrelevant.
-	 */
-	pi_state = alloc_pi_state();
-
-	/*
-	 * Initialize the pi_mutex in locked state and make @p
-	 * the owner of it:
-	 */
-	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
-
-	/* Store the key for possible exit cleanups: */
-	pi_state->key = *key;
-
-	WARN_ON(!list_empty(&pi_state->list));
-	list_add(&pi_state->list, &p->pi_state_list);
-	/*
-	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
-	 * because there is no concurrency as the object is not published yet.
-	 */
-	pi_state->owner = p;
+	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	put_task_struct(p);
 
-	*ps = pi_state;
-
 	return 0;
 }
 
@@ -1454,8 +1458,26 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 			newval |= FUTEX_WAITERS;
 
 		ret = lock_pi_update_atomic(uaddr, uval, newval);
-		/* If the take over worked, return 1 */
-		return ret < 0 ? ret : 1;
+		if (ret)
+			return ret;
+
+		/*
+		 * If the waiter bit was requested the caller also needs PI
+		 * state attached to the new owner of the user space futex.
+		 *
+		 * @task is guaranteed to be alive and it cannot be exiting
+		 * because it is either sleeping or waiting in
+		 * futex_requeue_pi_wakeup_sync().
+		 *
+		 * No need to do the full attach_to_pi_owner() exercise
+		 * because @task is known and valid.
+		 */
+		if (set_waiters) {
+			raw_spin_lock_irq(&task->pi_lock);
+			__attach_to_pi_owner(task, key, ps);
+			raw_spin_unlock_irq(&task->pi_lock);
+		}
+		return 1;
 	}
 
 	/*
@@ -1939,12 +1961,26 @@ static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
  * @hb:		the hash_bucket of the requeue target futex
  *
  * During futex_requeue, with requeue_pi=1, it is possible to acquire the
- * target futex if it is uncontended or via a lock steal.  Set the futex_q key
- * to the requeue target futex so the waiter can detect the wakeup on the right
- * futex, but remove it from the hb and NULL the rt_waiter so it can detect
- * atomic lock acquisition.  Set the q->lock_ptr to the requeue target hb->lock
- * to protect access to the pi_state to fixup the owner later.  Must be called
- * with both q->lock_ptr and hb->lock held.
+ * target futex if it is uncontended or via a lock steal.
+ *
+ * 1) Set @q::key to the requeue target futex key so the waiter can detect
+ *    the wakeup on the right futex.
+ *
+ * 2) Dequeue @q from the hash bucket.
+ *
+ * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
+ *    acquisition.
+ *
+ * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
+ *    the waiter has to fixup the pi state.
+ *
+ * 5) Complete the requeue state so the waiter can make progress. After
+ *    this point the waiter task can return from the syscall immediately in
+ *    case that the pi state does not have to be fixed up.
+ *
+ * 6) Wake the waiter task.
+ *
+ * Must be called with both q->lock_ptr and hb->lock held.
  */
 static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
@@ -2025,7 +2061,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	 * and waiting on the 'waitqueue' futex which is always !PI.
 	 */
 	if (!top_waiter->rt_waiter || top_waiter->pi_state)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
@@ -2036,17 +2072,24 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 		return -EAGAIN;
 
 	/*
-	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
-	 * the contended case or if set_waiters is 1.  The pi_state is returned
-	 * in ps in contended cases.
+	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
+	 * in the contended case or if @set_waiters is true.
+	 *
+	 * In the contended case PI state is attached to the lock owner. If
+	 * the user space lock can be acquired then PI state is attached to
+	 * the new owner (@top_waiter->task) when @set_waiters is true.
 	 */
 	vpid = task_pid_vnr(top_waiter->task);
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
-		/* Dequeue, wake up and update top_waiter::requeue_state */
+		/*
+		 * Lock was acquired in user space and PI state was
+		 * attached to @top_waiter->task. That means state is fully
+		 * consistent and the waiter can return to user space
+		 * immediately after the wakeup.
+		 */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
-		return vpid;
 	} else if (ret < 0) {
 		/* Rewind top_waiter::requeue_state */
 		futex_requeue_pi_complete(top_waiter, ret);
@@ -2208,19 +2251,26 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 						 &exiting, nr_requeue);
 
 		/*
-		 * At this point the top_waiter has either taken uaddr2 or is
-		 * waiting on it.  If the former, then the pi_state will not
-		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, @ret contains the
-		 * VPID of the top waiter task.
-		 * If the lock was not taken, we have pi_state and an initial
-		 * refcount on it. In case of an error we have nothing.
+		 * At this point the top_waiter has either taken uaddr2 or
+		 * is waiting on it. In both cases pi_state has been
+		 * established and an initial refcount on it. In case of an
+		 * error there's nothing.
 		 *
 		 * The top waiter's requeue_state is up to date:
 		 *
-		 *  - If the lock was acquired atomically (ret > 0), then
+		 *  - If the lock was acquired atomically (ret == 1), then
 		 *    the state is Q_REQUEUE_PI_LOCKED.
 		 *
+		 *    The top waiter has been dequeued and woken up and can
+		 *    return to user space immediately. The kernel/user
+		 *    space state is consistent. In case that there must be
+		 *    more waiters requeued the WAITERS bit in the user
+		 *    space futex is set so the top waiter task has to go
+		 *    into the syscall slowpath to unlock the futex. This
+		 *    will block until this requeue operation has been
+		 *    completed and the hash bucket locks have been
+		 *    dropped.
+		 *
 		 *  - If the trylock failed with an error (ret < 0) then
 		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
 		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
@@ -2234,36 +2284,20 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 *    the same sanity checks for requeue_pi as the loop
 		 *    below does.
 		 */
-		if (ret > 0) {
-			WARN_ON(pi_state);
-			task_count++;
-			/*
-			 * If futex_proxy_trylock_atomic() acquired the
-			 * user space futex, then the user space value
-			 * @uaddr2 has been set to the @hb1's top waiter
-			 * task VPID. This task is guaranteed to be alive
-			 * and cannot be exiting because it is either
-			 * sleeping or blocked on @hb2 lock.
-			 *
-			 * The @uaddr2 futex cannot have waiters either as
-			 * otherwise futex_proxy_trylock_atomic() would not
-			 * have succeeded.
-			 *
-			 * In order to requeue waiters to @hb2, pi state is
-			 * required. Hand in the VPID value (@ret) and
-			 * allocate PI state with an initial refcount on
-			 * it.
-			 */
-			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
-						 &exiting);
-			WARN_ON(ret);
-		}
-
 		switch (ret) {
 		case 0:
 			/* We hold a reference on the pi state. */
 			break;
 
+		case 1:
+			/*
+			 * futex_proxy_trylock_atomic() acquired the user space
+			 * futex. Adjust task_count.
+			 */
+			task_count++;
+			ret = 0;
+			break;
+
 		/*
 		 * If the above failed, then pi_state is NULL and
 		 * waiter::requeue_state is correct.
@@ -2395,9 +2429,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either in
-	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
-	 * to drop it here again.
+	 * We took an extra initial reference to the pi_state in
+	 * futex_proxy_trylock_atomic(). We need to drop it here again.
 	 */
 	put_pi_state(pi_state);
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f15df3fd7c5a6..6f22ad3617c9a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			if (read == -1 || hlock->read == read)
+			if (read == -1 || hlock->read == !!read)
 				return LOCK_STATE_HELD;
 
 			return LOCK_STATE_NOT_HELD;
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b4..1e584b47c987e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
