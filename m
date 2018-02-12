From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 12/18] tracing: Add accessing direct address from
 function based events
Date: Mon, 12 Feb 2018 11:47:02 -0500
Message-ID: <20180212114702.0452e71c@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.828677654@goodmis.org>
        <20180209003436.GB28206@sejong>
        <20180209170737.5921ea0f@gandalf.local.home>
        <20180212020644.GG31513@sejong>
        <20180213004750.62e7ee5a1038589a80b09b41@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
        kernel-team@lge.com
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213004750.62e7ee5a1038589a80b09b41@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 13 Feb 2018 00:47:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > >  		if (WARN_ON(!fevent->last_arg))
> > >  			break;
> > > -		ret = kstrtoul(token, 0, &val);
> > > -		if (ret < 0)
> > > -			break;
> > > +		if (isalpha(token[0]) || token[0] != '_') {  
> > 
> > I guess you wanted the token[0] being '_'.  Maybe it'd be better adding
> > 
> >   #define isident0(x)  (isalpha(x) || (x) == '_')  
> 
> If this '$' is only for the symbol or direct address(with 0x prefix),
> you just need to check by !isdigit(token[0]), isn't it? 
> (and if it is insane get_symbol just fails)

I modified a lot of this code for the next version (which I'm still
tweaking).

I have this for next_token() (which I may add for the
trace_events_filter.c code as Al Viro has recently pointed out issues
with its parsing):

static char *next_token(char **ptr, char *last)
{
	char *arg;
	char *str;

	if (!*ptr)
		return NULL;

	arg = *ptr;

	if (*last)
		*arg = *last;

	if (!*arg)
		return NULL;

	for (str = arg; *str; str++) {
		if (!isalnum(*str) && *str != '_')
			break;
	}
	if (*str) {
		if (str == arg)
			str++;
		*last = *str;
		*str = 0;
		*ptr = str;
		return arg;
	}

	*last = 0;
	*ptr = NULL;
	return arg;
}


And this:

static bool valid_name(const char *token)
{
	return isalpha(token[0]) || token[0] == '_';
}

As all tokens will now be either entirely alphanumeric with '_' or a
single character.

-- Steve
