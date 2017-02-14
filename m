From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 11/21] tracing: Add variable support to hist
 triggers
Date: Tue, 14 Feb 2017 09:25:26 -0600
Message-ID: <1487085926.1208.8.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <5f57709aa313b2faa09ba39c889bdfd2a495106a.1486569306.git.tom.zanussi@linux.intel.com>
         <20170213060330.GF14705@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753078AbdBNPZa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 10:25:30 -0500
In-Reply-To: <20170213060330.GF14705@sejong>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Namhyung,

On Mon, 2017-02-13 at 15:03 +0900, Namhyung Kim wrote:
> On Wed, Feb 08, 2017 at 11:25:07AM -0600, Tom Zanussi wrote:
> > Add support for saving the value of a current event's event field by
> > assigning it to a variable that can be read by a subsequent event.
> > 
> > The basic syntax for saving a variable is to simply prefix a unique
> > variable name not corresponding to any keyword along with an '=' sign
> > to any event field.
> > 
> > Both keys and values can be saved and retrieved in this way:
> > 
> >     # echo 'hist:keys=next_pid:vals=ts0=common_timestamp ...
> >     # echo 'hist:key=timer_pid=common_pid ...'
> > 
> > If a variable isn't a key variable or prefixed with 'vals=', the
> > associated event field will be saved in a variable but won't be summed
> > as a value:
> > 
> >     # echo 'hist:keys=next_pid:ts1=common_timestamp:...
> > 
> > Multiple variables can be assigned at the same time:
> > 
> >     # echo 'hist:keys=pid:vals=ts0=common_timestamp,b=field1,field2 ...
> > 
> > Variables set as above can be used by being referenced from another
> > event, as described in a subsequent patch.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 160 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 131 insertions(+), 29 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 8d7f7dd..e707577 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -29,6 +29,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
> >  				struct ring_buffer_event *rbe);
> >  
> >  #define HIST_FIELD_OPERANDS_MAX	2
> > +#define HIST_ASSIGNMENT_MAX	4
> >  
> >  struct hist_field {
> >  	struct ftrace_event_field	*field;
> > @@ -36,8 +37,10 @@ struct hist_field {
> >  	hist_field_fn_t			fn;
> >  	unsigned int			size;
> >  	unsigned int			offset;
> > -	unsigned int                    is_signed;
> > +	unsigned int			is_signed;
> 
> It seems like an unnecessary change.
> 

Yes, it is.

> >  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
> > +	u64				var_val;
> > +	char				*var_name;
> >  };
> >  
> >  static u64 hist_field_none(struct hist_field *field, void *event,
> > @@ -140,12 +143,16 @@ enum hist_field_flags {
> >  	HIST_FIELD_FL_SYSCALL		= 128,
> >  	HIST_FIELD_FL_STACKTRACE	= 256,
> >  	HIST_FIELD_FL_LOG2		= 512,
> > -	HIST_FIELD_FL_TIMESTAMP		= 1024,
> > +	HIST_FIELD_FL_VAR		= 1024,
> > +	HIST_FIELD_FL_VAR_ONLY		= 2048,
> > +	HIST_FIELD_FL_TIMESTAMP		= 4096,
> 
> Why did you move the timestamp?
> 

No good reason, just happened to be how some refactoring factored out.

> >  };
> >  
> >  struct hist_trigger_attrs {
> >  	char		*keys_str;
> >  	char		*vals_str;
> > +	char		*assignment_str[HIST_ASSIGNMENT_MAX];
> > +	unsigned int	n_assignments;
> >  	char		*sort_key_str;
> >  	char		*name;
> >  	bool		pause;
> > @@ -241,9 +248,14 @@ static int parse_map_size(char *str)
> >  
> >  static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
> >  {
> > +	unsigned int i;
> > +
> >  	if (!attrs)
> >  		return;
> >  
> > +	for (i = 0; i < attrs->n_assignments; i++)
> > +		kfree(attrs->assignment_str[i]);
> > +
> >  	kfree(attrs->name);
> >  	kfree(attrs->sort_key_str);
> >  	kfree(attrs->keys_str);
> > @@ -258,9 +270,9 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
> >  	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
> >  	    (strncmp(str, "keys=", strlen("keys=")) == 0))
> >  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> > -	else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
> > -		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
> > -		 (strncmp(str, "values=", strlen("values=")) == 0))
> > +	else if (((strncmp(str, "val=", strlen("val=")) == 0) ||
> > +		  (strncmp(str, "vals=", strlen("vals=")) == 0) ||
> > +		  (strncmp(str, "values=", strlen("values=")) == 0)))
> 
> Looks unnecessary too.
> 

Yep.

> >  		attrs->vals_str = kstrdup(str, GFP_KERNEL);
> >  	else if (strncmp(str, "sort=", strlen("sort=")) == 0)
> >  		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
> > @@ -274,8 +286,22 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
> >  			goto out;
> >  		}
> >  		attrs->map_bits = map_bits;
> > -	} else
> > -		ret = -EINVAL;
> > +	} else {
> > +		char *assignment;
> > +
> > +		if (attrs->n_assignments == HIST_ASSIGNMENT_MAX) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		assignment = kstrdup(str, GFP_KERNEL);
> > +		if (!assignment) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		attrs->assignment_str[attrs->n_assignments++] = assignment;
> > +	}
> >   out:
> >  	return ret;
> >  }
> 
> [SNIP]
> > @@ -839,8 +913,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
> >  			idx = tracing_map_add_key_field(map,
> >  							hist_field->offset,
> >  							cmp_fn);
> > -
> > -		} else
> > +		} else if (!(hist_field->flags & HIST_FIELD_FL_VAR))
> >  			idx = tracing_map_add_sum_field(map);
> >  
> >  		if (idx < 0)
> > @@ -931,6 +1004,11 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
> >  	for_each_hist_val_field(i, hist_data) {
> >  		hist_field = hist_data->fields[i];
> >  		hist_val = hist_field->fn(hist_field, rec, rbe);
> > +		if (hist_field->flags & HIST_FIELD_FL_VAR) {
> > +			hist_field->var_val = hist_val;
> > +			if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
> > +				continue;
> > +		}
> >  		tracing_map_update_sum(elt, i, hist_val);
> 
> Hmm.. you didn't add a field for HIST_FIELD_FL_VAR but it attempts to
> update it, no?
> 

There's a little confusion regarding VAR_ONLY, and the whole thing needs
to be cleaned up wrt that.  Originally, for simplicity I implemented it
such that you could only either have variables or values, not both.
Later when I added the assignment code, I changed that and some of the
old related code remained.  Anyway, suffice it to say that this whole
area will be cleaned up... 

> 
> >  	}
> >  }
> > @@ -996,17 +1074,21 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
> >  			} else
> >  				key = (void *)&field_contents;
> >  		}
> > -
> >  		if (use_compound_key)
> >  			add_to_key(compound_key, key, key_field, rec);
> > +
> > +		if (key_field->flags & HIST_FIELD_FL_VAR)
> > +			key_field->var_val = (u64)key;
> >  	}
> >  
> >  	if (use_compound_key)
> >  		key = compound_key;
> >  
> >  	elt = tracing_map_insert(hist_data->map, key);
> > -	if (elt)
> > -		hist_trigger_elt_update(hist_data, elt, rec, rbe);
> > +	if (!elt)
> > +		return;
> > +
> > +	hist_trigger_elt_update(hist_data, elt, rec, rbe);
> >  }
> >  
> >  static void hist_trigger_stacktrace_print(struct seq_file *m,
> > @@ -1228,7 +1310,12 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
> >  {
> >  	const char *field_name = hist_field_name(hist_field);
> >  
> > -	seq_printf(m, "%s", field_name);
> > +	if (hist_field->var_name)
> > +		seq_printf(m, "%s=", hist_field->var_name);
> > +
> > +	if (field_name)
> > +		seq_printf(m, "%s", field_name);
> > +
> >  	if (hist_field->flags) {
> >  		const char *flags_str = get_hist_field_flags(hist_field);
> >  
> > @@ -1237,6 +1324,16 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
> >  	}
> >  }
> >  
> > +static bool var_only(struct hist_trigger_data *hist_data)
> > +{
> > +	unsigned int i;
> > +
> > +	for_each_hist_val_field(i, hist_data)
> > +		if (hist_data->fields[i]->flags & HIST_FIELD_FL_VAR_ONLY)
> > +			return true;
> > +	return false;
> > +}
> 
> This means if there's a var-only field, the whole hist will be treated
> as var-only, right?  What if it has normal fields and var-only fields
> at the same time?  Didn't it have "hitcount"?  Please see below..
> 

As mentioned, this is a holdover that no longer makes sense, will clean
the whole thing up in the next version.

> > +
> >  static int event_hist_trigger_print(struct seq_file *m,
> >  				    struct event_trigger_ops *ops,
> >  				    struct event_trigger_data *data)
> > @@ -1266,15 +1363,19 @@ static int event_hist_trigger_print(struct seq_file *m,
> >  			hist_field_print(m, key_field);
> >  	}
> >  
> > -	seq_puts(m, ":vals=");
> > +	if (!var_only(hist_data))
> > +		seq_puts(m, ":vals=");
> > +	else
> > +		seq_puts(m, ":");
> >  
> >  	for_each_hist_val_field(i, hist_data) {
> > -		if (i == HITCOUNT_IDX)
> > +		if (i == HITCOUNT_IDX && !var_only(hist_data))
> >  			seq_puts(m, "hitcount");
> 
> Looks like var-only hist cannot have hitcount, right?
> 
> >  		else if (hist_data->fields[i]->flags & HIST_FIELD_FL_TIMESTAMP)
> >  			seq_puts(m, "common_timestamp");
> >  		else {
> > -			seq_puts(m, ",");
> > +			if (!var_only(hist_data))
> > +				seq_puts(m, ",");
> 
> If a var-only hist hist can have multiple fields, it should print ","
> as well IMHO.  Also it seems "common_timestamp" also needs it.
> 

Yep, some missing commas in the output, thanks for pointing them out.

Thanks,

Tom



