Return-Path: <SRS0=0bHC=D7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C025C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Oct 2020 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B13C20936
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Oct 2020 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvmUk3d7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubEmpQEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760428AbgJXJSr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 24 Oct 2020 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760422AbgJXJSp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 24 Oct 2020 05:18:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E6C0613CE;
        Sat, 24 Oct 2020 02:18:41 -0700 (PDT)
Date:   Sat, 24 Oct 2020 11:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603531120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pszqSLg+POwkOWnImZcjqxJMoXLQCjWCfuSc0Gqd814=;
        b=tvmUk3d70HDR6SqxoO7ACuPZxVUHhjObauIk63T8HG32p2nb6RWDxqxc5L3TCtOFB21AXv
        0daUg1mXI1uJrj5tcs2yfPzp/yLrXTrxfZs83749elZx25DI7g5agttgGUrPR8A3xs5rOD
        NEU+lEs6DCmEgin/OBftmzzLS9jd9jW1n6MC0K1N7kOygGYmRYbCXaCD3V5iIx3pe2Ei3E
        7Y9Sxo0pRWkZb372bCCsHNURYG3zVspM8ztENAFfPrIjxld4x2ya74g5X4UipKPmFuay/l
        fwYkjX3f6pI1JgC5cOw3kP8d89lD2hEVD8CF9HS9TukVhQBj2tqMXU22rPWeHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603531120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pszqSLg+POwkOWnImZcjqxJMoXLQCjWCfuSc0Gqd814=;
        b=ubEmpQEOmrjjZ3JziFzw3ooweL+VOREz3/s+1IhuzGr4Hyo13ySYsCUgrep2WbqWzwt7wx
        NIm+HNIcIKU0bACw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9.1-rt19 patch set. 

Changes since v5.9.1-rt18:

  - Mike Galbraith reported a possible circular locking dependency with
    a seqcount. Backported a patch from upstream solving the issue.

  - David Runge reported a crash in the block layer.

  - The migrate-disable series by Peter Zijlstra has been update to v4.

  - Mike Galbraith reported a possible hang due to the new printk code.
    Dropped a patch from the printk code which was causing the problem
    as suggested by John Ogness.

  - The rtmutex clean up in v5.9-rc8-rt12 restructured the code path and
    removed the blk_schedule_flush_plug() invocation from the locking
    path. It turns out that it is still required and has been added
    back.

  - A small rtmutex related clean up:

    - Remove rt_mutex_lock_killable(), it has no users.

    - Use _mutex_lock_io_nested() for _mutex_lock_io() to avoid
      duplicated code.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9.1-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9.1-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9.1-rt19

The RT patch against v5.9.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9.1-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9.1-rt19.tar.xz

Sebastian

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e37aa31332b70..99d2fb51e0e84 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -647,7 +647,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 {
 	int cpu = raw_smp_processor_id();
 
-	if (!IS_ENABLED(CONFIG_SMP) ||
+	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
 
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index 7179367bfb5e2..f0b2e07cd5c57 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -29,7 +29,6 @@ struct mutex {
 
 extern void __mutex_do_init(struct mutex *lock, const char *name, struct lock_class_key *key);
 extern void __lockfunc _mutex_lock(struct mutex *lock);
-extern void __lockfunc _mutex_lock_io(struct mutex *lock);
 extern void __lockfunc _mutex_lock_io_nested(struct mutex *lock, int subclass);
 extern int __lockfunc _mutex_lock_interruptible(struct mutex *lock);
 extern int __lockfunc _mutex_lock_killable(struct mutex *lock);
@@ -46,7 +45,7 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
-#define mutex_lock_io(l)		_mutex_lock_io(l);
+#define mutex_lock_io(l)		_mutex_lock_io_nested(l, 0);
 
 #define __mutex_owner(l)		((l)->lock.owner)
 
@@ -77,7 +76,7 @@ do {									\
 # define mutex_lock_killable_nested(l, s) \
 					_mutex_lock_killable(l)
 # define mutex_lock_nest_lock(lock, nest_lock) mutex_lock(lock)
-# define mutex_lock_io_nested(l, s)	_mutex_lock_io(l)
+# define mutex_lock_io_nested(l, s)	_mutex_lock_io_nested(l, s)
 #endif
 
 # define mutex_init(mutex)				\
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 5308cd7ddddf0..b02009f530263 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -112,7 +112,6 @@ extern void rt_mutex_lock(struct rt_mutex *lock);
 #endif
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
-extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f73c7eb68f27c..76e44e6c01004 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -173,6 +173,19 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @lock:	Pointer to the associated lock
  */
 
+#define seqcount_LOCKNAME_init(s, _lock, lockname)			\
+	do {								\
+		seqcount_##lockname##_t *____s = (s);			\
+		seqcount_init(&____s->seqcount);			\
+		__SEQ_LOCK(____s->lock = (_lock));			\
+	} while (0)
+
+#define seqcount_raw_spinlock_init(s, lock)	seqcount_LOCKNAME_init(s, lock, raw_spinlock)
+#define seqcount_spinlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, spinlock)
+#define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock);
+#define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex);
+#define seqcount_ww_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, ww_mutex);
+
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
  * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
@@ -190,13 +203,6 @@ typedef struct seqcount_##lockname {					\
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
-static __always_inline void						\
-seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
-{									\
-	seqcount_init(&s->seqcount);					\
-	__SEQ_LOCK(s->lock = lock);					\
-}									\
-									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -284,8 +290,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
-#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
diff --git a/kernel/locking/mutex-rt.c b/kernel/locking/mutex-rt.c
index 35b06711997dd..2b849e6b9b4ae 100644
--- a/kernel/locking/mutex-rt.c
+++ b/kernel/locking/mutex-rt.c
@@ -65,6 +65,7 @@
 #include <linux/fs.h>
 #include <linux/futex.h>
 #include <linux/hrtimer.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -85,55 +86,24 @@ void __mutex_do_init(struct mutex *mutex, const char *name,
 }
 EXPORT_SYMBOL(__mutex_do_init);
 
+static int _mutex_lock_blk_flush(struct mutex *lock, int state)
+{
+	/*
+	 * Flush blk before ->pi_blocked_on is set. At schedule() time it is too
+	 * late if one of the callbacks needs to acquire a sleeping lock.
+	 */
+	if (blk_needs_flush_plug(current))
+		blk_schedule_flush_plug(current);
+	return __rt_mutex_lock_state(&lock->lock, state);
+}
+
 void __lockfunc _mutex_lock(struct mutex *lock)
 {
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	__rt_mutex_lock_state(&lock->lock, TASK_UNINTERRUPTIBLE);
+	_mutex_lock_blk_flush(lock, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(_mutex_lock);
 
-void __lockfunc _mutex_lock_io(struct mutex *lock)
-{
-	int token;
-
-	token = io_schedule_prepare();
-	_mutex_lock(lock);
-	io_schedule_finish(token);
-}
-EXPORT_SYMBOL_GPL(_mutex_lock_io);
-
-int __lockfunc _mutex_lock_interruptible(struct mutex *lock)
-{
-	int ret;
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = __rt_mutex_lock_state(&lock->lock, TASK_INTERRUPTIBLE);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-	return ret;
-}
-EXPORT_SYMBOL(_mutex_lock_interruptible);
-
-int __lockfunc _mutex_lock_killable(struct mutex *lock)
-{
-	int ret;
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = __rt_mutex_lock_state(&lock->lock, TASK_KILLABLE);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-	return ret;
-}
-EXPORT_SYMBOL(_mutex_lock_killable);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-void __lockfunc _mutex_lock_nested(struct mutex *lock, int subclass)
-{
-	mutex_acquire_nest(&lock->dep_map, subclass, 0, NULL, _RET_IP_);
-	__rt_mutex_lock_state(&lock->lock, TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL(_mutex_lock_nested);
-
 void __lockfunc _mutex_lock_io_nested(struct mutex *lock, int subclass)
 {
 	int token;
@@ -147,10 +117,42 @@ void __lockfunc _mutex_lock_io_nested(struct mutex *lock, int subclass)
 }
 EXPORT_SYMBOL_GPL(_mutex_lock_io_nested);
 
+int __lockfunc _mutex_lock_interruptible(struct mutex *lock)
+{
+	int ret;
+
+	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	ret = _mutex_lock_blk_flush(lock, TASK_INTERRUPTIBLE);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(_mutex_lock_interruptible);
+
+int __lockfunc _mutex_lock_killable(struct mutex *lock)
+{
+	int ret;
+
+	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	ret = _mutex_lock_blk_flush(lock, TASK_KILLABLE);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(_mutex_lock_killable);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __lockfunc _mutex_lock_nested(struct mutex *lock, int subclass)
+{
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, NULL, _RET_IP_);
+	_mutex_lock_blk_flush(lock, TASK_UNINTERRUPTIBLE);
+}
+EXPORT_SYMBOL(_mutex_lock_nested);
+
 void __lockfunc _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest)
 {
 	mutex_acquire_nest(&lock->dep_map, 0, 0, nest, _RET_IP_);
-	__rt_mutex_lock_state(&lock->lock, TASK_UNINTERRUPTIBLE);
+	_mutex_lock_blk_flush(lock, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(_mutex_lock_nest_lock);
 
@@ -159,7 +161,7 @@ int __lockfunc _mutex_lock_interruptible_nested(struct mutex *lock, int subclass
 	int ret;
 
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, NULL, _RET_IP_);
-	ret = __rt_mutex_lock_state(&lock->lock, TASK_INTERRUPTIBLE);
+	ret = _mutex_lock_blk_flush(lock, TASK_INTERRUPTIBLE);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
@@ -171,7 +173,7 @@ int __lockfunc _mutex_lock_killable_nested(struct mutex *lock, int subclass)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	ret = __rt_mutex_lock_state(&lock->lock, TASK_KILLABLE);
+	ret = _mutex_lock_blk_flush(lock, TASK_KILLABLE);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ef22e1b52f8c8..cc0d7e99be00a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2034,21 +2034,6 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
 	return __rt_mutex_slowtrylock(lock);
 }
 
-/**
- * rt_mutex_lock_killable - lock a rt_mutex killable
- *
- * @lock:		the rt_mutex to be locked
- *
- * Returns:
- *  0		on success
- * -EINTR	when interrupted by a signal
- */
-int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
-{
-	return rt_mutex_lock_state(lock, 0, TASK_KILLABLE);
-}
-EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
-
 int __sched __rt_mutex_trylock(struct rt_mutex *lock)
 {
 #ifdef CONFIG_PREEMPT_RT
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index bca7a448206d6..ab05ce0903537 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -3,6 +3,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
 #include <linux/export.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -87,6 +88,13 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
 	if (__down_read_trylock(sem))
 		return 0;
 
+	/*
+	 * Flush blk before ->pi_blocked_on is set. At schedule() time it is too
+	 * late if one of the callbacks needs to acquire a sleeping lock.
+	 */
+	if (blk_needs_flush_plug(current))
+		blk_schedule_flush_plug(current);
+
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
@@ -209,6 +217,13 @@ static int __sched __down_write_common(struct rw_semaphore *sem, int state)
 	struct rt_mutex *m = &sem->rtmutex;
 	unsigned long flags;
 
+	/*
+	 * Flush blk before ->pi_blocked_on is set. At schedule() time it is too
+	 * late if one of the callbacks needs to acquire a sleeping lock.
+	 */
+	if (blk_needs_flush_plug(current))
+		blk_schedule_flush_plug(current);
+
 	/* Take the rtmutex as a first step */
 	if (__rt_mutex_lock_state(m, state))
 		return -EINTR;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 78a277ea5c351..0c56873396a99 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3140,66 +3140,6 @@ const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
 
-/**
- * pr_flush() - Wait for printing threads to catch up.
- *
- * @timeout_ms:        The maximum time (in ms) to wait.
- * @reset_on_progress: Reset the timeout if forward progress is seen.
- *
- * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
- * represents infinite waiting.
- *
- * If @reset_on_progress is true, the timeout will be reset whenever any
- * printer has been seen to make some forward progress.
- *
- * Context: Any context if @timeout_ms is 0. Otherwise process context and
- * may sleep if a printer is not caught up.
- * Return: true if all enabled printers are caught up.
- */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
-{
-	int remaining = timeout_ms;
-	struct console *con;
-	u64 last_diff = 0;
-	u64 printk_seq;
-	u64 diff;
-	u64 seq;
-
-	seq = prb_next_seq(prb);
-
-	for (;;) {
-		diff = 0;
-
-		for_each_console(con) {
-			if (!(con->flags & CON_ENABLED))
-				continue;
-			printk_seq = atomic64_read(&con->printk_seq);
-			if (printk_seq < seq)
-				diff += seq - printk_seq;
-		}
-
-		if (diff != last_diff && reset_on_progress)
-			remaining = timeout_ms;
-
-		if (!diff || remaining == 0)
-			break;
-
-		if (remaining < 0) {
-			msleep(100);
-		} else if (remaining < 100) {
-			msleep(remaining);
-			remaining = 0;
-		} else {
-			msleep(100);
-			remaining -= 100;
-		}
-
-		last_diff = diff;
-	}
-
-	return (diff == 0);
-}
-
 /**
  * kmsg_dump - dump kernel log to kernel message dumpers.
  * @reason: the reason (oops, panic etc) for dumping
@@ -3222,12 +3162,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 			sync_mode = true;
 			pr_info("enabled sync mode\n");
 		}
-
-		/*
-		 * Give the printing threads time to flush, allowing up to 1
-		 * second of no printing forward progress before giving up.
-		 */
-		pr_flush(1000, true);
 	}
 
 	rcu_read_lock();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d54f1e7ef867..34158d8ecf194 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1903,9 +1903,16 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 }
 
 struct migration_arg {
-	struct task_struct *task;
-	int dest_cpu;
-	struct completion *done;
+	struct task_struct		*task;
+	int				dest_cpu;
+	struct set_affinity_pending	*pending;
+};
+
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
 };
 
 /*
@@ -1937,8 +1944,10 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
+	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
+	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1947,7 +1956,7 @@ static int migration_cpu_stop(void *data)
 	 * The original target CPU might have gone down and we might
 	 * be on another CPU but it doesn't matter.
 	 */
-	local_irq_disable();
+	local_irq_save(rf.flags);
 	/*
 	 * We need to explicitly wake pending tasks before running
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
@@ -1957,6 +1966,8 @@ static int migration_cpu_stop(void *data)
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
+
+	pending = p->migration_pending;
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1966,23 +1977,71 @@ static int migration_cpu_stop(void *data)
 		if (is_migration_disabled(p))
 			goto out;
 
-		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-		else
-			p->wake_cpu = arg->dest_cpu;
-
-		if (arg->done) {
+		if (pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
+		/* migrate_enable() --  we must not race against SCA */
+		if (dest_cpu < 0) {
+			/*
+			 * When this was migrate_enable() but we no longer
+			 * have a @pending, a concurrent SCA 'fixed' things
+			 * and we should be valid again. Nothing to do.
+			 */
+			if (!pending) {
+				WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+				goto out;
+			}
+
+			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
+
+		if (task_on_rq_queued(p))
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
+		else
+			p->wake_cpu = dest_cpu;
+
+	} else if (dest_cpu < 0) {
+		/*
+		 * This happens when we get migrated between migrate_enable()'s
+		 * preempt_enable() and scheduling the stopper task. At that
+		 * point we're a regular task again and not current anymore.
+		 *
+		 * A !PREEMPT kernel has a giant hole here, which makes it far
+		 * more likely.
+		 */
+
+		/*
+		 * When this was migrate_enable() but we no longer have an
+		 * @pending, a concurrent SCA 'fixed' things and we should be
+		 * valid again. Nothing to do.
+		 */
+		if (!pending) {
+			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+			goto out;
+		}
+
+		/*
+		 * When migrate_enable() hits a rq mis-match we can't reliably
+		 * determine is_migration_disabled() and so have to chase after
+		 * it.
+		 */
+		task_rq_unlock(rq, p, &rf);
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+		return 0;
 	}
 out:
-	rq_unlock(rq, &rf);
-	raw_spin_unlock(&p->pi_lock);
-	local_irq_enable();
+	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
-		complete_all(arg->done);
+		complete_all(&pending->done);
+
+	/* For pending->{arg,stop_work} */
+	pending = arg->pending;
+	if (pending && refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
 
 	return 0;
 }
@@ -2095,13 +2154,6 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	__do_set_cpus_allowed(p, new_mask, 0);
 }
 
-struct set_affinity_pending {
-	refcount_t		refs;
-	struct completion	done;
-	struct cpu_stop_work	stop_work;
-	struct migration_arg	arg;
-};
-
 /*
  * This function is wildly self concurrent; here be dragons.
  *
@@ -2173,8 +2225,8 @@ struct set_affinity_pending {
  * pending affinity completion is preceded an uninstallion of
  * p->migration_pending done with p->pi_lock held.
  */
-static int affine_move_task(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p, int dest_cpu, unsigned int flags)
+static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
+			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	struct migration_arg arg = {
@@ -2240,13 +2292,18 @@ static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 	if (WARN_ON_ONCE(!pending))
 		return -EINVAL;
 
-	arg.done = &pending->done;
-
 	if (flags & SCA_MIGRATE_ENABLE) {
 
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
-		pending->arg = arg;
+
+		pending->arg = (struct migration_arg) {
+			.task = p,
+			.dest_cpu = -1,
+			.pending = pending,
+		};
+
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
@@ -2370,7 +2427,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
-	return affine_move_task(rq, &rf, p, dest_cpu, flags);
+	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
 out:
 	task_rq_unlock(rq, p, &rf);
@@ -3609,6 +3666,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
+	p->migration_pending = NULL;
 #endif
 }
 
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
