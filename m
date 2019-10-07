Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A9ECE58C
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D2F2133F
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfJGVzR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:55:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGVzR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 17:55:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHay6-0004i8-Uw; Mon, 07 Oct 2019 23:55:03 +0200
Date:   Mon, 7 Oct 2019 23:55:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.19-rt11
Message-ID: <20191007215502.ncvzhov76gmt3dch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.19-rt11 patch set. 

Changes since v5.2.19-rt10:

  - Larger futex rework. Making the futex_hash_bucket lock a
    raw_spinlock_t in v5.0.21-rt14 fixed a one problem but led to other.
    This change has been reverted and the original problem was solved
    differently by Peter Zijlstra.

  - The upstream printk received a patch to not lose the last line in
    the kmsg buffer. John Ogness made a similar change to the printk
    code in -RT.

  - An optimisation by Waiman Long to avoid a memcmp() in the debug
    version of smp_processor_id() and this_cpu_.*()

  - The UBSAN report will be serialized using a spinlock_t which causes
    "sleeping while atomic" warnings if used from atomic context. Patch
    by Julien Grall.

  - Another fix to kmemleak to avoid acquiring a spinlock_t within an
    atomic region. Patch by Yongxin Liu and Liu Haitao.
 
Known issues
     - None

The delta patch against v5.2.19-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.19-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.19-rt11

The RT patch against v5.2.19 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.19-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.19-rt11.tar.xz

Sebastian
diff --git a/kernel/futex.c b/kernel/futex.c
index d7e14538ac0c4..f4e1167884b07 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -231,7 +231,7 @@ struct futex_q {
 	struct plist_node list;
 
 	struct task_struct *task;
-	raw_spinlock_t *lock_ptr;
+	spinlock_t *lock_ptr;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
@@ -252,7 +252,7 @@ static const struct futex_q futex_q_init = {
  */
 struct futex_hash_bucket {
 	atomic_t waiters;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 	struct plist_head chain;
 } ____cacheline_aligned_in_smp;
 
@@ -814,13 +814,13 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
+static void put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
-		return NULL;
+		return;
 
 	if (!refcount_dec_and_test(&pi_state->refcount))
-		return NULL;
+		return;
 
 	/*
 	 * If pi_state->owner is NULL, the owner is most probably dying
@@ -840,7 +840,9 @@ static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (!current->pi_state_cache) {
+	if (current->pi_state_cache) {
+		kfree(pi_state);
+	} else {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -849,30 +851,6 @@ static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 		pi_state->owner = NULL;
 		refcount_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
-		pi_state = NULL;
-	}
-	return pi_state;
-}
-
-static void put_pi_state(struct futex_pi_state *pi_state)
-{
-	kfree(__put_pi_state(pi_state));
-}
-
-static void put_pi_state_atomic(struct futex_pi_state *pi_state,
-				struct list_head *to_free)
-{
-	if (__put_pi_state(pi_state))
-		list_add(&pi_state->list, to_free);
-}
-
-static void free_pi_state_list(struct list_head *to_free)
-{
-	struct futex_pi_state *p, *next;
-
-	list_for_each_entry_safe(p, next, to_free, list) {
-		list_del(&p->list);
-		kfree(p);
 	}
 }
 
@@ -889,7 +867,6 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
-	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -923,7 +900,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		raw_spin_lock(&hb->lock);
+		spin_lock(&hb->lock);
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		raw_spin_lock(&curr->pi_lock);
 		/*
@@ -933,8 +910,10 @@ void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock(&hb->lock);
-			put_pi_state_atomic(pi_state, &to_free);
+			raw_spin_unlock_irq(&curr->pi_lock);
+			spin_unlock(&hb->lock);
+			raw_spin_lock_irq(&curr->pi_lock);
+			put_pi_state(pi_state);
 			continue;
 		}
 
@@ -945,7 +924,7 @@ void exit_pi_state_list(struct task_struct *curr)
 
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_unlock(&hb->lock);
+		spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -953,8 +932,6 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
-
-	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1568,21 +1545,21 @@ static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
 	if (hb1 <= hb2) {
-		raw_spin_lock(&hb1->lock);
+		spin_lock(&hb1->lock);
 		if (hb1 < hb2)
-			raw_spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 	} else { /* hb1 > hb2 */
-		raw_spin_lock(&hb2->lock);
-		raw_spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&hb2->lock);
+		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
 	}
 }
 
 static inline void
 double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	raw_spin_unlock(&hb1->lock);
+	spin_unlock(&hb1->lock);
 	if (hb1 != hb2)
-		raw_spin_unlock(&hb2->lock);
+		spin_unlock(&hb2->lock);
 }
 
 /*
@@ -1610,7 +1587,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!hb_waiters_pending(hb))
 		goto out_put_key;
 
-	raw_spin_lock(&hb->lock);
+	spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1629,7 +1606,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 		}
 	}
 
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
@@ -1936,7 +1913,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
-	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2164,6 +2140,16 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				requeue_pi_wake_futex(this, &key2, hb2);
 				drop_count++;
 				continue;
+			} else if (ret == -EAGAIN) {
+				/*
+				 * Waiter was woken by timeout or
+				 * signal and has set pi_blocked_on to
+				 * PI_WAKEUP_INPROGRESS before we
+				 * tried to enqueue it on the rtmutex.
+				 */
+				this->pi_state = NULL;
+				put_pi_state(pi_state);
+				continue;
 			} else if (ret) {
 				/*
 				 * rt_mutex_start_proxy_lock() detected a
@@ -2174,7 +2160,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state_atomic(pi_state, &to_free);
+				put_pi_state(pi_state);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2191,7 +2177,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state_atomic(pi_state, &to_free);
+	put_pi_state(pi_state);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2212,7 +2198,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
-	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2236,7 +2221,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 
 	q->lock_ptr = &hb->lock;
 
-	raw_spin_lock(&hb->lock);
+	spin_lock(&hb->lock);
 	return hb;
 }
 
@@ -2244,7 +2229,7 @@ static inline void
 queue_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
 
@@ -2283,7 +2268,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	__queue_me(q, hb);
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 }
 
 /**
@@ -2299,41 +2284,41 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
  */
 static int unqueue_me(struct futex_q *q)
 {
-	raw_spinlock_t *lock_ptr;
+	spinlock_t *lock_ptr;
 	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
-	 * q->lock_ptr can change between this read and the following
-	 * raw_spin_lock. Use READ_ONCE to forbid the compiler from reloading
-	 * q->lock_ptr and optimizing lock_ptr out of the logic below.
+	 * q->lock_ptr can change between this read and the following spin_lock.
+	 * Use READ_ONCE to forbid the compiler from reloading q->lock_ptr and
+	 * optimizing lock_ptr out of the logic below.
 	 */
 	lock_ptr = READ_ONCE(q->lock_ptr);
 	if (lock_ptr != NULL) {
-		raw_spin_lock(lock_ptr);
+		spin_lock(lock_ptr);
 		/*
 		 * q->lock_ptr can change between reading it and
-		 * raw_spin_lock(), causing us to take the wrong lock.  This
+		 * spin_lock(), causing us to take the wrong lock.  This
 		 * corrects the race condition.
 		 *
 		 * Reasoning goes like this: if we have the wrong lock,
 		 * q->lock_ptr must have changed (maybe several times)
-		 * between reading it and the raw_spin_lock().  It can
-		 * change again after the raw_spin_lock() but only if it was
-		 * already changed before the raw_spin_lock().  It cannot,
+		 * between reading it and the spin_lock().  It can
+		 * change again after the spin_lock() but only if it was
+		 * already changed before the spin_lock().  It cannot,
 		 * however, change back to the original value.  Therefore
 		 * we can detect whether we acquired the correct lock.
 		 */
 		if (unlikely(lock_ptr != q->lock_ptr)) {
-			raw_spin_unlock(lock_ptr);
+			spin_unlock(lock_ptr);
 			goto retry;
 		}
 		__unqueue_futex(q);
 
 		BUG_ON(q->pi_state);
 
-		raw_spin_unlock(lock_ptr);
+		spin_unlock(lock_ptr);
 		ret = 1;
 	}
 
@@ -2349,16 +2334,13 @@ static int unqueue_me(struct futex_q *q)
 static void unqueue_me_pi(struct futex_q *q)
 	__releases(q->lock_ptr)
 {
-	struct futex_pi_state *ps;
-
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	ps = __put_pi_state(q->pi_state);
+	put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
-	raw_spin_unlock(q->lock_ptr);
-	kfree(ps);
+	spin_unlock(q->lock_ptr);
 }
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2491,7 +2473,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 */
 handle_err:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	raw_spin_unlock(q->lock_ptr);
+	spin_unlock(q->lock_ptr);
 
 	switch (err) {
 	case -EFAULT:
@@ -2509,7 +2491,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 	}
 
-	raw_spin_lock(q->lock_ptr);
+	spin_lock(q->lock_ptr);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -2605,7 +2587,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls raw_spin_unlock() upon completion, both serializing
+	 * queue_me() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -2896,7 +2878,15 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	raw_spin_unlock(q.lock_ptr);
+	/*
+	 * the migrate_disable() here disables migration in the in_atomic() fast
+	 * path which is enabled again in the following spin_unlock(). We have
+	 * one migrate_disable() pending in the slow-path which is reversed
+	 * after the raw_spin_unlock_irq() where we leave the atomic context.
+	 */
+	migrate_disable();
+
+	spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
@@ -2904,6 +2894,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -2917,7 +2908,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	raw_spin_lock(q.lock_ptr);
+	spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -3018,7 +3009,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 
 	hb = hash_futex(&key);
-	raw_spin_lock(&hb->lock);
+	spin_lock(&hb->lock);
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -3052,10 +3043,19 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_unlock(&hb->lock);
+		/*
+		 * Magic trickery for now to make the RT migrate disable
+		 * logic happy. The following spin_unlock() happens with
+		 * interrupts disabled so the internal migrate_enable()
+		 * won't undo the migrate_disable() which was issued when
+		 * locking hb->lock.
+		 */
+		migrate_disable();
+		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
+		migrate_enable();
 
 		put_pi_state(pi_state);
 
@@ -3091,7 +3091,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * owner.
 	 */
 	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
-		raw_spin_unlock(&hb->lock);
+		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -3111,7 +3111,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	ret = (curval == uval) ? 0 : -EAGAIN;
 
 out_unlock:
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 out_putkey:
 	put_futex_key(&key);
 	return ret;
@@ -3227,7 +3227,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
+	struct futex_hash_bucket *hb, *hb2;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3285,20 +3285,55 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	raw_spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-	raw_spin_unlock(&hb->lock);
-	if (ret)
-		goto out_put_keys;
+	/*
+	 * On RT we must avoid races with requeue and trying to block
+	 * on two mutexes (hb->lock and uaddr2's rtmutex) by
+	 * serializing access to pi_blocked_on with pi_lock.
+	 */
+	raw_spin_lock_irq(&current->pi_lock);
+	if (current->pi_blocked_on) {
+		/*
+		 * We have been requeued or are in the process of
+		 * being requeued.
+		 */
+		raw_spin_unlock_irq(&current->pi_lock);
+	} else {
+		/*
+		 * Setting pi_blocked_on to PI_WAKEUP_INPROGRESS
+		 * prevents a concurrent requeue from moving us to the
+		 * uaddr2 rtmutex. After that we can safely acquire
+		 * (and possibly block on) hb->lock.
+		 */
+		current->pi_blocked_on = PI_WAKEUP_INPROGRESS;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		spin_lock(&hb->lock);
+
+		/*
+		 * Clean up pi_blocked_on. We might leak it otherwise
+		 * when we succeeded with the hb->lock in the fast
+		 * path.
+		 */
+		raw_spin_lock_irq(&current->pi_lock);
+		current->pi_blocked_on = NULL;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+		spin_unlock(&hb->lock);
+		if (ret)
+			goto out_put_keys;
+	}
 
 	/*
-	 * In order for us to be here, we know our q.key == key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * In order to be here, we have either been requeued, are in
+	 * the process of being requeued, or requeue successfully
+	 * acquired uaddr2 on our behalf.  If pi_blocked_on was
+	 * non-null above, we may be racing with a requeue.  Do not
+	 * rely on q->lock_ptr to be hb2->lock until after blocking on
+	 * hb->lock or hb2->lock. The futex_requeue dropped our key1
+	 * reference and incremented our key2 reference count.
 	 */
+	hb2 = hash_futex(&key2);
 
 	/* Check if the requeue code acquired the second futex for us. */
 	if (!q.rt_waiter) {
@@ -3307,9 +3342,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			struct futex_pi_state *ps_free;
-
-			raw_spin_lock(q.lock_ptr);
+			spin_lock(&hb2->lock);
+			BUG_ON(&hb2->lock != q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
 				pi_state = q.pi_state;
@@ -3319,9 +3353,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			ps_free = __put_pi_state(q.pi_state);
-			raw_spin_unlock(q.lock_ptr);
-			kfree(ps_free);
+			put_pi_state(q.pi_state);
+			spin_unlock(&hb2->lock);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
@@ -3335,7 +3368,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		raw_spin_lock(q.lock_ptr);
+		spin_lock(&hb2->lock);
+		BUG_ON(&hb2->lock != q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
@@ -3960,7 +3994,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
-		raw_spin_lock_init(&futex_queues[i].lock);
+		spin_lock_init(&futex_queues[i].lock);
 	}
 
 	return 0;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5ccbb45131e5d..bb5c09c49c504 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -143,6 +143,12 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
+static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
+{
+	return waiter && waiter != PI_WAKEUP_INPROGRESS &&
+		waiter != PI_REQUEUE_INPROGRESS;
+}
+
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -416,7 +422,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -552,7 +559,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!waiter)
+	if (!rt_mutex_real_waiter(waiter))
 		goto out_unlock_pi;
 
 	/*
@@ -1322,6 +1329,22 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
+	/*
+	 * In the case of futex requeue PI, this will be a proxy
+	 * lock. The task will wake unaware that it is enqueueed on
+	 * this lock. Avoid blocking on two locks and corrupting
+	 * pi_blocked_on via the PI_WAKEUP_INPROGRESS
+	 * flag. futex_wait_requeue_pi() sets this when it wakes up
+	 * before requeue (due to a signal or timeout). Do not enqueue
+	 * the task if PI_WAKEUP_INPROGRESS is set.
+	 */
+	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
+		raw_spin_unlock(&task->pi_lock);
+		return -EAGAIN;
+	}
+
+       BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
+
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
@@ -1345,7 +1368,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on)
+		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1445,7 +1468,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex *next_lock = NULL;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1471,7 +1494,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	next_lock = task_blocked_on_lock(owner);
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1507,7 +1531,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!rt_mutex_real_waiter(waiter) ||
+	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -2296,6 +2321,26 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
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
@@ -2326,6 +2371,34 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/*
+	 * In PREEMPT_RT there's an added race.
+	 * If the task, that we are about to requeue, times out,
+	 * it can set the PI_WAKEUP_INPROGRESS. This tells the requeue
+	 * to skip this task. But right after the task sets
+	 * its pi_blocked_on to PI_WAKEUP_INPROGRESS it can then
+	 * block on the spin_lock(&hb->lock), which in RT is an rtmutex.
+	 * This will replace the PI_WAKEUP_INPROGRESS with the actual
+	 * lock that it blocks on. We *must not* place this task
+	 * on this proxy lock in that case.
+	 *
+	 * To prevent this race, we first take the task's pi_lock
+	 * and check if it has updated its pi_blocked_on. If it has,
+	 * we assume that it woke up and we return -EAGAIN.
+	 * Otherwise, we set the task's pi_blocked_on to
+	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
+	 * it will know that we are in the process of requeuing it.
+	 */
+	raw_spin_lock(&task->pi_lock);
+	if (task->pi_blocked_on) {
+		raw_spin_unlock(&task->pi_lock);
+		return -EAGAIN;
+	}
+	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
+	raw_spin_unlock(&task->pi_lock);
+#endif
+
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
 				      RT_MUTEX_FULL_CHAINWALK);
@@ -2340,6 +2413,9 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
+
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -2420,7 +2496,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
-	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2432,23 +2507,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
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
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 758dc43872e5b..546aaf058b9ec 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -132,6 +132,9 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
+#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
+#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
+
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 58c545a528b3b..9d9523431178b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1436,6 +1436,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
+		if (len + textlen > size)
+			break;
+
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
@@ -3075,7 +3078,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		ret = prb_iter_next(&iter, msgbuf, PRINTK_RECORD_MAX, &seq);
 		if (ret == 0) {
 			break;
-		} else if (ret < 0) {
+		} else if (ret < 0 || seq >= end_seq) {
 			prb_iter_init(&iter, &printk_rb, &seq);
 			goto retry;
 		}
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 60ba93fc42ce3..bd95716532889 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,7 +23,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
+	if (current->nr_cpus_allowed == 1)
 		goto out;
 
 	/*
diff --git a/lib/ubsan.c b/lib/ubsan.c
index e7d31735950de..39d5952c42733 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -140,25 +140,21 @@ static void val_to_string(char *str, size_t size, struct type_descriptor *type,
 	}
 }
 
-static DEFINE_SPINLOCK(report_lock);
-
-static void ubsan_prologue(struct source_location *location,
-			unsigned long *flags)
+static void ubsan_prologue(struct source_location *location)
 {
 	current->in_ubsan++;
-	spin_lock_irqsave(&report_lock, *flags);
 
 	pr_err("========================================"
 		"========================================\n");
 	print_source_location("UBSAN: Undefined behaviour in", location);
 }
 
-static void ubsan_epilogue(unsigned long *flags)
+static void ubsan_epilogue(void)
 {
 	dump_stack();
 	pr_err("========================================"
 		"========================================\n");
-	spin_unlock_irqrestore(&report_lock, *flags);
+
 	current->in_ubsan--;
 }
 
@@ -167,14 +163,13 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 {
 
 	struct type_descriptor *type = data->type;
-	unsigned long flags;
 	char lhs_val_str[VALUE_LENGTH];
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
@@ -186,7 +181,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 		rhs_val_str,
 		type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 void __ubsan_handle_add_overflow(struct overflow_data *data,
@@ -214,20 +209,19 @@ EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
 void __ubsan_handle_negate_overflow(struct overflow_data *data,
 				void *old_val)
 {
-	unsigned long flags;
 	char old_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
 
 	pr_err("negation of %s cannot be represented in type %s:\n",
 		old_val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 
@@ -235,13 +229,12 @@ EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 				void *lhs, void *rhs)
 {
-	unsigned long flags;
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
 
@@ -251,58 +244,52 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 	else
 		pr_err("division by zero\n");
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
 
 static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s null pointer of type %s\n",
 		type_check_kinds[data->type_check_kind],
 		data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_misaligned_access(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s misaligned address %p for type %s\n",
 		type_check_kinds[data->type_check_kind],
 		(void *)ptr, data->type->type_name);
 	pr_err("which requires %ld byte alignment\n", data->alignment);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 					unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 	pr_err("%s address %p with insufficient space\n",
 		type_check_kinds[data->type_check_kind],
 		(void *) ptr);
 	pr_err("for an object of type %s\n", data->type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
@@ -351,25 +338,23 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 
 void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
 {
-	unsigned long flags;
 	char index_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(index_str, sizeof(index_str), data->index_type, index);
 	pr_err("index %s is out of range for type %s\n", index_str,
 		data->array_type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
 
 void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 					void *lhs, void *rhs)
 {
-	unsigned long flags;
 	struct type_descriptor *rhs_type = data->rhs_type;
 	struct type_descriptor *lhs_type = data->lhs_type;
 	char rhs_str[VALUE_LENGTH];
@@ -378,7 +363,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
 	val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
@@ -401,18 +386,16 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 			lhs_str, rhs_str,
 			lhs_type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
 void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
-	unsigned long flags;
-
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 	pr_err("calling __builtin_unreachable()\n");
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 	panic("can't return from __builtin_unreachable()");
 }
 EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
@@ -420,19 +403,18 @@ EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
 void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
 				void *val)
 {
-	unsigned long flags;
 	char val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(val_str, sizeof(val_str), data->type, val);
 
 	pr_err("load of value %s is not a valid value for type %s\n",
 		val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index aaee59c0306a8..355dd95d0611f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -135,7 +135,7 @@ struct kmemleak_scan_area {
  * (use_count) and freed using the RCU mechanism.
  */
 struct kmemleak_object {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int flags;		/* object status flags */
 	struct list_head object_list;
 	struct list_head gray_list;
@@ -560,7 +560,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
-	spin_lock_init(&object->lock);
+	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
@@ -642,9 +642,9 @@ static void __delete_object(struct kmemleak_object *object)
 	 * Locking here also ensures that the corresponding memory block
 	 * cannot be freed when it is being scanned.
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags &= ~OBJECT_ALLOCATED;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -716,9 +716,9 @@ static void paint_it(struct kmemleak_object *object, int color)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	__paint_it(object, color);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 static void paint_ptr(unsigned long ptr, int color)
@@ -778,7 +778,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (size == SIZE_MAX) {
 		size = object->pointer + object->size - ptr;
 	} else if (ptr + size > object->pointer + object->size) {
@@ -794,7 +794,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 
 	hlist_add_head(&area->node, &object->area_list);
 out_unlock:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	put_object(object);
 }
@@ -817,9 +817,9 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->excess_ref = excess_ref;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -839,9 +839,9 @@ static void object_no_scan(unsigned long ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags |= OBJECT_NO_SCAN;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -902,11 +902,11 @@ static void early_alloc(struct early_log *log)
 			       log->min_count, GFP_ATOMIC);
 	if (!object)
 		goto out;
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	for (i = 0; i < log->trace_len; i++)
 		object->trace[i] = log->trace[i];
 	object->trace_len = log->trace_len;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	rcu_read_unlock();
 }
@@ -1096,9 +1096,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->trace_len = __save_stack_trace(object->trace);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 }
@@ -1346,7 +1346,7 @@ static void scan_block(void *_start, void *_end,
 		 * previously acquired in scan_object(). These locks are
 		 * enclosed by scan_mutex.
 		 */
-		spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 		/* only pass surplus references (object already gray) */
 		if (color_gray(object)) {
 			excess_ref = object->excess_ref;
@@ -1355,7 +1355,7 @@ static void scan_block(void *_start, void *_end,
 			excess_ref = 0;
 			update_refs(object);
 		}
-		spin_unlock(&object->lock);
+		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
 			object = lookup_object(excess_ref, 0);
@@ -1364,9 +1364,9 @@ static void scan_block(void *_start, void *_end,
 			if (object == scanned)
 				/* circular reference, ignore */
 				continue;
-			spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 			update_refs(object);
-			spin_unlock(&object->lock);
+			raw_spin_unlock(&object->lock);
 		}
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1402,7 +1402,7 @@ static void scan_object(struct kmemleak_object *object)
 	 * Once the object->lock is acquired, the corresponding memory block
 	 * cannot be freed (the same lock is acquired in delete_object).
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (object->flags & OBJECT_NO_SCAN)
 		goto out;
 	if (!(object->flags & OBJECT_ALLOCATED))
@@ -1421,9 +1421,9 @@ static void scan_object(struct kmemleak_object *object)
 			if (start >= end)
 				break;
 
-			spin_unlock_irqrestore(&object->lock, flags);
+			raw_spin_unlock_irqrestore(&object->lock, flags);
 			cond_resched();
-			spin_lock_irqsave(&object->lock, flags);
+			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else
 		hlist_for_each_entry(area, &object->area_list, node)
@@ -1431,7 +1431,7 @@ static void scan_object(struct kmemleak_object *object)
 				   (void *)(area->start + area->size),
 				   object);
 out:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 /*
@@ -1484,7 +1484,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1501,7 +1501,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1569,14 +1569,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1596,7 +1596,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1606,7 +1606,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1758,10 +1758,10 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
 	struct kmemleak_object *object = v;
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
 		print_unreferenced(seq, object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	return 0;
 }
 
@@ -1791,9 +1791,9 @@ static int dump_str_object_info(const char *str)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	dump_object_info(object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 	return 0;
@@ -1812,11 +1812,11 @@ static void kmemleak_clear(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
