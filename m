From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3 2/7] tracing: Split up onmatch action data
Date: Thu,  9 Aug 2018 09:34:12 -0500
Message-ID: <5e70e2ba44c2eef7a93f45d57b2b12baa8190b3e.1533753152.git.tom.zanussi@linux.intel.com>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533753152.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533753152.git.tom.zanussi@linux.intel.com>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Currently, the onmatch action data binds the onmatch action to data
related to synthetic event generation.  Since we want to allow the
onmatch handler to potentially invoke a different action, and because
we expect other handlers to generate synthetic events, we need to
separate the data related to these two functions.

Also rename the onmatch data to something more descriptive.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 59 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index de7d6aca4def..aac60de99d58 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -347,13 +347,14 @@ struct action_data {
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
@@ -1001,9 +1002,9 @@ static void action_trace(struct hist_trigger_data *hist_data,
 			 struct ring_buffer_event *rbe,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->onmatch.synth_event;
+	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
@@ -1573,8 +1574,8 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 		struct action_data *data = hist_data->actions[i];
 
 		if (data->handler == HANDLER_ONMATCH) {
-			char *system = data->onmatch.match_event_system;
-			char *event_name = data->onmatch.match_event;
+			char *system = data->match_data.event_system;
+			char *event_name = data->match_data.event;
 
 			file = find_var_file(tr, system, event_name, var_name);
 			if (!file)
@@ -3519,15 +3520,15 @@ static void onmatch_destroy(struct action_data *data)
 
 	mutex_lock(&synth_event_mutex);
 
-	kfree(data->onmatch.match_event);
-	kfree(data->onmatch.match_event_system);
+	kfree(data->match_data.event);
+	kfree(data->match_data.event_system);
 	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
-	if (data->onmatch.synth_event)
-		data->onmatch.synth_event->ref--;
+	if (data->synth_event)
+		data->synth_event->ref--;
 
 	kfree(data);
 
@@ -3609,8 +3610,8 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		hist_field = find_event_var(hist_data, system, event, var);
@@ -3649,8 +3650,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 		 * event.
 		 */
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		/*
@@ -3762,8 +3763,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 		goto err;
 	}
 
-	data->onmatch.synth_event = event;
-	data->onmatch.var_ref_idx = var_ref_idx;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
@@ -3853,14 +3854,14 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
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
@@ -4433,8 +4434,8 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
-		   data->onmatch.match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->match_data.event_system,
+		   data->match_data.event);
 
 	seq_printf(m, "%s(", data->action_name);
 
@@ -4472,11 +4473,11 @@ static bool actions_match(struct hist_trigger_data *hist_data,
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
