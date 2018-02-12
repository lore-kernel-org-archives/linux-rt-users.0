From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 12/18] tracing: Add accessing direct address from
 function based events
Date: Tue, 13 Feb 2018 00:47:50 +0900
Message-ID: <20180213004750.62e7ee5a1038589a80b09b41@kernel.org>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.828677654@goodmis.org>
        <20180209003436.GB28206@sejong>
        <20180209170737.5921ea0f@gandalf.local.home>
        <20180212020644.GG31513@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel-t
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180212020644.GG31513@sejong>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 12 Feb 2018 11:06:44 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Fri, Feb 09, 2018 at 05:07:37PM -0500, Steven Rostedt wrote:
> > On Fri, 9 Feb 2018 09:34:36 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > Couldn't we use the symbol name directly?  Maybe it needs a syntax to
> > > indicate global variable.  Like this?
> > > 
> > >   # echo 'do_IRQ(int $total_forks)' > function_events
> > 
> > 
> > I decided to stick with "$".
> 
> Good.
> 
> 
> [SNIP]
> >  static enum func_states
> >  process_event(struct func_event *fevent, const char *token, enum func_states state)
> >  {
> > @@ -469,6 +479,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
> >  	case FUNC_STATE_ARRAY_END:
> >  		if (WARN_ON(!fevent->last_arg))
> >  			break;
> > +		if (token[0] == '$')
> > +			return FUNC_STATE_SYMBOL;
> >  		if (update_arg_name(fevent, token) < 0)
> >  			break;
> >  		if (strncmp(token, "0x", 2) == 0)
> > @@ -542,6 +554,11 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
> >  		fevent->last_arg->index += val;
> >  		return FUNC_STATE_VAR;
> >  
> > +	case FUNC_STATE_SYMBOL:
> > +		if (!isalpha(token[0]) && token[0] != '_')
> > +			break;
> > +		goto equal;
> > +
> >  	case FUNC_STATE_ADDR:
> >  		switch (token[0]) {
> >  		case ')':
> > @@ -599,14 +616,26 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
> >  		break;
> >  
> >  	case FUNC_STATE_EQUAL:
> > +		if (token[0] == '$')
> > +			return FUNC_STATE_SYMBOL;
> >  		if (strncmp(token, "0x", 2) != 0)
> >  			break;
> >   equal:
> >  		if (WARN_ON(!fevent->last_arg))
> >  			break;
> > -		ret = kstrtoul(token, 0, &val);
> > -		if (ret < 0)
> > -			break;
> > +		if (isalpha(token[0]) || token[0] != '_') {
> 
> I guess you wanted the token[0] being '_'.  Maybe it'd be better adding
> 
>   #define isident0(x)  (isalpha(x) || (x) == '_')

If this '$' is only for the symbol or direct address(with 0x prefix),
you just need to check by !isdigit(token[0]), isn't it? 
(and if it is insane get_symbol just fails)

Thanks,

> 
> ?
> 
> Thanks,
> Namhyung
> 
> 
> > +			ret = get_symbol(token, &val);
> > +			if (ret < 0)
> > +				break;
> > +			if (!fevent->last_arg->name) {
> > +				if (update_arg_name(fevent, token) < 0)
> > +					break;
> > +			}
> > +		} else {
> > +			ret = kstrtoul(token, 0, &val);
> > +			if (ret < 0)
> > +				break;
> > +		}
> >  		update_arg = false;
> >  		fevent->last_arg->index = val;
> >  		fevent->last_arg->arg = -1;
> > -- 
> > 2.13.6
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
