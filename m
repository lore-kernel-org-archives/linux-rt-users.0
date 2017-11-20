From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 18/37] tracing: Add simple expression support to hist
 triggers
Date: Mon, 20 Nov 2017 15:05:06 +0900
Message-ID: <20171120060506.GA20701@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <9a80920fb2cc43c929341f70f9c46acde2242fd9.1510948725.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9a80920fb2cc43c929341f70f9c46acde2242fd9.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Fri, Nov 17, 2017 at 02:32:57PM -0600, Tom Zanussi wrote:
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
> +	char *expr;
> +
> +	if (level > 1)
> +		return NULL;
> +
> +	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	if (!expr)
> +		return NULL;
> +
> +	if (field->operator == FIELD_OP_UNARY_MINUS) {
> +		char *subexpr;
> +
> +		strcat(expr, "-(");
> +		subexpr = expr_str(field->operands[0], ++level);
> +		if (!subexpr) {
> +			kfree(expr);
> +			return NULL;
> +		}
> +		strcat(expr, subexpr);
> +		strcat(expr, ")");
> +
> +		return expr;

The subexpr was leaked.

Thanks,
Namhyung


> +	}
> +
> +	strcat(expr, hist_field_name(field->operands[0], 0));
> +	if (field->operands[0]->flags) {
> +		const char *flags_str = get_hist_field_flags(field->operands[0]);
> +
> +		if (flags_str) {
> +			strcat(expr, ".");
> +			strcat(expr, flags_str);
> +		}
> +	}
> +
> +	switch (field->operator) {
> +	case FIELD_OP_MINUS:
> +		strcat(expr, "-");
> +		break;
> +	case FIELD_OP_PLUS:
> +		strcat(expr, "+");
> +		break;
> +	default:
> +		kfree(expr);
> +		return NULL;
> +	}
> +
> +	strcat(expr, hist_field_name(field->operands[1], 0));
> +	if (field->operands[1]->flags) {
> +		const char *flags_str = get_hist_field_flags(field->operands[1]);
> +
> +		if (flags_str) {
> +			strcat(expr, ".");
> +			strcat(expr, flags_str);
> +		}
> +	}
> +
> +	return expr;
> +}
