From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 09/21] tracing: Add hist trigger timestamp support
Date: Wed,  8 Feb 2017 11:25:05 -0600
Message-ID: <8781998ccd0678ef5ddf1cc7720a9586806b44ae.1486569306.git.tom.zanussi@linux.intel.com>
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

Add support for a timestamp event field.  This is actually a 'pseudo-'
event field in that it behaves like it's part of the event record, but
is really part of the corresponding ring buffer event.

To make use of the timestamp field, users can specify "common_timestamp"
as a field name for any histogram.  Note that this doesn't make much
sense on its own either as either a key or value, but needs to be
supported even so, since follow-on patches will add support for making
use of this field in time deltas.

Note that the use of this field requires the ring buffer be put into
TIME_EXTEND_ABS mode, which saves the complete timestamp for each
event rather than an offset.  This mode will be enabled if and only if
a histogram makes use of the "common_timestamp" field.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 85 +++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4e70872..8d7f7dd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -88,6 +88,12 @@ static u64 hist_field_log2(struct hist_field *hist_field, void *event,
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
+static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
+				struct ring_buffer_event *rbe)
+{
+	return ring_buffer_event_time_stamp(rbe);
+}
+
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
 				     void *event,			\
@@ -134,6 +140,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_SYSCALL		= 128,
 	HIST_FIELD_FL_STACKTRACE	= 256,
 	HIST_FIELD_FL_LOG2		= 512,
+	HIST_FIELD_FL_TIMESTAMP		= 1024,
 };
 
 struct hist_trigger_attrs {
@@ -158,6 +165,7 @@ struct hist_trigger_data {
 	struct trace_event_file		*event_file;
 	struct hist_trigger_attrs	*attrs;
 	struct tracing_map		*map;
+	bool				enable_timestamps;
 };
 
 static const char *hist_field_name(struct hist_field *field)
@@ -404,6 +412,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	hist_field = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
 	if (!hist_field)
 		return NULL;
+	hist_field->is_signed = false;
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
@@ -423,6 +432,12 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 		goto out;
 	}
 
+	if (flags & HIST_FIELD_FL_TIMESTAMP) {
+		hist_field->fn = hist_field_timestamp;
+		hist_field->size = sizeof(u64);
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!field))
 		goto out;
 
@@ -500,10 +515,15 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	field = trace_find_event_field(file->event_call, field_name);
-	if (!field) {
-		ret = -EINVAL;
-		goto out;
+	if (strcmp(field_name, "common_timestamp") == 0) {
+		flags |= HIST_FIELD_FL_TIMESTAMP;
+		hist_data->enable_timestamps = true;
+	} else {
+		field = trace_find_event_field(file->event_call, field_name);
+		if (!field) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	hist_data->fields[val_idx] = create_hist_field(field, flags);
@@ -598,16 +618,22 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			}
 		}
 
-		field = trace_find_event_field(file->event_call, field_name);
-		if (!field) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (strcmp(field_name, "common_timestamp") == 0) {
+			flags |= HIST_FIELD_FL_TIMESTAMP;
+			hist_data->enable_timestamps = true;
+			key_size = sizeof(u64);
+		} else {
+			field = trace_find_event_field(file->event_call, field_name);
+			if (!field) {
+				ret = -EINVAL;
+				goto out;
+			}
 
-		if (is_string_field(field))
-			key_size = MAX_FILTER_STR_VAL;
-		else
-			key_size = field->size;
+			if (is_string_field(field))
+				key_size = MAX_FILTER_STR_VAL;
+			else
+				key_size = field->size;
+		}
 	}
 
 	hist_data->fields[key_idx] = create_hist_field(field, flags);
@@ -744,7 +770,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			break;
 		}
 
-		if (strcmp(field_name, "hitcount") == 0) {
+		if ((strcmp(field_name, "hitcount") == 0)) {
 			descending = is_descending(field_str);
 			if (descending < 0) {
 				ret = descending;
@@ -802,6 +828,9 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 
 			if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
 				cmp_fn = tracing_map_cmp_none;
+			else if (!field)
+				cmp_fn = tracing_map_cmp_num(hist_field->size,
+							     hist_field->is_signed);
 			else if (is_string_field(field))
 				cmp_fn = tracing_map_cmp_string;
 			else
@@ -1231,6 +1260,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE)
 			seq_puts(m, "stacktrace");
+		else if (key_field->flags & HIST_FIELD_FL_TIMESTAMP)
+			seq_puts(m, "common_timestamp");
 		else
 			hist_field_print(m, key_field);
 	}
@@ -1240,6 +1271,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 	for_each_hist_val_field(i, hist_data) {
 		if (i == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
+		else if (hist_data->fields[i]->flags & HIST_FIELD_FL_TIMESTAMP)
+			seq_puts(m, "common_timestamp");
 		else {
 			seq_puts(m, ",");
 			hist_field_print(m, hist_data->fields[i]);
@@ -1250,27 +1283,27 @@ static int event_hist_trigger_print(struct seq_file *m,
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
 		struct tracing_map_sort_key *sort_key;
+		unsigned int idx;
 
 		sort_key = &hist_data->sort_keys[i];
+		idx = sort_key->field_idx;
+
+		if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
+			return -EINVAL;
 
 		if (i > 0)
 			seq_puts(m, ",");
 
-		if (sort_key->field_idx == HITCOUNT_IDX)
+		if (idx == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
-		else {
-			unsigned int idx = sort_key->field_idx;
-
-			if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
-				return -EINVAL;
-
+		else if (hist_data->fields[idx]->flags & HIST_FIELD_FL_TIMESTAMP)
+			seq_puts(m, "common_timestamp");
+		else
 			hist_field_print(m, hist_data->fields[idx]);
-		}
 
 		if (sort_key->descending)
 			seq_puts(m, ".descending");
 	}
-
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
 
 	if (data->filter_str)
@@ -1438,6 +1471,10 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->offset != key_field_test->offset)
 			return false;
+		if (key_field->size != key_field_test->size)
+			return false;
+		if (key_field->is_signed != key_field_test->is_signed)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
@@ -1520,6 +1557,8 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 
 	update_cond_flag(file);
 
+	tracing_set_time_stamp_abs(file->tr, true);
+
 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
-- 
1.9.3
