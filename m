From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 24/32] tracing: Add 'onmax' hist trigger action support
Date: Wed, 26 Jul 2017 11:45:47 -0500
Message-ID: <1501087547.3214.18.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <eba89c852028b147fe695bb47cfafd690c345e74.1498510759.git.tom.zanussi@linux.intel.com>
         <20170726030427.GB32043@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726030427.GB32043@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Wed, 2017-07-26 at 12:04 +0900, Namhyung Kim wrote:
> On Mon, Jun 26, 2017 at 05:49:25PM -0500, Tom Zanussi wrote:
> > Add an 'onmax(var).save(field,...)' hist trigger action which is
> > invoked whenever an event exceeds the current maximum.
> > 
> > The end result is that the trace event fields or variables specified
> > as the onmax.save() params will be saved if 'var' exceeds the current
> > maximum for that hist trigger entry.  This allows context from the
> > event that exhibited the new maximum to be saved for later reference.
> > When the histogram is displayed, additional fields displaying the
> > saved values will be printed.
> > 
> > As an example the below defines a couple of hist triggers, one for
> > sched_wakeup and another for sched_switch, keyed on pid.  Whenever a
> > sched_wakeup occurs, the timestamp is saved in the entry corresponding
> > to the current pid, and when the scheduler switches back to that pid,
> > the timestamp difference is calculated.  If the resulting latency
> > exceeds the current maximum latency, the specified save() values are
> > saved:
> > 
> >     # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
> >         if comm=="cyclictest"' >> \
> >       /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > 
> >     # echo 'hist:keys=next_pid:\
> >       wakeup_lat=common_timestamp.usecs-$ts0:\
> >       onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
> >         if next_comm=="cyclictest"' >> \
> >       /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > 
> > When the histogram is displayed, the max value and the saved values
> > corresponding to the max are displayed following the rest of the
> > fields:
> > 
> >     # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
> >       { next_pid:       2255 } hitcount:        239 \
> >         common_timestamp-$ts0:          0
> 
> What is this, wakeup_lat?  If so, it'd be better showing the variable name.
> 

Yeah, this is actually old output - I need to update the examples in the
commit messages.  Anyway, this kind of thing is no longer displayed at
all in the current version.

> 
> >         max:         27  next_comm: cyclictest \
> >         prev_pid:          0  prev_prio:        120  prev_comm: swapper/1 \
> >       { next_pid:       2256 } hitcount:       2355  common_timestamp-$ts0: 0 \
> >       	max:         49  next_comm: cyclictest \
> >         prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
> > 
> >     Totals:
> >         Hits: 12970
> 
> Why total hits is different than the sum of two?
> 

The reason for differences like this is that the tracing map counts
lookups as 'hits', and we're using lookups to resolve variable
references, so this number no longer matches the actual number of
updates to elements.  I'm going to add a patch that doesn't account
lookups in the hitcount, as I don't think it should.

> >         Entries: 2
> >         Dropped: 0
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 310 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 276 insertions(+), 34 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index b1f859c..d191f1a 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -282,6 +282,10 @@ struct hist_trigger_data {
> >  	unsigned int			n_field_var_str;
> >  	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
> >  	unsigned int			n_field_var_hists;
> > +
> > +	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
> > +	unsigned int			n_max_vars;
> > +	unsigned int			n_max_var_str;
> >  };
> >  
> >  struct synth_field {
> > @@ -318,6 +322,12 @@ struct action_data {
> >  	char			*match_event_system;
> >  	char			*synth_event_name;
> >  	struct synth_event	*synth_event;
> > +
> > +	char			*onmax_var_str;
> > +	char			*onmax_fn_name;
> > +	unsigned int		max_var_ref_idx;
> > +	struct hist_field	*max_var;
> > +	struct hist_field	*onmax_var;
> 
> Couldn't it be a union?
> 

Yeah, I think that makes more sense.

> >  };
> 
> [SNIP]
> > @@ -2613,6 +2633,222 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
> >  	return create_field_var(hist_data, file, var_name);
> >  }
> >  
> > +static void onmax_print(struct seq_file *m,
> > +			struct hist_trigger_data *hist_data,
> > +			struct tracing_map_elt *elt,
> > +			struct action_data *data)
> > +{
> > +	unsigned int i, save_var_idx, max_idx = data->max_var->var.idx;
> > +
> > +	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
> > +
> > +	for (i = 0; i < hist_data->n_max_vars; i++) {
> > +		struct hist_field *save_val = hist_data->max_vars[i]->val;
> > +		struct hist_field *save_var = hist_data->max_vars[i]->var;
> > +		u64 val;
> > +
> > +		save_var_idx = save_var->var.idx;
> > +
> > +		val = tracing_map_read_var(elt, save_var_idx);
> > +
> > +		if (save_val->flags & HIST_FIELD_FL_STRING) {
> > +			seq_printf(m, "  %s: %-50s", save_var->var.name,
> 
> It seems TASK_COMM_LEN is enough.  Or please define STR_VAR_LEN or
> something.
> 
> 
> > +				   (char *)(uintptr_t)(val));
> > +		} else
> > +			seq_printf(m, "  %s: %10llu", save_var->var.name, val);
> > +	}
> > +}
> 
> [SNIP]
> > +static struct action_data *onmax_parse(char *str)
> > +{
> > +	char *onmax_fn_name, *onmax_var_str;
> > +	struct action_data *data;
> > +	int ret = -EINVAL;
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	onmax_var_str = strsep(&str, ")");
> > +	if (!onmax_var_str || !str)
> > +		return ERR_PTR(-EINVAL);
> > +	data->onmax_var_str = kstrdup(onmax_var_str, GFP_KERNEL);
> > +
> > +	strsep(&str, ".");
> > +	if (!str)
> > +		goto free;
> > +
> > +	onmax_fn_name = strsep(&str, "(");
> > +	if (!onmax_fn_name || !str)
> > +		goto free;
> > +
> > +	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (!params)
> > +			goto free;
> > +
> > +		ret = parse_action_params(params, data);
> > +		if (ret)
> > +			goto free;
> > +	}
> 
> Hmm.. is it ok to give a function name other than 'save'?
> 

No, good point, thanks for pointing it out.

Tom
