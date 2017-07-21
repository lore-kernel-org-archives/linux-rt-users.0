From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 19/32] tracing: Add variable reference handling to hist
 triggers
Date: Fri, 21 Jul 2017 12:31:08 +0900
Message-ID: <20170721033108.GC21128@danjae.aot.lge.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <f7caa5656819589319f15638b87cac9b9e1a8bd1.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7caa5656819589319f15638b87cac9b9e1a8bd1.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 26, 2017 at 05:49:20PM -0500, Tom Zanussi wrote:
> Add the necessary infrastructure to allow the variables defined on one
> event to be referenced in another.  This allows variables set by a
> previous event to be referenced and used in expressions combining the
> variable values saved by that previous event and the event fields of
> the current event.  For example, here's how a latency can be
> calculated and saved into yet another variable named 'wakeup_lat':
> 
>     # echo 'hist:keys=pid,prio:ts0=common_timestamp ...
>     # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...
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

I think it'd be better spliting this into 3 parts: add hist_elt_data,
pass tracing_map_elt to hist field func and add var ref logic.


[SNIP]
> @@ -241,6 +270,324 @@ static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
>  	return ts;
>  }
>  
> +static LIST_HEAD(hist_var_list);
> +
> +struct hist_var_data {
> +	struct list_head list;
> +	struct hist_trigger_data *hist_data;
> +};

Hmm.. I'm confused whether this list maintains reference of variable
or defintion (or both?).  It seems an entry is added only by
save_hist_vars() which is for definition.  But find_any_var_ref()
looks it up for references..  What am I missing?

Also I think it'd be better keeping this list for each instance rather
than globally.


[SNIP]
> @@ -2186,10 +2613,32 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
>  		tracing_set_time_stamp_abs(file->tr, false);
>  }
>  
> +static bool hist_file_check_refs(struct trace_event_file *file)
> +{
> +	struct hist_trigger_data *hist_data;
> +	struct event_trigger_data *test;
> +
> +	printk("func: %s\n", __func__);

Please remove this.

Thanks,
Namhyung


> +
> +	list_for_each_entry_rcu(test, &file->triggers, list) {
> +		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
> +			hist_data = test->private_data;
> +			if (check_var_refs(hist_data))
> +				return true;
> +			break;
> +		}
> +	}
> +
> +	return false;
> +}
