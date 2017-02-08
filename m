From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 05/21] tracing: Add ring buffer event param to hist field functions
Date: Wed,  8 Feb 2017 11:25:01 -0600
Message-ID: <6857ec4858623e98afb0f3d52476b3f75169189b.1486569306.git.tom.zanussi@linux.intel.com>
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

Some events such as timestamps require access to a ring_buffer_event
struct; add a param so that hist field functions can access that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 902df2c..38faa08 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -25,7 +25,8 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
+				struct ring_buffer_event *rbe);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 
@@ -39,24 +40,28 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event)
+static u64 hist_field_none(struct hist_field *field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event)
+static u64 hist_field_counter(struct hist_field *field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event)
+static u64 hist_field_string(struct hist_field *hist_field, void *event,
+			     struct ring_buffer_event *rbe)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
+				struct ring_buffer_event *rbe)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -65,24 +70,28 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event)
+static u64 hist_field_log2(struct hist_field *hist_field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event);
+	u64 val = operand->fn(operand, event, rbe);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
 #define DEFINE_HIST_FIELD_FN(type)					\
-static u64 hist_field_##type(struct hist_field *hist_field, void *event)\
+	static u64 hist_field_##type(struct hist_field *hist_field,	\
+				     void *event,			\
+				     struct ring_buffer_event *rbe)	\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -869,8 +878,8 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt,
-				    void *rec)
+				    struct tracing_map_elt *elt, void *rec,
+				    struct ring_buffer_event *rbe)
 {
 	struct hist_field *hist_field;
 	unsigned int i;
@@ -878,7 +887,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec);
+		hist_val = hist_field->fn(hist_field, rec, rbe);
 		tracing_map_update_sum(elt, i, hist_val);
 	}
 }
@@ -908,7 +917,7 @@ static inline void add_to_key(char *compound_key, void *key,
 }
 
 static void event_hist_trigger(struct event_trigger_data *data, void *rec,
-			       struct ring_buffer_event *event)
+			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
@@ -937,7 +946,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec);
+			field_contents = key_field->fn(key_field, rec, rbe);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -954,7 +963,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 	elt = tracing_map_insert(hist_data->map, key);
 	if (elt)
-		hist_trigger_elt_update(hist_data, elt, rec);
+		hist_trigger_elt_update(hist_data, elt, rec, rbe);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
-- 
1.9.3
