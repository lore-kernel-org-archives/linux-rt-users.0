From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT][RFC] irq_work: Have non HARD_IRQ irq work just run from
 ticks
Date: Mon, 22 Jun 2015 15:09:59 -0400
Message-ID: <20150622150959.44055b32@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:47820 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753770AbbFVTKC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 15:10:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With PREEMPT_RT, the irq work callbacks are called from the softirq
thread, unless the HARD_IRQ flag is set for the irq work. When an irq
work item is added without the HARD_IRQ flag set, and without the LAZY
flag set, an interrupt is raised, and that interrupt will wake up the
softirq thread to run the irq work like it would do without PREEMPT_RT.

The current logic in irq_work_queue() will not raise the interrupt when
the first irq work item added has the LAZY flag set. But if another
irq work item is added without the LAZY flag set, and without the
HARD_IRQ item set, the interrupt is not raised because the interrupt is
only raised when the list was empty before adding the current irq work
item.

This means that if an irq work item is added with the LAZY flag set, it
will not raise the interrupt and that work item will have to wait till
the next timer tick (which in computer terms is a long way away). Now
if in the mean time, another irq work item is added without the LAZY
flag set, and without the HARD_IRQ flag set (meaning it wants to run
from the softirq), the interrupt will still not be raised. This is
because the interrupt is only raised when the first item of the list is
added. Future items added will not raise the interrupt. This makes the
raising of the irq work callback non deterministic. Rather ironic
considering this only happens when PREEMPT_RT is enabled.


I have several ideas on how to fix this.

1) Add another list (softirq_list), and add to it if PREEMPT_RT is
enabled and the flag doesn't have either LAZY or HARD_IRQ flags set.
This is what would be checked in the interrupt irq work callback
instead of the lazy_list.

2) Raise the interrupt whenever a first item is added to a list (lazy
or otherwise) when PREEMPT_RT is enabled, and have the lazy with the
non lazy handled by softirq.

3) Only raise the hard interrupt when something is added to the
raised_list. That is, for PREEMPT_RT, that would only be irq work that
has the HARD_IRQ flag set. All other irq_work will be done when the
tick happens. To keep things deterministic, the irq_work_run() no
longer checks the lazy_list and is the same as the vanilla kernel.


I'm thinking that ideally, #1 is the best choice. #2 has the issue
where something may add itself as lazy, really expecting to be done
from the next timer tick, but then happen from a "sooner" softirq.
Although, I doubt that will really be an issue.

#3 (this patch), is something that I discussed with Sebastian, and he
said that nothing should break if we wait at most 10ms for the next
tick.

My concern here, is that the ipi call function (sending an irq work
from another CPU without the HARD_IRQ flag set), on a NO_HZ cpu, may
not wake it up to run it. Although, I'm not sure there's anything that
uses cross CPU irq work without setting HARD_IRQ. I can add back the
check to wake up the softirq, but then we make the timing of irq_work
non deterministic again. Is that an issue?

But here's the patch presented to you as an RFC. I can write up #1 too
if people think that would be the better solution.

Oh, and then there's #4, which is to do nothing. Just let irq work come
in non deterministic, and that may not hurt anything either.

Not-so-signed-off-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9678fd1382a7..f247388b0fda 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -67,6 +67,7 @@ void __weak arch_irq_work_raise(void)
 bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
 	struct llist_head *list;
+	bool lazy_work;
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -78,12 +79,15 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	lazy_work = IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
+		!(work->flags & IRQ_WORK_HARD_IRQ);
+
+	if (lazy_work)
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
 
-	if (llist_add(&work->llnode, list))
+	if (llist_add(&work->llnode, list) && !lazy_work)
 		arch_send_call_function_single_ipi(cpu);
 
 	return true;
@@ -95,7 +99,7 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 bool irq_work_queue(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+	bool lazy_work;
 
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
@@ -104,17 +108,23 @@ bool irq_work_queue(struct irq_work *work)
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 
-	lazy_work = work->flags & IRQ_WORK_LAZY;
+	lazy_work = work->flags & IRQ_WORK_LAZY ||
+		(IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
+		 !(work->flags & IRQ_WORK_HARD_IRQ));
 
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (lazy_work)
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
 
-	if (llist_add(&work->llnode, list)) {
-		if (!lazy_work || tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	}
+	/*
+	 * If the list was empty prior to adding this item and that
+	 * list was the raised list, or if the tick is stopped,
+	 * then force an interrupt to occur.
+	 */
+	if (llist_add(&work->llnode, list) &&
+	    (!lazy_work || tick_nohz_tick_stopped()))
+		arch_irq_work_raise();
 
 	preempt_enable();
 
@@ -181,16 +191,7 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
-		/*
-		 * NOTE: we raise softirq via IPI for safety,
-		 * and execute in irq_work_tick() to move the
-		 * overhead from hard to soft irq context.
-		 */
-		if (!llist_empty(this_cpu_ptr(&lazy_list)))
-			raise_softirq(TIMER_SOFTIRQ);
-	} else
-		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
