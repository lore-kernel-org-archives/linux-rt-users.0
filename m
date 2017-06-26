From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 15/32] tracing: Add usecs modifier for hist trigger timestamps
Date: Mon, 26 Jun 2017 17:49:16 -0500
Message-ID: <dbbf8ec03984f980936e3c873f94a2e1be00781b.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Appending .usecs onto a common_timestamp field will cause the
timestamp value to be in microseconds instead of the default
nanoseconds.  A typical latency histogram using usecs would look like
this:

   # echo 'hist:keys=pid,prio:ts0=$common_timestamp.usecs ...
   # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0 ...

This also adds an external trace_clock_in_ns() to trace.c for the
timestamp conversion.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c             |  8 ++++++++
 kernel/trace/trace.h             |  2 ++
 kernel/trace/trace_events_hist.c | 28 ++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f66a3df..ec84822 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1170,6 +1170,14 @@ unsigned long nsecs_to_usecs(unsigned long nsecs)
 	ARCH_TRACE_CLOCKS
 };
 
+bool trace_clock_in_ns(struct trace_array *tr)
+{
+	if (trace_clocks[tr->clock_id].in_ns)
+		return true;
+
+	return false;
+}
+
 /*
  * trace_parser_get_init - gets the buffer for trace parser
  */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 81b1d07..65f90b4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -283,6 +283,8 @@ enum {
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 
+extern bool trace_clock_in_ns(struct trace_array *tr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fb08a75..5c351d7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -90,12 +90,6 @@ static u64 hist_field_log2(struct hist_field *hist_field, void *event,
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
-static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
-{
-	return ring_buffer_event_time_stamp(rbe);
-}
-
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
 				     void *event,			\
@@ -143,6 +137,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_STACKTRACE	= 256,
 	HIST_FIELD_FL_LOG2		= 512,
 	HIST_FIELD_FL_TIMESTAMP		= 1024,
+	HIST_FIELD_FL_TIMESTAMP_USECS	= 2048,
 };
 
 struct hist_trigger_attrs {
@@ -153,6 +148,7 @@ struct hist_trigger_attrs {
 	bool		pause;
 	bool		cont;
 	bool		clear;
+	bool		ts_in_usecs;
 	unsigned int	map_bits;
 };
 
@@ -170,6 +166,20 @@ struct hist_trigger_data {
 	bool				enable_timestamps;
 };
 
+static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
+				struct ring_buffer_event *rbe)
+{
+	struct hist_trigger_data *hist_data = hist_field->hist_data;
+	struct trace_array *tr = hist_data->event_file->tr;
+
+	u64 ts = ring_buffer_event_time_stamp(rbe);
+
+	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
+		ts = ns2usecs(ts);
+
+	return ts;
+}
+
 static const char *hist_field_name(struct hist_field *field,
 				   unsigned int level)
 {
@@ -629,6 +639,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 				flags |= HIST_FIELD_FL_SYSCALL;
 			else if (strcmp(field_str, "log2") == 0)
 				flags |= HIST_FIELD_FL_LOG2;
+			else if (strcmp(field_str, "usecs") == 0)
+				flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 			else {
 				ret = -EINVAL;
 				goto out;
@@ -638,6 +650,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		if (strcmp(field_name, "$common_timestamp") == 0) {
 			flags |= HIST_FIELD_FL_TIMESTAMP;
 			hist_data->enable_timestamps = true;
+			if (flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+				hist_data->attrs->ts_in_usecs = true;
 			key_size = sizeof(u64);
 		} else {
 			field = trace_find_event_field(file->event_call, field_name);
@@ -1239,6 +1253,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "syscall";
 	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
 		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
 
 	return flags_str;
 }
-- 
1.9.3
