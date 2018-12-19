From: Tom Zanussi <tzanussi@gmail.com>
Subject: [PATCH v2 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
Date: Wed, 19 Dec 2018 13:09:16 -0600
Message-ID: <1545246556.4239.7.camel@gmail.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Since all the variable reference hist_fields are collected into
hist_data->var_refs[] array, there's no need to go through all the
fields looking for them, or in separate arrays like synth_var_refs[],
which will be going away soon anyway.

This also allows us to get rid of some unnecessary code and functions
currently used for the same purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 68 +++++++---------------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 25d06b3ae1f6..f3caf6e484f4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1297,75 +1297,29 @@ check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
 			unsigned int var_idx)
 {
-	struct hist_field *found = NULL;
-
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
-
-	found = check_field_for_var_ref(hist_field, var_data, var_idx);
-	if (found)
-		return found;
-
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
-		struct hist_field *operand;
+	WARN_ON(!(hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF));
 
-		operand = hist_field->operands[i];
-		found = check_field_for_var_refs(hist_data, operand, var_data,
-						 var_idx, level + 1);
-		if (found)
-			return found;
-	}
+	if (hist_field && hist_field->var.idx == var_idx &&
+	    hist_field->var.hist_data == var_data)
+		return hist_field;
 
-	return found;
+	return NULL;
 }
 
 static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
 {
-	struct hist_field *hist_field, *found = NULL;
+	struct hist_field *hist_field;
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
-		if (found)
-			return found;
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		if (check_field_for_var_ref(hist_field, var_data, var_idx))
+			return hist_field;
 	}
 
-	return found;
+	return NULL;
 }
 
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
-- 
2.14.1
