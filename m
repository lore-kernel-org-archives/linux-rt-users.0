From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/10] dump stack: dont disable preemption during trace
Date: Fri, 26 Feb 2016 16:35:56 -0500
Message-ID: <20160226213709.017707527@goodmis.org>
References: <20160226213551.557375746@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48920 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933921AbcBZVhM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 16:37:12 -0500
Content-Disposition: inline; filename=0005-dump-stack-don-t-disable-preemption-during-trace.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.61-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I see here large latencies during a stack dump on x86. The
preempt_disable() and get_cpu() should forbid moving the task to another
CPU during a stack dump and avoiding two stack traces in parallel on the
same CPU. However a stack trace from a second CPU may still happen in
parallel. Also nesting is allowed so a stack trace happens in
process-context and we may have another one from IRQ context. With migrate
disable we keep this code preemptible and allow a second backtrace on
the same CPU by another task.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/dumpstack_64.c | 8 ++++----
 lib/dump_stack.c               | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 66e274a3d968..37aee503a7ba 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -114,7 +114,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	unsigned long *irq_stack_end =
 		(unsigned long *)per_cpu(irq_stack_ptr, cpu);
 	unsigned used = 0;
@@ -191,7 +191,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	 * This handles the process stack:
 	 */
 	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
@@ -205,7 +205,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int cpu;
 	int i;
 
-	preempt_disable();
+	migrate_disable();
 	cpu = smp_processor_id();
 
 	irq_stack_end	= (unsigned long *)(per_cpu(irq_stack_ptr, cpu));
@@ -238,7 +238,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		pr_cont(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	pr_cont("\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f23b63f0a1c3..b39c60b1f12c 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -33,7 +33,7 @@ asmlinkage void dump_stack(void)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	preempt_disable();
+	migrate_disable();
 
 retry:
 	cpu = smp_processor_id();
@@ -52,7 +52,7 @@ retry:
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	preempt_enable();
+	migrate_enable();
 }
 #else
 asmlinkage void dump_stack(void)
-- 
2.7.0


