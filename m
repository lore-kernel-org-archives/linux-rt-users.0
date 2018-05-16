From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 06/10] tracing: Add trigger file for trace_markers
 tracefs/ftrace/print
Date: Wed, 16 May 2018 16:49:04 +0900
Message-ID: <20180516074904.GA30309@danjae.aot.lge.com>
References: <20180511194927.190877137@goodmis.org>
 <20180511195340.876528094@goodmis.org>
 <20180514031322.GB9220@sejong>
 <20180514110436.336b214b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514110436.336b214b@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Mon, May 14, 2018 at 11:04:36AM -0400, Steven Rostedt wrote:
> On Mon, 14 May 2018 12:13:22 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Fri, May 11, 2018 at 03:49:33PM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > Allow writing to the trace_markers file initiate triggers defined in
> > > tracefs/ftrace/print/trigger file. This will allow of user space to trigger
> > > the same type of triggers (including histograms) that the trace events use.
> > > 
> > > Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > Cc: Clark Williams <williams@redhat.com>
> > > Cc: Karim Yaghmour <karim.yaghmour@opersys.com>
> > > Cc: Brendan Gregg <bgregg@netflix.com>
> > > Suggested-by: Joel Fernandes <joelaf@google.com>
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---  
> > 
> > [SNIP]
> > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > > index e3a658bac10f..de3fce14cd00 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -230,7 +230,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
> > >  	FILTER_OTHER
> > >  );
> > >  
> > > -FTRACE_ENTRY(print, print_entry,
> > > +FTRACE_ENTRY_REG(print, print_entry,
> > >  
> > >  	TRACE_PRINT,
> > >  
> > > @@ -242,7 +242,9 @@ FTRACE_ENTRY(print, print_entry,
> > >  	F_printk("%ps: %s",
> > >  		 (void *)__entry->ip, __entry->buf),
> > >  
> > > -	FILTER_OTHER
> > > +	FILTER_OTHER,
> > > +
> > > +	 ftrace_event_register  
> > 
> > I wonder this is still needed since you added __find_event_file()
> > which ignores the reg field.  Maybe I'm missing something..
> 
> No, that's not the reason for it. The reason is due to the
> event_trigger_callback() function. I'll update the changelog to specify
> this.
> 
> We have something like:
> 
>  # echo snapshot > events/ftrace/print/trigger
> 
> Which will do:
> 
>   event_trigger_write() {
>     event_trigger_regex_write() {
>       trigger_process_regex() {
>         for p in trigger_commands {
>           p->func(); /* trigger_snapshot_cmd->func */
>             event_trigger_callback() {
>               cmd_ops->reg() /* register_trigger() */ {
>                 trace_event_trigger_enable_disable() {
>                   trace_event_enable_disable() {
>                     call->class->reg();
> 
> Without this patch, we jump to NULL and BOOM!

Thanks for the explanation.  I wonder we can skip calling
trace_event_enable_disable() for events which have the
TRACE_EVENT_FL_IGNORE_ENABLE flag.

Thanks,
Namhyung
