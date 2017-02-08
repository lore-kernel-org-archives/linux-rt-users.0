From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 20/21] tracing: Add 'onmax' hist trigger action support
Date: Wed,  8 Feb 2017 11:25:16 -0600
Message-ID: <7b63932147dc0f36cc40ee6eb7a8af07a1535b5e.1486569306.git.tom.zanussi@linux.intel.com>
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

Add an 'onmax(var).save(field...)' hist trigger action which is
invoked whenever an event exceeds the current maximum.

The end result is that the trace event fields specified as the
onmax.save() params will be saved if 'var' exceeds the current maximum
for that hist trigger entry.  This allows context from the event that
exhibited the new maximum to be saved for later reference.  When the
histogram is displayed, additional fields displaying the saved values
will be printed.

As an example the below defines a couple of hist triggers, one for
sched_wakeup and another for sched_switch, keyed on pid.  Whenever a
sched_wakeup occurs, the timestamp is saved in the entry corresponding
to the current pid, and when the scheduler switches back to that pid,
the timestamp difference is calculated.  If the resulting latency
exceeds the current maximum latency, the specified save() values are
saved:

    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
      if comm=="cyclictest"' >> \
      /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    # echo 'hist:keys=next_pid:\
      wakeup_lat=common_timestamp.usecs-ts0:\
      onmax(wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
      if next_comm=="cyclictest"' >> \
      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

When the histogram is displayed, the max value and the saved values
corresponding to the max are displayed following the rest of the
fields:

    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
      { next_pid:       2255 } hitcount:        239 \
        common_timestamp-ts0:          0
        max:         27  next_comm: cyclictest \
        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1 \
      { next_pid:       2256 } hitcount:       2355  common_timestamp-ts0: 0 \
      	max:         49  next_comm: cyclictest \
        prev_pid:          0  prev_prio:        120  prev_comm: swapper/0

    Totals:
        Hits: 12970
        Entries: 2
        Dropped: 0

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 280 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 278 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2f9efb8..14e05da 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -36,6 +36,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_ASSIGNMENT_MAX	4
 #define HIST_ACTIONS_MAX	8
+#define HIST_ON_MAX_SAVE_MAX	8
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -260,6 +261,7 @@ struct hist_trigger_data {
 	bool				enable_timestamps;
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
+	unsigned int			n_onmax_str;
 };
 
 static u64 hist_field_timestamp(struct hist_field *hist_field,
@@ -450,6 +452,7 @@ static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
 struct hist_elt_data {
 	char *comm;
 	u64 *var_ref_vals;
+	char *onmax_str[HIST_ON_MAX_SAVE_MAX];
 };
 
 static u64 hist_field_var_ref(struct hist_field *hist_field,
@@ -611,7 +614,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions == HIST_ACTIONS_MAX)
 		return -EINVAL;
 
-	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0)) {
+	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
+	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -729,7 +733,12 @@ static inline void save_comm(char *comm, struct task_struct *task)
 
 static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
+	struct hist_trigger_data *hist_data = elt->map->private_data;
 	struct hist_elt_data *private_data = elt->private_data;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_onmax_str; i++)
+		kfree(private_data->onmax_str[i]);
 
 	kfree(private_data->comm);
 	kfree(private_data);
@@ -761,6 +770,14 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
+	for (i = 0; i < hist_data->n_onmax_str; i++) {
+		elt_data->onmax_str[i] = kzalloc(size, GFP_KERNEL);
+		if (!elt_data->onmax_str[i]) {
+			hist_trigger_elt_data_free(elt);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 
@@ -990,6 +1007,12 @@ struct action_data {
 	action_fn_t	fn;
 	unsigned int	var_ref_idx;
 	struct synthetic_event *synthetic_event;
+
+	unsigned int		max_var_ref_idx;
+	struct hist_field	*max_save_val[HIST_ON_MAX_SAVE_MAX];
+	struct hist_field	*max_save_var[HIST_ON_MAX_SAVE_MAX];
+	unsigned int		max_n_save;
+	struct hist_field	*max_var;
 };
 
 static LIST_HEAD(synthetic_events_list);
@@ -1957,6 +1980,225 @@ static int create_onmatch_data(char *str, struct hist_trigger_data *hist_data)
 	return ret;
 }
 
+static void onmax_print(struct seq_file *m,
+			struct hist_trigger_data *hist_data,
+			struct tracing_map_elt *elt,
+			struct action_data *data)
+{
+	unsigned int i, save_var_idx, max_idx = data->max_var->var_ref.idx;
+
+	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+
+	for (i = 0; i < data->max_n_save; i++) {
+		struct hist_field *save_val = data->max_save_val[i];
+		struct hist_field *save_var = data->max_save_var[i];
+		u64 val;
+
+		save_var_idx = save_var->var_ref.idx;
+
+		val = tracing_map_read_var(elt, save_var_idx);
+
+		if (save_val->flags & HIST_FIELD_FL_STRING) {
+			seq_printf(m, "  %s: %-50s", save_var->var_name,
+				   (char *)(val));
+		} else
+			seq_printf(m, "  %s: %10llu", save_var->var_name, val);
+	}
+}
+
+static void onmax_save(struct hist_trigger_data *hist_data,
+		       struct tracing_map_elt *elt, void *rec,
+		       struct ring_buffer_event *rbe,
+		       struct action_data *data, u64 *var_ref_vals)
+{
+	unsigned int i, j, save_idx, max_idx = data->max_var->var_ref.idx;
+	unsigned int max_var_ref_idx = data->max_var_ref_idx;
+	struct hist_elt_data *elt_data = elt->private_data;
+
+	u64 var_val, max_val;
+
+	var_val = var_ref_vals[max_var_ref_idx];
+	max_val = tracing_map_read_var(elt, max_idx);
+
+	if (var_val <= max_val)
+		return;
+
+	tracing_map_set_var(elt, max_idx, var_val);
+
+	for (i = 0, j = 0; i < data->max_n_save; i++) {
+		struct hist_field *save_val = data->max_save_val[i];
+
+		var_val = save_val->fn(save_val, elt, rbe, rec);
+		save_idx = data->max_save_var[i]->var_ref.idx;
+
+		if (save_val->flags & HIST_FIELD_FL_STRING) {
+			char *onmax_str = elt_data->onmax_str[j++];
+
+			memcpy(onmax_str, (char *)var_val, TASK_COMM_LEN + 1);
+			var_val = (u64)onmax_str;
+		}
+		tracing_map_set_var(elt, save_idx, var_val);
+	}
+}
+
+static struct hist_field *create_free_var(struct hist_trigger_data *hist_data,
+					  char *name)
+{
+	struct hist_field *var;
+	unsigned int idx;
+
+	var = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
+	if (!var) {
+		var = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	idx = tracing_map_add_var(hist_data->map);
+	if (idx < 0) {
+		kfree(var);
+		var = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	var->flags = HIST_FIELD_FL_VAR;
+	var->var_ref.idx = idx;
+	var->var_ref.hist_data = hist_data;
+	var->var_name = kstrdup(name, GFP_KERNEL);
+ out:
+	return var;
+}
+
+static int create_save_var(struct hist_trigger_data *hist_data,
+			   struct trace_event_file *file,
+			   struct action_data *data,
+			   const char *event_name, char *field_str)
+{
+	struct hist_field *val_field, *save_var;
+	unsigned long flags = HIST_FIELD_FL_VAR;
+	int ret = 0;
+
+	val_field = parse_atom(hist_data, file, field_str,
+			       &flags, NULL);
+	if (IS_ERR(val_field)) {
+		ret = PTR_ERR(val_field);
+		goto out;
+	}
+	data->max_save_val[data->max_n_save] = val_field;
+	if (val_field->flags & HIST_FIELD_FL_STRING)
+		hist_data->n_onmax_str++;
+
+	save_var = create_free_var(hist_data, field_str);
+	if (IS_ERR(save_var)) {
+		ret = PTR_ERR(save_var);
+		goto out;
+	}
+	data->max_save_var[data->max_n_save++] = save_var;
+
+	if (WARN_ON(data->max_n_save > HIST_ON_MAX_SAVE_MAX)) {
+		ret = -EINVAL;
+		goto out;
+	}
+ out:
+	return ret;
+}
+
+static void destroy_onmax_data(struct action_data *data)
+{
+	unsigned int i;
+
+	destroy_hist_field(data->max_var);
+
+	for (i = 0; i < data->max_n_save; i++) {
+		destroy_hist_field(data->max_save_val[i]);
+		destroy_hist_field(data->max_save_var[i]);
+	}
+
+	kfree(data);
+}
+
+static int create_onmax_data(char *str, struct hist_trigger_data *hist_data)
+{
+	struct trace_event_call *call = hist_data->event_file->event_call;
+	unsigned int n_save = 0, var_ref_idx = hist_data->n_var_refs;
+	struct hist_field *var_field, *ref_field, *max_var_field;
+	struct trace_event_file *file = hist_data->event_file;
+	char *fn_name, *onmax_var;
+	struct action_data *data;
+	const char *event_name;
+	unsigned long flags;
+	int ret = 0;
+
+	onmax_var = strsep(&str, ")");
+	if (!onmax_var || !str)
+		return -EINVAL;
+
+	event_name = trace_event_name(call);
+	var_field = find_var_field(hist_data, NULL, event_name, onmax_var);
+	if (var_field) {
+		flags = HIST_FIELD_FL_VAR_REF;
+		ref_field = create_hist_field(NULL, flags, NULL);
+		if (ref_field) {
+			ref_field->var_ref.idx = var_field->var_ref.idx;
+			ref_field->var_ref.hist_data = hist_data;
+			ref_field->name = kstrdup(var_field->var_name, GFP_KERNEL);
+			hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+			ref_field->var_ref_idx = hist_data->n_var_refs++;
+		}
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->fn = onmax_save;
+	data->max_var_ref_idx = var_ref_idx;
+	max_var_field = create_free_var(hist_data, "max");
+	if (IS_ERR(max_var_field)) {
+		ret = PTR_ERR(max_var_field);
+		goto free;
+	}
+	data->max_var = max_var_field;
+
+	strsep(&str, ".");
+	if (!str) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	fn_name = strsep(&str, "(");
+	if (!fn_name || !str) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (strncmp(fn_name, "save", strlen("save")) == 0) {
+		char *save_param = strsep(&str, ")");
+
+		if (!save_param) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		while (save_param) {
+			char *save_var = strsep(&save_param, ",");
+
+			ret = create_save_var(hist_data, file, data,
+					      event_name, save_var);
+			if (ret)
+				goto free;
+			n_save++;
+		}
+	}
+
+	data->max_n_save = n_save;
+
+	hist_data->actions[hist_data->n_actions++] = data;
+ out:
+	return ret;
+ free:
+	destroy_onmax_data(data);
+	goto out;
+}
+
 static void destroy_actions(struct hist_trigger_data *hist_data)
 {
 	unsigned int i;
@@ -1964,7 +2206,10 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		kfree(data);
+		if (data->fn == onmax_save)
+			destroy_onmax_data(data);
+		else
+			kfree(data);
 	}
 }
 
@@ -1983,6 +2228,12 @@ static int create_actions(struct hist_trigger_data *hist_data)
 			ret = create_onmatch_data(action_str, hist_data);
 			if (ret)
 				return ret;
+		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
+			char *action_str = str + strlen("onmax(");
+
+			ret = create_onmax_data(action_str, hist_data);
+			if (ret)
+				return ret;
 		}
 	}
 
@@ -1997,7 +2248,28 @@ static void print_actions(struct seq_file *m,
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == onmax_save)
+			onmax_print(m, hist_data, elt, data);
+	}
+}
+
+static void print_onmax_spec(struct seq_file *m,
+			     struct hist_trigger_data *hist_data,
+			     struct action_data *data)
+{
+	unsigned int i;
+
+	seq_puts(m, ":onmax(");
+	seq_printf(m, "%s", hist_data->var_refs[data->max_var_ref_idx]->name);
+	seq_puts(m, ").save(");
+
+	for (i = 0; i < data->max_n_save; i++) {
+		seq_printf(m, "%s", data->max_save_var[i]->var_name);
+		if (i < data->max_n_save - 1)
+			seq_puts(m, ",");
 	}
+	seq_puts(m, ")");
 }
 
 static void print_onmatch_spec(struct seq_file *m,
@@ -2020,6 +2292,8 @@ static void print_actions_spec(struct seq_file *m,
 
 		if (data->fn == action_trace)
 			print_onmatch_spec(m, hist_data, data);
+		else if (data->fn == onmax_save)
+			print_onmax_spec(m, hist_data, data);
 	}
 }
 
@@ -2324,6 +2598,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 		}
 	}
 
+	print_actions(m, hist_data, elt);
+
 	seq_puts(m, "\n");
 }
 
-- 
1.9.3
