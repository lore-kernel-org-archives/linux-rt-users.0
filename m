From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3 1/7] tracing: Refactor hist trigger action code
Date: Fri, 10 Aug 2018 09:05:03 -0500
Message-ID: <1533909903.1918.9.camel@kernel.org>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <9d8aaf30dc0c8d48885b0936a038ddd770a55caa.1533753152.git.tom.zanussi@linux.intel.com>
         <20180810065858.GB479@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810065858.GB479@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2018-08-10 at 15:58 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Thu, Aug 09, 2018 at 09:34:11AM -0500, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > The hist trigger action code currently implements two essentially
> > hard-coded pairs of 'actions' - onmax(), which tracks a variable
> > and
> > saves some event fields when a max is hit, and onmatch(), which is
> > hard-coded to generate a synthetic event.
> > 
> > These hardcoded pairs (track max/save fields and detect
> > match/generate
> > synthetic event) should really be decoupled into separate
> > components
> > that can then be arbitrarily combined.  The first component of each
> > pair (track max/detect match) is called a 'handler' in the new
> > code,
> > while the second component (save fields/generate synthetic event)
> > is
> > called an 'action' in this scheme.
> > 
> > This change refactors the action code to reflect this split by
> > adding
> > two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
> > actions, ACTION_SAVE and ACTION_TRACE.
> > 
> > The new code combines them to produce the existing ONMATCH/TRACE
> > and
> > ONMAX/SAVE functionality, but doesn't implement the other
> > combinations
> > now possible.  Future patches will expand these to further useful
> > cases, such as ONMAX/TRACE, as well as add additional handlers and
> > actions such as ONCHANGE and SNAPSHOT.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > @@ -3421,10 +3419,69 @@ static int parse_action_params(char
> > *params, struct action_data *data)
> >  	return ret;
> >  }
> >  
> > -static struct action_data *onmax_parse(char *str)
> > +static int action_parse(char *str, struct action_data *data,
> > +			enum handler_id handler)
> > +{
> > +	char *action_name;
> > +	int ret = 0;
> > +
> > +	strsep(&str, ".");
> > +	if (!str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	action_name = strsep(&str, "(");
> > +	if (!action_name || !str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (strncmp(action_name, "save", strlen("save")) == 0) {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (!params) {
> > +			hist_err("action parsing: No params found
> > for %s", "save");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		ret = parse_action_params(params, data);
> > +		if (ret)
> > +			goto out;
> > +
> > +		if (handler == HANDLER_ONMAX)
> > +			data->fn = onmax_save;
> > +
> > +		data->action = ACTION_SAVE;
> > +	} else {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (params) {
> > +			ret = parse_action_params(params, data);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +
> > +		data->fn = action_trace;
> > +		data->action = ACTION_TRACE;
> 
> This will set action name as (synthetic) event name, right?  I think

Right.

> it's natural to have "trace" for it with this change.  Maybe it's
> time
> to change the syntax like below?
> 
>   onmatch(SYS.EVENT).trace(EVENT, FIELD, ...)
> 
> Of course it should support old syntax too..
> 

Yeah, I can easily add this variant while keeping the original syntax. 
Will do that in v4.

Thanks,

Tom
