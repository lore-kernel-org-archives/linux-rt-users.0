From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC 3/3] rt: Check if the task needs to migrate when
 re-enabling migration
Date: Fri, 23 Jun 2017 15:14:52 +0200
Message-ID: <20170623131452.tb6yh6uqjeazrnv6@linutronix.de>
References: <cover.1497607974.git.bristot@redhat.com>
 <99de119c39e3af618efdb2f79bf30e60ca42a6ec.1497607974.git.bristot@redhat.com>
 <20170616165815.mvu2jr323xy3dhf3@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616165815.mvu2jr323xy3dhf3@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-16 18:58:15 [+0200], To Daniel Bristot de Oliveira wrote:
> Any objections?

Okay, taking this for v4.9 then (mostly the same, except for one
superfluous check):

Subject: [PATCH] sched/migrate disable: handle updated task-mask mg-dis section

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
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d779486ad6b..89b453dc7c14 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1535,6 +1535,7 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
+	int migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
 # endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 10e832da70b6..cadc1e14073d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1138,18 +1138,14 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
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
 
@@ -1172,6 +1168,20 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
@@ -3435,6 +3445,43 @@ void migrate_enable(void)
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
-- 
2.13.1
