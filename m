From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 03/18] tracing: Add simple arguments to function based
 events
Date: Thu, 8 Feb 2018 10:37:56 -0500
Message-ID: <20180208103756.743a53e0@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.459764446@goodmis.org>
        <20180208101818.GA26290@sejong>
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
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180208101818.GA26290@sejong>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 8 Feb 2018 19:18:18 +0900
Namhyung Kim <namhyung@kernel.org> wrote:
						call->event.type,
> > @@ -150,6 +310,15 @@ static void func_event_trace(struct trace_event_file *trace_file,
> >  	entry = ring_buffer_event_data(event);
> >  	entry->ip = ip;
> >  	entry->parent_ip = parent_ip;
> > +	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
> > +
> > +	list_for_each_entry(arg, &func_event->args, list) {
> > +		if (i < nr_args)
> > +			val = args[i];
> > +		else
> > +			val = 0;
> > +		memcpy(&entry->data[arg->offset], &val, arg->size);
> > +	}  
> 
> Where is the 'i' increased?

Good question. I think the increment got nuked via one of my rebases,
and then most my testing happened at the end of the patch series where
"i" is no longer used. But that's no excuse for keeping this bug
around. I'll fix it and test again at each patch.

Thanks for reporting.

-- Steve
