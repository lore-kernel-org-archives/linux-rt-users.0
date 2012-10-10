From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/8] sched: Better debug output for might sleep
Date: Wed, 10 Oct 2012 09:34:12 -0400
Message-ID: <20121010133523.816809880@goodmis.org>
References: <20121010133406.053812290@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-sched-Better-debug-output-for-might-sleep.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

might sleep can tell us where interrupts have been disabled, but we
have no idea what disabled preemption. Add some debug infrastructure.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/sched.h |    4 ++++
 kernel/sched/core.c   |   23 +++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6f342d8..f291347 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1655,6 +1655,10 @@ struct task_struct {
 	int kmap_idx;
 	pte_t kmap_pte[KM_TYPE_NR];
 #endif
+
+#ifdef CONFIG_DEBUG_PREEMPT
+	unsigned long preempt_disable_ip;
+#endif
 };
 
 #ifdef CONFIG_PREEMPT_RT_FULL
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 66d4dea..263fd96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3215,8 +3215,13 @@ void __kprobes add_preempt_count(int val)
 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
 				PREEMPT_MASK - 10);
 #endif
-	if (preempt_count() == val)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+	if (preempt_count() == val) {
+		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+#ifdef CONFIG_DEBUG_PREEMPT
+		current->preempt_disable_ip = ip;
+#endif
+		trace_preempt_off(CALLER_ADDR0, ip);
+	}
 }
 EXPORT_SYMBOL(add_preempt_count);
 
@@ -3259,6 +3264,13 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	print_modules();
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
+#ifdef DEBUG_PREEMPT
+	if (in_atomic_preempt_off()) {
+		pr_err("Preemption disabled at:");
+		print_ip_sym(current->preempt_disable_ip);
+		pr_cont("\n");
+	}
+#endif
 	dump_stack();
 }
 
@@ -7479,6 +7491,13 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 	debug_show_held_locks(current);
 	if (irqs_disabled())
 		print_irqtrace_events(current);
+#ifdef DEBUG_PREEMPT
+	if (!preempt_count_equals(preempt_offset)) {
+		pr_err("Preemption disabled at:");
+		print_ip_sym(current->preempt_disable_ip);
+		pr_cont("\n");
+	}
+#endif
 	dump_stack();
 }
 EXPORT_SYMBOL(__might_sleep);
-- 
1.7.10.4
