From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 12/32] tracing: Add hist trigger timestamp support
Date: Mon, 17 Jul 2017 15:00:39 +0900
Message-ID: <20170717060039.GA32084@danjae.aot.lge.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <dc2a86608cd3adcf957f7f4cc0252e659acf0fce.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc2a86608cd3adcf957f7f4cc0252e659acf0fce.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 26, 2017 at 05:49:13PM -0500, Tom Zanussi wrote:
> Add support for a timestamp event field.  This is actually a 'pseudo-'
> event field in that it behaves like it's part of the event record, but
> is really part of the corresponding ring buffer event.
> 
> To make use of the timestamp field, users can specify
> "$common_timestamp" as a field name for any histogram.  Note that this
> doesn't make much sense on its own either as either a key or value,
> but needs to be supported even so, since follow-on patches will add
> support for making use of this field in time deltas.  The '$' is used
> as a prefix on the variable name to indicate that it's not an bonafide
> event field - so you won't find it in the event description - but
> rather it's a synthetic field that can be used like a real field).
> 
> Note that the use of this field requires the ring buffer be put into
> TIME_EXTEND_ABS mode, which saves the complete timestamp for each
> event rather than an offset.  This mode will be enabled if and only if
> a histogram makes use of the "$common_timestamp" field.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 90 +++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index dab6ff6..aeae3b4 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c

[SNIP]
> @@ -756,7 +783,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  			break;
>  		}
>  
> -		if (strcmp(field_name, "hitcount") == 0) {
> +		if ((strcmp(field_name, "hitcount") == 0)) {

Seems like an unnecessary change.


>  			descending = is_descending(field_str);
>  			if (descending < 0) {
>  				ret = descending;
> @@ -816,6 +843,9 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
>  
>  			if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
>  				cmp_fn = tracing_map_cmp_none;
> +			else if (!field)
> +				cmp_fn = tracing_map_cmp_num(hist_field->size,
> +							     hist_field->is_signed);

I couldn't find where the hist_field->is_signed is set.


>  			else if (is_string_field(field))
>  				cmp_fn = tracing_map_cmp_string;
>  			else

[SNIP]
> @@ -1534,6 +1570,9 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
>  
>  	update_cond_flag(file);
>  
> +	if (hist_data->enable_timestamps)
> +		tracing_set_time_stamp_abs(file->tr, true);
> +
>  	if (trace_event_trigger_enable_disable(file, 1) < 0) {
>  		list_del_rcu(&data->list);
>  		update_cond_flag(file);
> @@ -1568,6 +1607,9 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
>  
>  	if (unregistered && test->ops->free)
>  		test->ops->free(test->ops, test);
> +
> +	if (hist_data->enable_timestamps)
> +		tracing_set_time_stamp_abs(file->tr, false);

I think it needs some kind of refcount to disable the absolute
timestamp.  Otherwise unregistering a timestamp-enabled hist might
corrupt others IMHO.

Thanks,
Namhyung


>  }
>  
>  static void hist_unreg_all(struct trace_event_file *file)
> -- 
> 1.9.3
> 
