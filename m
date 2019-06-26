Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12129C48BD3
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8D2133F
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFZQS4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:18:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFZQS4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 12:18:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hgAd9-0006wZ-Cu; Wed, 26 Jun 2019 18:18:43 +0200
Date:   Wed, 26 Jun 2019 18:18:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.21-rt14
Message-ID: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.21-rt14 patch set. 

Changes since v5.0.21-rt13:

  - Fix a "scheduling while atomic" in zswap. Patch by Luis Claudio R.
    Goncalves.

  - Replace a fix for for wait_for_completion() (introduced in
    v5.0.14-rt9) by an alternative version as suggested by Peter
    Zijlstra.

  - Major futex/rtmutex surgery. He Zhe reported that glibc's
    tst-robustpi8.c triggers a BUG() statement. To address that bug the
    hash bucket has been made a raw_spinlock_t.

  - Two x86 FPU patches from upstream to avoid fallout on 32bit and with
    CRIU.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.21-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.21-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.21-rt14

The RT patch against v5.0.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.21-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.21-rt14.tar.xz

Sebastian

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4715458e972f..c1bb7f276d23b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -5,6 +5,7 @@
 
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/pagemap.h>
 
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
@@ -61,6 +62,11 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
+		fpregs_lock();
+		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+			copy_fxregs_to_kernel(&tsk->thread.fpu);
+		fpregs_unlock();
+
 		convert_from_fxsr(&env, tsk);
 
 		if (__copy_to_user(buf, &env, sizeof(env)) ||
@@ -189,15 +195,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret == nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 21ae66cd41d30..2ac63a13d26d3 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -61,11 +61,13 @@ struct swait_queue_head {
 struct swait_queue {
 	struct task_struct	*task;
 	struct list_head	task_list;
+	unsigned int		remove;
 };
 
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+	.remove		= 1,						\
 }
 
 #define DECLARE_SWAITQUEUE(name)					\
diff --git a/kernel/futex.c b/kernel/futex.c
index 85c538fcad578..a86955d80f7b9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -243,7 +243,7 @@ struct futex_q {
 	struct plist_node list;
 
 	struct task_struct *task;
-	spinlock_t *lock_ptr;
+	raw_spinlock_t *lock_ptr;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
@@ -264,7 +264,7 @@ static const struct futex_q futex_q_init = {
  */
 struct futex_hash_bucket {
 	atomic_t waiters;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct plist_head chain;
 } ____cacheline_aligned_in_smp;
 
@@ -830,13 +830,13 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static void put_pi_state(struct futex_pi_state *pi_state)
+static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
-		return;
+		return NULL;
 
 	if (!atomic_dec_and_test(&pi_state->refcount))
-		return;
+		return NULL;
 
 	/*
 	 * If pi_state->owner is NULL, the owner is most probably dying
@@ -856,9 +856,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (current->pi_state_cache) {
-		kfree(pi_state);
-	} else {
+	if (!current->pi_state_cache) {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -867,6 +865,30 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		pi_state->owner = NULL;
 		atomic_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
+		pi_state = NULL;
+	}
+	return pi_state;
+}
+
+static void put_pi_state(struct futex_pi_state *pi_state)
+{
+	kfree(__put_pi_state(pi_state));
+}
+
+static void put_pi_state_atomic(struct futex_pi_state *pi_state,
+				struct list_head *to_free)
+{
+	if (__put_pi_state(pi_state))
+		list_add(&pi_state->list, to_free);
+}
+
+static void free_pi_state_list(struct list_head *to_free)
+{
+	struct futex_pi_state *p, *next;
+
+	list_for_each_entry_safe(p, next, to_free, list) {
+		list_del(&p->list);
+		kfree(p);
 	}
 }
 
@@ -883,6 +905,7 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
+	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -916,7 +939,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		spin_lock(&hb->lock);
+		raw_spin_lock(&hb->lock);
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		raw_spin_lock(&curr->pi_lock);
 		/*
@@ -926,10 +949,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock_irq(&curr->pi_lock);
-			spin_unlock(&hb->lock);
-			raw_spin_lock_irq(&curr->pi_lock);
-			put_pi_state(pi_state);
+			raw_spin_unlock(&hb->lock);
+			put_pi_state_atomic(pi_state, &to_free);
 			continue;
 		}
 
@@ -940,7 +961,7 @@ void exit_pi_state_list(struct task_struct *curr)
 
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -948,6 +969,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
+
+	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1562,21 +1585,21 @@ static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
 	if (hb1 <= hb2) {
-		spin_lock(&hb1->lock);
+		raw_spin_lock(&hb1->lock);
 		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock(&hb2->lock);
+		raw_spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
 	}
 }
 
 static inline void
 double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	spin_unlock(&hb1->lock);
+	raw_spin_unlock(&hb1->lock);
 	if (hb1 != hb2)
-		spin_unlock(&hb2->lock);
+		raw_spin_unlock(&hb2->lock);
 }
 
 /*
@@ -1604,7 +1627,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!hb_waiters_pending(hb))
 		goto out_put_key;
 
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1623,7 +1646,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 		}
 	}
 
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
@@ -1930,6 +1953,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
+	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2157,16 +2181,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
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
@@ -2177,7 +2191,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state(pi_state);
+				put_pi_state_atomic(pi_state, &to_free);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2194,7 +2208,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state(pi_state);
+	put_pi_state_atomic(pi_state, &to_free);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2215,6 +2229,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
+	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2238,7 +2253,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 	return hb;
 }
 
@@ -2246,7 +2261,7 @@ static inline void
 queue_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
 
@@ -2285,7 +2300,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	__queue_me(q, hb);
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 }
 
 /**
@@ -2301,41 +2316,41 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
  */
 static int unqueue_me(struct futex_q *q)
 {
-	spinlock_t *lock_ptr;
+	raw_spinlock_t *lock_ptr;
 	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
-	 * q->lock_ptr can change between this read and the following spin_lock.
-	 * Use READ_ONCE to forbid the compiler from reloading q->lock_ptr and
-	 * optimizing lock_ptr out of the logic below.
+	 * q->lock_ptr can change between this read and the following
+	 * raw_spin_lock. Use READ_ONCE to forbid the compiler from reloading
+	 * q->lock_ptr and optimizing lock_ptr out of the logic below.
 	 */
 	lock_ptr = READ_ONCE(q->lock_ptr);
 	if (lock_ptr != NULL) {
-		spin_lock(lock_ptr);
+		raw_spin_lock(lock_ptr);
 		/*
 		 * q->lock_ptr can change between reading it and
-		 * spin_lock(), causing us to take the wrong lock.  This
+		 * raw_spin_lock(), causing us to take the wrong lock.  This
 		 * corrects the race condition.
 		 *
 		 * Reasoning goes like this: if we have the wrong lock,
 		 * q->lock_ptr must have changed (maybe several times)
-		 * between reading it and the spin_lock().  It can
-		 * change again after the spin_lock() but only if it was
-		 * already changed before the spin_lock().  It cannot,
+		 * between reading it and the raw_spin_lock().  It can
+		 * change again after the raw_spin_lock() but only if it was
+		 * already changed before the raw_spin_lock().  It cannot,
 		 * however, change back to the original value.  Therefore
 		 * we can detect whether we acquired the correct lock.
 		 */
 		if (unlikely(lock_ptr != q->lock_ptr)) {
-			spin_unlock(lock_ptr);
+			raw_spin_unlock(lock_ptr);
 			goto retry;
 		}
 		__unqueue_futex(q);
 
 		BUG_ON(q->pi_state);
 
-		spin_unlock(lock_ptr);
+		raw_spin_unlock(lock_ptr);
 		ret = 1;
 	}
 
@@ -2351,13 +2366,16 @@ static int unqueue_me(struct futex_q *q)
 static void unqueue_me_pi(struct futex_q *q)
 	__releases(q->lock_ptr)
 {
+	struct futex_pi_state *ps;
+
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	put_pi_state(q->pi_state);
+	ps = __put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
-	spin_unlock(q->lock_ptr);
+	raw_spin_unlock(q->lock_ptr);
+	kfree(ps);
 }
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2490,7 +2508,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 */
 handle_err:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	spin_unlock(q->lock_ptr);
+	raw_spin_unlock(q->lock_ptr);
 
 	switch (err) {
 	case -EFAULT:
@@ -2508,7 +2526,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 	}
 
-	spin_lock(q->lock_ptr);
+	raw_spin_lock(q->lock_ptr);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -2604,7 +2622,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls spin_unlock() upon completion, both serializing
+	 * queue_me() calls raw_spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -2895,15 +2913,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	/*
-	 * the migrate_disable() here disables migration in the in_atomic() fast
-	 * path which is enabled again in the following spin_unlock(). We have
-	 * one migrate_disable() pending in the slow-path which is reversed
-	 * after the raw_spin_unlock_irq() where we leave the atomic context.
-	 */
-	migrate_disable();
-
-	spin_unlock(q.lock_ptr);
+	raw_spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
@@ -2911,7 +2921,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -2925,7 +2934,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
+	raw_spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -3026,7 +3035,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 
 	hb = hash_futex(&key);
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -3060,19 +3069,10 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		/*
-		 * Magic trickery for now to make the RT migrate disable
-		 * logic happy. The following spin_unlock() happens with
-		 * interrupts disabled so the internal migrate_enable()
-		 * won't undo the migrate_disable() which was issued when
-		 * locking hb->lock.
-		 */
-		migrate_disable();
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
-		migrate_enable();
 
 		put_pi_state(pi_state);
 
@@ -3108,7 +3108,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * owner.
 	 */
 	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -3128,7 +3128,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	ret = (curval == uval) ? 0 : -EAGAIN;
 
 out_unlock:
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 out_putkey:
 	put_futex_key(&key);
 	return ret;
@@ -3244,7 +3244,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb, *hb2;
+	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3302,55 +3302,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
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
+	raw_spin_lock(&hb->lock);
+	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	raw_spin_unlock(&hb->lock);
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
@@ -3359,8 +3324,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(&hb2->lock);
-			BUG_ON(&hb2->lock != q.lock_ptr);
+			struct futex_pi_state *ps_free;
+
+			raw_spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
 				pi_state = q.pi_state;
@@ -3370,8 +3336,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			put_pi_state(q.pi_state);
-			spin_unlock(&hb2->lock);
+			ps_free = __put_pi_state(q.pi_state);
+			raw_spin_unlock(q.lock_ptr);
+			kfree(ps_free);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
@@ -3385,8 +3352,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		spin_lock(&hb2->lock);
-		BUG_ON(&hb2->lock != q.lock_ptr);
+		raw_spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
@@ -4011,7 +3977,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
+		raw_spin_lock_init(&futex_queues[i].lock);
 	}
 
 	return 0;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 9c1ae2f0c1d27..62f14671aeca2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -142,12 +142,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
-{
-	return waiter && waiter != PI_WAKEUP_INPROGRESS &&
-		waiter != PI_REQUEUE_INPROGRESS;
-}
-
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -421,8 +415,7 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return rt_mutex_real_waiter(p->pi_blocked_on) ?
-		p->pi_blocked_on->lock : NULL;
+	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -558,7 +551,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!rt_mutex_real_waiter(waiter))
+	if (!waiter)
 		goto out_unlock_pi;
 
 	/*
@@ -1328,22 +1321,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
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
@@ -1367,7 +1344,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1467,7 +1444,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock = NULL;
+	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1493,8 +1470,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	if (rt_mutex_real_waiter(owner->pi_blocked_on))
-		next_lock = task_blocked_on_lock(owner);
+	next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1530,8 +1506,7 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!rt_mutex_real_waiter(waiter) ||
-	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -2350,34 +2325,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
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
index 546aaf058b9ec..758dc43872e5b 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -132,9 +132,6 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
-
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 49c14137988ea..755a580849781 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
+		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
-			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index c58068d2ee06c..e2c3d2691edf1 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -28,7 +28,8 @@ void swake_up_locked(struct swait_queue_head *q)
 
 	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
 	wake_up_process(curr->task);
-	list_del_init(&curr->task_list);
+	if (curr->remove)
+		list_del_init(&curr->task_list);
 }
 EXPORT_SYMBOL(swake_up_locked);
 
@@ -77,7 +78,8 @@ void swake_up_all(struct swait_queue_head *q)
 		curr = list_first_entry(&tmp, typeof(*curr), task_list);
 
 		wake_up_state(curr->task, TASK_NORMAL);
-		list_del_init(&curr->task_list);
+		if (curr->remove)
+			list_del_init(&curr->task_list);
 
 		if (list_empty(&tmp))
 			break;
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
diff --git a/mm/zswap.c b/mm/zswap.c
index a4e4d36ec0858..fd5d2d5c9ae94 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/locallock.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/frontswap.h>
@@ -990,6 +991,8 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+/* protect zswap_dstmem from concurrency */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1066,12 +1069,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_cpu_var(zswap_dstmem);
-	tfm = *get_cpu_ptr(entry->pool->tfm);
+	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
 	kunmap_atomic(src);
-	put_cpu_ptr(entry->pool->tfm);
 	if (ret) {
 		ret = -EINVAL;
 		goto put_dstmem;
@@ -1094,7 +1096,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1122,7 +1124,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
