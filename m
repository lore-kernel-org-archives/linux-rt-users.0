From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFD 3/5] tracing: Add option to quantize key values
Date: Thu, 30 Apr 2015 21:12:34 -0500
Message-ID: <1430446354.17922.30.camel@picadillo>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
	 <1430388385-29558-4-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430388385-29558-4-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2015-04-30 at 12:06 +0200, Daniel Wagner wrote:
> Let's group some values together. This avoids a too detailed
> histogram. Some sort of logarythmic scale could be useful
> for latency plots.
> 
> Now we can write something like:
> 
> 'hist:key=latency.bucket:val=hitcount:sort=latency'
> 
> latency:          0 hitcount:     166440
> latency:        256 hitcount:      21104
> latency:        512 hitcount:       7754
> latency:        768 hitcount:       3269
> latency:       1024 hitcount:       1647
> latency:       1280 hitcount:        841
> latency:       1536 hitcount:        524
> latency:       1792 hitcount:        371
> latency:       2048 hitcount:        302
> latency:       2304 hitcount:        240
> latency:       2560 hitcount:        207
> latency:       2816 hitcount:        149
> latency:       3072 hitcount:        123
> latency:       3328 hitcount:        119
> latency:       3584 hitcount:        102
> latency:       3840 hitcount:         94
> latency:       4096 hitcount:         89
> latency:       4352 hitcount:         79
> latency:       4608 hitcount:         88
> 

Nice addition!

> One thing I struggled with the grammatic above is that I haven't found
> a nice way to pass in arguments, for example the bucket size. There a lot
> of options to do it. Just a couple random ideas, not necessarly consistent
> or clever:
> 
> 'hist:key=latency.bucket[10,1.5]:val=hitcount:sort=latency'
>    where [x,y]: x first bucket size, y scaling factor
> 

I like this notation - it's consistent with the other uses of the dot
notation in that it's modifying the way things are displayed, in this
case displaying latency as a histogram with specific [non-default]
parameters.

Tom

> 'hist:key=latency:val=hitcount:sort=latency:bucket=latency,10,1.5'
> 
> Not for inclusion!
> 
> Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
>  kernel/trace/trace_events_hist.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index fe06707..cac94a6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -84,6 +84,7 @@ enum hist_field_flags {
>  	HIST_FIELD_STRING	= 8,
>  	HIST_FIELD_EXECNAME	= 16,
>  	HIST_FIELD_SYSCALL	= 32,
> +	HIST_FIELD_BUCKET	= 64,
>  };
>  
>  struct hist_trigger_sort_key {
> @@ -400,6 +401,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
>  				flags |= HIST_FIELD_EXECNAME;
>  			else if (!strcmp(field_str, "syscall"))
>  				flags |= HIST_FIELD_SYSCALL;
> +			else if (!strcmp(field_str, "bucket"))
> +				flags |= HIST_FIELD_BUCKET;
>  		}
>  
>  		field = trace_find_event_field(file->event_call, field_name);
> @@ -900,6 +903,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
>  		key = entries;
>  	} else {
>  		field_contents = hist_data->key->fn(hist_data->key, rec);
> +		if (hist_data->key->flags & HIST_FIELD_BUCKET)
> +			field_contents &= ~0xff;
> +
>  		if (hist_data->key->flags & HIST_FIELD_STRING)
>  			key = (void *)field_contents;
>  		else
> @@ -1343,6 +1349,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
>  		flags_str = "hex";
>  	else if (hist_field->flags & HIST_FIELD_SYSCALL)
>  		flags_str = "syscall";
> +	else if (hist_field->flags & HIST_FIELD_BUCKET)
> +		flags_str = "bucket";
>  	else if (hist_field->flags & HIST_FIELD_EXECNAME)
>  		flags_str = "execname";
>  
