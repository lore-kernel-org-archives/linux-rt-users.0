From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 24/37] tracing: Add support for 'synthetic' events
Date: Tue, 14 Nov 2017 10:21:26 +0900
Message-ID: <20171114012126.GA19630@sejong>
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
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:59253 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKNBVe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Nov 2017 20:21:34 -0500
Content-Disposition: inline
In-Reply-To: <f97c1be3678794dad81ea1d523ca6da3f088e646.1510252666.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,

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

[SNIP]
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
> +	else if (strstr(type, "[") == 0)
> +		fmt = "%s";

Is it for string?  You may want to check it with '!='..

Thanks,
Namhyung


> +
> +	return fmt;
> +}
