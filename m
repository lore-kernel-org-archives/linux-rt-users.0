From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 6/8] locking/mutex: make mutex::wait_lock irq safe
Date: Tue,  9 Oct 2018 11:24:32 +0200
Message-ID: <20181009092434.26221-7-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

mutex::wait_lock might be nested under rq->lock.

Make it irq safe then.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/locking/mutex.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 23312afa7fca..c16cb84420c3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -444,6 +444,7 @@ __ww_mutex_check_waiters(struct mutex *lock,
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
+	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
 
 	ww_mutex_lock_acquired(lock, ctx);
@@ -473,9 +474,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	raw_spin_lock(&lock->base.wait_lock);
+	raw_spin_lock_irqsave(&lock->base.wait_lock, flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
-	raw_spin_unlock(&lock->base.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->base.wait_lock, flags);
 
 	wake_up_q(&wake_q);
 }
@@ -917,6 +918,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	bool first = false;
 	struct ww_mutex *ww;
 	int ret;
+	unsigned long flags;
 
 	might_sleep();
 
@@ -947,7 +949,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -1012,7 +1014,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		schedule_preempt_disabled();
 
 		/*
@@ -1039,9 +1041,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
 			break;
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1070,7 +1072,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -1079,7 +1081,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
 err_early_kill:
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
 	wake_up_q(&wake_q);
@@ -1220,6 +1222,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 * conditional on having proxy exec configured in?
 	 */
 	unsigned long owner = MUTEX_FLAG_HANDOFF;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, 1, ip);
 
@@ -1261,7 +1264,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	}
 #endif
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 
 #ifdef CONFIG_PROXY_EXEC
@@ -1302,7 +1305,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable(); // XXX unlock->wakeup inversion like
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q); // XXX must force resched on proxy
 	preempt_enable();
-- 
2.17.1
