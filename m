From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v14 06/15] tracing: Add hist trigger snapshot() action
Date: Tue,  5 Feb 2019 16:41:52 -0600
Message-ID: <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add support for hist:handlerXXX($var).snapshot(), which will take a
snapshot of the current trace buffer whenever handlerXXX is hit.

As a first user, this also adds snapshot() action support for the
onmax() handler i.e. hist:onmax($var).snapshot().

Also, the hist trigger key printing is moved into a separate function
so the snapshot() action can print a histogram key outside the
histogram display - add and use hist_trigger_print_key() for that
purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c             |   3 +
 kernel/trace/trace_events_hist.c | 267 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 260 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d672d1897a3c..1449a5201c87 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4913,6 +4913,9 @@ static const char readme_msg[] =
 	"\t    The available actions are:\n\n"
 	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
+#ifdef CONFIG_TRACER_SNAPSHOT
+	"\t        snapshot()                           - snapshot the trace buffer\n"
+#endif
 #endif
 ;
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c3cb6283daf3..9cc28cc82e3c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -396,6 +396,7 @@ enum handler_id {
 enum action_id {
 	ACTION_SAVE = 1,
 	ACTION_TRACE,
+	ACTION_SNAPSHOT,
 };
 
 struct action_data {
@@ -454,6 +455,84 @@ struct action_data {
 	};
 };
 
+struct track_data {
+	u64				track_val;
+	bool				updated;
+
+	unsigned int			key_len;
+	void				*key;
+	struct tracing_map_elt		elt;
+
+	struct action_data		*action_data;
+	struct hist_trigger_data	*hist_data;
+};
+
+struct hist_elt_data {
+	char *comm;
+	u64 *var_ref_vals;
+	char *field_var_str[SYNTH_FIELDS_MAX];
+};
+
+struct snapshot_context {
+	struct tracing_map_elt	*elt;
+	void			*key;
+};
+
+static void track_data_free(struct track_data *track_data)
+{
+	struct hist_elt_data *elt_data;
+
+	if (!track_data)
+		return;
+
+	kfree(track_data->key);
+
+	elt_data = track_data->elt.private_data;
+	if (elt_data) {
+		kfree(elt_data->comm);
+		kfree(elt_data);
+	}
+
+	kfree(track_data);
+}
+
+static struct track_data *track_data_alloc(unsigned int key_len,
+					   struct action_data *action_data,
+					   struct hist_trigger_data *hist_data)
+{
+	struct track_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
+	unsigned int size = TASK_COMM_LEN;
+	struct hist_elt_data *elt_data;
+
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->key = kzalloc(key_len, GFP_KERNEL);
+	if (!data->key) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	data->key_len = key_len;
+	data->action_data = action_data;
+	data->hist_data = hist_data;
+
+	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+	data->elt.private_data = elt_data;
+
+	elt_data->comm = kzalloc(size, GFP_KERNEL);
+	if (!elt_data->comm) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return data;
+}
+
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
@@ -1726,12 +1805,6 @@ static struct hist_field *find_event_var(struct hist_trigger_data *hist_data,
 	return hist_field;
 }
 
-struct hist_elt_data {
-	char *comm;
-	u64 *var_ref_vals;
-	char *field_var_str[SYNTH_FIELDS_MAX];
-};
-
 static u64 hist_field_var_ref(struct hist_field *hist_field,
 			      struct tracing_map_elt *elt,
 			      struct ring_buffer_event *rbe,
@@ -3452,6 +3525,112 @@ static bool check_track_val(struct tracing_map_elt *elt,
 	return data->track_data.check_val(track_val, var_val);
 }
 
+#ifdef CONFIG_TRACER_SNAPSHOT
+static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
+{
+	/* called with tr->max_lock held */
+	struct track_data *track_data = tr->cond_snapshot->cond_data;
+	struct hist_elt_data *elt_data, *track_elt_data;
+	struct snapshot_context *context = cond_data;
+	u64 track_val;
+
+	if (!track_data)
+		return false;
+
+	track_val = get_track_val(track_data->hist_data, context->elt,
+				  track_data->action_data);
+
+	track_data->track_val = track_val;
+	memcpy(track_data->key, context->key, track_data->key_len);
+
+	elt_data = context->elt->private_data;
+	track_elt_data = track_data->elt.private_data;
+	if (elt_data->comm)
+		memcpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+
+	track_data->updated = true;
+
+	return true;
+}
+
+static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
+				     struct tracing_map_elt *elt, void *rec,
+				     struct ring_buffer_event *rbe, void *key,
+				     struct action_data *data,
+				     u64 *var_ref_vals)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct snapshot_context context;
+
+	context.elt = elt;
+	context.key = key;
+
+	tracing_snapshot_cond(file->tr, &context);
+}
+
+static void hist_trigger_print_key(struct seq_file *m,
+				   struct hist_trigger_data *hist_data,
+				   void *key,
+				   struct tracing_map_elt *elt);
+
+static struct action_data *snapshot_action(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	if (!hist_data->n_actions)
+		return NULL;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->action == ACTION_SNAPSHOT)
+			return data;
+	}
+
+	return NULL;
+}
+
+static void track_data_snapshot_print(struct seq_file *m,
+				      struct hist_trigger_data *hist_data)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
+	struct action_data *action;
+
+	track_data = tracing_cond_snapshot_data(file->tr);
+	if (!track_data)
+		return;
+
+	if (!track_data->updated)
+		return;
+
+	action = snapshot_action(hist_data);
+	if (!action)
+		return;
+
+	seq_puts(m, "\nSnapshot taken (see tracing/snapshot).  Details:\n");
+	seq_printf(m, "\ttriggering value { %s(%s) }: %10llu",
+		   action->handler == HANDLER_ONMAX ? "onmax" : "onchange",
+		   action->track_data.var_str, track_data->track_val);
+
+	seq_puts(m, "\ttriggered by event with key: ");
+	hist_trigger_print_key(m, hist_data, track_data->key, &track_data->elt);
+	seq_putc(m, '\n');
+}
+#else
+static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
+{
+	return false;
+}
+static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
+				     struct tracing_map_elt *elt, void *rec,
+				     struct ring_buffer_event *rbe, void *key,
+				     struct action_data *data,
+				     u64 *var_ref_vals) {}
+static void track_data_snapshot_print(struct seq_file *m,
+				      struct hist_trigger_data *hist_data) {}
+#endif /* CONFIG_TRACER_SNAPSHOT */
+
 static void track_data_print(struct seq_file *m,
 			     struct hist_trigger_data *hist_data,
 			     struct tracing_map_elt *elt,
@@ -3463,6 +3642,9 @@ static void track_data_print(struct seq_file *m,
 	if (data->handler == HANDLER_ONMAX)
 		seq_printf(m, "\n\tmax: %10llu", track_val);
 
+	if (data->action == ACTION_SNAPSHOT)
+		return;
+
 	for (i = 0; i < hist_data->n_save_vars; i++) {
 		struct hist_field *save_val = hist_data->save_vars[i]->val;
 		struct hist_field *save_var = hist_data->save_vars[i]->var;
@@ -3513,9 +3695,21 @@ static void action_data_destroy(struct action_data *data)
 static void track_data_destroy(struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
+	struct trace_event_file *file = hist_data->event_file;
+
 	destroy_hist_field(data->track_data.track_var, 0);
 	destroy_hist_field(data->track_data.var_ref, 0);
 
+	if (data->action == ACTION_SNAPSHOT) {
+		struct track_data *track_data;
+
+		track_data = tracing_cond_snapshot_data(file->tr);
+		if (track_data && track_data->hist_data == hist_data) {
+			tracing_snapshot_cond_disable(file->tr);
+			track_data_free(track_data);
+		}
+	}
+
 	kfree(data->track_data.var_str);
 
 	action_data_destroy(data);
@@ -3646,6 +3840,26 @@ static int action_parse(char *str, struct action_data *data,
 		data->track_data.save_data = save_track_data_vars;
 		data->fn = ontrack_action;
 		data->action = ACTION_SAVE;
+	} else if (str_has_prefix(action_name, "snapshot")) {
+		char *params = strsep(&str, ")");
+
+		if (!str) {
+			hist_err("action parsing: No closing paren found: %s", params);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (handler == HANDLER_ONMAX)
+			data->track_data.check_val = check_track_val_max;
+		else {
+			hist_err("action parsing: Handler doesn't support action: ", action_name);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		data->track_data.save_data = save_track_data_snapshot;
+		data->fn = ontrack_action;
+		data->action = ACTION_SNAPSHOT;
 	} else {
 		char *params = strsep(&str, ")");
 
@@ -3942,6 +4156,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 static int action_create(struct hist_trigger_data *hist_data,
 			 struct action_data *data)
 {
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
 	struct field_var *field_var;
 	unsigned int i;
 	char *param;
@@ -3950,6 +4166,21 @@ static int action_create(struct hist_trigger_data *hist_data,
 	if (data->action == ACTION_TRACE)
 		return trace_action_create(hist_data, data);
 
+	if (data->action == ACTION_SNAPSHOT) {
+		track_data = track_data_alloc(hist_data->key_size, data, hist_data);
+		if (IS_ERR(track_data)) {
+			ret = PTR_ERR(track_data);
+			goto out;
+		}
+
+		ret = tracing_snapshot_cond_enable(file->tr, track_data,
+						   cond_snapshot_update);
+		if (ret)
+			track_data_free(track_data);
+
+		goto out;
+	}
+
 	if (data->action == ACTION_SAVE) {
 		if (hist_data->n_save_vars) {
 			ret = -EEXIST;
@@ -4552,6 +4783,9 @@ static void print_actions(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
+		if (data->action == ACTION_SNAPSHOT)
+			continue;
+
 		if (data->handler == HANDLER_ONMAX)
 			track_data_print(m, hist_data, elt, data);
 	}
@@ -4947,10 +5181,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 	}
 }
 
-static void
-hist_trigger_entry_print(struct seq_file *m,
-			 struct hist_trigger_data *hist_data, void *key,
-			 struct tracing_map_elt *elt)
+static void hist_trigger_print_key(struct seq_file *m,
+				   struct hist_trigger_data *hist_data,
+				   void *key,
+				   struct tracing_map_elt *elt)
 {
 	struct hist_field *key_field;
 	char str[KSYM_SYMBOL_LEN];
@@ -5026,6 +5260,17 @@ hist_trigger_entry_print(struct seq_file *m,
 		seq_puts(m, " ");
 
 	seq_puts(m, "}");
+}
+
+static void hist_trigger_entry_print(struct seq_file *m,
+				     struct hist_trigger_data *hist_data,
+				     void *key,
+				     struct tracing_map_elt *elt)
+{
+	const char *field_name;
+	unsigned int i;
+
+	hist_trigger_print_key(m, hist_data, key, elt);
 
 	seq_printf(m, " hitcount: %10llu",
 		   tracing_map_read_sum(elt, HITCOUNT_IDX));
@@ -5092,6 +5337,8 @@ static void hist_trigger_show(struct seq_file *m,
 	if (n_entries < 0)
 		n_entries = 0;
 
+	track_data_snapshot_print(m, hist_data);
+
 	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
 		   (u64)atomic64_read(&hist_data->map->hits),
 		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
-- 
2.14.1
