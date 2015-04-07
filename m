From: Thavatchai Makphaibulchoke <tmac@hp.com>
Subject: [PATCH v2 2/2] kernel/locking/rtmutex.c: some code optimization
Date: Mon,  6 Apr 2015 19:26:02 -0600
Message-ID: <1428369962-74723-3-git-send-email-tmac@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
Cc: mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Thavatchai Makphaibulchoke <tmac@hp.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:50454 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbbDGB0Z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2015 21:26:25 -0400
In-Reply-To: <1428369962-74723-1-git-send-email-tmac@hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Adding the following code optimization,

- Reducing the number of cmpxchgs.  Only call mark_rt_mutex_waiters() when
  needed, waiters bit is not set.
- Reducing the hold time of wait_lock lock.
- Calling fixup_rt_mutex_waiters() only when needed.
- When unlocking rt_spin_lock in IRQ, alternate between attempting fast
  unlocking and attempting to lock mutex's wait_lock.

Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
---
 kernel/locking/rtmutex.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ae5c13f..cadba20 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -608,7 +608,8 @@ __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	 * any more. This is fixed up when we take the ownership.
 	 * This is the transitional state explained at the top of this file.
 	 */
-	mark_rt_mutex_waiters(lock);
+	if (!((unsigned long)lock->owner & RT_MUTEX_HAS_WAITERS))
+		mark_rt_mutex_waiters(lock);
 
 	if (rt_mutex_owner(lock))
 		return 0;
@@ -832,8 +833,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	rt_mutex_dequeue(lock, waiter);
+	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
@@ -1019,11 +1020,11 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
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
@@ -1038,12 +1039,6 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	self->saved_state = TASK_RUNNING;
 	pi_unlock(&self->pi_lock);
 
-	/*
-	 * try_to_take_rt_mutex() sets the waiter bit
-	 * unconditionally. We might have to fix that up:
-	 */
-	fixup_rt_mutex_waiters(lock);
-
 	BUG_ON(rt_mutex_has_waiters(lock) && &waiter == rt_mutex_top_waiter(lock));
 	BUG_ON(!RB_EMPTY_NODE(&waiter.tree_entry));
 
@@ -1096,7 +1091,14 @@ static inline void rt_spin_lock_fastunlock_in_irq(struct rt_mutex *lock,
 		return;
 	}
 	do {
+		/*
+		 * Alternate between fast acquire and try lock and proceed
+		 * to slow lock whichever succeeds first.
+		 */
 		ret = raw_spin_trylock(&lock->wait_lock);
+		if (!ret && unlikely(rt_mutex_cmpxchg(lock, intr_owner,
+			NULL)))
+			return;
 	} while (!ret);
 
 	slowfn(lock, intr_owner);
@@ -1499,10 +1501,12 @@ rt_mutex_slowtrylock(struct rt_mutex *lock, struct task_struct *task)
 
 		ret = try_to_take_rt_mutex(lock, task, NULL);
 		/*
-		 * try_to_take_rt_mutex() sets the lock waiters
-		 * bit unconditionally. Clean this up.
+		 * try_to_take_rt_mutex() keeps the lock waiters
+		 * bit set when failed to grab lock. Clean this
+		 * in case of a failure.
 		 */
-		fixup_rt_mutex_waiters(lock);
+		if (!ret)
+			fixup_rt_mutex_waiters(lock);
 	}
 
 	raw_spin_unlock(&lock->wait_lock);
-- 
1.9.1

