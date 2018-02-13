From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Date: Tue, 13 Feb 2018 10:28:28 -0500
Message-ID: <20180213102828.11bf186c@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.582037880@goodmis.org>
        <20180209051301.GE28206@sejong>
        <20180209104758.093d31ad@gandalf.local.home>
        <20180212021534.GH31513@sejong>
        <20180212122354.1d2fb867@gandalf.local.home>
        <20180213092737.GJ31513@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213092737.GJ31513@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 13 Feb 2018 18:27:37 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, Feb 12, 2018 at 12:23:54PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Feb 2018 11:15:34 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >   
> > > > It should have been:
> > > > 
> > > > 		return process_redirects(arg, val, buf);    
> > > 
> > > But I think you need to consider data type of the arg when
> > > dereferencing the last redirect.  
> > 
> > What for?  
> 
> Otherwise it'd return a value of unsigned long type regardless of the
> type of the arg.  I thought it should have same logic as indirect
> args.

OK, I see what you are saying. Yeah, I think it should have the check,
or ...

> 
> But it seems not matter since record_entry() would copy it only for
> the arg->size.  Then type check in __get_arg() might be unnecessary
> too.

No, on big endian boxes it can break. I think the answer is to have the
final assignment do the conversion. Or I should have a helper function
to do it.

> 
> > 
> > Also this code has also changed. I haven't posted new patches but my
> > latest is in my git tree in the branch ftrace/dynamic-ftrace-events.  
> 
> I've checked it.  And it seems to have another problem for indirect
> (but not redirect) arrays and strings.  Like 'x32[1] foo[2]'?

Yep, I know the issue there, I haven't gotten around to fixing it.

Thanks!

-- Steve
