From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 4/7] tracing: Remove open-coding of hist trigger var_ref management
Date: Tue, 18 Dec 2018 14:33:23 -0600
Message-ID: <05ddae93ff514e66fc03897d6665231892939913.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Have create_var_ref() manage the hist trigger's var_ref list, rather
than having similar code doing it in multiple places.  This cleans up
the code and makes sure var_refs are always accounted properly.

Also, document the var_ref-related functions to make what their
purpose clearer.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 93 ++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ee839c52bd3f..9d4cf7a8a95b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1292,6 +1292,17 @@ static u64 hist_field_cpu(struct hist_field *hist_field,
 	return cpu;
 }
 
+/**
+ * check_field_for_var_ref - Check if a VAR_REF field references a variable
+ * @hist_field: The VAR_REF field to check
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the given VAR_REF field to see whether or not it references
+ * the given variable associated with the given trigger.
+ *
+ * Return: The VAR_REF field if it does reference the variable, NULL if not
+ */
 static struct hist_field *
 check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
@@ -1308,6 +1319,18 @@ check_field_for_var_ref(struct hist_field *hist_field,
 	return found;
 }
 
+/**
+ * find_var_ref - Check if a trigger has a reference to a trigger variable
+ * @hist_data: The hist trigger that might have a reference to the variable
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the list of var_refs[] on the first hist trigger to see
+ * whether any of them are references to the variable on the second
+ * trigger.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
@@ -1325,6 +1348,20 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 	return found;
 }
 
+/**
+ * find_any_var_ref - Check if there is a reference to a given trigger variable
+ * @hist_data: The hist trigger
+ * @var_idx: The trigger variable identifier
+ *
+ * Check to see whether the given variable is currently referenced by
+ * any other trigger.
+ *
+ * The trigger the variable is defined on is explicitly excluded - the
+ * assumption being that a self-reference doesn't prevent a trigger
+ * from being removed.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 					   unsigned int var_idx)
 {
@@ -1343,6 +1380,19 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 	return found;
 }
 
+/**
+ * check_var_refs - Check if there is a reference to any of trigger's variables
+ * @hist_data: The hist trigger
+ *
+ * A trigger can define one or more variables.  If any one of them is
+ * currently referenced by any other trigger, this function will
+ * determine that.
+
+ * Typically used to determine whether or not a trigger can be removed
+ * - if there are any references to a trigger's variables, it cannot.
+ *
+ * Return: True if there is a reference to any of trigger's variables
+ */
 static bool check_var_refs(struct hist_trigger_data *hist_data)
 {
 	struct hist_field *field;
@@ -2346,7 +2396,23 @@ static int init_var_ref(struct hist_field *ref_field,
 	goto out;
 }
 
-static struct hist_field *create_var_ref(struct hist_field *var_field,
+/**
+ * create_var_ref - Create a variable reference and attach it to trigger
+ * @hist_data: The trigger that will be referencing the variable
+ * @var_field: The VAR field to create a reference to
+ * @system: The optional system string
+ * @event_name: The optional event_name string
+ *
+ * Given a variable hist_field, create a VAR_REF hist_field that
+ * represents a reference to it.
+ *
+ * This function also adds the reference to the trigger that
+ * now references the variable.
+ *
+ * Return: The VAR_REF field if successful, NULL if not
+ */
+static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
+					 struct hist_field *var_field,
 					 char *system, char *event_name)
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
@@ -2358,6 +2424,9 @@ static struct hist_field *create_var_ref(struct hist_field *var_field,
 			destroy_hist_field(ref_field, 0);
 			return NULL;
 		}
+
+		hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+		ref_field->var_ref_idx = hist_data->n_var_refs++;
 	}
 
 	return ref_field;
@@ -2431,7 +2500,8 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 	var_field = find_event_var(hist_data, system, event_name, var_name);
 	if (var_field)
-		ref_field = create_var_ref(var_field, system, event_name);
+		ref_field = create_var_ref(hist_data, var_field,
+					   system, event_name);
 
 	if (!ref_field)
 		hist_err_event("Couldn't find variable: $",
@@ -2549,8 +2619,6 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	if (!s) {
 		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
 		if (hist_field) {
-			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
-			hist_field->var_ref_idx = hist_data->n_var_refs++;
 			if (var_name) {
 				hist_field = create_alias(hist_data, hist_field, var_name);
 				if (!hist_field) {
@@ -3324,7 +3392,6 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	unsigned int var_ref_idx = hist_data->n_var_refs;
 	struct field_var *field_var;
 	char *onmax_var_str, *param;
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -3341,18 +3408,10 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 		return -EINVAL;
 	}
 
-	flags = HIST_FIELD_FL_VAR_REF;
-	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
+	ref_field = create_var_ref(hist_data, var_field, NULL, NULL);
 	if (!ref_field)
 		return -ENOMEM;
 
-	if (init_var_ref(ref_field, var_field, NULL, NULL)) {
-		destroy_hist_field(ref_field, 0);
-		ret = -ENOMEM;
-		goto out;
-	}
-	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
-	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->onmax.var = ref_field;
 
 	data->fn = onmax_save;
@@ -3541,9 +3600,6 @@ static void save_synth_var_ref(struct hist_trigger_data *hist_data,
 			 struct hist_field *var_ref)
 {
 	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-
-	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
-	var_ref->var_ref_idx = hist_data->n_var_refs++;
 }
 
 static int check_synth_field(struct synth_event *event,
@@ -3697,7 +3753,8 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (check_synth_field(event, hist_field, field_pos) == 0) {
-			var_ref = create_var_ref(hist_field, system, event_name);
+			var_ref = create_var_ref(hist_data, hist_field,
+						 system, event_name);
 			if (!var_ref) {
 				kfree(p);
 				ret = -ENOMEM;
-- 
2.14.1
