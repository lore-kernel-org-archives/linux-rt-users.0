From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 21/37] tracing: Add hist_field 'type' field
Date: Mon, 15 Jan 2018 20:51:55 -0600
Message-ID: <3fd12a2e86316b05151ba0d7c68268e780af2c9d.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Future support for synthetic events requires hist_field 'type'
information, so add a field for that.

Also, make other hist_field attribute usage consistent (size,
is_signed, etc).

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index be083d9..a2800c2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -54,6 +54,7 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
+	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
 	struct hist_var			var;
@@ -717,6 +718,7 @@ static void destroy_hist_field(struct hist_field *hist_field,
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
+	kfree(hist_field->type);
 
 	kfree(hist_field);
 }
@@ -742,6 +744,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -755,12 +761,18 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn = hist_field_log2;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
+		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_TIMESTAMP) {
 		hist_field->fn = hist_field_timestamp;
 		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -770,6 +782,11 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (is_string_field(field)) {
 		flags |= HIST_FIELD_FL_STRING;
 
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
 		if (field->filter_type == FILTER_STATIC_STRING)
 			hist_field->fn = hist_field_string;
 		else if (field->filter_type == FILTER_DYN_STRING)
@@ -777,6 +794,12 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		else
 			hist_field->fn = hist_field_pstring;
 	} else {
+		hist_field->size = field->size;
+		hist_field->is_signed = field->is_signed;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
 		hist_field->fn = select_value_fn(field->size,
 						 field->is_signed);
 		if (!hist_field->fn) {
@@ -949,6 +972,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	return expr;
  free:
@@ -1042,6 +1070,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[1] = operand2;
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	switch (field_op) {
 	case FIELD_OP_MINUS:
-- 
1.9.3
