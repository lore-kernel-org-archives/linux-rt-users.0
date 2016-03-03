From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()
Date: Wed, 02 Mar 2016 21:21:39 -0500
Message-ID: <20160303022156.194035069@goodmis.org>
References: <20160303022133.583693153@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-kernel-sched-Fix-preempt_disable_ip-recodring-for-pr.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.77-rt112-rc1 stable review patch.
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
 kernel/sched.c         | 14 ++------------
 kernel/softirq.c       |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3ebb09d4283..3c87797e371e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -341,6 +341,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index a15cfd1bac9f..3cb870f1ffc1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -149,8 +149,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 struct seq_file;
 struct cfs_rq;
 struct task_group;
diff --git a/kernel/sched.c b/kernel/sched.c
index 24d7256ce0b2..abc27a937c1b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4460,16 +4460,6 @@ void scheduler_tick(void)
 #endif
 }
 
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
 
@@ -4491,7 +4481,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -4517,7 +4507,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 61860daa4098..b03c01c77d92 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -207,7 +207,7 @@ static void __local_bh_disable(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 #else /* !CONFIG_TRACE_IRQFLAGS */
 static inline void __local_bh_disable(unsigned long ip, unsigned int cnt)
-- 
2.7.0
