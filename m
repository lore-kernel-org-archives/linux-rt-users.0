From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 32/40] tracing: Add cpu field for hist triggers
Date: Fri, 8 Sep 2017 15:08:08 -0400
Message-ID: <20170908150808.6fb4295b@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <5d893e726dcbb6982a5e3d44414df06becdd5e6f.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d893e726dcbb6982a5e3d44414df06becdd5e6f.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:44 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> A common key to use in a histogram is the cpuid - add a new cpu
> 'synthetic' field for that purpose.  This field is named cpu rather
> than $cpu or $common_cpu because 'cpu' already exists as a special
> filter field and it makes more sense to match that rather than add
> another name for the same thing.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  Documentation/trace/events.txt   | 18 ++++++++++++++++++
>  kernel/trace/trace_events_hist.c | 30 +++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
> index 2cc08d4..9717688 100644
> --- a/Documentation/trace/events.txt
> +++ b/Documentation/trace/events.txt
> @@ -668,6 +668,24 @@ The following commands are supported:
>    The examples below provide a more concrete illustration of the
>    concepts and typical usage patterns discussed above.
>  
> +  'synthetic' event fields
> +  ------------------------
> +
> +  There are a number of 'synthetic fields' available for use as keys
> +  or values in a hist trigger.  These look like and behave as if they
> +  were event fields, but aren't actually part of the event's field
> +  definition or format file.  They are however available for any
> +  event, and can be used anywhere an actual event field could be.
> +  'Synthetic' field names are always prefixed with a '$' character to
> +  indicate that they're not normal fields (with the exception of
> +  'cpu', for compatibility with existing filter usage):
> +
> +    $common_timestamp      u64 - timestamp (from ring buffer) associated
> +                                 with the event, in nanoseconds.  May be
> +				 modified by .usecs to have timestamps
> +				 interpreted as microseconds.

I guess the above should have been added with the synthetic field
addition.

> +    cpu                    int - the cpu on which the event occurred.

Then this (and the explanation of '$' for cpu above) should be added
with this patch.


> +
>  
>  6.2 'hist' trigger examples
>  ---------------------------
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4f66f2e..0782766 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -226,6 +226,7 @@ enum hist_field_flags {
>  	HIST_FIELD_FL_VAR_ONLY		= 8192,
>  	HIST_FIELD_FL_EXPR		= 16384,
>  	HIST_FIELD_FL_VAR_REF		= 32768,
> +	HIST_FIELD_FL_CPU		= 65536,
>  };
>  
>  struct var_defs {
> @@ -1170,6 +1171,16 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
>  	return ts;
>  }
>  
> +static u64 hist_field_cpu(struct hist_field *hist_field,
> +			  struct tracing_map_elt *elt,
> +			  struct ring_buffer_event *rbe,
> +			  void *event)
> +{
> +	int cpu = raw_smp_processor_id();

Hmm, I wonder if this should be just smp_processor_id(). Why have the
raw_?

> +
> +	return cpu;
> +}
> +
>  static struct hist_field *check_var_ref(struct hist_field *hist_field,
>  					struct hist_trigger_data *var_data,
>  					unsigned int var_idx)
> @@ -1518,6 +1529,8 @@ static const char *hist_field_name(struct hist_field *field,
>  		field_name = hist_field_name(field->operands[0], ++level);
>  	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
>  		field_name = "$common_timestamp";
> +	else if (field->flags & HIST_FIELD_FL_CPU)
> +		field_name = "cpu";
>  	else if (field->flags & HIST_FIELD_FL_EXPR ||
>  		 field->flags & HIST_FIELD_FL_VAR_REF)
>  		field_name = field->name;
> @@ -1990,6 +2003,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>  		goto out;
>  	}
>  
> +	if (flags & HIST_FIELD_FL_CPU) {
> +		hist_field->fn = hist_field_cpu;
> +		hist_field->size = sizeof(int);
> +		hist_field->type = kstrdup("int", GFP_KERNEL);
> +		if (!hist_field->type)
> +			goto free;
> +		goto out;
> +	}
> +
>  	if (WARN_ON_ONCE(!field))
>  		goto out;
>  
> @@ -2182,7 +2204,9 @@ static struct hist_field *parse_var_ref(struct trace_array *tr,
>  		hist_data->enable_timestamps = true;
>  		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
>  			hist_data->attrs->ts_in_usecs = true;
> -	} else {
> +	} else if (strcmp(field_name, "cpu") == 0)
> +		*flags |= HIST_FIELD_FL_CPU;
> +	else {
>  		field = trace_find_event_field(file->event_call, field_name);
>  		if (!field || !field->size) {
>  			field = ERR_PTR(-EINVAL);


> @@ -3185,7 +3209,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
>  				goto out;
>  			}
>  		}
> -
>  		if (param[0] == '$')
>  			hist_field = onmatch_find_var(hist_data, data, system,
>  						      event_name, param);
> @@ -3200,7 +3223,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -

Why the modification of whitespace here?

-- Steve

>  		if (check_synth_field(event, hist_field, field_pos) == 0) {
>  			var_ref = create_var_ref(hist_field);
>  			if (!var_ref) {
> @@ -4315,6 +4337,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
>  
>  	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
>  		seq_puts(m, "$common_timestamp");
> +	else if (hist_field->flags & HIST_FIELD_FL_CPU)
> +		seq_puts(m, "cpu");
>  	else if (field_name)
>  		seq_printf(m, "%s", field_name);
>  
