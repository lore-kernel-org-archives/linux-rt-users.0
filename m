From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v3 03/33] ring-buffer: Add interface for setting absolute time stamps
Date: Fri, 22 Sep 2017 14:59:43 -0500
Message-ID: <df519705509bf3ed5fccf2a88dec2b216d19f088.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Define a new function, tracing_set_time_stamp_abs(), which can be used
to enable or disable the use of absolute timestamps rather than time
deltas for a trace array.

This resets the buffer to prevent a mix of time deltas and absolute
timestamps.

Only the interface is added here; a subsequent patch will add the
underlying implementation.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Baohong Liu <baohong.liu@intel.com>
---
 include/linux/ring_buffer.h |  2 ++
 kernel/trace/ring_buffer.c  | 11 +++++++++++
 kernel/trace/trace.c        | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  3 +++
 4 files changed, 55 insertions(+), 1 deletion(-)

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
index f6ee9b1..1e5b75a 100644
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
index c203b4b..24af00a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2269,7 +2269,7 @@ struct ring_buffer_event *
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -6285,6 +6285,44 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+{
+	int ret = 0;
+
+	mutex_lock(&trace_types_lock);
+
+	if (abs && tr->time_stamp_abs_ref++)
+		goto out;
+
+	if (!abs) {
+		if (WARN_ON_ONCE(!tr->time_stamp_abs_ref)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (--tr->time_stamp_abs_ref)
+			goto out;
+	}
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
+	if (tr->max_buffer.buffer)
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
+	tracing_reset_online_cpus(&tr->max_buffer);
+#endif
+ out:
+	mutex_unlock(&trace_types_lock);
+
+	return ret;
+}
+
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 61e2f35..d1e5d70 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -272,6 +272,7 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	int			time_stamp_abs_ref;
 };
 
 enum {
@@ -285,6 +286,8 @@ enum {
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
1.9.3
