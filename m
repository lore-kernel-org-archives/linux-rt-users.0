From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v8 22/22] tracing: Add hist trigger comments for variable-related fields
Date: Mon, 10 Dec 2018 18:01:36 -0600
Message-ID: <095c3bd35a755500fcb3eb1a26d0c3240bb4e688.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a few comments to help clarify how variable and variable reference
fields are used in the code.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 81e998bb601e..de5748ff8775 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -40,6 +40,16 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+/*
+ * A hist_var (histogram variable) contains variable information for
+ * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
+ * flag set.  A hist_var has a variable name e.g. ts0, and is
+ * associated with a given histogram trigger, as specified by
+ * hist_data.  The hist_var idx is the unique index assigned to the
+ * variable by the hist trigger's tracing_map.  The idx is what is
+ * used to set a variable's value and, by a variable reference, to
+ * retrieve it.
+ */
 struct hist_var {
 	char				*name;
 	struct hist_trigger_data	*hist_data;
@@ -56,11 +66,29 @@ struct hist_field {
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+
+	/*
+	 * Variable fields contain variable-specific info in var.
+	 */
 	struct hist_var			var;
 	enum field_op_id		operator;
 	char				*system;
 	char				*event_name;
+
+	/*
+	 * The name field is used for EXPR and VAR_REF fields.  VAR
+	 * fields contain the variable name in var.name.
+	 */
 	char				*name;
+
+	/*
+	 * When a histogram trigger is hit, if it has any references
+	 * to variables, the values of those variables are collected
+	 * into a var_ref_vals array by resolve_var_refs().  The
+	 * current value of each variable is read from the tracing_map
+	 * using the hist field's hist_var.idx and entered into the
+	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
+	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -389,6 +417,14 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	/*
+	 * When a histogram trigger is hit, the values of any
+	 * references to variables, including variables being passed
+	 * as parameters to synthetic events, are collected into a
+	 * var_ref_vals array.  This var_ref_idx is the index of the
+	 * first param in the array to be passed to the synthetic
+	 * event invocation.
+	 */
 	unsigned int		var_ref_idx;
 	struct synth_event	*synth_event;
 	bool			use_trace_keyword;
-- 
2.14.1
