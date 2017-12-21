From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v8 21/37] tracing: Add hist_field 'type' field
Date: Thu, 21 Dec 2017 10:02:43 -0600
Message-ID: <486f5e6d9e29e545247cbaa6b90ecb3186402b80.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5235 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754100AbdLUQE0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Dec 2017 11:04:26 -0500
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Future support for synthetic events requires hist_field 'type'
information, so add a field for that.

Also, make other hist_field attribute usage consistent (size,
is_signed, etc).

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c0a8be0..4ee9f04 100644
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
@@ -714,6 +715,7 @@ static void destroy_hist_field(struct hist_field *hist_field,
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
+	kfree(hist_field->type);
 
 	kfree(hist_field);
 }
@@ -739,6 +741,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -752,12 +758,18 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
 
@@ -767,6 +779,11 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
@@ -774,6 +791,12 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
@@ -950,6 +973,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
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
@@ -1039,6 +1067,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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

