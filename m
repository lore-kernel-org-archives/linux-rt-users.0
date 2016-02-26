From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/12] dump stack: dont disable preemption during trace
Date: Fri, 26 Feb 2016 16:32:42 -0500
Message-ID: <20160226213341.100625803@goodmis.org>
References: <20160226213235.253312067@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0007-dump-stack-don-t-disable-preemption-during-trace.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt26-rc1 stable review patch.
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
 arch/x86/kernel/dumpstack_32.c | 4 ++--
 arch/x86/kernel/dumpstack_64.c | 8 ++++----
 lib/dump_stack.c               | 6 ++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 5abd4cd4230c..1282817bb4c3 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -42,7 +42,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	int graph = 0;
 	u32 *prev_esp;
 
@@ -86,7 +86,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			break;
 		touch_nmi_watchdog();
 	}
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index ff86f19b5758..4821f291890f 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -152,7 +152,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	struct thread_info *tinfo;
 	unsigned long *irq_stack = (unsigned long *)per_cpu(irq_stack_ptr, cpu);
 	unsigned long dummy;
@@ -241,7 +241,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	 * This handles the process stack:
 	 */
 	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
@@ -255,7 +255,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int cpu;
 	int i;
 
-	preempt_disable();
+	migrate_disable();
 	cpu = smp_processor_id();
 
 	irq_stack_end	= (unsigned long *)(per_cpu(irq_stack_ptr, cpu));
@@ -288,7 +288,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		pr_cont(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	pr_cont("\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index c30d07e99dba..01ca6dae9414 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -25,7 +25,6 @@ static atomic_t dump_lock = ATOMIC_INIT(-1);
 
 asmlinkage __visible void dump_stack(void)
 {
-	unsigned long flags;
 	int was_locked;
 	int old;
 	int cpu;
@@ -34,8 +33,8 @@ asmlinkage __visible void dump_stack(void)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
+	migrate_disable();
 retry:
-	local_irq_save(flags);
 	cpu = smp_processor_id();
 	old = atomic_cmpxchg(&dump_lock, -1, cpu);
 	if (old == -1) {
@@ -43,7 +42,6 @@ retry:
 	} else if (old == cpu) {
 		was_locked = 1;
 	} else {
-		local_irq_restore(flags);
 		cpu_relax();
 		goto retry;
 	}
@@ -53,7 +51,7 @@ retry:
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	local_irq_restore(flags);
+	migrate_enable();
 }
 #else
 asmlinkage __visible void dump_stack(void)
-- 
2.7.0
