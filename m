From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 2/4] rtmutex: Provide rt_mutex_lock_state()
Date: Sat, 01 Apr 2017 12:51:00 +0200
Message-ID: <20170401112758.130515859@linutronix.de>
References: <20170401105058.958246042@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: RT-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=rtmutex-Provide-rt_mutex_lock_state-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Allow rtmutex to be locked with arbitrary states. Preparatory patch for the
rt rwsem rework.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h  |    1 +
 kernel/locking/rtmutex.c |   44 +++++++++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 19 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -105,6 +105,7 @@ extern void __rt_mutex_init(struct rt_mu
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
+extern int rt_mutex_lock_state(struct rt_mutex *lock, int state);
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2011,21 +2011,32 @@ rt_mutex_fastunlock(struct rt_mutex *loc
 }
 
 /**
+ * rt_mutex_lock_state - lock a rt_mutex with a given state
+ *
+ * @lock:	The rt_mutex to be locked
+ * @state:	The state to set when blocking on the rt_mutex
+ */
+int __sched rt_mutex_lock_state(struct rt_mutex *lock, int state)
+{
+	might_sleep();
+
+	return rt_mutex_fastlock(lock, state, NULL, rt_mutex_slowlock);
+}
+
+/**
  * rt_mutex_lock - lock a rt_mutex
  *
  * @lock: the rt_mutex to be locked
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, NULL, rt_mutex_slowlock);
+	rt_mutex_lock_state(lock, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 
 /**
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
- *
+ **
  * @lock:		the rt_mutex to be locked
  *
  * Returns:
@@ -2034,20 +2045,10 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, NULL, rt_mutex_slowlock);
+	return rt_mutex_lock_state(lock, TASK_INTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
-/*
- * Futex variant, must not use fastpath.
- */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return rt_mutex_slowtrylock(lock);
-}
-
 /**
  * rt_mutex_lock_killable - lock a rt_mutex killable
  *
@@ -2057,16 +2058,21 @@ int __sched rt_mutex_futex_trylock(struc
  * Returns:
  *  0          on success
  * -EINTR      when interrupted by a signal
- * -EDEADLK    when the lock would deadlock (when deadlock detection is on)
  */
 int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	return rt_mutex_fastlock(lock, TASK_KILLABLE, NULL, rt_mutex_slowlock);
+	return rt_mutex_lock_state(lock, TASK_KILLABLE);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
 
+/*
+ * Futex variant, must not use fastpath.
+ */
+int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return rt_mutex_slowtrylock(lock);
+}
+
 /**
  * rt_mutex_timed_lock - lock a rt_mutex interruptible
  *			the timeout structure is provided
