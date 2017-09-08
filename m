From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 31/40] tracing: Allow whitespace to surround hist
 trigger filter
Date: Fri, 8 Sep 2017 14:50:23 -0400
Message-ID: <20170908145023.462c3a79@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <9e6d9f17bcd71f29dec9039ab00d316ca2965c43.1504642143.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <9e6d9f17bcd71f29dec9039ab00d316ca2965c43.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:43 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> The existing code only allows for one space before and after the 'if'
> specifying the filter for a hist trigger.  Add code to make that more
> permissive as far as whitespace goes.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0a398f3..4f66f2e 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4819,7 +4819,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  	struct synth_event *se;
>  	const char *se_name;
>  	bool remove = false;
> -	char *trigger;
> +	char *trigger, *p;
>  	int ret = 0;
>  
>  	if (!param)
> @@ -4829,9 +4829,19 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  		remove = true;
>  
>  	/* separate the trigger from the filter (k:v [if filter]) */
> -	trigger = strsep(&param, " \t");
> -	if (!trigger)
> -		return -EINVAL;
> +	trigger = param;
> +	p = strstr(param, " if");
> +	if (!p)
> +		p = strstr(param, "\tif");
> +	if (p) {
> +		if (p == trigger)
> +			return -EINVAL;
> +		param = p + 1;
> +		param = strstrip(param);
> +		*p = '\0';
> +		trigger = strstrip(trigger);
> +	} else
> +		param = NULL;

This seems rather complex. Wouldn't the following work?

	param = skip_spaces(param);
	trigger = strsep(&param, " \t");
	if (param)
		param = strstrip(param);

-- Steve

>  
>  	attrs = parse_hist_trigger_attrs(trigger);
>  	if (IS_ERR(attrs))
> @@ -4889,6 +4899,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  	}
>  
>  	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> +
>  	/*
>  	 * The above returns on success the # of triggers registered,
>  	 * but if it didn't register any it returns zero.  Consider no
