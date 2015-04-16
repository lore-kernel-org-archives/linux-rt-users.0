From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 16 Apr 2015 18:28:16 +0200
Message-ID: <552FE320.6050601@siemens.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>	<552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home> <552FD55F.8000105@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:51533 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbbDPQ2X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 12:28:23 -0400
In-Reply-To: <552FD55F.8000105@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Instead of turning all irq_work requests into lazy ones on -rt, just
move their execution from hard into soft-irq context.

This resolves deadlocks of ftrace which will queue work from arbitrary
contexts, including those that have locks held that are needed for
raising a soft-irq.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Second try, looks much better so far. And it also removes my concerns
regarding other potential cases besides ftrace.

 kernel/irq_work.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9dda38a..3f6ffcd 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -85,12 +85,9 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		raise_irqwork = llist_add(&work->llnode,
 					  &per_cpu(hirq_work_list, cpu));
 	else
-		raise_irqwork = llist_add(&work->llnode,
-					  &per_cpu(lazy_list, cpu));
-#else
+#endif
 		raise_irqwork = llist_add(&work->llnode,
 					  &per_cpu(raised_list, cpu));
-#endif
 
 	if (raise_irqwork)
 		arch_send_call_function_single_ipi(cpu);
@@ -114,21 +111,20 @@ bool irq_work_queue(struct irq_work *work)
 	if (work->flags & IRQ_WORK_HARD_IRQ) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
 			arch_irq_work_raise();
-	} else {
+	} else
+#endif
+	if (work->flags & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
+#ifdef CONFIG_PREEMPT_RT_FULL
 			raise_softirq(TIMER_SOFTIRQ);
-	}
 #else
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
+#endif
 	} else {
 		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
-#endif
 
 	preempt_enable();
 
@@ -202,6 +198,8 @@ void irq_work_run(void)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
 	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
+	if (!llist_empty(this_cpu_ptr(&raised_list)))
+		raise_softirq(TIMER_SOFTIRQ);
 #else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
@@ -211,15 +209,11 @@ EXPORT_SYMBOL_GPL(irq_work_run);
 
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
-- 
2.1.4
