From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 24/37] tracing: Add support for 'synthetic' events
Date: Tue, 12 Dec 2017 23:42:01 +0900
Message-ID: <20171212144201.GA21538@danjae.aot.lge.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
 <f684af3c12a6fbdbed67df6142dc21fd728db808.1512593081.git.tom.zanussi@linux.intel.com>
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
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41107 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbdLLOos (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Dec 2017 09:44:48 -0500
Content-Disposition: inline
In-Reply-To: <f684af3c12a6fbdbed67df6142dc21fd728db808.1512593081.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Dec 06, 2017 at 04:38:05PM -0600, Tom Zanussi wrote:
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
> +static enum print_line_t print_synth_event(struct trace_iterator *iter,
> +					   int flags,
> +					   struct trace_event *event)
> +{
> +	struct trace_array *tr = iter->tr;
> +	struct trace_seq *s = &iter->seq;
> +	struct synth_trace_event *entry;
> +	struct synth_event *se;
> +	unsigned int i, n_u64;
> +	char print_fmt[32];
> +	const char *fmt;
> +
> +	entry = (struct synth_trace_event *)iter->ent;
> +	se = container_of(event, struct synth_event, call.event);
> +
> +	trace_seq_printf(s, "%s: ", se->name);
> +
> +	for (i = 0, n_u64 = 0; i < se->n_fields; i++) {
> +		if (trace_seq_has_overflowed(s))
> +			goto end;
> +
> +		fmt = synth_field_fmt(se->fields[i]->type);
> +
> +		/* parameter types */
> +		if (tr->trace_flags & TRACE_ITER_VERBOSE)
> +			trace_seq_printf(s, "%s ", fmt);
> +
> +		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);
> +
> +		/* parameter values */
> +		if (se->fields[i]->is_string) {
> +			trace_seq_printf(s, print_fmt, se->fields[i]->name,
> +					 (char *)(long)entry->fields[n_u64],

Hmm.. shouldn't it be (char *)&entry->fields[n_u64] ?

Thanks,
Namhyung


> +					 i == se->n_fields - 1 ? "" : " ");
> +			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +		} else {
> +			trace_seq_printf(s, print_fmt, se->fields[i]->name,
> +					 entry->fields[n_u64],
> +					 i == se->n_fields - 1 ? "" : " ");
> +			n_u64++;
> +		}
> +	}
> +end:
> +	trace_seq_putc(s, '\n');
> +
> +	return trace_handle_return(s);
> +}
