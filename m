From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference checking
Date: Tue, 18 Dec 2018 14:33:22 -0600
Message-ID: <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
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

Since all the variable reference hist_fields are collected into
hist_data->var_refs[] array, there's no need to go through all the
fields looking for them, or in separate arrays like synth_var_refs[],
which will be going away soon anyway.

This also allows us to get rid of some unnecessary code and functions
currently used for the same purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 57 +++++-----------------------------------
 1 file changed, 7 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 25d06b3ae1f6..ee839c52bd3f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1299,45 +1299,11 @@ check_field_for_var_ref(struct hist_field *hist_field,
 {
 	struct hist_field *found = NULL;
 
-	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-		if (hist_field->var.idx == var_idx &&
-		    hist_field->var.hist_data == var_data) {
-			found = hist_field;
-		}
-	}
-
-	return found;
-}
-
-static struct hist_field *
-check_field_for_var_refs(struct hist_trigger_data *hist_data,
-			 struct hist_field *hist_field,
-			 struct hist_trigger_data *var_data,
-			 unsigned int var_idx,
-			 unsigned int level)
-{
-	struct hist_field *found = NULL;
-	unsigned int i;
-
-	if (level > 3)
-		return found;
-
-	if (!hist_field)
-		return found;
+	WARN_ON(!(hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF));
 
-	found = check_field_for_var_ref(hist_field, var_data, var_idx);
-	if (found)
-		return found;
-
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
-		struct hist_field *operand;
-
-		operand = hist_field->operands[i];
-		found = check_field_for_var_refs(hist_data, operand, var_data,
-						 var_idx, level + 1);
-		if (found)
-			return found;
-	}
+	if (hist_field && hist_field->var.idx == var_idx &&
+	    hist_field->var.hist_data == var_data)
+		found = hist_field;
 
 	return found;
 }
@@ -1349,18 +1315,9 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 	struct hist_field *hist_field, *found = NULL;
 	unsigned int i;
 
-	for_each_hist_field(i, hist_data) {
-		hist_field = hist_data->fields[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
-	}
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
-		hist_field = hist_data->synth_var_refs[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		found = check_field_for_var_ref(hist_field, var_data, var_idx);
 		if (found)
 			return found;
 	}
-- 
2.14.1
