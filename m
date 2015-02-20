From: Thavatchai Makphaibulchoke <tmac@hp.com>
Subject: [PATCH 3.14.25-rt22 2/2] kernel/locking/rtmutex.c: some code optimization
Date: Thu, 19 Feb 2015 18:31:06 -0700
Message-ID: <1424395866-81589-3-git-send-email-tmac@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
Cc: mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Thavatchai Makphaibulchoke <tmac@hp.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424395866-81589-1-git-send-email-tmac@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Adding the following code optimization,

- Reducing the number of cmpxchgs.  Only call mark_rt_mutex_waiters() when
  needed, waiters bit is not set.
- Reducing the hold time of wait_lock lock.
- Calling fixup_rt_mutex_waiters() only when needed.

Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
---
 kernel/locking/rtmutex.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8b66f81..2600026 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -622,7 +622,8 @@ __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	 * any more. This is fixed up when we take the ownership.
 	 * This is the transitional state explained at the top of this file.
 	 */
-	mark_rt_mutex_waiters(lock);
+	if (!((unsigned long)lock->owner & RT_MUTEX_HAS_WAITERS))
+		mark_rt_mutex_waiters(lock);
 
 	if (rt_mutex_owner(lock))
 		return 0;
@@ -854,8 +855,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	rt_mutex_dequeue(lock, waiter);
+	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
@@ -960,6 +961,9 @@ static int adaptive_wait(struct rt_mutex *lock,
 {
 	int res = 0;
 
+	if (!owner)
+		return res;
+
 	rcu_read_lock();
 	for (;;) {
 		if (owner != rt_mutex_owner(lock))
@@ -1050,11 +1054,11 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
 			schedule_rt_mutex(lock);
 
-		raw_spin_lock(&lock->wait_lock);
-
 		pi_lock(&self->pi_lock);
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		pi_unlock(&self->pi_lock);
+
+		raw_spin_lock(&lock->wait_lock);
 	}
 
 	/*
@@ -1070,10 +1074,11 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	pi_unlock(&self->pi_lock);
 
 	/*
-	 * try_to_take_rt_mutex() sets the waiter bit
-	 * unconditionally. We might have to fix that up:
+	 * No need to call fixup_rt_mutex_waiters(), as we only get
+	 * here when __try_to_take_rt_mutex() returns TRUE.
+	 * In this case, rt_mutex_set_owner() has already take care of the
+	 * waiter bit.
 	 */
-	fixup_rt_mutex_waiters(lock);
 
 	BUG_ON(rt_mutex_has_waiters(lock) && &waiter == rt_mutex_top_waiter(lock));
 	BUG_ON(!RB_EMPTY_NODE(&waiter.tree_entry));
@@ -1127,7 +1132,16 @@ static inline void rt_spin_lock_fastunlock_in_irq(struct rt_mutex *lock,
 	if (likely(rt_mutex_cmpxchg(lock, intr_owner, NULL)))
 		return;
 	do {
+		/*
+		 * Alternate between fast acquire and try lock and proceed
+		 * to slow lock whichever succeeds first.
+		 *
+		 * Also use reserved INTERRUPT_HANDLER task_strcut.
+		 */
 		ret = raw_spin_trylock(&lock->wait_lock);
+		if (!ret && unlikely(rt_mutex_cmpxchg(lock, intr_owner,
+			NULL)))
+			return;
 	} while (!ret);
 
 	slowfn(lock, intr_owner);
@@ -1538,10 +1552,12 @@ rt_mutex_slowtrylock(struct rt_mutex *lock, struct task_struct *task)
 
 		ret = try_to_take_rt_mutex(lock, task, NULL);
 		/*
-		 * try_to_take_rt_mutex() sets the lock waiters
-		 * bit unconditionally. Clean this up.
+		 * try_to_take_rt_mutex() leaves the lock waiters bit set
+		 * if we fail to take the lock.  Clean this up if we
+		 * don't get the lock.
 		 */
-		fixup_rt_mutex_waiters(lock);
+		if (!ret)
+			fixup_rt_mutex_waiters(lock);
 	}
 
 	raw_spin_unlock(&lock->wait_lock);
-- 
1.9.1
