From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 27/37] tracing: Add 'onmax' hist trigger action support
Date: Thu, 23 Nov 2017 14:09:03 +0900
Message-ID: <20171123050903.GA25472@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <2d9cfba35cc17e8c9ee44256b9244546e9f3106c.1510948725.git.tom.zanussi@linux.intel.com>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:45746 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdKWFJF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Nov 2017 00:09:05 -0500
Content-Disposition: inline
In-Reply-To: <2d9cfba35cc17e8c9ee44256b9244546e9f3106c.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 17, 2017 at 02:33:06PM -0600, Tom Zanussi wrote:
> Add an 'onmax(var).save(field,...)' hist trigger action which is
> invoked whenever an event exceeds the current maximum.
> 
> The end result is that the trace event fields or variables specified
> as the onmax.save() params will be saved if 'var' exceeds the current
> maximum for that hist trigger entry.  This allows context from the
> event that exhibited the new maximum to be saved for later reference.
> When the histogram is displayed, additional fields displaying the
> saved values will be printed.
> 
> As an example the below defines a couple of hist triggers, one for
> sched_wakeup and another for sched_switch, keyed on pid.  Whenever a
> sched_wakeup occurs, the timestamp is saved in the entry corresponding
> to the current pid, and when the scheduler switches back to that pid,
> the timestamp difference is calculated.  If the resulting latency
> exceeds the current maximum latency, the specified save() values are
> saved:
> 
>     # echo 'hist:keys=pid:ts0=$common_timestamp.usecs \
>         if comm=="cyclictest"' >> \
>       /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> 
>     # echo 'hist:keys=next_pid:\
>       wakeup_lat=$common_timestamp.usecs-$ts0:\
>       onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
>         if next_comm=="cyclictest"' >> \
>       /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> When the histogram is displayed, the max value and the saved values
> corresponding to the max are displayed following the rest of the
> fields:
> 
>     # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
> 
>       { next_pid:       3728 } hitcount:        199 \
>         max:        123  next_comm: cyclictest  prev_pid:          0 \
> 	prev_prio:        120  prev_comm: swapper/3
>       { next_pid:       3730 } hitcount:       1321 \
>         max:         15  next_comm: cyclictest  prev_pid:          0 \
> 	prev_prio:        120  prev_comm: swapper/1
>       { next_pid:       3729 } hitcount:       1973\
>         max:         25  next_comm: cyclictest  prev_pid:          0  \
> 	prev_prio:        120  prev_comm: swapper/0
> 
>     Totals:
>         Hits: 3493
>         Entries: 3
> 	Dropped: 0
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> +static int onmax_create(struct hist_trigger_data *hist_data,
> +			struct action_data *data)
> +{
> +	struct trace_event_call *call = hist_data->event_file->event_call;
> +	struct trace_event_file *file = hist_data->event_file;
> +	struct hist_field *var_field, *ref_field, *max_var;
> +	unsigned int var_ref_idx = hist_data->n_var_refs;
> +	struct field_var *field_var;
> +	char *onmax_var_str, *param;
> +	const char *event_name;
> +	unsigned long flags;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	onmax_var_str = data->onmax.var_str;
> +	if (onmax_var_str[0] != '$')
> +		return -EINVAL;
> +	onmax_var_str++;
> +
> +	event_name = trace_event_name(call);

It seems not used.


> +	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
> +	if (!var_field)
> +		return -EINVAL;
> +
> +	flags = HIST_FIELD_FL_VAR_REF;
> +	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
> +	if (!ref_field)
> +		return -ENOMEM;
> +
> +	if (init_var_ref(ref_field, var_field, NULL, NULL)) {
> +		destroy_hist_field(ref_field, 0);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
> +	ref_field->var_ref_idx = hist_data->n_var_refs++;
> +	data->onmax.var = ref_field;

I was confused that this could create a reference to self-variable
which would prevent a hist from being freed.  IIUC it tries to avoid
such a self reference by using local field variable and disallowing
variable of expression, right?

But it seems that's not the case since the reference is saved in other
place than hist_data->fields which is used in find_var_ref().


> +
> +	data->fn = onmax_save;
> +	data->onmax.max_var_ref_idx = var_ref_idx;
> +	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
> +	if (IS_ERR(max_var)) {
> +		ret = PTR_ERR(max_var);
> +		goto out;
> +	}
> +	data->onmax.max_var = max_var;
> +
> +	for (i = 0; i < data->n_params; i++) {
> +		param = kstrdup(data->params[i], GFP_KERNEL);
> +		if (!param) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		field_var = create_target_field_var(hist_data, NULL, NULL, param);
> +		if (IS_ERR(field_var)) {
> +			ret = PTR_ERR(field_var);
> +			kfree(param);
> +			goto out;
> +		}
> +
> +		hist_data->max_vars[hist_data->n_max_vars++] = field_var;
> +		if (field_var->val->flags & HIST_FIELD_FL_STRING)
> +			hist_data->n_max_var_str++;
> +
> +		kfree(param);
> +	}
> + out:
> +	return ret;
> +}
> +

[SNIP]
> +static struct action_data *onmax_parse(char *str)
> +{
> +	char *onmax_fn_name, *onmax_var_str;
> +	struct action_data *data;
> +	int ret = -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	onmax_var_str = strsep(&str, ")");
> +	if (!onmax_var_str || !str)
> +		return ERR_PTR(-EINVAL);

'data' leaked.

Thanks,
Namhyung


> +	data->onmax.var_str = kstrdup(onmax_var_str, GFP_KERNEL);
> +	if (!data->onmax.var_str) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	strsep(&str, ".");
> +	if (!str)
> +		goto free;
> +
> +	onmax_fn_name = strsep(&str, "(");
> +	if (!onmax_fn_name || !str)
> +		goto free;
> +
> +	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
> +		char *params = strsep(&str, ")");
> +
> +		if (!params) {
> +			ret = -EINVAL;
> +			goto free;
> +		}
> +
> +		ret = parse_action_params(params, data);
> +		if (ret)
> +			goto free;
> +	} else
> +		goto free;
> +
> +	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
> +	if (!data->onmax.fn_name) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> + out:
> +	return data;
> + free:
> +	onmax_destroy(data);
> +	data = ERR_PTR(ret);
> +	goto out;
> +}
