From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 25/37] tracing: Add support for 'field variables'
Date: Tue, 21 Nov 2017 21:08:47 +0900
Message-ID: <20171121120847.GA22114@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <aba56805d86084cc9634ada2bd5ad4de845d4afd.1510948725.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <aba56805d86084cc9634ada2bd5ad4de845d4afd.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 17, 2017 at 02:33:04PM -0600, Tom Zanussi wrote:
> Users should be able to directly specify event fields in hist trigger
> 'actions' rather than being forced to explicitly create a variable for
> that purpose.
> 
> Add support allowing fields to be used directly in actions, which
> essentially does just that - creates 'invisible' variables for each
> bare field specified in an action.  If a bare field refers to a field
> on another (matching) event, it even creates a special histogram for
> the purpose (since variables can't be defined on an existing histogram
> after histogram creation).
> 
> Here's a simple example that demonstrates both.  Basically the
> onmatch() action creates a list of variables corresponding to the
> parameters of the synthetic event to be generated, and then uses those
> values to generate the event.  So for the wakeup_latency synthetic
> event 'call' below the first param, $wakeup_lat, is a variable defined
> explicitly on sched_switch, where 'next_pid' is just a normal field on
> sched_switch, and prio is a normal field on sched_waking.
> 
> Since the mechanism works on variables, those two normal fields just
> have 'invisible' variables created internally for them.  In the case of
> 'prio', which is on another event, we actually need to create an
> additional hist trigger and define the invisible variable on that, since
> once a hist trigger is defined, variables can't be added to it later.
> 
>   echo 'wakeup_latency u64 lat; pid_t pid; int prio' >>
>        /sys/kernel/debug/tracing/synthetic_events
> 
>   echo 'hist:keys=pid:ts0=$common_timestamp.usecs >>
>        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> 
> echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:
>       onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,prio)
>             >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> +struct hist_field *
> +create_field_var_hist(struct hist_trigger_data *target_hist_data,
> +		      char *subsys_name, char *event_name, char *field_name)
> +{
> +	struct trace_array *tr = target_hist_data->event_file->tr;
> +	struct hist_field *event_var = ERR_PTR(-EINVAL);
> +	struct hist_trigger_data *hist_data;
> +	unsigned int i, n, first = true;
> +	struct field_var_hist *var_hist;
> +	struct trace_event_file *file;
> +	struct hist_field *key_field;
> +	char *saved_filter;
> +	char *cmd;
> +	int ret;
> +
> +	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	file = event_file(tr, subsys_name, event_name);
> +
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/*
> +	 * Look for a histogram compatible with target.  We'll use the
> +	 * found histogram specification to create a new matching
> +	 * histogram with our variable on it.  target_hist_data is not
> +	 * yet a registered histogram so we can't use that.
> +	 */
> +	hist_data = find_compatible_hist(target_hist_data, file);
> +	if (!hist_data)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* See if a synthetic field variable has already been created */
> +	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
> +					     event_name, field_name);
> +	if (event_var && !IS_ERR(event_var))

You can use IS_ERR_OR_NULL().

> +		return event_var;
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
> +	/* Use the same keys as the compatible histogram */
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
> +	/* Create the synthetic field variable specification */
> +	strcat(cmd, ":synthetic_");
> +	strcat(cmd, field_name);
> +	strcat(cmd, "=");
> +	strcat(cmd, field_name);
> +
> +	/* Use the same filter as the compatible histogram */
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
> +	/* Save the compatible histogram information */
> +	var_hist->hist_data = hist_data;
> +
> +	/* Create the new histogram with our variable */
> +	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> +				      "", "hist", cmd);
> +	if (ret) {
> +		kfree(cmd);
> +		kfree(var_hist->cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(ret);
> +	}
> +
> +	kfree(cmd);
> +
> +	/* If we can't find the variable, something went wrong */
> +	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
> +					     event_name, field_name);
> +	if (!event_var || IS_ERR(event_var)) {

Again, IS_ERR_OR_NULL could be used.

> +		kfree(cmd);

It seems like a double-free.

Thanks,
Namhyung


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
