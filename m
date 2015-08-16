From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.1.5-rt5
Date: Sun, 16 Aug 2015 15:56:30 +0200
Message-ID: <20150816135630.GE7004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50174 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbHPN4e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Aug 2015 09:56:34 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.1.5-rt5 patch set.
Changes since v4.1.5-rt4:

- don't disable preemption in dump_stack(). We should not see a
  backtrace on a production kernel but then it should not increase the
  latency if trigger one.

Known issues:
 
- bcache is disabled.

- CPU hotplug works in general. Steven's test script however
  deadlocks usually on the second invocation.

- Clark Williams reported an OOPS in netlink_release() which has not
  been narrowed down yet.
 
- Nicholas Mc Guire reported high CPU usage by softirq on an idle system 
  which seems to freeze / halt the system.

The delta patch against 4.1.5-rt4 is appended below and can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.5-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.5-rt5

The RT patch against 4.1.5 can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.5-rt5.patch.xz

The split quilt queue is available at:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.5-rt5.tar.xz

Sebastian

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 464ffd69b92e..00db1aad1548 100644
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
index 5f1c6266eb30..c331e3fef465 100644
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
@@ -291,7 +291,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			pr_cont(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	pr_cont("\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6745c6230db3..7ccbc6ff80ea 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -33,7 +33,7 @@ asmlinkage __visible void dump_stack(void)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	preempt_disable();
+	migrate_disable();
 
 retry:
 	cpu = smp_processor_id();
@@ -52,7 +52,7 @@ asmlinkage __visible void dump_stack(void)
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	preempt_enable();
+	migrate_enable();
 }
 #else
 asmlinkage __visible void dump_stack(void)
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e..0efe7ba1930e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
