From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.20-rt16
Date: Tue, 4 Apr 2017 16:45:12 +0200
Message-ID: <20170404144512.hlkjz7cdujhsiba7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.9.20-rt16 patch set. 

Changes since v4.9.20-rt15:

  - Re-write of the R/W semaphores code. In RT we did not allow multiple
    readers because a writer blocking on the sempahore would have deal with
    all the readers in terms of priority or budget inheritance. It's
    obvious that the single reader restriction has severe performance
    problems for situations with heavy reader contention.
    The stall in the radeon driver observed by Carsten Emde (since
    v3.18-RT) and recently also reported by "Wargreen" seems to be caused
    by the single reader restriction. Wargreen confirmed that this
    rewrite fixes his radeon Problem. Patch(es) by Thomas Gleixner.

Known issues
	- CPU hotplug got a little better but can deadlock.

	- gdb. While gdb is following a task it is possible that after a
	  fork() operation the task is waiting for gdb and gdb waiting
	  for the task.

The delta patch against v4.9.20-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.20-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.20-rt16

The RT patch against v4.9.20 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.20-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.20-rt16.tar.xz

Sebastian
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -105,6 +105,7 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
+extern int rt_mutex_lock_state(struct rt_mutex *lock, int state);
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -110,6 +110,13 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 	return !list_empty(&sem->wait_list);
 }
 
+#endif /* !PREEMPT_RT_FULL */
+
+/*
+ * The functions below are the same for all rwsem implementations including
+ * the RT specific variant.
+ */
+
 /*
  * lock for reading
  */
@@ -188,6 +195,4 @@ extern void up_read_non_owner(struct rw_semaphore *sem);
 # define up_read_non_owner(sem)			up_read(sem)
 #endif
 
-#endif /* !PREEMPT_RT_FULL */
-
 #endif /* _LINUX_RWSEM_H */
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -5,163 +5,63 @@
 #error "Include rwsem.h"
 #endif
 
-/*
- * RW-semaphores are a spinlock plus a reader-depth count.
- *
- * Note that the semantics are different from the usual
- * Linux rw-sems, in PREEMPT_RT mode we do not allow
- * multiple readers to hold the lock at once, we only allow
- * a read-lock owner to read-lock recursively. This is
- * better for latency, makes the implementation inherently
- * fair and makes it simpler as well.
- */
-
 #include <linux/rtmutex.h>
+#include <linux/swait.h>
+
+#define READER_BIAS		(1U << 31)
+#define WRITER_BIAS		(1U << 30)
 
 struct rw_semaphore {
-	struct rt_mutex		lock;
-	int			read_depth;
+	atomic_t		readers;
+	struct rt_mutex		rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
 };
 
-#define __RWSEM_INITIALIZER(name) \
-	{ .lock = __RT_MUTEX_INITIALIZER(name.lock), \
-	  RW_DEP_MAP_INIT(name) }
+#define __RWSEM_INITIALIZER(name)				\
+{								\
+	.readers = ATOMIC_INIT(READER_BIAS),			\
+	.rtmutex = __RT_MUTEX_INITIALIZER(name.rtmutex),	\
+	RW_DEP_MAP_INIT(name)					\
+}
 
 #define DECLARE_RWSEM(lockname) \
 	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
 
-extern void  __rt_rwsem_init(struct rw_semaphore *rwsem, const char *name,
-				     struct lock_class_key *key);
+extern void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+			  struct lock_class_key *key);
 
-#define __rt_init_rwsem(sem, name, key)			\
-	do {						\
-		rt_mutex_init(&(sem)->lock);		\
-		__rt_rwsem_init((sem), (name), (key));\
-	} while (0)
+#define __init_rwsem(sem, name, key)			\
+do {							\
+		rt_mutex_init(&(sem)->rtmutex);		\
+		__rwsem_init((sem), (name), (key));	\
+} while (0)
 
-#define __init_rwsem(sem, name, key) __rt_init_rwsem(sem, name, key)
-
-# define rt_init_rwsem(sem)				\
+#define init_rwsem(sem)					\
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	__rt_init_rwsem((sem), #sem, &__key);		\
+	__init_rwsem((sem), #sem, &__key);		\
 } while (0)
 
-extern void rt_down_write(struct rw_semaphore *rwsem);
-extern int  rt_down_write_killable(struct rw_semaphore *rwsem);
-extern void rt_down_read_nested(struct rw_semaphore *rwsem, int subclass);
-extern void rt_down_write_nested(struct rw_semaphore *rwsem, int subclass);
-extern int  rt_down_write_killable_nested(struct rw_semaphore *rwsem,
-					  int subclass);
-extern void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
-				      struct lockdep_map *nest);
-extern void rt__down_read(struct rw_semaphore *rwsem);
-extern void rt_down_read(struct rw_semaphore *rwsem);
-extern int  rt_down_write_trylock(struct rw_semaphore *rwsem);
-extern int  rt__down_read_trylock(struct rw_semaphore *rwsem);
-extern int  rt_down_read_trylock(struct rw_semaphore *rwsem);
-extern void __rt_up_read(struct rw_semaphore *rwsem);
-extern void rt_up_read(struct rw_semaphore *rwsem);
-extern void rt_up_write(struct rw_semaphore *rwsem);
-extern void rt_downgrade_write(struct rw_semaphore *rwsem);
-
-#define init_rwsem(sem)		rt_init_rwsem(sem)
-#define rwsem_is_locked(s)	rt_mutex_is_locked(&(s)->lock)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
+{
+	return atomic_read(&sem->readers) != READER_BIAS;
+}
 
 static inline int rwsem_is_contended(struct rw_semaphore *sem)
 {
-	/* rt_mutex_has_waiters() */
-	return !RB_EMPTY_ROOT(&sem->lock.waiters);
+	return atomic_read(&sem->readers) > 0;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	rt__down_read(sem);
-}
+extern void __down_read(struct rw_semaphore *sem);
+extern int __down_read_trylock(struct rw_semaphore *sem);
+extern void __down_write(struct rw_semaphore *sem);
+extern int __must_check __down_write_killable(struct rw_semaphore *sem);
+extern int __down_write_trylock(struct rw_semaphore *sem);
+extern void __up_read(struct rw_semaphore *sem);
+extern void __up_write(struct rw_semaphore *sem);
+extern void __downgrade_write(struct rw_semaphore *sem);
 
-static inline void down_read(struct rw_semaphore *sem)
-{
-	rt_down_read(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	return rt__down_read_trylock(sem);
-}
-
-static inline int down_read_trylock(struct rw_semaphore *sem)
-{
-	return rt_down_read_trylock(sem);
-}
-
-static inline void down_write(struct rw_semaphore *sem)
-{
-	rt_down_write(sem);
-}
-
-static inline int down_write_killable(struct rw_semaphore *sem)
-{
-	return rt_down_write_killable(sem);
-}
-
-static inline int down_write_trylock(struct rw_semaphore *sem)
-{
-	return rt_down_write_trylock(sem);
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__rt_up_read(sem);
-}
-
-static inline void up_read(struct rw_semaphore *sem)
-{
-	rt_up_read(sem);
-}
-
-static inline void up_write(struct rw_semaphore *sem)
-{
-	rt_up_write(sem);
-}
-
-static inline void downgrade_write(struct rw_semaphore *sem)
-{
-	rt_downgrade_write(sem);
-}
-
-static inline void down_read_nested(struct rw_semaphore *sem, int subclass)
-{
-	return rt_down_read_nested(sem, subclass);
-}
-
-static inline void down_write_nested(struct rw_semaphore *sem, int subclass)
-{
-	rt_down_write_nested(sem, subclass);
-}
-
-static inline int down_write_killable_nested(struct rw_semaphore *sem,
-					     int subclass)
-{
-	return rt_down_write_killable_nested(sem, subclass);
-}
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static inline void down_write_nest_lock(struct rw_semaphore *sem,
-		struct rw_semaphore *nest_lock)
-{
-	rt_down_write_nested_lock(sem, &nest_lock->dep_map);
-}
-
-#else
-
-static inline void down_write_nest_lock(struct rw_semaphore *sem,
-		struct rw_semaphore *nest_lock)
-{
-	rt_down_write_nested_lock(sem, NULL);
-}
-#endif
 #endif
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -14,8 +14,8 @@ endif
 ifneq ($(CONFIG_PREEMPT_RT_FULL),y)
 obj-y += mutex.o
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
-obj-y += rwsem.o
 endif
+obj-y += rwsem.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
 ifeq ($(CONFIG_PROC_FS),y)
 obj-$(CONFIG_LOCKDEP) += lockdep_proc.o
@@ -32,6 +32,6 @@ ifneq ($(CONFIG_PREEMPT_RT_FULL),y)
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem-xadd.o
 endif
-obj-$(CONFIG_PREEMPT_RT_FULL) += rt.o
+obj-$(CONFIG_PREEMPT_RT_FULL) += rt.o rwsem-rt.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -306,173 +306,6 @@ void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__rt_rwlock_init);
 
-/*
- * rw_semaphores
- */
-
-void  rt_up_write(struct rw_semaphore *rwsem)
-{
-	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	rt_mutex_unlock(&rwsem->lock);
-}
-EXPORT_SYMBOL(rt_up_write);
-
-void __rt_up_read(struct rw_semaphore *rwsem)
-{
-	if (--rwsem->read_depth == 0)
-		rt_mutex_unlock(&rwsem->lock);
-}
-
-void  rt_up_read(struct rw_semaphore *rwsem)
-{
-	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	__rt_up_read(rwsem);
-}
-EXPORT_SYMBOL(rt_up_read);
-
-/*
- * downgrade a write lock into a read lock
- * - just wake up any readers at the front of the queue
- */
-void  rt_downgrade_write(struct rw_semaphore *rwsem)
-{
-	BUG_ON(rt_mutex_owner(&rwsem->lock) != current);
-	rwsem->read_depth = 1;
-}
-EXPORT_SYMBOL(rt_downgrade_write);
-
-int  rt_down_write_trylock(struct rw_semaphore *rwsem)
-{
-	int ret = rt_mutex_trylock(&rwsem->lock);
-
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
-	return ret;
-}
-EXPORT_SYMBOL(rt_down_write_trylock);
-
-void  rt_down_write(struct rw_semaphore *rwsem)
-{
-	rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
-}
-EXPORT_SYMBOL(rt_down_write);
-
-int rt_down_write_killable(struct rw_semaphore *rwsem)
-{
-	int ret;
-
-	rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&rwsem->lock);
-	if (ret)
-		rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	return ret;
-}
-EXPORT_SYMBOL(rt_down_write_killable);
-
-int rt_down_write_killable_nested(struct rw_semaphore *rwsem, int subclass)
-{
-	int ret;
-
-	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&rwsem->lock);
-	if (ret)
-		rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	return ret;
-}
-EXPORT_SYMBOL(rt_down_write_killable_nested);
-
-void  rt_down_write_nested(struct rw_semaphore *rwsem, int subclass)
-{
-	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
-}
-EXPORT_SYMBOL(rt_down_write_nested);
-
-void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
-			       struct lockdep_map *nest)
-{
-	rwsem_acquire_nest(&rwsem->dep_map, 0, 0, nest, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
-}
-EXPORT_SYMBOL(rt_down_write_nested_lock);
-
-int rt__down_read_trylock(struct rw_semaphore *rwsem)
-{
-	struct rt_mutex *lock = &rwsem->lock;
-	int ret = 1;
-
-	/*
-	 * recursive read locks succeed when current owns the rwsem,
-	 * but not when read_depth == 0 which means that the rwsem is
-	 * write locked.
-	 */
-	if (rt_mutex_owner(lock) != current)
-		ret = rt_mutex_trylock(&rwsem->lock);
-	else if (!rwsem->read_depth)
-		ret = 0;
-
-	if (ret)
-		rwsem->read_depth++;
-	return ret;
-
-}
-
-int  rt_down_read_trylock(struct rw_semaphore *rwsem)
-{
-	int ret;
-
-	ret = rt__down_read_trylock(rwsem);
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
-
-	return ret;
-}
-EXPORT_SYMBOL(rt_down_read_trylock);
-
-void rt__down_read(struct rw_semaphore *rwsem)
-{
-	struct rt_mutex *lock = &rwsem->lock;
-
-	if (rt_mutex_owner(lock) != current)
-		rt_mutex_lock(&rwsem->lock);
-	rwsem->read_depth++;
-}
-EXPORT_SYMBOL(rt__down_read);
-
-static void __rt_down_read(struct rw_semaphore *rwsem, int subclass)
-{
-	rwsem_acquire_read(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt__down_read(rwsem);
-}
-
-void  rt_down_read(struct rw_semaphore *rwsem)
-{
-	__rt_down_read(rwsem, 0);
-}
-EXPORT_SYMBOL(rt_down_read);
-
-void  rt_down_read_nested(struct rw_semaphore *rwsem, int subclass)
-{
-	__rt_down_read(rwsem, subclass);
-}
-EXPORT_SYMBOL(rt_down_read_nested);
-
-void  __rt_rwsem_init(struct rw_semaphore *rwsem, const char *name,
-			      struct lock_class_key *key)
-{
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/*
-	 * Make sure we are not reinitializing a held lock:
-	 */
-	debug_check_no_locks_freed((void *)rwsem, sizeof(*rwsem));
-	lockdep_init_map(&rwsem->dep_map, name, key, 0);
-#endif
-	rwsem->read_depth = 0;
-	rwsem->lock.save_state = 0;
-}
-EXPORT_SYMBOL(__rt_rwsem_init);
-
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
  * @cnt: the atomic which we are to dec
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1633,18 +1633,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (unlikely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		if (ww_ctx && ww_ctx->acquired > 0) {
@@ -1763,6 +1758,58 @@ static void ww_mutex_account_lock(struct rt_mutex *lock,
 }
 #endif
 
+int __sched rt_mutex_slowlock_locked(struct rt_mutex *lock, int state,
+				     struct hrtimer_sleeper *timeout,
+				     enum rtmutex_chainwalk chwalk,
+				     struct ww_acquire_ctx *ww_ctx,
+				     struct rt_mutex_waiter *waiter)
+{
+	int ret;
+
+	/* Try to acquire the lock again: */
+	if (try_to_take_rt_mutex(lock, current, NULL)) {
+		if (ww_ctx)
+			ww_mutex_account_lock(lock, ww_ctx);
+		return 0;
+	}
+
+	set_current_state(state);
+
+	/* Setup the timer, when timeout != NULL */
+	if (unlikely(timeout))
+		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
+
+	ret = task_blocks_on_rt_mutex(lock, waiter, current, chwalk);
+
+	if (likely(!ret)) {
+		/* sleep on the mutex */
+		ret = __rt_mutex_slowlock(lock, state, timeout, waiter,
+					  ww_ctx);
+	} else if (ww_ctx) {
+		/* ww_mutex received EDEADLK, let it become EALREADY */
+		ret = __mutex_lock_check_stamp(lock, ww_ctx);
+		BUG_ON(!ret);
+	}
+
+	if (unlikely(ret)) {
+		__set_current_state(TASK_RUNNING);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, waiter);
+	} else if (ww_ctx) {
+		ww_mutex_account_lock(lock, ww_ctx);
+	}
+
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit
+	 * unconditionally. We might have to fix that up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+	return ret;
+}
+
 /*
  * Slow path lock function:
  */
@@ -1788,48 +1835,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
-	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock, current, NULL)) {
-		if (ww_ctx)
-			ww_mutex_account_lock(lock, ww_ctx);
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return 0;
-	}
-
-	set_current_state(state);
-
-	/* Setup the timer, when timeout != NULL */
-	if (unlikely(timeout))
-		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
-
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
-
-	if (likely(!ret))
-		/* sleep on the mutex */
-		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter,
-					  ww_ctx);
-	else if (ww_ctx) {
-		/* ww_mutex received EDEADLK, let it become EALREADY */
-		ret = __mutex_lock_check_stamp(lock, ww_ctx);
-		BUG_ON(!ret);
-	}
-
-	if (unlikely(ret)) {
-		__set_current_state(TASK_RUNNING);
-		if (rt_mutex_has_waiters(lock))
-			remove_waiter(lock, &waiter);
-		/* ww_mutex want to report EDEADLK/EALREADY, let them */
-		if (!ww_ctx)
-			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
-	} else if (ww_ctx) {
-		ww_mutex_account_lock(lock, ww_ctx);
-	}
-
-	/*
-	 * try_to_take_rt_mutex() sets the waiter bit
-	 * unconditionally. We might have to fix that up.
-	 */
-	fixup_rt_mutex_waiters(lock);
+	ret = rt_mutex_slowlock_locked(lock, state, timeout, chwalk, ww_ctx,
+				       &waiter);
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
@@ -2016,21 +2023,32 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
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
@@ -2039,20 +2057,10 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
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
@@ -2062,16 +2070,21 @@ int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
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
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -129,6 +129,15 @@ extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
 
 extern void rt_mutex_adjust_prio(struct task_struct *task);
 
+/* RW semaphore special interface */
+struct ww_acquire_ctx;
+
+int __sched rt_mutex_slowlock_locked(struct rt_mutex *lock, int state,
+				     struct hrtimer_sleeper *timeout,
+				     enum rtmutex_chainwalk chwalk,
+				     struct ww_acquire_ctx *ww_ctx,
+				     struct rt_mutex_waiter *waiter);
+
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
 #else
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
new file mode 100644
--- /dev/null
+++ b/kernel/locking/rwsem-rt.c
@@ -0,0 +1,268 @@
+/*
+ */
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/export.h>
+
+#include "rtmutex_common.h"
+
+/*
+ * RT-specific reader/writer semaphores
+ *
+ * down_write()
+ *  1) Lock sem->rtmutex
+ *  2) Remove the reader BIAS to force readers into the slow path
+ *  3) Wait until all readers have left the critical region
+ *  4) Mark it write locked
+ *
+ * up_write()
+ *  1) Remove the write locked marker
+ *  2) Set the reader BIAS so readers can use the fast path again
+ *  3) Unlock sem->rtmutex to release blocked readers
+ *
+ * down_read()
+ *  1) Try fast path acquisition (reader BIAS is set)
+ *  2) Take sem->rtmutex.wait_lock which protects the writelocked flag
+ *  3) If !writelocked, acquire it for read
+ *  4) If writelocked, block on sem->rtmutex
+ *  5) unlock sem->rtmutex, goto 1)
+ *
+ * up_read()
+ *  1) Try fast path release (reader count != 1)
+ *  2) Wake the writer waiting in down_write()#3
+ *
+ * down_read()#3 has the consequence, that rw semaphores on RT are not writer
+ * fair, but writers, which should be avoided in RT tasks (think mmap_sem),
+ * are subject to the rtmutex priority/DL inheritance mechanism.
+ *
+ * It's possible to make the rw semaphores writer fair by keeping a list of
+ * active readers. A blocked writer would force all newly incoming readers to
+ * block on the rtmutex, but the rtmutex would have to be proxy locked for one
+ * reader after the other. We can't use multi-reader inheritance because there
+ * is no way to support that with SCHED_DEADLINE. Implementing the one by one
+ * reader boosting/handover mechanism is a major surgery for a very dubious
+ * value.
+ *
+ * The risk of writer starvation is there, but the pathological use cases
+ * which trigger it are not necessarily the typical RT workloads.
+ */
+
+void __rwsem_init(struct rw_semaphore *sem, const char *name,
+		  struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held semaphore:
+	 */
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
+	atomic_set(&sem->readers, READER_BIAS);
+}
+EXPORT_SYMBOL(__rwsem_init);
+
+int __down_read_trylock(struct rw_semaphore *sem)
+{
+	int r, old;
+
+	/*
+	 * Increment reader count, if sem->readers < 0, i.e. READER_BIAS is
+	 * set.
+	 */
+	for (r = atomic_read(&sem->readers); r < 0;) {
+		old = atomic_cmpxchg(&sem->readers, r, r + 1);
+		if (likely(old == r))
+			return 1;
+		r = old;
+	}
+	return 0;
+}
+
+void __sched __down_read(struct rw_semaphore *sem)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	struct rt_mutex_waiter waiter;
+
+	if (__down_read_trylock(sem))
+		return;
+
+	might_sleep();
+	raw_spin_lock_irq(&m->wait_lock);
+	/*
+	 * Allow readers as long as the writer has not completely
+	 * acquired the semaphore for write.
+	 */
+	if (atomic_read(&sem->readers) != WRITER_BIAS) {
+		atomic_inc(&sem->readers);
+		raw_spin_unlock_irq(&m->wait_lock);
+		return;
+	}
+
+	/*
+	 * Call into the slow lock path with the rtmutex->wait_lock
+	 * held, so this can't result in the following race:
+	 *
+	 * Reader1		Reader2		Writer
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					swait()
+	 * down_read()
+	 * unlock(m->wait_lock)
+	 *			up_read()
+	 *			swake()
+	 *					lock(m->wait_lock)
+	 *					sem->writelocked=true
+	 *					unlock(m->wait_lock)
+	 *
+	 *					up_write()
+	 *					sem->writelocked=false
+	 *					rtmutex_unlock(m)
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					swait()
+	 * rtmutex_lock(m)
+	 *
+	 * That would put Reader1 behind the writer waiting on
+	 * Reader2 to call up_read() which might be unbound.
+	 */
+	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_slowlock_locked(m, TASK_UNINTERRUPTIBLE, NULL,
+				 RT_MUTEX_MIN_CHAINWALK, NULL,
+				 &waiter);
+	/*
+	 * The slowlock() above is guaranteed to return with the rtmutex is
+	 * now held, so there can't be a writer active. Increment the reader
+	 * count and immediately drop the rtmutex again.
+	 */
+	atomic_inc(&sem->readers);
+	raw_spin_unlock_irq(&m->wait_lock);
+	rt_mutex_unlock(m);
+
+	debug_rt_mutex_free_waiter(&waiter);
+}
+
+void __up_read(struct rw_semaphore *sem)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	struct task_struct *tsk;
+
+	/*
+	 * sem->readers can only hit 0 when a writer is waiting for the
+	 * active readers to leave the critical region.
+	 */
+	if (!atomic_dec_and_test(&sem->readers))
+		return;
+
+	might_sleep();
+	raw_spin_lock_irq(&m->wait_lock);
+	/*
+	 * Wake the writer, i.e. the rtmutex owner. It might release the
+	 * rtmutex concurrently in the fast path (due to a signal), but to
+	 * clean up the rwsem it needs to acquire m->wait_lock. The worst
+	 * case which can happen is a spurious wakeup.
+	 */
+	tsk = rt_mutex_owner(m);
+	if (tsk)
+		wake_up_process(tsk);
+
+	raw_spin_unlock_irq(&m->wait_lock);
+}
+
+static void __up_write_unlock(struct rw_semaphore *sem, int bias,
+			      unsigned long flags)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+
+	atomic_add(READER_BIAS - bias, &sem->readers);
+	raw_spin_unlock_irqrestore(&m->wait_lock, flags);
+	rt_mutex_unlock(m);
+}
+
+static int __sched __down_write_common(struct rw_semaphore *sem, int state)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	unsigned long flags;
+
+	/* Take the rtmutex as a first step */
+	if (rt_mutex_lock_state(m, state))
+		return -EINTR;
+
+	/* Force readers into slow path */
+	atomic_sub(READER_BIAS, &sem->readers);
+	might_sleep();
+
+	set_current_state(state);
+	for (;;) {
+		raw_spin_lock_irqsave(&m->wait_lock, flags);
+		/* Have all readers left the critical region? */
+		if (!atomic_read(&sem->readers)) {
+			atomic_set(&sem->readers, WRITER_BIAS);
+			__set_current_state(TASK_RUNNING);
+			raw_spin_unlock_irqrestore(&m->wait_lock, flags);
+			return 0;
+		}
+
+		if (signal_pending_state(state, current)) {
+			__set_current_state(TASK_RUNNING);
+			__up_write_unlock(sem, 0, flags);
+			return -EINTR;
+		}
+		raw_spin_unlock_irqrestore(&m->wait_lock, flags);
+
+		if (atomic_read(&sem->readers) != 0) {
+			schedule();
+			set_current_state(state);
+		}
+	}
+}
+
+void __sched __down_write(struct rw_semaphore *sem)
+{
+	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
+}
+
+int __sched __down_write_killable(struct rw_semaphore *sem)
+{
+	return __down_write_common(sem, TASK_KILLABLE);
+}
+
+int __down_write_trylock(struct rw_semaphore *sem)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	unsigned long flags;
+
+	if (!rt_mutex_trylock(m))
+		return 0;
+
+	atomic_sub(READER_BIAS, &sem->readers);
+
+	raw_spin_lock_irqsave(&m->wait_lock, flags);
+	if (!atomic_read(&sem->readers)) {
+		atomic_set(&sem->readers, WRITER_BIAS);
+		raw_spin_unlock_irqrestore(&m->wait_lock, flags);
+		return 1;
+	}
+	__up_write_unlock(sem, 0, flags);
+	return 0;
+}
+
+void __up_write(struct rw_semaphore *sem)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&m->wait_lock, flags);
+	__up_write_unlock(sem, WRITER_BIAS, flags);
+}
+
+void __downgrade_write(struct rw_semaphore *sem)
+{
+	struct rt_mutex *m = &sem->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&m->wait_lock, flags);
+	/* Release it and account current as reader */
+	__up_write_unlock(sem, WRITER_BIAS - 1, flags);
+}
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
