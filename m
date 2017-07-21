From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 18/32] tracing: Add simple expression support to hist
 triggers
Date: Fri, 21 Jul 2017 11:02:18 +0900
Message-ID: <20170721020218.GB21128@danjae.aot.lge.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <f58c1e58b42f26a53cbc6e0ed660a6717d78acf4.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f58c1e58b42f26a53cbc6e0ed660a6717d78acf4.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, Jun 26, 2017 at 05:49:19PM -0500, Tom Zanussi wrote:
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
> +static char *expr_str(struct hist_field *field, unsigned int level)
> +{
> +	char *expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +
> +	if (!expr || level > 1)
> +		return NULL;

Looks like a memory leak.


[SNIP]
> +static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> +				     struct trace_event_file *file,
> +				     char *str, unsigned long flags,
> +				     char *var_name, unsigned int level)
> +{
> +	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
> +	unsigned long operand_flags;
> +	int field_op, ret = -EINVAL;
> +	char *sep, *operand1_str;
> +
> +	if (level > 2)
> +		return NULL;
> +
> +	field_op = contains_operator(str);
> +	if (field_op == FIELD_OP_NONE)
> +		return NULL;

Why not calling parse_atom() here?  It'd make the code simpler IMHO.

Thanks,
Namhyung


> +
> +	if (field_op == FIELD_OP_UNARY_MINUS)
> +		return parse_unary(hist_data, file, str, flags, var_name, ++level);
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
> +	operand1 = parse_atom(hist_data, file, operand1_str,
> +			      &operand_flags, NULL);
> +	if (IS_ERR(operand1)) {
> +		ret = PTR_ERR(operand1);
> +		operand1 = NULL;
> +		goto free;
> +	}
> +
> +	// rest of string could be another expression e.g. b+c in a+b+c
> +	operand_flags = 0;
> +	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
> +	if (IS_ERR(operand2)) {
> +		ret = PTR_ERR(operand2);
> +		operand2 = NULL;
> +		goto free;
> +	}
> +	if (!operand2) {
> +		operand_flags = 0;
> +		operand2 = parse_atom(hist_data, file, str,
> +				      &operand_flags, NULL);
> +		if (IS_ERR(operand2)) {
> +			ret = PTR_ERR(operand2);
> +			operand2 = NULL;
> +			goto free;
> +		}
> +	}
> +
> +	flags |= HIST_FIELD_FL_EXPR;
> +	expr = create_hist_field(hist_data, NULL, flags, var_name);
> +	if (!expr) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	expr->operands[0] = operand1;
> +	expr->operands[1] = operand2;
> +	expr->operator = field_op;
> +	expr->name = expr_str(expr, 0);
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
> +	destroy_hist_field(operand1, 0);
> +	destroy_hist_field(operand2, 0);
> +	destroy_hist_field(expr, 0);
> +
> +	return ERR_PTR(ret);
> +}
