From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 15/21] tracing: Add usecs modifier for hist trigger timestamps
Date: Wed,  8 Feb 2017 11:25:11 -0600
Message-ID: <047d224e45df7d22363630d21353d8db69b2ff59.1486569306.git.tom.zanussi@linux.intel.com>
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

Appending .usecs onto a common_timestamp field will cause the
timestamp value to be in microseconds instead of the default
nanoseconds.  A typical latency histogram using usecs would look like
this:

   # echo 'hist:keys=pid,prio:ts0=common_timestamp.usecs ...
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-ts0 ...

This also adds an external trace_clock_in_ns() to trace.c for the
timestamp conversion.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c             |  8 ++++++++
 kernel/trace/trace.h             |  2 ++
 kernel/trace/trace_events_hist.c | 33 ++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 78dff2f..f2a3b9c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1172,6 +1172,14 @@ unsigned long nsecs_to_usecs(unsigned long nsecs)
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
index f2af21b..1d0991b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -280,6 +280,8 @@ enum {
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 
+extern bool trace_clock_in_ns(struct trace_array *tr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c0a2ce8..13d67d3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -163,14 +163,6 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
-static u64 hist_field_timestamp(struct hist_field *hist_field,
-				struct tracing_map_elt *elt,
-				struct ring_buffer_event *rbe,
-				void *event)
-{
-	return ring_buffer_event_time_stamp(rbe);
-}
-
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
 				     struct tracing_map_elt *elt,	\
@@ -223,6 +215,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_VAR_REF		= 4096,
 	HIST_FIELD_FL_EXPR		= 8192,
 	HIST_FIELD_FL_TIMESTAMP		= 16384,
+	HIST_FIELD_FL_TIMESTAMP_USECS	= 32768,
 };
 
 struct hist_trigger_attrs {
@@ -235,6 +228,7 @@ struct hist_trigger_attrs {
 	bool		pause;
 	bool		cont;
 	bool		clear;
+	bool		ts_in_usecs;
 	unsigned int	map_bits;
 };
 
@@ -255,6 +249,22 @@ struct hist_trigger_data {
 	bool				enable_timestamps;
 };
 
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_trigger_data *hist_data = elt->map->private_data;
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
 static LIST_HEAD(hist_var_list);
 
 struct hist_var_data {
@@ -620,7 +630,6 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 
 	while (trigger_str) {
 		char *str = strsep(&trigger_str, ":");
-
 		if (strchr(str, '=')) {
 			ret = parse_assignment(str, attrs);
 			if (ret)
@@ -948,6 +957,8 @@ static struct hist_field *parse_var_ref(char *var_name)
 			*flags |= HIST_FIELD_FL_SYSCALL;
 		else if (strcmp(field_str, "log2") == 0)
 			*flags |= HIST_FIELD_FL_LOG2;
+		else if (strcmp(field_str, "usecs") == 0)
+			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else
 			return ERR_PTR(-EINVAL);
 	}
@@ -955,6 +966,8 @@ static struct hist_field *parse_var_ref(char *var_name)
 	if (strcmp(field_name, "common_timestamp") == 0) {
 		*flags |= HIST_FIELD_FL_TIMESTAMP;
 		hist_data->enable_timestamps = true;
+		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+			hist_data->attrs->ts_in_usecs = true;
 	} else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field)
@@ -1949,6 +1962,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "syscall";
 	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
 		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
 
 	return flags_str;
 }
-- 
1.9.3
