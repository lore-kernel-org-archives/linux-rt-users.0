From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 2/3] tracing: Add documentation for hwlat_detector tracer
Date: Thu, 04 Aug 2016 10:57:10 -0400
Message-ID: <20160804145840.044642364@goodmis.org>
References: <20160804145708.158968389@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34362 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741AbcHDPAc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2016 11:00:32 -0400
Content-Disposition: inline; filename=0002-tracing-Add-documentation-for-hwlat_detector-tracer.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Jon Masters <jcm@redhat.com>

Added the documentation on how to use th hwlat_detector.

Signed-off-by: Jon Masters <jcm@redhat.com>
[ Various updates and modified to show hwlat as a tracer ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/hwlat_detector.txt | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/trace/hwlat_detector.txt

diff --git a/Documentation/trace/hwlat_detector.txt b/Documentation/trace/hwlat_detector.txt
new file mode 100644
index 000000000000..c02e8ef800cf
--- /dev/null
+++ b/Documentation/trace/hwlat_detector.txt
@@ -0,0 +1,73 @@
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
+SMIs are not serviced by the Linux kernel, which means that it does not
+even know that they are occuring. SMIs are instead set up by BIOS code
+and are serviced by BIOS code, usually for "critical" events such as
+management of thermal sensors and fans. Sometimes though, SMIs are used for
+other tasks and those tasks can spend an inordinate amount of time in the
+handler (sometimes measured in milliseconds). Obviously this is a problem if
+you are trying to keep event service latencies down in the microsecond range.
+
+The hardware latency detector works by hogging one of the cpus for configurable
+amounts of time (with interrupts disabled), polling the CPU Time Stamp Counter
+for some period, then looking for gaps in the TSC data. Any gap indicates a
+time when the polling was interrupted and since the interrupts are disabled,
+the only thing that could do that would be an SMI or other hardware hiccup
+(or an NMI, but those can be tracked).
+
+Note that the hwlat detector should *NEVER* be used in a production environment.
+It is intended to be run manually to determine if the hardware platform has a
+problem with long system firmware service routines.
+
+Usage:
+------
+
+Write the ASCII text "hwlat" into the current_tracer file of the tracing system
+(mounted at /sys/kernel/tracing or /sys/kernel/tracing). It is possible to
+redefine the threshold in microseconds (us) above which latency spikes will
+be taken into account.
+
+Example:
+
+	# echo hwlat > /sys/kernel/tracing/current_tracer
+	# echo 100 > /sys/kernel/tracing/tracing_thresh
+
+The /sys/kernel/tracing/hwlat_detector interface contains the following files:
+
+width			- time period to sample with CPUs held (usecs)
+			  must be less than the total window size (enforced)
+window			- total period of sampling, width being inside (usecs)
+
+By default the width is set to 500,000 and window to 1,000,000, meaning that
+for every 1,000,000 usecs (1s) the hwlat detector will spin for 500,000 usecs
+(0.5s). If tracing_thresh contains zero when hwlat tracer is enabled, it will
+change to a default of 10 usecs. If any latencies that exceed the threshold is
+observed then the data will be written to the tracing ring buffer.
+
+The minimum sleep time between periods is 1 millisecond. Even if width
+is less than 1 millisecond apart from window, to allow the system to not
+be totally starved.
+
+If tracing_thresh was zero when hwlat detector was started, it will be set
+back to zero if another tracer is loaded. Note, the last value in
+tracing_thresh that hwlat detector had will be saved and this value will
+be restored in tracing_thresh if it is still zero when hwlat detector is
+started again.
+
+The following tracing directory files are used by the hwlat_detector:
+
+in /sys/kernel/tracing:
+
+ tracing_threshold	- minimum latency value to be considered (usecs)
+ tracing_max_latency	- maximum hardware latency actually observed (usecs)
+ hwlat_detector/width	- specified amount of time to spin within window (usecs)
+ hwlat_detector/window	- amount of time between (width) runs (usecs)
-- 
2.8.1


