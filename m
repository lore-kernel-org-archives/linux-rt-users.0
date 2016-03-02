From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/10] kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()
Date: Wed, 02 Mar 2016 10:51:09 -0500
Message-ID: <20160302155112.029909653@goodmis.org>
References: <20160302155100.873557484@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:60961 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688AbcCBPvS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:51:18 -0500
Content-Disposition: inline; filename=0009-kernel-sched-Fix-preempt_disable_ip-recodring-for-pr.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.10.97-rt107-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

preempt_disable() invokes preempt_count_add() which saves the caller in
current->preempt_disable_ip. It uses CALLER_ADDR1 which does not look for its
caller but for the parent of the caller. Which means we get the correct caller
for something like spin_lock() unless the architectures inlines those
invocations. It is always wrong for preempt_disable() or local_bh_disable().

This patch makes the function get_parent_ip() which tries CALLER_ADDR0,1,2 if
the former is a locking function.  This seems to record the preempt_disable()
caller properly for preempt_disable() itself as well as for get_cpu_var() or
local_bh_disable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 12 ++++++++++++
 include/linux/sched.h  |  2 --
 kernel/sched/core.c    | 14 ++------------
 kernel/softirq.c       |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7a13848d635c..c47f15afecdc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -631,6 +631,18 @@ static inline void __ftrace_enabled_restore(int enabled)
 # endif
 #endif /* ifndef HAVE_ARCH_CALLER_ADDR */
 
+static inline unsigned long get_lock_parent_ip(void)
+{
+	unsigned long addr = CALLER_ADDR0;
+
+	if (!in_lock_functions(addr))
+		return addr;
+	addr = CALLER_ADDR1;
+	if (!in_lock_functions(addr))
+		return addr;
+	return CALLER_ADDR2;
+}
+
 #ifdef CONFIG_IRQSOFF_TRACER
   extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
   extern void time_hardirqs_off(unsigned long a0, unsigned long a1);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61326229b234..866028bbd8ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -117,8 +117,6 @@ struct task_migration_notifier {
 };
 extern void register_task_migration_notifier(struct notifier_block *n);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77f43eeac94a..756953bdc800 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2850,16 +2850,6 @@ u64 scheduler_tick_max_deferment(void)
 }
 #endif
 
-notrace unsigned long get_parent_ip(unsigned long addr)
-{
-	if (in_lock_functions(addr)) {
-		addr = CALLER_ADDR2;
-		if (in_lock_functions(addr))
-			addr = CALLER_ADDR3;
-	}
-	return addr;
-}
-
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_PREEMPT_TRACER))
 
@@ -2881,7 +2871,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2907,7 +2897,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 463523131bfa..2c71e6529c2c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -277,7 +277,7 @@ static void __local_bh_disable(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 #else /* !CONFIG_TRACE_IRQFLAGS */
 static inline void __local_bh_disable(unsigned long ip, unsigned int cnt)
-- 
2.7.0


