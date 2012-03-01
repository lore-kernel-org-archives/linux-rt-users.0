From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/9][RFC] [PATCH 4/9] rtmutex: Add new mutex_lock_savestate() API
Date: Thu, 01 Mar 2012 13:55:31 -0500
Message-ID: <20120301190345.575650329@goodmis.org>
References: <20120301185527.064629423@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20848 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465Ab2CATDs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Mar 2012 14:03:48 -0500
Content-Disposition: inline; filename=0004-rtmutex-Add-new-mutex_lock_savestate-API.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To handle the case between CPU hotplugging and migrate_disable() the
cpu_hotplug.lock mutex is taken to postpone tasks from being pinned
to a CPU. This mutex is taken by all locations that do migrate_disable()
which includes spin_locks() that are converted to mutexes for PREEMPT_RT.

The problem is that grabbing the cpu_hotplug.lock mutex does not save the
task's state (TASK_INTERRUPTIBLE, etc), and may cause a task to not sleep
when it is expected. This causes lots of unexpected, hard to debug errors.

Create a new mutex_lock_savestate() API that lets the migrate_disable()
code for RT take the cpu_hotplug.lock mutex and still maintain the task's
state when the lock is released.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/mutex.h    |    2 ++
 include/linux/mutex_rt.h |    2 ++
 include/linux/rtmutex.h  |    1 +
 kernel/rt.c              |    6 ++++++
 kernel/rtmutex.c         |   12 ++++++++++++
 5 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index bdf1da2..910696b 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -163,6 +163,8 @@ extern int __must_check mutex_lock_killable(struct mutex *lock);
 # define mutex_lock_nest_lock(lock, nest_lock) mutex_lock(lock)
 #endif
 
+#define mutex_lock_savestate(lock) mutex_lock(lock)
+
 /*
  * NOTE: mutex_trylock() follows the spin_trylock() convention,
  *       not the down_trylock() convention!
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index c38a44b..fbdef29 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -30,6 +30,7 @@ extern void __mutex_do_init(struct mutex *lock, const char *name, struct lock_cl
 extern void __lockfunc _mutex_lock(struct mutex *lock);
 extern int __lockfunc _mutex_lock_interruptible(struct mutex *lock);
 extern int __lockfunc _mutex_lock_killable(struct mutex *lock);
+extern void __lockfunc _mutex_lock_savestate(struct mutex *lock);
 extern void __lockfunc _mutex_lock_nested(struct mutex *lock, int subclass);
 extern void __lockfunc _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
 extern int __lockfunc _mutex_lock_interruptible_nested(struct mutex *lock, int subclass);
@@ -41,6 +42,7 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock(l)			_mutex_lock(l)
 #define mutex_lock_interruptible(l)	_mutex_lock_interruptible(l)
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
+#define mutex_lock_savestate(l)		_mutex_lock_savestate(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
 #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 5ebd0bb..27a4b62 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -111,6 +111,7 @@ extern void rt_mutex_destroy(struct rt_mutex *lock);
 extern void rt_mutex_lock(struct rt_mutex *lock);
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock,
 						int detect_deadlock);
+extern void rt_mutex_lock_savestate(struct rt_mutex *lock);
 extern int rt_mutex_lock_killable(struct rt_mutex *lock, int detect_deadlock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 					struct hrtimer_sleeper *timeout,
diff --git a/kernel/rt.c b/kernel/rt.c
index 092d6b3..39641d0 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -117,6 +117,12 @@ int __lockfunc _mutex_lock_killable(struct mutex *lock)
 }
 EXPORT_SYMBOL(_mutex_lock_killable);
 
+void __lockfunc _mutex_lock_savestate(struct mutex *lock)
+{
+	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	rt_mutex_lock_savestate(&lock->lock);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc _mutex_lock_nested(struct mutex *lock, int subclass)
 {
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index b525158..a22c299 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -927,6 +927,18 @@ __rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 
+/*
+ * In some special cases in PREEMPT_RT, we need to grab a mutex
+ * but also keep the interruptible state like the rt_spinlocks
+ * do.
+ */
+void __lockfunc rt_mutex_lock_savestate(struct rt_mutex *lock)
+{
+	might_sleep();
+
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock);
+}
+
 #endif /* PREEMPT_RT_FULL */
 
 /**
-- 
1.7.3.4


