From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 12/33] tracing: Add variable support to hist triggers
Date: Thu, 12 Oct 2017 10:51:58 -0500
Message-ID: <1507823518.12638.2.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <00ac0ead22391be1e2689d901d63684ea3823bab.1506105131.git.tom.zanussi@linux.intel.com>
         <20171009032727.GA6357@danjae.aot.lge.com>
         <1507728797.8849.16.camel@tzanussi-mobl.amr.corp.intel.com>
         <20171011232347.GA9177@sejong>
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
In-Reply-To: <20171011232347.GA9177@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-10-12 at 08:23 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Oct 11, 2017 at 08:33:17AM -0500, Tom Zanussi wrote:
> > On Mon, 2017-10-09 at 12:27 +0900, Namhyung Kim wrote:
> > > On Fri, Sep 22, 2017 at 02:59:52PM -0500, Tom Zanussi wrote:
> > > > Variables set as above can be used by being referenced from another
> > > > event, as described in a subsequent patch.
> > > 
> > > That means, a variable should be unique (in a tracing instance at least).
> > > 
> > 
> > Not exactly - I thought it would be too restrictive to force users to
> > come up with names that would be unique across an instance, so made them
> > unique to events.  So users can use the same variable name for triggers
> > on multiple events, and in cases where there are multiple events with
> > the same name, use the fully-qualified subsys.event_name.variable_name
> > name to disambiguate them.  If there is only one event with the given
> > name, thus no ambiguity, specifying the bare variable name suffices.
> > Again the intent is to make the common case as simple as possible, but
> > allow for more complex cases without requiring naming gymnastics from
> > the user.
> 
> Agreed.  Thanks for the explanation.
> 
> 
> [SNIP]
> 
> > > > +static int parse_var_defs(struct hist_trigger_data *hist_data)
> > > > +{
> > > > +	char *s, *str, *var_name, *field_str;
> > > > +	unsigned int i, j, n_vars = 0;
> > > > +	int ret = 0;
> > > > +
> > > > +	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
> > > > +		str = hist_data->attrs->assignment_str[i];
> > > > +		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
> > > > +			field_str = strsep(&str, ",");
> > > > +			if (!field_str)
> > > > +				break;
> > > > +
> > > > +			var_name = strsep(&field_str, "=");
> > > > +			if (!var_name || !field_str) {
> > > > +				ret = -EINVAL;
> > > > +				goto free;
> > > > +			}
> > > > +
> > > > +			s = kstrdup(var_name, GFP_KERNEL);
> > > > +			if (!s) {
> > > > +				ret = -ENOMEM;
> > > > +				goto free;
> > > > +			}
> > > > +			hist_data->attrs->var_defs.name[n_vars] = s;
> > > > +
> > > > +			s = kstrdup(field_str, GFP_KERNEL);
> > > > +			if (!s) {
> > > > +				ret = -ENOMEM;
> > > > +				goto free;
> > > 
> > > It seems that it might leak the copy of var_name here..
> > > 
> > 
> > Unless I'm missing something, the free_var_defs() should handle this
> > case too...
> 
> But the var_defs.n_vars was not increased at this point.
> 

Yep.  Got it, thanks.

Tom

> Thanks,
> Namhyung
> 
> 
> > > 
> > > > +			}
> > > > +			hist_data->attrs->var_defs.expr[n_vars++] = s;
> > > > +
> > > > +			hist_data->attrs->var_defs.n_vars = n_vars;
> > > > +
> > > > +			if (n_vars == TRACING_MAP_VARS_MAX)
> > > > +				goto free;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > + free:
> > > > +	free_var_defs(hist_data);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > 
> > 
