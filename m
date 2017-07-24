From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 23/32] tracing: Add 'onmatch' hist trigger action support
Date: Mon, 24 Jul 2017 11:17:46 -0500
Message-ID: <1500913066.21148.49.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <8411497118160688b13fcf500596f6094d2eabcd.1498510759.git.tom.zanussi@linux.intel.com>
         <20170723151226.GA4947@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbdGXQRt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jul 2017 12:17:49 -0400
In-Reply-To: <20170723151226.GA4947@danjae.aot.lge.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Namhyung,

On Mon, 2017-07-24 at 00:12 +0900, Namhyung Kim wrote:
> On Mon, Jun 26, 2017 at 05:49:24PM -0500, Tom Zanussi wrote:
> > Add an 'onmatch(matching.event).<synthetic_event_name>(param list)'
> > hist trigger action which is invoked with the set of variables or
> > event fields named in the 'param list'.  The result is the generation
> > of a synthetic event that consists of the values contained in those
> > variables and/or fields at the time the invoking event was hit.
> > 
> > As an example the below defines a simple synthetic event using a
> > variable defined on the sched_wakeup_new event, and shows the event
> > definition with unresolved fields, since the sched_wakeup_new event
> > with the testpid variable hasn't been defined yet:
> > 
> >     # echo 'wakeup_new_test pid_t pid; int prio' >> \
> >       /sys/kernel/debug/tracing/synthetic_events
> > 
> >     # cat /sys/kernel/debug/tracing/synthetic_events
> >       wakeup_new_test pid_t pid; int prio
> > 
> > The following hist trigger both defines a testpid variable and
> > specifies an onmatch() trace action that uses that variable along with
> > a non-variable field to generate a wakeup_new_test synthetic event
> > whenever a sched_wakeup_new event occurs, which because of the 'if
> > comm == "cyclictest"' filter only happens when the executable is
> > cyclictest:
> > 
> >     # echo 'hist:keys=testpid=pid:\
> >       onmatch(sched.sched_wakeup_new).wakeup_new_test($testpid, prio) \
> >         if comm=="cyclictest"' >> \
> >       /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
> > 
> > Creating and displaying a histogram based on those events is now just
> > a matter of using the fields and new synthetic event in the
> > tracing/events/synthetic directory, as usual:
> > 
> >     # echo 'hist:keys=pid,prio:sort=pid,prio' >> \
> >       /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> This patch is also big and it'd be better splitting - add type to
> hist_field, add variable handling and implement onmatch() action.
> 

Yeah, makes sense, will do.

> 
> >  kernel/trace/trace_events_hist.c | 955 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 940 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index e11b3a3..b1f859c 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -59,6 +59,7 @@ struct hist_field {
> >  	unsigned int			size;
> >  	unsigned int			offset;
> >  	unsigned int                    is_signed;
> > +	const char			*type;
> >  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
> >  	struct hist_trigger_data	*hist_data;
> >  	struct hist_var			var;
> > @@ -243,6 +244,16 @@ struct hist_trigger_attrs {
> >  	unsigned int	n_actions;
> >  };
> >  
> > +struct field_var {
> > +	struct hist_field	*var;
> > +	struct hist_field	*val;
> > +};
> > +
> > +struct field_var_hist {
> > +	struct hist_trigger_data	*hist_data;
> > +	char				*cmd;
> > +};
> > +
> >  struct hist_trigger_data {
> >  	struct hist_field               *fields[HIST_FIELDS_MAX];
> >  	unsigned int			n_vals;
> > @@ -263,6 +274,14 @@ struct hist_trigger_data {
> >  
> >  	struct action_data		*actions[HIST_ACTIONS_MAX];
> >  	unsigned int			n_actions;
> > +
> > +	struct hist_field		*synth_var_refs[SYNTH_FIELDS_MAX];
> > +	unsigned int			n_synth_var_refs;
> > +	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
> > +	unsigned int			n_field_vars;
> > +	unsigned int			n_field_var_str;
> > +	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
> > +	unsigned int			n_field_var_hists;
> >  };
> >  
> >  struct synth_field {
> > @@ -291,7 +310,14 @@ typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
> >  
> >  struct action_data {
> >  	action_fn_t		fn;
> > +	unsigned int		n_params;
> > +	char			*params[SYNTH_FIELDS_MAX];
> > +
> >  	unsigned int		var_ref_idx;
> > +	char			*match_event;
> > +	char			*match_event_system;
> > +	char			*synth_event_name;
> > +	struct synth_event	*synth_event;
> >  };
> >  
> >  static LIST_HEAD(synth_event_list);
> > @@ -802,6 +828,50 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
> >  	return event;
> >  }
> >  
> > +static void action_trace(struct hist_trigger_data *hist_data,
> > +			 struct tracing_map_elt *elt, void *rec,
> > +			 struct ring_buffer_event *rbe,
> > +			 struct action_data *data, u64 *var_ref_vals)
> > +{
> > +	struct synth_event *event = data->synth_event;
> > +
> > +	trace_synth(event, var_ref_vals, data->var_ref_idx);
> > +}
> > +
> > +static bool check_hist_action_refs(struct hist_trigger_data *hist_data,
> > +				   struct synth_event *event)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < hist_data->n_actions; i++) {
> > +		struct action_data *data = hist_data->actions[i];
> > +
> > +		if (data->fn == action_trace && data->synth_event == event)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static LIST_HEAD(hist_action_list);
> > +static LIST_HEAD(hist_var_list);
> > +
> > +struct hist_var_data {
> > +	struct list_head list;
> > +	struct hist_trigger_data *hist_data;
> > +};
> > +
> > +static bool check_synth_action_refs(struct synth_event *event)
> > +{
> > +	struct hist_var_data *var_data;
> > +
> > +	list_for_each_entry(var_data, &hist_action_list, list)
> > +		if (check_hist_action_refs(var_data->hist_data, event))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +
> >  static int create_synth_event(int argc, char **argv)
> >  {
> >  	struct synth_field *fields[SYNTH_FIELDS_MAX];
> > @@ -832,15 +902,17 @@ static int create_synth_event(int argc, char **argv)
> >  	event = find_synth_event(name);
> >  	if (event) {
> >  		if (delete_event) {
> > +			if (check_synth_action_refs(event)) {
> > +				ret = -EBUSY;
> > +				goto out;
> > +			}
> >  			remove_synth_event(event);
> >  			goto err;
> >  		} else
> >  			ret = -EEXIST;
> >  		goto out;
> > -	} else if (delete_event) {
> > -		ret = -EINVAL;
> > +	} else if (delete_event)
> >  		goto out;
> > -	}
> 
> Why is it changed?
> 

Yeah, shouldn't have been, thanks for pointing this out.

Tom


