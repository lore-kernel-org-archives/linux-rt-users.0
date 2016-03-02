From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/13] kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()
Date: Wed, 02 Mar 2016 10:48:59 -0500
Message-ID: <20160302154907.069354385@goodmis.org>
References: <20160302154847.937325532@goodmis.org>
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
Content-Disposition: inline; filename=0012-kernel-sched-Fix-preempt_disable_ip-recodring-for-pr.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.54-rt74-rc1 stable review patch.
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
index e68db4d534cb..9b7b9341f886 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -627,6 +627,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index 3ce814c4ef42..4006703785b2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -113,8 +113,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e56dc293669..c66db09aaf12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2279,16 +2279,6 @@ u64 scheduler_tick_max_deferment(void)
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
 
@@ -2310,7 +2300,7 @@ void __kprobes add_preempt_count(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2336,7 +2326,7 @@ void __kprobes sub_preempt_count(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7c8e36bf9e2a..315b048423af 100644
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
