From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 27/40] tracing: Add support for 'synthetic' events
Date: Fri, 08 Sep 2017 09:30:39 -0500
Message-ID: <1504881039.13310.26.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <9cae5fa47b29d06521c12626333158dd5dd86d66.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907194048.0082b63f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907194048.0082b63f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-09-07 at 19:40 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:39 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> 
> > +static int synth_field_string_size(char *type)
> > +{
> > +	char buf[4], *end, *start;
> > +	unsigned int len;
> > +	int size, err;
> > +
> > +	start = strstr(type, "char[");
> > +	if (start == NULL)
> > +		return -EINVAL;
> > +	start += strlen("char[");
> > +
> > +	end = strchr(type, ']');
> > +	if (!end || end < start)
> > +		return -EINVAL;
> > +
> > +	len = end - start;
> > +	if (len > 2)
> 
> Is there a reason for max of 2? Could it be 3?
> 

You're right, it should be 3.

> > +		return -EINVAL;
> > +
> > +	strncpy(buf, start, len);
> > +	buf[len] = '\0';
> 
> With len=3, buf[len] would be the 4th byte, which buf is defined to be.
> 

Yep.

> > +
> > +	err = kstrtouint(buf, 0, &size);
> > +	if (err)
> > +		return err;
> > +
> > +	if (size > STR_VAR_LEN_MAX)
> > +		return -EINVAL;
> > +
> > +	return size;
> > +}
> > +
> > +static int synth_field_size(char *type)
> > +{
> > +	int size = 0;
> > +
> > +	if (strcmp(type, "s64") == 0)
> > +		size = sizeof(s64);
> > +	else if (strcmp(type, "u64") == 0)
> > +		size = sizeof(u64);
> > +	else if (strcmp(type, "s32") == 0)
> > +		size = sizeof(s32);
> > +	else if (strcmp(type, "u32") == 0)
> > +		size = sizeof(u32);
> > +	else if (strcmp(type, "s16") == 0)
> > +		size = sizeof(s16);
> > +	else if (strcmp(type, "u16") == 0)
> > +		size = sizeof(u16);
> > +	else if (strcmp(type, "s8") == 0)
> > +		size = sizeof(s8);
> > +	else if (strcmp(type, "u8") == 0)
> > +		size = sizeof(u8);
> > +	else if (strcmp(type, "char") == 0)
> > +		size = sizeof(char);
> > +	else if (strcmp(type, "unsigned char") == 0)
> > +		size = sizeof(unsigned char);
> > +	else if (strcmp(type, "int") == 0)
> > +		size = sizeof(int);
> > +	else if (strcmp(type, "unsigned int") == 0)
> > +		size = sizeof(unsigned int);
> > +	else if (strcmp(type, "long") == 0)
> > +		size = sizeof(long);
> > +	else if (strcmp(type, "unsigned long") == 0)
> > +		size = sizeof(unsigned long);
> > +	else if (strcmp(type, "pid_t") == 0)
> > +		size = sizeof(pid_t);
> > +	else if (synth_field_is_string(type))
> > +		size = synth_field_string_size(type);
> > +
> > +	return size;
> > +}
> > +
> > +static const char *synth_field_fmt(char *type)
> > +{
> > +	const char *fmt = "%llu";
> > +
> > +	if (strcmp(type, "s64") == 0)
> > +		fmt = "%lld";
> > +	else if (strcmp(type, "u64") == 0)
> > +		fmt = "%llu";
> > +	else if (strcmp(type, "s32") == 0)
> > +		fmt = "%d";
> > +	else if (strcmp(type, "u32") == 0)
> > +		fmt = "%u";
> > +	else if (strcmp(type, "s16") == 0)
> > +		fmt = "%d";
> > +	else if (strcmp(type, "u16") == 0)
> > +		fmt = "%u";
> > +	else if (strcmp(type, "s8") == 0)
> > +		fmt = "%d";
> > +	else if (strcmp(type, "u8") == 0)
> > +		fmt = "%u";
> > +	else if (strcmp(type, "char") == 0)
> > +		fmt = "%d";
> > +	else if (strcmp(type, "unsigned char") == 0)
> > +		fmt = "%u";
> > +	else if (strcmp(type, "int") == 0)
> > +		fmt = "%d";
> > +	else if (strcmp(type, "unsigned int") == 0)
> > +		fmt = "%u";
> > +	else if (strcmp(type, "long") == 0)
> > +		fmt = "%ld";
> > +	else if (strcmp(type, "unsigned long") == 0)
> > +		fmt = "%lu";
> > +	else if (strcmp(type, "pid_t") == 0)
> > +		fmt = "%d";
> > +	else if (strstr(type, "[") == 0)
> > +		fmt = "%s";
> > +
> > +	return fmt;
> > +}
> > +
> > +static enum print_line_t print_synth_event(struct trace_iterator *iter,
> > +					   int flags,
> > +					   struct trace_event *event)
> > +{
> > +	struct trace_array *tr = iter->tr;
> > +	struct trace_seq *s = &iter->seq;
> > +	struct synth_trace_event *entry;
> > +	struct synth_event *se;
> > +	unsigned int i, n_u64;
> > +	char print_fmt[32];
> > +	const char *fmt;
> > +
> > +	entry = (struct synth_trace_event *)iter->ent;
> > +	se = container_of(event, struct synth_event, call.event);
> > +
> > +	trace_seq_printf(s, "%s: ", se->name);
> > +
> > +	for (i = 0, n_u64 = 0; i < se->n_fields; i++) {
> > +		if (trace_seq_has_overflowed(s))
> > +			goto end;
> > +
> > +		fmt = synth_field_fmt(se->fields[i]->type);
> > +
> > +		/* parameter types */
> > +		if (tr->trace_flags & TRACE_ITER_VERBOSE)
> > +			trace_seq_printf(s, "%s ", fmt);
> > +
> > +		sprintf(print_fmt, "%%s=%s%%s", fmt);
> 
> Please use snprintf().
> 
> > +
> > +		/* parameter values */
> > +		if (se->fields[i]->is_string) {
> > +			trace_seq_printf(s, print_fmt, se->fields[i]->name,
> > +					 (char *)entry->fields[n_u64],
> > +					 i == se->n_fields - 1 ? "" : " ");
> > +			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> > +		} else {
> > +			trace_seq_printf(s, print_fmt, se->fields[i]->name,
> > +					 entry->fields[n_u64],
> > +					 i == se->n_fields - 1 ? "" : " ");
> > +			n_u64++;
> > +		}
> > +	}
> > +end:
> > +	trace_seq_putc(s, '\n');
> > +
> > +	return trace_handle_return(s);
> > +}
> > +
> > +static struct trace_event_functions synth_event_funcs = {
> > +	.trace		= print_synth_event
> > +};
> > +
> > +static notrace void trace_event_raw_event_synth(void *__data,
> > +						u64 *var_ref_vals,
> > +						unsigned int var_ref_idx)
> > +{
> > +	struct trace_event_file *trace_file = __data;
> > +	struct synth_trace_event *entry;
> > +	struct trace_event_buffer fbuffer;
> > +	struct synth_event *event;
> > +	unsigned int i, n_u64;
> > +	int fields_size = 0;
> > +
> > +	event = trace_file->event_call->data;
> > +
> > +	if (trace_trigger_soft_disabled(trace_file))
> > +		return;
> > +
> > +	fields_size = event->n_u64 * sizeof(u64);
> > +
> > +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> > +					   sizeof(*entry) + fields_size);
> > +	if (!entry)
> > +		return;
> > +
> > +	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
> > +		if (event->fields[i]->is_string) {
> > +			char *str_val = (char *)var_ref_vals[var_ref_idx + i];
> > +			char *str_field = (char *)&entry->fields[n_u64];
> > +
> > +			strncpy(str_field, str_val, STR_VAR_LEN_MAX);
> > +			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> > +		} else {
> > +			entry->fields[i] = var_ref_vals[var_ref_idx + i];
> > +			n_u64++;
> > +		}
> > +	}
> > +
> > +	trace_event_buffer_commit(&fbuffer);
> > +}
> > +
> > +static void free_synth_event_print_fmt(struct trace_event_call *call)
> > +{
> > +	if (call)
> > +		kfree(call->print_fmt);
> 
> For safety reasons should this be:
> 
> 	if (call) {
> 		kfree(call->print_fmt);
> 		call->print_fmt = NULL;
> 	}
> ?
> 

Yeah, will change.

> > +}
> > +
> > +static int __set_synth_event_print_fmt(struct synth_event *event,
> > +				       char *buf, int len)
> > +{
> > +	const char *fmt;
> > +	int pos = 0;
> > +	int i;
> > +
> > +	/* When len=0, we just calculate the needed length */
> > +#define LEN_OR_ZERO (len ? len - pos : 0)
> > +
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> > +	for (i = 0; i < event->n_fields; i++) {
> > +		fmt = synth_field_fmt(event->fields[i]->type);
> > +		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s%s",
> > +				event->fields[i]->name, fmt,
> > +				i == event->n_fields - 1 ? "" : ", ");
> > +	}
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> > +
> > +	for (i = 0; i < event->n_fields; i++) {
> > +		pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +				", REC->%s", event->fields[i]->name);
> > +	}
> > +
> > +#undef LEN_OR_ZERO
> > +
> > +	/* return the length of print_fmt */
> > +	return pos;
> > +}
> > +
> > +static int set_synth_event_print_fmt(struct trace_event_call *call)
> > +{
> > +	struct synth_event *event = call->data;
> > +	char *print_fmt;
> > +	int len;
> > +
> > +	/* First: called with 0 length to calculate the needed length */
> > +	len = __set_synth_event_print_fmt(event, NULL, 0);
> > +
> > +	print_fmt = kmalloc(len + 1, GFP_KERNEL);
> > +	if (!print_fmt)
> > +		return -ENOMEM;
> > +
> > +	/* Second: actually write the @print_fmt */
> > +	__set_synth_event_print_fmt(event, print_fmt, len + 1);
> > +	call->print_fmt = print_fmt;
> > +
> > +	return 0;
> > +}
> > +
> > +static void free_synth_field(struct synth_field *field)
> > +{
> > +	kfree(field->type);
> > +	kfree(field->name);
> > +	kfree(field);
> > +}
> > +
> > +static struct synth_field *parse_synth_field(char *field_type,
> > +					     char *field_name)
> > +{
> > +	struct synth_field *field;
> > +	int len, ret = 0;
> > +	char *array;
> > +
> > +	if (field_type[0] == ';')
> > +		field_type++;
> > +
> > +	len = strlen(field_name);
> > +	if (field_name[len - 1] == ';')
> > +		field_name[len - 1] = '\0';
> > +
> > +	field = kzalloc(sizeof(*field), GFP_KERNEL);
> > +	if (!field)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	len = strlen(field_type) + 1;
> > +	array = strchr(field_name, '[');
> > +	if (array)
> > +		len += strlen(array);
> > +	field->type = kzalloc(len, GFP_KERNEL);
> > +	if (!field->type) {
> > +		ret = -ENOMEM;
> > +		goto free;
> > +	}
> > +	strcat(field->type, field_type);
> > +	if (array) {
> > +		strcat(field->type, array);
> > +		*array = '\0';
> > +	}
> > +
> > +	field->size = synth_field_size(field->type);
> > +	if (!field->size) {
> > +		ret = -EINVAL;
> > +		goto free;
> > +	}
> > +
> > +	if (synth_field_is_string(field->type))
> > +		field->is_string = true;
> > +
> > +	field->is_signed = synth_field_signed(field->type);
> > +
> > +	field->name = kstrdup(field_name, GFP_KERNEL);
> > +	if (!field->name) {
> > +		ret = -ENOMEM;
> > +		goto free;
> > +	}
> > + out:
> > +	return field;
> > + free:
> > +	free_synth_field(field);
> > +	field = ERR_PTR(ret);
> > +	goto out;
> > +}
> > +
> > +static void free_synth_tracepoint(struct tracepoint *tp)
> > +{
> > +	if (!tp)
> > +		return;
> > +
> > +	kfree(tp->name);
> > +	kfree(tp);
> > +}
> > +
> > +static struct tracepoint *alloc_synth_tracepoint(char *name)
> > +{
> > +	struct tracepoint *tp;
> > +	int ret = 0;
> > +
> > +	tp = kzalloc(sizeof(*tp), GFP_KERNEL);
> > +	if (!tp) {
> > +		ret = -ENOMEM;
> > +		goto free;
> 
> Why the goto free here? It's the first allocation. Should just be able
> to return ERR_PTR(-ENOMEM).
> 
> > +	}
> > +
> > +	tp->name = kstrdup(name, GFP_KERNEL);
> > +	if (!tp->name) {
> > +		ret = -ENOMEM;
> > +		goto free;
> 
> Then we don't even need the goto. Just free free tp, and return with
> error.
> 
> > +	}
> > +
> > +	tp->dynamic = true;
> > +
> > +	return tp;
> > + free:
> > +	free_synth_tracepoint(tp);
> > +
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
> > +				    unsigned int var_ref_idx);
> > +
> > +static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> > +			       unsigned int var_ref_idx)
> > +{
> > +	struct tracepoint *tp = event->tp;
> > +
> > +	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
> > +		struct tracepoint_func *probe_func_ptr;
> > +		synth_probe_func_t probe_func;
> > +		void *__data;
> > +
> > +		if (!(cpu_online(raw_smp_processor_id())))
> > +			return;
> > +
> > +		probe_func_ptr = rcu_dereference_sched((tp)->funcs);
> > +		if (probe_func_ptr) {
> > +			do {
> > +				probe_func = (probe_func_ptr)->func;
> > +				__data = (probe_func_ptr)->data;
> 
> Are the parenthesis around probe_func_ptr required?
> 
> > +				probe_func(__data, var_ref_vals, var_ref_idx);
> > +			} while ((++probe_func_ptr)->func);
> > +		}
> > +	}
> > +}
> > +
> > +static struct synth_event *find_synth_event(const char *name)
> > +{
> > +	struct synth_event *event;
> > +
> > +	list_for_each_entry(event, &synth_event_list, list) {
> > +		if (strcmp(event->name, name) == 0)
> > +			return event;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int register_synth_event(struct synth_event *event)
> > +{
> > +	struct trace_event_call *call = &event->call;
> > +	int ret = 0;
> > +
> > +	event->call.class = &event->class;
> > +	event->class.system = kstrdup(SYNTH_SYSTEM, GFP_KERNEL);
> > +	if (!event->class.system) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	event->tp = alloc_synth_tracepoint(event->name);
> > +	if (IS_ERR(event->tp)) {
> > +		ret = PTR_ERR(event->tp);
> > +		event->tp = NULL;
> > +		goto out;
> > +	}
> > +
> > +	INIT_LIST_HEAD(&call->class->fields);
> > +	call->event.funcs = &synth_event_funcs;
> > +	call->class->define_fields = synth_event_define_fields;
> > +
> > +	ret = register_trace_event(&call->event);
> > +	if (!ret) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +	call->flags = TRACE_EVENT_FL_TRACEPOINT;
> > +	call->class->reg = trace_event_reg;
> > +	call->class->probe = trace_event_raw_event_synth;
> > +	call->data = event;
> > +	call->tp = event->tp;
> > +
> 
> Could you comment what lock inversion is being avoided by the releasing
> of this mutex.
> 

Yeah, this is because trace_add/remove_event_call() would otherwise grab
event_mutex with synth_event_mutex held, but a hist trigger cmd which
already has the event_mutex held when called can grab the
synth_event_mutex.

> > +	mutex_unlock(&synth_event_mutex);
> 
> Please add a comment before this function that states that this
> function releases synth_event_mutex.
> 

OK, will do.

> > +	ret = trace_add_event_call(call);
> > +	mutex_lock(&synth_event_mutex);
> > +	if (ret) {
> > +		pr_warn("Failed to register synthetic event: %s\n",
> > +			trace_event_name(call));
> > +		goto err;
> > +	}
> > +
> > +	ret = set_synth_event_print_fmt(call);
> > +	if (ret < 0) {
> > +		mutex_unlock(&synth_event_mutex);
> > +		trace_remove_event_call(call);
> > +		mutex_lock(&synth_event_mutex);
> > +		goto err;
> > +	}
> > + out:
> > +	return ret;
> > + err:
> > +	unregister_trace_event(&call->event);
> > +	goto out;
> > +}
> > +
> > +static int unregister_synth_event(struct synth_event *event)
> > +{
> > +	struct trace_event_call *call = &event->call;
> > +	int ret;
> > +
> > +	mutex_unlock(&synth_event_mutex);
> 
> Same here.
> 
> > +	ret = trace_remove_event_call(call);
> > +	mutex_lock(&synth_event_mutex);
> > +	if (ret) {
> > +		pr_warn("Failed to remove synthetic event: %s\n",
> > +			trace_event_name(call));
> > +		free_synth_event_print_fmt(call);
> 
> Is it safe to call unregister_trace_event() with the synth_event_mutex
> held?
> 

Yeah, I don't see a problem here.

For the rest of the comments, will update as suggested...

Thanks,

Tom 
