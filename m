From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 24/37] tracing: Add support for 'synthetic' events
Date: Tue, 14 Nov 2017 19:06:47 +0900
Message-ID: <20171114100647.GA20669@sejong>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
 <f97c1be3678794dad81ea1d523ca6da3f088e646.1510252666.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:50557 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdKNKGu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Nov 2017 05:06:50 -0500
Content-Disposition: inline
In-Reply-To: <f97c1be3678794dad81ea1d523ca6da3f088e646.1510252666.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 09, 2017 at 02:33:55PM -0600, Tom Zanussi wrote:
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
> ---
>  kernel/trace/trace_events_hist.c | 908 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 906 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 3504aa8..510b10d 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -20,10 +20,16 @@
>  #include <linux/slab.h>
>  #include <linux/stacktrace.h>
>  #include <linux/rculist.h>
> +#include <linux/tracefs.h>
>  
>  #include "tracing_map.h"
>  #include "trace.h"
>  
> +#define SYNTH_SYSTEM		"synthetic"
> +#define SYNTH_FIELDS_MAX	16
> +
> +#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
> +
>  struct hist_field;
>  
>  typedef u64 (*hist_field_fn_t) (struct hist_field *field,
> @@ -270,6 +276,26 @@ struct hist_trigger_data {
>  	unsigned int			n_actions;
>  };
>  
> +struct synth_field {
> +	char *type;
> +	char *name;
> +	size_t size;
> +	bool is_signed;
> +	bool is_string;
> +};
> +
> +struct synth_event {
> +	struct list_head			list;
> +	int					ref;
> +	char					*name;
> +	struct synth_field			**fields;
> +	unsigned int				n_fields;
> +	unsigned int				n_u64;
> +	struct trace_event_class		class;
> +	struct trace_event_call			call;
> +	struct tracepoint			*tp;
> +};
> +
>  struct action_data;
>  
>  typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
> @@ -282,6 +308,803 @@ struct action_data {
>  	unsigned int		var_ref_idx;
>  };
>  
> +static LIST_HEAD(synth_event_list);
> +static DEFINE_MUTEX(synth_event_mutex);
> +
> +struct synth_trace_event {
> +	struct trace_entry	ent;
> +	u64			fields[];
> +};
> +
> +static int synth_event_define_fields(struct trace_event_call *call)
> +{
> +	struct synth_trace_event trace;
> +	int offset = offsetof(typeof(trace), fields);
> +	struct synth_event *event = call->data;
> +	unsigned int i, size, n_u64;
> +	char *name, *type;
> +	bool is_signed;
> +	int ret = 0;
> +
> +	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
> +		size = event->fields[i]->size;
> +		is_signed = event->fields[i]->is_signed;
> +		type = event->fields[i]->type;
> +		name = event->fields[i]->name;
> +		ret = trace_define_field(call, type, name, offset, size,
> +					 is_signed, FILTER_OTHER);
> +		if (ret)
> +			break;
> +
> +		if (event->fields[i]->is_string) {
> +			offset += STR_VAR_LEN_MAX;
> +			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);

Did you use fixed size array for strings?


> +		} else {
> +			offset += sizeof(u64);
> +			n_u64++;
> +		}
> +	}
> +
> +	event->n_u64 = n_u64;
> +
> +	return ret;
> +}
> +
> +static bool synth_field_signed(char *type)
> +{
> +	if (strncmp(type, "u", 1) == 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int synth_field_is_string(char *type)
> +{
> +	if (strstr(type, "char[") != NULL)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int synth_field_string_size(char *type)
> +{
> +	char buf[4], *end, *start;
> +	unsigned int len;
> +	int size, err;
> +
> +	start = strstr(type, "char[");
> +	if (start == NULL)
> +		return -EINVAL;
> +	start += strlen("char[");
> +
> +	end = strchr(type, ']');
> +	if (!end || end < start)
> +		return -EINVAL;
> +
> +	len = end - start;
> +	if (len > 3)
> +		return -EINVAL;
> +
> +	strncpy(buf, start, len);
> +	buf[len] = '\0';
> +
> +	err = kstrtouint(buf, 0, &size);
> +	if (err)
> +		return err;
> +
> +	if (size > STR_VAR_LEN_MAX)
> +		return -EINVAL;
> +
> +	return size;
> +}

But this seems to use the actual array size for string..

[SNIP]
> +
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

Here it uses the fixed size again..

Thanks,
Namhyung


> +		} else {
> +			entry->fields[i] = var_ref_vals[var_ref_idx + i];
> +			n_u64++;
> +		}
> +	}
> +
> +	trace_event_buffer_commit(&fbuffer);
> +}
