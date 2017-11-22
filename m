From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 26/37] tracing: Add 'onmatch' hist trigger action
 support
Date: Wed, 22 Nov 2017 18:49:56 +0900
Message-ID: <20171122094955.GA2221@danjae.aot.lge.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <cb8329d8ff410082472191be48bfb99e7aafc6a2.1510948725.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <cb8329d8ff410082472191be48bfb99e7aafc6a2.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 17, 2017 at 02:33:05PM -0600, Tom Zanussi wrote:
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
>     # echo 'hist:testpid=pid:keys=$testpid:\
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
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> ---

[SNIP]
> +static int onmatch_create(struct hist_trigger_data *hist_data,
> +			  struct trace_event_file *file,
> +			  struct action_data *data)
> +{
> +	char *event_name, *param, *system = NULL;
> +	struct hist_field *hist_field, *var_ref;
> +	unsigned int i, var_ref_idx;
> +	unsigned int field_pos = 0;
> +	struct synth_event *event;
> +	int ret = 0;
> +
> +	mutex_lock(&synth_event_mutex);
> +	event = find_synth_event(data->onmatch.synth_event_name);
> +	if (!event) {
> +		mutex_unlock(&synth_event_mutex);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&synth_event_mutex);
> +
> +	var_ref_idx = hist_data->n_var_refs;
> +
> +	for (i = 0; i < data->n_params; i++) {
> +		char *p;
> +
> +		p = param = kstrdup(data->params[i], GFP_KERNEL);
> +		if (!param) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		system = strsep(&param, ".");
> +		if (!param) {
> +			param = (char *)system;
> +			system = event_name = NULL;
> +		} else {
> +			event_name = strsep(&param, ".");
> +			if (!param) {
> +				kfree(p);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +
> +		if (param[0] == '$')

What about $common_timestamp ?


> +			hist_field = onmatch_find_var(hist_data, data, system,
> +						      event_name, param);
> +		else
> +			hist_field = onmatch_create_field_var(hist_data, data,
> +							      system,
> +							      event_name,
> +							      param);
> +
> +		if (!hist_field) {
> +			kfree(p);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (check_synth_field(event, hist_field, field_pos) == 0) {
> +			var_ref = create_var_ref(hist_field, system, event_name);
> +			if (!var_ref) {
> +				kfree(p);
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			save_synth_var_ref(hist_data, var_ref);
> +			field_pos++;
> +			kfree(p);
> +			continue;
> +		}
> +
> +		kfree(p);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (field_pos != event->n_fields) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	data->fn = action_trace;
> +	data->onmatch.synth_event = event;
> +	data->onmatch.var_ref_idx = var_ref_idx;
> +	event->ref++;

Is it safe to update the refcount without synth_event_mutex?

Thanks,
Namhyung


> + out:
> +	return ret;
> +}
