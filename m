From: Alex Goins <agoins@nvidia.com>
Subject: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Tue, 24 Jan 2017 18:45:50 -0800
Message-ID: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Goins <agoins@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

mutex_destroy is no-op inline when DEBUG_MUTEX is not enabled. The RT Linux
patches replace mutex_destroy() with rt_mutex_destroy(). This patch aligns
rt_mutex_destroy() with mutex_destroy() by using the same no-op inline
technique.

Signed-off-by: Alex Goins <agoins@nvidia.com>
Reviewed-by: Andy Ritger <aritger@nvidia.com>
---
 include/linux/rtmutex.h  | 7 ++++++-
 kernel/locking/rtmutex.c | 5 ++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1abba5c..741e844 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -56,6 +56,12 @@ struct rt_mutex {
 #endif
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
+ extern void rt_mutex_destroy(struct rt_mutex *lock);
+#else
+ static inline void rt_mutex_destroy(struct rt_mutex *lock) {}
+#endif
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	, .name = #mutexname, .file = __FILE__, .line = __LINE__
 # define rt_mutex_init(mutex)			__rt_mutex_init(mutex, __func__)
@@ -87,7 +93,6 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 }
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
-extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2c49d76..8ff12fb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1577,6 +1577,7 @@ bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock,
 	return rt_mutex_slowunlock(lock, wqh);
 }
 
+#ifdef CONFIG_DEBUG_RT_MUTEXES
 /**
  * rt_mutex_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
@@ -1588,12 +1589,10 @@ bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock,
 void rt_mutex_destroy(struct rt_mutex *lock)
 {
 	WARN_ON(rt_mutex_is_locked(lock));
-#ifdef CONFIG_DEBUG_RT_MUTEXES
 	lock->magic = NULL;
-#endif
 }
-
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
+#endif
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
1.9.1
