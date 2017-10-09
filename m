From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 12/33] tracing: Add variable support to hist triggers
Date: Mon, 9 Oct 2017 12:27:27 +0900
Message-ID: <20171009032727.GA6357@danjae.aot.lge.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
 <00ac0ead22391be1e2689d901d63684ea3823bab.1506105131.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <00ac0ead22391be1e2689d901d63684ea3823bab.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Fri, Sep 22, 2017 at 02:59:52PM -0500, Tom Zanussi wrote:
> Add support for saving the value of a current event's event field by
> assigning it to a variable that can be read by a subsequent event.
> 
> The basic syntax for saving a variable is to simply prefix a unique
> variable name not corresponding to any keyword along with an '=' sign
> to any event field.
> 
> Both keys and values can be saved and retrieved in this way:
> 
>     # echo 'hist:keys=next_pid:vals=$ts0:ts0=common_timestamp ...

The 'common_timestamp' needs a '$' prefix, right?

>     # echo 'hist:timer_pid=common_pid:key=$timer_pid ...'
> 
> If a variable isn't a key variable or prefixed with 'vals=', the
> associated event field will be saved in a variable but won't be summed
> as a value:
> 
>     # echo 'hist:keys=next_pid:ts1=common_timestamp:...

Ditto.

> 
> Multiple variables can be assigned at the same time:
> 
>     # echo 'hist:keys=pid:vals=$ts0,$b,field2:ts0=common_timestamp,b=field1 ...
> 
> Multiple (or single) variables can also be assigned at the same time
> using separate assignments:
> 
>     # echo 'hist:keys=pid:vals=$ts0:ts0=common_timestamp:b=field1:c=field2 ...

Same here..

So you separated the variable definition and it should not be a part
of key or value field, right?

> 
> Variables set as above can be used by being referenced from another
> event, as described in a subsequent patch.

That means, a variable should be unique (in a tracing instance at least).


> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 374 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 334 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c2abe41..0d99548 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -30,6 +30,13 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
>  				struct ring_buffer_event *rbe);
>  
>  #define HIST_FIELD_OPERANDS_MAX	2
> +#define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
> +
> +struct hist_var {
> +	char				*name;
> +	struct hist_trigger_data	*hist_data;
> +	unsigned int			idx;
> +};
>  
>  struct hist_field {
>  	struct ftrace_event_field	*field;
> @@ -40,6 +47,7 @@ struct hist_field {
>  	unsigned int                    is_signed;
>  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
>  	struct hist_trigger_data	*hist_data;
> +	struct hist_var			var;
>  };
>  
>  static u64 hist_field_none(struct hist_field *field, void *event,
> @@ -138,6 +146,14 @@ enum hist_field_flags {
>  	HIST_FIELD_FL_LOG2		= 1 << 9,
>  	HIST_FIELD_FL_TIMESTAMP		= 1 << 10,
>  	HIST_FIELD_FL_TIMESTAMP_USECS	= 1 << 11,
> +	HIST_FIELD_FL_VAR		= 1 << 12,
> +	HIST_FIELD_FL_VAR_ONLY		= 1 << 13,

And then I'm not sure what _VAR_ONLY flag is for.  IIUC it's used to
identify pure variable definition from a definition in value fields.
But it's not possible anymore, no?


> +};
> +
> +struct var_defs {
> +	unsigned int	n_vars;
> +	char		*name[TRACING_MAP_VARS_MAX];
> +	char		*expr[TRACING_MAP_VARS_MAX];
>  };
>

[SNIP]

> +static int create_var_field(struct hist_trigger_data *hist_data,
> +			    unsigned int val_idx,
> +			    struct trace_event_file *file,
> +			    char *var_name, char *expr_str)
> +{
> +	unsigned long flags = 0;
> +
> +	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
> +		return -EINVAL;
> +
> +	if (find_var(file, var_name) && !hist_data->remove) {

Is this for the uniqueness check?  But I think it only checks
variables in the current event (file).


> +		return -EINVAL;
> +	}
> +
> +	flags |= HIST_FIELD_FL_VAR;
> +	hist_data->n_vars++;
> +	if (hist_data->n_vars > TRACING_MAP_VARS_MAX) {
> +		return -EINVAL;
> +	}
> +
> +	flags |= HIST_FIELD_FL_VAR_ONLY;
> +
> +	return __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
> +}
> +

[SNIP]

> +static int parse_var_defs(struct hist_trigger_data *hist_data)
> +{
> +	char *s, *str, *var_name, *field_str;
> +	unsigned int i, j, n_vars = 0;
> +	int ret = 0;
> +
> +	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
> +		str = hist_data->attrs->assignment_str[i];
> +		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
> +			field_str = strsep(&str, ",");
> +			if (!field_str)
> +				break;
> +
> +			var_name = strsep(&field_str, "=");
> +			if (!var_name || !field_str) {
> +				ret = -EINVAL;
> +				goto free;
> +			}
> +
> +			s = kstrdup(var_name, GFP_KERNEL);
> +			if (!s) {
> +				ret = -ENOMEM;
> +				goto free;
> +			}
> +			hist_data->attrs->var_defs.name[n_vars] = s;
> +
> +			s = kstrdup(field_str, GFP_KERNEL);
> +			if (!s) {
> +				ret = -ENOMEM;
> +				goto free;

It seems that it might leak the copy of var_name here..

Thanks,
Namhyung


> +			}
> +			hist_data->attrs->var_defs.expr[n_vars++] = s;
> +
> +			hist_data->attrs->var_defs.n_vars = n_vars;
> +
> +			if (n_vars == TRACING_MAP_VARS_MAX)
> +				goto free;
> +		}
> +	}
> +
> +	return ret;
> + free:
> +	free_var_defs(hist_data);
> +
> +	return ret;
> +}
> +
