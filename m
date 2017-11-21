From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 24/37] tracing: Add support for 'synthetic' events
Date: Tue, 21 Nov 2017 20:32:11 +0900
Message-ID: <20171121113211.GB17299@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <2bbfcf24f73a41b9c7140d49cfc5e3874ac96432.1510948725.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <2bbfcf24f73a41b9c7140d49cfc5e3874ac96432.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 17, 2017 at 02:33:03PM -0600, Tom Zanussi wrote:
> Synthetic events are user-defined events generated from hist trigger
> variables saved from one or more other events.
> 
> To define a synthetic event, the user writes a simple specification
> consisting of the name of the new event along with one or more
> variables and their type(s), to the tracing/synthetic_events file.
> 
> For instance, the following creates a new event named 'wakeup_latency'
> with 3 fields: lat, pid, and prio:
> 
>     # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
>       /sys/kernel/debug/tracing/synthetic_events
> 
> Reading the tracing/synthetic_events file lists all the
> currently-defined synthetic events, in this case the event we defined
> above:
> 
>     # cat /sys/kernel/debug/tracing/synthetic_events
>     wakeup_latency u64 lat; pid_t pid; int prio
> 
> At this point, the synthetic event is ready to use, and a histogram
> can be defined using it:
> 
>     # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
>     /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
> 
> The new event is created under the tracing/events/synthetic/ directory
> and looks and behaves just like any other event:
> 
>     # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
>       enable  filter  format  hist  id  trigger
> 
> Although a histogram can be defined for it, nothing will happen until
> an action tracing that event via the trace_synth() function occurs.
> The trace_synth() function is very similar to all the other trace_*
> invocations spread throughout the kernel, except in this case the
> trace_ function and its corresponding tracepoint isn't statically
> generated but defined by the user at run-time.
> 
> How this can be automatically hooked up via a hist trigger 'action' is
> discussed in a subsequent patch.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> [fix noderef.cocci warnings, sizeof pointer for kcalloc of event->fields]
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---

[SNIP]
> +static int synth_field_size(char *type)
> +{
> +	int size = 0;
> +
> +	if (strcmp(type, "s64") == 0)
> +		size = sizeof(s64);
> +	else if (strcmp(type, "u64") == 0)
> +		size = sizeof(u64);
> +	else if (strcmp(type, "s32") == 0)
> +		size = sizeof(s32);
> +	else if (strcmp(type, "u32") == 0)
> +		size = sizeof(u32);
> +	else if (strcmp(type, "s16") == 0)
> +		size = sizeof(s16);
> +	else if (strcmp(type, "u16") == 0)
> +		size = sizeof(u16);
> +	else if (strcmp(type, "s8") == 0)
> +		size = sizeof(s8);
> +	else if (strcmp(type, "u8") == 0)
> +		size = sizeof(u8);
> +	else if (strcmp(type, "char") == 0)
> +		size = sizeof(char);
> +	else if (strcmp(type, "unsigned char") == 0)
> +		size = sizeof(unsigned char);
> +	else if (strcmp(type, "int") == 0)
> +		size = sizeof(int);
> +	else if (strcmp(type, "unsigned int") == 0)
> +		size = sizeof(unsigned int);
> +	else if (strcmp(type, "long") == 0)
> +		size = sizeof(long);
> +	else if (strcmp(type, "unsigned long") == 0)
> +		size = sizeof(unsigned long);
> +	else if (strcmp(type, "pid_t") == 0)
> +		size = sizeof(pid_t);
> +	else if (synth_field_is_string(type))
> +		size = synth_field_string_size(type);
> +
> +	return size;
> +}
> +
> +static const char *synth_field_fmt(char *type)
> +{
> +	const char *fmt = "%llu";
> +
> +	if (strcmp(type, "s64") == 0)
> +		fmt = "%lld";
> +	else if (strcmp(type, "u64") == 0)
> +		fmt = "%llu";
> +	else if (strcmp(type, "s32") == 0)
> +		fmt = "%d";
> +	else if (strcmp(type, "u32") == 0)
> +		fmt = "%u";
> +	else if (strcmp(type, "s16") == 0)
> +		fmt = "%d";
> +	else if (strcmp(type, "u16") == 0)
> +		fmt = "%u";
> +	else if (strcmp(type, "s8") == 0)
> +		fmt = "%d";
> +	else if (strcmp(type, "u8") == 0)
> +		fmt = "%u";
> +	else if (strcmp(type, "char") == 0)
> +		fmt = "%d";
> +	else if (strcmp(type, "unsigned char") == 0)
> +		fmt = "%u";
> +	else if (strcmp(type, "int") == 0)
> +		fmt = "%d";
> +	else if (strcmp(type, "unsigned int") == 0)
> +		fmt = "%u";
> +	else if (strcmp(type, "long") == 0)
> +		fmt = "%ld";
> +	else if (strcmp(type, "unsigned long") == 0)
> +		fmt = "%lu";
> +	else if (strcmp(type, "pid_t") == 0)
> +		fmt = "%d";
> +	else if (strchr(type, '[') != NULL)

Why not using the same function here?

	else if (synth_field_is_string(type))

> +		fmt = "%s";
> +
> +	return fmt;
> +}
> +

[SNIP]
> +static notrace void trace_event_raw_event_synth(void *__data,
> +						u64 *var_ref_vals,
> +						unsigned int var_ref_idx)
> +{
> +	struct trace_event_file *trace_file = __data;
> +	struct synth_trace_event *entry;
> +	struct trace_event_buffer fbuffer;
> +	struct synth_event *event;
> +	unsigned int i, n_u64;
> +	int fields_size = 0;
> +
> +	event = trace_file->event_call->data;
> +
> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	fields_size = event->n_u64 * sizeof(u64);
> +
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + fields_size);
> +	if (!entry)
> +		return;
> +
> +	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
> +		if (event->fields[i]->is_string) {
> +			char *str_val = (char *)(long)var_ref_vals[var_ref_idx + i];
> +			char *str_field = (char *)&entry->fields[n_u64];
> +
> +			strncpy(str_field, str_val, STR_VAR_LEN_MAX);
> +			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +		} else {
> +			entry->fields[i] = var_ref_vals[var_ref_idx + i];

I think it should be 'entry->fields[n_u64]' like for string.


> +			n_u64++;
> +		}
> +	}
> +
> +	trace_event_buffer_commit(&fbuffer);
> +}
> +

[SNIP]
> +static int create_synth_event(int argc, char **argv)
> +{
> +	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
> +	struct synth_event *event = NULL;
> +	bool delete_event = false;
> +	int i, n_fields = 0, ret = 0;
> +	char *name;
> +
> +	mutex_lock(&synth_event_mutex);
> +
> +	/*
> +	 * Argument syntax:
> +	 *  - Add synthetic event: <event_name> field[;field] ...
> +	 *  - Remove synthetic event: !<event_name> field[;field] ...
> +	 *      where 'field' = type field_name
> +	 */
> +	if (argc < 1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	name = argv[0];
> +	if (name[0] == '!') {
> +		delete_event = true;
> +		name++;
> +	}
> +
> +	event = find_synth_event(name);
> +	if (event) {
> +		if (delete_event) {
> +			if (event->ref) {
> +				event = NULL;
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +			list_del(&event->list);
> +			goto out;
> +		}
> +		event = NULL;
> +		ret = -EEXIST;
> +		goto out;
> +	} else if (delete_event)
> +		goto out;
> +
> +	if (argc < 2) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i = 1; i < argc - 1; i++) {
> +		if (strcmp(argv[i], ";") == 0)
> +			continue;
> +		if (n_fields == SYNTH_FIELDS_MAX) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		field = parse_synth_field(argv[i], argv[i + 1]);
> +		if (IS_ERR(field)) {
> +			ret = PTR_ERR(field);
> +			goto err;
> +		}
> +		fields[n_fields] = field;
> +		i++; n_fields++;
> +	}
> +
> +	if (i < argc) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	event = alloc_synth_event(name, n_fields, fields);
> +	if (IS_ERR(event)) {
> +		ret = PTR_ERR(event);
> +		event = NULL;
> +		goto err;
> +	}
> + out:
> +	mutex_unlock(&synth_event_mutex);
> +
> +	if (event) {
> +		if (delete_event) {
> +			ret = unregister_synth_event(event);
> +			if (!ret)
> +				free_synth_event(event);
> +			else {
> +				mutex_lock(&synth_event_mutex);
> +				if (!find_synth_event(event->name))
> +					list_add(&event->list, &synth_event_list);
> +				mutex_unlock(&synth_event_mutex);
> +			}
> +		} else {
> +			ret = register_synth_event(event);
> +			if (!ret) {
> +				mutex_lock(&synth_event_mutex);
> +				if (!find_synth_event(event->name))
> +					list_add(&event->list, &synth_event_list);
> +				mutex_unlock(&synth_event_mutex);
> +			} else
> +				free_synth_event(event);

Hmm.. this code is repeated 3 times (see below).  How about making a
separate function like free_or_add_back_event()?


> +		}
> +	}
> +
> +	return ret;
> + err:
> +	mutex_unlock(&synth_event_mutex);
> +
> +	for (i = 0; i < n_fields; i++)
> +		free_synth_field(fields[i]);
> +	free_synth_event(event);
> +
> +	return ret;
> +}
> +
> +static int release_all_synth_events(void)
> +{
> +	struct list_head release_events;
> +	struct synth_event *event, *e;
> +	int ret = 0, err = 0;
> +
> +	INIT_LIST_HEAD(&release_events);
> +
> +	mutex_lock(&synth_event_mutex);
> +
> +	list_for_each_entry(event, &synth_event_list, list) {
> +		if (event->ref) {
> +			mutex_unlock(&synth_event_mutex);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(event, e, &synth_event_list, list) {
> +		list_del(&event->list);
> +		list_add(&event->list, &release_events);

list_move() ?

> +	}
> +
> +	mutex_unlock(&synth_event_mutex);
> +
> +	list_for_each_entry_safe(event, e, &release_events, list) {
> +		list_del(&event->list);
> +
> +		ret = unregister_synth_event(event);
> +		if (ret == 0)
> +			free_synth_event(event);
> +		else {
> +			err = ret;
> +			mutex_lock(&synth_event_mutex);
> +			if (!find_synth_event(event->name))
> +				list_add(&event->list, &synth_event_list);
> +			mutex_unlock(&synth_event_mutex);
> +		}

Also repeated here..

Thanks,
Namhyung


> +	}
> +
> +	if (err)
> +		ret = err;
> +
> +	return ret;
> +}
