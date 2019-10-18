Return-Path: <SRS0=Yxvf=YL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488AECA9EA9
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A54222C5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 14:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505104AbfJRO6Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:58:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfJRO6Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Oct 2019 10:58:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iLTho-0000uU-K1; Fri, 18 Oct 2019 16:58:16 +0200
Date:   Fri, 18 Oct 2019 16:58:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.21-rt13
Message-ID: <20191018145816.givfbhqkzc5xlgo4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.21-rt13 patch set. 

Changes since v5.2.21-rt12:

  - Various migrate_disable() related patches by Scott Wood. This are
    the last patches from his series which aim to to improve the
    performance of migrate_disable().

  - The cpufreq driver for AMD-K8 CPUs can be enabled again. Borislav
    Petkov was kind enough to test the driver on the hardware and he
    could not reproduce the original issue.

  - Don't initialize page table locks for the vector page on ARM. It was
    needed for the split page-table lock which was added to -RT first
    but now that the functionality is upstream it seems not be required
    anymore. "Seems" as in "nobody complained upstream about it" and "I
    can't reproduce the original bug report on current code".

Known issues
     - None

The delta patch against v5.2.21-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.21-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.21-rt13

The RT patch against v5.2.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.21-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.21-rt13.tar.xz

Sebastian

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1041300022177..f934a6739fc05 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -325,30 +325,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_MMU
-/*
- * CONFIG_SPLIT_PTLOCK_CPUS results in a page->ptl lock.  If the lock is not
- * initialized by pgtable_page_ctor() then a coredump of the vector page will
- * fail.
- */
-static int __init vectors_user_mapping_init_page(void)
-{
-	struct page *page;
-	unsigned long addr = 0xffff0000;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset_k(addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	page = pmd_page(*(pmd));
-
-	pgtable_page_ctor(page);
-
-	return 0;
-}
-late_initcall(vectors_user_mapping_init_page);
-
 #ifdef CONFIG_KUSER_HELPERS
 /*
  * The vectors page is always readable from user space for the
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 19bb0dfbaf0d2..dfa6457deaf60 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -126,7 +126,7 @@ config X86_POWERNOW_K7_ACPI
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ && !PREEMPT_RT_BASE
+	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ
 	help
 	  This adds the CPUFreq driver for K8/early Opteron/Athlon64 processors.
 	  Support for K10 and newer processors is now in acpi-cpufreq.
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index f4a772c12d140..2df500fdcbc44 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -113,8 +113,6 @@ extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
-extern void pin_current_cpu(void);
-extern void unpin_current_cpu(void);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -126,8 +124,6 @@ static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
-static inline void pin_current_cpu(void) { }
-static inline void unpin_current_cpu(void) { }
 
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e892e727f126..c6872b38bf770 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -229,6 +229,8 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+int cpu_nr_pinned(int cpu);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
@@ -661,16 +663,13 @@ struct task_struct {
 	cpumask_t			cpus_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
-	int				migrate_disable_update;
-	int				pinned_on_cpu;
+	bool				migrate_disable_scheduled;
 # ifdef CONFIG_SCHED_DEBUG
-	int				migrate_disable_atomic;
+	int				pinned_on_cpu;
 # endif
-
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 # ifdef CONFIG_SCHED_DEBUG
 	int				migrate_disable;
-	int				migrate_disable_atomic;
 # endif
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -2074,4 +2073,6 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+extern struct task_struct *takedown_cpu_task;
+
 #endif
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbeb..82fc686ddd9eb 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -26,6 +26,8 @@ struct cpu_stop_work {
 	cpu_stop_fn_t		fn;
 	void			*arg;
 	struct cpu_stop_done	*done;
+	/* Did not run due to disabled stopper; for nowait debug checks */
+	bool			disabled;
 };
 
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
diff --git a/init/init_task.c b/init/init_task.c
index e402413dc47d5..c0c7618fd2fb9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -81,6 +81,10 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE) && \
+    defined(CONFIG_SCHED_DEBUG)
+	.pinned_on_cpu	= -1,
+#endif
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 25afa2bb1a2cf..e1bf3c698a321 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -76,11 +76,6 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PREEMPT_RT_FULL)
-static DEFINE_PER_CPU(struct rt_rw_lock, cpuhp_pin_lock) = \
-	__RWLOCK_RT_INITIALIZER(cpuhp_pin_lock);
-#endif
-
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -287,57 +282,6 @@ static int cpu_hotplug_disabled;
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/**
- * pin_current_cpu - Prevent the current cpu from being unplugged
- */
-void pin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin;
-	unsigned int cpu;
-	int ret;
-
-again:
-	cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-	ret = __read_rt_trylock(cpuhp_pin);
-	if (ret) {
-		current->pinned_on_cpu = smp_processor_id();
-		return;
-	}
-	cpu = smp_processor_id();
-	preempt_lazy_enable();
-	preempt_enable();
-
-	sleeping_lock_inc();
-	__read_rt_lock(cpuhp_pin);
-	sleeping_lock_dec();
-
-	preempt_disable();
-	preempt_lazy_disable();
-	if (cpu != smp_processor_id()) {
-		__read_rt_unlock(cpuhp_pin);
-		goto again;
-	}
-	current->pinned_on_cpu = cpu;
-#endif
-}
-
-/**
- * unpin_current_cpu - Allow unplug of current cpu
- */
-void unpin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-
-	if (WARN_ON(current->pinned_on_cpu != smp_processor_id()))
-		cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, current->pinned_on_cpu);
-
-	current->pinned_on_cpu = -1;
-	__read_rt_unlock(cpuhp_pin);
-#endif
-}
-
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
 void cpus_read_lock(void)
@@ -895,6 +839,15 @@ static int take_cpu_down(void *_param)
 	int err, cpu = smp_processor_id();
 	int ret;
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+	/*
+	 * If any tasks disabled migration before we got here,
+	 * go back and sleep again.
+	 */
+	if (cpu_nr_pinned(cpu))
+		return -EAGAIN;
+#endif
+
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
@@ -924,11 +877,10 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+struct task_struct *takedown_cpu_task;
+
 static int takedown_cpu(unsigned int cpu)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, cpu);
-#endif
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int err;
 
@@ -941,17 +893,38 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_lock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	WARN_ON_ONCE(takedown_cpu_task);
+	takedown_cpu_task = current;
+
+again:
+	/*
+	 * If a task pins this CPU after we pass this check, take_cpu_down
+	 * will return -EAGAIN.
+	 */
+	for (;;) {
+		int nr_pinned;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		nr_pinned = cpu_nr_pinned(cpu);
+		if (nr_pinned == 0)
+			break;
+		schedule();
+	}
+	set_current_state(TASK_RUNNING);
 #endif
 
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (err == -EAGAIN)
+		goto again;
+#endif
 	if (err) {
-#ifdef CONFIG_PREEMPT_RT_FULL
-		__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+		takedown_cpu_task = NULL;
 #endif
 		/* CPU refused to die */
 		irq_unlock_sparse();
@@ -971,8 +944,8 @@ static int takedown_cpu(unsigned int cpu)
 	wait_for_ap_thread(st, false);
 	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	takedown_cpu_task = NULL;
 #endif
 	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
 	irq_unlock_sparse();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 93b4ae1ecaff8..6383ade320f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1051,6 +1051,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	bool done;
 };
 
 /*
@@ -1086,6 +1087,11 @@ static int migration_cpu_stop(void *data)
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	int dest_cpu = arg->dest_cpu;
+
+	/* We don't look at arg after this point. */
+	smp_mb();
+	arg->done = true;
 
 	/*
 	 * The original target CPU might have gone down and we might
@@ -1108,9 +1114,9 @@ static int migration_cpu_stop(void *data)
 	 */
 	if (task_rq(p) == rq) {
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
-			p->wake_cpu = arg->dest_cpu;
+			p->wake_cpu = dest_cpu;
 	}
 	rq_unlock(rq, &rf);
 	raw_spin_unlock(&p->pi_lock);
@@ -1126,7 +1132,8 @@ static int migration_cpu_stop(void *data)
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	if (p->cpus_ptr == &p->cpus_mask)
+		p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
@@ -1137,8 +1144,7 @@ int __migrate_disabled(struct task_struct *p)
 EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
-static void __do_set_cpus_allowed_tail(struct task_struct *p,
-				       const struct cpumask *new_mask)
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -1167,20 +1173,6 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 		set_curr_task(rq, p);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		lockdep_assert_held(&p->pi_lock);
-
-		cpumask_copy(&p->cpus_mask, new_mask);
-		p->migrate_disable_update = 1;
-		return;
-	}
-#endif
-	__do_set_cpus_allowed_tail(p, new_mask);
-}
-
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1239,7 +1231,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	}
 
 	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
+	if (cpumask_test_cpu(task_cpu(p), new_mask) ||
+	    p->cpus_ptr != &p->cpus_mask)
 		goto out;
 
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
@@ -3502,6 +3495,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+static void migrate_disabled_sched(struct task_struct *p);
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -3572,6 +3567,9 @@ static void __sched notrace __schedule(bool preempt)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+	if (__migrate_disabled(prev))
+		migrate_disabled_sched(prev);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -5822,6 +5820,8 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
+		WARN_ON_ONCE(__migrate_disabled(next));
+
 		/*
 		 * Rules for changing task_struct::cpus_mask are holding
 		 * both pi_lock and rq->lock, such that holding either
@@ -7317,14 +7317,9 @@ update_nr_migratory(struct task_struct *p, long delta)
 static inline void
 migrate_disable_update_cpus_allowed(struct task_struct *p)
 {
-	struct rq *rq;
-	struct rq_flags rf;
-
-	rq = task_rq_lock(p, &rf);
 	p->cpus_ptr = cpumask_of(smp_processor_id());
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline void
@@ -7342,54 +7337,35 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
 
 void migrate_disable(void)
 {
-	struct task_struct *p = current;
-
-	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic++;
-#endif
-		return;
-	}
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-#endif
-
-	if (p->migrate_disable) {
-		p->migrate_disable++;
-		return;
-	}
-
 	preempt_disable();
-	preempt_lazy_disable();
-	pin_current_cpu();
 
-	migrate_disable_update_cpus_allowed(p);
-	p->migrate_disable = 1;
+	if (++current->migrate_disable == 1) {
+		this_rq()->nr_pinned++;
+		preempt_lazy_disable();
+#ifdef CONFIG_SCHED_DEBUG
+		WARN_ON_ONCE(current->pinned_on_cpu >= 0);
+		current->pinned_on_cpu = smp_processor_id();
+#endif
+	}
 
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_disable);
 
+static void migrate_disabled_sched(struct task_struct *p)
+{
+	if (p->migrate_disable_scheduled)
+		return;
+
+	migrate_disable_update_cpus_allowed(p);
+	p->migrate_disable_scheduled = 1;
+}
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
-
-	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic--;
-#endif
-		return;
-	}
-
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-#endif
+	struct rq *rq = this_rq();
+	int cpu = task_cpu(p);
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	if (p->migrate_disable > 1) {
@@ -7399,70 +7375,65 @@ void migrate_enable(void)
 
 	preempt_disable();
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ON_ONCE(current->pinned_on_cpu != cpu);
+	current->pinned_on_cpu = -1;
+#endif
+
+	WARN_ON_ONCE(rq->nr_pinned < 1);
+
 	p->migrate_disable = 0;
+	rq->nr_pinned--;
+	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
+	    takedown_cpu_task)
+		wake_up_process(takedown_cpu_task);
+
+	if (!p->migrate_disable_scheduled)
+		goto out;
+
+	p->migrate_disable_scheduled = 0;
+
 	migrate_enable_update_cpus_allowed(p);
 
-	if (p->migrate_disable_update) {
-		struct rq *rq;
+	WARN_ON(smp_processor_id() != cpu);
+	if (!is_cpu_allowed(p, cpu)) {
+		struct migration_arg arg = { p };
+		struct cpu_stop_work work;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-
-		__do_set_cpus_allowed_tail(p, &p->cpus_mask);
+		arg.dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
-		p->migrate_disable_update = 0;
-
-		WARN_ON(smp_processor_id() != task_cpu(p));
-		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
-			const struct cpumask *cpu_valid_mask = cpu_active_mask;
-			struct migration_arg arg;
-			unsigned int dest_cpu;
-
-			if (p->flags & PF_KTHREAD) {
-				/*
-				 * Kernel threads are allowed on online && !active CPUs
-				 */
-				cpu_valid_mask = cpu_online_mask;
-			}
-			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_mask);
-			arg.task = p;
-			arg.dest_cpu = dest_cpu;
-
-			unpin_current_cpu();
-			preempt_lazy_enable();
-			preempt_enable();
-
-			sleeping_lock_inc();
-			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-			sleeping_lock_dec();
-			return;
-		}
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &arg, &work);
+		__schedule(true);
+		WARN_ON_ONCE(!arg.done && !work.disabled);
 	}
-	unpin_current_cpu();
+
+out:
 	preempt_lazy_enable();
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
 
+int cpu_nr_pinned(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return rq->nr_pinned;
+}
+
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
+
 void migrate_disable(void)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	struct task_struct *p = current;
-
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic++;
-		return;
-	}
-
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-
-	p->migrate_disable++;
+	current->migrate_disable++;
 #endif
 	barrier();
 }
@@ -7473,20 +7444,14 @@ void migrate_enable(void)
 #ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic--;
-		return;
-	}
-
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
 #endif
 	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
+#else
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9c1bbd67e9711..2e4db417049dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -952,6 +952,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT_BASE) && defined(CONFIG_SMP)
+	int			nr_pinned;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f5..fa53a472dd443 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -85,8 +85,11 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work, &wakeq);
-	else if (work->done)
-		cpu_stop_signal_done(work->done);
+	else {
+		work->disabled = true;
+		if (work->done)
+			cpu_stop_signal_done(work->done);
+	}
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index bd95716532889..5f2618d346c42 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,6 +23,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+	if (current->migrate_disable)
+		goto out;
+
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
