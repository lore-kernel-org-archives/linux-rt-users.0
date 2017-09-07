From: "Liu, Baohong" <baohong.liu@intel.com>
Subject: RE: [PATCH v2 07/40] tracing: Apply absolute timestamps to instance
 max buffer
Date: Thu, 7 Sep 2017 01:15:58 +0000
Message-ID: <3CD19752AA18BE4A91FBEE9F90EBB89D70C135AB@ORSMSX106.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <ebdb168d0be042dcdf51f81e696b17fabe3609c1.1504642143.git.tom.zanussi@linux.intel.com>
 <20170906204946.61c4e680@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "Patel, Vedang" <vedang.patel@intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "joel.opensrc@gmail.com" <joel.opensrc@gmail.com>,
        "joelaf@google.com" <joelaf@google.com>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906204946.61c4e680@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 6 Sep 2017 20:49:46 -0400 Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:19 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > From: Baohong Liu <baohong.liu@intel.com>
> >
> > Currently absolute timestamps are applied to both regular and max
> > buffers only for global trace. For instance trace, absolute timestamps
> > are applied only to regular buffer. But, regular and max buffers can
> > be swapped, for example, following a snapshot. So, for instance trace,
> > bad timestamps can be seen following a snapshot.
> > Let's apply absolute timestamps to instance max buffer as well.
> >
> > Similarly, buffer clock change is applied to instance max buffer as
> > well.
> >
> > Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> > ---
> >  kernel/trace/trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c index
> > 66d465e..719e4c1 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6223,7 +6223,7 @@ static int tracing_set_clock(struct trace_array *tr,
> const char *clockstr)
> >  	tracing_reset_online_cpus(&tr->trace_buffer);
> >
> >  #ifdef CONFIG_TRACER_MAX_TRACE
> > -	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
> > +	if (tr->max_buffer.buffer)
> >  		ring_buffer_set_clock(tr->max_buffer.buffer,
> trace_clocks[i].func);
> >  	tracing_reset_online_cpus(&tr->max_buffer);
> >  #endif
> 
> 
> 
> 
> > @@ -6307,7 +6307,7 @@ int tracing_set_time_stamp_abs(struct trace_array
> *tr, bool abs)
> >  	tracing_reset_online_cpus(&tr->trace_buffer);
> >
> >  #ifdef CONFIG_TRACER_MAX_TRACE
> > -	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
> > +	if (tr->max_buffer.buffer)
> >  		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
> >  	tracing_reset_online_cpus(&tr->max_buffer);
> >  #endif
> 
> Please fold this part into the previous patch. I'm adding the first part to my tree
> now and will start testing it tonight, and push it to Linus by the weekend.

Will do.

Thanks,

Baohong

> 
> -- Steve
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
