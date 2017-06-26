From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 03/32] ring-buffer: Add interface for setting absolute time stamps
Date: Mon, 26 Jun 2017 17:49:04 -0500
Message-ID: <2e6714e525e62f54dd72d563c7d220be76f8f808.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11033 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdFZWts (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:49:48 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Define a new function, tracing_set_time_stamp_abs(), which can be used
to enable or disable the use of absolute timestamps rather than time
deltas for a trace array.

This resets the buffer to prevent a mix of time deltas and absolute
timestamps.

Only the interface is added here; a subsequent patch will add the
underlying implementation.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/ring_buffer.h |  2 ++
 kernel/trace/ring_buffer.c  | 11 +++++++++++
 kernel/trace/trace.c        | 25 ++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index ee9b461..28e3472 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -180,6 +180,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct ring_buffer *buffer,
 			   u64 (*clock)(void));
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4ae268e..f544738 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -485,6 +485,7 @@ struct ring_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
+	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1379,6 +1380,16 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 	buffer->clock = clock;
 }
 
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs)
+{
+	buffer->time_stamp_abs = abs;
+}
+
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer)
+{
+	return buffer->time_stamp_abs;
+}
+
 static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
 
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 19ac208..da8cd51 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2169,7 +2169,7 @@ struct ring_buffer_event *
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -6079,6 +6079,29 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+{
+	mutex_lock(&trace_types_lock);
+
+	ring_buffer_set_time_stamp_abs(tr->trace_buffer.buffer, abs);
+
+	/*
+	 * New timestamps may not be consistent with the previous setting.
+	 * Reset the buffer so that it doesn't have incomparable timestamps.
+	 */
+	tracing_reset_online_cpus(&tr->trace_buffer);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
+	tracing_reset_online_cpus(&tr->max_buffer);
+#endif
+
+	mutex_unlock(&trace_types_lock);
+
+	return 0;
+}
+
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 69a3ab3..155ad9a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -281,6 +281,8 @@ enum {
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
1.9.3

