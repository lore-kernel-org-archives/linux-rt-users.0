From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 03/21] ring-buffer: Add TIME_EXTEND_ABS ring buffer type
Date: Wed,  8 Feb 2017 11:24:59 -0600
Message-ID: <a27fc1371e12174ee9f806d67d0c60844ebbe04c.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Replace the unused RINGBUF_TYPE_TIME_STAMP ring buffer type with
RINGBUF_TYPE_TIME_EXTEND_ABS, which forces extended time_deltas for
all events.

Having time_deltas that aren't dependent on previous events in the
ring buffer makes it feasible to use the ring_buffer_event timetamps
in a more random-access way, to be used for purposes other than serial
event printing.

To set/reset this mode, use tracing_set_timestamp_abs().

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/ring_buffer.h |  12 ++++-
 kernel/trace/ring_buffer.c  | 109 ++++++++++++++++++++++++++++++++------------
 kernel/trace/trace.c        |  25 +++++++++-
 kernel/trace/trace.h        |   2 +
 4 files changed, 117 insertions(+), 31 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index b6d4568..c3a1064 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -36,6 +36,12 @@ struct ring_buffer_event {
  *				 array[0] = time delta (28 .. 59)
  *				 size = 8 bytes
  *
+ * @RINGBUF_TYPE_TIME_EXTEND_ABS:
+ *				 Extend the time delta, but interpret it as
+ *				 absolute, not relative
+ *				 array[0] = time delta (28 .. 59)
+ *				 size = 8 bytes
+ *
  * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
  *				 array[0]    = tv_nsec
  *				 array[1..2] = tv_sec
@@ -56,12 +62,12 @@ enum ring_buffer_type {
 	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
 	RINGBUF_TYPE_PADDING,
 	RINGBUF_TYPE_TIME_EXTEND,
-	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
-	RINGBUF_TYPE_TIME_STAMP,
+	RINGBUF_TYPE_TIME_EXTEND_ABS,
 };
 
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
@@ -180,6 +186,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct ring_buffer *buffer,
 			   u64 (*clock)(void));
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a85739e..c9c9a83 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -41,6 +41,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 			 RINGBUF_TYPE_PADDING);
 	trace_seq_printf(s, "\ttime_extend : type == %d\n",
 			 RINGBUF_TYPE_TIME_EXTEND);
+	trace_seq_printf(s, "\ttime_extend_abs : type == %d\n",
+			 RINGBUF_TYPE_TIME_EXTEND_ABS);
 	trace_seq_printf(s, "\tdata max type_len  == %d\n",
 			 RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 
@@ -186,11 +188,9 @@ static void rb_event_set_padding(struct ring_buffer_event *event)
 		return  event->array[0] + RB_EVNT_HDR_SIZE;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
+	case RINGBUF_TYPE_TIME_EXTEND_ABS:
 		return RB_LEN_TIME_EXTEND;
 
-	case RINGBUF_TYPE_TIME_STAMP:
-		return RB_LEN_TIME_STAMP;
-
 	case RINGBUF_TYPE_DATA:
 		return rb_event_data_length(event);
 	default:
@@ -209,7 +209,8 @@ static void rb_event_set_padding(struct ring_buffer_event *event)
 {
 	unsigned len = 0;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND ||
+	    event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS) {
 		/* time extends include the data event after it */
 		len = RB_LEN_TIME_EXTEND;
 		event = skip_time_extend(event);
@@ -231,7 +232,8 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 {
 	unsigned length;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND ||
+	    event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS)
 		event = skip_time_extend(event);
 
 	length = rb_event_length(event);
@@ -248,7 +250,8 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 static __always_inline void *
 rb_event_data(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND ||
+	    event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS)
 		event = skip_time_extend(event);
 	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
@@ -483,6 +486,7 @@ struct ring_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
+	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1377,6 +1381,16 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
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
@@ -2207,13 +2221,16 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 }
 
 /* Slow path, do not inline */
-static noinline struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
+static struct noinline ring_buffer_event *
+rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 {
-	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
+	if (abs)
+		event->type_len = RINGBUF_TYPE_TIME_EXTEND_ABS;
+	else
+		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
-	/* Not the first event on the page? */
-	if (rb_event_index(event)) {
+	/* Not the first event on the page, or not delta? */
+	if (abs || rb_event_index(event)) {
 		event->time_delta = delta & TS_MASK;
 		event->array[0] = delta >> TS_SHIFT;
 	} else {
@@ -2256,7 +2273,9 @@ static inline bool rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the resevered space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		event = rb_add_time_stamp(event, delta);
+		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+
+		event = rb_add_time_stamp(event, info->delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
 	}
@@ -2444,7 +2463,8 @@ static __always_inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer
 
 static inline void rb_event_discard(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND ||
+	    event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS)
 		event = skip_time_extend(event);
 
 	/* array[0] holds the actual length for the discarded event */
@@ -2475,6 +2495,10 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 {
 	u64 delta;
 
+	/* Ignore write_stamp if TIME_EXTEND_ABS */
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS)
+		return;
+
 	/*
 	 * The event first in the commit queue updates the
 	 * time stamp.
@@ -2492,8 +2516,7 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 			delta <<= TS_SHIFT;
 			delta += event->time_delta;
 			cpu_buffer->write_stamp += delta;
-		} else
-			cpu_buffer->write_stamp += event->time_delta;
+		}
 	}
 }
 
@@ -2674,7 +2697,7 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (!tail)
+	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
 		info->delta = 0;
 
 	/* See if we shot pass the end of this buffer page */
@@ -2752,8 +2775,11 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 	/* make sure this diff is calculated here */
 	barrier();
 
-	/* Did the write stamp get updated already? */
-	if (likely(info.ts >= cpu_buffer->write_stamp)) {
+	if (ring_buffer_time_stamp_abs(buffer)) {
+		info.delta = info.ts;
+		rb_handle_timestamp(cpu_buffer, &info);
+	} else /* Did the write stamp get updated already? */
+		if (likely(info.ts >= cpu_buffer->write_stamp)) {
 		info.delta = diff;
 		if (unlikely(test_time_stamp(info.delta)))
 			rb_handle_timestamp(cpu_buffer, &info);
@@ -3429,8 +3455,8 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 		cpu_buffer->read_stamp += delta;
 		return;
 
-	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+	case RINGBUF_TYPE_TIME_EXTEND_ABS:
+		/* Ignore read_stamp if TIME_EXTEND_ABS */
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3460,8 +3486,8 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 		iter->read_stamp += delta;
 		return;
 
-	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+	case RINGBUF_TYPE_TIME_EXTEND_ABS:
+		/* Ignore read_stamp if TIME_EXTEND_ABS */
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3677,6 +3703,17 @@ static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
 	return cpu_buffer->lost_events;
 }
 
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
+{
+	u64 ts;
+
+	ts = event->array[0];
+	ts <<= TS_SHIFT;
+	ts += event->time_delta;
+
+	return ts;
+}
+
 static struct ring_buffer_event *
 rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 	       unsigned long *lost_events)
@@ -3685,6 +3722,9 @@ static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *reader;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
+
  again:
 	/*
 	 * We repeat when a time extend is encountered.
@@ -3720,13 +3760,18 @@ static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
 		rb_advance_reader(cpu_buffer);
 		goto again;
 
-	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+	case RINGBUF_TYPE_TIME_EXTEND_ABS:
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_reader(cpu_buffer);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = cpu_buffer->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
@@ -3751,6 +3796,9 @@ static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
+
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
 
@@ -3802,13 +3850,18 @@ static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
 		rb_advance_iter(iter);
 		goto again;
 
-	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+	case RINGBUF_TYPE_TIME_EXTEND_ABS:
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_iter(iter);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = iter->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(buffer,
 							 cpu_buffer->cpu, ts);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4589b67..5868656 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2090,7 +2090,7 @@ struct ring_buffer_event *
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -5967,6 +5967,29 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
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
index afbec96..12bc7fa 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -278,6 +278,8 @@ enum {
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
1.9.3
