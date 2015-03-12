From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 10/36] rtmutex: Cleanup deadlock detector debug logic
Date: Thu, 12 Mar 2015 15:21:49 -0400
Message-ID: <20150312192156.069978932@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0010-rtmutex-Cleanup-deadlock-detector-debug-logic.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: 8930ed80f970a90a795239e7415c9b0e6f964649

The conditions under which deadlock detection is conducted are unclear
and undocumented.

Add constants instead of using 0/1 and provide a selection function
which hides the additional debug dependency from the calling code.

Add comments where needed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Link: http://lkml.kernel.org/r/20140522031949.947264874@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	kernel/rtmutex.c
---
 kernel/rtmutex-debug.c  |  5 +--
 kernel/rtmutex-debug.h  |  7 +++--
 kernel/rtmutex.c        | 82 ++++++++++++++++++++++++++++++++++---------------
 kernel/rtmutex.h        |  7 ++++-
 kernel/rtmutex_common.h | 15 +++++++++
 5 files changed, 85 insertions(+), 31 deletions(-)

diff --git a/kernel/rtmutex-debug.c b/kernel/rtmutex-debug.c
index 13b243a323fa..2035a46ca489 100644
--- a/kernel/rtmutex-debug.c
+++ b/kernel/rtmutex-debug.c
@@ -66,12 +66,13 @@ void rt_mutex_debug_task_free(struct task_struct *task)
  * the deadlock. We print when we return. act_waiter can be NULL in
  * case of a remove waiter operation.
  */
-void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *act_waiter,
+void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
+			     struct rt_mutex_waiter *act_waiter,
 			     struct rt_mutex *lock)
 {
 	struct task_struct *task;
 
-	if (!debug_locks || detect || !act_waiter)
+	if (!debug_locks || chwalk == RT_MUTEX_FULL_CHAINWALK || !act_waiter)
 		return;
 
 	task = rt_mutex_owner(act_waiter->lock);
diff --git a/kernel/rtmutex-debug.h b/kernel/rtmutex-debug.h
index ab29b6a22669..d0519c3432b6 100644
--- a/kernel/rtmutex-debug.h
+++ b/kernel/rtmutex-debug.h
@@ -20,14 +20,15 @@ extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
 				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *waiter,
+extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
+				    struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
 extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
 # define debug_rt_mutex_reset_waiter(w)			\
 	do { (w)->deadlock_lock = NULL; } while (0)
 
-static inline int debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
-						 int detect)
+static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
+						  enum rtmutex_chainwalk walk)
 {
 	return (waiter != NULL);
 }
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 7a788794bfb6..8f4a8188d6e3 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -254,6 +254,32 @@ static void rt_mutex_wake_waiter(struct rt_mutex_waiter *waiter)
 }
 
 /*
+ * Deadlock detection is conditional:
+ *
+ * If CONFIG_DEBUG_RT_MUTEXES=n, deadlock detection is only conducted
+ * if the detect argument is == RT_MUTEX_FULL_CHAINWALK.
+ *
+ * If CONFIG_DEBUG_RT_MUTEXES=y, deadlock detection is always
+ * conducted independent of the detect argument.
+ *
+ * If the waiter argument is NULL this indicates the deboost path and
+ * deadlock detection is disabled independent of the detect argument
+ * and the config settings.
+ */
+static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
+					  enum rtmutex_chainwalk chwalk)
+{
+	/*
+	 * This is just a wrapper function for the following call,
+	 * because debug_rt_mutex_detect_deadlock() smells like a magic
+	 * debug feature and I wanted to keep the cond function in the
+	 * main source file along with the comments instead of having
+	 * two of the same in the headers.
+	 */
+	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+}
+
+/*
  * Max number of times we'll walk the boosting chain:
  */
 int max_lock_depth = 1024;
@@ -328,7 +354,7 @@ static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
  *	  goto again;
  */
 static int rt_mutex_adjust_prio_chain(struct task_struct *task,
-				      int deadlock_detect,
+				      enum rtmutex_chainwalk chwalk,
 				      struct rt_mutex *orig_lock,
 				      struct rt_mutex *next_lock,
 				      struct rt_mutex_waiter *orig_waiter,
@@ -336,12 +362,12 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 {
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	struct rt_mutex_waiter *prerequeue_top_waiter;
-	int detect_deadlock, ret = 0, depth = 0;
+	int ret = 0, depth = 0;
 	struct rt_mutex *lock;
+	bool detect_deadlock;
 	unsigned long flags;
 
-	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
-							 deadlock_detect);
+	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);
 
 	/*
 	 * The (de)boosting is a step by step approach with a lot of
@@ -467,7 +493,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
+		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
 		goto out_unlock_pi;
@@ -763,7 +789,7 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
 				   struct task_struct *task,
-				   int detect_deadlock)
+				   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
@@ -827,7 +853,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		__rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
-	} else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
+	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
 	}
 
@@ -852,7 +878,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
+	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
 	raw_spin_lock(&lock->wait_lock);
@@ -960,7 +986,8 @@ static void remove_waiter(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	rt_mutex_adjust_prio_chain(owner, 0, lock, next_lock, NULL, current);
+	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
+				   next_lock, NULL, current);
 
 	raw_spin_lock(&lock->wait_lock);
 }
@@ -989,8 +1016,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(task);
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-
-	rt_mutex_adjust_prio_chain(task, 0, NULL, next_lock, NULL, task);
+	rt_mutex_adjust_prio_chain(task, RT_MUTEX_MIN_CHAINWALK, NULL,
+				   next_lock, NULL, task);
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -1499,7 +1526,8 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
-		  int detect_deadlock, struct ww_acquire_ctx *ww_ctx)
+		  enum rtmutex_chainwalk chwalk,
+		  struct ww_acquire_ctx *ww_ctx)
 {
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
@@ -1526,7 +1554,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 			timeout->task = NULL;
 	}
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, detect_deadlock);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
 
 	if (likely(!ret))
 		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter, ww_ctx);
@@ -1535,8 +1563,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	if (unlikely(ret)) {
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, detect_deadlock, &waiter);
-
+		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -1668,30 +1695,32 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 		  struct ww_acquire_ctx *ww_ctx,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
-				int detect_deadlock,
+				enum rtmutex_chainwalk chwalk,
 				struct ww_acquire_ctx *ww_ctx))
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, 0, ww_ctx);
+		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
 static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout, int detect_deadlock,
+			struct hrtimer_sleeper *timeout,
+			enum rtmutex_chainwalk chwalk,
 			struct ww_acquire_ctx *ww_ctx,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock,
+				      enum rtmutex_chainwalk chwalk,
 				      struct ww_acquire_ctx *ww_ctx))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
+	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, timeout, detect_deadlock, ww_ctx);
+		return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
 static inline int
@@ -1753,8 +1782,9 @@ int rt_mutex_timed_futex_lock(struct rt_mutex *lock,
 {
 	might_sleep();
 
-	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout, 1,
-				       NULL, rt_mutex_slowlock);
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
+				       RT_MUTEX_FULL_CHAINWALK, NULL,
+				       rt_mutex_slowlock);
 }
 
 /**
@@ -1794,7 +1824,8 @@ rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
 {
 	might_sleep();
 
-	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout, 0,
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
+				       RT_MUTEX_MIN_CHAINWALK,
 				       NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
@@ -1950,7 +1981,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 #endif
 
 	/* We enforce deadlock detection for futexes */
-	ret = task_blocks_on_rt_mutex(lock, waiter, task, 1);
+	ret = task_blocks_on_rt_mutex(lock, waiter, task,
+				      RT_MUTEX_FULL_CHAINWALK);
 
 	if (ret && !rt_mutex_owner(lock)) {
 		/*
diff --git a/kernel/rtmutex.h b/kernel/rtmutex.h
index f6a1f3c133b1..c4060584c407 100644
--- a/kernel/rtmutex.h
+++ b/kernel/rtmutex.h
@@ -22,10 +22,15 @@
 #define debug_rt_mutex_init(m, n)			do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-#define debug_rt_mutex_detect_deadlock(w,d)		(d)
 #define debug_rt_mutex_reset_waiter(w)			do { } while (0)
 
 static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
 {
 	WARN(1, "rtmutex deadlock detected\n");
 }
+
+static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
+						  enum rtmutex_chainwalk walk)
+{
+	return walk == RT_MUTEX_FULL_CHAINWALK;
+}
diff --git a/kernel/rtmutex_common.h b/kernel/rtmutex_common.h
index efde34108ebc..213c7bf3c0d9 100644
--- a/kernel/rtmutex_common.h
+++ b/kernel/rtmutex_common.h
@@ -102,6 +102,21 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 }
 
 /*
+ * Constants for rt mutex functions which have a selectable deadlock
+ * detection.
+ *
+ * RT_MUTEX_MIN_CHAINWALK:	Stops the lock chain walk when there are
+ *				no further PI adjustments to be made.
+ *
+ * RT_MUTEX_FULL_CHAINWALK:	Invoke deadlock detection with a full
+ *				walk of the lock chain.
+ */
+enum rtmutex_chainwalk {
+	RT_MUTEX_MIN_CHAINWALK,
+	RT_MUTEX_FULL_CHAINWALK,
+};
+
+/*
  * PI-futex support (proxy locking functions, etc.):
  */
 #define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-- 
2.1.4
