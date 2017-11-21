From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/8] sched/migrate disable: handle updated task-mask mg-dis section
Date: Tue, 21 Nov 2017 11:07:00 -0500
Message-ID: <20171121160706.555560372@goodmis.org>
References: <20171121160654.493640386@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-sched-migrate-disable-handle-updated-task-mask-mg-di.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.97-rt111-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If task's cpumask changes while in the task is in a migrate_disable()
section then we don't react on it after a migrate_enable(). It matters
however if current CPU is no longer part of the cpumask. We also miss
the ->set_cpus_allowed() callback.
This patch fixes it by setting task->migrate_disable_update once we this
"delayed" hook.
This bug was introduced while fixing unrelated issue in
migrate_disable() in v4.4-rt3 (update_migrate_disable() got removed
during that).

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 56ccd0a3dd49..331cdbfc6431 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1438,6 +1438,7 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
+	int migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
 # endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 970b893a1d15..bea476417297 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1212,18 +1212,14 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
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
 
@@ -1246,6 +1242,20 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		enqueue_task(rq, p, ENQUEUE_RESTORE);
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
@@ -3231,6 +3241,43 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
+	if (p->migrate_disable_update) {
+		unsigned long flags;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &flags);
+		update_rq_clock(rq);
+
+		__do_set_cpus_allowed_tail(p, &p->cpus_allowed);
+		task_rq_unlock(rq, p, &flags);
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
-- 
2.13.2
