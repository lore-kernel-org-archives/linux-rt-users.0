From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 17/21] tracing: Add hist trigger action hook
Date: Wed,  8 Feb 2017 11:25:13 -0600
Message-ID: <f1dfe9d9cd68572aaafe956411cc82ed2a3abd13.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:15527 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932587AbdBHRiS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 12:38:18 -0500
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a hook for executing extra actions whenever a histogram entry is
added or updated.

The default 'action' when a hist entry is added to a histogram is to
update the set of values associated with it.  Some applications may
want to perform additional actions at that point, such as generate
another event, or compare and save a maximum.

Add a simple framework for doing that; specific actions will be
implemented on top of it in later patches.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 155 +++++++++++++++++++++++++++++++++++----
 1 file changed, 139 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 13d67d3..0147141 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -32,6 +32,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_ASSIGNMENT_MAX	4
+#define HIST_ACTIONS_MAX	8
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -60,6 +61,7 @@ struct hist_field {
 	char				*name;
 	u64				var_val;
 	unsigned int			var_idx;
+	bool                            read_once;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -230,6 +232,8 @@ struct hist_trigger_attrs {
 	bool		clear;
 	bool		ts_in_usecs;
 	unsigned int	map_bits;
+	char		*action_str[HIST_ACTIONS_MAX];
+	unsigned int	n_actions;
 };
 
 struct hist_trigger_data {
@@ -247,6 +251,8 @@ struct hist_trigger_data {
 	struct hist_trigger_attrs	*attrs;
 	struct tracing_map		*map;
 	bool				enable_timestamps;
+	struct action_data		*actions[HIST_ACTIONS_MAX];
+	unsigned int			n_actions;
 };
 
 static u64 hist_field_timestamp(struct hist_field *hist_field,
@@ -452,7 +458,7 @@ static u64 hist_field_var_ref(struct hist_field *hist_field,
 
 static bool resolve_var_refs(struct hist_trigger_data *hist_data,
 			     void *key,
-			     u64 *var_ref_vals)
+			     u64 *var_ref_vals, bool self)
 {
 	struct hist_trigger_data *var_data;
 	struct tracing_map_elt *var_elt;
@@ -466,17 +472,26 @@ static bool resolve_var_refs(struct hist_trigger_data *hist_data,
 		var_idx = hist_field->var_ref.idx;
 		var_data = hist_field->var_ref.hist_data;
 
+		if ((self && var_data != hist_data) ||
+		    (!self && var_data == hist_data))
+			continue;
+
 		var_elt = tracing_map_lookup(var_data->map, key);
 		if (!var_elt) {
 			resolved = false;
 			break;
 		}
+
 		if (!tracing_map_var_set(var_elt, var_idx)) {
 			resolved = false;
 			break;
 		}
 
-		var_val = tracing_map_read_var(var_elt, var_idx);
+		if (self || !hist_field->read_once)
+			var_val = tracing_map_read_var(var_elt, var_idx);
+		else
+			var_val = tracing_map_read_var_once(var_elt, var_idx);
+
 		var_ref_vals[i] = var_val;
 	}
 
@@ -569,6 +584,9 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	for (i = 0; i < attrs->n_assignments; i++)
 		kfree(attrs->assignment_str[i]);
 
+	for (i = 0; i < attrs->n_actions; i++)
+		kfree(attrs->action_str[i]);
+
 	kfree(attrs->name);
 	kfree(attrs->sort_key_str);
 	kfree(attrs->keys_str);
@@ -576,6 +594,16 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	kfree(attrs);
 }
 
+static int parse_action(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = 0;
+
+	if (attrs->n_actions == HIST_ACTIONS_MAX)
+		return -EINVAL;
+
+	return ret;
+}
+
 static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
@@ -642,8 +670,13 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 		else if (strcmp(str, "clear") == 0)
 			attrs->clear = true;
 		else {
-			ret = -EINVAL;
-			goto free;
+			ret = parse_action(str, attrs);
+			if (ret < 0)
+				goto free;
+			if (!ret) {
+				ret = -EINVAL;
+				goto free;
+			}
 		}
 	}
 
@@ -910,6 +943,18 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 	}
 }
 
+struct action_data;
+
+typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt, void *rec,
+			     struct ring_buffer_event *rbe,
+			     struct action_data *data, u64 *var_ref_vals);
+
+struct action_data {
+	action_fn_t	fn;
+	unsigned int	var_ref_idx;
+};
+
 static struct hist_field *parse_var_ref(char *var_name)
 {
 	struct hist_var_data *var_data;
@@ -1150,6 +1195,9 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
+	operand1->read_once = true;
+	operand2->read_once = true;
+
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
 	expr->operator = field_op;
@@ -1529,14 +1577,6 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 	return ret;
 }
 
-static void destroy_hist_data(struct hist_trigger_data *hist_data)
-{
-	destroy_hist_trigger_attrs(hist_data->attrs);
-	destroy_hist_fields(hist_data);
-	tracing_map_destroy(hist_data->map);
-	kfree(hist_data);
-}
-
 static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 {
 	struct tracing_map *map = hist_data->map;
@@ -1582,6 +1622,63 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
+static void destroy_actions(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		kfree(data);
+	}
+}
+
+static int create_actions(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+	int ret = 0;
+	char *str;
+
+	for (i = 0; i < hist_data->attrs->n_actions; i++) {
+		str = hist_data->attrs->action_str[i];
+	}
+
+	return ret;
+}
+
+static void print_actions(struct seq_file *m,
+			  struct hist_trigger_data *hist_data,
+			  struct tracing_map_elt *elt)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+	}
+}
+
+static void print_actions_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+	}
+}
+
+static void destroy_hist_data(struct hist_trigger_data *hist_data)
+{
+	if (!hist_data)
+		return;
+
+	destroy_hist_trigger_attrs(hist_data->attrs);
+	destroy_hist_fields(hist_data);
+	tracing_map_destroy(hist_data->map);
+	destroy_actions(hist_data);
+	kfree(hist_data);
+}
+
 static struct hist_trigger_data *
 create_hist_data(unsigned int map_bits,
 		 struct hist_trigger_attrs *attrs,
@@ -1695,6 +1792,20 @@ static inline void add_to_key(char *compound_key, void *key,
 	memcpy(compound_key + key_field->offset, key, size);
 }
 
+static void
+hist_trigger_actions(struct hist_trigger_data *hist_data,
+		     struct tracing_map_elt *elt, void *rec,
+		     struct ring_buffer_event *rbe, u64 *var_ref_vals)
+{
+	struct action_data *data;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		data = hist_data->actions[i];
+		data->fn(hist_data, elt, rec, rbe, data, var_ref_vals);
+	}
+}
+
 static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 			       struct ring_buffer_event *rbe)
 {
@@ -1741,7 +1852,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 		key = compound_key;
 
 	if (hist_data->n_var_refs &&
-	    !resolve_var_refs(hist_data, key, var_ref_vals))
+	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
 		return;
 
 	elt = tracing_map_insert(hist_data->map, key);
@@ -1749,6 +1860,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 		return;
 
 	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
+
+	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
+		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -2069,6 +2183,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 	}
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
 
+	print_actions_spec(m, hist_data);
+
 	if (data->filter_str)
 		seq_printf(m, " if %s", data->filter_str);
 
@@ -2421,6 +2537,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
+	bool unreg_self = false;
 	char *trigger;
 	int ret = 0;
 
@@ -2496,6 +2613,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (has_hist_vars(hist_data))
 		save_hist_vars(hist_data);
 
+	ret = create_actions(hist_data);
+	if (ret)
+		goto out_unreg;
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
@@ -2503,18 +2624,20 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
-
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
 	return ret;
  out_unreg:
 	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+	unreg_self = true;
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-	kfree(trigger_data);
-	destroy_hist_data(hist_data);
+	if (!unreg_self) {
+		kfree(trigger_data);
+		destroy_hist_data(hist_data);
+	}
 	goto out;
 }
 
-- 
1.9.3

