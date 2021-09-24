Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CBC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984C161261
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 17:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbhIXRy5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:54:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbhIXRy4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Sep 2021 13:54:56 -0400
Date:   Fri, 24 Sep 2021 19:53:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632506002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PxmHsJuyltV4wP6N8LgYNmL4TsHrLx1ulwEY6BjoArc=;
        b=ZZwHg/DrOCvJixD7jx+RMjsODgB72ODybtD6DLyOEHITFF1WIJiFeHK0+UpRN2H9YW78Ud
        /QlsGEhxAA1q/p/068pzmEujlE3tArcUjeE5uxQlzAgbfrnzIINkIFfM88Z3Ks0+2+qX9E
        UHahm9nzcBmszvVixoSrL2zNEvbjvaHyuXMLHSeNY59te5SGKZ8fMaxe96PpnQJ4Wz+mIN
        +wbAzuSXsaM/COXSP4hux55eZ7tlpW4JmsBpNbssPelKXvrXUKNsykyF5P/H9/m/TtwelM
        0H5cp8JVKgT/O1PWkraAAdWZ0C/PUW2725KFY8G31y1GuseNqlam+OObd/vIqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632506002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PxmHsJuyltV4wP6N8LgYNmL4TsHrLx1ulwEY6BjoArc=;
        b=9KXNvIm5nqrnx4KlWLc9lo7DllYX17kh5FFHtyEAYL7WfX0q+pdU4/VoqkHaivBEFs9ESW
        pxzau601SItPGXDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc2-rt4
Message-ID: <20210924175320.qgk26g5jqgjhe55i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc2-rt4 patch set. 

Changes since v5.15-rc2-rt3:

  - Reformatted a function invocation in SMACK.

  - Wake ksoftirqd from idle again. A logic bug was introduced in around
    v5.14-rc3-rt1.

  - Two explicit atomic.h includes were introduced because ARM failed to
    compile depending on some options. It appears that this is no longer
    the case and so the additional includes were dropped again.

  - Additional might_sleep() improvements. Now it splat should be more
    readable / provide additional details. Patches by Thomas Gleixner.

  - Rework the delayed mm_struct and task stack deallocation. Patches by
    Thomas Gleixner.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.15-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc2-rt4

The RT patch against v5.15-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc2-rt4.tar.xz

Sebastian

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2776423a587e4..e8696e4a45aa0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,8 +111,8 @@ static __always_inline void might_resched(void)
 #endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void ___might_sleep(const char *file, int line, int preempt_offset);
-extern void __might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_resched(const char *file, int line, unsigned int offsets);
+extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
 
@@ -129,7 +129,7 @@ extern void __cant_migrate(const char *file, int line);
  * supposed to.
  */
 # define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
 /**
  * cant_sleep - annotation for functions that cannot sleep
  *
@@ -168,10 +168,9 @@ extern void __cant_migrate(const char *file, int line);
  */
 # define non_block_end() WARN_ON(current->non_block_count-- == 0)
 #else
-  static inline void ___might_sleep(const char *file, int line,
-				   int preempt_offset) { }
-  static inline void __might_sleep(const char *file, int line,
-				   int preempt_offset) { }
+  static inline void __might_resched(const char *file, int line,
+				     unsigned int offsets) { }
+static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
 # define cant_migrate()		do { } while (0)
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 33c14785c46b2..af308e15f174c 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -3,7 +3,6 @@
 #define _LINUX_PID_H
 
 #include <linux/rculist.h>
-#include <linux/atomic.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index cf665d25838cf..dc8158a459859 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -123,16 +123,9 @@
  */
 #if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET		PREEMPT_DISABLE_OFFSET
-#define PREEMPT_LOCK_RESCHED_OFFSET	PREEMPT_LOCK_OFFSET
 #else
 /* Locks on RT do not disable preemption */
 #define PREEMPT_LOCK_OFFSET		0
-/*
- * spin/rw_lock() on RT implies rcu_read_lock(). The might_sleep() check in
- * cond_resched*lock() has to take that into account because it checks for
- * preempt_count() + rcu_preempt_depth().
- */
-#define PREEMPT_LOCK_RESCHED_OFFSET	1
 #endif
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 992a1e07a27e8..79852a2ebe5b4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2161,7 +2161,7 @@ static inline int _cond_resched(void) { return 0; }
 #endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
-	___might_sleep(__FILE__, __LINE__, 0);	\
+	__might_resched(__FILE__, __LINE__, 0);	\
 	_cond_resched();			\
 })
 
@@ -2169,19 +2169,38 @@ extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
-#define cond_resched_lock(lock) ({					\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
-	__cond_resched_lock(lock);					\
+#define MIGHT_RESCHED_RCU_SHIFT		8
+#define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
+
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Non RT kernels have an elevated preempt count due to the held lock,
+ * but are not allowed to be inside a RCU read side critical section
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	PREEMPT_LOCK_OFFSET
+#else
+/*
+ * spin/rw_lock() on RT implies rcu_read_lock(). The might_sleep() check in
+ * cond_resched*lock() has to take that into account because it checks for
+ * preempt_count() and rcu_preempt_depth().
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	\
+	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
+#endif
+
+#define cond_resched_lock(lock) ({						\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_lock(lock);						\
 })
 
-#define cond_resched_rwlock_read(lock) ({				\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
-	__cond_resched_rwlock_read(lock);				\
+#define cond_resched_rwlock_read(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_read(lock);					\
 })
 
-#define cond_resched_rwlock_write(lock) (	{			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
-	__cond_resched_rwlock_write(lock);				\
+#define cond_resched_rwlock_write(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_write(lock);					\
 })
 
 static inline void cond_resched_rcu(void)
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 11177c36f640d..8358352428d4d 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -51,13 +51,22 @@ static inline void mmdrop(struct mm_struct *mm)
 
 #ifdef CONFIG_PREEMPT_RT
 extern void __mmdrop_delayed(struct rcu_head *rhp);
-static inline void mmdrop_delayed(struct mm_struct *mm)
+
+/*
+ * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
+ * kernels via RCU.
+ */
+static inline void mmdrop_sched(struct mm_struct *mm)
 {
+	/* Provides a full memory barrier. See mmdrop() */
 	if (atomic_dec_and_test(&mm->mm_count))
 		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
 }
 #else
-# define mmdrop_delayed(mm)    mmdrop(mm)
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
 #endif
 
 /**
diff --git a/include/linux/wait.h b/include/linux/wait.h
index e778131e7c4bd..93dab0e9580f8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -10,7 +10,6 @@
 
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
-#include <linux/atomic.h>
 
 typedef struct wait_queue_entry wait_queue_entry_t;
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32eb..acd7aa9700db3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -60,6 +60,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/kprobes.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
@@ -168,8 +169,14 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
 
+	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
+
+	/* RT enabled kernels delay freeing the VMAP'ed task stack */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		put_task_stack(tsk);
+
 	put_task_struct(tsk);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a040f0cfe45d1..1dc9ac795d5eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,7 +42,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/kprobes.h>
 #include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
@@ -290,7 +289,10 @@ static inline void free_thread_stack(struct task_struct *tsk)
 			return;
 		}
 
-		vfree(tsk->stack);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			vfree_atomic(tsk->stack);
+		else
+			vfree(tsk->stack);
 		return;
 	}
 #endif
@@ -708,8 +710,8 @@ EXPORT_SYMBOL_GPL(__mmdrop);
 
 #ifdef CONFIG_PREEMPT_RT
 /*
- * RCU callback for delayed mm drop. Not strictly rcu, but we don't
- * want another facility to make this work.
+ * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
+ * by far the least expensive way to do that.
  */
 void __mmdrop_delayed(struct rcu_head *rhp)
 {
@@ -760,15 +762,6 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
-	/*
-	 * Remove function-return probe instances associated with this
-	 * task and put them back on the free list.
-	 */
-	kprobe_flush_task(tsk);
-
-	/* Task is done with its stack. */
-	put_task_stack(tsk);
-
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00c..9a38e7581a5ce 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1250,10 +1250,10 @@ void kprobe_busy_end(void)
 }
 
 /*
- * This function is called from finish_task_switch when task tk becomes dead,
- * so that we can recycle any function-return probe instances associated
- * with this task. These left over instances represent probed functions
- * that have been called but will never return.
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any function-return probe instances
+ * associated with this task. These left over instances represent probed
+ * functions that have been called but will never return.
  */
 void kprobe_flush_task(struct task_struct *tk)
 {
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 1d1e85e317385..9e396a09fe0fd 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -25,12 +25,15 @@
 #include "rtmutex.c"
 
 /*
- * Use ___might_sleep() which skips the state check and take RCU nesting
- * into account as spin/read/write_lock() can legitimately nest into an RCU
- * read side critical section:
+ * __might_resched() skips the state check as rtlocks are state
+ * preserving. Take RCU nesting into account as spin/read/write_lock() can
+ * legitimately nest into an RCU read side critical section.
  */
-#define rtlock_might_sleep()					\
-	___might_sleep(__FILE__, __LINE__, rcu_preempt_depth())
+#define RTLOCK_RESCHED_OFFSETS						\
+	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
+
+#define rtlock_might_resched()						\
+	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS)
 
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
@@ -40,7 +43,7 @@ static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	rtlock_might_sleep();
+	rtlock_might_resched();
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -218,7 +221,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	rtlock_might_sleep();
+	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -228,7 +231,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	rtlock_might_sleep();
+	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 261508bac047d..1ddd50f2a3d7f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4884,18 +4884,22 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 *   provided by mmdrop(),
 	 * - a sync_core for SYNC_CORE.
 	 */
-	/*
-	 * We use mmdrop_delayed() here so we don't have to do the
-	 * full __mmdrop() when we are the last user.
-	 */
+
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop_delayed(mm);
+		mmdrop_sched(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
+		/*
+		 * Release VMAP'ed task stack immediate for reuse. On RT
+		 * enabled kernels this is delayed for latency reasons.
+		 */
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			put_task_stack(prev);
+
 		put_task_struct_rcu_user(prev);
 	}
 
@@ -8855,7 +8859,6 @@ void sched_setnuma(struct task_struct *p, int nid)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_HOTPLUG_CPU
-
 /*
  * Ensure that the idle task is using init_mm right before its CPU goes
  * offline.
@@ -9545,14 +9548,8 @@ void __init sched_init(void)
 }
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-static inline int preempt_count_equals(int preempt_offset)
-{
-	int nested = preempt_count() + rcu_preempt_depth();
 
-	return (nested == preempt_offset);
-}
-
-void __might_sleep(const char *file, int line, int preempt_offset)
+void __might_sleep(const char *file, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -9566,11 +9563,32 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	___might_sleep(file, line, preempt_offset);
+	__might_resched(file, line, 0);
 }
 EXPORT_SYMBOL(__might_sleep);
 
-void ___might_sleep(const char *file, int line, int preempt_offset)
+static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
+		return;
+
+	if (preempt_count() == preempt_offset)
+		return;
+
+	pr_err("Preemption disabled at:");
+	print_ip_sym(KERN_ERR, ip);
+}
+
+static inline bool resched_offsets_ok(unsigned int offsets)
+{
+	unsigned int nested = preempt_count();
+
+	nested += rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT;
+
+	return nested == offsets;
+}
+
+void __might_resched(const char *file, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9580,7 +9598,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	/* WARN_ON_ONCE() by default, no rate limit required: */
 	rcu_sleep_check();
 
-	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
+	if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
 	     !is_idle_task(current) && !current->non_block_count) ||
 	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
@@ -9593,29 +9611,33 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	printk(KERN_ERR
-		"BUG: sleeping function called from invalid context at %s:%d\n",
-			file, line);
-	printk(KERN_ERR
-		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
-			in_atomic(), irqs_disabled(), current->non_block_count,
-			current->pid, current->comm);
+	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
+	       file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), current->non_block_count,
+	       current->pid, current->comm);
+	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
+	       offsets & MIGHT_RESCHED_PREEMPT_MASK);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		pr_err("RCU nest depth: %d, expected: %u\n",
+		       rcu_preempt_depth(), offsets >> MIGHT_RESCHED_RCU_SHIFT);
+	}
 
 	if (task_stack_end_corrupted(current))
-		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
+		pr_emerg("Thread overran stack, or stack corrupted\n");
 
 	debug_show_held_locks(current);
 	if (irqs_disabled())
 		print_irqtrace_events(current);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && !preempt_count_equals(preempt_offset)) {
-		pr_err("Preemption disabled at:");
-		print_ip_sym(KERN_ERR, preempt_disable_ip);
-	}
+
+	print_preempt_disable_ip(offsets & MIGHT_RESCHED_PREEMPT_MASK,
+				 preempt_disable_ip);
+
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
-EXPORT_SYMBOL(___might_sleep);
+EXPORT_SYMBOL(__might_resched);
 
 void __cant_sleep(const char *file, int line, int preempt_offset)
 {
diff --git a/kernel/smp.c b/kernel/smp.c
index c37cc3ab3ceb3..2364fd9acb09b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -701,7 +701,7 @@ void flush_smp_call_function_from_idle(void)
 		} else {
 			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
 
-			if (ksoftirqd && task_is_running(ksoftirqd))
+			if (ksoftirqd && !task_is_running(ksoftirqd))
 				wake_up_process(ksoftirqd);
 		}
 	}
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e872142..1cd1792c00f2d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5255,7 +5255,7 @@ void __might_fault(const char *file, int line)
 		return;
 	if (pagefault_disabled())
 		return;
-	__might_sleep(file, line, 0);
+	__might_sleep(file, line);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fd9e6b54907ee..95bd604c38199 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2855,7 +2855,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 					    SMK_CONNECTING);
 		}
 #ifdef SMACK_IPV6_PORT_LABELING
-			rc = smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
+		rc = smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
 #endif
 
 		return rc;
