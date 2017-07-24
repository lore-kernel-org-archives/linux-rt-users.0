From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 22/32] tracing: Add support for 'synthetic' events
Date: Mon, 24 Jul 2017 11:11:56 -0500
Message-ID: <1500912716.21148.47.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <17e9dcfcdd927e42d3d70cb41f7189b0b3682c20.1498510759.git.tom.zanussi@linux.intel.com>
         <20170723120022.GA3902@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbdGXQL7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jul 2017 12:11:59 -0400
In-Reply-To: <20170723120022.GA3902@danjae.aot.lge.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Namhyung,

On Sun, 2017-07-23 at 21:00 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Mon, Jun 26, 2017 at 05:49:23PM -0500, Tom Zanussi wrote:
> > Synthetic events are user-defined events generated from hist trigger
> > variables saved from one or more other events.
> > 
> > To define a synthetic event, the user writes a simple specification
> > consisting of the name of the new event along with one or more
> > variables and their type(s), to the tracing/synthetic_events file.
> > 
> > For instance, the following creates a new event named 'wakeup_latency'
> > with 3 fields: lat, pid, and prio:
> > 
> >     # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
> >       /sys/kernel/debug/tracing/synthetic_events
> > 
> > Reading the tracing/synthetic_events file lists all the
> > currently-defined synthetic events, in this case the event we defined
> > above:
> > 
> >     # cat /sys/kernel/debug/tracing/synthetic_events
> >     wakeup_latency u64 lat; pid_t pid; int prio
> > 
> > At this point, the synthetic event is ready to use, and a histogram
> > can be defined using it:
> > 
> >     # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
> >     /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
> > 
> > The new event is created under the tracing/events/synthetic/ directory
> > and looks and behaves just like any other event:
> > 
> >     # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
> >       enable  filter  format  hist  id  trigger
> > 
> > Although a histogram can be defined for it, nothing will happen until
> > an action tracing that event via the trace_synth() function occurs.
> > The trace_synth() function is very similar to all the other trace_*
> > invocations spread throughout the kernel, except in this case the
> > trace_ function and its corresponding tracepoint isn't statically
> > generated but defined by the user at run-time.
> > 
> > How this can be automatically hooked up via a hist trigger 'action' is
> > discussed in a subsequent patch.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 738 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 738 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 338a9d5..e11b3a3 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> 
> [SNIP]
> > @@ -273,6 +294,688 @@ struct action_data {
> >  	unsigned int		var_ref_idx;
> >  };
> >  
> > +static LIST_HEAD(synth_event_list);
> > +static DEFINE_MUTEX(synth_event_mutex);
> > +
> > +struct synth_trace_event {
> > +	struct trace_entry	ent;
> > +	int			n_fields;
> > +	u64			fields[];
> > +};
> > +
> > +static int synth_event_define_fields(struct trace_event_call *call)
> > +{
> > +	struct synth_trace_event trace;
> > +	int offset = offsetof(typeof(trace), fields);
> > +	struct synth_event *event = call->data;
> > +	unsigned int i, size;
> > +	char *name, *type;
> > +	bool is_signed;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < event->n_fields; i++) {
> > +		size = event->fields[i]->size;
> > +		is_signed = event->fields[i]->is_signed;
> > +		type = event->fields[i]->type;
> > +		name = event->fields[i]->name;
> > +		ret = trace_define_field(call, type, name, offset, size,
> > +					 is_signed, FILTER_OTHER);
> > +		offset += sizeof(u64);
> 
> So you assume size of a field is up to 64-bit, right?  Does it
> guaranteed somewhere?
> 
> 
> > +	}
> > +
> > +	return ret;
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
> > +	unsigned int i;
> > +
> > +	entry = (struct synth_trace_event *)iter->ent;
> > +	se = container_of(event, struct synth_event, call.event);
> > +
> > +	trace_seq_printf(s, "%s: ", se->name);
> > +
> > +	for (i = 0; i < entry->n_fields; i++) {
> > +		if (trace_seq_has_overflowed(s))
> > +			goto end;
> > +
> > +		/* parameter types */
> > +		if (tr->trace_flags & TRACE_ITER_VERBOSE)
> > +			trace_seq_printf(s, "%s ", "u64");
> 
> Why did you hardcode 'u64' here?
> 

Originally everything was u64 but now we have actual types, so this
needs to be updated.

> > +
> > +		/* parameter values */
> > +		trace_seq_printf(s, "%s=%llu%s", se->fields[i]->name,
> > +				 entry->fields[i],
> > +				 i == entry->n_fields - 1 ? "" : ", ");
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
> 
> [SNIP]
> > +static unsigned int synth_field_size(char *type)
> > +{
> > +	unsigned int size = 0;
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
> > +	else if (strstr(type, "[") == 0)
> > +		size = sizeof(u64);
> 
> Ah ok, so you don't accept arrays and all supported fields are less
> than or equal to 8 bytes.
> 
> > +
> > +	return size;
> > +}
> > +
> 
> [SNIP]
> > +static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> > +			       unsigned int var_ref_idx)
> > +{
> > +	struct tracepoint *tp = event->tp;
> > +
> > +	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
> > +		struct tracepoint_func *it_func_ptr;
> > +		void *it_func;
> > +		void *__data;
> > +
> > +		if (!(cpu_online(raw_smp_processor_id())))
> > +			return;
> > +
> > +		it_func_ptr = rcu_dereference_sched((tp)->funcs);
> > +		if (it_func_ptr) {
> > +			do {
> > +				it_func = (it_func_ptr)->func;
> > +				__data = (it_func_ptr)->data;
> > +				((void(*)(void *__data, u64 *var_ref_vals, unsigned int var_ref_idx))(it_func))(__data, var_ref_vals, var_ref_idx);
> 
> Ouch, why not defining a function pointer?
> 

Good point, will do.

Thanks,

Tom



