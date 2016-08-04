From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 0/3] tracing: Add Hardware Latency detector tracer
Date: Thu, 04 Aug 2016 10:57:08 -0400
Message-ID: <20160804145708.158968389@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34388 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758742AbcHDPAc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2016 11:00:32 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This adds the PREEMPT_RT hwlat detector as a Linux tracer in mainline.
In the PREEMPT_RT patch set, it is a separate entity that is controlled
by the debugfs file system. I found that it is better suited as a
latency tracer in the tracing directory, as it follows pretty much the
same paradigm as the other latency tracers that already exist. All
I had to add was a hwlat_detector directory that contained a window
and width for the period and duration respectively of the test. But
the samples would just write to the tracing ring buffer and the max
latency would be stored in tracing_max_latency, and the threshold can
be set by the existing tracing_threshold. The last patch also adds a
new feature that would have the kthread migrate after each period to
another CPU specified by tracing_cpumask.


Here's the documention that is added to hwlat_detector.txt in the
Documentation directory:

Introduction:
-------------

The tracer hwlat_detector is a special purpose tracer that is used to
detect large system latencies induced by the behavior of certain underlying
hardware or firmware, independent of Linux itself. The code was developed
originally to detect SMIs (System Management Interrupts) on x86 systems,
however there is nothing x86 specific about this patchset. It was
originally written for use by the "RT" patch since the Real Time
kernel is highly latency sensitive.

SMIs are not serviced by the Linux kernel, which means that it does not
even know that they are occuring. SMIs are instead set up by BIOS code
and are serviced by BIOS code, usually for "critical" events such as
management of thermal sensors and fans. Sometimes though, SMIs are used for
other tasks and those tasks can spend an inordinate amount of time in the
handler (sometimes measured in milliseconds). Obviously this is a problem if
you are trying to keep event service latencies down in the microsecond range.

The hardware latency detector works by hogging one of the cpus for configurable
amounts of time (with interrupts disabled), polling the CPU Time Stamp Counter
for some period, then looking for gaps in the TSC data. Any gap indicates a
time when the polling was interrupted and since the interrupts are disabled,
the only thing that could do that would be an SMI or other hardware hiccup
(or an NMI, but those can be tracked).

Note that the hwlat detector should *NEVER* be used in a production environment.
It is intended to be run manually to determine if the hardware platform has a
problem with long system firmware service routines.

Usage:
------

Write the ASCII text "hwlat" into the current_tracer file of the tracing system
(mounted at /sys/kernel/tracing or /sys/kernel/tracing). It is possible to
redefine the threshold in microseconds (us) above which latency spikes will
be taken into account.

Example:

	# echo hwlat > /sys/kernel/tracing/current_tracer
	# echo 100 > /sys/kernel/tracing/tracing_thresh

The /sys/kernel/tracing/hwlat_detector interface contains the following files:

width			- time period to sample with CPUs held (usecs)
			  must be less than the total window size (enforced)
window			- total period of sampling, width being inside (usecs)

By default the width is set to 500,000 and window to 1,000,000, meaning that
for every 1,000,000 usecs (1s) the hwlat detector will spin for 500,000 usecs
(0.5s). If tracing_thresh contains zero when hwlat tracer is enabled, it will
change to a default of 10 usecs. If any latencies that exceed the threshold is
observed then the data will be written to the tracing ring buffer.

The minimum sleep time between periods is 1 millisecond. Even if width
is less than 1 millisecond apart from window, to allow the system to not
be totally starved.

If tracing_thresh was zero when hwlat detector was started, it will be set
back to zero if another tracer is loaded. Note, the last value in
tracing_thresh that hwlat detector had will be saved and this value will
be restored in tracing_thresh if it is still zero when hwlat detector is
started again.

The following tracing directory files are used by the hwlat_detector:

in /sys/kernel/tracing:

 tracing_threshold	- minimum latency value to be considered (usecs)
 tracing_max_latency	- maximum hardware latency actually observed (usecs)
 hwlat_detector/width	- specified amount of time to spin within window (usecs)
 hwlat_detector/window	- amount of time between (width) runs (usecs)

-- Steve


Jon Masters (1):
      tracing: Add documentation for hwlat_detector tracer

Steven Rostedt (Red Hat) (2):
      tracing: Added hardware latency tracer
      tracing: Have hwlat trace migrate across tracing_cpumask CPUs

----
 Documentation/trace/hwlat_detector.txt |  79 +++++
 kernel/trace/Kconfig                   |  35 ++
 kernel/trace/Makefile                  |   1 +
 kernel/trace/trace.c                   |   2 +-
 kernel/trace/trace.h                   |   3 +
 kernel/trace/trace_entries.h           |  23 ++
 kernel/trace/trace_hwlat.c             | 582 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.c            |  52 +++
 8 files changed, 776 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/hwlat_detector.txt
 create mode 100644 kernel/trace/trace_hwlat.c
