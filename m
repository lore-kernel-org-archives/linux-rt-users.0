From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 3/9] tracing: adding function timings to function profile
Date: Tue, 19 May 2009 11:48:47 -0300
Message-ID: <20090519144847.GK27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:45066 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZESOsu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 10:48:50 -0400
Received: by pxi29 with SMTP id 29so2455021pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 07:48:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

tracing: adding function timings to function profile

Backport to 2.6.29.3-rt14.

| From: Steven Rostedt <srostedt@redhat.com>
| 
| If the function graph trace is enabled, the function profiler will
| use it to take the timing of the functions.
| 
|  cat /debug/tracing/trace_stat/functions
| 
|   Function                               Hit    Time
|   --------                               ---    ----
|   mwait_idle                             127    183028.4 us
|   schedule                                26    151997.7 us
|   __schedule                              31    151975.1 us
|   sys_wait4                                2    74080.53 us
|   do_wait                                  2    74077.80 us
|   sys_newlstat                           138    39929.16 us
|   do_path_lookup                         179    39845.79 us
|   vfs_lstat_fd                           138    39761.97 us
|   user_path_at                           153    39469.58 us
|   path_walk                              179    39435.76 us
|   __link_path_walk                       189    39143.73 us
| [...]
| 
| Note the times are skewed due to the function graph tracer not taking
| into account schedules.
| 
| Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/trace/ftrace.c                |   93 ++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c                 |   11 ----
 kernel/trace/trace.h                 |    3 +-
 kernel/trace/trace_functions_graph.c |   17 +++++-
 kernel/trace/trace_output.c          |   10 ++++
 kernel/trace/trace_output.h          |    2 +
 6 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 24dac44..a9ccd71 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -33,7 +33,7 @@
 
 #include <asm/ftrace.h>
 
-#include "trace.h"
+#include "trace_output.h"
 #include "trace_stat.h"
 
 #define FTRACE_WARN_ON(cond)			\
@@ -246,6 +246,9 @@ struct ftrace_profile {
 	struct hlist_node		node;
 	unsigned long			ip;
 	unsigned long			counter;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	unsigned long long		time;
+#endif
 };
 
 struct ftrace_profile_page {
@@ -303,6 +306,22 @@ static void *function_stat_start(struct tracer_stat *trace)
 	return function_stat_next(&profile_pages_start->records[0], 0);
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* function graph compares on total time */
+static int function_stat_cmp(void *p1, void *p2)
+{
+	struct ftrace_profile *a = p1;
+	struct ftrace_profile *b = p2;
+
+	if (a->time < b->time)
+		return -1;
+	if (a->time > b->time)
+		return 1;
+	else
+		return 0;
+}
+#else
+/* not function graph compares against hits */
 static int function_stat_cmp(void *p1, void *p2)
 {
 	struct ftrace_profile *a = p1;
@@ -315,11 +334,17 @@ static int function_stat_cmp(void *p1, void *p2)
 	else
 		return 0;
 }
+#endif
 
 static int function_stat_headers(struct seq_file *m)
 {
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	seq_printf(m, "  Function                               Hit    Time\n"
+		      "  --------                               ---    ----\n");
+#else
 	seq_printf(m, "  Function                               Hit\n"
 		      "  --------                               ---\n");
+#endif
 	return 0;
 }
 
@@ -327,10 +352,25 @@ static int function_stat_show(struct seq_file *m, void *v)
 {
 	struct ftrace_profile *rec = v;
 	char str[KSYM_SYMBOL_LEN];
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	static struct trace_seq s;
+	static DEFINE_MUTEX(mutex);
+
+	mutex_lock(&mutex);
+	trace_seq_init(&s);
+	trace_print_graph_duration(rec->time, &s);
+#endif
 
 	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	seq_printf(m, "    ");
+	trace_print_seq(m, &s);
+	mutex_unlock(&mutex);
+#endif
+	seq_putc(m, '\n');
 
-	seq_printf(m, "  %-30.30s  %10lu\n", str, rec->counter);
 	return 0;
 }
 
@@ -534,11 +574,52 @@ function_profile_call(unsigned long ip, unsigned long parent_ip)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static int profile_graph_entry(struct ftrace_graph_ent *trace)
+{
+	function_profile_call(trace->func, 0);
+	return 1;
+}
+
+static void profile_graph_return(struct ftrace_graph_ret *trace)
+{
+	unsigned long flags;
+	struct ftrace_profile *rec;
+
+	local_irq_save(flags);
+	rec = ftrace_find_profiled_func(trace->func);
+	if (rec)
+		rec->time += trace->rettime - trace->calltime;
+	local_irq_restore(flags);
+}
+
+static int register_ftrace_profiler(void)
+{
+	return register_ftrace_graph(&profile_graph_return,
+				     &profile_graph_entry);
+}
+
+static void unregister_ftrace_profiler(void)
+{
+	unregister_ftrace_graph();
+}
+#else
 static struct ftrace_ops ftrace_profile_ops __read_mostly =
 {
 	.func = function_profile_call,
 };
 
+static int register_ftrace_profiler(void)
+{
+	return register_ftrace_function(&ftrace_profile_ops);
+}
+
+static void unregister_ftrace_profiler(void)
+{
+	unregister_ftrace_function(&ftrace_profile_ops);
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 static ssize_t
 ftrace_profile_write(struct file *filp, const char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
@@ -570,11 +651,15 @@ ftrace_profile_write(struct file *filp, const char __user *ubuf,
 				goto out;
 			}
 
-			register_ftrace_function(&ftrace_profile_ops);
+			ret = register_ftrace_profiler();
+			if (ret < 0) {
+				cnt = ret;
+				goto out;
+			}
 			ftrace_profile_enabled = 1;
 		} else {
 			ftrace_profile_enabled = 0;
-			unregister_ftrace_function(&ftrace_profile_ops);
+			unregister_ftrace_profiler();
 		}
 	}
  out:
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 67c6a21..821bf49 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -405,17 +405,6 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 	return cnt;
 }
 
-static void
-trace_print_seq(struct seq_file *m, struct trace_seq *s)
-{
-	int len = s->len >= PAGE_SIZE ? PAGE_SIZE - 1 : s->len;
-
-	s->buffer[len] = 0;
-	seq_puts(m, s->buffer);
-
-	trace_seq_init(s);
-}
-
 /**
  * update_max_tr - snapshot all trace buffers from global_trace to max_tr
  * @tr: tracer
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d7410bb..c66ca3b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -613,6 +613,8 @@ extern unsigned long trace_flags;
 /* Standard output formatting function used for function return traces */
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern enum print_line_t print_graph_function(struct trace_iterator *iter);
+extern enum print_line_t
+trace_print_graph_duration(unsigned long long duration, struct trace_seq *s);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 /* TODO: make this variable */
@@ -644,7 +646,6 @@ static inline int ftrace_graph_addr(unsigned long addr)
 	return 1;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
-
 #else /* CONFIG_FUNCTION_GRAPH_TRACER */
 static inline enum print_line_t
 print_graph_function(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index d28687e..85bba0f 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -426,8 +426,8 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 	return TRACE_TYPE_HANDLED;
 }
 
-static enum print_line_t
-print_graph_duration(unsigned long long duration, struct trace_seq *s)
+enum print_line_t
+trace_print_graph_duration(unsigned long long duration, struct trace_seq *s)
 {
 	unsigned long nsecs_rem = do_div(duration, 1000);
 	/* log10(ULONG_MAX) + '\0' */
@@ -464,12 +464,23 @@ print_graph_duration(unsigned long long duration, struct trace_seq *s)
 		if (!ret)
 			return TRACE_TYPE_PARTIAL_LINE;
 	}
+	return TRACE_TYPE_HANDLED;
+}
+
+static enum print_line_t
+print_graph_duration(unsigned long long duration, struct trace_seq *s)
+{
+	int ret;
+
+	ret = trace_print_graph_duration(duration, s);
+	if (ret != TRACE_TYPE_HANDLED)
+		return ret;
 
 	ret = trace_seq_printf(s, "|  ");
 	if (!ret)
 		return TRACE_TYPE_PARTIAL_LINE;
-	return TRACE_TYPE_HANDLED;
 
+	return TRACE_TYPE_HANDLED;
 }
 
 /* Case of a leaf function on its call entry */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 19261fd..a3b6e3f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -19,6 +19,16 @@ static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
 
 static int next_event_type = __TRACE_LAST_TYPE + 1;
 
+void trace_print_seq(struct seq_file *m, struct trace_seq *s)
+{
+	int len = s->len >= PAGE_SIZE ? PAGE_SIZE - 1 : s->len;
+
+	s->buffer[len] = 0;
+	seq_puts(m, s->buffer);
+
+	trace_seq_init(s);
+}
+
 enum print_line_t trace_print_bprintk_msg_only(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index 35c422f..1eac297 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -20,6 +20,8 @@ trace_print_bprintk_msg_only(struct trace_iterator *iter);
 extern enum print_line_t
 trace_print_printk_msg_only(struct trace_iterator *iter);
 
+extern void trace_print_seq(struct seq_file *m, struct trace_seq *s);
+
 extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
 extern int
-- 
1.6.2

-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

