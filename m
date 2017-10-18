From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 25/33] tracing: Allow whitespace to surround hist
 trigger filter
Date: Wed, 18 Oct 2017 09:11:54 -0500
Message-ID: <1508335914.524.4.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <68a176facc91c86e90862f3e719c6bf57f505340.1506105131.git.tom.zanussi@linux.intel.com>
         <20171004141105.4f88f44f@gandalf.local.home>
         <1507143917.14461.8.camel@tzanussi-mobl.amr.corp.intel.com>
         <20171018030044.GC11621@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018030044.GC11621@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-10-18 at 12:00 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Oct 04, 2017 at 02:05:17PM -0500, Tom Zanussi wrote:
> > Hi Steve,
> > 
> > On Wed, 2017-10-04 at 14:11 -0400, Steven Rostedt wrote:
> > > On Fri, 22 Sep 2017 15:00:05 -0500
> > > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > > 
> > > > The existing code only allows for one space before and after the 'if'
> > > > specifying the filter for a hist trigger.  Add code to make that more
> > > > permissive as far as whitespace goes.  Specifically, we want to allow
> > > > spaces in the trigger itself now that we have additional syntax
> > > > (onmatch/onmax) where spaces are more natural e.g. spaces after commas
> > > > in param lists.
> > > > 
> > > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > ---
> > > >  kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
> > > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > > > index ba42fe2..431f2b2 100644
> > > > --- a/kernel/trace/trace_events_hist.c
> > > > +++ b/kernel/trace/trace_events_hist.c
> > > > @@ -4857,7 +4857,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
> > > >  	struct synth_event *se;
> > > >  	const char *se_name;
> > > >  	bool remove = false;
> > > > -	char *trigger;
> > > > +	char *trigger, *p;
> > > >  	int ret = 0;
> > > >  
> > > >  	if (!param)
> > > > @@ -4866,10 +4866,23 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
> > > >  	if (glob[0] == '!')
> > > >  		remove = true;
> > > >  
> > > > -	/* separate the trigger from the filter (k:v [if filter]) */
> > > > -	trigger = strsep(&param, " \t");
> > > > -	if (!trigger)
> > > > -		return -EINVAL;
> > > > +	/*
> > > > +	 * separate the trigger from the filter (k:v [if filter])
> > > > +	 * allowing for whitespace in the trigger
> > > > +	 */
> > > > +	trigger = param;
> > > > +	p = strstr(param, " if");
> > > > +	if (!p)
> > > > +		p = strstr(param, "\tif");
> > > > +	if (p) {
> > > > +		if (p == trigger)
> > > > +			return -EINVAL;
> > > > +		param = p + 1;
> > > > +		param = strstrip(param);
> > > > +		*p = '\0';
> > > > +		trigger = strstrip(trigger);
> > > > +	} else
> > > > +		param = NULL;
> > > 
> > > I think you forgot to update this:
> > > 
> > 
> > I was going to but on closer inspection realized the simpler form
> > wouldn't accomplish the same thing - the problem this is trying to solve
> > is to allow bits of whitespace within the trigger (because we now have
> > function-like syntax, which should allow whitespace after commas for
> > instance) and separating the trigger from the filter ('if').  So we
> > explicitly search for 'if' with preceding whitespace, which strsep won't
> > accomplish.
> 
> What if a field name is started with 'if' (like "ifb")?  I think you
> also need to check whitespace after the 'if'.
> 

Yeah, it will unnecessarily truncate the trigger, will fix.

Thanks,

Tom

> Thanks,
> Namhyung
