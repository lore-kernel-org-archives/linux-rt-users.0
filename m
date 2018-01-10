From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v8 24/37] tracing: Add support for 'synthetic' events
Date: Wed, 10 Jan 2018 14:41:24 +0900
Message-ID: <20180110054124.GA2575@danjae.aot.lge.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
 <c8c526d55c308b108d1a1129cdd44af988581937.1513802700.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <c8c526d55c308b108d1a1129cdd44af988581937.1513802700.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Thu, Dec 21, 2017 at 10:02:46AM -0600, Tom Zanussi wrote:
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
> +	list_for_each_entry_safe(event, e, &synth_event_list, list)
> +		list_move(&event->list, &release_events);

list_splice_init() ?

> +
> +	mutex_unlock(&synth_event_mutex);
> +
> +	list_for_each_entry_safe(event, e, &release_events, list) {
> +		list_del(&event->list);
> +
> +		ret = unregister_synth_event(event);
> +		add_or_delete_synth_event(event, !ret);
> +	}
> +
> +	if (err)
> +		ret = err;

The err was never used.

> +
> +	return ret;
> +}
