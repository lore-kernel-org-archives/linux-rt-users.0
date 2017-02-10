From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Fri, 10 Feb 2017 12:43:53 -0600
Message-ID: <1486752233.2871.163.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <20170210041617.GE599@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210041617.GE599@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-02-10 at 13:16 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Feb 08, 2017 at 11:24:56AM -0600, Tom Zanussi wrote:
> > This patchset adds support for 'inter-event' quantities to the trace
> > event subsystem.  The most important example of inter-event quantities
> > are latencies, or the time differences between two events.
> > 
> > One of the main motivations for adding this capability is to provide a
> > general-purpose base that existing existing tools such as the -RT
> > latency_hist patchset can be built upon, while at the same time
> > providing a simple way for users to track latencies (or any
> > inter-event quantity) generically between any two events.
> > 
> > Previous -RT latency_hist patchsets that take advantage of the trace
> > event subsystem have been submitted, but they essentially hard-code
> > special-case tracepoints and application logic in ways that can't be
> > reused.  It seemed to me that rather than providing a one-off patchset
> > devoted specifically to generating the specific histograms in the
> > latency_hist patchset, it should be possible to build the same
> > functionality on top of a generic layer allowing users to do similar
> > things for other non-latency_hist applications.
> > 
> > In addition to preliminary patches that add some basic missing
> > functionality such as a common ringbuffer-derived timestamp and
> > dynamically-creatable tracepoints, the overall patchset is divided up
> > into a few different areas that combine to produce the overall goal
> > (The Documentation patch explains all the details):
> 
> Looks very nice!
> 

Thanks!

...
 
> >   First, we create a synthetic event called wakeup_latency, that
> >   references 3 variables from other events:
> > 
> >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> >                            pid=sched_switch:woken_pid \
> >                            prio=sched_switch:woken_prio' >> \
> >             /sys/kernel/debug/tracing/synthetic_events
> > 
> >   Next we add a trigger to sched_wakeup, which saves the value of the
> >   'common_timestamp' when that event is hit in a variable, ts0.  Note
> >   that this happens only when 'comm==cyclictest'.
> > 
> >   Also, 'common_timestamp' is a new field defined on every event (if
> >   needed - if there are no users of timestamps in a trace, timestamps
> >   won't be saved and there's no additional overhead from that).
> > 
> >     #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
> >              comm=="cyclictest"' >> \
> >              /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > 
> >   Next, we add a trigger to sched_switch.  When the pid being switched
> >   to matches the pid woken up by a previous sched_wakeup event, this
> >   event grabs the ts0 saved on that event, takes the difference
> >   between it and the current sched_switch's common_timestamp, and
> >   assigns it to a new 'wakeup_lat' variable.  It also saves a couple
> >   other variables and then invokes the onmatch().trace() action which
> >   generates a new wakeup_latency event using those variables.
> > 
> >     # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
> >        wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
> >             if next_comm=="cyclictest"' >> \
> >             /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> As Masami said, I think the syntax is a bit hard to understand.  Also
> it'd be nice to access an event field directly (i.e. not by adding a
> field in a hist).  Maybe we can use a prefix like '$' to identify hist
> fields..

Yes, that's a good point, and I like the $ syntax - it makes the
variables obvious to users.

> 
> How about below?
> 
>   # echo 'wakeup_latency \
>   		lat=sched_switch.$wakeup_lat  \
> 		pid=sched_switch.next_pid     \
> 		prio=sched_switch.next_prio' >> \
> 	/sys/kernel/debug/tracing/synthetic_events
> 
>   # echo 'hist: \
>   		keys=pid: \
> 		ts0=common_timestamp.usec \
> 		if comm=="cyclictest"' >> \
> 	/sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> 
>   # echo 'hist: \
> 		keys=next_pid: \
> 		wakeup_lat=common_timestamp.usec-$ts0: \
> 		onmatch(sched_wakeup).trace(wakeup_latency) \
> 		if next_comm=="cyclictest"' >> \
> 	/sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> By passing an event name to 'onmatch', we can know where to find $ts0
> easily IMHO.
> 

I think that also makes a lot of sense - keeping things as explicit as
possible makes it clear what's going on.  I'll make these changes,
modulo the comments along similar lines from Masami.

Thanks for the excellent suggestions!

Tom

> Thanks,
> Namhyung
