From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Wed, 6 May 2015 08:31:15 +0200
Message-ID: <5549B533.5070609@bmw-carit.de>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de> <1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Carsten Emde <C.Emde@osadl.org>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

It is possible to avoid the hackery from patch 4 completely.
If the tracepoint is placed in stop_critical_timing(),
lockdep doesn't complain anymore.

I have changed this patch so that I don't do need to any additional
work to get the latency calculated. Instead just use the values
from check_critical_timing().

That means the tracepoints will only be hit if the tracer
preemptirqsoff & co is enabled. Instead having several
different tracepoints just add the a new field which describes where
the latency is coming from. Furthermore, this approach also avoids
adding additional overhead when the tracers are compiled in but
not used.

# cat /sys/kernel/debug/tracing/events/latency/latency/format 
name: latency
ID: 333
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:int source;       offset:8;       size:4; signed:1;
        field:cycles_t latency; offset:16;      size:8; signed:0;

print fmt: "source=%s latency=%llu", __print_symbolic(REC->source, {1, "critical section" }, {2, "irq"}, {3, "preempt"}), REC->latency


So in short you could do following to get a histogram:

# echo preemptirqsoff > /sys/kernel/debug/tracing/current_tracer
# echo 1 > /sys/kernel/debug/tracing/tracing_on
# echo 'hist:key=latency.bucket:val=hitcount:sort=latency '	\
	'if source == 1' > 					\
	/sys/kernel/debug/tracing/events/latency/latency/trigger

# cat /sys/kernel/debug/tracing/events/latency/latency/hist | head -20
# trigger info: hist:keys=latency.bucket:vals=:sort=latency.bucket:size=2048 if source == 1 [active]

latency:       1792 hitcount:          7
latency:       2048 hitcount:         23
latency:       2304 hitcount:         37
latency:       2560 hitcount:         57
latency:       2816 hitcount:         33
latency:       3072 hitcount:         40
latency:       3328 hitcount:         16
latency:       3584 hitcount:         40
latency:       3840 hitcount:        133
latency:       4096 hitcount:        150
latency:       4352 hitcount:        196
latency:       4608 hitcount:        338
latency:       4864 hitcount:        159
latency:       5120 hitcount:         92
latency:       5376 hitcount:         58
latency:       5632 hitcount:         26
latency:       5888 hitcount:         25
latency:       6144 hitcount:         24


I do some more testing to see if I missed something.

cheers,
daniel



>From 449c6881425cc461dd7ea6b6f865d2efe99175b3 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Wed, 29 Apr 2015 17:09:04 +0200
Subject: [PATCH] tracing: Add trace_irqsoff tracepoints

In order to create latency histograms, we place a tracepoint at the end
of critical section. 

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 include/trace/events/latency.h | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_irqsoff.c   | 22 ++++++++++++++--------
 2 files changed, 55 insertions(+), 8 deletions(-)
 create mode 100644 include/trace/events/latency.h

diff --git a/include/trace/events/latency.h b/include/trace/events/latency.h
new file mode 100644
index 0000000..1ed8b13
--- /dev/null
+++ b/include/trace/events/latency.h
@@ -0,0 +1,41 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM latency
+
+#if !defined(_TRACE_LATENCY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LATENCY_H
+
+#include <linux/tracepoint.h>
+
+#define LATENCY_CS	1
+#define LATENCY_IRQ	2
+#define LATENCY_PREEMPT	3
+
+#define latency_source_sym						\
+	{LATENCY_CS,		"critical section" },			\
+	{LATENCY_IRQ,		"irq"},					\
+	{LATENCY_PREEMPT,	"preempt"}
+
+TRACE_EVENT(latency,
+	TP_PROTO(int source, cycles_t latency),
+
+	TP_ARGS(source, latency),
+
+	TP_STRUCT__entry(
+		__field(int,		source)
+		__field(cycles_t,	latency)
+	),
+
+	TP_fast_assign(
+		__entry->source		= source;
+		__entry->latency	= latency;
+	),
+
+	TP_printk("source=%s latency=%llu",
+		__print_symbolic(__entry->source, latency_source_sym),
+		__entry->latency)
+);
+
+#endif /* _TRACE_LATENCY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 8523ea3..7a1d254 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,8 +14,13 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
 
+#include <trace/events/sched.h>
+
 #include "trace.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/latency.h>
+
 static struct trace_array		*irqsoff_trace __read_mostly;
 static int				tracer_enabled __read_mostly;
 
@@ -311,7 +316,7 @@ static void
 check_critical_timing(struct trace_array *tr,
 		      struct trace_array_cpu *data,
 		      unsigned long parent_ip,
-		      int cpu)
+		      int cpu, int source)
 {
 	cycle_t T0, T1, delta;
 	unsigned long flags;
@@ -325,6 +330,7 @@ check_critical_timing(struct trace_array *tr,
 
 	pc = preempt_count();
 
+	trace_latency(source, delta);
 	if (!report_latency(tr, delta))
 		goto out;
 
@@ -396,7 +402,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 }
 
 static inline void
-stop_critical_timing(unsigned long ip, unsigned long parent_ip)
+stop_critical_timing(unsigned long ip, unsigned long parent_ip, int source)
 {
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
@@ -423,7 +429,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 
 	local_save_flags(flags);
 	__trace_function(tr, ip, parent_ip, flags, preempt_count());
-	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
+	check_critical_timing(tr, data, parent_ip ? : ip, cpu, source);
 	data->critical_start = 0;
 	atomic_dec(&data->disabled);
 }
@@ -439,7 +445,7 @@ EXPORT_SYMBOL_GPL(start_critical_timings);
 void stop_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, LATENCY_CS);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 
@@ -448,7 +454,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(a0, a1);
+		stop_critical_timing(a0, a1, LATENCY_IRQ);
 }
 
 void time_hardirqs_off(unsigned long a0, unsigned long a1)
@@ -481,7 +487,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
 void trace_hardirqs_on(void)
 {
 	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, LATENCY_IRQ);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
@@ -495,7 +501,7 @@ EXPORT_SYMBOL(trace_hardirqs_off);
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
 	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, caller_addr);
+		stop_critical_timing(CALLER_ADDR0, caller_addr, LATENCY_IRQ);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
@@ -513,7 +519,7 @@ EXPORT_SYMBOL(trace_hardirqs_off_caller);
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
 	if (preempt_trace() && !irq_trace())
-		stop_critical_timing(a0, a1);
+		stop_critical_timing(a0, a1, LATENCY_PREEMPT);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
-- 
2.1.0
