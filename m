From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 15:08:25 -0400
Message-ID: <20150423190825.714359844@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53431 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030364AbbDWTR2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 15:17:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This is the port of the hardware latency detector from the -rt patch
to mainline. Instead of keeping it as a device that had its own debugfs
filesystem infrastructure, it made more sense to make it into a tracer
like irqsoff and wakeup latency tracers currently are.

With this patch set, a new tracer is enabled if CONFIG_HWLAT_TRACER is
enabled. Inside the available_tracers file will be hwlat_detector.

 # cd /sys/kernel/debug/tracing
 # echo hwlat_detector > current_tracer

will enable the hwlat_detector that will create per cpu kernel threads
(which cpus is defined by the tracing/hwlat_detector/cpumask, default
 is just CPU 0).

Like the other tracers (function, function_graph, preemptirqsoff,
and mmiotracer), the hwlat_detector can add a significant performance
penalty when enabled. As each of the threads created will go into a spin
checking the trace_local_clock (sched_clock) for any gaps of time
and will report them if they are greater than the threshold defined
by tracing/tracing_thresh (usecs, default 10). The spin is performed with
interrupts disabled and runs for "width" usecs in "window" usecs time. The
width and window are defined by the values in the corresponding file
names under tracing/hwlat_detector/

To keep authorship, the first patch is the code from the -rt patch
directly, removing the setup of the device and its own ring buffer.
I made sure that it still compiles though (even though it isn't
included in the Makefile, I tested it by adding it in the Makefile
to make sure there was enough there to compile).

The next patch is what I did to it to make it into a tracer.

The third patch is the documentation pulled from the rt patch with
minor tweaks to still maintain authorship from Jon.

The last patch adds a new feature, as the original code only ran
one thread, the last patch adds the cpumask and allows the user
to run threads on any CPU they choose.

 Here's an example:

  # cd /sys/kernel/debug/tracing
  # echo hwat_detector > current_tracer
  # sleep 1000
  # cat trace
# tracer: hwlat_detector
#
# entries-in-buffer/entries-written: 4255/4255   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-1093  [000] d...   190.028562: cnt:1	ts:1429650359.0152020816	inner:0	outer:12
           <...>-1093  [000] dn..   192.029474: cnt:2	ts:1429650361.0227041390	inner:10	outer:11
           <...>-1093  [000] dn..   251.057300: cnt:3	ts:1429650420.0228626083	inner:11	outer:9
           <...>-1093  [000] d...   256.059542: cnt:4	ts:1429650425.0227696532	inner:0	outer:13
           <...>-1093  [000] dn..   265.063606: cnt:5	ts:1429650433.0896822479	inner:11	outer:18
           <...>-1093  [000] dn..   311.084310: cnt:6	ts:1429650480.0229495647	inner:13	outer:12
           <...>-1093  [000] dn..   324.090171: cnt:7	ts:1429650493.0105674296	inner:13	outer:9
           <...>-1093  [000] dn..   371.111359: cnt:8	ts:1429650540.0228324942	inner:0	outer:15
           <...>-1093  [000] d...   385.117823: cnt:9	ts:1429650554.0105350802	inner:9	outer:11


The inner, outer times shows where the latency was detected:

  while (run) {
    start_ts = trace_local_clock();
    end_ts = trace_local_clock();
    if (!first && start_ts - last_ts > thresh)
	record_outer();
    if (end_ts - start_ts > thresh)
	record_inner();
    last_ts = end_ts;
    first = 0;
  }

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/hwlat

Head SHA1: 876428062c7fbb94a06fefc8df86560f9a80c8dd


Jon Masters (2):
      tracing: Initial hwlat_detector code from the -rt patch
      tracing: Add documentation for hwlat_detector tracer

Steven Rostedt (Red Hat) (2):
      tracing: Add hwlat_detector tracer
      hwlat: Add per cpu mask for hwlat_detector

----
 Documentation/trace/hwlat_detector.txt |  66 +++
 kernel/trace/Kconfig                   |  40 ++
 kernel/trace/Makefile                  |   1 +
 kernel/trace/trace.c                   |  11 +-
 kernel/trace/trace.h                   |   5 +
 kernel/trace/trace_entries.h           |  23 +
 kernel/trace/trace_hwlatdetect.c       | 763 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.c            |  84 ++++
 8 files changed, 988 insertions(+), 5 deletions(-)
