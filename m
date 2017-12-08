From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v7 15/37] tracing: Add variable support to hist triggers
Date: Fri, 08 Dec 2017 13:54:58 -0600
Message-ID: <1512762898.4353.4.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
         <04af0ae029bd09e4f7b163d7793e094fe4b1163a.1512593081.git.tom.zanussi@linux.intel.com>
         <20171208130224.GA7312@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208130224.GA7312@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-12-08 at 22:02 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Dec 06, 2017 at 04:37:56PM -0600, Tom Zanussi wrote:
> > Add support for saving the value of a current event's event field by
> > assigning it to a variable that can be read by a subsequent event.
> > 
> > The basic syntax for saving a variable is to simply prefix a unique
> > variable name not corresponding to any keyword along with an '=' sign
> > to any event field.
> > 
> > Both keys and values can be saved and retrieved in this way:
> > 
> >     # echo 'hist:keys=next_pid:vals=$ts0:ts0=common_timestamp ...
> >     # echo 'hist:timer_pid=common_pid:key=$timer_pid ...'
> > 
> > If a variable isn't a key variable or prefixed with 'vals=', the
> > associated event field will be saved in a variable but won't be summed
> > as a value:
> > 
> >     # echo 'hist:keys=next_pid:ts1=common_timestamp:...
> > 
> > Multiple variables can be assigned at the same time:
> > 
> >     # echo 'hist:keys=pid:vals=$ts0,$b,field2:ts0=common_timestamp,b=field1 ...
> > 
> > Multiple (or single) variables can also be assigned at the same time
> > using separate assignments:
> > 
> >     # echo 'hist:keys=pid:vals=$ts0:ts0=common_timestamp:b=field1:c=field2 ...
> > 
> > Variables set as above can be used by being referenced from another
> > event, as described in a subsequent patch.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> > ---
> 
> [SNIP]
> > @@ -962,14 +1201,28 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
> >  				    struct ring_buffer_event *rbe)
> >  {
> >  	struct hist_field *hist_field;
> > -	unsigned int i;
> > +	unsigned int i, var_idx;
> >  	u64 hist_val;
> >  
> >  	for_each_hist_val_field(i, hist_data) {
> >  		hist_field = hist_data->fields[i];
> > -		hist_val = hist_field->fn(hist_field, rec, rbe);
> > +		hist_val = hist_field->fn(hist_field, rbe, rec);
> 
> Why is this changed?
> 

It's a bit premature here - 20/37 (Pass tracing_map_elt to
hist_field_accessor) actually changes the param order so the above is
correct in the end.  Anyway, I'll move this to 20/37 to avoid the
inconsistency in this patch.

> 
> > +		if (hist_field->flags & HIST_FIELD_FL_VAR) {
> > +			var_idx = hist_field->var.idx;
> > +			tracing_map_set_var(elt, var_idx, hist_val);
> > +			continue;
> > +		}
> >  		tracing_map_update_sum(elt, i, hist_val);
> >  	}
> > +
> > +	for_each_hist_key_field(i, hist_data) {
> > +		hist_field = hist_data->fields[i];
> > +		if (hist_field->flags & HIST_FIELD_FL_VAR) {
> > +			hist_val = hist_field->fn(hist_field, rbe, rec);
> 
> Also it seems to have a wrong argument order.
> 

Same here - hist_field_fn_t ends up with this order but it should be the
reverse in this patch.

Thanks,

Tom

> Thanks,
> Namhyung
> 
> 
> > +			var_idx = hist_field->var.idx;
> > +			tracing_map_set_var(elt, var_idx, hist_val);
> > +		}
> > +	}
> >  }
