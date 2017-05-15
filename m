From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.27-rt18
Date: Mon, 15 May 2017 15:18:51 +0200
Message-ID: <20170515131851.3jwgv7sxu2ge2l6i@linutronix.de>
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

I'm pleased to announce the v4.9.27-rt18 patch set. 

Changes since v4.9.27-rt17:

  - Replaced a preempt-disabled region with local-locks in the random
    driver which sneaked in via a stable update.

  - Various futex backports from mainline which were required after the
    rework which was backported into v4.9.18-rt14.

  - A canceled FUTEX_WAIT_REQUEUE_PI operation (by timeout or signal)
    could lead to a double locking issue. Reported by Engleder Gerhard,
    fixed by Thomas Gleixner.

Known issues
	- CPU hotplug got a little better but can deadlock.

	- gdb. While gdb is following a task it is possible that after a
	  fork() operation the task is waiting for gdb and gdb waiting
	  for the task.

The delta patch against v4.9.27-rt17 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.27-rt17-rt18.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.27-rt18

The RT patch against v4.9.27 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.27-rt18.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.27-rt18.tar.xz

Sebastian
diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5196,6 +5196,23 @@ F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
 F:	Documentation/filesystems/fuse.txt
 
+FUTEX SUBSYSTEM
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Ingo Molnar <mingo@redhat.com>
+R:	Peter Zijlstra <peterz@infradead.org>
+R:	Darren Hart <dvhart@infradead.org>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
+S:	Maintained
+F:	kernel/futex.c
+F:	kernel/futex_compat.c
+F:	include/asm-generic/futex.h
+F:	include/linux/futex.h
+F:	include/uapi/linux/futex.h
+F:	tools/testing/selftests/futex/
+F:	tools/perf/bench/futex*
+F:	Documentation/*futex*
+
 FUTURE DOMAIN TMC-16x0 SCSI DRIVER (16-bit)
 M:	Rik Faith <faith@cs.unc.edu>
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -262,6 +262,7 @@
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
+#include <linux/locallock.h>
 #include <crypto/chacha20.h>
 
 #include <asm/processor.h>
@@ -2052,6 +2053,7 @@ struct batched_entropy {
  * goal of being quite fast and not depleting entropy.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_long);
+static DEFINE_LOCAL_IRQ_LOCK(batched_entropy_long_lock);
 unsigned long get_random_long(void)
 {
 	unsigned long ret;
@@ -2060,13 +2062,13 @@ unsigned long get_random_long(void)
 	if (arch_get_random_long(&ret))
 		return ret;
 
-	batch = &get_cpu_var(batched_entropy_long);
+	batch = &get_locked_var(batched_entropy_long_lock, batched_entropy_long);
 	if (batch->position % ARRAY_SIZE(batch->entropy_long) == 0) {
 		extract_crng((u8 *)batch->entropy_long);
 		batch->position = 0;
 	}
 	ret = batch->entropy_long[batch->position++];
-	put_cpu_var(batched_entropy_long);
+	put_locked_var(batched_entropy_long_lock, batched_entropy_long);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_long);
@@ -2078,6 +2080,8 @@ unsigned int get_random_int(void)
 }
 #else
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_int);
+static DEFINE_LOCAL_IRQ_LOCK(batched_entropy_int_lock);
+
 unsigned int get_random_int(void)
 {
 	unsigned int ret;
@@ -2086,13 +2090,13 @@ unsigned int get_random_int(void)
 	if (arch_get_random_int(&ret))
 		return ret;
 
-	batch = &get_cpu_var(batched_entropy_int);
+	batch = &get_locked_var(batched_entropy_int_lock, batched_entropy_int);
 	if (batch->position % ARRAY_SIZE(batch->entropy_int) == 0) {
 		extract_crng((u8 *)batch->entropy_int);
 		batch->position = 0;
 	}
 	ret = batch->entropy_int[batch->position++];
-	put_cpu_var(batched_entropy_int);
+	put_locked_var(batched_entropy_int_lock, batched_entropy_int);
 	return ret;
 }
 #endif
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -170,6 +170,7 @@ extern struct task_group root_task_group;
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters = RB_ROOT,						\
+	.pi_top_task = NULL,						\
 	.pi_waiters_leftmost = NULL,
 #else
 # define INIT_RT_MUTEXES(tsk)
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1751,6 +1751,8 @@ struct task_struct {
 	/* PI waiters blocked on a rt_mutex held by this task */
 	struct rb_root pi_waiters;
 	struct rb_node *pi_waiters_leftmost;
+	/* Updated under owner's pi_lock and rq lock */
+	struct task_struct	*pi_top_task;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
 #endif
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -16,27 +16,20 @@ static inline int rt_task(struct task_struct *p)
 }
 
 #ifdef CONFIG_RT_MUTEXES
-extern int rt_mutex_getprio(struct task_struct *p);
-extern void rt_mutex_setprio(struct task_struct *p, int prio);
-extern int rt_mutex_get_effective_prio(struct task_struct *task, int newprio);
-extern struct task_struct *rt_mutex_get_top_task(struct task_struct *task);
+/*
+ * Must hold either p->pi_lock or task_rq(p)->lock.
+ */
+static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *p)
+{
+	return p->pi_top_task;
+}
+extern void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
 static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
 {
 	return tsk->pi_blocked_on != NULL;
 }
 #else
-static inline int rt_mutex_getprio(struct task_struct *p)
-{
-	return p->normal_prio;
-}
-
-static inline int rt_mutex_get_effective_prio(struct task_struct *task,
-					      int newprio)
-{
-	return newprio;
-}
-
 static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
 	return NULL;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -70,7 +70,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
-		__entry->prio		= p->prio;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
@@ -147,6 +147,7 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
+		/* XXX SCHED_DEADLINE */
 	),
 
 	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
@@ -181,7 +182,7 @@ TRACE_EVENT(sched_migrate_task,
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
-		__entry->prio		= p->prio;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->orig_cpu	= task_cpu(p);
 		__entry->dest_cpu	= dest_cpu;
 	),
@@ -206,7 +207,7 @@ DECLARE_EVENT_CLASS(sched_process_template,
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
-		__entry->prio		= p->prio;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 	),
 
 	TP_printk("comm=%s pid=%d prio=%d",
@@ -253,7 +254,7 @@ TRACE_EVENT(sched_process_wait,
 	TP_fast_assign(
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 		__entry->pid		= pid_nr(pid);
-		__entry->prio		= current->prio;
+		__entry->prio		= current->prio; /* XXX SCHED_DEADLINE */
 	),
 
 	TP_printk("comm=%s pid=%d prio=%d",
@@ -413,9 +414,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
  */
 TRACE_EVENT(sched_pi_setprio,
 
-	TP_PROTO(struct task_struct *tsk, int newprio),
+	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
 
-	TP_ARGS(tsk, newprio),
+	TP_ARGS(tsk, pi_task),
 
 	TP_STRUCT__entry(
 		__array( char,	comm,	TASK_COMM_LEN	)
@@ -428,7 +429,8 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= newprio;
+		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		/* XXX SCHED_DEADLINE bits missing */
 	),
 
 	TP_printk("comm=%s pid=%d oldprio=%d newprio=%d",
diff --git a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1453,6 +1453,7 @@ static void rt_mutex_init_task(struct task_struct *p)
 #ifdef CONFIG_RT_MUTEXES
 	p->pi_waiters = RB_ROOT;
 	p->pi_waiters_leftmost = NULL;
+	p->pi_top_task = NULL;
 	p->pi_blocked_on = NULL;
 #endif
 }
diff --git a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1025,7 +1025,8 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
-	int ret, uval2;
+	u32 uval2;
+	int ret;
 
 	/*
 	 * Userspace might have messed up non-PI and PI futexes [3]
@@ -1379,10 +1380,11 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	wake_q_add(wake_q, p);
 	__unqueue_futex(q);
 	/*
-	 * The waiting task can free the futex_q as soon as
-	 * q->lock_ptr = NULL is written, without taking any locks. A
-	 * memory barrier is required here to prevent the following
-	 * store to lock_ptr from getting ahead of the plist_del.
+	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
+	 * is written, without taking any locks. This is possible in the event
+	 * of a spurious wakeup, for example. A memory barrier is required here
+	 * to prevent the following store to lock_ptr from getting ahead of the
+	 * plist_del in __unqueue_futex().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
 }
@@ -1394,7 +1396,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 {
 	u32 uninitialized_var(curval), newval;
 	struct task_struct *new_owner;
-	bool deboost = false;
+	bool postunlock = false;
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
 	int ret = 0;
@@ -1442,6 +1444,11 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * This is a point of no return; once we modify the uval there is no
+	 * going back and subsequent operations must not fail.
+	 */
+
 	raw_spin_lock(&pi_state->owner->pi_lock);
 	WARN_ON(list_empty(&pi_state->list));
 	list_del_init(&pi_state->list);
@@ -1453,20 +1460,13 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	pi_state->owner = new_owner;
 	raw_spin_unlock(&new_owner->pi_lock);
 
-	/*
-	 * We've updated the uservalue, this unlock cannot fail.
-	 */
-	deboost = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q,
-					  &wake_sleeper_q);
-
+	postunlock = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q,
+					     &wake_sleeper_q);
 out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
-	if (deboost) {
-		wake_up_q(&wake_q);
-		wake_up_q_sleeper(&wake_sleeper_q);
-		rt_mutex_adjust_prio(current);
-	}
+	if (postunlock)
+		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
 
 	return ret;
 }
@@ -2760,8 +2760,10 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 out_put_key:
 	put_futex_key(&q.key);
 out:
-	if (to)
+	if (to) {
+		hrtimer_cancel(&to->timer);
 		destroy_hrtimer_on_stack(&to->timer);
+	}
 	return ret != -EINTR ? ret : -ERESTARTNOINTR;
 
 uaddr_faulted:
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -234,12 +234,25 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 #endif
 
+#define STEAL_NORMAL  0
+#define STEAL_LATERAL 1
+/*
+ * Only use with rt_mutex_waiter_{less,equal}()
+ */
+#define task_to_waiter(p)	\
+	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+
 static inline int
 rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-		     struct rt_mutex_waiter *right)
+		     struct rt_mutex_waiter *right, int mode)
 {
-	if (left->prio < right->prio)
-		return 1;
+	if (mode == STEAL_NORMAL) {
+		if (left->prio < right->prio)
+			return 1;
+	} else {
+		if (left->prio <= right->prio)
+			return 1;
+	}
 
 	/*
 	 * If both waiters have dl_prio(), we check the deadlines of the
@@ -248,12 +261,30 @@ rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	 * then right waiter has a dl_prio() too.
 	 */
 	if (dl_prio(left->prio))
-		return dl_time_before(left->task->dl.deadline,
-				      right->task->dl.deadline);
+		return dl_time_before(left->deadline, right->deadline);
 
 	return 0;
 }
 
+static inline int
+rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
+		      struct rt_mutex_waiter *right)
+{
+	if (left->prio != right->prio)
+		return 0;
+
+	/*
+	 * If both waiters have dl_prio(), we check the deadlines of the
+	 * associated tasks.
+	 * If left waiter has a dl_prio(), and we didn't return 0 above,
+	 * then right waiter has a dl_prio() too.
+	 */
+	if (dl_prio(left->prio))
+		return left->deadline == right->deadline;
+
+	return 1;
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
@@ -265,7 +296,7 @@ rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
+		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -304,7 +335,7 @@ rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
+		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -332,72 +363,16 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 }
 
-/*
- * Calculate task priority from the waiter tree priority
- *
- * Return task->normal_prio when the waiter tree is empty or when
- * the waiter is not allowed to do priority boosting
- */
-int rt_mutex_getprio(struct task_struct *task)
+static void rt_mutex_adjust_prio(struct task_struct *p)
 {
-	if (likely(!task_has_pi_waiters(task)))
-		return task->normal_prio;
+	struct task_struct *pi_task = NULL;
 
-	return min(task_top_pi_waiter(task)->prio,
-		   task->normal_prio);
-}
+	lockdep_assert_held(&p->pi_lock);
 
-struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
-{
-	if (likely(!task_has_pi_waiters(task)))
-		return NULL;
+	if (task_has_pi_waiters(p))
+		pi_task = task_top_pi_waiter(p)->task;
 
-	return task_top_pi_waiter(task)->task;
-}
-
-/*
- * Called by sched_setscheduler() to get the priority which will be
- * effective after the change.
- */
-int rt_mutex_get_effective_prio(struct task_struct *task, int newprio)
-{
-	if (!task_has_pi_waiters(task))
-		return newprio;
-
-	if (task_top_pi_waiter(task)->task->prio <= newprio)
-		return task_top_pi_waiter(task)->task->prio;
-	return newprio;
-}
-
-/*
- * Adjust the priority of a task, after its pi_waiters got modified.
- *
- * This can be both boosting and unboosting. task->pi_lock must be held.
- */
-static void __rt_mutex_adjust_prio(struct task_struct *task)
-{
-	int prio = rt_mutex_getprio(task);
-
-	if (task->prio != prio || dl_prio(prio))
-		rt_mutex_setprio(task, prio);
-}
-
-/*
- * Adjust task priority (undo boosting). Called from the exit path of
- * rt_mutex_slowunlock() and rt_mutex_slowlock().
- *
- * (Note: We do this outside of the protection of lock->wait_lock to
- * allow the lock to be taken while or before we readjust the priority
- * of task. We do not use the spin_xx_mutex() variants here as we are
- * outside of the debug path.)
- */
-void rt_mutex_adjust_prio(struct task_struct *task)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
-	__rt_mutex_adjust_prio(task);
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	rt_mutex_setprio(p, pi_task);
 }
 
 /*
@@ -629,7 +604,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (waiter->prio == task->prio) {
+	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -725,7 +700,26 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* [7] Requeue the waiter in the lock waiter tree. */
 	rt_mutex_dequeue(lock, waiter);
+
+	/*
+	 * Update the waiter prio fields now that we're dequeued.
+	 *
+	 * These values can have changed through either:
+	 *
+	 *   sys_sched_set_scheduler() / sys_sched_setattr()
+	 *
+	 * or
+	 *
+	 *   DL CBS enforcement advancing the effective deadline.
+	 *
+	 * Even though pi_waiters also uses these fields, and that tree is only
+	 * updated in [11], we can do this here, since we hold [L], which
+	 * serializes all pi_waiters access and rb_erase() does not care about
+	 * the values of the node being removed.
+	 */
 	waiter->prio = task->prio;
+	waiter->deadline = task->dl.deadline;
+
 	rt_mutex_enqueue(lock, waiter);
 
 	/* [8] Release the task */
@@ -769,7 +763,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
 		rt_mutex_enqueue_pi(task, waiter);
-		__rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -785,7 +779,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
 		rt_mutex_enqueue_pi(task, waiter);
-		__rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -843,24 +837,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 }
 
 
-#define STEAL_NORMAL  0
-#define STEAL_LATERAL 1
-
-/*
- * Note that RT tasks are excluded from lateral-steals to prevent the
- * introduction of an unbounded latency
- */
-static inline int lock_is_stealable(struct task_struct *task,
-				    struct task_struct *pendowner, int mode)
-{
-    if (mode == STEAL_NORMAL || rt_task(task)) {
-	    if (task->prio >= pendowner->prio)
-		    return 0;
-    } else if (task->prio > pendowner->prio)
-	    return 0;
-    return 1;
-}
-
 /*
  * Try to take an rt-mutex
  *
@@ -875,6 +851,8 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 				  struct task_struct *task,
 				  struct rt_mutex_waiter *waiter, int mode)
 {
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Before testing whether we can acquire @lock, we set the
 	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
@@ -911,7 +889,7 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 		 * @lock, give up.
 		 */
 		if (waiter != rt_mutex_top_waiter(lock)) {
-			/* XXX lock_is_stealable() ? */
+			/* XXX rt_mutex_waiter_less() ? */
 			return 0;
 		}
 
@@ -933,7 +911,23 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 		if (rt_mutex_has_waiters(lock)) {
 			struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
 
-			if (task != pown && !lock_is_stealable(task, pown, mode))
+			if (task != pown)
+				return 0;
+
+			/*
+			 * Note that RT tasks are excluded from lateral-steals
+			 * to prevent the introduction of an unbounded latency.
+			 */
+			if (rt_task(task))
+				mode = STEAL_NORMAL;
+			/*
+			 * If @task->prio is greater than or equal to
+			 * the top waiter priority (kernel view),
+			 * @task lost.
+			 */
+			if (!rt_mutex_waiter_less(task_to_waiter(task),
+						  rt_mutex_top_waiter(lock),
+						  mode))
 				return 0;
 			/*
 			 * The current top waiter stays enqueued. We
@@ -1142,9 +1136,9 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
 	debug_rt_mutex_free_waiter(&waiter);
 }
 
-static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
-				    struct wake_q_head *wake_sleeper_q,
-				    struct rt_mutex *lock);
+static bool __sched __rt_mutex_unlock_common(struct rt_mutex *lock,
+					     struct wake_q_head *wake_q,
+					     struct wake_q_head *wq_sleeper);
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
@@ -1153,25 +1147,14 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	unsigned long flags;
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
+	bool postunlock;
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	debug_rt_mutex_unlock(lock);
-
-	if (!rt_mutex_has_waiters(lock)) {
-		lock->owner = NULL;
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return;
-	}
-
-	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
-
+	postunlock = __rt_mutex_unlock_common(lock, &wake_q, &wake_sleeper_q);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	wake_up_q_sleeper(&wake_sleeper_q);
 
-	/* Undo pi boosting.when necessary */
-	rt_mutex_adjust_prio(current);
+	if (postunlock)
+		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
 }
 
 void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
@@ -1384,6 +1367,8 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	struct rt_mutex *next_lock;
 	int chain_walk = 0, res;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Early deadlock detection. We really don't want the task to
 	 * enqueue on itself just to untangle the mess later. It's not
@@ -1414,10 +1399,11 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
 
-	__rt_mutex_adjust_prio(task);
+	rt_mutex_adjust_prio(task);
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
+	waiter->deadline = task->dl.deadline;
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1436,7 +1422,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		__rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1489,12 +1475,14 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	waiter = rt_mutex_top_waiter(lock);
 
 	/*
-	 * Remove it from current->pi_waiters. We do not adjust a
-	 * possible priority boost right now. We execute wakeup in the
-	 * boosted mode and go back to normal after releasing
-	 * lock->wait_lock.
+	 * Remove it from current->pi_waiters and deboost.
+	 *
+	 * We must in fact deboost here in order to ensure we call
+	 * rt_mutex_setprio() to update p->pi_top_task before the
+	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
+	rt_mutex_adjust_prio(current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1506,12 +1494,22 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 */
 	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
 
-	raw_spin_unlock(&current->pi_lock);
-
+	/*
+	 * We deboosted before waking the top waiter task such that we don't
+	 * run two tasks with the 'same' priority (and ensure the
+	 * p->pi_top_task pointer points to a blocked task). This however can
+	 * lead to priority inversion if we would get preempted after the
+	 * deboost but before waking our donor task, hence the preempt_disable()
+	 * before unlock.
+	 *
+	 * Pairs with preempt_enable() in rt_mutex_postunlock();
+	 */
+	preempt_disable();
 	if (waiter->savestate)
 		wake_q_add(wake_sleeper_q, waiter->task);
 	else
 		wake_q_add(wake_q, waiter->task);
+	raw_spin_unlock(&current->pi_lock);
 }
 
 /*
@@ -1527,6 +1525,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
@@ -1546,7 +1546,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	__rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	if (rt_mutex_real_waiter(owner->pi_blocked_on))
@@ -1586,8 +1586,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!rt_mutex_real_waiter(waiter) || (waiter->prio == task->prio &&
-			!dl_prio(task->prio))) {
+	if (!rt_mutex_real_waiter(waiter) ||
+	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -1886,7 +1886,8 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 
 /*
  * Slow path to release a rt-mutex.
- * Return whether the current task needs to undo a potential priority boosting.
+ *
+ * Return whether the current task needs to call rt_mutex_postunlock().
  */
 static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 					struct wake_q_head *wake_q,
@@ -1945,11 +1946,9 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
 	mark_wakeup_next_waiter(wake_q, wake_sleeper_q, lock);
-
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	/* check PI boosting */
-	return true;
+	return true; /* call rt_mutex_postunlock() */
 }
 
 /*
@@ -1999,6 +1998,19 @@ rt_mutex_fasttrylock(struct rt_mutex *lock,
 	return slowfn(lock);
 }
 
+/*
+ * Performs the wakeup of the the top-waiter and re-enables preemption.
+ */
+void rt_mutex_postunlock(struct wake_q_head *wake_q,
+			 struct wake_q_head *wq_sleeper)
+{
+	wake_up_q(wake_q);
+	wake_up_q_sleeper(wq_sleeper);
+
+	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	preempt_enable();
+}
+
 static inline void
 rt_mutex_fastunlock(struct rt_mutex *lock,
 		    bool (*slowfn)(struct rt_mutex *lock,
@@ -2007,19 +2019,12 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 {
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
-	bool deboost;
 
 	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
 		return;
 
-	deboost = slowfn(lock, &wake_q, &wake_sleeper_q);
-
-	wake_up_q(&wake_q);
-	wake_up_q_sleeper(&wake_sleeper_q);
-
-	/* Undo pi boosting if necessary: */
-	if (deboost)
-		rt_mutex_adjust_prio(current);
+	if (slowfn(lock, &wake_q,  &wake_sleeper_q))
+		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
 }
 
 /**
@@ -2145,13 +2150,9 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
-/**
- * Futex variant, that since futex variants do not use the fast-path, can be
- * simple and will not need to retry.
- */
-bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				    struct wake_q_head *wake_q,
-				    struct wake_q_head *wq_sleeper)
+static bool __sched __rt_mutex_unlock_common(struct rt_mutex *lock,
+					     struct wake_q_head *wake_q,
+					     struct wake_q_head *wq_sleeper)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -2162,25 +2163,40 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 		return false; /* done */
 	}
 
+	/*
+	 * We've already deboosted, mark_wakeup_next_waiter() will
+	 * retain preempt_disabled when we drop the wait_lock, to
+	 * avoid inversion prior to the wakeup.  preempt_disable()
+	 * therein pairs with rt_mutex_postunlock().
+	 */
 	mark_wakeup_next_waiter(wake_q, wq_sleeper, lock);
-	return true; /* deboost and wakeups */
+
+	return true; /* call postunlock() */
+}
+
+/**
+ * Futex variant, that since futex variants do not use the fast-path, can be
+ * simple and will not need to retry.
+ */
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
+				    struct wake_q_head *wake_q,
+				    struct wake_q_head *wq_sleeper)
+{
+	return __rt_mutex_unlock_common(lock, wake_q, wq_sleeper);
 }
 
 void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
-	bool deboost;
+	bool postunlock;
 
 	raw_spin_lock_irq(&lock->wait_lock);
-	deboost = __rt_mutex_futex_unlock(lock, &wake_q, &wake_sleeper_q);
+	postunlock = __rt_mutex_futex_unlock(lock, &wake_q, &wake_sleeper_q);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-	if (deboost) {
-		wake_up_q(&wake_q);
-		wake_up_q_sleeper(&wake_sleeper_q);
-		rt_mutex_adjust_prio(current);
-	}
+	if (postunlock)
+		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
 }
 
 /**
@@ -2380,6 +2396,7 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
+	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2389,6 +2406,24 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
 
+	/*
+	 * RT has a problem here when the wait got interrupted by a timeout
+	 * or a signal. task->pi_blocked_on is still set. The task must
+	 * acquire the hash bucket lock when returning from this function.
+	 *
+	 * If the hash bucket lock is contended then the
+	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
+	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
+	 * clearing task->pi_blocked_on which removes the task from the
+	 * boosting chain of the rtmutex. That's correct because the task
+	 * is not longer blocked on it.
+	 */
+	if (ret) {
+		raw_spin_lock(&tsk->pi_lock);
+		tsk->pi_blocked_on = NULL;
+		raw_spin_unlock(&tsk->pi_lock);
+	}
+
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -34,6 +34,7 @@ struct rt_mutex_waiter {
 	struct rt_mutex		*deadlock_lock;
 #endif
 	int prio;
+	u64 deadline;
 };
 
 /*
@@ -127,7 +128,8 @@ extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
 				 struct wake_q_head *wqh,
 				 struct wake_q_head *wq_sleeper);
 
-extern void rt_mutex_adjust_prio(struct task_struct *task);
+extern void rt_mutex_postunlock(struct wake_q_head *wake_q,
+				struct wake_q_head *wq_sleeper);
 
 /* RW semaphore special interface */
 struct ww_acquire_ctx;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3862,10 +3862,25 @@ EXPORT_SYMBOL(default_wake_function);
 
 #ifdef CONFIG_RT_MUTEXES
 
+static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
+{
+	if (pi_task)
+		prio = min(prio, pi_task->prio);
+
+	return prio;
+}
+
+static inline int rt_effective_prio(struct task_struct *p, int prio)
+{
+	struct task_struct *pi_task = rt_mutex_get_top_task(p);
+
+	return __rt_effective_prio(pi_task, prio);
+}
+
 /*
  * rt_mutex_setprio - set the current priority of a task
- * @p: task
- * @prio: prio value (kernel-internal form)
+ * @p: task to boost
+ * @pi_task: donor task
  *
  * This function changes the 'effective' priority of a task. It does
  * not touch ->normal_prio like __setscheduler().
@@ -3873,16 +3888,40 @@ EXPORT_SYMBOL(default_wake_function);
  * Used by the rt_mutex code to implement priority inheritance
  * logic. Call site only calls if the priority of the task changed.
  */
-void rt_mutex_setprio(struct task_struct *p, int prio)
+void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int oldprio, queued, running, queue_flag = DEQUEUE_SAVE | DEQUEUE_MOVE;
+	int prio, oldprio, queued, running, queue_flag = DEQUEUE_SAVE | DEQUEUE_MOVE;
 	const struct sched_class *prev_class;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	BUG_ON(prio > MAX_PRIO);
+	/* XXX used to be waiter->prio, not waiter->task->prio */
+	prio = __rt_effective_prio(pi_task, p->normal_prio);
+
+	/*
+	 * If nothing changed; bail early.
+	 */
+	if (p->pi_top_task == pi_task && prio == p->prio && !dl_prio(prio))
+		return;
 
 	rq = __task_rq_lock(p, &rf);
+	/*
+	 * Set under pi_lock && rq->lock, such that the value can be used under
+	 * either lock.
+	 *
+	 * Note that there is loads of tricky to make this pointer cache work
+	 * right. rt_mutex_slowunlock()+rt_mutex_postunlock() work together to
+	 * ensure a task is de-boosted (pi_task is set to NULL) before the
+	 * task is allowed to run again (and can exit). This ensures the pointer
+	 * points to a blocked task -- which guaratees the task is present.
+	 */
+	p->pi_top_task = pi_task;
+
+	/*
+	 * For FIFO/RR we only need to set prio, if that matches we're done.
+	 */
+	if (prio == p->prio && !dl_prio(prio))
+		goto out_unlock;
 
 	/*
 	 * Idle task boosting is a nono in general. There is one
@@ -3902,7 +3941,7 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 		goto out_unlock;
 	}
 
-	trace_sched_pi_setprio(p, prio);
+	trace_sched_pi_setprio(p, pi_task);
 	oldprio = p->prio;
 
 	if (oldprio == prio)
@@ -3926,7 +3965,6 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 	 *          running task
 	 */
 	if (dl_prio(prio)) {
-		struct task_struct *pi_task = rt_mutex_get_top_task(p);
 		if (!dl_prio(p->normal_prio) ||
 		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
@@ -3963,6 +4001,11 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 	balance_callback(rq);
 	preempt_enable();
 }
+#else
+static inline int rt_effective_prio(struct task_struct *p, int prio)
+{
+	return prio;
+}
 #endif
 
 void set_user_nice(struct task_struct *p, long nice)
@@ -4207,10 +4250,9 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
 	 * Keep a potential priority boosting if called from
 	 * sched_setscheduler().
 	 */
+	p->prio = normal_prio(p);
 	if (keep_boost)
-		p->prio = rt_mutex_get_effective_prio(p, normal_prio(p));
-	else
-		p->prio = normal_prio(p);
+		p->prio = rt_effective_prio(p, p->prio);
 
 	if (dl_prio(p->prio))
 		p->sched_class = &dl_sched_class;
@@ -4497,7 +4539,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		 * the runqueue. This will be done when the task deboost
 		 * itself.
 		 */
-		new_effective_prio = rt_mutex_get_effective_prio(p, newprio);
+		new_effective_prio = rt_effective_prio(p, newprio);
 		if (new_effective_prio == oldprio)
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt17
+-rt18
