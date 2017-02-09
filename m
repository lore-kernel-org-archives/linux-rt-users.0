From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Wed, 08 Feb 2017 19:14:22 -0600
Message-ID: <1486602862.2871.62.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56557 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdBIBOa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 20:14:30 -0500
In-Reply-To: <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Masami,

On Thu, 2017-02-09 at 08:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed,  8 Feb 2017 11:24:56 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > This patchset adds support for 'inter-event' quantities to the trace
> > event subsystem.  The most important example of inter-event quantities
> > are latencies, or the time differences between two events.
> 
> Great! This is what I dream! :)
> I'd like to use it. 
> 

Glad to hear it, thanks!

> >   - 'actions' generating synthetic events, among other things
> > 
> >     Variables and synthetic events provide the data and data structure
> >     for new events, but something still needs to actually generate an
> >     event using that data.  'Actions' are expanded to provide that
> >     capability.  Though it hasn't been explicitly called as much
> >     before, the default 'action' currently for a hist trigger is to
> >     update the matching histogram entry's sum values.  This patchset
> >     essentially expands that to provide a new 'onmatch.trace(event)'
> >     action that can be used to have one event generate another.  The
> >     mechanism is extensible to other actions, and in fact the patchset
> >     also includes another, 'onmax(var).save(field,...)' that can be
> >     used to save context whenever a value exceeds the previous maximum
> >     (something also needed by latency_hist).
> 
> BTW, I would like to comment on this grammer.
> 
> > 
> > I'm submitting the patchset (based on tracing/for-next) as an RFC not
> > only to get comments, but because there are still some problems I
> > haven't fixed yet...
> > 
> > Here are some examples that should make things less abstract.
> > 
> >   ====
> >   Example - wakeup latency
> >   ====
> > 
> >   This basically implements the -RT latency_hist 'wakeup_latency'
> >   histogram using the synthetic events, variables, and actions
> >   described.  The output below is from a run of cyclictest using the
> >   following command:
> > 
> >     # rt-tests/cyclictest -p 80 -n -s -t 2
> > 
> >   What we're measuring the latency of is the time between when a
> >   thread (of cyclictest) is awakened and when it's scheduled in.  To
> >   do that we add triggers to sched_wakeup and sched_switch with the
> >   appropriate variables, and on a matching sched_switch event,
> >   generate a synthetic 'wakeup_latency' event.  Since it's just
> >   another trace event like any other, we can also define a histogram
> >   on that event, the output of which is what we see displayed when
> >   reading the wakeup_latency 'hist' file.
> > 
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
> Hmm, this looks a bit hard to understand, I guess that onmatch() means
> "if there is an event which has ts0 variable and the event's key matches
> this key, take some action".

Yes, that's pretty much it. It's essentially shorthand for this kind of
common idiom, where timestamp[] is an associative array, which in our
case is the tracing_map of the histogram: 

event sched_wakeup()
{
	ts0[wakeup_pid] = now()
}

event sched_switch()
{
	if (ts0[next_pid])
		latency = now() - ts0[next_pid] /* next_pid == wakeup_pid */
}

Only if ts0 has already been set does the onmatch() get invoked - if ts0
hasn't been set, there's no match and the trace(wakeup_latency) doesn't
happen.

> I think there are 2 indefinate point that
> - Where the 'ts0' came from? what the variable will have 'global' scope?

ts0 is basically a per-table-entry variable - there's one for each entry
in the table, and it can only be accessed by events with matching keys.
The table owns the variable name, so you can't have two different tables
with the ts0 variable.

So if we create a histogram on event1 and associate a variable ts0 with
it, any event hit on that histogram assigns to the corresponding entry's
ts0 instance. 

If we create a histogram on event2 which references ts0, it knows that
ts0 belongs to event1's histogram, and when there's a hit on event2, the
same key is used to look up the entry corresponding to that key on
event1, and if there's a matching entry, it grabs the value of ts0 from
that and subtracts it from the current event's value to produce the
latency or whatever it is.

So, that's a long-winded way of saying that the name ts0 is global
across all tables (histograms) but an instance of ts0 is local to each
entry in the table that owns the name.

> - What matches to what? onmatch() doesn't tell it.
> 

It's implied by the references to other events - in order for ts0 to be
resolved, it needs to find the match on event1.  Also, the synthetic
event has references to variables on other events - in order to generate
the synthetic event, those variables also need to be resolved to
matching events - note that variables can also come from the current
event as well.

Hope that clears things up a bit (although the details under the covers
might seem confusing).

Tom  


> Thank you,
> 
> 


