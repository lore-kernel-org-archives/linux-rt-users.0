From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v5 30/37] tracing: Add hist trigger support for variable reference aliases
Date: Thu,  9 Nov 2017 14:34:01 -0600
Message-ID: <978c83faf8502f29b30b6b81ff90c0c2f7487a6b.1510252666.git.tom.zanussi@linux.intel.com>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510252666.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1510252666.git.tom.zanussi@linux.intel.com>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add support for alias=$somevar where alias can be used as
onmatch.xxx($alias).

Aliases are a way of creating a new name for an existing variable, for
flexibly in making naming more clear in certain cases.  For example in
the below the user perhaps feels that using $new_lat in the synthetic
event invocation is opaque or doesn't fit well stylistically with
previous triggers, so creates an alias of $new_lat named $latency and
uses that in the call instead:

  # echo 'hist:keys=next_pid:new_lat=$common_timestamp.usecs' >
    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

  # echo 'hist:keys=pid:latency=$new_lat:
    onmatch(sched.sched_switch).wake2($latency,pid)' >
    /sys/kernel/debug/tracing/events/synthetic/wake1/trigger

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 58 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 30da21c..bd3f03f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -228,6 +228,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_EXPR		= 1 << 13,
 	HIST_FIELD_FL_VAR_REF		= 1 << 14,
 	HIST_FIELD_FL_CPU		= 1 << 15,
+	HIST_FIELD_FL_ALIAS		= 1 << 16,
 };
 
 struct var_defs {
@@ -1624,7 +1625,8 @@ static const char *hist_field_name(struct hist_field *field,
 
 	if (field->field)
 		field_name = field->field->name;
-	else if (field->flags & HIST_FIELD_FL_LOG2)
+	else if (field->flags & HIST_FIELD_FL_LOG2 ||
+		 field->flags & HIST_FIELD_FL_ALIAS)
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "$common_timestamp";
@@ -2091,7 +2093,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	hist_field->hist_data = hist_data;
 
-	if (flags & HIST_FIELD_FL_EXPR)
+	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
 		goto out; /* caller will populate */
 
 	if (flags & HIST_FIELD_FL_VAR_REF) {
@@ -2375,6 +2377,28 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 	return field;
 }
 
+static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
+				       struct hist_field *var_ref,
+				       char *var_name)
+{
+	struct hist_field *alias = NULL;
+	unsigned long flags = HIST_FIELD_FL_ALIAS | HIST_FIELD_FL_VAR;
+
+	alias = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!alias)
+		return NULL;
+
+	alias->fn = var_ref->fn;
+	alias->operands[0] = var_ref;
+
+	if (init_var_ref(alias, var_ref, var_ref->system, var_ref->event_name)) {
+		destroy_hist_field(alias, 0);
+		return NULL;
+	}
+
+	return alias;
+}
+
 struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 			      struct trace_event_file *file, char *str,
 			      unsigned long *flags, char *var_name)
@@ -2408,6 +2432,13 @@ struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 		if (hist_field) {
 			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
 			hist_field->var_ref_idx = hist_data->n_var_refs++;
+			if (var_name) {
+				hist_field = create_alias(hist_data, hist_field, var_name);
+				if (!hist_field) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
 			return hist_field;
 		}
 	} else
@@ -2512,6 +2543,26 @@ static int check_expr_operands(struct hist_field *operand1,
 	unsigned long operand1_flags = operand1->flags;
 	unsigned long operand2_flags = operand2->flags;
 
+	if ((operand1_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand1_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand1->var.hist_data, operand1->name);
+		if (!var)
+			return -EINVAL;
+		operand1_flags = var->flags;
+	}
+
+	if ((operand2_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand2_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand2->var.hist_data, operand2->name);
+		if (!var)
+			return -EINVAL;
+		operand2_flags = var->flags;
+	}
+
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
 	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS))
 		return -EINVAL;
@@ -4634,7 +4685,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	else if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "cpu");
 	else if (field_name) {
-		if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
+		    hist_field->flags & HIST_FIELD_FL_ALIAS)
 			seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
 	}
-- 
1.9.3
