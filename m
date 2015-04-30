From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Thu, 30 Apr 2015 12:06:25 +0200
Message-ID: <1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Finally we place a few tracepoint at the end of critical section. With
the hist trigger in place we can generate the plots.

There are a few drawbacks compared to the latency_hist.patch [1]

The latency plots contain the values from all CPUs. In theory you
can also filter with something like

'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'

but I haven't got this working. I didn't spend much time figuring out
why this doesn't work. Even if the above is working you still
don't get the per CPU breakdown of the events. I don't know if this is
a must have feature.

Another point is the need for placing at least one tracepoint so that
the hist code is able to do something. Also I think it would be a good
idea to reuse the time diff from the tracer instead. Some refactoring
would be necessary for this. For simplicity I just added a hack for
getting the time diff. And I am not really sure if it is okay to use
the *_enabled() in this way, splitting the time stamping and adding
the tracepoint in two sections.

Steven was tossing the idea around to introduce a 'variable' to the
tracepoints which can be used for timestamping etc. I'd like to avoid
placing two tracepoints and doing later the time diff. It sounds like
too much overhead.

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>

[1] https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=56d50cc34943bbba12b8c5942ee1ae3b29f73acb
---
 include/trace/events/latency.h | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_irqsoff.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 include/trace/events/latency.h

diff --git a/include/trace/events/latency.h b/include/trace/events/latency.h
new file mode 100644
index 0000000..9659b08
--- /dev/null
+++ b/include/trace/events/latency.h
@@ -0,0 +1,40 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM latency
+
+#if !defined(_TRACE_HIST_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HIST_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(latency_template,
+	TP_PROTO(cycles_t latency),
+
+	TP_ARGS(latency),
+
+	TP_STRUCT__entry(
+		__field(cycles_t,	latency)
+	),
+
+	TP_fast_assign(
+		__entry->latency	= latency;
+	),
+
+	TP_printk("latency=%llu", __entry->latency)
+);
+
+DEFINE_EVENT(latency_template, latency_irqs,
+	    TP_PROTO(cycles_t latency),
+	    TP_ARGS(latency));
+
+DEFINE_EVENT(latency_template, latency_preempt,
+	    TP_PROTO(cycles_t latency),
+	    TP_ARGS(latency));
+
+DEFINE_EVENT(latency_template, latency_critical_timings,
+	    TP_PROTO(cycles_t latency),
+	    TP_ARGS(latency));
+
+#endif /* _TRACE_HIST_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 8523ea3..7465c72 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,12 +14,20 @@
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
 
 static DEFINE_PER_CPU(int, tracing_cpu);
+static DEFINE_PER_CPU(cycle_t, ts_irqs);
+static DEFINE_PER_CPU(cycle_t, ts_preempt);
+static DEFINE_PER_CPU(cycle_t, ts_critical_timings);
 
 static DEFINE_RAW_SPINLOCK(max_trace_lock);
 
@@ -428,9 +436,24 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	atomic_dec(&data->disabled);
 }
 
+static void do_timestamp(cycle_t __percpu *ts)
+{
+	int cpu = raw_smp_processor_id();
+	per_cpu(*ts, cpu) = ftrace_now(cpu);
+}
+
+static cycle_t get_delta(cycle_t __percpu *ts)
+{
+	int cpu = raw_smp_processor_id();
+	return ftrace_now(cpu) - per_cpu(*ts, cpu);
+}
+
 /* start and stop critical timings used to for stoppage (in idle) */
 void start_critical_timings(void)
 {
+	if (trace_latency_critical_timings_enabled())
+		do_timestamp(&ts_critical_timings);
+
 	if (preempt_trace() || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -440,6 +463,9 @@ void stop_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+
+	if (trace_latency_critical_timings_enabled())
+		trace_latency_critical_timings(get_delta(&ts_critical_timings));
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 
@@ -447,6 +473,9 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
+	if (trace_latency_irqs_enabled())
+		do_timestamp(&ts_irqs);
+
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -455,6 +484,9 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
+
+	if (trace_latency_irqs_enabled())
+		trace_latency_irqs(get_delta(&ts_irqs));
 }
 
 #else /* !CONFIG_PROVE_LOCKING */
@@ -512,6 +544,9 @@ EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #ifdef CONFIG_PREEMPT_TRACER
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
+	if (trace_latency_preempt_enabled())
+		do_timestamp(&ts_preempt);
+
 	if (preempt_trace() && !irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -520,6 +555,9 @@ void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
 	if (preempt_trace() && !irq_trace())
 		start_critical_timing(a0, a1);
+
+	if (trace_latency_preempt_enabled())
+		trace_latency_preempt(get_delta(&ts_preempt));
 }
 #endif /* CONFIG_PREEMPT_TRACER */
 
-- 
2.1.0
