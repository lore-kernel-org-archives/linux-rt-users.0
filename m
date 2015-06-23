From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT][3.14-rt] irq_work: Split raised and lazy lists
Date: Tue, 23 Jun 2015 11:19:16 -0400
Message-ID: <20150623111916.11890056@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I cherry-picked this from mainline and modified it with some of the
code in 4.0-rt to get it to work. As I'm considering this as more of a
stable pull and not as much of a specific -rt pull, I'm going to
include this patch with my next stable-rt release without doing the
formal -rc. But I still have a bunch of testing to do, as well as the
other stable releases before I do a release; I figured I would post
this change to let people review it and find anything I might have
missed.

Thanks!

-- Steve


>From f71cfae06bdab40fb49199699e282b80ab070ea9 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 23 May 2014 18:10:21 +0200
Subject: [PATCH] irq_work: Split raised and lazy lists

An irq work can be handled from two places: from the tick if the work
carries the "lazy" flag and the tick is periodic, or from a self IPI.

We merge all these works in a single list and we use some per cpu latch
to avoid raising a self-IPI when one is already pending.

Now we could do away with this ugly latch if only the list was only made of
non-lazy works. Just enqueueing a work on the empty list would be enough
to know if we need to raise an IPI or not.

Also we are going to implement remote irq work queuing. Then the per CPU
latch will need to become atomic in the global scope. That's too bad
because, here as well, just enqueueing a work on an empty list of
non-lazy works would be enough to know if we need to raise an IPI or not.

So lets take a way out of this: split the works in two distinct lists,
one for the works that can be handled by the next tick and another
one for those handled by the IPI. Just checking if the latter is empty
when we queue a new work is enough to know if we need to raise an IPI.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

Conflicts:
	kernel/irq_work.c

Merged in some changes from 4.0-rt that added the irq_work_tick()
code, and also has the raised_list called from hardirq context and
the lazy_list always from softirq context (which is threaded on RT)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/irq_work.h |  1 +
 kernel/irq_work.c        | 83 ++++++++++++++++++++++--------------------------
 kernel/timer.c           |  2 +-
 3 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 60c19eeca9e0..1582908ac4a0 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -33,6 +33,7 @@ void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 
 void irq_work_queue(struct irq_work *work);
 void irq_work_run(void);
+void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
 
 #ifdef CONFIG_IRQ_WORK
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 5f7d93d89c7f..af8ceafc94e4 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,11 +20,8 @@
 #include <asm/processor.h>
 
 
-static DEFINE_PER_CPU(struct llist_head, irq_work_list);
-#ifdef CONFIG_PREEMPT_RT_FULL
-static DEFINE_PER_CPU(struct llist_head, hirq_work_list);
-#endif
-static DEFINE_PER_CPU(int, irq_work_raised);
+static DEFINE_PER_CPU(struct llist_head, raised_list);
+static DEFINE_PER_CPU(struct llist_head, lazy_list);
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -67,6 +64,9 @@ void __weak arch_irq_work_raise(void)
  */
 void irq_work_queue(struct irq_work *work)
 {
+	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+	struct llist_head *list;
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return;
@@ -74,19 +74,16 @@ void irq_work_queue(struct irq_work *work)
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ)
-		llist_add(&work->llnode, &__get_cpu_var(hirq_work_list));
+	/* If the work is "lazy", handle it from next tick if any */
+	lazy_work = work->flags & IRQ_WORK_LAZY;
+
+	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+		list = this_cpu_ptr(&lazy_list);
 	else
-#endif
-		llist_add(&work->llnode, &__get_cpu_var(irq_work_list));
-	/*
-	 * If the work is not "lazy" or the tick is stopped, raise the irq
-	 * work interrupt (if supported by the arch), otherwise, just wait
-	 * for the next tick.
-	 */
-	if (!(work->flags & IRQ_WORK_LAZY) || tick_nohz_tick_stopped()) {
-		if (!this_cpu_cmpxchg(irq_work_raised, 0, 1))
+		list = this_cpu_ptr(&raised_list);
+
+	if (llist_add(&work->llnode, list)) {
+		if (!lazy_work || tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	}
 
@@ -96,10 +93,11 @@ EXPORT_SYMBOL_GPL(irq_work_queue);
 
 bool irq_work_needs_cpu(void)
 {
-	struct llist_head *this_list;
+	struct llist_head *raised, *lazy;
 
-	this_list = &__get_cpu_var(irq_work_list);
-	if (llist_empty(this_list))
+	raised = &__get_cpu_var(raised_list);
+	lazy = &__get_cpu_var(lazy_list);
+	if (llist_empty(raised) && llist_empty(lazy))
 		return false;
 
 	/* All work should have been flushed before going offline */
@@ -108,34 +106,18 @@ bool irq_work_needs_cpu(void)
 	return true;
 }
 
-static void __irq_work_run(void)
+static void irq_work_run_list(struct llist_head *list)
 {
 	unsigned long flags;
 	struct irq_work *work;
-	struct llist_head *this_list;
 	struct llist_node *llnode;
 
+	BUG_ON_NONRT(!irqs_disabled());
 
-	/*
-	 * Reset the "raised" state right before we check the list because
-	 * an NMI may enqueue after we find the list empty from the runner.
-	 */
-	__this_cpu_write(irq_work_raised, 0);
-	barrier();
-
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_irq())
-		this_list = &__get_cpu_var(hirq_work_list);
-	else
-#endif
-		this_list = &__get_cpu_var(irq_work_list);
-	if (llist_empty(this_list))
+	if (llist_empty(list))
 		return;
 
-#ifndef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(!irqs_disabled());
-#endif
-	llnode = llist_del_all(this_list);
+	llnode = llist_del_all(list);
 	while (llnode != NULL) {
 		work = llist_entry(llnode, struct irq_work, llnode);
 
@@ -166,13 +148,24 @@ static void __irq_work_run(void)
  */
 void irq_work_run(void)
 {
-#ifndef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(!in_irq());
-#endif
-	__irq_work_run();
+	irq_work_run_list(this_cpu_ptr(&raised_list));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+		if (!llist_empty(this_cpu_ptr(&lazy_list)))
+			raise_softirq(TIMER_SOFTIRQ);
+	} else
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
+void irq_work_tick(void)
+{
+	struct llist_head *raised = this_cpu_ptr(&raised_list);
+
+	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
+		irq_work_run_list(raised);
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
  * currently in use.
@@ -197,7 +190,7 @@ static int irq_work_cpu_notify(struct notifier_block *self,
 		/* Called from stop_machine */
 		if (WARN_ON_ONCE(cpu != smp_processor_id()))
 			break;
-		__irq_work_run();
+		irq_work_tick();
 		break;
 	default:
 		break;
diff --git a/kernel/timer.c b/kernel/timer.c
index 36b9f10bb3c7..300870358b4f 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1467,7 +1467,7 @@ static void run_timer_softirq(struct softirq_action *h)
 	hrtimer_run_pending();
 
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_run();
+	irq_work_tick();
 #endif
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
-- 
2.1.4
