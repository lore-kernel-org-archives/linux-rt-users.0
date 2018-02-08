From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/20 v2] tracing: Add function based events
Date: Thu, 8 Feb 2018 10:53:23 -0500
Message-ID: <20180208105323.6263b2dd@gandalf.local.home>
References: <20180207202402.253089656@goodmis.org>
        <20180207202814.738058149@goodmis.org>
        <20180208112014.GA30958@krava>
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
To: Jiri Olsa <jolsa@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180208112014.GA30958@krava>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 8 Feb 2018 12:20:14 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 03:24:03PM -0500, Steven Rostedt wrote:
> 
> SNIP
> 
> > +
> > +void create_function_event_file(struct dentry *d_tracer)
> > +{
> > +	struct dentry *d;
> > +
> > +	d = trace_create_file("function_events", 0644, d_tracer, NULL,
> > +			      &func_event_fops);
> > +	WARN(!d, "Failed to create function_events file");
> > +}  
> 
> this fucntion seems like leftover.. can't see any code using it
> 

You are right. My original version had it created via instance, but
then I realized that the events are for all instances. I'll nuke this.

Thanks!

-- Steve
