From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v4 20/37] tracing: Pass tracing_map_elt to hist_field accessor functions
Date: Mon, 30 Oct 2017 15:52:02 -0500
Message-ID: <4016abfa010130bf9ab852096ea029b506d9719f.1509395596.git.tom.zanussi@linux.intel.com>
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

Some accessor functions, such as for variable references, require
access to a corrsponding tracing_map_elt.

Add a tracing_map_elt param to the function signature and update the
accessor functions accordingly.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 91 +++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4055187..8c6e062 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -26,8 +26,10 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
-				struct ring_buffer_event *rbe);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
@@ -59,28 +61,36 @@ struct hist_field {
 	char				*name;
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_none(struct hist_field *field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event,
-			      struct ring_buffer_event *rbe)
+static u64 hist_field_counter(struct hist_field *field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event,
-			     struct ring_buffer_event *rbe)
+static u64 hist_field_string(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct ring_buffer_event *rbe,
+			     void *event)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
+static u64 hist_field_dynstring(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -89,54 +99,64 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
-			      struct ring_buffer_event *rbe)
+static u64 hist_field_pstring(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_log2(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event, rbe);
+	u64 val = operand->fn(operand, elt, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
-static u64 hist_field_plus(struct hist_field *hist_field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_plus(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, event, rbe);
-	u64 val2 = operand2->fn(operand2, event, rbe);
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
 
 	return val1 + val2;
 }
 
-static u64 hist_field_minus(struct hist_field *hist_field, void *event,
-			    struct ring_buffer_event *rbe)
+static u64 hist_field_minus(struct hist_field *hist_field,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, event, rbe);
-	u64 val2 = operand2->fn(operand2, event, rbe);
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
 
 	return val1 - val2;
 }
 
-static u64 hist_field_unary_minus(struct hist_field *hist_field, void *event,
-				  struct ring_buffer_event *rbe)
+static u64 hist_field_unary_minus(struct hist_field *hist_field,
+				  struct tracing_map_elt *elt,
+				  struct ring_buffer_event *rbe,
+				  void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	s64 sval = (s64)operand->fn(operand, event, rbe);
+	s64 sval = (s64)operand->fn(operand, elt, rbe, event);
 	u64 val = (u64)-sval;
 
 	return val;
@@ -144,8 +164,9 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field, void *event,
 
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
-				     void *event,			\
-				     struct ring_buffer_event *rbe)	\
+				     struct tracing_map_elt *elt,	\
+				     struct ring_buffer_event *rbe,	\
+				     void *event)			\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -233,8 +254,10 @@ struct hist_trigger_data {
 	bool				remove;
 };
 
-static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
@@ -1593,7 +1616,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rbe, rec);
+		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
@@ -1605,7 +1628,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 	for_each_hist_key_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_val = hist_field->fn(hist_field, rbe, rec);
+			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
 		}
@@ -1643,9 +1666,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	bool use_compound_key = (hist_data->n_keys > 1);
 	unsigned long entries[HIST_STACKTRACE_DEPTH];
 	char compound_key[HIST_KEY_SIZE_MAX];
+	struct tracing_map_elt *elt = NULL;
 	struct stack_trace stacktrace;
 	struct hist_field *key_field;
-	struct tracing_map_elt *elt;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -1666,7 +1689,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec, rbe);
+			field_contents = key_field->fn(key_field, elt, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
-- 
1.9.3
