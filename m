From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 22/33] tracing: Add support for 'field variables'
Date: Thu, 12 Oct 2017 16:35:50 -0500
Message-ID: <1507844150.9720.4.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <4f507b4fc0584f08b9a7d6abf1b8d718f8306c5c.1506105131.git.tom.zanussi@linux.intel.com>
         <20171012025211.GC9177@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012025211.GC9177@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Thu, 2017-10-12 at 11:52 +0900, Namhyung Kim wrote:
> On Fri, Sep 22, 2017 at 03:00:02PM -0500, Tom Zanussi wrote:
> > Users should be able to directly specify event fields in hist trigger
> > 'actions' rather than being forced to explicitly create a variable for
> > that purpose.
> > 
> > Add support allowing fields to be used directly in actions, which
> > essentially does just that - creates 'invisible' variables for each
> > bare field specified in an action.  If a bare field refers to a field
> > on another (matching) event, it even creates a special histogram for
> > the purpose (since variables can't be defined on an existing histogram
> > after histogram creation).
> > 
> > Here's a simple example that demonstrates both.  Basically the
> > onmatch() action creates a list of variables corresponding to the
> > parameters of the synthetic event to be generated, and then uses those
> > values to generate the event.  So for the wakeup_latency synthetic
> > event 'call' below the first param, $wakeup_lat, is a variable defined
> > explicitly on sched_switch, where 'next_pid' is just a normal field on
> > sched_switch, and prio is a normal field on sched_waking.
> > 
> > Since the mechanism works on variables, those two normal fields just
> > have 'invisible' variables created internally for them.  In the case of
> > 'prio', which is on another event, we actually need to create an
> > additional hist trigger and define the invisible event on that, since
> 
> s/event/variable/ ?
> 

Right, thanks for pointing that out.

> 
> > once a hist trigger is defined, variables can't be added to it later.
> > 
> >   echo 'wakeup_latency u64 lat; pid_t pid; int prio' >>
> >        /sys/kernel/debug/tracing/synthetic_events
> > 
> >   echo 'hist:keys=pid:ts0=$common_timestamp.usecs >>
> >        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> > 
> > echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:
> >       onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,prio)
> >             >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> 
> > +static bool compatible_keys(struct hist_trigger_data *target_hist_data,
> > +			    struct hist_trigger_data *hist_data,
> > +			    unsigned int n_keys)
> > +{
> > +	struct hist_field *target_hist_field, *hist_field;
> > +	unsigned int n, i, j;
> > +
> > +	if (hist_data->n_fields - hist_data->n_vals != n_keys)
> > +		return false;
> > +
> > +	i = hist_data->n_vals;
> > +	j = target_hist_data->n_vals;
> > +
> > +	for (n = 0; n < n_keys; n++) {
> > +		hist_field = hist_data->fields[i + n];
> > +		target_hist_field = hist_data->fields[j + n];
> 
> s/hist_data/target_hist_data/
> 

Yeah, I actually fixed this, but put it in the onmatch patch, will move
it to this patch.

> > +
> > +		if (strcmp(hist_field->type, target_hist_field->type) != 0)
> > +			return false;
> > +		if (hist_field->size != target_hist_field->size)
> > +			return false;
> > +		if (hist_field->is_signed != target_hist_field->is_signed)
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> [SNIP]
> 
> > +static struct hist_field *
> > +create_field_var_hist(struct hist_trigger_data *target_hist_data,
> > +		      char *system, char *event_name, char *field_name)
> > +{
> > +	struct trace_array *tr = target_hist_data->event_file->tr;
> > +	struct hist_field *event_var = ERR_PTR(-EINVAL);
> > +	struct hist_trigger_data *hist_data;
> > +	unsigned int i, n, first = true;
> > +	struct field_var_hist *var_hist;
> > +	struct trace_event_file *file;
> > +	struct hist_field *key_field;
> > +	char *saved_filter;
> > +	char *cmd;
> > +	int ret;
> > +
> > +	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	file = event_file(tr, system, event_name);
> > +
> > +	if (IS_ERR(file)) {
> > +		ret = PTR_ERR(file);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	hist_data = find_compatible_hist(target_hist_data, file);
> > +	if (!hist_data)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	var_hist = kzalloc(sizeof(*var_hist), GFP_KERNEL);
> > +	if (!var_hist)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +	if (!cmd) {
> > +		kfree(var_hist);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	strcat(cmd, "keys=");
> > +
> > +	for_each_hist_key_field(i, hist_data) {
> > +		key_field = hist_data->fields[i];
> > +		if (!first)
> > +			strcat(cmd, ",");
> > +		strcat(cmd, key_field->field->name);
> > +		first = false;
> > +	}
> > +
> > +	strcat(cmd, ":synthetic_");
> > +	strcat(cmd, field_name);
> > +	strcat(cmd, "=");
> > +	strcat(cmd, field_name);
> > +
> > +	saved_filter = find_trigger_filter(hist_data, file);
> > +	if (saved_filter) {
> > +		strcat(cmd, " if ");
> > +		strcat(cmd, saved_filter);
> > +	}
> > +
> > +	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
> > +	if (!var_hist->cmd) {
> > +		kfree(cmd);
> > +		kfree(var_hist);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	var_hist->hist_data = hist_data;
> 
> Hmm.. so it's a compatible hist data, not the newly created one,
> right?  Might confuse someone later.. ;-)
> 

Yeah, will add some more comments to this and related functions to make
it less confusing.

> 
> > +
> > +	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> > +				      "", "hist", cmd);
> > +	if (ret) {
> > +		kfree(cmd);
> > +		kfree(var_hist->cmd);
> > +		kfree(var_hist);
> > +		return ERR_PTR(ret);
> > +	}
> 
> What if two different event want to create synthetic variables for a
> same field?  I suspect one failed because the variable names are same
> but it could continue since the variable is there anyway.  Probably it
> would be better to use a different error code for the case..
> 

Yeah, in this case, one will fail when there's no reason it should, will
fix, thanks for thinking of these things ;-)

Tom
