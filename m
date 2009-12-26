From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/2] add-tracing_max_latency-may-not-be-worst-case-system-latency-to-ftrace-docs.patch
Date: Sat, 26 Dec 2009 22:41:15 +0100
Message-ID: <20091226214229.238699028@osadl.org>
References: <20091226214114.843059850@osadl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754066AbZLZWLL@vger.kernel.org>
Content-Disposition: inline; filename=add-tracing_max_latency-may-not-be-worst-case-system-latency-to-ftrace-docs.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Explain the background of the trace variable
tracing_max_latency in the context of the
wakeup and the wakeup_rt tracer and why it
does not necessarily measure the worst-case
latency of the system.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: linux-2.6.33-rc2/Documentation/trace/ftrace.txt
===================================================================
--- linux-2.6.33-rc2.orig/Documentation/trace/ftrace.txt
+++ linux-2.6.33-rc2/Documentation/trace/ftrace.txt
@@ -117,9 +117,25 @@ of ftrace. Here is a list of some of the
 	For example, the time interrupts are disabled.
 	This time is saved in this file. The max trace
 	will also be stored, and displayed by "trace".
-	A new max trace will only be recorded if the
+	A new max trace will only be recorded, if the
 	latency is greater than the value in this
-	file. (in microseconds)
+	file (in microseconds). NOTE: The max latency
+	recorded by the wakeup and the wakeup_rt tracer
+	do not necessarily reflect the worst-case latency
+	of the system. If two or more processes share the
+	highest priority of the system and may be woken
+	up shortly after each other, the max latency
+	recorded by the wakeup and the wakeup_rt tracers
+	equal the worst-case latency of the system *plus*
+	the longest possible runtime duration of all tasks
+	that share the same priority. An exact measurement
+	of the worst-case wakeup latency of the system can
+	be achieved using the wakekup latency histograms
+	that are part of the PREEMPT_RT patches. These
+	histograms separately determine the wakeup latency
+	of a task that exclusively uses the highest
+	priority of the system and of tasks that share the
+	highest priority of the system with other tasks.
 
   buffer_size_kb:
 
