From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 09/18] tracing: Add indexing of arguments for function
 based events
Date: Fri, 9 Feb 2018 08:56:15 +0900
Message-ID: <20180208235615.GA28206@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231018.338259949@goodmis.org>
 <20180208105924.GB26290@sejong>
 <20180208104343.2fa63eda@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
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
        kernel-team@lge.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208104343.2fa63eda@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Feb 08, 2018 at 10:43:43AM -0500, Steven Rostedt wrote:
> On Thu, 8 Feb 2018 19:59:24 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > @@ -347,6 +361,8 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
> > >  	char buf[8];
> > >  	int ret;
> > >  
> > > +	val += arg->index;
> > > +
> > >  	if (!arg->indirect)
> > >  		return val;  
> > 
> > So this also works without the indirect, and just add the immediate to
> > the value.
> 
> Not sure what you are asking here. The immediate adds to the current
> value, where as the indirect will then look what's at that location.

I expected that the immediate offset is only meaningful with the
indirect (dereference) as the doc says just about it.  So I asked it
was intentional or not.

Thanks,
Namhyung
