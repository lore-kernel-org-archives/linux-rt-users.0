From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 30/39] locking: ww_mutex: fix ww_mutex vs self-deadlock
Date: Thu, 12 Mar 2015 15:13:37 -0400
Message-ID: <20150312191411.986253478@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:7574 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752591AbbCLTP2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:15:28 -0400
Content-Disposition: inline; filename=0030-locking-ww_mutex-fix-ww_mutex-vs-self-deadlock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

If the caller already holds the mutex, task_blocks_on_rt_mutex()
returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
where it's instant game over.

Let ww_mutexes return EDEADLK/EALREADY as they want to instead.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 27a1993111f9..ee4e7e747e06 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1694,13 +1694,20 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	if (likely(!ret))
 		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter, ww_ctx);
+	else if (ww_ctx) {
+		/* ww_mutex received EDEADLK, let it become EALREADY */
+		ret = __mutex_lock_check_stamp(lock, ww_ctx);
+		BUG_ON(!ret);
+	}
 
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
 		if (rt_mutex_has_waiters(lock))
 			remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -2239,8 +2246,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2258,8 +2264,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2271,11 +2276,13 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock);
 
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
+	int nest = !!lock->ctx;
+
 	/*
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
 	 */
-	if (lock->ctx) {
+	if (nest) {
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
@@ -2284,7 +2291,7 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 		lock->ctx = NULL;
 	}
 
-	mutex_release(&lock->base.dep_map, 1, _RET_IP_);
+	mutex_release(&lock->base.dep_map, nest, _RET_IP_);
 	rt_mutex_unlock(&lock->base.lock);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
-- 
2.1.4


