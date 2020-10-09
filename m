Return-Path: <SRS0=IZRq=DQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC22C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E372225B
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLrCBzwL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvB71fuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgJIWB7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Oct 2020 18:01:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJIWB6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Oct 2020 18:01:58 -0400
Date:   Sat, 10 Oct 2020 00:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602280908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RLeG7cxqEdq5BQIds8A8GZqbXrJGb+E9w3klLnPdkVs=;
        b=SLrCBzwL2tQvCN4HNg6Nw+oHFCQxUfTcgFXStxaf8QqwzInv2kkfBKs1wgJxlUkxyuLWJs
        AravwZD7T/IamjaP3VT+JOBmIycqJiYADwp0jpxhqmqXZdAVZXg1phPpIIfuL7acK87Dzi
        mzr4D0iLsucGTJlfHT2D+Z4yueSULl8ZGFz8sVFCy9mkU772esoi9BBx0hs+beSCjJqENj
        PpTzIdKu6WdxOh/M2jFJG/NlEpIWfFDiUGiezpdu9mKI1Vaof/JkPMNJPvfcoHc0JZySaW
        CL2etrzPEri5/GCFABxsaxd0QvvCINN5GoJ0dlTc6L/0oM/YWq9GhWAau+S9/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602280908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RLeG7cxqEdq5BQIds8A8GZqbXrJGb+E9w3klLnPdkVs=;
        b=ZvB71fuIjIqbvbC1M8tQrmx6GruLg6/BnIGVpZjYPNE94U/OCDtke8fNFPfpGATpoqTvKy
        FqsyONdV4m7woTAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc8-rt14
Message-ID: <20201009220146.tubrqcdbzg3opqtc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc8-rt14 patch set. 

Changes since v5.9-rc8-rt13:

  - Replace current migrate disable patches with Peter Zijlstra's
    migrate disable series. As part of the new implementation the manual
    balancing of the migrate vs preemption counter has been removed.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc8-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc8-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc8-rt14

The RT patch against v5.9-rc8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc8-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc8-rt14.tar.xz

Sebastian

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa802..7052441be9679 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -382,9 +382,9 @@ static inline void task_context_switch_counts(struct seq_file *m,
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bf9181cef444d..26b29e78dbc64 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -151,6 +151,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39f..383684e30f123 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -199,6 +199,11 @@ static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
+int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c5594c63c160f..e72b67e0ced8c 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -383,21 +383,66 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
 
+/*
+ * Migrate-Disable and why it is undesired.
+ *
+ * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * becomes one of the M highest priority tasks), it might still have to wait
+ * for the preemptee's migrate_disable() section to complete. Thereby suffering
+ * a reduction in bandwidth in the exact duration of the migrate_disable()
+ * section.
+ *
+ * Per this argument, the change from preempt_disable() to migrate_disable()
+ * gets us:
+ *
+ * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
+ *   it would have had to wait for the lower priority task.
+ *
+ * - a lower priority tasks; which under preempt_disable() could've instantly
+ *   migrated away when another CPU becomes available, is now constrained
+ *   by the ability to push the higher priority task away, which might itself be
+ *   in a migrate_disable() section, reducing it's available bandwidth.
+ *
+ * IOW it trades latency / moves the interference term, but it stays in the
+ * system, and as long as it remains unbounded, the system is not fully
+ * deterministic.
+ *
+ *
+ * The reason we have it anyway.
+ *
+ * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
+ * number of primitives into becoming preemptible, they would also allow
+ * migration. This turns out to break a bunch of per-cpu usage. To this end,
+ * all these primitives employ migirate_disable() to restore this implicit
+ * assumption.
+ *
+ * This is a 'temporary' work-around at best. The correct solution is getting
+ * rid of the above assumptions and reworking the code to employ explicit
+ * per-cpu locking or short preempt-disable regions.
+ *
+ * The end goal must be to get rid of migrate_disable(), alternatively we need
+ * a schedulability theory that does not depend on abritrary migration.
+ *
+ *
+ * Notes on the implementation.
+ *
+ * The implementation is particularly tricky since existing code patterns
+ * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
+ * This means that it cannot use cpus_read_lock() to serialize against hotplug,
+ * nor can it easily migrate itself into a pending affinity mask change on
+ * migrate_enable().
+ *
+ *
+ * Note: even non-work-conserving schedulers like semi-partitioned depends on
+ *       migration, so migrate_disable() is not only a problem for
+ *       work-conserving schedulers.
+ *
+ */
 extern void migrate_disable(void);
 extern void migrate_enable(void);
 
-int __migrate_disabled(struct task_struct *p);
+#else /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
 
-#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-
-extern void migrate_disable(void);
-extern void migrate_enable(void);
-static inline int __migrate_disabled(struct task_struct *p)
-{
-	return 0;
-}
-
-#else
 /**
  * migrate_disable - Prevent migration of the current task
  *
@@ -428,9 +473,6 @@ static __always_inline void migrate_enable(void)
 	preempt_enable();
 }
 
-static inline int __migrate_disabled(struct task_struct *p)
-{
-	return 0;
-}
-#endif
+#endif /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 29e9bfbb8766f..c72ae6627e967 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -232,8 +232,6 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
-int cpu_nr_pinned(int cpu);
-
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
@@ -720,17 +718,11 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+	void				*migration_pending;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-	int				migrate_disable;
-	bool				migrate_disable_scheduled;
-# ifdef CONFIG_SCHED_DEBUG
-	int				pinned_on_cpu;
-# endif
-#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-# ifdef CONFIG_SCHED_DEBUG
-	int				migrate_disable;
-# endif
+	unsigned short			migration_disabled;
 #endif
+	unsigned short			migration_flags;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -2165,6 +2157,4 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
-extern struct task_struct *takedown_cpu_task;
-
 #endif
diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
index 9a62ffdd296f0..412cdaba33eb4 100644
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -11,8 +11,10 @@ extern int sched_cpu_activate(unsigned int cpu);
 extern int sched_cpu_deactivate(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern int sched_cpu_wait_empty(unsigned int cpu);
 extern int sched_cpu_dying(unsigned int cpu);
 #else
+# define sched_cpu_wait_empty	NULL
 # define sched_cpu_dying	NULL
 #endif
 
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 99996aefc7a3e..30577c3aecf81 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -24,10 +24,9 @@ typedef int (*cpu_stop_fn_t)(void *arg);
 struct cpu_stop_work {
 	struct list_head	list;		/* cpu_stopper->works */
 	cpu_stop_fn_t		fn;
+	unsigned long		caller;
 	void			*arg;
 	struct cpu_stop_done	*done;
-	/* Did not run due to disabled stopper; for nowait debug checks */
-	bool			disabled;
 };
 
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
@@ -38,6 +37,8 @@ void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
 
+extern void print_stop_info(const char *log_lvl, struct task_struct *task);
+
 #else	/* CONFIG_SMP */
 
 #include <linux/workqueue.h>
@@ -82,6 +83,8 @@ static inline bool stop_one_cpu_nowait(unsigned int cpu,
 	return false;
 }
 
+static inline void print_stop_info(const char *log_lvl, struct task_struct *task) { }
+
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fec25b9cfbafa..f9bf9d8f30b89 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -646,6 +646,18 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_migrate_disable_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
+DECLARE_TRACE(sched_migrate_enable_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
+DECLARE_TRACE(sched_migrate_pull_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/init/init_task.c b/init/init_task.c
index c32b16be75332..f6889fce64af7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -82,10 +82,6 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT) && \
-    defined(CONFIG_SCHED_DEBUG)
-	.pinned_on_cpu	= -1,
-#endif
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 541f537871483..fa535eaa48265 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -864,15 +864,6 @@ static int take_cpu_down(void *_param)
 	int err, cpu = smp_processor_id();
 	int ret;
 
-#ifdef CONFIG_PREEMPT_RT
-	/*
-	 * If any tasks disabled migration before we got here,
-	 * go back and sleep again.
-	 */
-	if (cpu_nr_pinned(cpu))
-		return -EAGAIN;
-#endif
-
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
@@ -902,10 +893,6 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
-#ifdef CONFIG_PREEMPT_RT
-struct task_struct *takedown_cpu_task;
-#endif
-
 static int takedown_cpu(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
@@ -920,39 +907,11 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-#ifdef CONFIG_PREEMPT_RT
-	WARN_ON_ONCE(takedown_cpu_task);
-	takedown_cpu_task = current;
-
-again:
-	/*
-	 * If a task pins this CPU after we pass this check, take_cpu_down
-	 * will return -EAGAIN.
-	 */
-	for (;;) {
-		int nr_pinned;
-
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		nr_pinned = cpu_nr_pinned(cpu);
-		if (nr_pinned == 0)
-			break;
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-#endif
-
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
-#ifdef CONFIG_PREEMPT_RT
-	if (err == -EAGAIN)
-		goto again;
-#endif
 	if (err) {
-#ifdef CONFIG_PREEMPT_RT
-		takedown_cpu_task = NULL;
-#endif
 		/* CPU refused to die */
 		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
@@ -971,9 +930,6 @@ static int takedown_cpu(unsigned int cpu)
 	wait_for_ap_thread(st, false);
 	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
-#ifdef CONFIG_PREEMPT_RT
-	takedown_cpu_task = NULL;
-#endif
 	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
 	irq_unlock_sparse();
 
@@ -1646,7 +1602,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.name			= "ap:online",
 	},
 	/*
-	 * Handled on controll processor until the plugged processor manages
+	 * Handled on control processor until the plugged processor manages
 	 * this itself.
 	 */
 	[CPUHP_TEARDOWN_CPU] = {
@@ -1655,6 +1611,13 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= takedown_cpu,
 		.cant_stop		= true,
 	},
+
+	[CPUHP_AP_SCHED_WAIT_EMPTY] = {
+		.name			= "sched:waitempty",
+		.startup.single		= NULL,
+		.teardown.single	= sched_cpu_wait_empty,
+	},
+
 	/* Handle smpboot threads park/unpark */
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
diff --git a/kernel/futex.c b/kernel/futex.c
index 9853757335aed..1ca3581043fea 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -869,9 +869,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock_irq(&curr->pi_lock);
 			spin_unlock(&hb->lock);
-			raw_spin_lock_irq(&curr->pi_lock);
 			put_pi_state(pi_state);
 			continue;
 		}
@@ -2859,14 +2857,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	/*
-	 * the migrate_disable() here disables migration in the in_atomic() fast
-	 * path which is enabled again in the following spin_unlock(). We have
-	 * one migrate_disable() pending in the slow-path which is reversed
-	 * after the raw_spin_unlock_irq() where we leave the atomic context.
-	 */
-	migrate_disable();
-
 	spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
@@ -2875,7 +2865,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -3021,19 +3010,10 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		/*
-		 * Magic trickery for now to make the RT migrate disable
-		 * logic happy. The following spin_unlock() happens with
-		 * interrupts disabled so the internal migrate_enable()
-		 * won't undo the migrate_disable() which was issued when
-		 * locking hb->lock.
-		 */
-		migrate_disable();
 		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
-		migrate_enable();
 
 		put_pi_state(pi_state);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7200cf427ae86..29d8062ec4f5c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1769,6 +1769,86 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_PREEMPT_RT
+
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask,
+				  u32 flags);
+
+static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
+{
+	if (likely(!p->migration_disabled))
+		return;
+
+	if (p->cpus_ptr != &p->cpus_mask)
+		return;
+
+	/*
+	 * Violates locking rules! see comment in __do_set_cpus_allowed().
+	 */
+	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+}
+
+void migrate_disable(void)
+{
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+		p->migration_disabled++;
+		return;
+	}
+
+	trace_sched_migrate_disable_tp(p);
+
+	preempt_disable();
+	this_rq()->nr_pinned++;
+	p->migration_disabled = 1;
+	preempt_lazy_disable();
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
+		return;
+	}
+
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	preempt_disable();
+	if (p->cpus_ptr != &p->cpus_mask)
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled = 0;
+	this_rq()->nr_pinned--;
+	preempt_lazy_enable();
+	preempt_enable();
+
+	trace_sched_migrate_enable_tp(p);
+}
+EXPORT_SYMBOL_GPL(migrate_enable);
+
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned;
+}
+
+#endif
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -1778,7 +1858,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
+	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1825,7 +1905,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
-	bool done;
+	struct completion *done;
 };
 
 /*
@@ -1860,12 +1940,8 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
+	bool complete = false;
 	struct rq_flags rf;
-	int dest_cpu = arg->dest_cpu;
-
-	/* We don't look at arg after this point. */
-	smp_mb();
-	arg->done = true;
 
 	/*
 	 * The original target CPU might have gone down and we might
@@ -1887,15 +1963,70 @@ static int migration_cpu_stop(void *data)
 	 * we're holding p->pi_lock.
 	 */
 	if (task_rq(p) == rq) {
+		if (is_migration_disabled(p))
+			goto out;
+
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
+
+		if (arg->done) {
+			p->migration_pending = NULL;
+			complete = true;
+		}
 	}
+out:
 	rq_unlock(rq, &rf);
 	raw_spin_unlock(&p->pi_lock);
-
 	local_irq_enable();
+
+	if (complete)
+		complete_all(arg->done);
+
+	return 0;
+}
+
+int push_cpu_stop(void *arg)
+{
+	struct rq *lowest_rq = NULL, *rq = this_rq();
+	struct task_struct *p = arg;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock(&rq->lock);
+
+	if (task_rq(p) != rq)
+		goto out_unlock;
+
+	if (is_migration_disabled(p)) {
+		p->migration_flags |= MDF_PUSH;
+		goto out_unlock;
+	}
+
+	p->migration_flags &= ~MDF_PUSH;
+
+	if (p->sched_class->find_lock_rq)
+		lowest_rq = p->sched_class->find_lock_rq(p, rq);
+
+	if (!lowest_rq)
+		goto out_unlock;
+
+	// XXX validate p is still the highest prio task
+	if (task_rq(p) == rq) {
+		deactivate_task(rq, p, 0);
+		set_task_cpu(p, lowest_rq->cpu);
+		activate_task(lowest_rq, p, 0);
+		resched_curr(lowest_rq);
+	}
+
+	double_unlock_balance(rq, lowest_rq);
+
+out_unlock:
+	rq->push_busy = false;
+	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
 	return 0;
 }
 
@@ -1903,27 +2034,39 @@ static int migration_cpu_stop(void *data)
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
+	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = new_mask;
+		return;
+	}
+
 	cpumask_copy(&p->cpus_mask, new_mask);
-	if (p->cpus_ptr == &p->cpus_mask)
-		p->nr_cpus_allowed = cpumask_weight(new_mask);
+	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-int __migrate_disabled(struct task_struct *p)
-{
-	return p->migrate_disable;
-}
-EXPORT_SYMBOL_GPL(__migrate_disabled);
-#endif
-
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
-	lockdep_assert_held(&p->pi_lock);
+	/*
+	 * This here violates the locking rules for affinity, since we're only
+	 * supposed to change these variables while holding both rq->lock and
+	 * p->pi_lock.
+	 *
+	 * HOWEVER, it magically works, because ttwu() is the only code that
+	 * accesses these variables under p->pi_lock and only does so after
+	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
+	 * before finish_task().
+	 *
+	 * XXX do further audits, this smells like something putrid.
+	 */
+	if (flags & SCA_MIGRATE_DISABLE)
+		SCHED_WARN_ON(!p->on_cpu);
+	else
+		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
@@ -1939,7 +2082,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask);
+	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1947,6 +2090,130 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_next_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	__do_set_cpus_allowed(p, new_mask, 0);
+}
+
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
+};
+
+/*
+ * This function is wildly self concurrent, consider at least 3 times.
+ */
+static int affine_move_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int dest_cpu, unsigned int flags)
+{
+	struct set_affinity_pending my_pending = { }, *pending = NULL;
+	struct migration_arg arg = {
+		.task = p,
+		.dest_cpu = dest_cpu,
+	};
+	bool complete = false;
+
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+		struct task_struct *push_task = NULL;
+
+		if ((flags & SCA_MIGRATE_ENABLE) &&
+		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
+			rq->push_busy = true;
+			push_task = get_task_struct(p);
+		}
+
+		pending = p->migration_pending;
+		if (pending) {
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+		if (push_task) {
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    p, &rq->push_work);
+		}
+
+		if (complete)
+			goto do_complete;
+
+		return 0;
+	}
+
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		/* serialized by p->pi_lock */
+		if (!p->migration_pending) {
+			refcount_set(&my_pending.refs, 1);
+			init_completion(&my_pending.done);
+			p->migration_pending = &my_pending;
+		} else {
+			pending = p->migration_pending;
+			refcount_inc(&pending->refs);
+		}
+	}
+	pending = p->migration_pending;
+	/*
+	 * - !MIGRATE_ENABLE:
+	 *   we'll have installed a pending if there wasn't one already.
+	 *
+	 * - MIGRATE_ENABLE:
+	 *   we're here because the current CPU isn't matching anymore,
+	 *   the only way that can happen is because of a concurrent
+	 *   set_cpus_allowed_ptr() call, which should then still be
+	 *   pending completion.
+	 *
+	 * Either way, we really should have a @pending here.
+	 */
+	if (WARN_ON_ONCE(!pending))
+		return -EINVAL;
+
+	arg.done = &pending->done;
+
+	if (flags & SCA_MIGRATE_ENABLE) {
+
+		p->migration_flags &= ~MDF_PUSH;
+		task_rq_unlock(rq, p, rf);
+		pending->arg = arg;
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+
+		return 0;
+	}
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+
+		task_rq_unlock(rq, p, rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+	} else {
+
+		if (!is_migration_disabled(p)) {
+			if (task_on_rq_queued(p))
+				rq = move_queued_task(rq, rf, p, dest_cpu);
+
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+do_complete:
+		if (complete)
+			complete_all(&pending->done);
+	}
+
+	wait_for_completion(&pending->done);
+
+	if (refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
+
+	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
+
+	return 0;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1957,7 +2224,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+				  const struct cpumask *new_mask,
+				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
@@ -1968,9 +2236,14 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
+	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs
+		 * Kernel threads are allowed on online && !active CPUs.
+		 *
+		 * Specifically, migration_disabled() tasks must not fail the
+		 * cpumask_any_and_distribute() pick below, esp. so on
+		 * SCA_MIGRATE_ENABLE, otherwise we'll not call
+		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
 	}
@@ -1979,12 +2252,12 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if (check && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_mask, new_mask))
+	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*
@@ -1998,7 +2271,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	do_set_cpus_allowed(p, new_mask);
+	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (p->flags & PF_KTHREAD) {
 		/*
@@ -2010,24 +2283,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask) ||
-	    p->cpus_ptr != &p->cpus_mask)
-		goto out;
+	return affine_move_task(rq, &rf, p, dest_cpu, flags);
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
-		struct migration_arg arg = { p, dest_cpu };
-		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
-		return 0;
-	} else if (task_on_rq_queued(p)) {
-		/*
-		 * OK, since we're going to drop the lock immediately
-		 * afterwards anyway.
-		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
-	}
 out:
 	task_rq_unlock(rq, p, &rf);
 
@@ -2036,7 +2293,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -2077,6 +2334,8 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
+
+	WARN_ON_ONCE(is_migration_disabled(p));
 #endif
 
 	trace_sched_migrate_task(p, new_cpu);
@@ -2420,6 +2679,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			}
 			fallthrough;
 		case possible:
+			/*
+			 * XXX When called from select_task_rq() we only
+			 * hold p->pi_lock and again violate locking order.
+			 *
+			 * More yuck to audit.
+			 */
 			do_set_cpus_allowed(p, cpu_possible_mask);
 			state = fail;
 			break;
@@ -2454,7 +2719,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1)
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
 		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
@@ -2477,6 +2742,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
+	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	struct task_struct *old_stop = cpu_rq(cpu)->stop;
 
@@ -2492,6 +2758,20 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 		sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
 
 		stop->sched_class = &stop_sched_class;
+
+		/*
+		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
+		 * adjust the effective priority of a task. As a result,
+		 * rt_mutex_setprio() can trigger (RT) balancing operations,
+		 * which can then trigger wakeups of the stop thread to push
+		 * around the current task.
+		 *
+		 * The stop task itself will never be part of the PI-chain, it
+		 * never blocks, therefore that ->pi_lock recursion is safe.
+		 * Tell lockdep about this by placing the stop->pi_lock in its
+		 * own class.
+		 */
+		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
 	}
 
 	cpu_rq(cpu)->stop = stop;
@@ -2508,13 +2788,25 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 #else
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask, bool check)
+					 const struct cpumask *new_mask,
+					 u32 flags)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
 
 #endif /* CONFIG_SMP */
 
+#if !defined(CONFIG_SMP) || !defined(CONFIG_PREEMPT_RT)
+
+static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
+
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
+
+#endif
+
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -3620,6 +3912,91 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
+#ifdef CONFIG_SMP
+
+static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	void (*func)(struct rq *rq);
+	struct callback_head *next;
+
+	lockdep_assert_held(&rq->lock);
+
+	while (head) {
+		func = (void (*)(struct rq *))head->func;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+
+		func(rq);
+	}
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	struct callback_head *head = rq->balance_callback;
+
+	lockdep_assert_held(&rq->lock);
+	if (head) {
+		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
+
+	return head;
+}
+
+static void __balance_callbacks(struct rq *rq)
+{
+	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	unsigned long flags;
+
+	if (unlikely(head)) {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		do_balance_callbacks(rq, head);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
+static bool balance_push(struct rq *rq);
+
+static inline void balance_switch(struct rq *rq)
+{
+	if (unlikely(rq->balance_flags)) {
+		/*
+		 * Run the balance_callbacks, except on hotplug
+		 * when we need to push the current task away.
+		 */
+		if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+		    !(rq->balance_flags & BALANCE_PUSH) ||
+		    !balance_push(rq))
+			__balance_callbacks(rq);
+	}
+}
+
+#else
+
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return NULL;
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+}
+
+static inline void balance_switch(struct rq *rq)
+{
+}
+
+#endif
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -3645,6 +4022,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3781,43 +4159,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	return rq;
 }
 
-#ifdef CONFIG_SMP
-
-/* rq->lock is NOT held, but preemption is disabled */
-static void __balance_callback(struct rq *rq)
-{
-	struct callback_head *head, *next;
-	void (*func)(struct rq *rq);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	head = rq->balance_callback;
-	rq->balance_callback = NULL;
-	while (head) {
-		func = (void (*)(struct rq *))head->func;
-		next = head->next;
-		head->next = NULL;
-		head = next;
-
-		func(rq);
-	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
-}
-
-static inline void balance_callback(struct rq *rq)
-{
-	if (unlikely(rq->balance_callback))
-		__balance_callback(rq);
-}
-
-#else
-
-static inline void balance_callback(struct rq *rq)
-{
-}
-
-#endif
-
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
@@ -3837,7 +4178,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -4493,8 +4833,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
-static void migrate_disabled_sched(struct task_struct *p);
-
 /*
  * __schedule() is the main scheduler function.
  *
@@ -4573,9 +4911,6 @@ static void __sched notrace __schedule(bool preempt, bool spinning_lock)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
-	if (__migrate_disabled(prev))
-		migrate_disabled_sched(prev);
-
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -4651,6 +4986,7 @@ static void __sched notrace __schedule(bool preempt, bool spinning_lock)
 		 */
 		++*switch_count;
 
+		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next);
@@ -4659,10 +4995,11 @@ static void __sched notrace __schedule(bool preempt, bool spinning_lock)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-		rq_unlock_irq(rq, &rf);
-	}
 
-	balance_callback(rq);
+		rq_unpin_lock(rq, &rf);
+		__balance_callbacks(rq);
+		raw_spin_unlock_irq(&rq->lock);
+	}
 }
 
 void __noreturn do_task_dead(void)
@@ -5108,9 +5445,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-	__task_rq_unlock(rq, &rf);
 
-	balance_callback(rq);
+	rq_unpin_lock(rq, &rf);
+	__balance_callbacks(rq);
+	raw_spin_unlock(&rq->lock);
+
 	preempt_enable();
 }
 #else
@@ -5384,6 +5723,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5622,6 +5962,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5630,7 +5971,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(rq, head);
 	preempt_enable();
 
 	return 0;
@@ -6125,7 +6466,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
@@ -6708,7 +7049,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu));
+	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
@@ -6862,120 +7203,129 @@ void idle_task_exit(void)
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-/*
- * Since this CPU is going 'away' for a while, fold any nr_active delta
- * we might have. Assumes we're called after migrate_tasks() so that the
- * nr_active count is stable. We need to take the teardown thread which
- * is calling this into account, so we hand in adjust = 1 to the load
- * calculation.
- *
- * Also see the comment "Global load-average calculations".
- */
-static void calc_load_migrate(struct rq *rq)
+static int __balance_push_cpu_stop(void *arg)
 {
-	long delta = calc_load_fold_active(rq, 1);
-	if (delta)
-		atomic_long_add(delta, &calc_load_tasks);
-}
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
 
-static struct task_struct *__pick_migrate_task(struct rq *rq)
-{
-	const struct sched_class *class;
-	struct task_struct *next;
+	raw_spin_lock_irq(&p->pi_lock);
+	rq_lock(rq, &rf);
 
-	for_each_class(class) {
-		next = class->pick_next_task(rq);
-		if (next) {
-			next->sched_class->put_prev_task(rq, next);
-			return next;
-		}
-	}
-
-	/* The idle class should always have a runnable task */
-	BUG();
-}
-
-/*
- * Migrate all tasks from the rq, sleeping tasks will be migrated by
- * try_to_wake_up()->select_task_rq().
- *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
- */
-static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
-{
-	struct rq *rq = dead_rq;
-	struct task_struct *next, *stop = rq->stop;
-	struct rq_flags orf = *rf;
-	int dest_cpu;
-
-	/*
-	 * Fudge the rq selection such that the below task selection loop
-	 * doesn't get stuck on the currently eligible stop task.
-	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
-	 * either way we should never end up calling schedule() until we're
-	 * done here.
-	 */
-	rq->stop = NULL;
-
-	/*
-	 * put_prev_task() and pick_next_task() sched
-	 * class method both need to have an up-to-date
-	 * value of rq->clock[_task]
-	 */
 	update_rq_clock(rq);
 
-	for (;;) {
-		/*
-		 * There's this thread running, bail when that's the only
-		 * remaining thread:
-		 */
-		if (rq->nr_running == 1)
-			break;
-
-		next = __pick_migrate_task(rq);
-		WARN_ON_ONCE(__migrate_disabled(next));
-
-		/*
-		 * Rules for changing task_struct::cpus_mask are holding
-		 * both pi_lock and rq->lock, such that holding either
-		 * stabilizes the mask.
-		 *
-		 * Drop rq->lock is not quite as disastrous as it usually is
-		 * because !cpu_active at this point, which means load-balance
-		 * will not interfere. Also, stop-machine.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&next->pi_lock);
-		rq_relock(rq, rf);
-
-		/*
-		 * Since we're inside stop-machine, _nothing_ should have
-		 * changed the task, WARN if weird stuff happened, because in
-		 * that case the above rq->lock drop is a fail too.
-		 */
-		if (WARN_ON(task_rq(next) != rq || !task_on_rq_queued(next))) {
-			raw_spin_unlock(&next->pi_lock);
-			continue;
-		}
-
-		/* Find suitable destination for @next, with force if needed. */
-		dest_cpu = select_fallback_rq(dead_rq->cpu, next);
-		rq = __migrate_task(rq, rf, next, dest_cpu);
-		if (rq != dead_rq) {
-			rq_unlock(rq, rf);
-			rq = dead_rq;
-			*rf = orf;
-			rq_relock(rq, rf);
-		}
-		raw_spin_unlock(&next->pi_lock);
+	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq = __migrate_task(rq, &rf, p, cpu);
 	}
 
-	rq->stop = stop;
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
 }
+
+static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
+
+/*
+ * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ */
+static bool balance_push(struct rq *rq)
+{
+	struct task_struct *push_task = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
+	/*
+	 * Both the cpu-hotplug and stop task are in this case and are
+	 * required to complete the hotplug process.
+	 */
+	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+		/*
+		 * If this is the idle task on the outgoing CPU try to wake
+		 * up the hotplug control thread which might wait for the
+		 * last task to vanish. The rcuwait_active() check is
+		 * accurate here because the waiter is pinned on this CPU
+		 * and can't obviously be running in parallel.
+		 *
+		 * On RT kernels this also has to check whether there are
+		 * pinned and scheduled out tasks on the runqueue. They
+		 * need to leave the migrate disabled section first.
+		 */
+		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
+		    rcuwait_active(&rq->hotplug_wait)) {
+			raw_spin_unlock(&rq->lock);
+			rcuwait_wake_up(&rq->hotplug_wait);
+			raw_spin_lock(&rq->lock);
+		}
+		return false;
+	}
+
+	get_task_struct(push_task);
+	/*
+	 * Temporarily drop rq->lock such that we can wake-up the stop task.
+	 * Both preemption and IRQs are still disabled.
+	 */
+	raw_spin_unlock(&rq->lock);
+	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
+			    this_cpu_ptr(&push_work));
+	/*
+	 * At this point need_resched() is true and we'll take the loop in
+	 * schedule(). The next pick is obviously going to be the stop task
+	 * which is_per_cpu_kthread() and will push this task away.
+	 */
+	raw_spin_lock(&rq->lock);
+
+	return true;
+}
+
+static void balance_push_set(int cpu, bool on)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (on)
+		rq->balance_flags |= BALANCE_PUSH;
+	else
+		rq->balance_flags &= ~BALANCE_PUSH;
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+/*
+ * Invoked from a CPUs hotplug control thread after the CPU has been marked
+ * inactive. All tasks which are not per CPU kernel threads are either
+ * pushed off this CPU now via balance_push() or placed on a different CPU
+ * during wakeup. Wait until the CPU is quiescent.
+ */
+static void balance_hotplug_wait(void)
+{
+	struct rq *rq = this_rq();
+
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
+			   TASK_UNINTERRUPTIBLE);
+}
+
+#else
+
+static inline bool balance_push(struct rq *rq)
+{
+	return false;
+}
+
+static void balance_push_set(int cpu, bool on)
+{
+}
+
+static inline void balance_hotplug_wait(void)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7061,6 +7411,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -7096,6 +7448,8 @@ int sched_cpu_activate(unsigned int cpu)
 
 int sched_cpu_deactivate(unsigned int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 	int ret;
 
 	set_cpu_active(cpu, false);
@@ -7108,6 +7462,16 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		update_rq_clock(rq);
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -7121,6 +7485,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
@@ -7144,6 +7509,41 @@ int sched_cpu_starting(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * Invoked immediately before the stopper thread is invoked to bring the
+ * CPU down completely. At this point all per CPU kthreads except the
+ * hotplug thread (current) and the stopper thread (inactive) have been
+ * either parked or have been unbound from the outgoing CPU. Ensure that
+ * any of those which might be on the way out are gone.
+ *
+ * If after this point a bound task is being woken on this CPU then the
+ * responsible hotplug callback has failed to do it's job.
+ * sched_cpu_dying() will catch it with the appropriate fireworks.
+ */
+int sched_cpu_wait_empty(unsigned int cpu)
+{
+	balance_hotplug_wait();
+	return 0;
+}
+
+/*
+ * Since this CPU is going 'away' for a while, fold any nr_active delta we
+ * might have. Called from the CPU stopper task after ensuring that the
+ * stopper is the last running task on the CPU, so nr_active count is
+ * stable. We need to take the teardown thread which is calling this into
+ * account, so we hand in adjust = 1 to the load calculation.
+ *
+ * Also see the comment "Global load-average calculations".
+ */
+static void calc_load_migrate(struct rq *rq)
+{
+	long delta = calc_load_fold_active(rq, 1);
+
+	if (delta)
+		atomic_long_add(delta, &calc_load_tasks);
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7153,12 +7553,7 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	migrate_tasks(rq, &rf);
-	BUG_ON(rq->nr_running != 1);
+	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -7365,6 +7760,9 @@ void __init sched_init(void)
 
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
+#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
@@ -8656,172 +9054,3 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-
-static inline void
-update_nr_migratory(struct task_struct *p, long delta)
-{
-	if (unlikely((p->sched_class == &rt_sched_class ||
-		      p->sched_class == &dl_sched_class) &&
-		      p->nr_cpus_allowed > 1)) {
-		if (p->sched_class == &rt_sched_class)
-			task_rq(p)->rt.rt_nr_migratory += delta;
-		else
-			task_rq(p)->dl.dl_nr_migratory += delta;
-	}
-}
-
-static inline void
-migrate_disable_update_cpus_allowed(struct task_struct *p)
-{
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-	update_nr_migratory(p, -1);
-	p->nr_cpus_allowed = 1;
-}
-
-static inline void
-migrate_enable_update_cpus_allowed(struct task_struct *p)
-{
-	struct rq *rq;
-	struct rq_flags rf;
-
-	rq = task_rq_lock(p, &rf);
-	p->cpus_ptr = &p->cpus_mask;
-	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
-	update_nr_migratory(p, 1);
-	task_rq_unlock(rq, p, &rf);
-}
-
-void migrate_disable(void)
-{
-	preempt_disable();
-
-	if (++current->migrate_disable == 1) {
-		this_rq()->nr_pinned++;
-		preempt_lazy_disable();
-#ifdef CONFIG_SCHED_DEBUG
-		WARN_ON_ONCE(current->pinned_on_cpu >= 0);
-		current->pinned_on_cpu = smp_processor_id();
-#endif
-	}
-
-	preempt_enable();
-}
-EXPORT_SYMBOL(migrate_disable);
-
-static void migrate_disabled_sched(struct task_struct *p)
-{
-	if (p->migrate_disable_scheduled)
-		return;
-
-	migrate_disable_update_cpus_allowed(p);
-	p->migrate_disable_scheduled = 1;
-}
-
-static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
-static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
-
-void migrate_enable(void)
-{
-	struct task_struct *p = current;
-	struct rq *rq = this_rq();
-	int cpu = task_cpu(p);
-
-	WARN_ON_ONCE(p->migrate_disable <= 0);
-	if (p->migrate_disable > 1) {
-		p->migrate_disable--;
-		return;
-	}
-
-	preempt_disable();
-
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(current->pinned_on_cpu != cpu);
-	current->pinned_on_cpu = -1;
-#endif
-
-	WARN_ON_ONCE(rq->nr_pinned < 1);
-
-	p->migrate_disable = 0;
-	rq->nr_pinned--;
-#ifdef CONFIG_HOTPLUG_CPU
-	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
-	    takedown_cpu_task)
-		wake_up_process(takedown_cpu_task);
-#endif
-
-	if (!p->migrate_disable_scheduled)
-		goto out;
-
-	p->migrate_disable_scheduled = 0;
-
-	migrate_enable_update_cpus_allowed(p);
-
-	WARN_ON(smp_processor_id() != cpu);
-	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg __percpu *arg;
-		struct cpu_stop_work __percpu *work;
-		struct rq_flags rf;
-
-		work = this_cpu_ptr(&migrate_work);
-		arg = this_cpu_ptr(&migrate_arg);
-		WARN_ON_ONCE(!arg->done && !work->disabled && work->arg);
-
-		arg->task = p;
-		arg->done = false;
-
-		rq = task_rq_lock(p, &rf);
-		update_rq_clock(rq);
-		arg->dest_cpu = select_fallback_rq(cpu, p);
-		task_rq_unlock(rq, p, &rf);
-
-		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
-				    arg, work);
-	}
-
-out:
-	preempt_lazy_enable();
-	preempt_enable();
-}
-EXPORT_SYMBOL(migrate_enable);
-
-int cpu_nr_pinned(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	return rq->nr_pinned;
-}
-
-#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-static void migrate_disabled_sched(struct task_struct *p)
-{
-}
-
-void migrate_disable(void)
-{
-#ifdef CONFIG_SCHED_DEBUG
-	current->migrate_disable++;
-#endif
-	barrier();
-}
-EXPORT_SYMBOL(migrate_disable);
-
-void migrate_enable(void)
-{
-#ifdef CONFIG_SCHED_DEBUG
-	struct task_struct *p = current;
-
-	WARN_ON_ONCE(p->migrate_disable <= 0);
-	p->migrate_disable--;
-#endif
-	barrier();
-}
-EXPORT_SYMBOL(migrate_enable);
-
-#else
-static void migrate_disabled_sched(struct task_struct *p)
-{
-}
-
-#endif
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8cb06c8c7eb11..ceb03d76c0ccd 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -120,7 +120,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
+	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
@@ -151,7 +151,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
+		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 0033731a07976..11c4df2010de5 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -73,11 +73,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d0..15320ede2f456 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -543,7 +543,7 @@ static int push_dl_task(struct rq *rq);
 
 static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 {
-	return dl_task(prev);
+	return rq->online && dl_task(prev);
 }
 
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
@@ -1888,7 +1888,7 @@ static void task_fork_dl(struct task_struct *p)
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
 }
@@ -2001,7 +2001,7 @@ static int find_later_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
@@ -2038,7 +2038,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
@@ -2182,7 +2182,7 @@ static void push_dl_tasks(struct rq *rq)
 static void pull_dl_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	bool resched = false;
 	struct rq *src_rq;
 	u64 dmin = LONG_MAX;
@@ -2212,6 +2212,7 @@ static void pull_dl_task(struct rq *this_rq)
 			continue;
 
 		/* Might drop this_rq->lock */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2243,17 +2244,28 @@ static void pull_dl_task(struct rq *this_rq)
 					   src_rq->curr->dl.deadline))
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
-			dmin = p->dl.deadline;
+			if (is_migration_disabled(p)) {
+				trace_sched_migrate_pull_tp(p);
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				dmin = p->dl.deadline;
+				resched = true;
+			}
 
 			/* Is there any other task even earlier? */
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2277,7 +2289,8 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
+				const struct cpumask *new_mask,
+				u32 flags)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2306,7 +2319,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask);
+	set_cpus_allowed_common(p, new_mask, flags);
 }
 
 /* Assumes rq->lock is held */
@@ -2323,9 +2336,6 @@ static void rq_online_dl(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_dl(struct rq *rq)
 {
-	if (rq->dl.overloaded)
-		dl_clear_overload(rq);
-
 	cpudl_clear(&rq->rd->cpudl, rq->cpu);
 	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
 }
@@ -2499,6 +2509,7 @@ const struct sched_class dl_sched_class
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+	.find_lock_rq		= find_lock_later_rq,
 #endif
 
 	.task_tick		= task_tick_dl,
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 31dc08cd5b46a..36c54265bb2b0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -958,10 +958,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-	P(migrate_disable);
-#endif
-	P(nr_cpus_allowed);
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a9661..e90a69b3e85c0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -265,7 +265,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return rq->online && rq->rt.highest_prio.curr > prev->prio;
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -1658,7 +1658,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
 	return 0;
@@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
@@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(lowest_mask);
+	cpu = cpumask_any_distribute(lowest_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
@@ -1811,7 +1811,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
@@ -1859,7 +1859,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
  * running task can migrate over to a CPU that is running a task
  * of lesser priority.
  */
-static int push_rt_task(struct rq *rq)
+static int push_rt_task(struct rq *rq, bool pull)
 {
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
@@ -1873,6 +1873,39 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task)) {
+		struct task_struct *push_task = NULL;
+		int cpu;
+
+		if (!pull)
+			return 0;
+
+		trace_sched_migrate_pull_tp(next_task);
+
+		if (rq->push_busy)
+			return 0;
+
+		cpu = find_lowest_rq(rq->curr);
+		if (cpu == -1 || cpu == rq->cpu)
+			return 0;
+
+		/*
+		 * Given we found a CPU with lower priority than @next_task,
+		 * therefore it should be running. However we cannot migrate it
+		 * to this other CPU, instead attempt to push the current
+		 * running task on this CPU away.
+		 */
+		push_task = get_push_task(rq);
+		if (push_task) {
+			raw_spin_unlock(&rq->lock);
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    push_task, &rq->push_work);
+			raw_spin_lock(&rq->lock);
+		}
+
+		return 0;
+	}
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -1927,12 +1960,10 @@ static int push_rt_task(struct rq *rq)
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
+	resched_curr(lowest_rq);
 	ret = 1;
 
-	resched_curr(lowest_rq);
-
 	double_unlock_balance(rq, lowest_rq);
-
 out:
 	put_task_struct(next_task);
 
@@ -1942,7 +1973,7 @@ static int push_rt_task(struct rq *rq)
 static void push_rt_tasks(struct rq *rq)
 {
 	/* push_rt_task will return true if it moved an RT */
-	while (push_rt_task(rq))
+	while (push_rt_task(rq, false))
 		;
 }
 
@@ -2095,7 +2126,8 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 */
 	if (has_pushable_tasks(rq)) {
 		raw_spin_lock(&rq->lock);
-		push_rt_tasks(rq);
+		while (push_rt_task(rq, true))
+			;
 		raw_spin_unlock(&rq->lock);
 	}
 
@@ -2120,7 +2152,7 @@ static void pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);
 
@@ -2167,6 +2199,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * double_lock_balance, and another CPU could
 		 * alter this_rq
 		 */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2194,11 +2227,15 @@ static void pull_rt_task(struct rq *this_rq)
 			if (p->prio < src_rq->curr->prio)
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
+			if (is_migration_disabled(p)) {
+				trace_sched_migrate_pull_tp(p);
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				resched = true;
+			}
 			/*
 			 * We continue with the search, just in
 			 * case there's an even higher prio task
@@ -2208,6 +2245,13 @@ static void pull_rt_task(struct rq *this_rq)
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2245,9 +2289,6 @@ static void rq_online_rt(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_rt(struct rq *rq)
 {
-	if (rq->rt.overloaded)
-		rt_clear_overload(rq);
-
 	__disable_runtime(rq);
 
 	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
@@ -2449,6 +2490,7 @@ const struct sched_class rt_sched_class
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
+	.find_lock_rq		= find_lock_lowest_rq,
 #endif
 
 	.task_tick		= task_tick_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 21875239f06d7..19847e4ae1323 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -973,6 +973,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1003,6 +1004,10 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	struct rcuwait		hotplug_wait;
+#endif
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -1050,8 +1055,10 @@ struct rq {
 #endif
 
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
-	int			nr_pinned;
+	unsigned int		nr_pinned;
 #endif
+	unsigned int		push_busy;
+	struct cpu_stop_work	push_work;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1079,6 +1086,16 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#define MDF_PUSH	0x01
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	return p->migration_disabled;
+#else
+	return false;
+#endif
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1225,6 +1242,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 #endif
+#ifdef CONFIG_SMP
+	SCHED_WARN_ON(rq->balance_callback);
+#endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
@@ -1386,6 +1406,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1393,12 +1416,13 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next))
+	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
@@ -1800,10 +1824,13 @@ struct sched_class {
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
 	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask);
+				 const struct cpumask *newmask,
+				 u32 flags);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
+
+	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
@@ -1887,13 +1914,35 @@ static inline bool sched_fair_runnable(struct rq *rq)
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
+#define SCA_CHECK		0x01
+#define SCA_MIGRATE_DISABLE	0x02
+#define SCA_MIGRATE_ENABLE	0x04
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
+extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static inline struct task_struct *get_push_task(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+
+	if (rq->push_busy)
+		return NULL;
+
+	if (p->nr_cpus_allowed == 1)
+		return NULL;
+
+	rq->push_busy = true;
+	return get_task_struct(p);
+}
+
+extern int push_cpu_stop(void *arg);
 
 #endif
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 933816b2fb8f8..fb05a9293d007 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -42,11 +42,23 @@ struct cpu_stopper {
 	struct list_head	works;		/* list of pending works */
 
 	struct cpu_stop_work	stop_work;	/* for stop_cpus */
+	unsigned long		caller;
+	cpu_stop_fn_t		fn;
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
 static bool stop_machine_initialized = false;
 
+void print_stop_info(const char *log_lvl, struct task_struct *task)
+{
+	struct cpu_stopper *stopper = this_cpu_ptr(&cpu_stopper);
+
+	if (task != stopper->thread)
+		return;
+
+	printk("%sStopper: %pS <- %pS\n", log_lvl, stopper->fn, (void *)stopper->caller);
+}
+
 /* static data for stop_cpus */
 static DEFINE_MUTEX(stop_cpus_mutex);
 static bool stop_cpus_in_progress;
@@ -86,11 +98,8 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work, &wakeq);
-	else {
-		work->disabled = true;
-		if (work->done)
-			cpu_stop_signal_done(work->done);
-	}
+	else if (work->done)
+		cpu_stop_signal_done(work->done);
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
@@ -126,7 +135,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
-	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done };
+	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
 
 	cpu_stop_init_done(&done, 1);
 	if (!cpu_stop_queue_work(cpu, &work))
@@ -334,7 +343,8 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 	work1 = work2 = (struct cpu_stop_work){
 		.fn = multi_cpu_stop,
 		.arg = &msdata,
-		.done = &done
+		.done = &done,
+		.caller = _RET_IP_,
 	};
 
 	cpu_stop_init_done(&done, 2);
@@ -370,7 +380,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			struct cpu_stop_work *work_buf)
 {
-	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, };
+	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
 	return cpu_stop_queue_work(cpu, work_buf);
 }
 
@@ -490,6 +500,8 @@ static void cpu_stopper_thread(unsigned int cpu)
 		int ret;
 
 		/* cpu stop callbacks must not sleep, make in_atomic() == T */
+		stopper->caller = work->caller;
+		stopper->fn = fn;
 		preempt_count_inc();
 		ret = fn(arg);
 		if (done) {
@@ -498,6 +510,8 @@ static void cpu_stopper_thread(unsigned int cpu)
 			cpu_stop_signal_done(done);
 		}
 		preempt_count_dec();
+		stopper->fn = NULL;
+		stopper->caller = 0;
 		WARN_ONCE(preempt_count(),
 			  "cpu_stop: %ps(%p) leaked preempt count\n", fn, arg);
 		goto repeat;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b6f62f07a8b39..aa7f3bef6d4fa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2460,7 +2460,7 @@ tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 		(need_resched_lazy() ? TRACE_FLAG_NEED_RESCHED_LAZY : 0) |
 		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
 
-	entry->migrate_disable = (tsk) ? __migrate_disabled(tsk) & 0xFF : 0;
+	entry->migrate_disable = (tsk) ? tsk->migration_disabled & 0xFF : 0;
 }
 EXPORT_SYMBOL_GPL(tracing_generic_entry_update);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a3..bb8a84dbabb9d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4905,6 +4905,10 @@ static void unbind_workers(int cpu)
 		pool->flags |= POOL_DISASSOCIATED;
 
 		raw_spin_unlock_irq(&pool->lock);
+
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+
 		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 85da6ab4fbb5a..35924025097b9 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
+
+int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_distribute);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index a00ee6eedc7c3..f5a33b6f773f7 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/kexec.h>
 #include <linux/utsname.h>
+#include <linux/stop_machine.h>
 
 static char dump_stack_arch_desc_str[128];
 
@@ -57,6 +58,7 @@ void dump_stack_print_info(const char *log_lvl)
 		       log_lvl, dump_stack_arch_desc_str);
 
 	print_worker_info(log_lvl, current);
+	print_stop_info(log_lvl, current);
 }
 
 /**
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index f2a93988cd9dd..faaa927ac2c8b 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,14 +23,14 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-#if defined(CONFIG_PREEMPT_RT) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
-	if (current->migrate_disable)
-		goto out;
-#endif
-
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	if (current->migration_disabled)
+		goto out;
+#endif
+
 	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
