From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 23 Apr 2015 08:11:45 +0200
Message-ID: <1429769505.3419.9.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36501 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbbDWGLt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 02:11:49 -0400
In-Reply-To: <1429517036.3226.9.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2015-04-20 at 10:03 +0200, Mike Galbraith wrote:
> On Thu, 2015-04-16 at 18:28 +0200, Jan Kiszka wrote:
> > Instead of turning all irq_work requests into lazy ones on -rt, 
> > just
> > move their execution from hard into soft-irq context.
> > 
> > This resolves deadlocks of ftrace which will queue work from 
> > arbitrary
> > contexts, including those that have locks held that are needed for
> > raising a soft-irq.
> 
> Yup, trace-cmd record -> dead-box fully repeatable, and now fixed.

Except you kinda forgot to run the raised list.  The reformatted 
(which saved two whole lines;) patch below adds that to 
irq_work_tick(), which fixes the livelock both powertop and perf top 
otherwise meet.

Subject: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date:   Thu, 16 Apr 2015 18:28:16 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>

Instead of turning all irq_work requests into lazy ones on -rt, just
move their execution from hard into soft-irq context.

This resolves deadlocks of ftrace which will queue work from arbitrary
contexts, including those that have locks held that are needed for
raising a soft-irq.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Second try, looks much better so far. And it also removes my concerns
regarding other potential cases besides ftrace.

 kernel/irq_work.c |   84 ++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -80,17 +80,12 @@ bool irq_work_queue_on(struct irq_work *
        if (!irq_work_claim(work))
                return false;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-       if (work->flags & IRQ_WORK_HARD_IRQ)
+       if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && (work->flags & IRQ_WORK_HARD_IRQ))
                raise_irqwork = llist_add(&work->llnode,
                                          &per_cpu(hirq_work_list, cpu));
        else
                raise_irqwork = llist_add(&work->llnode,
-                                         &per_cpu(lazy_list, cpu));
-#else
-               raise_irqwork = llist_add(&work->llnode,
                                          &per_cpu(raised_list, cpu));
-#endif
 
        if (raise_irqwork)
                arch_send_call_function_single_ipi(cpu);
@@ -103,6 +98,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
+       bool realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+       bool raise = false;
+
        /* Only queue if not already pending */
        if (!irq_work_claim(work))
                return false;
@@ -110,25 +108,22 @@ bool irq_work_queue(struct irq_work *wor
        /* Queue the entry and raise the IPI if needed. */
        preempt_disable();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-       if (work->flags & IRQ_WORK_HARD_IRQ) {
+       if (realtime && (work->flags & IRQ_WORK_HARD_IRQ)) {
                if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
-                       arch_irq_work_raise();
-       } else {
-               if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-                   tick_nohz_tick_stopped())
-                       raise_softirq(TIMER_SOFTIRQ);
-       }
-#else
-       if (work->flags & IRQ_WORK_LAZY) {
+                       raise = 1;
+       } else if (work->flags & IRQ_WORK_LAZY) {
                if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-                   tick_nohz_tick_stopped())
-                       arch_irq_work_raise();
-       } else {
-               if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
-                       arch_irq_work_raise();
-       }
-#endif
+                   tick_nohz_tick_stopped()) {
+                       if (realtime)
+                               raise_softirq(TIMER_SOFTIRQ);
+                       else
+                               raise = true;
+               }
+       } else if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+               raise = true;
+
+       if (raise)
+               arch_irq_work_raise();
 
        preempt_enable();
 
@@ -143,12 +138,13 @@ bool irq_work_needs_cpu(void)
        raised = this_cpu_ptr(&raised_list);
        lazy = this_cpu_ptr(&lazy_list);
 
-       if (llist_empty(raised))
-               if (llist_empty(lazy))
-#ifdef CONFIG_PREEMPT_RT_FULL
+       if (llist_empty(raised) && llist_empty(lazy)) {
+               if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
                        if (llist_empty(this_cpu_ptr(&hirq_work_list)))
-#endif
                                return false;
+               } else
+                       return false;
+       }
 
        /* All work should have been flushed before going offline */
        WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
@@ -162,9 +158,7 @@ static void irq_work_run_list(struct lli
        struct irq_work *work;
        struct llist_node *llnode;
 
-#ifndef CONFIG_PREEMPT_RT_FULL
-       BUG_ON(!irqs_disabled());
-#endif
+       BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled());
 
        if (llist_empty(list))
                return;
@@ -200,26 +194,30 @@ static void irq_work_run_list(struct lli
  */
 void irq_work_run(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-       irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-#else
-       irq_work_run_list(this_cpu_ptr(&raised_list));
-       irq_work_run_list(this_cpu_ptr(&lazy_list));
-#endif
+       if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+               irq_work_run_list(this_cpu_ptr(&hirq_work_list));
+               /*
+                * NOTE: we raise softirq via IPI for safety,
+                * and execute in irq_work_tick() to move the
+                * overhead from hard to soft irq context.
+                */
+               if (!llist_empty(this_cpu_ptr(&raised_list)))
+                       raise_softirq(TIMER_SOFTIRQ);
+       } else {
+               irq_work_run_list(this_cpu_ptr(&raised_list));
+               irq_work_run_list(this_cpu_ptr(&lazy_list));
+       }
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
 void irq_work_tick(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-       irq_work_run_list(this_cpu_ptr(&lazy_list));
-#else
-       struct llist_head *raised = &__get_cpu_var(raised_list);
+       struct llist_head *raised = this_cpu_ptr(&raised_list);
 
-       if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
+       if (!llist_empty(raised) && (!arch_irq_work_has_interrupt() ||
+           IS_ENABLED(CONFIG_PREEMPT_RT_FULL)))
                irq_work_run_list(raised);
-       irq_work_run_list(&__get_cpu_var(lazy_list));
-#endif
+       irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
 /*
