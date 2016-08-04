From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 3/3] tracing: Have hwlat trace migrate across tracing_cpumask CPUs
Date: Thu, 04 Aug 2016 10:57:11 -0400
Message-ID: <20160804145840.183035905@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:34412 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758743AbcHDPAc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2016 11:00:32 -0400
Content-Disposition: inline; filename=0003-tracing-Have-hwlat-trace-migrate-across-tracing_cpum.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Instead of having the hwlat detector thread stay on one CPU, have it migrate
across all the CPUs specified by tracing_cpumask. If the user modifies the
thread's CPU affinity, the migration will stop until the next instance that
the tracer is instantiated. The migration happens at the end of each window
(period).

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/hwlat_detector.txt |  6 ++++
 kernel/trace/trace_hwlat.c             | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/trace/hwlat_detector.txt b/Documentation/trace/hwlat_detector.txt
index c02e8ef800cf..3207717a0d1a 100644
--- a/Documentation/trace/hwlat_detector.txt
+++ b/Documentation/trace/hwlat_detector.txt
@@ -69,5 +69,11 @@ in /sys/kernel/tracing:
 
  tracing_threshold	- minimum latency value to be considered (usecs)
  tracing_max_latency	- maximum hardware latency actually observed (usecs)
+ tracing_cpumask	- the CPUs to move the hwlat thread across
  hwlat_detector/width	- specified amount of time to spin within window (usecs)
  hwlat_detector/window	- amount of time between (width) runs (usecs)
+
+The hwlat detector's kernel thread will migrate across each CPU specified in
+tracing_cpumask between each window. To limit the migration, either modify
+tracing_cpumask, or modify the hwlat kernel thread (named [hwlatd]) CPU
+affinity directly, and the migration will stop.
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 08dfabe4e862..f0b5b2944ee7 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -42,6 +42,7 @@
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
 #include <linux/uaccess.h>
+#include <linux/cpumask.h>
 #include <linux/delay.h>
 #include "trace.h"
 
@@ -211,6 +212,57 @@ out:
 	return ret;
 }
 
+static struct cpumask save_cpumask;
+static bool disable_migrate;
+
+static void move_to_next_cpu(void)
+{
+	static struct cpumask *current_mask;
+	int next_cpu;
+
+	if (disable_migrate)
+		return;
+
+	/* Just pick the first CPU on first iteration */
+	if (!current_mask) {
+		current_mask = &save_cpumask;
+		get_online_cpus();
+		cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+		put_online_cpus();
+		next_cpu = cpumask_first(current_mask);
+		goto set_affinity;
+	}
+		
+	/*
+	 * If for some reason the user modifies the CPU affinity
+	 * of this thread, than stop migrating for the duration
+	 * of the current test.
+	 */
+	if (!cpumask_equal(current_mask, &current->cpus_allowed))
+		goto disable;
+
+	get_online_cpus();
+	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	next_cpu = cpumask_next(smp_processor_id(), current_mask);
+	put_online_cpus();
+
+	if (next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(current_mask);
+
+ set_affinity:
+	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
+		goto disable;
+
+	cpumask_clear(current_mask);
+	cpumask_set_cpu(next_cpu, current_mask);
+
+	sched_setaffinity(0, current_mask);
+	return;
+
+ disable:
+	disable_migrate = true;
+}
+
 /*
  * kthread_fn - The CPU time sampling/hardware latency detection kernel thread
  *
@@ -230,6 +282,8 @@ static int kthread_fn(void *data)
 
 	while (!kthread_should_stop()) {
 
+		move_to_next_cpu();
+
 		local_irq_disable();
 		get_sample();
 		local_irq_enable();
@@ -473,6 +527,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 	hwlat_trace = tr;
 
+	disable_migrate = false;
 	hwlat_data.count = 0;
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
-- 
2.8.1


