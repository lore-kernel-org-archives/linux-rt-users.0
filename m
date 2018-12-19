From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
Date: Wed, 19 Dec 2018 09:01:43 -0600
Message-ID: <1545231703.4491.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Wed, 2018-12-19 at 21:22 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 18 Dec 2018 14:33:22 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Since all the variable reference hist_fields are collected into
> > hist_data->var_refs[] array, there's no need to go through all the
> > fields looking for them, or in separate arrays like
> > synth_var_refs[],
> > which will be going away soon anyway.
> > 
> > This also allows us to get rid of some unnecessary code and
> > functions
> > currently used for the same purpose.
> 
> I just have a nitpick. 
> 
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 57 +++++-----------------------
> > ------------
> >  1 file changed, 7 insertions(+), 50 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 25d06b3ae1f6..ee839c52bd3f 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1299,45 +1299,11 @@ check_field_for_var_ref(struct hist_field
> > *hist_field,
> >  {
> >  	struct hist_field *found = NULL;
> >  
> > -	if (hist_field && hist_field->flags &
> > HIST_FIELD_FL_VAR_REF) {
> > -		if (hist_field->var.idx == var_idx &&
> > -		    hist_field->var.hist_data == var_data) {
> > -			found = hist_field;
> > -		}
> > -	}
> > -
> > -	return found;
> > -}
> > -
> > -static struct hist_field *
> > -check_field_for_var_refs(struct hist_trigger_data *hist_data,
> > -			 struct hist_field *hist_field,
> > -			 struct hist_trigger_data *var_data,
> > -			 unsigned int var_idx,
> > -			 unsigned int level)
> > -{
> > -	struct hist_field *found = NULL;
> > -	unsigned int i;
> > -
> > -	if (level > 3)
> > -		return found;
> > -
> > -	if (!hist_field)
> > -		return found;
> > +	WARN_ON(!(hist_field && hist_field->flags &
> > HIST_FIELD_FL_VAR_REF));
> >  
> > -	found = check_field_for_var_ref(hist_field, var_data,
> > var_idx);
> > -	if (found)
> > -		return found;
> > -
> > -	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
> > -		struct hist_field *operand;
> > -
> > -		operand = hist_field->operands[i];
> > -		found = check_field_for_var_refs(hist_data,
> > operand, var_data,
> > -						 var_idx, level +
> > 1);
> > -		if (found)
> > -			return found;
> > -	}
> > +	if (hist_field && hist_field->var.idx == var_idx &&
> > +	    hist_field->var.hist_data == var_data)
> > +		found = hist_field;
> >  
> >  	return found;
> 
> It seems we don't need "found" var here. Just return hist_field or
> NULL.
> 

OK, will change these and resubmit shortly.

Thanks,

Tom
