From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v4 29/37] tracing: Add cpu field for hist triggers
Date: Mon, 30 Oct 2017 15:52:11 -0500
Message-ID: <8b2694d02d23570a94cc4d91bca659287794a464.1509395596.git.tom.zanussi@linux.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509395595.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1509395595.git.tom.zanussi@linux.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A common key to use in a histogram is the cpuid - add a new cpu
'synthetic' field for that purpose.  This field is named cpu rather
than $cpu or $common_cpu because 'cpu' already exists as a special
filter field and it makes more sense to match that rather than add
another name for the same thing.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.txt | 17 +++++++++++++++++
 kernel/trace/trace_events_hist.c  | 28 +++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index d1d92ed..cd3ec00 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -172,6 +172,23 @@
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
+  'special' event fields
+  ------------------------
+
+  There are a number of 'special event fields' available for use as
+  keys or values in a hist trigger.  These look like and behave as if
+  they were actual event fields, but aren't really part of the event's
+  field definition or format file.  They are however available for any
+  event, and can be used anywhere an actual event field could be.
+  'Special' field names are always prefixed with a '$' character to
+  indicate that they're not normal fields (with the exception of
+  'cpu', for compatibility with existing filter usage):
+
+    $common_timestamp      u64 - timestamp (from ring buffer) associated
+                                 with the event, in nanoseconds.  May be
+				 modified by .usecs to have timestamps
+				 interpreted as microseconds.
+    cpu                    int - the cpu on which the event occurred.
 
 6.2 'hist' trigger examples
 ---------------------------
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 13f653f..2238d51 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -227,6 +227,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_VAR		= 1 << 12,
 	HIST_FIELD_FL_EXPR		= 1 << 13,
 	HIST_FIELD_FL_VAR_REF		= 1 << 14,
+	HIST_FIELD_FL_CPU		= 1 << 15,
 };
 
 struct var_defs {
@@ -1177,6 +1178,16 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	return ts;
 }
 
+static u64 hist_field_cpu(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	int cpu = smp_processor_id();
+
+	return cpu;
+}
+
 static struct hist_field *
 check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
@@ -1617,6 +1628,8 @@ static const char *hist_field_name(struct hist_field *field,
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "$common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_CPU)
+		field_name = "cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
@@ -2120,6 +2133,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	if (flags & HIST_FIELD_FL_CPU) {
+		hist_field->fn = hist_field_cpu;
+		hist_field->size = sizeof(int);
+		hist_field->type = kstrdup("int", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!field))
 		goto out;
 
@@ -2338,7 +2360,9 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 		hist_data->enable_timestamps = true;
 		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 			hist_data->attrs->ts_in_usecs = true;
-	} else {
+	} else if (strcmp(field_name, "cpu") == 0)
+		*flags |= HIST_FIELD_FL_CPU;
+	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
 			field = ERR_PTR(-EINVAL);
@@ -4607,6 +4631,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
 		seq_puts(m, "$common_timestamp");
+	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+		seq_puts(m, "cpu");
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
 			seq_putc(m, '$');
-- 
1.9.3
