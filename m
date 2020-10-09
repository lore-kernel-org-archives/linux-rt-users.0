Return-Path: <SRS0=IZRq=DQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4913C43457
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F1B22258
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 21:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHDbN45p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kw6qS2Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbgJIV7T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Oct 2020 17:59:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbgJIV7O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Oct 2020 17:59:14 -0400
Date:   Fri, 9 Oct 2020 23:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602280749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ICyUNg+TEneBEcvLaUD+x2cQMjjEy0Wx6CN67cO5FLA=;
        b=kHDbN45pDBx5lBp/bggr9Sal4cGa6J9oHangadbJXN/y2XfN7rvT0VeOz48z12qCxAqD2Z
        2fbQORMgd3cQ4UqcyK0eXPQ+mup7aMBufPdauvqx/oYdipN6zDyEyiZ8EcP+/B69zFAjlC
        NykKjumfWh/kxTFwgDUeMXVYsPmJfY5HPv0jFWv61qqodwAjtgTYAeYxSqQLKUQpfnkt+g
        K2Dp61yblpYE0zixOvSZYOhO276MCDUqdUpkvYP9JeiXUlS/9x7wOt7qdrr0ijmQpE6ZZH
        2BBQyupUNK5yuDEt3No98QUjkkOCgp5ofxt6RZ7He1o4Bxw95xbUKg0la0R/Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602280749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ICyUNg+TEneBEcvLaUD+x2cQMjjEy0Wx6CN67cO5FLA=;
        b=Kw6qS2HjVDEGbBZNHPxUIn3NcdfjQ7TtwCYjQ9m4JLwZdNH8ROP6RCfwm9FcgLg5dMY805
        1x3mXVHaRjvJUcBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc8-rt13
Message-ID: <20201009215908.mcbqoclpvxwqmifq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc8-rt13 patch set. 

Changes since v5.9-rc8-rt12:

  - Refurbish the rtmutex related patches:

    - Remove unused code, struct members.

    - Add a scheduling function to the scheduler which is invoked
      instead of schedule() while blocking on a sleeping lock. This
      allows to removes
      - the extra flush-block-io calls.
      - the sleeping lock counter.

      As a result blocking on a sleeping lock from within a
      (workerqueue/IO) worker thread won't fire up another worker. On
      !PREEMPT_RT this does not happen if the execution blocks on a
      spinlock_t. This change aligns the behaviour. Further testing is
      required to see if this behaviour is desired for PREEMPT_RT.

    - Disable migration after the sleeping lock has been acquired. This
      has been done before the lock was acquired due to CPU hotplug
      restriction. These restrictions have been lifted and there should
      be nothing requiring the old behaviour. The advantage is that the
      scheduler is able to freely place the task once the lock is
      available. Otherwise the task would have to wait until the CPU is
      no longer by a task with a higher priority. This of course doesn't
      work for tested locks.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc8-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc8-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc8-rt13

The RT patch against v5.9-rc8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc8-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc8-rt13.tar.xz

Sebastian
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 3b19db2db1ed0..994f997b15724 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -104,6 +104,9 @@ static inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 void preempt_schedule(void);
+#ifdef CONFIG_PREEMPT_RT
+void preempt_schedule_lock(void);
+#endif
 #define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 314757e23c47b..471dec2d78e12 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -134,6 +134,9 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_RT
+  extern void preempt_schedule_lock(void);
+#endif
   extern asmlinkage void preempt_schedule_thunk(void);
 # define __preempt_schedule() \
 	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index d683f5e6d7913..71c1535db56a2 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -79,6 +79,9 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_RT
+extern void preempt_schedule_lock(void);
+#endif
 extern asmlinkage void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index 3fcb5edb1d2b4..7179367bfb5e2 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef __LINUX_MUTEX_RT_H
 #define __LINUX_MUTEX_RT_H
 
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 46b266d3ed2e8..5308cd7ddddf0 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -36,11 +36,6 @@ struct rt_mutex {
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
 	int			save_state;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	const char		*name, *file;
-	int			line;
-	void			*magic;
-#endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -53,6 +48,7 @@ struct hrtimer_sleeper;
  extern int rt_mutex_debug_check_no_locks_freed(const void *from,
 						unsigned long len);
  extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
+ extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
  static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
 						       unsigned long len)
@@ -60,25 +56,15 @@ struct hrtimer_sleeper;
 	return 0;
  }
 # define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
+# define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	, .name = #mutexname, .file = __FILE__, .line = __LINE__
-
-# define rt_mutex_init(mutex) \
+#define rt_mutex_init(mutex) \
 do { \
 	static struct lock_class_key __key; \
 	__rt_mutex_init(mutex, __func__, &__key); \
 } while (0)
 
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
-#else
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
-#endif
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
 	, .dep_map = { .name = #mutexname }
@@ -87,21 +73,21 @@ do { \
 #endif
 
 #define __RT_MUTEX_INITIALIZER_PLAIN(mutexname) \
-	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
+	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
 	, .waiters = RB_ROOT_CACHED \
 	, .owner = NULL \
-	__DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 
 #define __RT_MUTEX_INITIALIZER(mutexname) \
-	{ __RT_MUTEX_INITIALIZER_PLAIN(mutexname) }
-
-#define DEFINE_RT_MUTEX(mutexname) \
-	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
+	{ __RT_MUTEX_INITIALIZER_PLAIN(mutexname) \
+	, .save_state = 0 }
 
 #define __RT_MUTEX_INITIALIZER_SAVE_STATE(mutexname) \
 	{ __RT_MUTEX_INITIALIZER_PLAIN(mutexname)    \
-		, .save_state = 1 }
+	, .save_state = 1 }
+
+#define DEFINE_RT_MUTEX(mutexname) \
+	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
 /**
  * rt_mutex_is_locked - is the mutex locked
@@ -127,9 +113,6 @@ extern void rt_mutex_lock(struct rt_mutex *lock);
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_lock_killable(struct rt_mutex *lock);
-extern int rt_mutex_timed_lock(struct rt_mutex *lock,
-			       struct hrtimer_sleeper *timeout);
-
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index ebd3ed1903887..aafdb0a685d54 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef __LINUX_RWLOCK_RT_H
 #define __LINUX_RWLOCK_RT_H
 
diff --git a/include/linux/rwlock_types_rt.h b/include/linux/rwlock_types_rt.h
index 546a1f8f12748..4762391d659bf 100644
--- a/include/linux/rwlock_types_rt.h
+++ b/include/linux/rwlock_types_rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef __LINUX_RWLOCK_TYPES_RT_H
 #define __LINUX_RWLOCK_TYPES_RT_H
 
diff --git a/include/linux/rwsem-rt.h b/include/linux/rwsem-rt.h
index 2018ff77904ad..7f7e748ef5222 100644
--- a/include/linux/rwsem-rt.h
+++ b/include/linux/rwsem-rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef _LINUX_RWSEM_RT_H
 #define _LINUX_RWSEM_RT_H
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c0fd9b458d82e..29e9bfbb8766f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -148,7 +148,6 @@ struct task_group;
 		current->state = (state_value);				\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
-
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -732,9 +731,6 @@ struct task_struct {
 	int				migrate_disable;
 # endif
 #endif
-#ifdef CONFIG_PREEMPT_RT
-	int				sleeping_lock;
-#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1985,23 +1981,6 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
-#ifdef CONFIG_PREEMPT_RT
-static inline void sleeping_lock_inc(void)
-{
-	current->sleeping_lock++;
-}
-
-static inline void sleeping_lock_dec(void)
-{
-	current->sleeping_lock--;
-}
-
-#else
-
-static inline void sleeping_lock_inc(void) { }
-static inline void sleeping_lock_dec(void) { }
-#endif
-
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index e5af028c08b49..994c25640e156 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -39,20 +39,12 @@ static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *p)
 }
 extern void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return tsk->pi_blocked_on != NULL;
-}
 #else
 static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
 	return NULL;
 }
 # define rt_mutex_adjust_pi(p)		do { } while (0)
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return false;
-}
 #endif
 
 extern void normalize_rt_tasks(void);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 060cbcba0d466..ac2be04c59fa7 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef __LINUX_SPINLOCK_RT_H
 #define __LINUX_SPINLOCK_RT_H
 
diff --git a/include/linux/spinlock_types_rt.h b/include/linux/spinlock_types_rt.h
index 3e3d8c5f7a9ad..446da786e5d5c 100644
--- a/include/linux/spinlock_types_rt.h
+++ b/include/linux/spinlock_types_rt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef __LINUX_SPINLOCK_TYPES_RT_H
 #define __LINUX_SPINLOCK_TYPES_RT_H
 
@@ -18,22 +19,11 @@ typedef struct spinlock {
 #endif
 } spinlock_t;
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-# define __RT_SPIN_INITIALIZER(name) \
+#define __RT_SPIN_INITIALIZER(name) \
 	{ \
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock), \
 	.save_state = 1, \
-	.file = __FILE__, \
-	.line = __LINE__ , \
 	}
-#else
-# define __RT_SPIN_INITIALIZER(name) \
-	{								\
-	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),		\
-	.save_state = 1, \
-	}
-#endif
-
 /*
 .wait_list = PLIST_HEAD_INIT_RAW((name).lock.wait_list, (name).lock.wait_lock)
 */
diff --git a/kernel/locking/mutex-rt.c b/kernel/locking/mutex-rt.c
index 5d418dc9ac701..35b06711997dd 100644
--- a/kernel/locking/mutex-rt.c
+++ b/kernel/locking/mutex-rt.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * kernel/rt.c
- *
  * Real-Time Preemption Support
  *
  * started by Ingo Molnar:
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 36e69100e8e06..fb150100335fc 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,110 +32,12 @@
 
 #include "rtmutex_common.h"
 
-static void printk_task(struct task_struct *p)
-{
-	if (p)
-		printk("%16s:%5d [%p, %3d]", p->comm, task_pid_nr(p), p, p->prio);
-	else
-		printk("<none>");
-}
-
-static void printk_lock(struct rt_mutex *lock, int print_owner)
-{
-	if (lock->name)
-		printk(" [%p] {%s}\n",
-			lock, lock->name);
-	else
-		printk(" [%p] {%s:%d}\n",
-			lock, lock->file, lock->line);
-
-	if (print_owner && rt_mutex_owner(lock)) {
-		printk(".. ->owner: %p\n", lock->owner);
-		printk(".. held by:  ");
-		printk_task(rt_mutex_owner(lock));
-		printk("\n");
-	}
-}
-
 void rt_mutex_debug_task_free(struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-/*
- * We fill out the fields in the waiter to store the information about
- * the deadlock. We print when we return. act_waiter can be NULL in
- * case of a remove waiter operation.
- */
-void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-			     struct rt_mutex_waiter *act_waiter,
-			     struct rt_mutex *lock)
-{
-	struct task_struct *task;
-
-	if (!debug_locks || chwalk == RT_MUTEX_FULL_CHAINWALK || !act_waiter)
-		return;
-
-	task = rt_mutex_owner(act_waiter->lock);
-	if (task && task != current) {
-		act_waiter->deadlock_task_pid = get_pid(task_pid(task));
-		act_waiter->deadlock_lock = lock;
-	}
-}
-
-void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
-{
-	struct task_struct *task;
-
-	if (!waiter->deadlock_lock || !debug_locks)
-		return;
-
-	rcu_read_lock();
-	task = pid_task(waiter->deadlock_task_pid, PIDTYPE_PID);
-	if (!task) {
-		rcu_read_unlock();
-		return;
-	}
-
-	if (!debug_locks_off()) {
-		rcu_read_unlock();
-		return;
-	}
-
-	pr_warn("\n");
-	pr_warn("============================================\n");
-	pr_warn("WARNING: circular locking deadlock detected!\n");
-	pr_warn("%s\n", print_tainted());
-	pr_warn("--------------------------------------------\n");
-	printk("%s/%d is deadlocking current task %s/%d\n\n",
-	       task->comm, task_pid_nr(task),
-	       current->comm, task_pid_nr(current));
-
-	printk("\n1) %s/%d is trying to acquire this lock:\n",
-	       current->comm, task_pid_nr(current));
-	printk_lock(waiter->lock, 1);
-
-	printk("\n2) %s/%d is blocked on this lock:\n",
-		task->comm, task_pid_nr(task));
-	printk_lock(waiter->deadlock_lock, 1);
-
-	debug_show_held_locks(current);
-	debug_show_held_locks(task);
-
-	printk("\n%s/%d's [blocked] stackdump:\n\n",
-		task->comm, task_pid_nr(task));
-	show_stack(task, NULL, KERN_DEFAULT);
-	printk("\n%s/%d's [current] stackdump:\n\n",
-		current->comm, task_pid_nr(current));
-	dump_stack();
-	debug_show_all_locks();
-	rcu_read_unlock();
-
-	printk("[ turning off deadlock detection."
-	       "Please report this trace. ]\n\n");
-}
-
 void debug_rt_mutex_lock(struct rt_mutex *lock)
 {
 }
@@ -158,12 +60,10 @@ void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	memset(waiter, 0x11, sizeof(*waiter));
-	waiter->deadlock_task_pid = NULL;
 }
 
 void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 {
-	put_pid(waiter->deadlock_task_pid);
 	memset(waiter, 0x22, sizeof(*waiter));
 }
 
@@ -173,10 +73,8 @@ void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_cl
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lock->name = name;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 }
-
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index fc549713bba3f..659e93e256c67 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -18,20 +18,9 @@ extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
 				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-				    struct rt_mutex_waiter *waiter,
-				    struct rt_mutex *lock);
-extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
-# define debug_rt_mutex_reset_waiter(w)			\
-	do { (w)->deadlock_lock = NULL; } while (0)
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
 						  enum rtmutex_chainwalk walk)
 {
 	return (waiter != NULL);
 }
-
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	debug_rt_mutex_print_deadlock(w);
-}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 9ba766cd37edd..ef22e1b52f8c8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -25,7 +25,6 @@
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
-#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -640,7 +639,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
 		goto out_unlock_pi;
@@ -1068,10 +1066,8 @@ void __sched rt_spin_lock_slowlock_locked(struct rt_mutex *lock,
 
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-		debug_rt_mutex_print_deadlock(waiter);
-
 		if (top_waiter != waiter || adaptive_wait(lock, lock_owner))
-			schedule();
+			preempt_schedule_lock();
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
@@ -1138,11 +1134,10 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
-	sleeping_lock_inc();
-	rcu_read_lock();
-	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rcu_read_lock();
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
@@ -1154,22 +1149,20 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	sleeping_lock_inc();
-	rcu_read_lock();
-	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rcu_read_lock();
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
 
 void __lockfunc rt_spin_lock_nest_lock(spinlock_t *lock,
 				       struct lockdep_map *nest_lock)
 {
-	sleeping_lock_inc();
-	rcu_read_lock();
-	migrate_disable();
 	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rcu_read_lock();
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_spin_lock_nest_lock);
 #endif
@@ -1178,10 +1171,9 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, _RET_IP_);
-	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
 	rcu_read_unlock();
-	sleeping_lock_dec();
+	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -1207,15 +1199,11 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 {
 	int ret;
 
-	sleeping_lock_inc();
-	migrate_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
-	} else {
-		migrate_enable();
-		sleeping_lock_dec();
+		migrate_disable();
 	}
 	return ret;
 }
@@ -1228,12 +1216,12 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	local_bh_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
-		sleeping_lock_inc();
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
 		migrate_disable();
-		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	} else
+	} else {
 		local_bh_enable();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_spin_trylock_bh);
@@ -1592,8 +1580,6 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		debug_rt_mutex_print_deadlock(waiter);
-
 		schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
@@ -1614,10 +1600,6 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (res != -EDEADLOCK || detect_deadlock)
 		return;
 
-	/*
-	 * Yell lowdly and stop the task right here.
-	 */
-	rt_mutex_print_deadlock(w);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
@@ -1926,38 +1908,9 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	/*
-	 * If rt_mutex blocks, the function sched_submit_work will not call
-	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
-	 * We must call blk_schedule_flush_plug here, if we don't call it,
-	 * a deadlock in I/O may happen.
-	 */
-	if (unlikely(blk_needs_flush_plug(current)))
-		blk_schedule_flush_plug(current);
-
 	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
-static inline int
-rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout,
-			enum rtmutex_chainwalk chwalk,
-			struct ww_acquire_ctx *ww_ctx,
-			int (*slowfn)(struct rt_mutex *lock, int state,
-				      struct hrtimer_sleeper *timeout,
-				      enum rtmutex_chainwalk chwalk,
-				      struct ww_acquire_ctx *ww_ctx))
-{
-	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
-	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
-
-	if (unlikely(blk_needs_flush_plug(current)))
-		blk_schedule_flush_plug(current);
-
-	return slowfn(lock, state, timeout, chwalk, ww_ctx);
-}
-
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
@@ -2084,12 +2037,11 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
 /**
  * rt_mutex_lock_killable - lock a rt_mutex killable
  *
- * @lock:              the rt_mutex to be locked
- * @detect_deadlock:   deadlock detection on/off
+ * @lock:		the rt_mutex to be locked
  *
  * Returns:
- *  0          on success
- * -EINTR      when interrupted by a signal
+ *  0		on success
+ * -EINTR	when interrupted by a signal
  */
 int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
 {
@@ -2097,38 +2049,6 @@ int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
 
-/**
- * rt_mutex_timed_lock - lock a rt_mutex interruptible
- *			the timeout structure is provided
- *			by the caller
- *
- * @lock:		the rt_mutex to be locked
- * @timeout:		timeout structure or NULL (no timeout)
- *
- * Returns:
- *  0		on success
- * -EINTR	when interrupted by a signal
- * -ETIMEDOUT	when the timeout expired
- */
-int
-rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
-{
-	int ret;
-
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       RT_MUTEX_MIN_CHAINWALK,
-				       NULL,
-				       rt_mutex_slowlock);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
-
 int __sched __rt_mutex_trylock(struct rt_mutex *lock)
 {
 #ifdef CONFIG_PREEMPT_RT
@@ -2242,9 +2162,6 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 void rt_mutex_destroy(struct rt_mutex *lock)
 {
 	WARN_ON(rt_mutex_is_locked(lock));
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	lock->magic = NULL;
-#endif
 }
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
@@ -2413,8 +2330,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (ret)
 		fixup_rt_mutex_blocked(lock);
 
-	debug_rt_mutex_print_deadlock(waiter);
-
 	return ret;
 }
 
@@ -2573,7 +2488,7 @@ static inline int
 ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
-	unsigned tmp;
+	unsigned int tmp;
 
 	if (ctx->deadlock_inject_countdown-- == 0) {
 		tmp = ctx->deadlock_inject_interval;
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index 732f96abf4623..338ccd29119a1 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -19,15 +19,8 @@
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
-#define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
-#define debug_rt_mutex_print_deadlock(w)		do { } while (0)
 #define debug_rt_mutex_reset_waiter(w)			do { } while (0)
 
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	WARN(1, "rtmutex deadlock detected\n");
-}
-
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
 						  enum rtmutex_chainwalk walk)
 {
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 546aaf058b9ec..407f3da146cb2 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -30,13 +30,8 @@ struct rt_mutex_waiter {
 	struct rb_node          pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
-	bool			savestate;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	unsigned long		ip;
-	struct pid		*deadlock_task_pid;
-	struct rt_mutex		*deadlock_lock;
-#endif
 	int prio;
+	bool			savestate;
 	u64 deadline;
 };
 
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index 2faa9bf62e145..4cd72a2968a6f 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -1,5 +1,4 @@
-/*
- */
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/sched/debug.h>
 #include <linux/export.h>
 
@@ -212,7 +211,7 @@ static void __write_rt_lock(struct rt_rw_lock *lock)
 		raw_spin_unlock_irqrestore(&m->wait_lock, flags);
 
 		if (atomic_read(&lock->readers) != 0)
-			schedule();
+			preempt_schedule_lock();
 
 		raw_spin_lock_irqsave(&m->wait_lock, flags);
 
@@ -268,15 +267,11 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
-	sleeping_lock_inc();
-	migrate_disable();
 	ret = __read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
-	} else {
-		migrate_enable();
-		sleeping_lock_dec();
+		migrate_disable();
 	}
 	return ret;
 }
@@ -286,15 +281,11 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
-	sleeping_lock_inc();
-	migrate_disable();
 	ret = __write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
-	} else {
-		migrate_enable();
-		sleeping_lock_dec();
+		migrate_disable();
 	}
 	return ret;
 }
@@ -302,41 +293,37 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
-	sleeping_lock_inc();
-	rcu_read_lock();
-	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	__read_rt_lock(rwlock);
+	rcu_read_lock();
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_read_lock);
 
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
-	sleeping_lock_inc();
-	rcu_read_lock();
-	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	__write_rt_lock(rwlock);
+	rcu_read_lock();
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_write_lock);
 
 void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	__read_rt_unlock(rwlock);
 	migrate_enable();
 	rcu_read_unlock();
-	sleeping_lock_dec();
+	__read_rt_unlock(rwlock);
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	__write_rt_unlock(rwlock);
 	migrate_enable();
 	rcu_read_unlock();
-	sleeping_lock_dec();
+	__write_rt_unlock(rwlock);
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index f518495bd6ccd..bca7a448206d6 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,6 +1,4 @@
-/*
- */
-#include <linux/blkdev.h>
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -88,14 +86,6 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
 
 	if (__down_read_trylock(sem))
 		return 0;
-	/*
-	 * If rt_mutex blocks, the function sched_submit_work will not call
-	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
-	 * We must call blk_schedule_flush_plug here, if we don't call it,
-	 * a deadlock in I/O may happen.
-	 */
-	if (unlikely(blk_needs_flush_plug(current)))
-		blk_schedule_flush_plug(current);
 
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 7f42a330709a9..fce8a6e3fa7c3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1333,7 +1333,6 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 	return sem;
 }
 
-
 /*
  * lock for reading
  */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4ce2fd80e28f0..982fc5be52698 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -289,14 +289,10 @@ void rcu_note_context_switch(bool preempt)
 	struct task_struct *t = current;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
-	int sleeping_l = 0;
 
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-#if defined(CONFIG_PREEMPT_RT)
-	sleeping_l = t->sleeping_lock;
-#endif
-	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0 && !sleeping_l);
+	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
 	if (rcu_preempt_depth() > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 86e017ec2af5e..7200cf427ae86 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4534,7 +4534,7 @@ static void migrate_disabled_sched(struct task_struct *p);
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(bool preempt, bool spinning_lock)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -4590,7 +4590,7 @@ static void __sched notrace __schedule(bool preempt)
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = prev->state;
-	if (!preempt && prev_state) {
+	if ((!preempt || spinning_lock) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
@@ -4673,7 +4673,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
 
-	__schedule(false);
+	__schedule(false, false);
 	BUG();
 
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
@@ -4703,9 +4703,6 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		preempt_enable_no_resched();
 	}
 
-	if (tsk_is_pi_blocked(tsk))
-		return;
-
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
@@ -4731,7 +4728,7 @@ asmlinkage __visible void __sched schedule(void)
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(false, false);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -4759,7 +4756,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->state);
 	do {
-		__schedule(false);
+		__schedule(false, false);
 	} while (need_resched());
 }
 
@@ -4812,7 +4809,7 @@ static void __sched notrace preempt_schedule_common(void)
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(true, false);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 
@@ -4867,6 +4864,19 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
+#ifdef CONFIG_PREEMPT_RT
+void __sched notrace preempt_schedule_lock(void)
+{
+	do {
+		preempt_disable();
+		__schedule(true, true);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+NOKPROBE_SYMBOL(preempt_schedule_lock);
+EXPORT_SYMBOL(preempt_schedule_lock);
+#endif
+
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -4913,7 +4923,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 		 * an infinite recursion.
 		 */
 		prev_ctx = exception_enter();
-		__schedule(true);
+		__schedule(true, false);
 		exception_exit(prev_ctx);
 
 		preempt_latency_stop(1);
@@ -4942,7 +4952,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(true, false);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0b2da8da0c48e..822fa0c7f5dbe 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2011,9 +2011,7 @@ void cpu_chill(void)
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
 
 	current->flags |= PF_NOFREEZE;
-	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
-	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
