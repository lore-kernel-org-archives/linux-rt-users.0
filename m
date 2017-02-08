From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 13/21] tracing: Add simple expression support to hist triggers
Date: Wed,  8 Feb 2017 11:25:09 -0600
Message-ID: <0ec36d09fff75cfa8fe241b2e3026400cf22880f.1486569306.git.tom.zanussi@linux.intel.com>
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

Add support for simple addition, subtraction, and unary expressions
(-(expr) and expr, where expr = b-a, a+b, a+b+c) to hist triggers, in
order to support a minimal set of useful inter-event calculations.

These operations are needed for calculating latencies between events
(timestamp1-timestamp0) and for combined latencies (latencies over 3
or more events).

In the process, factor out some common code from key and value
parsing.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 445 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 387 insertions(+), 58 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 889455e..cea95b6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -31,6 +31,13 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_ASSIGNMENT_MAX	4
 
+enum field_op_id {
+	FIELD_OP_NONE,
+	FIELD_OP_PLUS,
+	FIELD_OP_MINUS,
+	FIELD_OP_UNARY_MINUS,
+};
+
 struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
@@ -41,6 +48,8 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	u64				var_val;
 	char				*var_name;
+	enum field_op_id		operator;
+	char				*name;
 };
 
 static u64 hist_field_none(struct hist_field *field, void *event,
@@ -81,6 +90,47 @@ static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
 	return (u64)(unsigned long)*addr;
 }
 
+static u64 hist_field_var_val(struct hist_field *hist_field, void *event,
+			      struct ring_buffer_event *rbe)
+{
+	return hist_field->var_val;
+}
+
+static u64 hist_field_plus(struct hist_field *hist_field, void *event,
+			   struct ring_buffer_event *rbe)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, event, rbe);
+	u64 val2 = operand2->fn(operand2, event, rbe);
+
+	return val1 + val2;
+}
+
+static u64 hist_field_minus(struct hist_field *hist_field, void *event,
+			    struct ring_buffer_event *rbe)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, event, rbe);
+	u64 val2 = operand2->fn(operand2, event, rbe);
+
+	return val1 - val2;
+}
+
+static u64 hist_field_unary_minus(struct hist_field *hist_field, void *event,
+				  struct ring_buffer_event *rbe)
+{
+	struct hist_field *operand = hist_field->operands[0];
+
+	s64 sval = (s64)operand->fn(operand, event, rbe);
+	u64 val = (u64)-sval;
+
+	return val;
+}
+
 static u64 hist_field_log2(struct hist_field *hist_field, void *event,
 			   struct ring_buffer_event *rbe)
 {
@@ -145,7 +195,8 @@ enum hist_field_flags {
 	HIST_FIELD_FL_LOG2		= 512,
 	HIST_FIELD_FL_VAR		= 1024,
 	HIST_FIELD_FL_VAR_ONLY		= 2048,
-	HIST_FIELD_FL_TIMESTAMP		= 4096,
+	HIST_FIELD_FL_EXPR		= 4096,
+	HIST_FIELD_FL_TIMESTAMP		= 8192,
 };
 
 struct hist_trigger_attrs {
@@ -183,6 +234,10 @@ static const char *hist_field_name(struct hist_field *field)
 		field_name = field->field->name;
 	else if (field->flags & HIST_FIELD_FL_LOG2)
 		field_name = hist_field_name(field->operands[0]);
+	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_EXPR)
+		field_name = field->name;
 
 	return field_name;
 }
@@ -407,6 +462,44 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
 		save_comm(comm, current);
 }
 
+static struct ftrace_event_field *
+parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
+	    char *field_str, unsigned long *flags)
+{
+	struct ftrace_event_field *field = NULL;
+	char *field_name;
+
+	field_name = strsep(&field_str, ".");
+	if (field_str) {
+		if (strcmp(field_str, "hex") == 0)
+			*flags |= HIST_FIELD_FL_HEX;
+		else if (strcmp(field_str, "sym") == 0)
+			*flags |= HIST_FIELD_FL_SYM;
+		else if (strcmp(field_str, "sym-offset") == 0)
+			*flags |= HIST_FIELD_FL_SYM_OFFSET;
+		else if ((strcmp(field_str, "execname") == 0) &&
+			 (strcmp(field_name, "common_pid") == 0))
+			*flags |= HIST_FIELD_FL_EXECNAME;
+		else if (strcmp(field_str, "syscall") == 0)
+			*flags |= HIST_FIELD_FL_SYSCALL;
+		else if (strcmp(field_str, "log2") == 0)
+			*flags |= HIST_FIELD_FL_LOG2;
+		else
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (strcmp(field_name, "common_timestamp") == 0) {
+		*flags |= HIST_FIELD_FL_TIMESTAMP;
+		hist_data->enable_timestamps = true;
+	} else {
+		field = trace_find_event_field(file->event_call, field_name);
+		if (!field)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return field;
+}
+
 static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
 	.elt_alloc	= hist_trigger_elt_comm_alloc,
 	.elt_copy	= hist_trigger_elt_comm_copy,
@@ -414,6 +507,73 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
 	.elt_init	= hist_trigger_elt_comm_init,
 };
 
+static char *expr_str(struct hist_field *field)
+{
+	char *expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+
+	if (!expr)
+		return NULL;
+
+	if (field->operator == FIELD_OP_UNARY_MINUS) {
+		char *subexpr;
+
+		strcat(expr, "-(");
+		subexpr = expr_str(field->operands[0]);
+		if (!subexpr) {
+			kfree(expr);
+			return NULL;
+		}
+		strcat(expr, subexpr);
+		strcat(expr, ")");
+
+		return expr;
+	}
+
+	strcat(expr, hist_field_name(field->operands[0]));
+
+	switch (field->operator) {
+	case FIELD_OP_MINUS:
+		strcat(expr, "-");
+		break;
+	case FIELD_OP_PLUS:
+		strcat(expr, "+");
+		break;
+	default:
+		kfree(expr);
+		return NULL;
+	}
+
+	strcat(expr, hist_field_name(field->operands[1]));
+
+	return expr;
+}
+
+static int contains_operator(char *str)
+{
+	enum field_op_id field_op = FIELD_OP_NONE;
+	char *op;
+
+	op = strpbrk(str, "+-");
+	if (!op)
+		return FIELD_OP_NONE;
+
+	switch (*op) {
+	case '-':
+		if (*str == '-')
+			field_op = FIELD_OP_UNARY_MINUS;
+		else
+			field_op = FIELD_OP_MINUS;
+		break;
+	case '+':
+		field_op = FIELD_OP_PLUS;
+		break;
+	default:
+		break;
+	}
+
+	return field_op;
+}
+
 static void destroy_hist_field(struct hist_field *hist_field)
 {
 	unsigned int i;
@@ -425,6 +585,7 @@ static void destroy_hist_field(struct hist_field *hist_field)
 		destroy_hist_field(hist_field->operands[i]);
 
 	kfree(hist_field->var_name);
+	kfree(hist_field->name);
 
 	kfree(hist_field);
 }
@@ -443,6 +604,9 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 		return NULL;
 	hist_field->is_signed = false;
 
+	if (flags & HIST_FIELD_FL_EXPR)
+		goto out; /* caller will populate */
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		goto out;
@@ -508,6 +672,187 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 	}
 }
 
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name);
+
+static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
+				      struct trace_event_file *file,
+				      char *str, unsigned long flags,
+				      char *var_name)
+{
+	struct hist_field *operand1, *expr = NULL;
+	struct ftrace_event_field *field = NULL;
+	unsigned long operand_flags;
+	char *operand1_str;
+	int ret = 0;
+	char *s;
+
+	// we support only -(xxx) i.e. explicit parens required
+
+	str++; // skip leading '-'
+
+	s = strchr(str, '(');
+	if (s)
+		str++;
+	else {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	s = strchr(str, ')');
+	if (s)
+		*s = '\0';
+	else {
+		ret = -EINVAL; // no closing ')'
+		goto free;
+	}
+
+	operand1_str = strsep(&str, "(");
+	if (!operand1_str)
+		goto free;
+
+	flags |= HIST_FIELD_FL_EXPR;
+	expr = create_hist_field(NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	operand_flags = 0;
+	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
+		goto free;
+	}
+
+	if (operand1 == NULL) {
+		operand_flags = 0;
+		field = parse_field(hist_data, file, operand1_str,
+				    &operand_flags);
+		if (IS_ERR(field)) {
+			ret = PTR_ERR(field);
+			goto free;
+		}
+		operand1 = create_hist_field(field, operand_flags, NULL);
+		if (!operand1) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
+	expr->fn = hist_field_unary_minus;
+	expr->operands[0] = operand1;
+	expr->operator = FIELD_OP_UNARY_MINUS;
+	expr->name = expr_str(expr);
+
+	return expr;
+ free:
+	return ERR_PTR(ret);
+}
+
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name)
+{
+	struct hist_field *operand1, *operand2, *expr = NULL;
+	struct ftrace_event_field *field = NULL;
+	unsigned long operand_flags;
+	int field_op, ret = -EINVAL;
+	char *sep, *operand1_str;
+
+	field_op = contains_operator(str);
+	if (field_op == FIELD_OP_NONE)
+		return NULL;
+
+	if (field_op == FIELD_OP_UNARY_MINUS)
+		return parse_unary(hist_data, file, str, flags, var_name);
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		sep = "-";
+		break;
+	case FIELD_OP_PLUS:
+		sep = "+";
+		break;
+	default:
+		goto free;
+	}
+
+	operand1_str = strsep(&str, sep);
+	if (!operand1_str || !str)
+		goto free;
+
+	operand_flags = 0;
+	field = parse_field(hist_data, file, operand1_str, &operand_flags);
+	if (IS_ERR(field)) {
+		ret = PTR_ERR(field);
+		goto free;
+	}
+	operand1 = create_hist_field(field, operand_flags, NULL);
+	if (!operand1) {
+		ret = -ENOMEM;
+		operand1 = NULL;
+		goto free;
+	}
+
+	// rest of string could be another expression e.g. b+c in a+b+c
+	operand_flags = 0;
+	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL);
+	if (IS_ERR(operand2)) {
+		ret = PTR_ERR(operand2);
+		operand2 = NULL;
+		goto free;
+	}
+	if (!operand2) {
+		operand_flags = 0;
+		field = parse_field(hist_data, file, str, &operand_flags);
+		if (IS_ERR(field)) {
+			ret = PTR_ERR(field);
+			goto free;
+		}
+		operand2 = create_hist_field(field, operand_flags, NULL);
+		if (!operand2) {
+			ret = -ENOMEM;
+			operand2 = NULL;
+			goto free;
+		}
+	}
+
+	flags |= HIST_FIELD_FL_EXPR;
+	expr = create_hist_field(NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	expr->operands[0] = operand1;
+	expr->operands[1] = operand2;
+	expr->operator = field_op;
+	expr->name = expr_str(expr);
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		expr->fn = hist_field_minus;
+		break;
+	case FIELD_OP_PLUS:
+		expr->fn = hist_field_plus;
+		break;
+	default:
+		goto free;
+	}
+
+	return expr;
+ free:
+	destroy_hist_field(operand1);
+	destroy_hist_field(operand2);
+	destroy_hist_field(expr);
+
+	return ERR_PTR(ret);
+}
+
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
@@ -529,8 +874,9 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 			    char *field_str, char *var_name)
 {
 	struct ftrace_event_field *field = NULL;
-	char *field_name, *token;
+	struct hist_field *hist_field;
 	unsigned long flags = 0;
+	char *token;
 	int ret = 0;
 
 	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
@@ -549,32 +895,27 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		flags |= HIST_FIELD_FL_VAR;
 	}
 
-	field_name = strsep(&field_str, ".");
-	if (field_str) {
-		if (strcmp(field_str, "hex") == 0)
-			flags |= HIST_FIELD_FL_HEX;
-		else {
-			ret = -EINVAL;
+	hist_field = parse_expr(hist_data, file, field_str, flags, var_name);
+	if (IS_ERR(hist_field)) {
+		ret = PTR_ERR(hist_field);
+		goto out;
+	}
+
+	if (!hist_field) {
+		field = parse_field(hist_data, file, field_str, &flags);
+		if (IS_ERR(field)) {
+			ret = PTR_ERR(field);
 			goto out;
 		}
-	}
 
-	if (strcmp(field_name, "common_timestamp") == 0) {
-		flags |= HIST_FIELD_FL_TIMESTAMP;
-		hist_data->enable_timestamps = true;
-	} else {
-		field = trace_find_event_field(file->event_call, field_name);
-		if (!field) {
-			ret = -EINVAL;
+		hist_field = create_hist_field(field, flags, var_name);
+		if (!hist_field) {
+			ret = -ENOMEM;
 			goto out;
 		}
 	}
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags, var_name);
-	if (!hist_data->fields[val_idx]) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	hist_data->fields[val_idx] = hist_field;
 
 	++hist_data->n_vals;
 
@@ -623,6 +964,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			    char *field_str)
 {
 	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field;
 	unsigned long flags = 0;
 	unsigned int key_size;
 	char *var_name;
@@ -640,53 +982,40 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	if (strcmp(field_str, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
+		hist_field = create_hist_field(field, flags, var_name);
 	} else {
-		char *field_name = strsep(&field_str, ".");
-
-		if (field_str) {
-			if (strcmp(field_str, "hex") == 0)
-				flags |= HIST_FIELD_FL_HEX;
-			else if (strcmp(field_str, "sym") == 0)
-				flags |= HIST_FIELD_FL_SYM;
-			else if (strcmp(field_str, "sym-offset") == 0)
-				flags |= HIST_FIELD_FL_SYM_OFFSET;
-			else if ((strcmp(field_str, "execname") == 0) &&
-				 (strcmp(field_name, "common_pid") == 0))
-				flags |= HIST_FIELD_FL_EXECNAME;
-			else if (strcmp(field_str, "syscall") == 0)
-				flags |= HIST_FIELD_FL_SYSCALL;
-			else if (strcmp(field_str, "log2") == 0)
-				flags |= HIST_FIELD_FL_LOG2;
-			else {
-				ret = -EINVAL;
-				goto out;
-			}
+		hist_field = parse_expr(hist_data, file, field_str, flags,
+					var_name);
+		if (IS_ERR(hist_field)) {
+			ret = PTR_ERR(hist_field);
+			goto out;
 		}
 
-		if (strcmp(field_name, "common_timestamp") == 0) {
-			flags |= HIST_FIELD_FL_TIMESTAMP;
-			hist_data->enable_timestamps = true;
-			key_size = sizeof(u64);
-		} else {
-			field = trace_find_event_field(file->event_call, field_name);
-			if (!field) {
-				ret = -EINVAL;
+		if (!hist_field) {
+			field = parse_field(hist_data, file, field_str,
+					    &flags);
+			if (IS_ERR(field)) {
+				ret = PTR_ERR(field);
 				goto out;
 			}
 
-			if (is_string_field(field))
-				key_size = MAX_FILTER_STR_VAL;
-			else
-				key_size = field->size;
+			hist_field = create_hist_field(field, flags, var_name);
+			if (!hist_field) {
+				ret = -ENOMEM;
+				goto out;
+			}
 		}
-	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags, var_name);
-	if (!hist_data->fields[key_idx]) {
-		ret = -ENOMEM;
-		goto out;
+		if (flags & HIST_FIELD_FL_TIMESTAMP)
+			key_size = sizeof(u64);
+		else if (is_string_field(field))
+			key_size = MAX_FILTER_STR_VAL;
+		else
+			key_size = field->size;
 	}
 
+	hist_data->fields[key_idx] = hist_field;
+
 	key_size = ALIGN(key_size, sizeof(u64));
 	hist_data->fields[key_idx]->size = key_size;
 	hist_data->fields[key_idx]->offset = key_offset;
-- 
1.9.3
