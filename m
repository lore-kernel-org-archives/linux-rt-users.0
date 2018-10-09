From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 1/8] locking/mutex: Convert mutex::wait_lock to raw_spinlock_t
Date: Tue,  9 Oct 2018 11:24:27 +0200
Message-ID: <20181009092434.26221-2-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock it needs to be
raw_spinlock_t.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/mutex.h        |  4 ++--
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex.c       | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 3093dd162424..725aa113626f 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -52,7 +52,7 @@ struct ww_acquire_ctx;
  */
 struct mutex {
 	atomic_long_t		owner;
-	spinlock_t		wait_lock;
+	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
@@ -127,7 +127,7 @@ do {									\
 
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
-		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
+		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 9aa713629387..a660d38b6c29 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -36,7 +36,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 {
-	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	SMP_DEBUG_LOCKS_WARN_ON(!raw_spin_is_locked(&lock->wait_lock));
 	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
 	DEBUG_LOCKS_WARN_ON(waiter->magic != waiter);
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -51,7 +51,7 @@ void debug_mutex_free_waiter(struct mutex_waiter *waiter)
 void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			    struct task_struct *task)
 {
-	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	SMP_DEBUG_LOCKS_WARN_ON(!raw_spin_is_locked(&lock->wait_lock));
 
 	/* Mark the current thread as blocked on the lock: */
 	task->blocked_on = waiter;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3f8a35104285..df34ce70fcde 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -39,7 +39,7 @@ void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
 	atomic_long_set(&lock->owner, 0);
-	spin_lock_init(&lock->wait_lock);
+	raw_spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
@@ -464,9 +464,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	spin_lock(&lock->base.wait_lock);
+	raw_spin_lock(&lock->base.wait_lock);
 	__ww_mutex_check_waiters(&lock->base, ctx);
-	spin_unlock(&lock->base.wait_lock);
+	raw_spin_unlock(&lock->base.wait_lock);
 }
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -934,7 +934,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		return 0;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -998,7 +998,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
-		spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
 		/*
@@ -1021,9 +1021,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
 			break;
 
-		spin_lock(&lock->wait_lock);
+		raw_spin_lock(&lock->wait_lock);
 	}
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1050,7 +1050,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	preempt_enable();
 	return 0;
 
@@ -1058,7 +1058,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
 err_early_kill:
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
 	preempt_enable();
@@ -1227,7 +1227,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		owner = old;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -1244,7 +1244,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
 }
-- 
2.17.1
