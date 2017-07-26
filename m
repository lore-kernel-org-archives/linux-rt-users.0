From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 29/32] tracing: Add 'last error' error facility for hist
 triggers
Date: Wed, 26 Jul 2017 11:47:41 -0500
Message-ID: <1501087661.3214.20.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <cad8b161d443ba1140572d764745ea113a60f4b9.1498510759.git.tom.zanussi@linux.intel.com>
         <20170726043902.GC32043@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726043902.GC32043@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Wed, 2017-07-26 at 13:39 +0900, Namhyung Kim wrote:
> On Mon, Jun 26, 2017 at 05:49:30PM -0500, Tom Zanussi wrote:
> > With the addition of variables and actions, it's become necessary to
> > provide more detailed error information to users about syntax errors.
> > 
> > Add a 'last error' facility accessible via the erroring event's 'hist'
> > file.  Reading the hist file after an error will display more detailed
> > information about what went wrong, if information is available.  This
> > extended error information will be available until the next hist
> > trigger command for that event.
> > 
> >   # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> >   echo: write error: Invalid argument
> > 
> >   # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
> > 
> >   ERROR: Couldn't yyy: zzz
> >   Last command: xxx
> > 
> > Also add specific error messages for variable and action errors.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  Documentation/trace/events.txt   |  19 ++++
> >  kernel/trace/trace_events_hist.c | 181 ++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 188 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
> > index 9717688..f271d87 100644
> > --- a/Documentation/trace/events.txt
> > +++ b/Documentation/trace/events.txt
> > @@ -686,6 +686,25 @@ The following commands are supported:
> >  				 interpreted as microseconds.
> >      cpu                    int - the cpu on which the event occurred.
> >  
> > +  Extended error information
> > +  --------------------------
> > +
> > +  For some error conditions encountered when invoking a hist trigger
> > +  command, extended error information is available via the
> > +  corresponding event's 'hist' file.  Reading the hist file after an
> > +  error will display more detailed information about what went wrong,
> > +  if information is available.  This extended error information will
> > +  be available until the next hist trigger command for that event.
> > +
> > +  If available for a given error condition, the extended error
> > +  information and usage takes the following form:
> > +
> > +    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > +    echo: write error: Invalid argument
> > +
> > +    # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
> > +    ERROR: Couldn't yyy: zzz
> > +      Last command: xxx
> >  
> >  6.2 'hist' trigger examples
> >  ---------------------------
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 799b95e..06049f8 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -288,6 +288,7 @@ struct hist_trigger_data {
> >  	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
> >  	unsigned int			n_max_vars;
> >  	unsigned int			n_max_var_str;
> > +	char				*last_err;
> 
> I couldn't find where it's used.
> 

It's not, will remove.

> >  };
> >  
> >  struct synth_field {
> > @@ -332,6 +333,83 @@ struct action_data {
> >  	struct hist_field	*onmax_var;
> >  };
> >  
> > +
> > +static char *hist_err_str;
> > +static char *last_hist_cmd;
> > +
> > +static int hist_err_alloc(void)
> > +{
> > +	int ret = 0;
> > +
> > +	last_hist_cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +	hist_err_str = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +	if (!last_hist_cmd || !hist_err_str)
> > +		ret = -ENOMEM;
> 
> This makes me uncomfortable..
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static void last_cmd_set(char *str)
> > +{
> > +	if (!last_hist_cmd || !str)
> > +		return;
> > +
> > +	if (strlen(last_hist_cmd) > MAX_FILTER_STR_VAL - 1)
> > +		return;
> 
> Hmm.. why does it check 'last_hist_cmd' rather than 'str'?
> 
> > +
> > +	strcpy(last_hist_cmd, str);
> > +}
> > +
> > +static void hist_err(char *str, char *var)
> > +{
> > +	int maxlen = MAX_FILTER_STR_VAL - 1;
> > +
> > +	if (strlen(hist_err_str))
> > +		return;
> 
> Shouldn't it move to after the NULL check below?
> 

Yes, will fix this and the others above.

Thanks,

Tom
