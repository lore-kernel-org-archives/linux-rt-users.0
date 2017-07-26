From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 23/32] tracing: Add 'onmatch' hist trigger action support
Date: Wed, 26 Jul 2017 11:40:19 +0900
Message-ID: <20170726024019.GA32043@sejong>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <8411497118160688b13fcf500596f6094d2eabcd.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8411497118160688b13fcf500596f6094d2eabcd.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, Jun 26, 2017 at 05:49:24PM -0500, Tom Zanussi wrote:
> Add an 'onmatch(matching.event).<synthetic_event_name>(param list)'
> hist trigger action which is invoked with the set of variables or
> event fields named in the 'param list'.  The result is the generation
> of a synthetic event that consists of the values contained in those
> variables and/or fields at the time the invoking event was hit.
> 
> As an example the below defines a simple synthetic event using a
> variable defined on the sched_wakeup_new event, and shows the event
> definition with unresolved fields, since the sched_wakeup_new event
> with the testpid variable hasn't been defined yet:
> 
>     # echo 'wakeup_new_test pid_t pid; int prio' >> \
>       /sys/kernel/debug/tracing/synthetic_events
> 
>     # cat /sys/kernel/debug/tracing/synthetic_events
>       wakeup_new_test pid_t pid; int prio
> 
> The following hist trigger both defines a testpid variable and
> specifies an onmatch() trace action that uses that variable along with
> a non-variable field to generate a wakeup_new_test synthetic event
> whenever a sched_wakeup_new event occurs, which because of the 'if
> comm == "cyclictest"' filter only happens when the executable is
> cyclictest:
> 
>     # echo 'hist:keys=testpid=pid:\
>       onmatch(sched.sched_wakeup_new).wakeup_new_test($testpid, prio) \
>         if comm=="cyclictest"' >> \
>       /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
> 
> Creating and displaying a histogram based on those events is now just
> a matter of using the fields and new synthetic event in the
> tracing/events/synthetic directory, as usual:
> 
>     # echo 'hist:keys=pid,prio:sort=pid,prio' >> \
>       /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
>  static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
>  {
> +	struct hist_trigger_data *hist_data = elt->map->private_data;
>  	struct hist_elt_data *private_data = elt->private_data;
> +	unsigned int i, n_str;
> +
> +	n_str = hist_data->n_field_var_str;
> +
> +	for (i = 0; i < n_str; i++)
> +		kfree(private_data->field_var_str[i]);
>  
>  	kfree(private_data->comm);
>  	kfree(private_data);
> @@ -1537,7 +1627,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
>  	unsigned int size = TASK_COMM_LEN + 1;
>  	struct hist_elt_data *elt_data;
>  	struct hist_field *key_field;
> -	unsigned int i;
> +	unsigned int i, n_str;
>  
>  	elt->private_data = elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
>  	if (!elt_data)
> @@ -1557,6 +1647,16 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
>  		}
>  	}
>  
> +	n_str = hist_data->n_field_var_str;
> +
> +	for (i = 0; i < n_str; i++) {
> +		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);

So the max length of a string variable is TASK_COMM_LEN, right?

In addition, isn't it necessary for hist_trigger_elt_data_copy() to
copy the field_var_str array?


> +		if (!elt_data->field_var_str[i]) {
> +			hist_trigger_elt_data_free(elt);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	return 0;
>  }

[SNIP]
> +static bool compatible_keys(struct hist_trigger_data *target_hist_data,
> +			    struct hist_trigger_data *hist_data,
> +			    unsigned int n_keys)
> +{
> +	struct hist_field *target_hist_field, *hist_field;
> +	unsigned int n, i, j;
> +
> +	if (hist_data->n_fields - hist_data->n_vals != n_keys)
> +		return false;
> +
> +	i = hist_data->n_vals;
> +	j = target_hist_data->n_vals;
> +
> +	for (n = 0; n < n_keys; n++) {
> +		hist_field = hist_data->fields[i + n];
> +		target_hist_field = hist_data->fields[j + n];

Shouldn't it be 'target_hist_field = target_hist_data->fields[j + n]'?
                                     ^^^^^^^^^^^^^^^^

> +
> +		if (strcmp(hist_field->type, target_hist_field->type) != 0)
> +			return false;
> +		if (hist_field->size != target_hist_field->size)
> +			return false;
> +		if (hist_field->is_signed != target_hist_field->is_signed)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static struct hist_trigger_data *
> +find_compatible_hist(struct hist_trigger_data *target_hist_data,
> +		     struct trace_event_file *file)
> +{
> +	struct hist_trigger_data *hist_data;
> +	struct event_trigger_data *test;
> +	unsigned int n_keys;
> +
> +	n_keys = target_hist_data->n_fields - target_hist_data->n_vals;
> +
> +	list_for_each_entry_rcu(test, &file->triggers, list) {
> +		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
> +			hist_data = test->private_data;
> +
> +			if (compatible_keys(target_hist_data, hist_data, n_keys))
> +				return hist_data;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct trace_event_file *event_file(char *system, char *event_name)
> +{
> +	struct trace_event_file *file;
> +	struct trace_array *tr;
> +
> +	tr = top_trace_array();
> +	if (!tr)
> +		return ERR_PTR(-ENODEV);
> +
> +	file = find_event_file(tr, system, event_name);
> +	if (!file)
> +		return ERR_PTR(-EINVAL);
> +
> +	return file;
> +}
> +
> +static struct hist_field *
> +create_field_var_hist(struct hist_trigger_data *target_hist_data,
> +		      char *system, char *event_name, char *field_name)

IIUC this is needed to create a new hist on a match_event only to
provide a variable for a field, right?  I guess it's needed because
adding a new variable is dangerous/unsafe for a running hist.

It'd be nice if you could add more comments though.

Thanks,
Namhyung


> +{
> +	struct hist_field *event_var = ERR_PTR(-EINVAL);
> +	struct hist_trigger_data *hist_data;
> +	unsigned int i, n, first = true;
> +	struct field_var_hist *var_hist;
> +	struct trace_event_file *file;
> +	struct hist_field *key_field;
> +	struct trace_array *tr;
> +	char *saved_filter;
> +	char *cmd;
> +	int ret;
> +
> +	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	tr = top_trace_array();
> +	if (!tr)
> +		return ERR_PTR(-ENODEV);
> +
> +	file = event_file(system, event_name);
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hist_data = find_compatible_hist(target_hist_data, file);
> +	if (!hist_data)
> +		return ERR_PTR(-EINVAL);
> +
> +	var_hist = kzalloc(sizeof(*var_hist), GFP_KERNEL);
> +	if (!var_hist)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	if (!cmd) {
> +		kfree(var_hist);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	strcat(cmd, "keys=");
> +
> +	for_each_hist_key_field(i, hist_data) {
> +		key_field = hist_data->fields[i];
> +		if (!first)
> +			strcat(cmd, ",");
> +		strcat(cmd, key_field->field->name);
> +		first = false;
> +	}
> +
> +	strcat(cmd, ":synthetic_");
> +	strcat(cmd, field_name);
> +	strcat(cmd, "=");
> +	strcat(cmd, field_name);
> +
> +	saved_filter = find_trigger_filter(hist_data, file);
> +	if (saved_filter) {
> +		strcat(cmd, " if ");
> +		strcat(cmd, saved_filter);
> +	}
> +
> +	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
> +	if (!var_hist->cmd) {
> +		kfree(cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	var_hist->hist_data = hist_data;
> +
> +	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> +				      "", "hist", cmd);
> +	if (ret) {
> +		kfree(cmd);
> +		kfree(var_hist->cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(ret);
> +	}
> +
> +	strcpy(cmd, "synthetic_");
> +	strcat(cmd, field_name);
> +
> +	event_var = find_event_var(system, event_name, cmd);
> +	if (!event_var) {
> +		kfree(cmd);
> +		kfree(var_hist->cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	n = target_hist_data->n_field_var_hists;
> +	target_hist_data->field_var_hists[n] = var_hist;
> +	target_hist_data->n_field_var_hists++;
> +
> +	return event_var;
> +}
