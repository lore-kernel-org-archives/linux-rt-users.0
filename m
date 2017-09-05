From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 40/40] tracing: Add trace_event_buffer_reserve() variant that allows recursion
Date: Tue,  5 Sep 2017 16:57:52 -0500
Message-ID: <417873f6f05e44b6c93abd9771f85fa8f2dd37d0.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Synthetic event generation requires the reservation of a second event
while the reservation of a previous event is still in progress.  The
trace_recursive_lock() check in ring_buffer_lock_reserve() prevents
this however.

This sets up a special reserve pathway for this particular case,
leaving existing pathways untouched, other than an additional check in
ring_buffer_lock_reserve() and trace_event_buffer_reserve().  These
checks could be gotten rid of as well, with copies of those functions,
but for now try to avoid that unless necessary.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/ring_buffer.h      |  3 +-
 include/linux/trace_events.h     | 10 +++++++
 kernel/trace/ring_buffer.c       | 10 +++++--
 kernel/trace/trace.c             | 65 +++++++++++++++++++++++++++-------------
 kernel/trace/trace_events.c      | 35 +++++++++++++++++-----
 kernel/trace/trace_events_hist.c |  4 +--
 6 files changed, 93 insertions(+), 34 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 74bc276..5459516 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -113,7 +113,8 @@ int ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 void ring_buffer_change_overwrite(struct ring_buffer *buffer, int val);
 
 struct ring_buffer_event *ring_buffer_lock_reserve(struct ring_buffer *buffer,
-						   unsigned long length);
+						   unsigned long length,
+						   bool allow_recursion);
 int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 			      struct ring_buffer_event *event);
 int ring_buffer_write(struct ring_buffer *buffer,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index bfd2a53..eb03abb 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -151,6 +151,12 @@ struct ring_buffer_event *
 				int type, unsigned long len,
 				unsigned long flags, int pc);
 
+struct ring_buffer_event *
+trace_event_buffer_lock_reserve_recursive(struct ring_buffer **current_buffer,
+					  struct trace_event_file *trace_file,
+					  int type, unsigned long len,
+					  unsigned long flags, int pc);
+
 #define TRACE_RECORD_CMDLINE	BIT(0)
 #define TRACE_RECORD_TGID	BIT(1)
 
@@ -210,6 +216,10 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 				  struct trace_event_file *trace_file,
 				  unsigned long len);
 
+void *trace_event_buffer_reserve_recursive(struct trace_event_buffer *fbuffer,
+					   struct trace_event_file *trace_file,
+					   unsigned long len);
+
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer);
 
 enum {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0bcc53e..8e5bcfa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2830,6 +2830,7 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
  * ring_buffer_lock_reserve - reserve a part of the buffer
  * @buffer: the ring buffer to reserve from
  * @length: the length of the data to reserve (excluding event header)
+ * @allow_recursion: flag allowing recursion check to be overridden
  *
  * Returns a reseverd event on the ring buffer to copy directly to.
  * The user of this interface will need to get the body to write into
@@ -2842,7 +2843,8 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
  * If NULL is returned, then nothing has been allocated or locked.
  */
 struct ring_buffer_event *
-ring_buffer_lock_reserve(struct ring_buffer *buffer, unsigned long length)
+ring_buffer_lock_reserve(struct ring_buffer *buffer, unsigned long length,
+			 bool allow_recursion)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
@@ -2867,8 +2869,10 @@ struct ring_buffer_event *
 	if (unlikely(length > BUF_MAX_DATA_SIZE))
 		goto out;
 
-	if (unlikely(trace_recursive_lock(cpu_buffer)))
-		goto out;
+	if (unlikely(trace_recursive_lock(cpu_buffer))) {
+		if (!allow_recursion)
+			goto out;
+	}
 
 	event = rb_reserve_next_event(buffer, cpu_buffer, length);
 	if (!event)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ecdf456..1d009e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -744,13 +744,14 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 
 static __always_inline struct ring_buffer_event *
 __trace_buffer_lock_reserve(struct ring_buffer *buffer,
-			  int type,
-			  unsigned long len,
-			  unsigned long flags, int pc)
+			    int type,
+			    unsigned long len,
+			    unsigned long flags, int pc,
+			    bool allow_recursion)
 {
 	struct ring_buffer_event *event;
 
-	event = ring_buffer_lock_reserve(buffer, len);
+	event = ring_buffer_lock_reserve(buffer, len, allow_recursion);
 	if (event != NULL)
 		trace_event_setup(event, type, flags, pc);
 
@@ -829,8 +830,8 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 
 	local_save_flags(irq_flags);
 	buffer = global_trace.trace_buffer.buffer;
-	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc, 
-					    irq_flags, pc);
+	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
+					    irq_flags, pc, false);
 	if (!event)
 		return 0;
 
@@ -878,7 +879,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	local_save_flags(irq_flags);
 	buffer = global_trace.trace_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
-					    irq_flags, pc);
+					    irq_flags, pc, false);
 	if (!event)
 		return 0;
 
@@ -2150,7 +2151,7 @@ struct ring_buffer_event *
 			  unsigned long len,
 			  unsigned long flags, int pc)
 {
-	return __trace_buffer_lock_reserve(buffer, type, len, flags, pc);
+	return __trace_buffer_lock_reserve(buffer, type, len, flags, pc, false);
 }
 
 DEFINE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
@@ -2267,10 +2268,11 @@ void trace_buffered_event_disable(void)
 static struct ring_buffer *temp_buffer;
 
 struct ring_buffer_event *
-trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
-			  struct trace_event_file *trace_file,
-			  int type, unsigned long len,
-			  unsigned long flags, int pc)
+__trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
+				  struct trace_event_file *trace_file,
+				  int type, unsigned long len,
+				  unsigned long flags, int pc,
+				  bool allow_recursion)
 {
 	struct ring_buffer_event *entry;
 	int val;
@@ -2291,7 +2293,7 @@ struct ring_buffer_event *
 	}
 
 	entry = __trace_buffer_lock_reserve(*current_rb,
-					    type, len, flags, pc);
+					    type, len, flags, pc, allow_recursion);
 	/*
 	 * If tracing is off, but we have triggers enabled
 	 * we still need to look at the event data. Use the temp_buffer
@@ -2301,12 +2303,33 @@ struct ring_buffer_event *
 	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
 		*current_rb = temp_buffer;
 		entry = __trace_buffer_lock_reserve(*current_rb,
-						    type, len, flags, pc);
+						    type, len, flags, pc, allow_recursion);
 	}
 	return entry;
 }
+
+struct ring_buffer_event *
+trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
+			  struct trace_event_file *trace_file,
+			  int type, unsigned long len,
+			  unsigned long flags, int pc)
+{
+	return __trace_event_buffer_lock_reserve(current_rb, trace_file, type,
+						 len, flags, pc, false);
+}
 EXPORT_SYMBOL_GPL(trace_event_buffer_lock_reserve);
 
+struct ring_buffer_event *
+trace_event_buffer_lock_reserve_recursive(struct ring_buffer **current_rb,
+					  struct trace_event_file *trace_file,
+					  int type, unsigned long len,
+					  unsigned long flags, int pc)
+{
+	return __trace_event_buffer_lock_reserve(current_rb, trace_file, type,
+						 len, flags, pc, true);
+}
+EXPORT_SYMBOL_GPL(trace_event_buffer_lock_reserve_recursive);
+
 static DEFINE_SPINLOCK(tracepoint_iter_lock);
 static DEFINE_MUTEX(tracepoint_printk_mutex);
 
@@ -2548,7 +2571,7 @@ int unregister_ftrace_export(struct trace_export *export)
 	struct ftrace_entry *entry;
 
 	event = __trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
-					    flags, pc);
+					    flags, pc, false);
 	if (!event)
 		return;
 	entry	= ring_buffer_event_data(event);
@@ -2628,7 +2651,7 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	size *= sizeof(unsigned long);
 
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-					    sizeof(*entry) + size, flags, pc);
+					    sizeof(*entry) + size, flags, pc, false);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
@@ -2759,7 +2782,7 @@ void trace_dump_stack(int skip)
 	__this_cpu_inc(user_stack_count);
 
 	event = __trace_buffer_lock_reserve(buffer, TRACE_USER_STACK,
-					    sizeof(*entry), flags, pc);
+					    sizeof(*entry), flags, pc, false);
 	if (!event)
 		goto out_drop_count;
 	entry	= ring_buffer_event_data(event);
@@ -2930,7 +2953,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	size = sizeof(*entry) + sizeof(u32) * len;
 	buffer = tr->trace_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
-					    flags, pc);
+					    flags, pc, false);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
@@ -2986,7 +3009,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	local_save_flags(flags);
 	size = sizeof(*entry) + len + 1;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    flags, pc);
+					    flags, pc, false);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
@@ -6097,7 +6120,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 
 	buffer = tr->trace_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    irq_flags, preempt_count());
+					    irq_flags, preempt_count(), false);
 	if (unlikely(!event))
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
@@ -6169,7 +6192,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 
 	buffer = tr->trace_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    irq_flags, preempt_count());
+					    irq_flags, preempt_count(), false);
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 889802c..7b90462 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -249,9 +249,9 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 }
 EXPORT_SYMBOL_GPL(trace_event_ignore_this_pid);
 
-void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
-				 struct trace_event_file *trace_file,
-				 unsigned long len)
+void *__trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
+				   struct trace_event_file *trace_file,
+				   unsigned long len, bool allow_recursion)
 {
 	struct trace_event_call *event_call = trace_file->event_call;
 
@@ -271,18 +271,39 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 		fbuffer->pc--;
 	fbuffer->trace_file = trace_file;
 
-	fbuffer->event =
-		trace_event_buffer_lock_reserve(&fbuffer->buffer, trace_file,
-						event_call->event.type, len,
-						fbuffer->flags, fbuffer->pc);
+	if (!allow_recursion)
+		fbuffer->event =
+			trace_event_buffer_lock_reserve(&fbuffer->buffer, trace_file,
+							event_call->event.type, len,
+							fbuffer->flags, fbuffer->pc);
+	else
+		fbuffer->event =
+			trace_event_buffer_lock_reserve_recursive(&fbuffer->buffer, trace_file,
+								  event_call->event.type, len,
+								  fbuffer->flags, fbuffer->pc);
 	if (!fbuffer->event)
 		return NULL;
 
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
+
+void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
+				 struct trace_event_file *trace_file,
+				 unsigned long len)
+{
+	return __trace_event_buffer_reserve(fbuffer, trace_file, len, false);
+}
 EXPORT_SYMBOL_GPL(trace_event_buffer_reserve);
 
+void *trace_event_buffer_reserve_recursive(struct trace_event_buffer *fbuffer,
+					   struct trace_event_file *trace_file,
+					   unsigned long len)
+{
+	return __trace_event_buffer_reserve(fbuffer, trace_file, len, true);
+}
+EXPORT_SYMBOL_GPL(trace_event_buffer_reserve_recursive);
+
 int trace_event_reg(struct trace_event_call *call,
 		    enum trace_reg type, void *data)
 {
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb77eee..67a25bf 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -674,8 +674,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 	fields_size = event->n_u64 * sizeof(u64);
 
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
-					   sizeof(*entry) + fields_size);
+	entry = trace_event_buffer_reserve_recursive(&fbuffer, trace_file,
+						     sizeof(*entry) + fields_size);
 	if (!entry)
 		return;
 
-- 
1.9.3
