From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 27/32] tracing: Add cpu field for hist triggers
Date: Mon, 26 Jun 2017 17:49:28 -0500
Message-ID: <d239cea632a0efefff42dcc14ee24c3b4d4acf25.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44464 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdFZWus (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:50:48 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A common key to use in a histogram is the cpuid - add a new cpu
'synthetic' field for that purpose.  This field is named cpu rather
than $cpu or $common_cpu because 'cpu' already exists as a special
filter field and it makes more sense to match that rather than add
another name for the same thing.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/events.txt   | 18 ++++++++++++++++++
 kernel/trace/trace_events_hist.c | 30 +++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 2cc08d4..9717688 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -668,6 +668,24 @@ The following commands are supported:
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
+  'synthetic' event fields
+  ------------------------
+
+  There are a number of 'synthetic fields' available for use as keys
+  or values in a hist trigger.  These look like and behave as if they
+  were event fields, but aren't actually part of the event's field
+  definition or format file.  They are however available for any
+  event, and can be used anywhere an actual event field could be.
+  'Synthetic' field names are always prefixed with a '$' character to
+  indicate that they're not normal fields (with the exception of
+  'cpu', for compatibility with existing filter usage):
+
+    $common_timestamp      u64 - timestamp (from ring buffer) associated
+                                 with the event, in nanoseconds.  May be
+				 modified by .usecs to have timestamps
+				 interpreted as microseconds.
+    cpu                    int - the cpu on which the event occurred.
+
 
 6.2 'hist' trigger examples
 ---------------------------
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ab94e2a..904a635 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -224,6 +224,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_VAR_ONLY		= 8192,
 	HIST_FIELD_FL_EXPR		= 16384,
 	HIST_FIELD_FL_VAR_REF		= 32768,
+	HIST_FIELD_FL_CPU		= 65536,
 };
 
 struct hist_trigger_attrs {
@@ -1081,6 +1082,16 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	return ts;
 }
 
+static u64 hist_field_cpu(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return cpu;
+}
+
 static struct hist_field *check_var_ref(struct hist_field *hist_field,
 					struct hist_trigger_data *var_data,
 					unsigned int var_idx)
@@ -1407,6 +1418,8 @@ static const char *hist_field_name(struct hist_field *field,
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "$common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_CPU)
+		field_name = "cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
 		 field->flags & HIST_FIELD_FL_VAR_REF)
 		field_name = field->name;
@@ -1848,6 +1861,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
 
@@ -1980,7 +2002,9 @@ static struct hist_field *parse_var_ref(char *system, char *event_name,
 		hist_data->enable_timestamps = true;
 		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 			hist_data->attrs->ts_in_usecs = true;
-	} else {
+	} else if (strcmp(field_name, "cpu") == 0)
+		*flags |= HIST_FIELD_FL_CPU;
+	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field)
 			return ERR_PTR(-EINVAL);
@@ -3019,7 +3043,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 				goto out;
 			}
 		}
-
 		if (param[0] == '$')
 			hist_field = onmatch_find_var(hist_data, data, system,
 						      event_name, param);
@@ -3034,7 +3057,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 			ret = -EINVAL;
 			goto out;
 		}
-
 		if (check_synth_field(event, hist_field, field_pos) == 0) {
 			var_ref = create_var_ref(hist_field);
 			if (!var_ref) {
@@ -4128,6 +4150,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
 		seq_puts(m, "$common_timestamp");
+	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+		seq_puts(m, "cpu");
 	else if (field_name)
 		seq_printf(m, "%s", field_name);
 
-- 
1.9.3

