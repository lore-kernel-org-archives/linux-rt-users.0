From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.1-rt3
Date: Fri, 3 Jun 2016 12:44:24 +0200
Message-ID: <20160603104424.GA18975@linutronix.de>
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

I'm pleased to announce the v4.6.1-rt3 patch set. 

Changes since v4.6.1-rt2:
  - On return from interrupt on ARM we could schedule with lazy preempt
    count > 0 under some circumstances. It isn't toxic but it shouldn't
    happen. Noticed by Thomas Gleixner.

  - The way the preempt counter is accessed on non-x86 architectures
    allowed the compiler to reorder the code slightly. This led to
    decrementing the preempt counter, checking for the need resched bit
    followed by writing the counter back. An interrupt between the last
    two steps will lead to a missing preemption point and thus high
    latencies. Patch by Peter Zijlstra.

  - The recorded preemption counter in event trace points (such as
    raw_syscall_entry) are off by one because each trace point
    increments the counter. This has been corrected.

  - It is now ensured that there are no attempts to print from IRQ or
    NMI context. On certain events such as hard-lockup-detector we would
    attempt to grab sleeping locks.

  - Allow lru_add_drain_all() to perform its work remotely. Patch by
    Luiz Capitulino and Rik van Riel.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.1-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.1-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.1-rt3

The RT patch against 4.6.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.1-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.1-rt3.tar.xz

Sebastian

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 188027584dd1..3125de9e9783 100644
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
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 493e801e0c9b..845c77f1a5ca 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -66,6 +66,9 @@ static inline void __local_lock(struct local_irq_lock *lv)
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_on(lvar, cpu)				\
+	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
@@ -104,6 +107,9 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_on(lvar, cpu)                       \
+	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index be586c632a0c..12cb3bb40c1c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,19 @@ struct trace_enum_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+/*
+ * The preempt count recorded in trace_event_raw_event_# are off by one due to
+ * rcu_read_lock_sched_notrace() in __DO_TRACE. This is corrected here.
+ */
+static inline int event_preempt_count(void)
+{
+#ifdef CONFIG_PREEMPT
+	return preempt_count() - 1;
+#else
+	return 0;
+#endif
+}
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
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
index 723bcab97524..ba5e3381a8cc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1528,6 +1528,11 @@ static void call_console_drivers(int level,
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
@@ -2460,6 +2465,11 @@ void console_unblank(void)
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
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 52c4fffaddcd..90b40cf6ec98 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -245,7 +245,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 		return NULL;
 
 	local_save_flags(fbuffer->flags);
-	fbuffer->pc = preempt_count();
+	fbuffer->pc = event_preempt_count();
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/swap.c b/mm/swap.c
index 892747266c7e..d3558eb2f685 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -596,9 +596,15 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		local_lock_irqsave_on(rotate_lock, flags, cpu);
+		pagevec_move_tail(pvec);
+		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
+#else
 		local_lock_irqsave(rotate_lock, flags);
 		pagevec_move_tail(pvec);
 		local_unlock_irqrestore(rotate_lock, flags);
+#endif
 	}
 
 	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
@@ -666,12 +672,32 @@ void lru_add_drain(void)
 	local_unlock_cpu(swapvec_lock);
 }
 
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_on(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_on(swapvec_lock, cpu);
+}
+
+#else
+
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+	INIT_WORK(work, lru_add_drain_per_cpu);
+	schedule_work_on(cpu, work);
+	cpumask_set_cpu(cpu, has_work);
+}
+#endif
 
 void lru_add_drain_all(void)
 {
@@ -684,21 +710,18 @@ void lru_add_drain_all(void)
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
-		    need_activate_page_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			schedule_work_on(cpu, work);
-			cpumask_set_cpu(cpu, &has_work);
-		}
+		    need_activate_page_drain(cpu))
+			remote_lru_add_drain(cpu, &has_work);
 	}
 
+#ifndef CONFIG_PREEMPT_RT_BASE
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
+#endif
 
 	put_online_cpus();
 	mutex_unlock(&lock);
