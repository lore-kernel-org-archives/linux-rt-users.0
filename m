From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 22/37] tracing: Add variable reference handling to
 hist triggers
Date: Tue, 21 Nov 2017 19:53:25 +0900
Message-ID: <20171121105325.GA17299@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <7c8f53b3a98f9422db9e345b532bacbae1a64862.1510948725.git.tom.zanussi@linux.intel.com>
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
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:44699 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdKUKx2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 05:53:28 -0500
Content-Disposition: inline
In-Reply-To: <7c8f53b3a98f9422db9e345b532bacbae1a64862.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 17, 2017 at 02:33:01PM -0600, Tom Zanussi wrote:
> Add the necessary infrastructure to allow the variables defined on one
> event to be referenced in another.  This allows variables set by a
> previous event to be referenced and used in expressions combining the
> variable values saved by that previous event and the event fields of
> the current event.  For example, here's how a latency can be
> calculated and saved into yet another variable named 'wakeup_lat':
> 
>     # echo 'hist:keys=pid,prio:ts0=$common_timestamp ...
>     # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp-$ts0 ...
> 
> In the first event, the event's timetamp is saved into the variable
> ts0.  In the next line, ts0 is subtracted from the second event's
> timestamp to produce the latency.
> 
> Further users of variable references will be described in subsequent
> patches, such as for instance how the 'wakeup_lat' variable above can
> be displayed in a latency histogram.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> @@ -914,13 +1383,38 @@ struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
>  			      struct trace_event_file *file, char *str,
>  			      unsigned long *flags, char *var_name)
>  {
> -	char *s;
> +	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
>  	struct ftrace_event_field *field = NULL;
>  	struct hist_field *hist_field = NULL;
>  	int ret = 0;
>  
> -	s = local_field_var_ref(hist_data, str);
> -	if (s)
> +	s = strchr(str, '.');
> +	if (s) {
> +		s = strchr(++s, '.');
> +		if (s) {
> +			ref_system = strsep(&str, ".");
> +			if (!str) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ref_event = strsep(&str, ".");
> +			if (!str) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ref_var = str;
> +		}
> +	}
> +
> +	s = local_field_var_ref(hist_data, ref_var);

Wouldn't it be called when ref_system + ref_event are NULL or same as
hist_data->file's ?

Thanks,
Namhyung


> +	if (!s) {
> +		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
> +		if (hist_field) {
> +			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
> +			hist_field->var_ref_idx = hist_data->n_var_refs++;
> +			return hist_field;
> +		}
> +	} else
>  		str = s;
>  
>  	field = parse_field(hist_data, file, str, flags);
