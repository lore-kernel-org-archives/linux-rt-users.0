From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Mon, 13 Feb 2017 10:04:16 +0900
Message-ID: <20170213010416.GE14705@sejong>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
 <20170210041617.GE599@sejong>
 <20170210183425.3444f5a28779bec9034230d4@kernel.org>
 <1486753110.3005.5.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Masami Hiramatsu <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:41019 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBMBEY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Feb 2017 20:04:24 -0500
In-Reply-To: <1486753110.3005.5.camel@tzanussi-mobl.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 10, 2017 at 12:58:30PM -0600, Tom Zanussi wrote:
> Hi Masami,
> 
> On Fri, 2017-02-10 at 18:34 +0900, Masami Hiramatsu wrote:
> > On Fri, 10 Feb 2017 13:16:17 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > >   ====
> > > >   Example - wakeup latency
> > > >   ====
> > > > 
> > > >   This basically implements the -RT latency_hist 'wakeup_latency'
> > > >   histogram using the synthetic events, variables, and actions
> > > >   described.  The output below is from a run of cyclictest using the
> > > >   following command:
> > > > 
> > > >     # rt-tests/cyclictest -p 80 -n -s -t 2
> > > > 
> > > >   What we're measuring the latency of is the time between when a
> > > >   thread (of cyclictest) is awakened and when it's scheduled in.  To
> > > >   do that we add triggers to sched_wakeup and sched_switch with the
> > > >   appropriate variables, and on a matching sched_switch event,
> > > >   generate a synthetic 'wakeup_latency' event.  Since it's just
> > > >   another trace event like any other, we can also define a histogram
> > > >   on that event, the output of which is what we see displayed when
> > > >   reading the wakeup_latency 'hist' file.
> > > > 
> > > >   First, we create a synthetic event called wakeup_latency, that
> > > >   references 3 variables from other events:
> > > > 
> > > >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> > > >                            pid=sched_switch:woken_pid \
> > > >                            prio=sched_switch:woken_prio' >> \
> > > >             /sys/kernel/debug/tracing/synthetic_events
> > > > 
> > > >   Next we add a trigger to sched_wakeup, which saves the value of the
> > > >   'common_timestamp' when that event is hit in a variable, ts0.  Note
> > > >   that this happens only when 'comm==cyclictest'.
> > > > 
> > > >   Also, 'common_timestamp' is a new field defined on every event (if
> > > >   needed - if there are no users of timestamps in a trace, timestamps
> > > >   won't be saved and there's no additional overhead from that).
> > > > 
> > > >     #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
> > > >              comm=="cyclictest"' >> \
> > > >              /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > > 
> > > >   Next, we add a trigger to sched_switch.  When the pid being switched
> > > >   to matches the pid woken up by a previous sched_wakeup event, this
> > > >   event grabs the ts0 saved on that event, takes the difference
> > > >   between it and the current sched_switch's common_timestamp, and
> > > >   assigns it to a new 'wakeup_lat' variable.  It also saves a couple
> > > >   other variables and then invokes the onmatch().trace() action which
> > > >   generates a new wakeup_latency event using those variables.
> > > > 
> > > >     # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
> > > >        wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
> > > >             if next_comm=="cyclictest"' >> \
> > > >             /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > > 
> > > As Masami said, I think the syntax is a bit hard to understand.  Also
> > > it'd be nice to access an event field directly (i.e. not by adding a
> > > field in a hist).  Maybe we can use a prefix like '$' to identify hist
> > > fields..
> > 
> > Ah that's a nice idea!
> > 
> > > 
> > > How about below?
> > > 
> > >   # echo 'wakeup_latency \
> > >   		lat=sched_switch.$wakeup_lat  \
> > > 		pid=sched_switch.next_pid     \
> > > 		prio=sched_switch.next_prio' >> \
> > > 	/sys/kernel/debug/tracing/synthetic_events
> > 
> > Should we define these parameter assignment at this.point?
> > 
> > I think this syntax binds wakeup_latency event to sched_switch too tight. I 
> > mean, if someone kicks this event from some other event, it may easily lose 
> > values.
> > So, at this point, we will define event name and what parameters it has,
> > until binding this event to onmatch().
> > 
> 
> Right, I agree this binding doesn't need to be done here, good idea to
> defer it as below...
> 
> > >   # echo 'hist: \
> > >   		keys=pid: \
> > > 		ts0=common_timestamp.usec \
> > > 		if comm=="cyclictest"' >> \
> > > 	/sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > 
> > >   # echo 'hist: \
> > > 		keys=next_pid: \
> > > 		wakeup_lat=common_timestamp.usec-$ts0: \
> > > 		onmatch(sched_wakeup).trace(wakeup_latency) \
> > 
> > This one seems much better for me, but I would like to ask you call event 
> > directly from onmatch, like as
> > 
> >  "onmatch(sched_wakeup).wakeup_latency(wakeup_lat,next_pid,next_prio)"
> > 
> > At this point, kernel will finalize the wakeup_latency event with wakeup_lat,
> > next_pid and next_prio.
> > 
> 
> Yes, I like this much better - things are no longer so implicit and
> therefore subject to confusion, and the syntax itself makes more sense,
> even if it is a bit more verbose on the trigger, which is fine.

I thought about it too, but it needs to add some kind of type checking
then.  What if another hist generates the event with totally different
info?

Thanks,
Namhyung
