From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 37/40] tracing: Add inter-event hist trigger
 Documentation
Date: Wed, 20 Sep 2017 12:15:35 -0500
Message-ID: <1505927735.1845.46.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <f67001c01a5c1a24d4dcd1eea44c7ba71a703988.1504642143.git.tom.zanussi@linux.intel.com>
         <20170920144433.GE29872@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170920144433.GE29872@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Julia,

On Wed, 2017-09-20 at 09:44 -0500, Julia Cartwright wrote:
> On Tue, Sep 05, 2017 at 04:57:49PM -0500, Tom Zanussi wrote:
> > Add background and details on inter-event hist triggers, including
> > hist variables, synthetic events, and actions.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> > ---
> >  Documentation/trace/events.txt | 385 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 385 insertions(+)
> > 
> > diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
> > index f271d87..7ee720b 100644
> > --- a/Documentation/trace/events.txt
> > +++ b/Documentation/trace/events.txt
> > @@ -571,6 +571,7 @@ The following commands are supported:
> >  	.sym-offset display an address as a symbol and offset
> >  	.syscall    display a syscall id as a system call name
> >  	.execname   display a common_pid as a program name
> > +	.usecs      display a $common_timestamp in microseconds
> >  
> >    Note that in general the semantics of a given field aren't
> >    interpreted when applying a modifier to it, but there are some
> > @@ -2101,3 +2102,387 @@ The following commands are supported:
> >          Hits: 489
> >          Entries: 7
> >          Dropped: 0
> > +
> > +6.3 Inter-event hist triggers
> > +-----------------------------
> > +
> > +Inter-event hist triggers are hist triggers that combine values from
> > +one or more other events and create a histogram using that data.  Data
> > +from an inter-event histogram can in turn become the source for
> > +further combined histograms, thus providing a chain of related
> > +histograms, which is important for some applications.
> > +
> > +The most important example of an inter-event quantity that can be used
> > +in this manner is latency, which is simply a difference in timestamps
> > +between two events (although trace events don't have an externally
> > +visible timestamp field, the inter-event hist trigger support adds a
> > +pseudo-field to all events named '$common_timestamp' which can be used
> > +as if it were an actual event field)
> 
> What's between the parentheses is covered below, is it worth mentioning
> in both places?
> 

Probably not, maybe just a quick mention to see below for details on
timestamps, will change regardless..

> [..]
> > +  - Trace events don't have a 'timestamp' associated with them, but
> > +    there is an implicit timestamp saved along with an event in the
> > +    underlying ftrace ring buffer.  This timestamp is now exposed as a
> > +    a synthetic field named '$common_timestamp' which can be used in
> > +    histograms as if it were any other event field.  Note that it has
> > +    a '$' prefixed to it - this is meant to indicate that it isn't an
> > +    actual field in the trace format but rather is a synthesized value
> > +    that nonetheless can be used as if it were an actual field.  By
> > +    default it is in units of nanoseconds; appending '.usecs' to a
> > +    common_timestamp field changes the units to microseconds.
> > +
> > +These features are decribed in more detail in the following sections.
> 
>                       ^ described
> 

Right, thanks for pointing that out ;-)

> > +
> > +6.3.1 Histogram Variables
> > +-------------------------
> > +
> > +Variables are simply named locations used for saving and retrieving
> > +values between matching events.  A 'matching' event is defined as an
> > +event that has a matching key - if a variable is saved for a histogram
> > +entry corresponding to that key, any subsequent event with a matching
> > +key can access that variable.
> > +
> > +A variable's value is normally available to any subsequent event until
> > +it is set to something else by a subsequent event.  The one exception
> > +to that rule is that any variable used in an expression is essentially
> > +'read-once' - once it's used by an expression in a subsequent event,
> > +it's reset to its 'unset' state, which means it can't be used again
> > +unless it's set again.  This ensures not only that an event doesn't
> > +use an uninitialized variable in a calculation, but that that variable
> > +is used only once and not for any unrelated subsequent match.
> > +
> > +The basic syntax for saving a variable is to simply prefix a unique
> > +variable name not corresponding to any keyword along with an '=' sign
> > +to any event field.
> 
> This would seem to make it much more difficult in the future to add new
> keywords for hist triggers without breaking users existing triggers.
> Maybe that's not a problem given the tracing ABI wild west.
> 

Hmm, yeah, not sure how to implement general-purpose variable assignment
without knowing what reserved words would be ahead of time..

> [..]
> > +6.3.2 Synthetic Events
> > +----------------------
> > +
> > +Synthetic events are user-defined events generated from hist trigger
> > +variables or fields associated with one or more other events.  Their
> > +purpose is to provide a mechanism for displaying data spanning
> > +multiple events consistent with the existing and already familiar
> > +usage for normal events.
> > +
> > +To define a synthetic event, the user writes a simple specification
> > +consisting of the name of the new event along with one or more
> > +variables and their types, which can be any valid field type,
> > +separated by semicolons, to the tracing/synthetic_events file.
> > +
> > +For instance, the following creates a new event named 'wakeup_latency'
> > +with 3 fields: lat, pid, and prio.  Each of those fields is simply a
> > +variable reference to a variable on another event:
> > +
> > +  # echo 'wakeup_latency \
> > +          u64 lat; \
> > +          pid_t pid; \
> > +	  int prio' >> \
> > +	  /sys/kernel/debug/tracing/synthetic_events
> > +
> > +Reading the tracing/synthetic_events file lists all the currently
> > +defined synthetic events, in this case the event defined above:
> > +
> > +  # cat /sys/kernel/debug/tracing/synthetic_events
> > +    wakeup_latency u64 lat; pid_t pid; int prio
> > +
> > +An existing synthetic event definition can be removed by prepending
> > +the command that defined it with a '!':
> > +
> > +  # echo '!wakeup_latency u64 lat pid_t pid int prio' >> \
> > +    /sys/kernel/debug/tracing/synthetic_events
> > +
> > +At this point, there isn't yet an actual 'wakeup_latency' event
> > +instantiated in the event subsytem - for this to happen, a 'hist
> > +trigger action' needs to be instantiated and bound to actual fields
> > +and variables defined on other events (see Section 6.3.3 below).
> > +
> > +Once that is done, an event instance is created, and a histogram can
> > +be defined using it:
> > +
> > +  # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
> > +        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
> > +
> > +The new event is created under the tracing/events/synthetic/ directory
> > +and looks and behaves just like any other event:
> > +
> > +  # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
> > +        enable  filter  format  hist  id  trigger
> > +
> > +Like any other event, once a histogram is enabled for the event, the
> > +output can be displayed by reading the event's 'hist' file.
> > +
> > +6.3.3 Hist trigger 'actions'
> > +----------------------------
> > +
> > +A hist trigger 'action' is a function that's executed whenever a
> > +histogram entry is added or updated.
> > +
> > +The default 'action' if no special function is explicity specified is
> > +as it always has been, to simply update the set of values associated
> > +with an entry.  Some applications, however, may want to perform
> > +additional actions at that point, such as generate another event, or
> > +compare and save a maximum.
> > +
> > +The following additional actions are available.  To specify an action
> > +for a given event, simply specify the action between colons in the
> > +hist trigger specification.
> > +
> > +  - onmatch(matching.event).<synthetic_event_name>(param list)
> > +
> > +    The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
> > +    trigger action is invoked whenever an event matches and the
> > +    histogram entry would be added or updated.
> 
> I understand from the documentation that 'onmatch' establishes a
> relation between events, but it isn't clear the nature of this relation.
> 

Well, the syntax and idea behind 'onmatch' has evolved a bit following
the review comments of the past couple iterations of the patchset.  The
underlying mechanism hasn't changed much though, which is that basically
a synthetic event is generated using variables from one or more
'matching' events, where 'matching' means that an event with a matching
key was found in a histogram for that event, and the value of the
variable associated with it is used for the corresponding param when
generating the synthetic event.  So when the event that defines the
onmatch() action occurs, the matching events having the same key as the
onmatch() synthetic event params are looked up and if all are found the
onmatch() action generates the synthetic events using those matching
variables.

Though that's still all true, the most common use case consists of two
events, the event the onmatch() is defined on and the matching.event
specified as onmatch(matching.event).  For most users and use cases that
makes the relationship clear.  That doesn't mean there can only be one
matching event participating - the main change that the switch to the
matching.event syntax added was that if a variable isn't found on the
event onmatch() is defined on, then it's automatically looked for on the
matching.event event.  Basically a syntax change making it more natural
for the user to specify triggers using the most common use case.

> In other words: what criteria are used to determine whether two events
> match?  Is it the trace buffer ordering?  Time ordering?  Something
> else?

A match for an event is just the last matching.event found in the
matching.event histogram.  Or in the more general case, the last event
found in the histogram(s) for each variable used in the synthetic event
generation.

> 
> >                                                  It causes the named
> > +    synthetic event to be generated with the values given in the
> > +    'param list'.  The result is the generation of a synthetic event
> > +    that consists of the values contained in those variables at the
> > +    time the invoking event was hit.
> > +
> > +    The 'param list' consists of one or more parameters which may be
> > +    either variables or fields defined on either the 'matching.event'
> > +    or the target event.  The variables or fields specified in the
> > +    param list may be either fully-qualified or unqualified.  If a
> > +    variable is specified as unqualified, it must be unique between
> > +    the two events.  A field name used as a param can be unqualified
> > +    if it refers to the target event, but must be fully qualified if
> > +    it refers to the matching event.  A fully-qualified name is of the
> > +    form 'system.event_name.$var_name' or 'system.event_name.field'.
> > +
> > +    The 'matching.event' specification is simply the fully qualified
> > +    event name of the event that matches the target event for the
> > +    onmatch() functionality, in the form 'system.event_name'.
> > +
> > +    Finally, the number and type of variables/fields in the 'param
> > +    list' must match the number and types of the fields in the
> > +    synthetic event being generated.
> > +
> > +    As an example the below defines a simple synthetic event and uses
> > +    a variable defined on the sched_wakeup_new event as a parameter
> > +    when invoking the synthetic event.  Here we define the synthetic
> > +    event:
> > +
> > +    # echo 'wakeup_new_test pid_t pid' >> \
> > +           /sys/kernel/debug/tracing/synthetic_events
> > +
> > +    # cat /sys/kernel/debug/tracing/synthetic_events
> > +          wakeup_new_test pid_t pid
> > +
> > +    The following hist trigger both defines the missing testpid
> > +    variable and specifies an onmatch() action that generates a
> > +    wakeup_new_test synthetic event whenever a sched_wakeup_new event
> > +    occurs, which because of the 'if comm == "cyclictest"' filter only
> > +    happens when the executable is cyclictest:
> > +
> > +    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
> > +            wakeup_new_test($testpid) if comm=="cyclictest"' >> \
> > +            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
> > +
> > +    Creating and displaying a histogram based on those events is now
> > +    just a matter of using the fields and new synthetic event in the
> > +    tracing/events/synthetic directory, as usual:
> > +
> > +    # echo 'hist:keys=pid:sort=pid' >> \
> > +           /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
> > +
> > +    Running 'cyclictest' should cause wakeup_new events to generate
> > +    wakeup_new_test synthetic events which should result in histogram
> > +    output in the wakeup_new_test event's hist file:
> > +
> > +    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
> > +
> > +    A more typical usage would be to use two events to calculate a
> > +    latency.  The following example uses a set of hist triggers to
> > +    produce a 'wakeup_latency' histogram:
> > +
> > +    First, we define a 'wakeup_latency' synthetic event:
> > +
> > +    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
> > +            /sys/kernel/debug/tracing/synthetic_events
> > +
> > +    Next, we specify that whenever we see a sched_waking event for a
> > +    cyclictest thread, save the timestamp in a 'ts0' variable:
> > +
> > +    # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=$common_timestamp.usecs \
> > +            if comm=="cyclictest"' >> \
> > +	    /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> > +
> > +    Then, when the corresponding thread is actually scheduled onto the
> > +    CPU by a sched_switch event, calculate the latency and use that
> > +    along with another variable and an event field to generate a
> > +    wakeup_latency synthetic event:
> > +
> > +    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:\
> > +            onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
> > +	            $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
> > +	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> Just a check for understanding:
> 
> The onmatch() relation between events is driven by the use of the
> histogram variables 'ts0' and 'saved_pid', here.
> 
> If that's the case, this then precludes the matching only on fields
> statically defined in matching event's tracepoint?
> 
> Continuing on your latency examples, if I wanted to look at hrtimer
> latencies:
> 
>    # echo 'hrtimer_latency u64 lat' >> /sys/kernel/debug/tracing/synthetic_events
> 
>    # echo 'hist:keys=hrtimer.hex:onmatch(timer.hrtimer_start).hrtimer_latency(now-expires)' > \
>          /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/trigger
> 
>     (where 'now' and 'expires' are defined fields of the hrtimer_start
>      and hrtimer_expire_entry tracepoints, respectively)
> 
> This would _not_ work, because without the usage of a 'dummy' variable,
> there is no "capturing of context" in the hrtimer_start event.
> 
> I would have to, instead, do:
> 
>    # echo 'hrtimer_latency u64 lat' >> /sys/kernel/debug/tracing/synthetic_events
>    #
>    # echo 'hist:keys=hrtimer.hex:ts0=expires' > \
>          /sys/kernel/debug/tracing/events/timer/hrtimer_start/trigger
> 
>    # echo 'hist:keys=hrtimer.hex:onmatch(timer.hrtimer_start).hrtimer_latency(now-$ts0)' > \
>          /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/trigger
> 
> That is, create a dummy $ts0 to establish the relation.
> 
> Is my understanding correct?  If so, that's not very intuitive (to me).
> 

Yes, that's correct, that's how it works, but there's no reason we
couldn't add a higher-level capability that would automatically
translate hrtimer_latency(now-expires) into the low-level syntax.

What's implemented so far is necessarily pretty low-level, but I'm
pretty sure there will be some follow-ons providing higher-level
constructs like this, once the basic mechanism settles..

Thanks,

Tom

> Thanks,
>    Julia
