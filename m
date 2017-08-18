From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt10
Date: Fri, 18 Aug 2017 14:09:39 +0200
Message-ID: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
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

I'm pleased to announce the v4.11.12-rt10 patch set. 

Changes since v4.11.12-rt9:

  - A tweak to scheduler to let it know that a task is in a migration
    disabled region so there are less possible tasks to migrate. Idea
    and patch by Daniel Bristot de Oliveira.

  - A fix for the CPU idle code on arm64 was merged in v4.11.9-rt6 and
    now updated to version which queued for mainline.

  - hrtimers which fired during a bad window while a shutdown would be
    postponed for ever and could corrupt the deferred list. Reported by
    Mike Galbraith.

  - The new RWLOCK code a flaw in the write-lock path where a task could
    lose its task state. Reported and fixed by Mike Galbraith.

Known issues
	- There was a report regarding a deadlock within the rtmutex code.

The delta patch against v4.11.12-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt10

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt10.tar.xz

Sebastian
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -28,8 +28,15 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
 
+	/*
+	 * __atomic_notifier_call_chain has a RCU read critical section, which
+	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
+	 * RCU know this.
+	 */
+	rcu_irq_enter_irqson();
 	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
+	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -190,14 +190,14 @@ void __sched __write_rt_lock(struct rt_rw_lock *lock)
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &lock->readers);
 
+	raw_spin_lock_irqsave(&m->wait_lock, flags);
+
+	raw_spin_lock(&self->pi_lock);
+	self->saved_state = self->state;
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock(&self->pi_lock);
+
 	for (;;) {
-		raw_spin_lock_irqsave(&m->wait_lock, flags);
-
-		raw_spin_lock(&self->pi_lock);
-		self->saved_state = self->state;
-		__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
-		raw_spin_unlock(&self->pi_lock);
-
 		/* Have all readers left the critical region? */
 		if (!atomic_read(&lock->readers)) {
 			atomic_set(&lock->readers, WRITER_BIAS);
@@ -213,6 +213,12 @@ void __sched __write_rt_lock(struct rt_rw_lock *lock)
 
 		if (atomic_read(&lock->readers) != 0)
 			schedule();
+
+		raw_spin_lock_irqsave(&m->wait_lock, flags);
+
+		raw_spin_lock(&self->pi_lock);
+		__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+		raw_spin_unlock(&self->pi_lock);
 	}
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7499,6 +7499,47 @@ const u32 sched_prio_to_wmult[40] = {
 
 #if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
 
+static inline void
+update_nr_migratory(struct task_struct *p, long delta)
+{
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory += delta;
+		else
+			task_rq(p)->dl.dl_nr_migratory += delta;
+	}
+}
+
+static inline void
+migrate_disable_update_cpus_allowed(struct task_struct *p)
+{
+	struct rq *rq;
+	struct rq_flags rf;
+
+	p->cpus_ptr = cpumask_of(smp_processor_id());
+
+	rq = task_rq_lock(p, &rf);
+	update_nr_migratory(p, -1);
+	p->nr_cpus_allowed = 1;
+	task_rq_unlock(rq, p, &rf);
+}
+
+static inline void
+migrate_enable_update_cpus_allowed(struct task_struct *p)
+{
+	struct rq *rq;
+	struct rq_flags rf;
+
+	p->cpus_ptr = &p->cpus_mask;
+
+	rq = task_rq_lock(p, &rf);
+	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
+	update_nr_migratory(p, 1);
+	task_rq_unlock(rq, p, &rf);
+}
+
 void migrate_disable(void)
 {
 	struct task_struct *p = current;
@@ -7524,10 +7565,9 @@ void migrate_disable(void)
 	preempt_disable();
 	preempt_lazy_disable();
 	pin_current_cpu();
-	p->migrate_disable = 1;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-	p->nr_cpus_allowed = 1;
+	migrate_disable_update_cpus_allowed(p);
+	p->migrate_disable = 1;
 
 	preempt_enable();
 }
@@ -7559,9 +7599,8 @@ void migrate_enable(void)
 
 	preempt_disable();
 
-	p->cpus_ptr = &p->cpus_mask;
-	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	p->migrate_disable = 0;
+	migrate_enable_update_cpus_allowed(p);
 
 	if (p->migrate_disable_update) {
 		struct rq *rq;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -552,15 +552,21 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 
 #define P(x) \
 	SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rt_rq->x))
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(rt_rq->x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
-	P(rt_nr_running);
+	PU(rt_nr_running);
+#ifdef CONFIG_SMP
+	PU(rt_nr_migratory);
+#endif
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
 
 #undef PN
+#undef PU
 #undef P
 }
 
@@ -569,14 +575,21 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	struct dl_bw *dl_bw;
 
 	SEQ_printf(m, "\ndl_rq[%d]:\n", cpu);
-	SEQ_printf(m, "  .%-30s: %ld\n", "dl_nr_running", dl_rq->dl_nr_running);
+
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
+
+	PU(dl_nr_running);
 #ifdef CONFIG_SMP
+	PU(dl_nr_migratory);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 #else
 	dl_bw = &dl_rq->dl_bw;
 #endif
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
+
+#undef PU
 }
 
 extern __read_mostly int sched_clock_running;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1802,6 +1802,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	if (!list_empty(&new_base->expired))
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+#endif
 }
 
 int hrtimers_dead_cpu(unsigned int scpu)
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
