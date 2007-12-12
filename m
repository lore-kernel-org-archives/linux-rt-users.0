From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt] preempt_max_latency to microseconds
Date: Wed, 12 Dec 2007 09:18:49 -0800
Message-ID: <20071212171811.134848654__48160.7875707143$1197480745$gmane$org@mvista.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757223AbXLLRbZ@vger.kernel.org>
Message-Id: <20071212171811.134848654@mvista.com>
Date: Wed, 12 Dec 2007 09:18:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Not to long ago preempt_max_latency was microseconds, and someplace
along the way it turned into cycles. That's a bit unintuitive, so I 
converted it back to microseconds.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |   12 ++++++++++--
 kernel/latency_trace.c      |   36 +++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c             |   12 ++++++------
 3 files changed, 51 insertions(+), 9 deletions(-)

Index: linux-2.6.23/include/linux/clocksource.h
===================================================================
--- linux-2.6.23.orig/include/linux/clocksource.h
+++ linux-2.6.23/include/linux/clocksource.h
@@ -21,10 +21,18 @@
 typedef u64 cycle_t;
 struct clocksource;
 
-extern unsigned long preempt_max_latency;
-extern unsigned long preempt_thresh;
+extern unsigned long preempt_max_latency_us;
+extern unsigned long preempt_thresh_us;
 extern unsigned long preempt_mark_thresh;
 
+struct ctl_table;
+struct file;
+extern int proc_preempt_max_latency(struct ctl_table *table, int write,
+				    struct file *file, void __user *buffer,
+				    size_t *length, loff_t *ppos);
+extern int proc_preempt_threshold(struct ctl_table *table, int write,
+				  struct file *file, void __user *buffer,
+				  size_t *length, loff_t *ppos);
 /**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
Index: linux-2.6.23/kernel/latency_trace.c
===================================================================
--- linux-2.6.23.orig/kernel/latency_trace.c
+++ linux-2.6.23/kernel/latency_trace.c
@@ -27,6 +27,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/rtc.h>
 #include <linux/stacktrace.h>
+#include <linux/sysctl.h>
 
 #ifndef DEFINE_RAW_SPINLOCK
 # define DEFINE_RAW_SPINLOCK		DEFINE_SPINLOCK
@@ -38,7 +39,7 @@
 
 int trace_use_raw_cycles = 0;
 
-#ifdef CONFIG_EVENT_TRACE
+#if defined(CONFIG_LATENCY_TIMING) || defined(CONFIG_EVENT_TRACE)
 /*
  * Convert raw cycles to usecs.
  * Note: this is not the 'clocksource cycles' value, it's the raw
@@ -161,11 +162,14 @@ enum trace_flag_type
  */
 #ifdef CONFIG_LATENCY_HIST
 unsigned long preempt_max_latency = (cycle_t)0UL;
+unsigned long preempt_max_latency_us = (cycle_t)0UL;
 #else
 unsigned long preempt_max_latency = (cycle_t)ULONG_MAX;
+unsigned long preempt_max_latency_us = (cycle_t)ULONG_MAX;
 #endif
 
 unsigned long preempt_thresh;
+unsigned long preempt_thresh_us;
 
 /*
  * Should this new latency be reported/recorded?
@@ -1713,6 +1717,7 @@ static int setup_preempt_thresh(char *s)
 	get_option(&s, &thresh);
 	if (thresh > 0) {
 		preempt_thresh = usecs_to_cycles(thresh);
+		preempt_thresh_us = thresh;
 		printk("Preemption threshold = %u us\n", thresh);
 	}
 	return 1;
@@ -2806,3 +2811,32 @@ void __init init_tracer(void)
 		total_size);
 }
 #endif
+
+#ifdef CONFIG_LATENCY_TIMING
+
+int proc_preempt_max_latency(struct ctl_table *table, int write,
+			     struct file *file, void __user *buffer,
+			     size_t *length, loff_t *ppos)
+{
+	preempt_max_latency_us = cycles_to_us(preempt_max_latency);
+
+	proc_doulongvec_minmax(table, write, file, buffer, length, ppos);
+
+	preempt_max_latency = usecs_to_cycles(preempt_max_latency_us);
+
+	return 0;
+}
+
+int proc_preempt_threshold(struct ctl_table *table, int write,
+			   struct file *file, void __user *buffer,
+			   size_t *length, loff_t *ppos)
+{
+	preempt_thresh_us = cycles_to_us(preempt_thresh);
+
+	proc_doulongvec_minmax(table, write, file, buffer, length, ppos);
+
+	preempt_thresh = usecs_to_cycles(preempt_thresh_us);
+
+	return 0;
+}
+#endif
Index: linux-2.6.23/kernel/sysctl.c
===================================================================
--- linux-2.6.23.orig/kernel/sysctl.c
+++ linux-2.6.23/kernel/sysctl.c
@@ -418,18 +418,18 @@ static struct ctl_table kern_table[] = {
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "preempt_max_latency",
-		.data		= &preempt_max_latency,
-		.maxlen		= sizeof(preempt_max_latency),
+		.data		= &preempt_max_latency_us,
+		.maxlen		= sizeof(preempt_max_latency_us),
 		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
+		.proc_handler	= &proc_preempt_max_latency,
 	},
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "preempt_thresh",
-		.data		= &preempt_thresh,
-		.maxlen		= sizeof(preempt_thresh),
+		.data		= &preempt_thresh_us,
+		.maxlen		= sizeof(preempt_thresh_us),
 		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
+		.proc_handler	= &proc_preempt_threshold,
 	},
 #endif
 #ifdef CONFIG_EVENT_TRACE
-- 

-- 
