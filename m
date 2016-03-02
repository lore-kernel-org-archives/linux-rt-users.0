From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 16/17] kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()
Date: Wed, 02 Mar 2016 10:44:49 -0500
Message-ID: <20160302154502.340688542@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:59735 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579AbcCBPpF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:45:05 -0500
Content-Disposition: inline; filename=0016-kernel-sched-Fix-preempt_disable_ip-recodring-for-pr.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.61-rt64-rc1 stable review patch.
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
index 2068dff8a2cc..a28c5dab7131 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -625,6 +625,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index 9e6db231d0b9..f49fd086d5dc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -180,8 +180,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3825465fb1eb..5e86914f2d3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2548,16 +2548,6 @@ u64 scheduler_tick_max_deferment(void)
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
 
@@ -2579,7 +2569,7 @@ void __kprobes preempt_count_add(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2605,7 +2595,7 @@ void __kprobes preempt_count_sub(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	__preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 250669395a5f..7abfdab644bd 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -288,7 +288,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
-- 
2.7.0


