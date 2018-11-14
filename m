From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v7 04/16] tracing: Split up onmatch action data
Date: Wed, 14 Nov 2018 14:18:01 -0600
Message-ID: <d863c9191ace666f54b496e40f7bbfc568ea739f.1542221863.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Currently, the onmatch action data binds the onmatch action to data
related to synthetic event generation.  Since we want to allow the
onmatch handler to potentially invoke a different action, and because
we expect other handlers to generate synthetic events, we need to
separate the data related to these two functions.

Also rename the onmatch data to something more descriptive, and create
and use common action data destroy function.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 91 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7751dce5e5fb..54b78cfe2766 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -338,13 +338,14 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	unsigned int		var_ref_idx;
+	struct synth_event	*synth_event;
+
 	union {
 		struct {
-			unsigned int		var_ref_idx;
-			char			*match_event;
-			char			*match_event_system;
-			struct synth_event	*synth_event;
-		} onmatch;
+			char			*event;
+			char			*event_system;
+		} match_data;
 
 		struct {
 			char			*var_str;
@@ -1010,9 +1011,9 @@ static void action_trace(struct hist_trigger_data *hist_data,
 			 struct ring_buffer_event *rbe,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->onmatch.synth_event;
+	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
@@ -1584,8 +1585,8 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 		struct action_data *data = hist_data->actions[i];
 
 		if (data->handler == HANDLER_ONMATCH) {
-			char *system = data->onmatch.match_event_system;
-			char *event_name = data->onmatch.match_event;
+			char *system = data->match_data.event_system;
+			char *event_name = data->match_data.event;
 
 			file = find_var_file(tr, system, event_name, var_name);
 			if (!file)
@@ -3320,20 +3321,33 @@ static void onmax_save(struct hist_trigger_data *hist_data,
 	update_max_vars(hist_data, elt, rbe, rec);
 }
 
-static void onmax_destroy(struct action_data *data)
+static void action_data_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
+	mutex_lock(&synth_event_mutex);
 
-	kfree(data->onmax.var_str);
 	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
+	if (data->synth_event)
+		data->synth_event->ref--;
+
 	kfree(data);
+
+	mutex_unlock(&synth_event_mutex);
+}
+
+static void onmax_destroy(struct action_data *data)
+{
+	destroy_hist_field(data->onmax.max_var, 0);
+	destroy_hist_field(data->onmax.var, 0);
+
+	kfree(data->onmax.var_str);
+
+	action_data_destroy(data);
 }
 
 static int action_create(struct hist_trigger_data *hist_data,
@@ -3524,23 +3538,10 @@ static struct action_data *onmax_parse(char *str, enum handler_id handler)
 
 static void onmatch_destroy(struct action_data *data)
 {
-	unsigned int i;
-
-	mutex_lock(&synth_event_mutex);
-
-	kfree(data->onmatch.match_event);
-	kfree(data->onmatch.match_event_system);
-	kfree(data->action_name);
+	kfree(data->match_data.event);
+	kfree(data->match_data.event_system);
 
-	for (i = 0; i < data->n_params; i++)
-		kfree(data->params[i]);
-
-	if (data->onmatch.synth_event)
-		data->onmatch.synth_event->ref--;
-
-	kfree(data);
-
-	mutex_unlock(&synth_event_mutex);
+	action_data_destroy(data);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3618,8 +3619,8 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		hist_field = find_event_var(hist_data, system, event, var);
@@ -3658,8 +3659,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 		 * event.
 		 */
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		/*
@@ -3771,8 +3772,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 		goto err;
 	}
 
-	data->onmatch.synth_event = event;
-	data->onmatch.var_ref_idx = var_ref_idx;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
@@ -3860,14 +3861,14 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	data->onmatch.match_event = kstrdup(match_event, GFP_KERNEL);
-	if (!data->onmatch.match_event) {
+	data->match_data.event = kstrdup(match_event, GFP_KERNEL);
+	if (!data->match_data.event) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	data->onmatch.match_event_system = kstrdup(match_event_system, GFP_KERNEL);
-	if (!data->onmatch.match_event_system) {
+	data->match_data.event_system = kstrdup(match_event_system, GFP_KERNEL);
+	if (!data->match_data.event_system) {
 		ret = -ENOMEM;
 		goto free;
 	}
@@ -4437,8 +4438,8 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
-		   data->onmatch.match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->match_data.event_system,
+		   data->match_data.event);
 
 	seq_printf(m, "%s(", data->action_name);
 
@@ -4476,11 +4477,11 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 			return false;
 
 		if (data->handler == HANDLER_ONMATCH) {
-			if (strcmp(data->onmatch.match_event_system,
-				   data_test->onmatch.match_event_system) != 0)
+			if (strcmp(data->match_data.event_system,
+				   data_test->match_data.event_system) != 0)
 				return false;
-			if (strcmp(data->onmatch.match_event,
-				   data_test->onmatch.match_event) != 0)
+			if (strcmp(data->match_data.event,
+				   data_test->match_data.event) != 0)
 				return false;
 		} else if (data->handler == HANDLER_ONMAX) {
 			if (strcmp(data->onmax.var_str,
-- 
2.14.1
