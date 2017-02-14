From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 13/21] tracing: Add simple expression support to
 hist triggers
Date: Tue, 14 Feb 2017 11:37:26 +0900
Message-ID: <20170214023726.GM14705@sejong>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
 <0ec36d09fff75cfa8fe241b2e3026400cf22880f.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: <rostedt@goodmis.org>, <tglx@linutronix.de>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:37513 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBNChc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 21:37:32 -0500
In-Reply-To: <0ec36d09fff75cfa8fe241b2e3026400cf22880f.1486569306.git.tom.zanussi@linux.intel.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 08, 2017 at 11:25:09AM -0600, Tom Zanussi wrote:
> Add support for simple addition, subtraction, and unary expressions
> (-(expr) and expr, where expr = b-a, a+b, a+b+c) to hist triggers, in
> order to support a minimal set of useful inter-event calculations.
> 
> These operations are needed for calculating latencies between events
> (timestamp1-timestamp0) and for combined latencies (latencies over 3
> or more events).
> 
> In the process, factor out some common code from key and value
> parsing.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> +static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> +				     struct trace_event_file *file,
> +				     char *str, unsigned long flags,
> +				     char *var_name);
> +
> +static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
> +				      struct trace_event_file *file,
> +				      char *str, unsigned long flags,
> +				      char *var_name)
> +{
> +	struct hist_field *operand1, *expr = NULL;
> +	struct ftrace_event_field *field = NULL;
> +	unsigned long operand_flags;
> +	char *operand1_str;
> +	int ret = 0;
> +	char *s;
> +
> +	// we support only -(xxx) i.e. explicit parens required
> +
> +	str++; // skip leading '-'
> +
> +	s = strchr(str, '(');
> +	if (s)
> +		str++;
> +	else {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	s = strchr(str, ')');
> +	if (s)
> +		*s = '\0';
> +	else {
> +		ret = -EINVAL; // no closing ')'
> +		goto free;
> +	}
> +
> +	operand1_str = strsep(&str, "(");
> +	if (!operand1_str)
> +		goto free;
> +
> +	flags |= HIST_FIELD_FL_EXPR;
> +	expr = create_hist_field(NULL, flags, var_name);
> +	if (!expr) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	operand_flags = 0;
> +	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL);

Doesn't it create an unbounded recursion?

Thanks,
Namhyung


> +	if (IS_ERR(operand1)) {
> +		ret = PTR_ERR(operand1);
> +		goto free;
> +	}
> +
> +	if (operand1 == NULL) {
> +		operand_flags = 0;
> +		field = parse_field(hist_data, file, operand1_str,
> +				    &operand_flags);
> +		if (IS_ERR(field)) {
> +			ret = PTR_ERR(field);
> +			goto free;
> +		}
> +		operand1 = create_hist_field(field, operand_flags, NULL);
> +		if (!operand1) {
> +			ret = -ENOMEM;
> +			goto free;
> +		}
> +	}
> +
> +	expr->fn = hist_field_unary_minus;
> +	expr->operands[0] = operand1;
> +	expr->operator = FIELD_OP_UNARY_MINUS;
> +	expr->name = expr_str(expr);
> +
> +	return expr;
> + free:
> +	return ERR_PTR(ret);
> +}
> +
> +static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> +				     struct trace_event_file *file,
> +				     char *str, unsigned long flags,
> +				     char *var_name)
> +{
> +	struct hist_field *operand1, *operand2, *expr = NULL;
> +	struct ftrace_event_field *field = NULL;
> +	unsigned long operand_flags;
> +	int field_op, ret = -EINVAL;
> +	char *sep, *operand1_str;
> +
> +	field_op = contains_operator(str);
> +	if (field_op == FIELD_OP_NONE)
> +		return NULL;
> +
> +	if (field_op == FIELD_OP_UNARY_MINUS)
> +		return parse_unary(hist_data, file, str, flags, var_name);
> +
> +	switch (field_op) {
> +	case FIELD_OP_MINUS:
> +		sep = "-";
> +		break;
> +	case FIELD_OP_PLUS:
> +		sep = "+";
> +		break;
> +	default:
> +		goto free;
> +	}
> +
> +	operand1_str = strsep(&str, sep);
> +	if (!operand1_str || !str)
> +		goto free;
> +
> +	operand_flags = 0;
> +	field = parse_field(hist_data, file, operand1_str, &operand_flags);
> +	if (IS_ERR(field)) {
> +		ret = PTR_ERR(field);
> +		goto free;
> +	}
> +	operand1 = create_hist_field(field, operand_flags, NULL);
> +	if (!operand1) {
> +		ret = -ENOMEM;
> +		operand1 = NULL;
> +		goto free;
> +	}
> +
> +	// rest of string could be another expression e.g. b+c in a+b+c
> +	operand_flags = 0;
> +	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL);
> +	if (IS_ERR(operand2)) {
> +		ret = PTR_ERR(operand2);
> +		operand2 = NULL;
> +		goto free;
> +	}
> +	if (!operand2) {
> +		operand_flags = 0;
> +		field = parse_field(hist_data, file, str, &operand_flags);
> +		if (IS_ERR(field)) {
> +			ret = PTR_ERR(field);
> +			goto free;
> +		}
> +		operand2 = create_hist_field(field, operand_flags, NULL);
> +		if (!operand2) {
> +			ret = -ENOMEM;
> +			operand2 = NULL;
> +			goto free;
> +		}
> +	}
> +
> +	flags |= HIST_FIELD_FL_EXPR;
> +	expr = create_hist_field(NULL, flags, var_name);
> +	if (!expr) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	expr->operands[0] = operand1;
> +	expr->operands[1] = operand2;
> +	expr->operator = field_op;
> +	expr->name = expr_str(expr);
> +
> +	switch (field_op) {
> +	case FIELD_OP_MINUS:
> +		expr->fn = hist_field_minus;
> +		break;
> +	case FIELD_OP_PLUS:
> +		expr->fn = hist_field_plus;
> +		break;
> +	default:
> +		goto free;
> +	}
> +
> +	return expr;
> + free:
> +	destroy_hist_field(operand1);
> +	destroy_hist_field(operand2);
> +	destroy_hist_field(expr);
> +
> +	return ERR_PTR(ret);
> +}
> +
>  static int create_hitcount_val(struct hist_trigger_data *hist_data)
>  {
>  	hist_data->fields[HITCOUNT_IDX] =
> @@ -529,8 +874,9 @@ static int create_val_field(struct hist_trigger_data *hist_data,
>  			    char *field_str, char *var_name)
>  {
>  	struct ftrace_event_field *field = NULL;
> -	char *field_name, *token;
> +	struct hist_field *hist_field;
>  	unsigned long flags = 0;
> +	char *token;
>  	int ret = 0;
>  
>  	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
> @@ -549,32 +895,27 @@ static int create_val_field(struct hist_trigger_data *hist_data,
>  		flags |= HIST_FIELD_FL_VAR;
>  	}
>  
> -	field_name = strsep(&field_str, ".");
> -	if (field_str) {
> -		if (strcmp(field_str, "hex") == 0)
> -			flags |= HIST_FIELD_FL_HEX;
> -		else {
> -			ret = -EINVAL;
> +	hist_field = parse_expr(hist_data, file, field_str, flags, var_name);
> +	if (IS_ERR(hist_field)) {
> +		ret = PTR_ERR(hist_field);
> +		goto out;
> +	}
> +
> +	if (!hist_field) {
> +		field = parse_field(hist_data, file, field_str, &flags);
> +		if (IS_ERR(field)) {
> +			ret = PTR_ERR(field);
>  			goto out;
>  		}
> -	}
>  
> -	if (strcmp(field_name, "common_timestamp") == 0) {
> -		flags |= HIST_FIELD_FL_TIMESTAMP;
> -		hist_data->enable_timestamps = true;
> -	} else {
> -		field = trace_find_event_field(file->event_call, field_name);
> -		if (!field) {
> -			ret = -EINVAL;
> +		hist_field = create_hist_field(field, flags, var_name);
> +		if (!hist_field) {
> +			ret = -ENOMEM;
>  			goto out;
>  		}
>  	}
>  
> -	hist_data->fields[val_idx] = create_hist_field(field, flags, var_name);
> -	if (!hist_data->fields[val_idx]) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	hist_data->fields[val_idx] = hist_field;
>  
>  	++hist_data->n_vals;
>  
> @@ -623,6 +964,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
>  			    char *field_str)
>  {
>  	struct ftrace_event_field *field = NULL;
> +	struct hist_field *hist_field;
>  	unsigned long flags = 0;
>  	unsigned int key_size;
>  	char *var_name;
> @@ -640,53 +982,40 @@ static int create_key_field(struct hist_trigger_data *hist_data,
>  	if (strcmp(field_str, "stacktrace") == 0) {
>  		flags |= HIST_FIELD_FL_STACKTRACE;
>  		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
> +		hist_field = create_hist_field(field, flags, var_name);
>  	} else {
> -		char *field_name = strsep(&field_str, ".");
> -
> -		if (field_str) {
> -			if (strcmp(field_str, "hex") == 0)
> -				flags |= HIST_FIELD_FL_HEX;
> -			else if (strcmp(field_str, "sym") == 0)
> -				flags |= HIST_FIELD_FL_SYM;
> -			else if (strcmp(field_str, "sym-offset") == 0)
> -				flags |= HIST_FIELD_FL_SYM_OFFSET;
> -			else if ((strcmp(field_str, "execname") == 0) &&
> -				 (strcmp(field_name, "common_pid") == 0))
> -				flags |= HIST_FIELD_FL_EXECNAME;
> -			else if (strcmp(field_str, "syscall") == 0)
> -				flags |= HIST_FIELD_FL_SYSCALL;
> -			else if (strcmp(field_str, "log2") == 0)
> -				flags |= HIST_FIELD_FL_LOG2;
> -			else {
> -				ret = -EINVAL;
> -				goto out;
> -			}
> +		hist_field = parse_expr(hist_data, file, field_str, flags,
> +					var_name);
> +		if (IS_ERR(hist_field)) {
> +			ret = PTR_ERR(hist_field);
> +			goto out;
>  		}
>  
> -		if (strcmp(field_name, "common_timestamp") == 0) {
> -			flags |= HIST_FIELD_FL_TIMESTAMP;
> -			hist_data->enable_timestamps = true;
> -			key_size = sizeof(u64);
> -		} else {
> -			field = trace_find_event_field(file->event_call, field_name);
> -			if (!field) {
> -				ret = -EINVAL;
> +		if (!hist_field) {
> +			field = parse_field(hist_data, file, field_str,
> +					    &flags);
> +			if (IS_ERR(field)) {
> +				ret = PTR_ERR(field);
>  				goto out;
>  			}
>  
> -			if (is_string_field(field))
> -				key_size = MAX_FILTER_STR_VAL;
> -			else
> -				key_size = field->size;
> +			hist_field = create_hist_field(field, flags, var_name);
> +			if (!hist_field) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
>  		}
> -	}
>  
> -	hist_data->fields[key_idx] = create_hist_field(field, flags, var_name);
> -	if (!hist_data->fields[key_idx]) {
> -		ret = -ENOMEM;
> -		goto out;
> +		if (flags & HIST_FIELD_FL_TIMESTAMP)
> +			key_size = sizeof(u64);
> +		else if (is_string_field(field))
> +			key_size = MAX_FILTER_STR_VAL;
> +		else
> +			key_size = field->size;
>  	}
>  
> +	hist_data->fields[key_idx] = hist_field;
> +
>  	key_size = ALIGN(key_size, sizeof(u64));
>  	hist_data->fields[key_idx]->size = key_size;
>  	hist_data->fields[key_idx]->offset = key_offset;
> -- 
> 1.9.3
> 
