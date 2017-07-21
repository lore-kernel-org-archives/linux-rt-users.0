From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 19/32] tracing: Add variable reference handling to hist
 triggers
Date: Fri, 21 Jul 2017 11:41:18 -0500
Message-ID: <1500655278.21148.21.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <f7caa5656819589319f15638b87cac9b9e1a8bd1.1498510759.git.tom.zanussi@linux.intel.com>
         <20170721033108.GC21128@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721033108.GC21128@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-07-21 at 12:31 +0900, Namhyung Kim wrote:
> On Mon, Jun 26, 2017 at 05:49:20PM -0500, Tom Zanussi wrote:
> > Add the necessary infrastructure to allow the variables defined on one
> > event to be referenced in another.  This allows variables set by a
> > previous event to be referenced and used in expressions combining the
> > variable values saved by that previous event and the event fields of
> > the current event.  For example, here's how a latency can be
> > calculated and saved into yet another variable named 'wakeup_lat':
> > 
> >     # echo 'hist:keys=pid,prio:ts0=common_timestamp ...
> >     # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...
> > 
> > In the first event, the event's timetamp is saved into the variable
> > ts0.  In the next line, ts0 is subtracted from the second event's
> > timestamp to produce the latency.
> > 
> > Further users of variable references will be described in subsequent
> > patches, such as for instance how the 'wakeup_lat' variable above can
> > be displayed in a latency histogram.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> I think it'd be better spliting this into 3 parts: add hist_elt_data,
> pass tracing_map_elt to hist field func and add var ref logic.
> 

Yeah, that makes sense, will do.

> 
> [SNIP]
> > @@ -241,6 +270,324 @@ static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
> >  	return ts;
> >  }
> >  
> > +static LIST_HEAD(hist_var_list);
> > +
> > +struct hist_var_data {
> > +	struct list_head list;
> > +	struct hist_trigger_data *hist_data;
> > +};
> 
> Hmm.. I'm confused whether this list maintains reference of variable
> or defintion (or both?).  It seems an entry is added only by
> save_hist_vars() which is for definition.  But find_any_var_ref()
> looks it up for references..  What am I missing?
> 

Nothing - it should be both, but as you point out it's missing the
reference-only triggers.  Most of the time when you create a hist
trigger that references a variable, you also create a variable to
receive the result and use it later, which is why you don't normally
see a problem.  Thanks for noticing this..

Tom
