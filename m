From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.33-rt23
Date: Fri, 23 Jun 2017 16:31:43 +0200
Message-ID: <20170623143143.ohtw67i5y5cnp436@linutronix.de>
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

I'm pleased to announce the v4.9.33-rt23 patch set. 

Changes since v4.9.33-rt22:

  - A changed CPU mask while a task was in a migrate_disable() section
    did not run all its scheduler hooks after a migrate_enable(). Also
    it did not immediatelly switch the CPU if its CPU mask was did not
    contain the current CPU mask. Noticed while re-doing the migrate
    disable code for v4.11 and also reported by Daniel Bristot.

  - The removal of TASK_ALL in the last release uncovered a bug where we
    mixed normal wake ups and wake ups made for waiters of sleeping
    spinlock. Reported by Mike Galbraith.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.33-rt22 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.33-rt22-rt23.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.33-rt23

The RT patch against v4.9.33 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.33-rt23.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.33-rt23.tar.xz

Sebastian
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1014,8 +1014,20 @@ struct wake_q_head {
 #define WAKE_Q(name)					\
 	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
 
-extern void wake_q_add(struct wake_q_head *head,
-			      struct task_struct *task);
+extern void __wake_q_add(struct wake_q_head *head,
+			 struct task_struct *task, bool sleeper);
+static inline void wake_q_add(struct wake_q_head *head,
+			      struct task_struct *task)
+{
+	__wake_q_add(head, task, false);
+}
+
+static inline void wake_q_add_sleeper(struct wake_q_head *head,
+				      struct task_struct *task)
+{
+	__wake_q_add(head, task, true);
+}
+
 extern void __wake_up_q(struct wake_q_head *head, bool sleeper);
 
 static inline void wake_up_q(struct wake_q_head *head)
@@ -1535,6 +1547,7 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
+	int migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
 # endif
@@ -1745,6 +1758,7 @@ struct task_struct {
 	raw_spinlock_t pi_lock;
 
 	struct wake_q_node wake_q;
+	struct wake_q_node wake_q_sleeper;
 
 #ifdef CONFIG_RT_MUTEXES
 	/* PI waiters blocked on a rt_mutex held by this task */
diff --git a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -558,6 +558,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
+	tsk->wake_q_sleeper.next = NULL;
 
 	account_kernel_stack(tsk, 1);
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1506,7 +1506,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 */
 	preempt_disable();
 	if (waiter->savestate)
-		wake_q_add(wake_sleeper_q, waiter->task);
+		wake_q_add_sleeper(wake_sleeper_q, waiter->task);
 	else
 		wake_q_add(wake_q, waiter->task);
 	raw_spin_unlock(&current->pi_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -430,9 +430,15 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
-void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+void __wake_q_add(struct wake_q_head *head, struct task_struct *task,
+		  bool sleeper)
 {
-	struct wake_q_node *node = &task->wake_q;
+	struct wake_q_node *node;
+
+	if (sleeper)
+		node = &task->wake_q_sleeper;
+	else
+		node = &task->wake_q;
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
@@ -461,11 +467,17 @@ void __wake_up_q(struct wake_q_head *head, bool sleeper)
 	while (node != WAKE_Q_TAIL) {
 		struct task_struct *task;
 
-		task = container_of(node, struct task_struct, wake_q);
+		if (sleeper)
+			task = container_of(node, struct task_struct, wake_q_sleeper);
+		else
+			task = container_of(node, struct task_struct, wake_q);
 		BUG_ON(!task);
 		/* task can safely be re-inserted now */
 		node = node->next;
-		task->wake_q.next = NULL;
+		if (sleeper)
+			task->wake_q_sleeper.next = NULL;
+		else
+			task->wake_q.next = NULL;
 
 		/*
 		 * wake_up_process() implies a wmb() to pair with the queueing
@@ -1138,18 +1150,14 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void __do_set_cpus_allowed_tail(struct task_struct *p,
+				       const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
 	lockdep_assert_held(&p->pi_lock);
 
-	if (__migrate_disabled(p)) {
-		cpumask_copy(&p->cpus_allowed, new_mask);
-		return;
-	}
-
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 
@@ -1172,6 +1180,20 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_curr_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	if (__migrate_disabled(p)) {
+		lockdep_assert_held(&p->pi_lock);
+
+		cpumask_copy(&p->cpus_allowed, new_mask);
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+		p->migrate_disable_update = 1;
+#endif
+		return;
+	}
+	__do_set_cpus_allowed_tail(p, new_mask);
+}
+
 static DEFINE_PER_CPU(struct cpumask, sched_cpumasks);
 static DEFINE_MUTEX(sched_down_mutex);
 static cpumask_t sched_down_cpumask;
@@ -3435,6 +3457,43 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
+	if (p->migrate_disable_update) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		rq = task_rq_lock(p, &rf);
+		update_rq_clock(rq);
+
+		__do_set_cpus_allowed_tail(p, &p->cpus_allowed);
+		task_rq_unlock(rq, p, &rf);
+
+		p->migrate_disable_update = 0;
+
+		WARN_ON(smp_processor_id() != task_cpu(p));
+		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_allowed)) {
+			const struct cpumask *cpu_valid_mask = cpu_active_mask;
+			struct migration_arg arg;
+			unsigned int dest_cpu;
+
+			if (p->flags & PF_KTHREAD) {
+				/*
+				 * Kernel threads are allowed on online && !active CPUs
+				 */
+				cpu_valid_mask = cpu_online_mask;
+			}
+			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_allowed);
+			arg.task = p;
+			arg.dest_cpu = dest_cpu;
+
+			unpin_current_cpu();
+			preempt_lazy_enable();
+			preempt_enable();
+			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			tlb_migrate_finish(p->mm);
+			return;
+		}
+	}
+
 	unpin_current_cpu();
 	preempt_enable();
 	preempt_lazy_enable();
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt22
+-rt23
