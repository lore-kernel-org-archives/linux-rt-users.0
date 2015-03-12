From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/36] rtmutex: Confine deadlock logic to futex
Date: Thu, 12 Mar 2015 15:21:48 -0400
Message-ID: <20150312192155.917073175@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:36529 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755792AbbCLTV7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:21:59 -0400
Content-Disposition: inline; filename=0009-rtmutex-Confine-deadlock-logic-to-futex.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: c051b21f71d1ffdfd7ad406a1ef5ede5e5f974c5

The deadlock logic is only required for futexes.

Remove the extra arguments for the public functions and also for the
futex specific ones which get always called with deadlock detection
enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	include/linux/rtmutex.h
	kernel/rtmutex.c
---
 include/linux/rtmutex.h |  8 +++-----
 kernel/futex.c          | 10 ++++-----
 kernel/rt.c             |  8 ++++----
 kernel/rtmutex-tester.c |  4 ++--
 kernel/rtmutex.c        | 54 ++++++++++++++++++++++++-------------------------
 kernel/rtmutex_common.h |  7 +++----
 6 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index fa18682c331e..a9bb1042ec19 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -113,12 +113,10 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
-extern int rt_mutex_lock_interruptible(struct rt_mutex *lock,
-						int detect_deadlock);
-extern int rt_mutex_lock_killable(struct rt_mutex *lock, int detect_deadlock);
+extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
+extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
-					struct hrtimer_sleeper *timeout,
-					int detect_deadlock);
+			       struct hrtimer_sleeper *timeout);
 
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 2d98dc9a66d1..1170418e4dd6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1570,7 +1570,7 @@ retry_private:
 			this->pi_state = pi_state;
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
-							this->task, 1);
+							this->task);
 			if (ret == 1) {
 				/* We got the lock. */
 				requeue_pi_wake_futex(this, &key2, hb2);
@@ -2186,9 +2186,9 @@ retry_private:
 	/*
 	 * Block on the PI mutex:
 	 */
-	if (!trylock)
-		ret = rt_mutex_timed_lock(&q.pi_state->pi_mutex, to, 1);
-	else {
+	if (!trylock) {
+		ret = rt_mutex_timed_futex_lock(&q.pi_state->pi_mutex, to);
+	} else {
 		ret = rt_mutex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
@@ -2554,7 +2554,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter, 1);
+		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 
 		spin_lock(&hb2->lock);
diff --git a/kernel/rt.c b/kernel/rt.c
index 5f44defabe02..b31716c7ac76 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -98,7 +98,7 @@ int __lockfunc _mutex_lock_interruptible(struct mutex *lock)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_lock_interruptible(&lock->lock, 0);
+	ret = rt_mutex_lock_interruptible(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -110,7 +110,7 @@ int __lockfunc _mutex_lock_killable(struct mutex *lock)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&lock->lock, 0);
+	ret = rt_mutex_lock_killable(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -137,7 +137,7 @@ int __lockfunc _mutex_lock_interruptible_nested(struct mutex *lock, int subclass
 	int ret;
 
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, NULL, _RET_IP_);
-	ret = rt_mutex_lock_interruptible(&lock->lock, 0);
+	ret = rt_mutex_lock_interruptible(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -149,7 +149,7 @@ int __lockfunc _mutex_lock_killable_nested(struct mutex *lock, int subclass)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&lock->lock, 0);
+	ret = rt_mutex_lock_killable(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
diff --git a/kernel/rtmutex-tester.c b/kernel/rtmutex-tester.c
index 1d96dd0d93c1..a6b605b51b97 100644
--- a/kernel/rtmutex-tester.c
+++ b/kernel/rtmutex-tester.c
@@ -16,7 +16,7 @@
 #include <linux/freezer.h>
 #include <linux/stat.h>
 
-#include "rtmutex.h"
+#include "rtmutex_common.h"
 
 #define MAX_RT_TEST_THREADS	8
 #define MAX_RT_TEST_MUTEXES	8
@@ -107,7 +107,7 @@ static int handle_op(struct test_thread_data *td, int lockwakeup)
 
 		td->mutexes[id] = 1;
 		td->event = atomic_add_return(1, &rttest_event);
-		ret = rt_mutex_lock_interruptible(&mutexes[id], 0);
+		ret = rt_mutex_lock_interruptible(&mutexes[id]);
 		td->event = atomic_add_return(1, &rttest_event);
 		td->mutexes[id] = ret ? 0 : 4;
 		return ret ? -EINTR : 0;
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 215efab038cb..7a788794bfb6 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1665,17 +1665,17 @@ rt_mutex_slowunlock(struct rt_mutex *lock)
  */
 static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int detect_deadlock, struct ww_acquire_ctx *ww_ctx,
+		  struct ww_acquire_ctx *ww_ctx,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
 				int detect_deadlock,
 				struct ww_acquire_ctx *ww_ctx))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, detect_deadlock, ww_ctx);
+		return slowfn(lock, state, NULL, 0, ww_ctx);
 }
 
 static inline int
@@ -1724,7 +1724,7 @@ void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
 	might_sleep();
 
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, rt_mutex_slowlock);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 
@@ -1732,41 +1732,47 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
  *
  * @lock:		the rt_mutex to be locked
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
- * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock,
-						 int detect_deadlock)
+int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
 	might_sleep();
 
-	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE,
-				 detect_deadlock, NULL, rt_mutex_slowlock);
+	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
+/*
+ * Futex variant with full deadlock detection.
+ */
+int rt_mutex_timed_futex_lock(struct rt_mutex *lock,
+			      struct hrtimer_sleeper *timeout)
+{
+	might_sleep();
+
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout, 1,
+				       NULL, rt_mutex_slowlock);
+}
+
 /**
  * rt_mutex_lock_killable - lock a rt_mutex killable
  *
  * @lock:		the rt_mutex to be locked
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
  * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int __sched rt_mutex_lock_killable(struct rt_mutex *lock,
-				   int detect_deadlock)
+int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
 {
 	might_sleep();
 
 	return rt_mutex_fastlock(lock, TASK_KILLABLE,
-				 detect_deadlock, NULL, rt_mutex_slowlock);
+				 NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
 
@@ -1777,22 +1783,19 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
  *
  * @lock:		the rt_mutex to be locked
  * @timeout:		timeout structure or NULL (no timeout)
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
  * -ETIMEDOUT	when the timeout expired
- * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
 int
-rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout,
-		    int detect_deadlock)
+rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
 {
 	might_sleep();
 
-	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       detect_deadlock, NULL, rt_mutex_slowlock);
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout, 0,
+				       NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 
@@ -1896,7 +1899,6 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  * @lock:		the rt_mutex to take
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
- * @detect_deadlock:	perform deadlock detection (1) or not (0)
  *
  * Returns:
  *  0 - task blocked on lock
@@ -1907,7 +1909,7 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  */
 int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
-			      struct task_struct *task, int detect_deadlock)
+			      struct task_struct *task)
 {
 	int ret;
 
@@ -1994,22 +1996,20 @@ struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
  * rt_mutex_finish_proxy_lock() - Complete lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
- * 			been started.
+ *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
- * @detect_deadlock:	perform deadlock detection (1) or not (0)
  *
  * Complete the lock acquisition started our behalf by another thread.
  *
  * Returns:
  *  0 - success
- * <0 - error, one of -EINTR, -ETIMEDOUT, or -EDEADLK
+ * <0 - error, one of -EINTR, -ETIMEDOUT
  *
  * Special API call for PI-futex requeue support
  */
 int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
-			       struct rt_mutex_waiter *waiter,
-			       int detect_deadlock)
+			       struct rt_mutex_waiter *waiter)
 {
 	int ret;
 
diff --git a/kernel/rtmutex_common.h b/kernel/rtmutex_common.h
index 6ec3dc1eab10..efde34108ebc 100644
--- a/kernel/rtmutex_common.h
+++ b/kernel/rtmutex_common.h
@@ -114,12 +114,11 @@ extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 				  struct task_struct *proxy_owner);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task,
-				     int detect_deadlock);
+				     struct task_struct *task);
 extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 				      struct hrtimer_sleeper *to,
-				      struct rt_mutex_waiter *waiter,
-				      int detect_deadlock);
+				      struct rt_mutex_waiter *waiter);
+extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
-- 
2.1.4


