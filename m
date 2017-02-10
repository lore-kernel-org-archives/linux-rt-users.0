From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 09/21] tracing: Add hist trigger timestamp support
Date: Fri, 10 Feb 2017 15:14:14 +0900
Message-ID: <20170210061414.GB14705@sejong>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
 <8781998ccd0678ef5ddf1cc7720a9586806b44ae.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: <rostedt@goodmis.org>, <tglx@linutronix.de>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:54905 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdBJG3k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2017 01:29:40 -0500
In-Reply-To: <8781998ccd0678ef5ddf1cc7720a9586806b44ae.1486569306.git.tom.zanussi@linux.intel.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 08, 2017 at 11:25:05AM -0600, Tom Zanussi wrote:
> Add support for a timestamp event field.  This is actually a 'pseudo-'
> event field in that it behaves like it's part of the event record, but
> is really part of the corresponding ring buffer event.
> 
> To make use of the timestamp field, users can specify "common_timestamp"
> as a field name for any histogram.  Note that this doesn't make much
> sense on its own either as either a key or value, but needs to be
> supported even so, since follow-on patches will add support for making
> use of this field in time deltas.
> 
> Note that the use of this field requires the ring buffer be put into
> TIME_EXTEND_ABS mode, which saves the complete timestamp for each
> event rather than an offset.  This mode will be enabled if and only if
> a histogram makes use of the "common_timestamp" field.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 85 +++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4e70872..8d7f7dd 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -88,6 +88,12 @@ static u64 hist_field_log2(struct hist_field *hist_field, void *event,
>  	return (u64) ilog2(roundup_pow_of_two(val));
>  }
>  
> +static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
> +				struct ring_buffer_event *rbe)
> +{
> +	return ring_buffer_event_time_stamp(rbe);
> +}
> +
>  #define DEFINE_HIST_FIELD_FN(type)					\
>  	static u64 hist_field_##type(struct hist_field *hist_field,	\
>  				     void *event,			\
> @@ -134,6 +140,7 @@ enum hist_field_flags {
>  	HIST_FIELD_FL_SYSCALL		= 128,
>  	HIST_FIELD_FL_STACKTRACE	= 256,
>  	HIST_FIELD_FL_LOG2		= 512,
> +	HIST_FIELD_FL_TIMESTAMP		= 1024,
>  };
>  
>  struct hist_trigger_attrs {
> @@ -158,6 +165,7 @@ struct hist_trigger_data {
>  	struct trace_event_file		*event_file;
>  	struct hist_trigger_attrs	*attrs;
>  	struct tracing_map		*map;
> +	bool				enable_timestamps;
>  };
>  
>  static const char *hist_field_name(struct hist_field *field)
> @@ -404,6 +412,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
>  	hist_field = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
>  	if (!hist_field)
>  		return NULL;
> +	hist_field->is_signed = false;

I think it's not needed since hist_field is allocated by kzalloc().
Also I cannot find where ->is_signed is set.

>  
>  	if (flags & HIST_FIELD_FL_HITCOUNT) {
>  		hist_field->fn = hist_field_counter;
> @@ -423,6 +432,12 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
>  		goto out;
>  	}
>  
> +	if (flags & HIST_FIELD_FL_TIMESTAMP) {
> +		hist_field->fn = hist_field_timestamp;
> +		hist_field->size = sizeof(u64);
> +		goto out;
> +	}
> +
>  	if (WARN_ON_ONCE(!field))
>  		goto out;
>

[SNIP]
> @@ -1520,6 +1557,8 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
>  
>  	update_cond_flag(file);
>  
> +	tracing_set_time_stamp_abs(file->tr, true);
> +

Hmm.. does it makes all events using absolute timestamp?  Where is it
turned off?

Thanks,
Namhyung


>  	if (trace_event_trigger_enable_disable(file, 1) < 0) {
>  		list_del_rcu(&data->list);
>  		update_cond_flag(file);
> -- 
> 1.9.3
> 
