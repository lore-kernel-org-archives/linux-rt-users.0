From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Sat, 25 Apr 2015 09:20:48 +0200
Message-ID: <1429946448.3179.33.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com> <552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>
	 <55389632.50308@siemens.com> <1429772482.3419.40.camel@gmail.com>
	 <55389B67.3000703@siemens.com> <1429773566.3419.42.camel@gmail.com>
	 <20150423170026.0de65c90@gandalf.local.home>
	 <1429858489.3461.28.camel@gmail.com> <553A062D.6090608@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553A062D.6090608@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2015-04-24 at 11:00 +0200, Jan Kiszka wrote:

> The approach looks good to me, but the commit log deserves a rework now.

Ok, we agree on the approach, and that the changelog wants a bit of
attention, so either you're gonna rewrite it to suit you, do a pretty
changelog, and I ack, or I take the blame for the posted form, scribble
something that I hope is a better log, and you ack.  Either will work.

Here's my changelog+blame-taking, if you're ok with it, ack, and we can
call it a day, otherwise onward to plan B.



irq_work: Delegate non-immediate irq work to ksoftirqd

Based on a patch from Jan Kiszka.

Jan reported that ftrace queueing work from arbitrary contexts can
and does lead to deadlock.  trace-cmd -e sched:* deadlocked in fact.

Resolve the problem by delegating all non-immediate work to ksoftirqd.

We need two lists to do this, one for hard irq, one for soft, so we
can use the two existing lists, eliminating the -rt specific list and
all of the ifdefery while we're at it.  

Strategy: Queue work tagged for hirq invocation to the raised_list,
invoke via IPI as usual.  If a work item being queued to lazy_list,
which becomes our all others list, is not a lazy work item, or the
tick is stopped, fire an IPI to raise SOFTIRQ_TIMER immediately,
otherwise let ksofirqd find it when the tick comes along.  Raising
SOFTIRQ_TIMER via IPI even when queueing local ensures delegation.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

---
 kernel/irq_work.c |   85 ++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

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
@@ -80,19 +78,12 @@ bool irq_work_queue_on(struct irq_work *
 	if (!irq_work_claim(work))
 		return false;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ)
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(hirq_work_list, cpu));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		list = &per_cpu(lazy_list, cpu);
 	else
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(lazy_list, cpu));
-#else
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(raised_list, cpu));
-#endif
+		list = &per_cpu(raised_list, cpu);
 
-	if (raise_irqwork)
+	if (llist_add(&work->llnode, list))
 		arch_send_call_function_single_ipi(cpu);
 
 	return true;
@@ -103,6 +94,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
@@ -110,25 +104,17 @@ bool irq_work_queue(struct irq_work *wor
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			raise_softirq(TIMER_SOFTIRQ);
-	}
-#else
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
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
-#endif
 
 	preempt_enable();
 
@@ -143,12 +129,8 @@ bool irq_work_needs_cpu(void)
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
@@ -162,9 +144,7 @@ static void irq_work_run_list(struct lli
 	struct irq_work *work;
 	struct llist_node *llnode;
 
-#ifndef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled());
 
 	if (llist_empty(list))
 		return;
@@ -200,26 +180,27 @@ static void irq_work_run_list(struct lli
  */
 void irq_work_run(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
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
 
 void irq_work_tick(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-#else
-	struct llist_head *raised = &__get_cpu_var(raised_list);
+	struct llist_head *raised = this_cpu_ptr(&raised_list);
 
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
-	irq_work_run_list(&__get_cpu_var(lazy_list));
-#endif
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
 /*
