From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 19/33] tracing: Add variable reference handling to
 hist triggers
Date: Mon, 9 Oct 2017 21:46:35 +0900
Message-ID: <20171009124635.GA7378@danjae.aot.lge.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
 <d92ae1de648410d7488f8787d9a2ec876d40aba6.1506105131.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <d92ae1de648410d7488f8787d9a2ec876d40aba6.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Sep 22, 2017 at 02:59:59PM -0500, Tom Zanussi wrote:
> Add the necessary infrastructure to allow the variables defined on one
> event to be referenced in another.  This allows variables set by a
> previous event to be referenced and used in expressions combining the
> variable values saved by that previous event and the event fields of
> the current event.  For example, here's how a latency can be
> calculated and saved into yet another variable named 'wakeup_lat':
> 
>     # echo 'hist:keys=pid,prio:ts0=common_timestamp ...
>     # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...
> 
> In the first event, the event's timetamp is saved into the variable
> ts0.  In the next line, ts0 is subtracted from the second event's
> timestamp to produce the latency.
> 
> Further users of variable references will be described in subsequent
> patches, such as for instance how the 'wakeup_lat' variable above can
> be displayed in a latency histogram.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace.c                |   2 +
>  kernel/trace/trace.h                |   3 +
>  kernel/trace/trace_events_hist.c    | 613 ++++++++++++++++++++++++++++++++----
>  kernel/trace/trace_events_trigger.c |   6 +
>  4 files changed, 568 insertions(+), 56 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 19ffbe1..5eb313a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7753,6 +7753,7 @@ static int instance_mkdir(const char *name)
>  
>  	INIT_LIST_HEAD(&tr->systems);
>  	INIT_LIST_HEAD(&tr->events);
> +	INIT_LIST_HEAD(&tr->hist_vars);
>  
>  	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
>  		goto out_free_tr;
> @@ -8500,6 +8501,7 @@ __init static int tracer_alloc_buffers(void)
>  
>  	INIT_LIST_HEAD(&global_trace.systems);
>  	INIT_LIST_HEAD(&global_trace.events);
> +	INIT_LIST_HEAD(&global_trace.hist_vars);
>  	list_add(&global_trace.list, &ftrace_trace_arrays);
>  
>  	apply_trace_boot_options();
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 02bfd5c..7b78762 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -273,6 +273,7 @@ struct trace_array {
>  	int			function_enabled;
>  #endif
>  	int			time_stamp_abs_ref;
> +	struct list_head	hist_vars;
>  };
>  
>  enum {
> @@ -1547,6 +1548,8 @@ extern int save_named_trigger(const char *name,
>  extern void unpause_named_trigger(struct event_trigger_data *data);
>  extern void set_named_trigger_data(struct event_trigger_data *data,
>  				   struct event_trigger_data *named_data);
> +extern struct event_trigger_data *
> +get_named_trigger_data(struct event_trigger_data *data);
>  extern int register_event_command(struct event_command *cmd);
>  extern int unregister_event_command(struct event_command *cmd);
>  extern int register_trigger_hist_enable_disable_cmds(void);
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 02170df..6dcef22 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -60,6 +60,9 @@ struct hist_field {
>  	struct hist_var			var;
>  	enum field_op_id		operator;
>  	char				*name;
> +	unsigned int			var_idx;
> +	unsigned int			var_ref_idx;
> +	bool                            read_once;
>  };
>  
>  static u64 hist_field_none(struct hist_field *field,
> @@ -215,6 +218,7 @@ enum hist_field_flags {
>  	HIST_FIELD_FL_VAR		= 1 << 12,
>  	HIST_FIELD_FL_VAR_ONLY		= 1 << 13,
>  	HIST_FIELD_FL_EXPR		= 1 << 14,
> +	HIST_FIELD_FL_VAR_REF		= 1 << 15,
>  };
>  
>  struct var_defs {
> @@ -255,6 +259,8 @@ struct hist_trigger_data {
>  	struct tracing_map		*map;
>  	bool				enable_timestamps;
>  	bool				remove;
> +	struct hist_field               *var_refs[TRACING_MAP_VARS_MAX];
> +	unsigned int			n_var_refs;
>  };
>  
>  static u64 hist_field_timestamp(struct hist_field *hist_field,
> @@ -273,10 +279,344 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
>  	return ts;
>  }
>  
> +struct hist_var_data {
> +	struct list_head list;
> +	struct hist_trigger_data *hist_data;
> +};
> +
> +static struct hist_field *check_var_ref(struct hist_field *hist_field,
> +					struct hist_trigger_data *var_data,
> +					unsigned int var_idx)
> +{
> +	struct hist_field *found = NULL;
> +
> +	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
> +		if (hist_field->var.idx == var_idx &&
> +		    hist_field->var.hist_data == var_data) {
> +			found = hist_field;
> +		}
> +	}
> +
> +	return found;
> +}
> +
> +static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
> +				       struct hist_trigger_data *var_data,
> +				       unsigned int var_idx)
> +{
> +	struct hist_field *hist_field, *found = NULL;
> +	unsigned int i, j;
> +
> +	for_each_hist_field(i, hist_data) {
> +		hist_field = hist_data->fields[i];
> +		found = check_var_ref(hist_field, var_data, var_idx);
> +		if (found)
> +			return found;
> +
> +		for (j = 0; j < HIST_FIELD_OPERANDS_MAX; j++) {
> +			struct hist_field *operand;
> +
> +			operand = hist_field->operands[j];
> +			found = check_var_ref(operand, var_data, var_idx);
> +			if (found)
> +				return found;
> +		}

Hmm.. IIUC expression can be nested but it seems to miss var-ref at
level 2 - something like "a + b + $c", no?


> +	}
> +
> +	return found;
> +}
> +
> +static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
> +					   unsigned int var_idx)
> +{
> +	struct trace_array *tr = hist_data->event_file->tr;
> +	struct hist_field *found = NULL;
> +	struct hist_var_data *var_data;
> +
> +	list_for_each_entry(var_data, &tr->hist_vars, list) {
> +		found = find_var_ref(var_data->hist_data, hist_data, var_idx);
> +		if (found)
> +			break;

Shouldn't it check self-references - i.e. ref from the same hist_data?


> +	}
> +
> +	return found;
> +}
> +
> +static bool check_var_refs(struct hist_trigger_data *hist_data)
> +{
> +	struct hist_field *field;
> +	bool found = false;
> +	int i;
> +
> +	for_each_hist_field(i, hist_data) {
> +		field = hist_data->fields[i];
> +		if (field && field->flags & HIST_FIELD_FL_VAR) {
> +			if (find_any_var_ref(hist_data, field->var.idx)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return found;
> +}
> +
> +static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
> +{
> +	struct trace_array *tr = hist_data->event_file->tr;
> +	struct hist_var_data *var_data, *found = NULL;
> +
> +	list_for_each_entry(var_data, &tr->hist_vars, list) {
> +		if (var_data->hist_data == hist_data) {
> +			found = var_data;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
> +static bool has_hist_vars(struct hist_trigger_data *hist_data)
> +{
> +	struct hist_field *hist_field;
> +	int i, j;
> +
> +	for_each_hist_field(i, hist_data) {
> +		hist_field = hist_data->fields[i];
> +		if (hist_field &&
> +		    (hist_field->flags & HIST_FIELD_FL_VAR ||
> +		     hist_field->flags & HIST_FIELD_FL_VAR_REF))
> +			return true;
> +
> +		for (j = 0; j < HIST_FIELD_OPERANDS_MAX; j++) {
> +			struct hist_field *operand;
> +
> +			operand = hist_field->operands[j];
> +			if (operand &&
> +			    (operand->flags & HIST_FIELD_FL_VAR ||
> +			     operand->flags & HIST_FIELD_FL_VAR_REF))
> +				return true;

Same with the above.

Thanks,
Namhyung


> +		}
> +	}
> +
> +	return false;
> +}
> +
