From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 3/4] tracing: Add documentation for hwlat_detector tracer
Date: Thu, 23 Apr 2015 15:08:28 -0400
Message-ID: <20150423191725.158120617@goodmis.org>
References: <20150423190825.714359844@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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
Received: from mail.kernel.org ([198.145.29.136]:53455 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030523AbbDWTR3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 15:17:29 -0400
Content-Disposition: inline; filename=0003-tracing-Add-documentation-for-hwlat_detector-tracer.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Jon Masters <jcm@redhat.com>

Added the documentation on how to use th hwlat_detector.

Signed-off-by: Jon Masters <jcm@redhat.com>
[ Updated to show move from module to tracer ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/hwlat_detector.txt | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/trace/hwlat_detector.txt

diff --git a/Documentation/trace/hwlat_detector.txt b/Documentation/trace/hwlat_detector.txt
new file mode 100644
index 000000000000..db98dd1fa4ed
--- /dev/null
+++ b/Documentation/trace/hwlat_detector.txt
@@ -0,0 +1,61 @@
+Introduction:
+-------------
+
+The tracer hwlat_detector is a special purpose tracer that is used to
+detect large system latencies induced by the behavior of certain underlying
+hardware or firmware, independent of Linux itself. The code was developed
+originally to detect SMIs (System Management Interrupts) on x86 systems,
+however there is nothing x86 specific about this patchset. It was
+originally written for use by the "RT" patch since the Real Time
+kernel is highly latency sensitive.
+
+SMIs are usually not serviced by the Linux kernel, which typically does not
+even know that they are occuring. SMIs are instead are set up by BIOS code
+and are serviced by BIOS code, usually for "critical" events such as
+management of thermal sensors and fans. Sometimes though, SMIs are used for
+other tasks and those tasks can spend an inordinate amount of time in the
+handler (sometimes measured in milliseconds). Obviously this is a problem if
+you are trying to keep event service latencies down in the microsecond range.
+
+The hardware latency detector works by hogging all of the cpus for configurable
+amounts of time (with interrupts disabled), polling the CPU Time Stamp Counter
+for some period, then looking for gaps in the TSC data. Any gap indicates a
+time when the polling was interrupted and since the interrupts are disabled,
+the only thing that could do that would be an SMI.
+
+Note that the SMI detector should *NEVER* be used in a production environment.
+It is intended to be run manually to determine if the hardware platform has a
+problem with long system firmware service routines.
+
+Usage:
+------
+
+Write the ASCII text "hwlat_detector" into the current_tracer file of the
+tracing system (mounted at /sys/kernel/debug/tracing). It is possible to
+redefine the threshold in microseconds (us) above which latency spikes will
+be taken into account.
+
+Example:
+
+	# echo hwlat_detector > /sys/kernel/debug/tracing/current_tracer
+	# echo 100 > /sys/kernel/debug/tracing/tracing_thresh
+
+The /sys/kernel/debug/tracing/hwlat_detector interface contains the following files:
+
+count			- number of latency spikes observed since last reset
+width			- time period to sample with CPUs held (usecs)
+			  must be less than the total window size (enforced)
+window			- total period of sampling, width being inside (usecs)
+
+By default we will set width to 500,000 and window to 1,000,000, meaning that
+we will sample every 1,000,000 usecs (1s) for 500,000 usecs (0.5s). If we
+observe any latencies that exceed the threshold (initially 100 usecs),
+then we write to a global sample ring buffer of 8K samples, which is
+consumed by reading from the "sample" (pipe) debugfs file interface.
+
+Also the following tracing directory files are used by the hwlat_detector:
+
+in /sys/kernel/debug/tracing:
+
+tracing_threshold	- minimum latency value to be considered (usecs)
+tracing_max_latency	- maximum hardware latency actually observed (usecs)
-- 
2.1.4


