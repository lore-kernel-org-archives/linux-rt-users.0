From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 18/21] tracing: Add support for 'synthetic' events
Date: Wed,  8 Feb 2017 11:25:14 -0600
Message-ID: <4513d7cbadba3f2e77596fca2b4fc0f0af5bf77b.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:12863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932957AbdBHRap (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 12:30:45 -0500
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Synthetic events are user-defined events generated from hist trigger
variables saved from one or more other events.

To define a synthetic event, the user writes a simple specification
consisting of the name of the new event along with one or more
variables defined on other events, to the tracing/synthetic_events
file.

For instance, the following creates a new event named 'wakeup_latency'
with 3 fields: lat, pid, and prio.  Each of those fields is simply a
variable reference to a variable on another event:

    # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
      pid=sched_switch:woken_pid prio=sched_switch:woken_prio' >> \
      /sys/kernel/debug/tracing/synthetic_events

Reading the tracing/synthetic_events file lists all the
currently-defined synthetic events, in this case the event we defined
above:

    # cat /sys/kernel/debug/tracing/synthetic_events
    wakeup_latency lat=sched_switch:wakeup_lat*, pid=sched_switch:woken_pid*, \
                   prio=sched_switch:woken_prio*

Any event field that hasn't yet been 'resolved' is shown with an
asterisk following it.  A field will be unresolved if another event
defining the specified variable hasn't been defined yet.  Once we add
the second event below, those variables are defined:

    # echo 'hist:keys=pid,prio:ts0=common_timestamp.usecs' >> \
      /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger

    # echo 'hist:keys=woken_pid=next_pid,woken_prio=next_prio:\
      wakeup_lat=common_timestamp.usecs-ts0:' >> \
      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

At that point the variables are defined and displaying the
synthetic_event no longer displays the asterisks:

    # cat /sys/kernel/debug/tracing/synthetic_events
    wakeup_latency lat=sched:sched_switch:wakeup_lat, \
    pid=sched:sched_switch:woken_pid, prio=sched:sched_switch:woken_prio

At this point, the synthetic event is ready to use, and a histogram
can be defined using it:

    # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
    /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

The new event is created under the tracing/events/synthetic/ directory
and looks and behaves just like any other event:

    # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
      enable  filter  format  hist  id  trigger

Although a histogram can be defined for it, nothing will happen until
an action tracing that event via the trace_synthetic() function
occurs.  The trace_synthetic() function is very similar to all the
other trace_* invocations spread throughout the kernel, except in this
case the trace_ function and its corresponding tracepoint isn't
statically generated but defined by the user at run-time.

How this can be automatically hooked up via a hist trigger 'action' is
discussed in a subsequent patch.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 822 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 814 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0147141..46da09f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -19,10 +19,13 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
+#include <linux/tracefs.h>
 
 #include "tracing_map.h"
 #include "trace.h"
 
+#define SYNTHETIC_EVENT_SYSTEM "synthetic"
+
 struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
@@ -44,6 +47,10 @@ enum field_op_id {
 struct hist_var_ref {
 	struct hist_trigger_data	*hist_data;
 	unsigned int			idx;
+	bool				pending;
+	char				*pending_system;
+	char				*pending_event_name;
+	char				*pending_var_name;
 };
 
 struct hist_field {
@@ -419,7 +426,9 @@ static int remove_hist_vars(struct hist_trigger_data *hist_data)
 }
 
 static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
-					 char *var_name)
+					 const char *system,
+					 const char *event_name,
+					 const char *var_name)
 {
 	struct hist_field *hist_field, *found = NULL;
 	int i;
@@ -943,6 +952,22 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 	}
 }
 
+struct synthetic_event_field {
+	char *name;
+	struct hist_field *var_ref;
+};
+
+struct synthetic_event {
+	struct list_head		list;
+	char				*name;
+	struct synthetic_event_field	*fields;
+	unsigned int			n_fields;
+	u64				*var_ref_vals;
+	struct trace_event_class	class;
+	struct trace_event_call		call;
+	struct tracepoint		*tp;
+};
+
 struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
@@ -953,15 +978,158 @@ typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
 struct action_data {
 	action_fn_t	fn;
 	unsigned int	var_ref_idx;
+	struct synthetic_event *synthetic_event;
 };
 
-static struct hist_field *parse_var_ref(char *var_name)
+static LIST_HEAD(synthetic_events_list);
+static DEFINE_MUTEX(synthetic_event_mutex);
+
+static void free_synthetic_tracepoint(struct tracepoint *tp)
+{
+	if (!tp)
+		return;
+
+	kfree(tp->name);
+	kfree(tp);
+}
+
+static struct tracepoint *alloc_synthetic_tracepoint(char *name)
+{
+	struct tracepoint *tp;
+	int ret = 0;
+
+	tp = kzalloc(sizeof(*tp), GFP_KERNEL);
+	if (!tp) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	tp->name = kstrdup(name, GFP_KERNEL);
+	if (!tp->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	return tp;
+ free:
+	free_synthetic_tracepoint(tp);
+
+	return ERR_PTR(ret);
+}
+
+static inline void trace_synthetic(struct synthetic_event *event,
+				   u64 *var_ref_vals,
+				   unsigned int var_ref_idx)
+{
+	struct tracepoint *tp = event->tp;
+
+	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+		struct tracepoint_func *it_func_ptr;
+		void *it_func;
+		void *__data;
+
+		if (!(cpu_online(raw_smp_processor_id())))
+			return;
+
+		it_func_ptr = rcu_dereference_sched((tp)->funcs);
+		if (it_func_ptr) {
+			do {
+				it_func = (it_func_ptr)->func;
+				__data = (it_func_ptr)->data;
+				((void(*)(void *__data, u64* var_ref_vals, unsigned int var_ref_idx))(it_func))(__data, var_ref_vals, var_ref_idx);
+			} while ((++it_func_ptr)->func);
+		}
+	}
+}
+
+static struct synthetic_event *find_synthetic_event(char *name);
+
+static void reset_pending_var_refs(struct hist_trigger_data *hist_data,
+				   struct synthetic_event *event)
+{
+	const char *system, *event_name, *pending_system, *pending_event_name;
+	struct synthetic_event_field *se_field;
+	struct trace_event_call *call;
+	struct hist_field *ref_field;
+	unsigned int i;
+
+	call = hist_data->event_file->event_call;
+	system = call->class->system;
+	event_name = trace_event_name(call);
+
+	for (i = 0; i < event->n_fields; i++) {
+		se_field = &event->fields[i];
+		ref_field = se_field->var_ref;
+
+		pending_system = ref_field->var_ref.pending_system;
+		if ((pending_system) && (strcmp(system, pending_system) != 0))
+			continue;
+
+		pending_event_name = ref_field->var_ref.pending_event_name;
+		if (pending_event_name &&
+		    (strcmp(event_name, pending_event_name) == 0))
+			ref_field->var_ref.pending = true;
+	}
+}
+
+static void unresolve_pending_var_refs(struct hist_trigger_data *hist_data)
+{
+	struct synthetic_event *event;
+
+	mutex_lock(&synthetic_event_mutex);
+	list_for_each_entry(event, &synthetic_events_list, list)
+		reset_pending_var_refs(hist_data, event);
+	mutex_unlock(&synthetic_event_mutex);
+}
+
+static bool resolve_pending_var_refs(struct synthetic_event *event)
+{
+	struct hist_var_data *var_data;
+	struct hist_field *var_field = NULL, *ref_field = NULL;
+	struct synthetic_event_field *se_field;
+	char *system, *event_name, *var_name;
+	bool pending = false;
+	unsigned int i;
+
+	for (i = 0; i < event->n_fields; i++) {
+		se_field = &event->fields[i];
+		ref_field = se_field->var_ref;
+		if (!ref_field->var_ref.pending)
+			continue;
+
+		pending = true;
+
+		system = ref_field->var_ref.pending_system;
+		event_name = ref_field->var_ref.pending_event_name;
+		var_name = ref_field->var_ref.pending_var_name;
+
+		list_for_each_entry(var_data, &hist_var_list, list) {
+			var_field = find_var_field(var_data->hist_data, system,
+						   event_name, var_name);
+			if (!var_field)
+				continue;
+
+			ref_field->var_ref.idx = var_field->var_ref.idx;
+			ref_field->var_ref.hist_data = var_data->hist_data;
+			if (!ref_field->name)
+				ref_field->name = kstrdup(var_field->var_name, GFP_KERNEL);
+			ref_field->var_ref.pending = false;
+			pending = false;
+		}
+	}
+
+	return !pending;
+}
+
+static struct hist_field *parse_var_ref(char *system, char *event_name,
+					char *var_name, bool defer)
 {
 	struct hist_var_data *var_data;
 	struct hist_field *var_field = NULL, *ref_field = NULL;
 
 	list_for_each_entry(var_data, &hist_var_list, list) {
-		var_field = find_var_field(var_data->hist_data, var_name);
+		var_field = find_var_field(var_data->hist_data, system,
+					   event_name, var_name);
 		if (var_field)
 			break;
 	}
@@ -975,6 +1143,25 @@ static struct hist_field *parse_var_ref(char *var_name)
 			ref_field->var_ref.hist_data = var_data->hist_data;
 			ref_field->name = kstrdup(var_field->var_name, GFP_KERNEL);
 		}
+	} else if (defer) {
+		unsigned long flags = HIST_FIELD_FL_VAR_REF;
+
+		ref_field = create_hist_field(NULL, flags, NULL);
+		if (ref_field) {
+			char *str;
+
+			ref_field->var_ref.pending = true;
+			if (system) {
+				str = kstrdup(system, GFP_KERNEL);
+				ref_field->var_ref.pending_system = str;
+			}
+			if (event_name) {
+				str = kstrdup(event_name, GFP_KERNEL);
+				ref_field->var_ref.pending_event_name = str;
+			}
+			str = kstrdup(var_name, GFP_KERNEL);
+			ref_field->var_ref.pending_var_name = str;
+		}
 	}
 
 	return ref_field;
@@ -1030,7 +1217,7 @@ struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	struct hist_field *hist_field = NULL;
 	int ret = 0;
 
-	hist_field = parse_var_ref(str);
+	hist_field = parse_var_ref(NULL, NULL, str, false);
 	if (hist_field) {
 		hist_data->var_refs[hist_data->n_var_refs] = hist_field;
 		hist_field->var_ref_idx = hist_data->n_var_refs++;
@@ -1622,6 +1809,20 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
+static int add_synthetic_var_refs(struct hist_trigger_data *hist_data,
+				  struct synthetic_event *event)
+{
+	unsigned int i, var_ref_idx = hist_data->n_var_refs;
+
+	for (i = 0; i < event->n_fields; i++) {
+		struct hist_field *var_ref = event->fields[i].var_ref;
+
+		hist_data->var_refs[hist_data->n_var_refs++] = var_ref;
+	}
+
+	return var_ref_idx;
+}
+
 static void destroy_actions(struct hist_trigger_data *hist_data)
 {
 	unsigned int i;
@@ -1716,10 +1917,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	if (ret)
 		goto free;
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto free;
-
 	hist_data->event_file = file;
  out:
 	return hist_data;
@@ -2226,6 +2423,8 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 
 		trigger_data_free(data);
 
+		unresolve_pending_var_refs(hist_data);
+
 		if (remove_hist_vars(hist_data))
 			return;
 
@@ -2795,3 +2994,610 @@ __init int register_trigger_hist_enable_disable_cmds(void)
 
 	return ret;
 }
+
+static void free_synthetic_event_field(struct synthetic_event_field *field)
+{
+	if (field->var_ref->var_ref.pending)
+		destroy_hist_field(field->var_ref);
+	kfree(field->name);
+}
+
+static void free_synthetic_event_print_fmt(struct trace_event_call *call)
+{
+	kfree(call->print_fmt);
+}
+
+static void free_synthetic_event(struct synthetic_event *event)
+{
+	unsigned int i;
+
+	if (!event)
+		return;
+
+	for (i = 0; i < event->n_fields; i++)
+		free_synthetic_event_field(&event->fields[i]);
+
+	kfree(event->fields);
+	kfree(event->name);
+
+	kfree(event->class.system);
+	free_synthetic_tracepoint(event->tp);
+	free_synthetic_event_print_fmt(&event->call);
+
+	kfree(event);
+}
+
+static struct synthetic_event *alloc_synthetic_event(char *event_name,
+						     int n_fields)
+{
+	struct synthetic_event *event;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event) {
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->name = kstrdup(event_name, GFP_KERNEL);
+	if (!event->name) {
+		kfree(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->n_fields = n_fields;
+	event->fields = kcalloc(n_fields, sizeof(*event->fields), GFP_KERNEL);
+	if (!event->fields)
+		goto err;
+ out:
+	return event;
+ err:
+	free_synthetic_event(event);
+	event = NULL;
+	goto out;
+}
+
+static struct synthetic_event *find_synthetic_event(char *name)
+{
+	struct synthetic_event *event, *found = NULL;
+
+	mutex_lock(&synthetic_event_mutex);
+
+	list_for_each_entry(event, &synthetic_events_list, list) {
+		if (strcmp(event->name, name) == 0) {
+			found = event;
+			goto out;
+		}
+	}
+ out:
+	mutex_unlock(&synthetic_event_mutex);
+
+	return found;
+}
+
+struct synthetic_trace_event {
+	struct trace_entry	ent;
+	int			n_fields;
+	u64			fields[];
+};
+
+static int synthetic_event_define_fields(struct trace_event_call *call)
+{
+	struct synthetic_event *event = call->data;
+	struct synthetic_trace_event trace;
+	unsigned int i;
+	int ret = 0;
+	int offset = offsetof(typeof(trace), fields);
+
+	for (i = 0; i < event->n_fields; i++) {
+		ret = trace_define_field(call, "u64", event->fields[i].name,
+					 offset, sizeof(u64), 0, FILTER_OTHER);
+		offset += sizeof(u64);
+	}
+
+	return ret;
+}
+
+static enum print_line_t
+print_synthetic_event(struct trace_iterator *iter, int flags,
+		      struct trace_event *event)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	struct synthetic_trace_event *entry;
+	struct synthetic_event *se;
+	unsigned int i;
+
+	entry = (struct synthetic_trace_event *)iter->ent;
+	se = container_of(event, struct synthetic_event, call.event);
+
+	trace_seq_printf(s, "%s: ", se->name);
+
+	for (i = 0; i < entry->n_fields; i++) {
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		/* parameter types */
+		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+			trace_seq_printf(s, "%s ", "u64");
+
+		/* parameter values */
+		trace_seq_printf(s, "%s=%llu%s", se->fields[i].name,
+				 entry->fields[i],
+				 i == entry->n_fields - 1 ? "" : ", ");
+	}
+end:
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions synthetic_event_funcs = {
+	.trace		= print_synthetic_event
+};
+
+static notrace void
+trace_event_raw_event_synthetic(void *__data,
+				u64 *var_ref_vals,
+				unsigned int var_ref_idx)
+{
+	struct trace_event_file *trace_file = __data;
+	struct synthetic_trace_event *entry;
+	struct trace_event_buffer fbuffer;
+	int fields_size;
+	unsigned int i;
+
+	struct synthetic_event *event;
+
+	event = trace_file->event_call->data;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	fields_size = event->n_fields * sizeof(u64);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + fields_size);
+	if (!entry)
+		return;
+
+	entry->n_fields = event->n_fields;
+
+	for (i = 0; i < event->n_fields; i++)
+		entry->fields[i] = var_ref_vals[var_ref_idx + i];
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static int __set_synthetic_event_print_fmt(struct synthetic_event *event,
+					   char *buf, int len)
+{
+	int pos = 0;
+	int i;
+
+	/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx%s",
+				event->fields[i].name, sizeof(u64),
+				i == event->n_fields - 1 ? "" : ", ");
+	}
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", ((u64)(REC->%s))", event->fields[i].name);
+	}
+
+#undef LEN_OR_ZERO
+
+	/* return the length of print_fmt */
+	return pos;
+}
+
+static int set_synthetic_event_print_fmt(struct trace_event_call *call)
+{
+	struct synthetic_event *event = call->data;
+	char *print_fmt;
+	int len;
+
+	/* First: called with 0 length to calculate the needed length */
+	len = __set_synthetic_event_print_fmt(event, NULL, 0);
+
+	print_fmt = kmalloc(len + 1, GFP_KERNEL);
+	if (!print_fmt)
+		return -ENOMEM;
+
+	/* Second: actually write the @print_fmt */
+	__set_synthetic_event_print_fmt(event, print_fmt, len + 1);
+	call->print_fmt = print_fmt;
+
+	return 0;
+}
+
+int dynamic_trace_event_reg(struct trace_event_call *call,
+			    enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return dynamic_tracepoint_probe_register(call->tp,
+							 call->class->probe,
+							 file);
+	case TRACE_REG_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->probe,
+					    file, true);
+		return 0;
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return dynamic_tracepoint_probe_register(call->tp,
+							 call->class->perf_probe,
+							 call);
+	case TRACE_REG_PERF_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->perf_probe,
+					    call, true);
+		return 0;
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+static int register_synthetic_event(struct synthetic_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret = 0;
+
+	event->call.class = &event->class;
+	event->class.system = kstrdup(SYNTHETIC_EVENT_SYSTEM, GFP_KERNEL);
+	if (!event->class.system) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	event->tp = alloc_synthetic_tracepoint(event->name);
+	if (IS_ERR(event->tp)) {
+		ret = PTR_ERR(event->tp);
+		event->tp = NULL;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&call->class->fields);
+	call->event.funcs = &synthetic_event_funcs;
+	call->class->define_fields = synthetic_event_define_fields;
+
+	ret = register_trace_event(&call->event);
+	if (!ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+	call->flags = TRACE_EVENT_FL_TRACEPOINT;
+	call->class->reg = dynamic_trace_event_reg;
+	call->class->probe = trace_event_raw_event_synthetic;
+	call->data = event;
+	call->tp = event->tp;
+	ret = trace_add_event_call(call);
+	if (ret) {
+		pr_warn("Failed to register synthetic event: %s\n",
+			trace_event_name(call));
+		goto err;
+	}
+
+	ret = set_synthetic_event_print_fmt(call);
+	if (ret < 0) {
+		trace_remove_event_call(call);
+		goto err;
+	}
+ out:
+	return ret;
+ err:
+	unregister_trace_event(&call->event);
+	goto out;
+}
+
+static int unregister_synthetic_event(struct synthetic_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret;
+
+	ret = trace_remove_event_call(call);
+	if (ret) {
+		pr_warn("Failed to remove synthetic event: %s\n",
+			trace_event_name(call));
+		free_synthetic_event_print_fmt(call);
+		unregister_trace_event(&call->event);
+	}
+
+	return ret;
+}
+
+static int add_synthetic_event(struct synthetic_event *event)
+{
+	int ret;
+
+	mutex_lock(&synthetic_event_mutex);
+
+	ret = register_synthetic_event(event);
+	if (ret)
+		goto out;
+	list_add(&event->list, &synthetic_events_list);
+out:
+	mutex_unlock(&synthetic_event_mutex);
+
+	return ret;
+}
+
+static void remove_synthetic_event(struct synthetic_event *event)
+{
+	mutex_lock(&synthetic_event_mutex);
+
+	unregister_synthetic_event(event);
+	list_del(&event->list);
+
+	mutex_unlock(&synthetic_event_mutex);
+}
+
+static int parse_synthetic_field(struct synthetic_event *event,
+				 char *str, int i)
+{
+	char *field_name, *system, *event_name, *var_name;
+	struct hist_field *var_ref;
+	int ret = 0;
+
+	field_name = strsep(&str, "=");
+	if (!str || !field_name) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event->fields[i].name = kstrdup(field_name, GFP_KERNEL);
+	if (!event->fields[i].name)
+		ret = -ENOMEM;
+
+	system = strsep(&str, ":");
+	if (!system || !str) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event_name = strsep(&str, ":");
+	if (!str) {
+		var_name = event_name;
+		event_name = system;
+		system = NULL;
+	} else
+		var_name = str;
+
+	var_ref = parse_var_ref(system, event_name, var_name, true);
+	if (!var_ref) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event->fields[i].var_ref = var_ref;
+ out:
+	return ret;
+}
+
+static int create_synthetic_event(int argc, char **argv)
+{
+	struct synthetic_event *event = NULL;
+	bool delete_event = false;
+	int i, ret = 0;
+	char *token;
+
+	/*
+	 * Argument syntax:
+	 *  - Add synthetic event: hist:<event_name> [EVENT:]VAR ...
+	 *  - Remove synthetic event: !hist:<event_name> [EVENT:]VAR ...
+	 * EVENT can be sys:event_name or event_name or nothing if VAR unique
+	 */
+	if (argc < 1) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	token = argv[0];
+	if (token[0] == '!') {
+		delete_event = true;
+		token++;
+	}
+
+	event = find_synthetic_event(token);
+	if (event) {
+		if (delete_event) {
+			remove_synthetic_event(event);
+			goto err;
+		} else
+			ret = -EEXIST;
+		goto out;
+	} else if (delete_event) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (argc < 2) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	event = alloc_synthetic_event(token, argc - 1);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		event = NULL;
+		goto err;
+	}
+
+	for (i = 1; i < argc; i++) {
+		ret = parse_synthetic_field(event, argv[i], i - 1);
+		if (ret)
+			goto err;
+	}
+
+	ret = add_synthetic_event(event);
+	if (ret)
+		goto err;
+ out:
+	return ret;
+ err:
+	free_synthetic_event(event);
+
+	goto out;
+}
+
+static int release_all_synthetic_events(void)
+{
+	struct synthetic_event *event, *e;
+
+	mutex_lock(&synthetic_event_mutex);
+
+	list_for_each_entry_safe(event, e, &synthetic_events_list, list) {
+		remove_synthetic_event(event);
+		free_synthetic_event(event);
+	}
+
+	mutex_unlock(&synthetic_event_mutex);
+
+	return 0;
+}
+
+
+static void *synthetic_events_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&synthetic_event_mutex);
+
+	return seq_list_start(&synthetic_events_list, *pos);
+}
+
+static void *synthetic_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &synthetic_events_list, pos);
+}
+
+static void synthetic_events_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&synthetic_event_mutex);
+}
+
+static int synthetic_events_seq_show(struct seq_file *m, void *v)
+{
+	struct synthetic_event_field *se_field;
+	const char *var_name, *system, *event_name;
+	struct hist_trigger_data *hist_data;
+	struct synthetic_event *event = v;
+	struct trace_event_call *call;
+	struct hist_field *ref_field;
+	bool pending;
+	unsigned int i;
+
+	seq_printf(m, "%s ", event->name);
+
+	for (i = 0; i < event->n_fields; i++) {
+		se_field = &event->fields[i];
+		ref_field = se_field->var_ref;
+		pending = ref_field->var_ref.pending;
+		if (!pending) {
+			hist_data = ref_field->var_ref.hist_data;
+			call = hist_data->event_file->event_call;
+			system = call->class->system;
+			event_name = trace_event_name(call);
+		} else {
+			system = ref_field->var_ref.pending_system;
+			event_name = ref_field->var_ref.pending_event_name;
+		}
+
+		var_name = ref_field->var_ref.pending_var_name;
+
+		/* parameter values */
+		seq_printf(m, "%s=%s%s%s:%s%s%s", event->fields[i].name,
+			   system ? system : "", system ? ":" : "",
+			   event_name, var_name, pending ? "*" : "",
+			   i == event->n_fields - 1 ? "" : ", ");
+	}
+
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations synthetic_events_seq_op = {
+	.start  = synthetic_events_seq_start,
+	.next   = synthetic_events_seq_next,
+	.stop   = synthetic_events_seq_stop,
+	.show   = synthetic_events_seq_show
+};
+
+static int synthetic_events_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = release_all_synthetic_events();
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &synthetic_events_seq_op);
+}
+
+static ssize_t synthetic_events_write(struct file *file,
+				      const char __user *buffer,
+				      size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_synthetic_event);
+}
+
+static const struct file_operations synthetic_events_fops = {
+	.open           = synthetic_events_open,
+	.write		= synthetic_events_write,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+static __init int trace_events_hist_init(void)
+{
+	struct dentry *entry = NULL;
+	struct trace_array *tr;
+	struct dentry *d_tracer;
+	int err = 0;
+
+	tr = top_trace_array();
+	if (!tr) {
+		err = -ENODEV;
+		goto err;
+	}
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer)) {
+		err = PTR_ERR(d_tracer);
+		goto err;
+	}
+
+	entry = tracefs_create_file("synthetic_events", 0644, d_tracer,
+				    tr, &synthetic_events_fops);
+	if (!entry) {
+		err = -ENODEV;
+		goto err;
+	}
+
+	return err;
+ err:
+	pr_warn("Could not create tracefs 'synthetic_events' entry\n");
+
+	return err;
+}
+
+fs_initcall(trace_events_hist_init);
-- 
1.9.3

