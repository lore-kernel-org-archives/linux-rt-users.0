From: Steven Rostedt <rostedt@goodmis.org>
Subject: Use the RT Latency Trace? - LET ME KNOW!
Date: Thu, 24 Jan 2008 15:36:44 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43560 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236AbYAXUhE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 15:37:04 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi all,

I'm about to gut the RT latency tracer with the version I'm pushing
upstream. This will be some of the changes:

Move from /proc to /debugfs

instead of all the files in proc (for which I don't even know what half of
them do) will be condensed into a few files in /debugfs/tracing

  available_tracers
   This file holds the available traces that you can use. Note, unlike
   -rt, you can choose between tracing preemptoff, irqsoff or preempt
   and irqs off latency at runtime. Here's the available tracers:

	events - traces kernel events (like EVENT_TRACE)

	wakeup - trace wakeup timings

	preemptirqsoff - trace preempt and irqs off latencies

	preemptoff - trace only preempt off latencies

	irqsoff - trace irqs off latencies

	function - trace functions (mcount)

	sched_switch - a context switch tracer (watch processes get
		scheduled in and out)

   Only one trace may be enabled at a time. Most of these traces also have
   a function equivalent, which will be activate if function trace is
   compiled in and sysctl kernel.mcount_enabled=1.

  current_tracer
   This holds the current active trace (from above). To change or activate
   a trace, simple echo in one of the above traces into this file.

    e.g.  echo irqsoff > /debugfs/tracing/current_tracer

  iter_ctrl
   This file controls the output of traces. So far there's only two
   different commands:

	verbose (noverbose) - change to latency_tracer verbose output.

	symonly (nosymonly) - only print kallsyms addr, and leave out the
				hex IP addr.

  latency_trace
   This is where one can read the latency trace from.
	(the old /proc/latency_trace)

  trace
   This is another format for output. A little easier to read but not as
   much information.

  trace_ctrl
   echo 1 > starts the tracer, echo 0 > stops (for all traces)

  tracing_max_latency
   This is just like the old preempt_max_latency for those that use it
   (preempt and irqs off as well as wakeup)

  tracing_thresh
   This is just like the old preempt_thresh.

Now the users has full access to start and stop the trace from these
files.

Note: I've been pushing a lot of this mainline. Some of this will not be
pushed mainline. Specifically, the event trace. Since the event trace does
a lot that LTTng does. I will probably wait till the markers of LTTng go
in. Or perhaps I'll simply push event trace, but that's still TBA.

I'll also hack up the prctl(0,0) - trace off - and prctl(0,1) trace on for
-rt only. This will not be something that will be pushed upstream.

If there's people on this list that use tools for latency tracing, let me
know and I can help you in the conversion. Also note some other
differences.

 - There will be some slightly different output formats. One is that the
trace_special which seems to always pass in an eip will now convert that
eip into a comm (kallsyms).

- The hrtimer_trace will use a hex value for the timer pointer instead of
a decimal.

- context switching is done a bit different:

e.g.
  bash-3138  1d..3 342us+: 3138:120:S --> 3131:120

This is a sched switch from bash 3138 of prio 120 in sleep state to task
sshd 3131 (I know this because of the next line down that I didn't show
;-) of prio 120.

But here's just a heads up on the new tracer. If there's issues, I'll try
to work them out.

Expect this new tracing format to be in either 2.6.24-rc8-rt2 or
2.6.24-rt2. (if 2.6.24 comes out, I may just port to it without adding the
tracer).

-- Steve
