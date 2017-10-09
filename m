From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 15/33] tracing: Add simple expression support to hist
 triggers
Date: Mon, 9 Oct 2017 21:54:01 +0900
Message-ID: <20171009125401.GA7788@danjae.aot.lge.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
 <6a4903ab375ffbf9d76cc2c2193efaec1c751b54.1506105131.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a4903ab375ffbf9d76cc2c2193efaec1c751b54.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Sep 22, 2017 at 02:59:55PM -0500, Tom Zanussi wrote:
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
> +static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
> +				      struct trace_event_file *file,
> +				      char *str, unsigned long flags,
> +				      char *var_name, unsigned int level)
> +{
> +	struct hist_field *operand1, *expr = NULL;
> +	unsigned long operand_flags;
> +	int ret = 0;
> +	char *s;
> +
> +	// we support only -(xxx) i.e. explicit parens required
> +
> +	if (level > 2) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
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
> +	strsep(&str, "(");
> +	if (!str) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	flags |= HIST_FIELD_FL_EXPR;
> +	expr = create_hist_field(hist_data, NULL, flags, var_name);
> +	if (!expr) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	operand_flags = 0;
> +	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
> +	if (IS_ERR(operand1)) {
> +		ret = PTR_ERR(operand1);
> +		goto free;
> +	}
> +
> +	expr->fn = hist_field_unary_minus;
> +	expr->operands[0] = operand1;
> +	expr->operator = FIELD_OP_UNARY_MINUS;
> +	expr->name = expr_str(expr, 0);
> +
> +	return expr;
> + free:

Missing destroy_hist_field(expr, 0)?

Thanks,
Namhyung


> +	return ERR_PTR(ret);
> +}
> +
