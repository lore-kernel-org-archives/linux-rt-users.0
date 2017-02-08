From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 14/21] tracing: Add variable reference handling to hist triggers
Date: Wed,  8 Feb 2017 11:25:10 -0600
Message-ID: <d4be2ca8c9ab9af19b1783401d09044194531694.1486569306.git.tom.zanussi@linux.intel.com>
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

Add the necessary infrastructure to allow the variables defined on one
event to be referenced in another.  This allows variables set by a
previous event to be referenced and used in expressions combining the
variable values saved by that previous event and the event fields of
the current event.  For example, here's how a latency can be
calculated and saved into yet another variable named 'wakeup_lat':

    # echo 'hist:keys=pid,prio:ts0=common_timestamp ...
    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-ts0 ...

In the first event, the event's timetamp is saved into the variable
ts0.  In the next line, ts0 is subtracted from the second event's
timestamp to produce the latency.

Further users of variable references will be described in subsequent
patches, such as for instance how the 'wakeup_lat' variable above can
be displayed in a latency histogram.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 742 +++++++++++++++++++++++++++++----------
 1 file changed, 556 insertions(+), 186 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cea95b6..c0a2ce8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -25,8 +25,10 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
-				struct ring_buffer_event *rbe);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_ASSIGNMENT_MAX	4
@@ -38,6 +40,11 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+struct hist_var_ref {
+	struct hist_trigger_data	*hist_data;
+	unsigned int			idx;
+};
+
 struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
@@ -45,35 +52,46 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int			is_signed;
-	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
-	u64				var_val;
+	struct hist_var_ref		var_ref;
+	unsigned int			var_ref_idx;
 	char				*var_name;
+	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	enum field_op_id		operator;
 	char				*name;
+	u64				var_val;
+	unsigned int			var_idx;
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
@@ -82,75 +100,82 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
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
 
-static u64 hist_field_var_val(struct hist_field *hist_field, void *event,
-			      struct ring_buffer_event *rbe)
-{
-	return hist_field->var_val;
-}
-
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
 
-static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	return ring_buffer_event_time_stamp(rbe);
 }
 
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
@@ -195,8 +220,9 @@ enum hist_field_flags {
 	HIST_FIELD_FL_LOG2		= 512,
 	HIST_FIELD_FL_VAR		= 1024,
 	HIST_FIELD_FL_VAR_ONLY		= 2048,
-	HIST_FIELD_FL_EXPR		= 4096,
-	HIST_FIELD_FL_TIMESTAMP		= 8192,
+	HIST_FIELD_FL_VAR_REF		= 4096,
+	HIST_FIELD_FL_EXPR		= 8192,
+	HIST_FIELD_FL_TIMESTAMP		= 16384,
 };
 
 struct hist_trigger_attrs {
@@ -214,9 +240,12 @@ struct hist_trigger_attrs {
 
 struct hist_trigger_data {
 	struct hist_field               *fields[TRACING_MAP_FIELDS_MAX];
+	struct hist_field               *var_refs[TRACING_MAP_VARS_MAX];
 	unsigned int			n_vals;
 	unsigned int			n_keys;
 	unsigned int			n_fields;
+	unsigned int			n_vars;
+	unsigned int			n_var_refs;
 	unsigned int			key_size;
 	struct tracing_map_sort_key	sort_keys[TRACING_MAP_SORT_KEYS_MAX];
 	unsigned int			n_sort_keys;
@@ -226,6 +255,224 @@ struct hist_trigger_data {
 	bool				enable_timestamps;
 };
 
+static LIST_HEAD(hist_var_list);
+
+struct hist_var_data {
+	struct list_head list;
+	struct hist_trigger_data *hist_data;
+};
+
+static struct hist_field *check_var_ref(struct hist_field *hist_field,
+					struct hist_trigger_data *var_data,
+					unsigned int var_idx)
+{
+	struct hist_field *found = NULL;
+
+	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (hist_field->var_ref.idx == var_idx &&
+		    hist_field->var_ref.hist_data == var_data) {
+			found = hist_field;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
+				       struct hist_trigger_data *var_data,
+				       unsigned int var_idx)
+{
+	struct hist_field *hist_field, *found = NULL;
+	unsigned int i, j;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		found = check_var_ref(hist_field, var_data, var_idx);
+		if (found)
+			return found;
+
+		for (j = 0; j < HIST_FIELD_OPERANDS_MAX; j++) {
+			struct hist_field *operand;
+			operand = hist_field->operands[j];
+			found = check_var_ref(operand, var_data, var_idx);
+			if (found)
+				return found;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
+					   unsigned int var_idx)
+{
+	struct hist_field *found = NULL;
+	struct hist_var_data *var_data;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		found = find_var_ref(var_data->hist_data, hist_data, var_idx);
+		if (found)
+			break;
+	}
+
+	return found;
+}
+
+static bool check_var_refs(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *field;
+	bool found = false;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		field = hist_data->fields[i];
+		if (field && field->flags & HIST_FIELD_FL_VAR) {
+			if (find_any_var_ref(hist_data, field->var_ref.idx)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	return found;
+}
+
+static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data, *found = NULL;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		if (var_data->hist_data == hist_data) {
+			found = var_data;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static bool has_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *hist_field;
+	bool found = false;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static int save_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (var_data)
+		return 0;
+
+	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
+	if (!var_data)
+		return -ENOMEM;
+
+	var_data->hist_data = hist_data;
+	list_add(&var_data->list, &hist_var_list);
+
+	return 0;
+}
+
+static int remove_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (!var_data)
+		return -EINVAL;
+
+	if (check_var_refs(hist_data))
+		return -EINVAL;
+
+	list_del(&var_data->list);
+
+	return 0;
+}
+
+static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
+					 char *var_name)
+{
+	struct hist_field *hist_field, *found = NULL;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR) {
+			if (strcmp(hist_field->var_name, var_name) == 0) {
+				found = hist_field;
+				break;
+			}
+		}
+	}
+
+	return found;
+}
+
+struct hist_elt_data {
+	char *comm;
+	u64 *var_ref_vals;
+};
+
+static u64 hist_field_var_ref(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
+{
+	struct hist_elt_data *elt_data;
+	u64 var_val = 0;
+
+	elt_data = elt->private_data;
+	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
+
+	return var_val;
+}
+
+static bool resolve_var_refs(struct hist_trigger_data *hist_data,
+			     void *key,
+			     u64 *var_ref_vals)
+{
+	struct hist_trigger_data *var_data;
+	struct tracing_map_elt *var_elt;
+	struct hist_field *hist_field;
+	bool resolved = true;
+	unsigned int i, var_idx;
+	u64 var_val = 0;
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		var_idx = hist_field->var_ref.idx;
+		var_data = hist_field->var_ref.hist_data;
+
+		var_elt = tracing_map_lookup(var_data->map, key);
+		if (!var_elt) {
+			resolved = false;
+			break;
+		}
+		if (!tracing_map_var_set(var_elt, var_idx)) {
+			resolved = false;
+			break;
+		}
+
+		var_val = tracing_map_read_var(var_elt, var_idx);
+		var_ref_vals[i] = var_val;
+	}
+
+	return resolved;
+}
+
 static const char *hist_field_name(struct hist_field *field)
 {
 	const char *field_name = NULL;
@@ -236,7 +483,8 @@ static const char *hist_field_name(struct hist_field *field)
 		field_name = hist_field_name(field->operands[0]);
 	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
-	else if (field->flags & HIST_FIELD_FL_EXPR)
+	else if (field->flags & HIST_FIELD_FL_EXPR ||
+		 field->flags & HIST_FIELD_FL_VAR_REF)
 		field_name = field->name;
 
 	return field_name;
@@ -417,26 +665,36 @@ static inline void save_comm(char *comm, struct task_struct *task)
 	memcpy(comm, task->comm, TASK_COMM_LEN);
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
-	kfree((char *)elt->private_data);
+	struct hist_elt_data *private_data = elt->private_data;
+
+	kfree(private_data->comm);
+	kfree(private_data);
 }
 
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN + 1;
+	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
 	unsigned int i;
 
+	elt->private_data = elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data)
+		return -ENOMEM;
+
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			unsigned int size = TASK_COMM_LEN + 1;
-
-			elt->private_data = kzalloc(size, GFP_KERNEL);
-			if (!elt->private_data)
+			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			if (!elt_data->comm) {
+				kfree(elt_data);
+				elt->private_data = NULL;
 				return -ENOMEM;
+			}
 			break;
 		}
 	}
@@ -444,67 +702,31 @@ static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
 	return 0;
 }
 
-static void hist_trigger_elt_comm_copy(struct tracing_map_elt *to,
+static void hist_trigger_elt_data_copy(struct tracing_map_elt *to,
 				       struct tracing_map_elt *from)
 {
-	char *comm_from = from->private_data;
-	char *comm_to = to->private_data;
+	struct hist_elt_data *from_data = from->private_data;
+	struct hist_elt_data *to_data = to->private_data;
 
-	if (comm_from)
-		memcpy(comm_to, comm_from, TASK_COMM_LEN + 1);
-}
+	memcpy(to_data, from_data, sizeof(*to));
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
-{
-	char *comm = elt->private_data;
-
-	if (comm)
-		save_comm(comm, current);
+	if (from_data->comm)
+		memcpy(to_data->comm, from_data->comm, TASK_COMM_LEN + 1);
 }
 
-static struct ftrace_event_field *
-parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
-	    char *field_str, unsigned long *flags)
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
-	struct ftrace_event_field *field = NULL;
-	char *field_name;
-
-	field_name = strsep(&field_str, ".");
-	if (field_str) {
-		if (strcmp(field_str, "hex") == 0)
-			*flags |= HIST_FIELD_FL_HEX;
-		else if (strcmp(field_str, "sym") == 0)
-			*flags |= HIST_FIELD_FL_SYM;
-		else if (strcmp(field_str, "sym-offset") == 0)
-			*flags |= HIST_FIELD_FL_SYM_OFFSET;
-		else if ((strcmp(field_str, "execname") == 0) &&
-			 (strcmp(field_name, "common_pid") == 0))
-			*flags |= HIST_FIELD_FL_EXECNAME;
-		else if (strcmp(field_str, "syscall") == 0)
-			*flags |= HIST_FIELD_FL_SYSCALL;
-		else if (strcmp(field_str, "log2") == 0)
-			*flags |= HIST_FIELD_FL_LOG2;
-		else
-			return ERR_PTR(-EINVAL);
-	}
+	struct hist_elt_data *private_data = elt->private_data;
 
-	if (strcmp(field_name, "common_timestamp") == 0) {
-		*flags |= HIST_FIELD_FL_TIMESTAMP;
-		hist_data->enable_timestamps = true;
-	} else {
-		field = trace_find_event_field(file->event_call, field_name);
-		if (!field)
-			return ERR_PTR(-EINVAL);
-	}
-
-	return field;
+	if (private_data->comm)
+		save_comm(private_data->comm, current);
 }
 
-static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
-	.elt_alloc	= hist_trigger_elt_comm_alloc,
-	.elt_copy	= hist_trigger_elt_comm_copy,
-	.elt_free	= hist_trigger_elt_comm_free,
-	.elt_init	= hist_trigger_elt_comm_init,
+static const struct tracing_map_ops hist_trigger_elt_data_ops = {
+	.elt_alloc	= hist_trigger_elt_data_alloc,
+	.elt_copy	= hist_trigger_elt_data_copy,
+	.elt_free	= hist_trigger_elt_data_free,
+	.elt_init	= hist_trigger_elt_data_init,
 };
 
 static char *expr_str(struct hist_field *field)
@@ -607,6 +829,11 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (flags & HIST_FIELD_FL_EXPR)
 		goto out; /* caller will populate */
 
+	if (flags & HIST_FIELD_FL_VAR_REF) {
+		hist_field->fn = hist_field_var_ref;
+		goto out;
+	}
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		goto out;
@@ -636,6 +863,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 
 	if (is_string_field(field)) {
 		flags |= HIST_FIELD_FL_STRING;
+		hist_field->size = MAX_FILTER_STR_VAL;
 
 		if (field->filter_type == FILTER_STATIC_STRING)
 			hist_field->fn = hist_field_string;
@@ -644,6 +872,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 		else
 			hist_field->fn = hist_field_pstring;
 	} else {
+		hist_field->size = field->size;
 		hist_field->fn = select_value_fn(field->size,
 						 field->is_signed);
 		if (!hist_field->fn) {
@@ -672,6 +901,101 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 	}
 }
 
+static struct hist_field *parse_var_ref(char *var_name)
+{
+	struct hist_var_data *var_data;
+	struct hist_field *var_field = NULL, *ref_field = NULL;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		var_field = find_var_field(var_data->hist_data, var_name);
+		if (var_field)
+			break;
+	}
+
+	if (var_field) {
+		unsigned long flags = HIST_FIELD_FL_VAR_REF;
+
+		ref_field = create_hist_field(NULL, flags, NULL);
+		if (ref_field) {
+			ref_field->var_ref.idx = var_field->var_ref.idx;
+			ref_field->var_ref.hist_data = var_data->hist_data;
+			ref_field->name = kstrdup(var_field->var_name, GFP_KERNEL);
+		}
+	}
+
+	return ref_field;
+}
+
+static struct ftrace_event_field *
+parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
+	    char *field_str, unsigned long *flags)
+{
+	struct ftrace_event_field *field = NULL;
+	char *field_name;
+
+	field_name = strsep(&field_str, ".");
+	if (field_str) {
+		if (strcmp(field_str, "hex") == 0)
+			*flags |= HIST_FIELD_FL_HEX;
+		else if (strcmp(field_str, "sym") == 0)
+			*flags |= HIST_FIELD_FL_SYM;
+		else if (strcmp(field_str, "sym-offset") == 0)
+			*flags |= HIST_FIELD_FL_SYM_OFFSET;
+		else if ((strcmp(field_str, "execname") == 0) &&
+			 (strcmp(field_name, "common_pid") == 0))
+			*flags |= HIST_FIELD_FL_EXECNAME;
+		else if (strcmp(field_str, "syscall") == 0)
+			*flags |= HIST_FIELD_FL_SYSCALL;
+		else if (strcmp(field_str, "log2") == 0)
+			*flags |= HIST_FIELD_FL_LOG2;
+		else
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (strcmp(field_name, "common_timestamp") == 0) {
+		*flags |= HIST_FIELD_FL_TIMESTAMP;
+		hist_data->enable_timestamps = true;
+	} else {
+		field = trace_find_event_field(file->event_call, field_name);
+		if (!field)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return field;
+}
+
+struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
+			      struct trace_event_file *file, char *str,
+			      unsigned long *flags, char *var_name)
+{
+	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field = NULL;
+	int ret = 0;
+
+	hist_field = parse_var_ref(str);
+	if (hist_field) {
+		hist_data->var_refs[hist_data->n_var_refs] = hist_field;
+		hist_field->var_ref_idx = hist_data->n_var_refs++;
+		return hist_field;
+	}
+
+	field = parse_field(hist_data, file, str, flags);
+	if (IS_ERR(field)) {
+		ret = PTR_ERR(field);
+		goto out;
+	}
+
+	hist_field = create_hist_field(field, *flags, var_name);
+	if (!hist_field) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	return hist_field;
+ out:
+	return ERR_PTR(ret);
+}
+
 static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file,
 				     char *str, unsigned long flags,
@@ -683,7 +1007,6 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 				      char *var_name)
 {
 	struct hist_field *operand1, *expr = NULL;
-	struct ftrace_event_field *field = NULL;
 	unsigned long operand_flags;
 	char *operand1_str;
 	int ret = 0;
@@ -729,15 +1052,10 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 
 	if (operand1 == NULL) {
 		operand_flags = 0;
-		field = parse_field(hist_data, file, operand1_str,
-				    &operand_flags);
-		if (IS_ERR(field)) {
-			ret = PTR_ERR(field);
-			goto free;
-		}
-		operand1 = create_hist_field(field, operand_flags, NULL);
-		if (!operand1) {
-			ret = -ENOMEM;
+		operand1 = parse_atom(hist_data, file, operand1_str,
+				      &operand_flags, NULL);
+		if (IS_ERR(operand1)) {
+			ret = PTR_ERR(operand1);
 			goto free;
 		}
 	}
@@ -757,8 +1075,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     char *str, unsigned long flags,
 				     char *var_name)
 {
-	struct hist_field *operand1, *operand2, *expr = NULL;
-	struct ftrace_event_field *field = NULL;
+	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
 	unsigned long operand_flags;
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
@@ -786,14 +1103,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 
 	operand_flags = 0;
-	field = parse_field(hist_data, file, operand1_str, &operand_flags);
-	if (IS_ERR(field)) {
-		ret = PTR_ERR(field);
-		goto free;
-	}
-	operand1 = create_hist_field(field, operand_flags, NULL);
-	if (!operand1) {
-		ret = -ENOMEM;
+	operand1 = parse_atom(hist_data, file, operand1_str,
+			      &operand_flags, NULL);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
 		operand1 = NULL;
 		goto free;
 	}
@@ -808,14 +1121,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	}
 	if (!operand2) {
 		operand_flags = 0;
-		field = parse_field(hist_data, file, str, &operand_flags);
-		if (IS_ERR(field)) {
-			ret = PTR_ERR(field);
-			goto free;
-		}
-		operand2 = create_hist_field(field, operand_flags, NULL);
-		if (!operand2) {
-			ret = -ENOMEM;
+		operand2 = parse_atom(hist_data, file, str,
+				      &operand_flags, NULL);
+		if (IS_ERR(operand2)) {
+			ret = PTR_ERR(operand2);
 			operand2 = NULL;
 			goto free;
 		}
@@ -873,7 +1182,6 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *field_str, char *var_name)
 {
-	struct ftrace_event_field *field = NULL;
 	struct hist_field *hist_field;
 	unsigned long flags = 0;
 	char *token;
@@ -893,7 +1201,8 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		}
 		var_name = token;
 		flags |= HIST_FIELD_FL_VAR;
-	}
+	} else
+		field_str = token;
 
 	hist_field = parse_expr(hist_data, file, field_str, flags, var_name);
 	if (IS_ERR(hist_field)) {
@@ -902,15 +1211,10 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	}
 
 	if (!hist_field) {
-		field = parse_field(hist_data, file, field_str, &flags);
-		if (IS_ERR(field)) {
-			ret = PTR_ERR(field);
-			goto out;
-		}
-
-		hist_field = create_hist_field(field, flags, var_name);
-		if (!hist_field) {
-			ret = -ENOMEM;
+		hist_field = parse_atom(hist_data, file, field_str,
+					&flags, var_name);
+		if (IS_ERR(hist_field)) {
+			ret = PTR_ERR(hist_field);
 			goto out;
 		}
 	}
@@ -945,12 +1249,15 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		field_str = strsep(&fields_str, ",");
 		if (!field_str)
 			break;
+
 		if (strcmp(field_str, "hitcount") == 0)
 			continue;
+
 		ret = create_val_field(hist_data, j++, file, field_str, NULL);
 		if (ret)
 			goto out;
 	}
+
 	if (fields_str && (strcmp(fields_str, "hitcount") != 0))
 		ret = -EINVAL;
  out:
@@ -963,7 +1270,6 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *field_str)
 {
-	struct ftrace_event_field *field = NULL;
 	struct hist_field *hist_field;
 	unsigned long flags = 0;
 	unsigned int key_size;
@@ -978,11 +1284,15 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	var_name = strsep(&field_str, "=");
 	if (field_str)
 		flags |= HIST_FIELD_FL_VAR;
+	else {
+		field_str = var_name;
+		var_name = NULL;
+	}
 
 	if (strcmp(field_str, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
-		hist_field = create_hist_field(field, flags, var_name);
+		hist_field = create_hist_field(NULL, flags, var_name);
 	} else {
 		hist_field = parse_expr(hist_data, file, field_str, flags,
 					var_name);
@@ -992,26 +1302,21 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		if (!hist_field) {
-			field = parse_field(hist_data, file, field_str,
-					    &flags);
-			if (IS_ERR(field)) {
-				ret = PTR_ERR(field);
+			hist_field = parse_atom(hist_data, file, field_str,
+						&flags, var_name);
+			if (IS_ERR(hist_field)) {
+				ret = PTR_ERR(hist_field);
 				goto out;
 			}
+		}
 
-			hist_field = create_hist_field(field, flags, var_name);
-			if (!hist_field) {
-				ret = -ENOMEM;
-				goto out;
-			}
+		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+			destroy_hist_field(hist_field);
+			ret = -EINVAL;
+			goto out;
 		}
 
-		if (flags & HIST_FIELD_FL_TIMESTAMP)
-			key_size = sizeof(u64);
-		else if (is_string_field(field))
-			key_size = MAX_FILTER_STR_VAL;
-		else
-			key_size = field->size;
+		key_size = hist_field->size;
 	}
 
 	hist_data->fields[key_idx] = hist_field;
@@ -1054,16 +1359,20 @@ static int create_key_fields(struct hist_trigger_data *hist_data,
 		field_str = strsep(&fields_str, ",");
 		if (!field_str)
 			break;
+
 		ret = create_key_field(hist_data, i, key_offset,
 				       file, field_str);
 		if (ret < 0)
 			goto out;
+
 		key_offset += ret;
 	}
+
 	if (fields_str) {
 		ret = -EINVAL;
 		goto out;
 	}
+
 	ret = 0;
  out:
 	return ret;
@@ -1247,24 +1556,17 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 
 		if (idx < 0)
 			return idx;
-	}
-
-	return 0;
-}
 
-static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
-{
-	struct hist_field *key_field;
-	unsigned int i;
-
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
-
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME)
-			return true;
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			idx = tracing_map_add_var(map);
+			if (idx < 0)
+				return idx;
+			hist_field->var_ref.idx = idx;
+			hist_data->n_vars++;
+		}
 	}
 
-	return false;
+	return 0;
 }
 
 static struct hist_trigger_data *
@@ -1290,8 +1592,7 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -1324,22 +1625,37 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 				    struct tracing_map_elt *elt, void *rec,
-				    struct ring_buffer_event *rbe)
+				    struct ring_buffer_event *rbe,
+				    u64 *var_ref_vals)
 {
 	struct hist_field *hist_field;
-	unsigned int i;
+	unsigned int i, var_idx;
 	u64 hist_val;
+	struct hist_elt_data *elt_data;
+
+	elt_data = elt->private_data;
+	elt_data->var_ref_vals = var_ref_vals;
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec, rbe);
+		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_field->var_val = hist_val;
+			var_idx = hist_field->var_ref.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
 			if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
 				continue;
 		}
 		tracing_map_update_sum(elt, i, hist_val);
 	}
+
+	for_each_hist_key_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+			var_idx = hist_field->var_ref.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
+		}
+	}
 }
 
 static inline void add_to_key(char *compound_key, void *key,
@@ -1372,10 +1688,11 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
 	unsigned long entries[HIST_STACKTRACE_DEPTH];
+	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
 	struct stack_trace stacktrace;
 	struct hist_field *key_field;
-	struct tracing_map_elt *elt;
+	struct tracing_map_elt *elt = NULL;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -1396,7 +1713,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec, rbe);
+			field_contents = key_field->fn(key_field, elt, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -1405,19 +1722,20 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 		}
 		if (use_compound_key)
 			add_to_key(compound_key, key, key_field, rec);
-
-		if (key_field->flags & HIST_FIELD_FL_VAR)
-			key_field->var_val = (u64)key;
 	}
 
 	if (use_compound_key)
 		key = compound_key;
 
+	if (hist_data->n_var_refs &&
+	    !resolve_var_refs(hist_data, key, var_ref_vals))
+		return;
+
 	elt = tracing_map_insert(hist_data->map, key);
 	if (!elt)
 		return;
 
-	hist_trigger_elt_update(hist_data, elt, rec, rbe);
+	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -1774,7 +2092,12 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 	if (!data->ref) {
 		if (data->name)
 			del_named_trigger(data);
+
 		trigger_data_free(data);
+
+		if (remove_hist_vars(hist_data))
+			return;
+
 		destroy_hist_data(hist_data);
 	}
 }
@@ -1992,16 +2315,47 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	update_cond_flag(file);
 
 	tracing_set_time_stamp_abs(file->tr, true);
+ out:
+	return ret;
+}
+
+static int hist_trigger_enable(struct event_trigger_data *data,
+			       struct trace_event_file *file)
+{
+	int ret = 0;
 
 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
 		ret--;
 	}
- out:
+
 	return ret;
 }
 
+static bool hist_trigger_check_refs(struct event_trigger_data *data,
+				    struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data = data->private_data;
+	struct event_trigger_data *test, *named_data = NULL;
+
+	if (hist_data->attrs->name)
+		named_data = find_named_trigger(hist_data->attrs->name);
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, test, named_data, false))
+				continue;
+			hist_data = test->private_data;
+			if (check_var_refs(hist_data))
+				return true;
+			break;
+		}
+	}
+
+	return false;
+}
+
 static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
@@ -2012,7 +2366,6 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
-
 	list_for_each_entry_rcu(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
@@ -2100,6 +2453,11 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 			goto out_free;
 	}
 
+	if (hist_trigger_check_refs(trigger_data, file)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	if (glob[0] == '!') {
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
 		ret = 0;
@@ -2119,16 +2477,28 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_free;
 	} else if (ret < 0)
 		goto out_free;
+
+	if (has_hist_vars(hist_data))
+		save_hist_vars(hist_data);
+
+	ret = tracing_map_init(hist_data->map);
+	if (ret)
+		goto out_unreg;
+
+	ret = hist_trigger_enable(trigger_data, file);
+	if (ret)
+		goto out_unreg;
+
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
 	return ret;
+ out_unreg:
+	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-
 	kfree(trigger_data);
-
 	destroy_hist_data(hist_data);
 	goto out;
 }
-- 
1.9.3
