From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Fri, 10 Feb 2017 13:16:17 +0900
Message-ID: <20170210041617.GE599@sejong>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Wed, Feb 08, 2017 at 11:24:56AM -0600, Tom Zanussi wrote:
> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.
> 
> One of the main motivations for adding this capability is to provide a
> general-purpose base that existing existing tools such as the -RT
> latency_hist patchset can be built upon, while at the same time
> providing a simple way for users to track latencies (or any
> inter-event quantity) generically between any two events.
> 
> Previous -RT latency_hist patchsets that take advantage of the trace
> event subsystem have been submitted, but they essentially hard-code
> special-case tracepoints and application logic in ways that can't be
> reused.  It seemed to me that rather than providing a one-off patchset
> devoted specifically to generating the specific histograms in the
> latency_hist patchset, it should be possible to build the same
> functionality on top of a generic layer allowing users to do similar
> things for other non-latency_hist applications.
> 
> In addition to preliminary patches that add some basic missing
> functionality such as a common ringbuffer-derived timestamp and
> dynamically-creatable tracepoints, the overall patchset is divided up
> into a few different areas that combine to produce the overall goal
> (The Documentation patch explains all the details):

Looks very nice!

> 
>   - variables and simple expressions required to calculate a latency
> 
>     In order to calculate a latency or any inter-event value,
>     something from one event needs to be saved and later retrieved,
>     and some operation such as subtraction or addition is performed on
>     it.  This means some minimal form of variables and expressions,
>     which the first set of patches implements.  Saving and retrieving
>     events to use in a latency calculation is normally done using a
>     hash table, and that's exactly what we have with trace event hist
>     triggers, so that's where variables are instantiated, set, and
>     retrieved.  Basically, variables are set on one entry and
>     retrieved and used by a 'matching' event.
> 
>   - 'synthetic' events, combining variables from other events
> 
>     The trace event interface is based on pseudo-files associated with
>     individual events, so it wouldn't really make sense to have
>     quantities derived from multiple events attached to any one of
>     those events.  For that reason, the patchset implements a means of
>     combining variables from other events into a separate 'synthetic'
>     event, which can be treated as if it were just like any other
>     trace event in the system.
> 
>   - 'actions' generating synthetic events, among other things
> 
>     Variables and synthetic events provide the data and data structure
>     for new events, but something still needs to actually generate an
>     event using that data.  'Actions' are expanded to provide that
>     capability.  Though it hasn't been explicitly called as much
>     before, the default 'action' currently for a hist trigger is to
>     update the matching histogram entry's sum values.  This patchset
>     essentially expands that to provide a new 'onmatch.trace(event)'
>     action that can be used to have one event generate another.  The
>     mechanism is extensible to other actions, and in fact the patchset
>     also includes another, 'onmax(var).save(field,...)' that can be
>     used to save context whenever a value exceeds the previous maximum
>     (something also needed by latency_hist).
> 
> I'm submitting the patchset (based on tracing/for-next) as an RFC not
> only to get comments, but because there are still some problems I
> haven't fixed yet...
> 
> Here are some examples that should make things less abstract.
> 
>   ====
>   Example - wakeup latency
>   ====
> 
>   This basically implements the -RT latency_hist 'wakeup_latency'
>   histogram using the synthetic events, variables, and actions
>   described.  The output below is from a run of cyclictest using the
>   following command:
> 
>     # rt-tests/cyclictest -p 80 -n -s -t 2
> 
>   What we're measuring the latency of is the time between when a
>   thread (of cyclictest) is awakened and when it's scheduled in.  To
>   do that we add triggers to sched_wakeup and sched_switch with the
>   appropriate variables, and on a matching sched_switch event,
>   generate a synthetic 'wakeup_latency' event.  Since it's just
>   another trace event like any other, we can also define a histogram
>   on that event, the output of which is what we see displayed when
>   reading the wakeup_latency 'hist' file.
> 
>   First, we create a synthetic event called wakeup_latency, that
>   references 3 variables from other events:
> 
>     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
>                            pid=sched_switch:woken_pid \
>                            prio=sched_switch:woken_prio' >> \
>             /sys/kernel/debug/tracing/synthetic_events
> 
>   Next we add a trigger to sched_wakeup, which saves the value of the
>   'common_timestamp' when that event is hit in a variable, ts0.  Note
>   that this happens only when 'comm==cyclictest'.
> 
>   Also, 'common_timestamp' is a new field defined on every event (if
>   needed - if there are no users of timestamps in a trace, timestamps
>   won't be saved and there's no additional overhead from that).
> 
>     #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
>              comm=="cyclictest"' >> \
>              /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> 
>   Next, we add a trigger to sched_switch.  When the pid being switched
>   to matches the pid woken up by a previous sched_wakeup event, this
>   event grabs the ts0 saved on that event, takes the difference
>   between it and the current sched_switch's common_timestamp, and
>   assigns it to a new 'wakeup_lat' variable.  It also saves a couple
>   other variables and then invokes the onmatch().trace() action which
>   generates a new wakeup_latency event using those variables.
> 
>     # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
>        wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
>             if next_comm=="cyclictest"' >> \
>             /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

As Masami said, I think the syntax is a bit hard to understand.  Also
it'd be nice to access an event field directly (i.e. not by adding a
field in a hist).  Maybe we can use a prefix like '$' to identify hist
fields..

How about below?

  # echo 'wakeup_latency \
  		lat=sched_switch.$wakeup_lat  \
		pid=sched_switch.next_pid     \
		prio=sched_switch.next_prio' >> \
	/sys/kernel/debug/tracing/synthetic_events

  # echo 'hist: \
  		keys=pid: \
		ts0=common_timestamp.usec \
		if comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  # echo 'hist: \
		keys=next_pid: \
		wakeup_lat=common_timestamp.usec-$ts0: \
		onmatch(sched_wakeup).trace(wakeup_latency) \
		if next_comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_switch/trigger

By passing an event name to 'onmatch', we can know where to find $ts0
easily IMHO.

Thanks,
Namhyung
