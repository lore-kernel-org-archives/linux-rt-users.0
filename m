Return-Path: <SRS0=wDRI=3Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC725C3524B
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712572087E
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBDQ6U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:58:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBDQ6T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Feb 2020 11:58:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iz1Wd-0002bj-Kp; Tue, 04 Feb 2020 17:58:11 +0100
Date:   Tue, 4 Feb 2020 17:58:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.17-rt9
Message-ID: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.17-rt9 patch set. 

Changes since v5.4.17-rt8:

  - A rework of percpu-rwsem locking. The fs core was using a
    percpu-rwsem and returned with acquired lock to userland during
    `fsfreeze' which led warnings. On !RT the warnings were disabled but
    the same lockdep trick did not work on RT.
    Reported by Juri Lelli, patch(es) by Peter Zijlstra.

  - Include a header file the `current' macro to not break an allmod
    build on ARM.

  - A tweak to migrate_enable() to not having to wait until
    stop_one_cpu_nowait() finishes in case CPU-mask changed during
    migrate_disable() and the CPU has to be changed. Patch by Scott
    Wood.

  - Drop a lock earlier in mm/memcontrol. Not a bug but there is no need
    for the additional locked section. Patch by Matt Fleming.

Known issues
     - None

The delta patch against v5.4.17-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.17-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.17-rt9

The RT patch against v5.4.17 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.17-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.17-rt9.tar.xz

Sebastian

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 05a15110c8aa7..9b6b4def52d49 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -3,6 +3,7 @@
 
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 #ifdef CONFIG_PREEMPT_RT
 
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 9fa9a1dd9a11a..6e8d3871450a4 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -3,41 +3,52 @@
 #define _LINUX_PERCPU_RWSEM_H
 
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
 #include <linux/rcuwait.h>
+#include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
-	struct rw_semaphore	rw_sem; /* slowpath */
-	struct rcuwait          writer; /* blocked writer */
-	int			readers_block;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#else
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __DEFINE_PERCPU_RWSEM(name, is_static)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 is_static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
-	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
+	.block = ATOMIC_INIT(0),					\
+	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
+
 #define DEFINE_PERCPU_RWSEM(name)		\
 	__DEFINE_PERCPU_RWSEM(name, /* not static */)
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
-extern void __percpu_up_read(struct percpu_rw_semaphore *);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	preempt_disable();
 	/*
@@ -48,8 +59,9 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * and that once the synchronize_rcu() is done, the writer will see
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
 	 * The preempt_enable() prevents the compiler from
@@ -58,16 +70,17 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
+	bool ret = true;
 
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
 	/*
@@ -76,24 +89,36 @@ static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 
 	return ret;
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	if (likely(rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
 		__this_cpu_dec(*sem->read_count);
-	else
-		__percpu_up_read(sem); /* Unconditional memory barrier */
+	} else {
+		/*
+		 * slowpath; reader will only ever wake a single blocked
+		 * writer.
+		 */
+		smp_mb(); /* B matches C */
+		/*
+		 * In other words, if they see our decrement (presumably to
+		 * aggregate zero, as that is the only time it matters) they
+		 * will also see our critical section.
+		 */
+		__this_cpu_dec(*sem->read_count);
+		rcuwait_wake_up(&sem->writer);
+	}
 	preempt_enable();
-
-	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
@@ -110,29 +135,19 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 	__percpu_init_rwsem(sem, #sem, &rwsem_key);		\
 })
 
-#define percpu_rwsem_is_held(sem) lockdep_is_held(&(sem)->rw_sem)
-
-#define percpu_rwsem_assert_held(sem)				\
-	lockdep_assert_held(&(sem)->rw_sem)
+#define percpu_rwsem_is_held(sem) lockdep_is_held(sem)
+#define percpu_rwsem_assert_held(sem)  lockdep_assert_held(sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_release(&sem->rw_sem.dep_map, 1, ip);
-#if defined(CONFIG_RWSEM_SPIN_ON_OWNER) && !defined(CONFIG_PREEMPT_RT)
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
-#endif
+	lock_release(&sem->dep_map, 1, ip);
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
-#if defined(CONFIG_RWSEM_SPIN_ON_OWNER) && !defined(CONFIG_PREEMPT_RT)
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, (long)current);
-#endif
+	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
 }
 
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index b240dd987834f..393f4520befc9 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -58,12 +58,6 @@ struct rw_semaphore {
 #endif
 };
 
-/*
- * Setting all bits of the owner field except bit 0 will indicate
- * that the rwsem is writer-owned with an unknown owner.
- */
-#define RWSEM_OWNER_UNKNOWN	(-2L)
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2090f205b5c68..1781c47d81f0b 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -21,6 +21,7 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
 
 /*
  * A single wait-queue entry structure:
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a24fd4763263e..368309e9a1f52 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -331,12 +331,12 @@ void lockdep_assert_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
 {
-	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, 1, _THIS_IP_);
+	rwsem_release(&cpu_hotplug_lock.dep_map, 1, _THIS_IP_);
 }
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index d659c84716b46..dcb1f1182101e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -258,6 +258,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 		wake_up_process(task);
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(rcuwait_wake_up);
 
 /*
  * Determine if a process group is "orphaned", according to the POSIX
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 364d38a0c4441..e4a4a56037bb2 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -1,27 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 #include <linux/errno.h>
 
-#include "rwsem.h"
-
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
-			const char *name, struct lock_class_key *rwsem_key)
+			const char *name, struct lock_class_key *key)
 {
 	sem->read_count = alloc_percpu(int);
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
-	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
 	rcuwait_init(&sem->writer);
-	sem->readers_block = 0;
+	init_waitqueue_head(&sem->waiters);
+	atomic_set(&sem->block, 0);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__percpu_init_rwsem);
@@ -41,73 +43,139 @@ void percpu_free_rwsem(struct percpu_rw_semaphore *sem)
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
+	__this_cpu_inc(*sem->read_count);
+
 	/*
 	 * Due to having preemption disabled the decrement happens on
 	 * the same CPU as the increment, avoiding the
 	 * increment-on-one-CPU-and-decrement-on-another problem.
 	 *
-	 * If the reader misses the writer's assignment of readers_block, then
-	 * the writer is guaranteed to see the reader's increment.
+	 * If the reader misses the writer's assignment of sem->block, then the
+	 * writer is guaranteed to see the reader's increment.
 	 *
 	 * Conversely, any readers that increment their sem->read_count after
-	 * the writer looks are guaranteed to see the readers_block value,
-	 * which in turn means that they are guaranteed to immediately
-	 * decrement their sem->read_count, so that it doesn't matter that the
-	 * writer missed them.
+	 * the writer looks are guaranteed to see the sem->block value, which
+	 * in turn means that they are guaranteed to immediately decrement
+	 * their sem->read_count, so that it doesn't matter that the writer
+	 * missed them.
 	 */
 
 	smp_mb(); /* A matches D */
 
 	/*
-	 * If !readers_block the critical section starts here, matched by the
+	 * If !sem->block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!smp_load_acquire(&sem->readers_block)))
-		return 1;
+	if (likely(!atomic_read_acquire(&sem->block)))
+		return true;
 
-	/*
-	 * Per the above comment; we still have preemption disabled and
-	 * will thus decrement on the same CPU as we incremented.
-	 */
-	__percpu_up_read(sem);
-
-	if (try)
-		return 0;
-
-	/*
-	 * We either call schedule() in the wait, or we'll fall through
-	 * and reschedule on the preempt_enable() in percpu_down_read().
-	 */
-	preempt_enable_no_resched();
-
-	/*
-	 * Avoid lockdep for the down/up_read() we already have them.
-	 */
-	__down_read(&sem->rw_sem);
-	this_cpu_inc(*sem->read_count);
-	__up_read(&sem->rw_sem);
-
-	preempt_disable();
-	return 1;
-}
-EXPORT_SYMBOL_GPL(__percpu_down_read);
-
-void __percpu_up_read(struct percpu_rw_semaphore *sem)
-{
-	smp_mb(); /* B matches C */
-	/*
-	 * In other words, if they see our decrement (presumably to aggregate
-	 * zero, as that is the only time it matters) they will also see our
-	 * critical section.
-	 */
 	__this_cpu_dec(*sem->read_count);
 
-	/* Prod writer to recheck readers_active */
+	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
+
+	return false;
 }
-EXPORT_SYMBOL_GPL(__percpu_up_read);
+
+static inline bool __percpu_down_write_trylock(struct percpu_rw_semaphore *sem)
+{
+	if (atomic_read(&sem->block))
+		return false;
+
+	return atomic_xchg(&sem->block, 1) == 0;
+}
+
+static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
+{
+	if (reader) {
+		bool ret;
+
+		preempt_disable();
+		ret = __percpu_down_read_trylock(sem);
+		preempt_enable();
+
+		return ret;
+	}
+	return __percpu_down_write_trylock(sem);
+}
+
+/*
+ * The return value of wait_queue_entry::func means:
+ *
+ *  <0 - error, wakeup is terminated and the error is returned
+ *   0 - no wakeup, a next waiter is tried
+ *  >0 - woken, if EXCLUSIVE, counted towards @nr_exclusive.
+ *
+ * We use EXCLUSIVE for both readers and writers to preserve FIFO order,
+ * and play games with the return value to allow waking multiple readers.
+ *
+ * Specifically, we wake readers until we've woken a single writer, or until a
+ * trylock fails.
+ */
+static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
+				      unsigned int mode, int wake_flags,
+				      void *key)
+{
+	struct task_struct *p = get_task_struct(wq_entry->private);
+	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
+	struct percpu_rw_semaphore *sem = key;
+
+	/* concurrent against percpu_down_write(), can get stolen */
+	if (!__percpu_rwsem_trylock(sem, reader))
+		return 1;
+
+	list_del_init(&wq_entry->entry);
+	smp_store_release(&wq_entry->private, NULL);
+
+	wake_up_process(p);
+	put_task_struct(p);
+
+	return !reader; /* wake (readers until) 1 writer */
+}
+
+static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
+{
+	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
+	bool wait;
+
+	spin_lock_irq(&sem->waiters.lock);
+	/*
+	 * Serialize against the wakeup in percpu_up_write(), if we fail
+	 * the trylock, the wakeup must see us on the list.
+	 */
+	wait = !__percpu_rwsem_trylock(sem, reader);
+	if (wait) {
+		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
+		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+	}
+	spin_unlock_irq(&sem->waiters.lock);
+
+	while (wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!smp_load_acquire(&wq_entry.private))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+{
+	if (__percpu_down_read_trylock(sem))
+		return true;
+
+	if (try)
+		return false;
+
+	preempt_enable();
+	percpu_rwsem_wait(sem, /* .reader = */ true);
+	preempt_disable();
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(__percpu_down_read);
 
 #define per_cpu_sum(var)						\
 ({									\
@@ -124,6 +192,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
  * zero.  If this sum is zero, then it is stable due to the fact that if any
  * newly arriving readers increment a given counter, they will immediately
  * decrement that same counter.
+ *
+ * Assumes sem->block is set.
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
@@ -142,32 +212,36 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	might_sleep();
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	down_write(&sem->rw_sem);
+	/*
+	 * Try set sem->block; this provides writer-writer exclusion.
+	 * Having sem->block set makes new readers block.
+	 */
+	if (!__percpu_down_write_trylock(sem))
+		percpu_rwsem_wait(sem, /* .reader = */ false);
+
+	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
 
 	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
-	 */
-	WRITE_ONCE(sem->readers_block, 1);
-
-	smp_mb(); /* D matches A */
-
-	/*
-	 * If they don't see our writer of readers_block, then we are
-	 * guaranteed to see their sem->read_count increment, and therefore
-	 * will wait for them.
+	 * If they don't see our store of sem->block, then we are guaranteed to
+	 * see their sem->read_count increment, and therefore will wait for
+	 * them.
 	 */
 
-	/* Wait for all now active readers to complete. */
+	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
 void percpu_up_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+
 	/*
 	 * Signal the writer is done, no fast path yet.
 	 *
@@ -178,12 +252,12 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
+	atomic_set_release(&sem->block, 0);
 
 	/*
-	 * Release the write lock, this will allow readers back in the game.
+	 * Prod any pending reader/writer to make progress.
 	 */
-	up_write(&sem->rw_sem);
+	__wake_up(&sem->waiters, TASK_NORMAL, 1, sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 7d566aa1ab429..0d11ba11a32ac 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,8 +28,6 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 
-#include "rwsem.h"
-
 #ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
 
@@ -662,8 +660,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	unsigned long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
-
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
 		return false;
@@ -1341,7 +1337,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-inline void __down_read(struct rw_semaphore *sem)
+static inline void __down_read(struct rw_semaphore *sem)
 {
 	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
@@ -1429,7 +1425,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 /*
  * unlock after reading
  */
-inline void __up_read(struct rw_semaphore *sem)
+static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index cd7820880a4f4..e69de29bb2d1d 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __INTERNAL_RWSEM_H
-#define __INTERNAL_RWSEM_H
-#include <linux/rwsem.h>
-
-#ifndef CONFIG_PREEMPT_RT
-extern void __down_read(struct rw_semaphore *sem);
-extern void __up_read(struct rw_semaphore *sem);
-#endif
-
-#endif /* __INTERNAL_RWSEM_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 754f6afb438d8..ea05364619819 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8189,6 +8189,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -8227,22 +8230,24 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { .task = p };
-		struct cpu_stop_work work;
+		struct migration_arg __percpu *arg;
+		struct cpu_stop_work __percpu *work;
 		struct rq_flags rf;
 
+		work = this_cpu_ptr(&migrate_work);
+		arg = this_cpu_ptr(&migrate_arg);
+		WARN_ON_ONCE(!arg->done && !work->disabled && work->arg);
+
+		arg->task = p;
+		arg->done = false;
+
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-		arg.dest_cpu = select_fallback_rq(cpu, p);
+		arg->dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
-				    &arg, &work);
-		__schedule(true);
-		if (!work.disabled) {
-			while (!arg.done)
-				cpu_relax();
-		}
+				    arg, work);
 	}
 
 out:
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 953e106d6cb2d..1e3d9047474ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7043,10 +7043,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
 				     -nr_entries);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 
 	if (!mem_cgroup_is_root(memcg))
 		css_put_many(&memcg->css, nr_entries);
-	local_unlock_irqrestore(event_lock, flags);
 }
 
 /**
