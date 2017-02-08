From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 19/21] tracing: Add 'onmatch' hist trigger action support
Date: Wed,  8 Feb 2017 11:25:15 -0600
Message-ID: <d18055cfec5d6a16d047804a816a05f1676c050e.1486569306.git.tom.zanussi@linux.intel.com>
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

Add an 'onmatch().trace(event)' hist trigger action which is invoked
with the set of resolved variables named in the given synthetic event.
The result is the generation of a synthetic event that consists of the
values contained in those variables at the time the invoking event was
hit.

As an example the below defines a simple synthetic event using a
variable defined on the sched_wakeup_new event, and shows the event
definition with unresolved fields, since the sched_wakeup_new event
with the testpid variable hasn't been defined yet:

    # echo 'wakeup_new_test pid=sched_wakeup_new:testpid' >> \
      /sys/kernel/debug/tracing/synthetic_events

    # cat /sys/kernel/debug/tracing/synthetic_events
      wakeup_new_test pid=sched_wakeup_new:testpid*

The following hist trigger both defines the missing testpid variable
and specifies an onmatch().trace action that generates a
wakeup_new_test synthetic event whenever a sched_wakeup_new event
occurs, which because of the 'if comm == "cyclictest"' filter only
happens when the executable is cyclictest:

    # echo 'hist:keys=testpid=pid:onmatch().trace(wakeup_new_test) \
      if comm=="cyclictest"' >> \
      /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger

Creating and displaying a histogram based on those events is now just
a matter of using the fields and new synthetic event in the
tracing/events/synthetic directory, as usual:

    # echo 'hist:keys=pid:sort=pid' >> \
      /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 167 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 46da09f..2f9efb8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -279,6 +279,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 }
 
 static LIST_HEAD(hist_var_list);
+static LIST_HEAD(hist_action_list);
 
 struct hist_var_data {
 	struct list_head list;
@@ -610,6 +611,16 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions == HIST_ACTIONS_MAX)
 		return -EINVAL;
 
+	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0)) {
+		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
+		if (!attrs->action_str[attrs->n_actions]) {
+			ret = -ENOMEM;
+			return ret;
+		}
+		attrs->n_actions++;
+		ret = 1;
+	}
+
 	return ret;
 }
 
@@ -1823,6 +1834,129 @@ static int add_synthetic_var_refs(struct hist_trigger_data *hist_data,
 	return var_ref_idx;
 }
 
+static void action_trace(struct hist_trigger_data *hist_data,
+			 struct tracing_map_elt *elt, void *rec,
+			 struct ring_buffer_event *rbe,
+			 struct action_data *data, u64 *var_ref_vals)
+{
+	struct synthetic_event *event = data->synthetic_event;
+
+	trace_synthetic(event, var_ref_vals, data->var_ref_idx);
+}
+
+static bool check_hist_action_refs(struct hist_trigger_data *hist_data,
+				   struct synthetic_event *event)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace && data->synthetic_event == event)
+			return true;
+	}
+
+	return false;
+}
+
+static bool check_synthetic_action_refs(struct synthetic_event *event)
+{
+	struct hist_var_data *var_data;
+
+	list_for_each_entry(var_data, &hist_action_list, list)
+		if (check_hist_action_refs(var_data->hist_data, event))
+			return true;
+
+	return false;
+}
+
+static struct hist_var_data *find_hist_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data, *found = NULL;
+
+	list_for_each_entry(var_data, &hist_action_list, list) {
+		if (var_data->hist_data == hist_data) {
+			found = var_data;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static int save_hist_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_actions(hist_data);
+	if (var_data)
+		return 0;
+
+	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
+	if (!var_data)
+		return -ENOMEM;
+
+	var_data->hist_data = hist_data;
+	list_add(&var_data->list, &hist_action_list);
+
+	return 0;
+}
+
+static int remove_hist_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_actions(hist_data);
+	if (!var_data)
+		return -EINVAL;
+
+	list_del(&var_data->list);
+
+	return 0;
+}
+
+static int create_onmatch_data(char *str, struct hist_trigger_data *hist_data)
+{
+	char *fn_name, *param;
+	struct action_data *data;
+	int ret = 0;
+
+	strsep(&str, ".");
+	if (!str)
+		return -EINVAL;
+
+	fn_name = strsep(&str, "(");
+	if (!fn_name || !str)
+		return -EINVAL;
+
+	if (strncmp(fn_name, "trace", strlen("trace")) == 0) {
+		struct synthetic_event *event;
+
+		param = strsep(&str, ")");
+		if (!param)
+			return -EINVAL;
+
+		event = find_synthetic_event(param);
+		if (!event)
+			return -EINVAL;
+
+		if (!resolve_pending_var_refs(event))
+			return -EINVAL;
+
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->fn = action_trace;
+		data->synthetic_event = event;
+		data->var_ref_idx = add_synthetic_var_refs(hist_data, event);
+		hist_data->actions[hist_data->n_actions++] = data;
+		save_hist_actions(hist_data);
+	}
+
+	return ret;
+}
+
 static void destroy_actions(struct hist_trigger_data *hist_data)
 {
 	unsigned int i;
@@ -1842,6 +1976,14 @@ static int create_actions(struct hist_trigger_data *hist_data)
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
+
+		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
+			char *action_str = str + strlen("onmatch(");
+
+			ret = create_onmatch_data(action_str, hist_data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -1858,6 +2000,16 @@ static void print_actions(struct seq_file *m,
 	}
 }
 
+static void print_onmatch_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data,
+			       struct action_data *data)
+{
+	seq_puts(m, ":onmatch().");
+
+	if (data->synthetic_event)
+		seq_printf(m, "trace(%s)", data->synthetic_event->name);
+}
+
 static void print_actions_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data)
 {
@@ -1865,6 +2017,9 @@ static void print_actions_spec(struct seq_file *m,
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace)
+			print_onmatch_spec(m, hist_data, data);
 	}
 }
 
@@ -2428,6 +2583,9 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 		if (remove_hist_vars(hist_data))
 			return;
 
+		if (remove_hist_actions(hist_data))
+			return;
+
 		destroy_hist_data(hist_data);
 	}
 }
@@ -3417,6 +3575,10 @@ static int create_synthetic_event(int argc, char **argv)
 	event = find_synthetic_event(token);
 	if (event) {
 		if (delete_event) {
+			if (check_synthetic_action_refs(event)) {
+				ret = -EINVAL;
+				goto out;
+			}
 			remove_synthetic_event(event);
 			goto err;
 		} else
@@ -3462,6 +3624,11 @@ static int release_all_synthetic_events(void)
 
 	mutex_lock(&synthetic_event_mutex);
 
+	list_for_each_entry(event, &synthetic_events_list, list) {
+		if (check_synthetic_action_refs(event))
+			return -EINVAL;
+	}
+
 	list_for_each_entry_safe(event, e, &synthetic_events_list, list) {
 		remove_synthetic_event(event);
 		free_synthetic_event(event);
-- 
1.9.3
