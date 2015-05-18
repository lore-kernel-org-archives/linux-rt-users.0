From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.13-rt10
Date: Mon, 18 May 2015 23:11:30 +0200
Message-ID: <20150518211130.GB4275@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v3.18.13-rt10 patch set.

Changes since v3.18.13-rt9

- The dead lock fix for ftrace fixed by Jan Kiszka in -rt9 has now an
  updated patch by Mike Galbraith.

Known issues:

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 3.18.13-rt9 is appended below and can be found here: 

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.13-rt9-rt10.patch.xz

The RT patch against 3.18.13 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.13-rt10.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.13-rt10.tar.xz

Sebastian

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 171dfacb61d4..9678fd1382a7 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -23,9 +23,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
-#ifdef CONFIG_PREEMPT_RT_FULL
-static DEFINE_PER_CPU(struct llist_head, hirq_work_list);
-#endif
+
 /*
  * Claim the entry so that no one else will poke at it.
  */
@@ -68,7 +66,7 @@ void __weak arch_irq_work_raise(void)
  */
 bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
-	bool raise_irqwork;
+	struct llist_head *list;
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -80,16 +78,12 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ)
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(hirq_work_list, cpu));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		list = &per_cpu(lazy_list, cpu);
 	else
-#endif
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(raised_list, cpu));
+		list = &per_cpu(raised_list, cpu);
 
-	if (raise_irqwork)
+	if (llist_add(&work->llnode, list))
 		arch_send_call_function_single_ipi(cpu);
 
 	return true;
@@ -100,6 +94,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
@@ -107,22 +104,15 @@ bool irq_work_queue(struct irq_work *work)
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
-			arch_irq_work_raise();
-	} else
-#endif
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-#ifdef CONFIG_PREEMPT_RT_FULL
-			raise_softirq(TIMER_SOFTIRQ);
-#else
-			arch_irq_work_raise();
-#endif
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+	lazy_work = work->flags & IRQ_WORK_LAZY;
+
+	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+		list = this_cpu_ptr(&lazy_list);
+	else
+		list = this_cpu_ptr(&raised_list);
+
+	if (llist_add(&work->llnode, list)) {
+		if (!lazy_work || tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	}
 
@@ -139,12 +129,8 @@ bool irq_work_needs_cpu(void)
 	raised = this_cpu_ptr(&raised_list);
 	lazy = this_cpu_ptr(&lazy_list);
 
-	if (llist_empty(raised))
-		if (llist_empty(lazy))
-#ifdef CONFIG_PREEMPT_RT_FULL
-			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
-#endif
-				return false;
+	if (llist_empty(raised) && llist_empty(lazy))
+		return false;
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
@@ -158,9 +144,7 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work;
 	struct llist_node *llnode;
 
-#ifndef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled());
 
 	if (llist_empty(list))
 		return;
@@ -196,19 +180,17 @@ static void irq_work_run_list(struct llist_head *list)
  */
 void irq_work_run(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-	/*
-	 * NOTE: we raise softirq via IPI for safety (caller may hold locks
-	 * that raise_softirq needs) and execute in irq_work_tick() to move
-	 * the overhead from hard to soft irq context.
-	 */
-	if (!llist_empty(this_cpu_ptr(&raised_list)))
-		raise_softirq(TIMER_SOFTIRQ);
-#else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-#endif
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+		/*
+		 * NOTE: we raise softirq via IPI for safety,
+		 * and execute in irq_work_tick() to move the
+		 * overhead from hard to soft irq context.
+		 */
+		if (!llist_empty(this_cpu_ptr(&lazy_list)))
+			raise_softirq(TIMER_SOFTIRQ);
+	} else
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
@@ -216,8 +198,7 @@ void irq_work_tick(void)
 {
 	struct llist_head *raised = this_cpu_ptr(&raised_list);
 
-	if (!llist_empty(raised) && (!arch_irq_work_has_interrupt() ||
-				     IS_ENABLED(CONFIG_PREEMPT_RT_FULL)))
+	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a4..d79dde624aaa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
