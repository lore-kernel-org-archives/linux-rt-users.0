From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.4.12-rt19
Date: Fri, 3 Jun 2016 17:28:14 +0200
Message-ID: <20160603152814.GA4496@linutronix.de>
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

I'm pleased to announce the v4.4.12-rt19 patch set. I'm doing this
release mostly due the preemption check fix on non x86 architectures and
the perf/rapl patch.

Changes since v4.4.12-rt18:
  - On return from interrupt on ARM we could schedule with lazy preempt
    count > 0 under some circumstances. It isn't toxic but it shouldn't
    happen. Noticed by Thomas Gleixner.

  - The way the preempt counter is accessed on non-x86 architectures
    allowed the compiler to reorder the code slightly. This led to
    decrementing the preempt counter, checking for the need resched bit
    followed by writing the counter back. An interrupt between the last
    two steps will lead to a missing preemption point and thus high
    latencies. Patch by Peter Zijlstra.

  - It is now ensured that there are no attempts to print from IRQ or
    NMI context. On certain events such as hard-lockup-detector we would
    attempt to grab sleeping locks.

  - The lock used in the perf/rapl driver is now a raw lock. This change
    is part of v4.6-rc1 and therefore not mentioned in the v4.6 series.
    Carsten Emde asked for this change to become part of v4.4.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.4.12-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.12-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.12-rt19

The RT patch against 4.6.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.12-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.12-rt19.tar.xz

Sebastian

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d66b1aef2083..d044cea59f54 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -244,7 +244,11 @@ ENDPROC(__irq_svc)
 	bne	1b
 	tst	r0, #_TIF_NEED_RESCHED_LAZY
 	reteq	r8				@ go again
-	b	1b
+	ldr	r0, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
+	teq	r0, #0				@ if preempt lazy count != 0
+	beq	1b
+	ret	r8				@ go again
+
 #endif
 
 __und_fault:
diff --git a/arch/x86/kernel/cpu/perf_event_intel_rapl.c b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
index ed446bdcbf31..d2ac364e2118 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_rapl.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
@@ -117,7 +117,7 @@ static struct perf_pmu_events_attr event_attr_##v = {			\
 };
 
 struct rapl_pmu {
-	spinlock_t	 lock;
+	raw_spinlock_t	 lock;
 	int		 n_active; /* number of active events */
 	struct list_head active_list;
 	struct pmu	 *pmu; /* pointer to rapl_pmu_class */
@@ -220,13 +220,13 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 	if (!pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	list_for_each_entry(event, &pmu->active_list, active_entry) {
 		rapl_event_update(event);
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	hrtimer_forward_now(hrtimer, pmu->timer_interval);
 
@@ -263,9 +263,9 @@ static void rapl_pmu_event_start(struct perf_event *event, int mode)
 	struct rapl_pmu *pmu = __this_cpu_read(rapl_pmu);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 	__rapl_pmu_event_start(pmu, event);
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
@@ -274,7 +274,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
@@ -299,7 +299,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
@@ -308,14 +308,14 @@ static int rapl_pmu_event_add(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
 		__rapl_pmu_event_start(pmu, event);
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	return 0;
 }
@@ -603,7 +603,7 @@ static int rapl_cpu_prepare(int cpu)
 	pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
 	if (!pmu)
 		return -1;
-	spin_lock_init(&pmu->lock);
+	raw_spin_lock_init(&pmu->lock);
 
 	INIT_LIST_HEAD(&pmu->active_list);
 
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 5d8ffa3e6f8c..c1cde3577551 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -7,10 +7,10 @@
 
 static __always_inline int preempt_count(void)
 {
-	return current_thread_info()->preempt_count;
+	return READ_ONCE(current_thread_info()->preempt_count);
 }
 
-static __always_inline int *preempt_count_ptr(void)
+static __always_inline volatile int *preempt_count_ptr(void)
 {
 	return &current_thread_info()->preempt_count;
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 66971005cc12..fde5e54f1096 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2059,7 +2059,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (WARN_ON(in_irq() || in_nmi()))
+	if (WARN_ON_ONCE(in_irq() || in_nmi()))
 #else
 	if (WARN_ON(in_irq() || in_nmi() || in_serving_softirq()))
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f75e4b0c60e9..c747bdfa199e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1527,6 +1527,11 @@ static void call_console_drivers(int level,
 	if (!console_drivers)
 		return;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	migrate_disable();
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
@@ -2464,6 +2469,11 @@ void console_unblank(void)
 {
 	struct console *c;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	/*
 	 * console_unblank can no longer be called in interrupt context unless
 	 * oops_in_progress is set to 1..
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44..483ad771f201 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
