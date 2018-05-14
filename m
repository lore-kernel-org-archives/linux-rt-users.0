From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 00/14] tracing: Add triggers to trace_marker writes
Date: Mon, 14 May 2018 16:58:45 -0400
Message-ID: <20180514205845.017925650@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A few people have asked for this in the past, and I finally got around
to implementing it. What this does is to allow writes into trace_marker
to initiate a trigger.

The trace_marker event is described in:

 tracefs/events/ftrace/print

Thus the trigger file is added there:

 tracefs/events/ftrace/print/trigger

As there's already a "hist" file there, everything appears to work
just like any other trigger to an event. See the last patch for
documentation on how to use the triggers to a trace_marker write.

By the way, the patch:

  tracing: Prevent further users of zero size static arrays in trace events

May prevent your kernel from building if you include Xen. You will need
to add this patch to make it work.

 http://lkml.kernel.org/r/20180509144605.5a220327@gandalf.local.home

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: a3762cfaa4e4b141aa53d3053f38a9cdd47ea49b


Steven Rostedt (VMware) (14):
      tracing: Do not reference event data in post call triggers
      tracing: Add __find_event_file() to find event files without restrictions
      tracing: Have event_trace_init() called by trace_init_tracefs()
      tracing: Add brackets in ftrace event dynamic arrays
      tracing: Do not show filter file for ftrace internal events
      tracing: Add trigger file for trace_markers tracefs/ftrace/print
      tracing: Have zero size length in filter logic be full string
      tracing: Prevent further users of zero size static arrays in trace events
      tracing: Allow histogram triggers to access ftrace internal events
      tracing: Document trace_marker triggers
      ftrace/selftest: Have the reset_trigger code be a bit more careful
      ftrace/selftest: Fix reset_trigger() to handle triggers with filters
      tracing/selftest: Add selftests to test trace_marker histogram triggers
      tracing/selftest: Add test to test hist trigger between kernel event and trace_marker

----
Changes since v1:

 - Fixed comment about length (Masami Hiramatsu)
 - Added note about ->reg() requiremet (Namhyung Kim)
 - Added fix for r->len (Yann Ylavic)
 - Added fixes for reset_trigger in ftrace self test
 - Added self tests to test the trace_marker triggers

 Documentation/trace/events.rst                     |   6 +-
 Documentation/trace/ftrace.rst                     |   5 +
 Documentation/trace/histogram.txt                  | 546 ++++++++++++++++++++-
 include/linux/trace_events.h                       |   3 +-
 include/trace/trace_events.h                       |   1 +
 kernel/trace/trace.c                               |  19 +
 kernel/trace/trace.h                               |   9 +-
 kernel/trace/trace_entries.h                       |   6 +-
 kernel/trace/trace_events.c                        |  36 +-
 kernel/trace/trace_events_filter.c                 |  23 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/trace_export.c                        |   9 +-
 tools/testing/selftests/ftrace/test.d/functions    |  23 +-
 .../trigger/trigger-trace-marker-synthetic.tc      |  88 ++++
 .../ftrace/test.d/trigger/trigger-trace-marker.tc  |  49 ++
 16 files changed, 790 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc
