From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 28 Mar 2016 13:50:51 -0300
Message-ID: <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459182044.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Deadline tasks behave differently of other tasks because deadline
task's also depend on their period, deadline and runtime.

Hence, the well known sched:sched_wakeup and sched:sched_switch
tracepoints are not always enough to precisely explain the behavior of a
deadline task with respect to the task's period, deadline, and runtime
consumption and replenishment.

In order to provide more precise information about the scheduling of
deadline tasks, this patch implements the following tracepoints:

- sched:sched_deadline_replenish: Informs the runtime replenishment of
a deadline task. Trace example:

  <idle>-0     [010] d.h.   268.428878: sched_deadline_replenish: \
	comm=y pid=1608 now=268.428876113 deadline=268.458863627  \
	runtime=20000000

The task y-1608 was replenished with 20000000 ns at 268.428876113
to be used until the deadline at 268.458863627.

- sched:sched_deadline_yield: Informs that a deadline task called
sched_yield(), and will wait for the next period. Trace example:

  y-1608  [010] d...   268.428892: sched_deadline_yield: 	\
	now=268.428891932 deadline=268.458863627		\
	remaining_runtime=19995653

The task y-1608 yielded before its deadline, with 19995653 ns of
remaining runtime.

- sched:sched_deadline_throttle: Informs that a task consumed all its
available runtime and was throttled. Trace example:

  t-1613  [011] d.h.   280.419823: sched_deadline_throttle:	\
	now=280.419823282 deadline=280.430683206 		\
	remaining_runtime=-13280

The task t-1613 overrun its runtime by 13280 ns and was throttled.

- sched:sched_deadline_block: Informs that a deadline task went to sleep
waiting to be awakened by another task. Trace example:

  b-1611  [011] d...   276.228298: sched_deadline_block: 	\
	now=276.228295889 deadline=276.258262555
	remaining_runtime=19966666

The task b-1611 blocked waiting for an external event. Its deadline is at
276.258262555, and it stills have 19966666 ns of remaining runtime on the
current period.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9b90c57..8696c1a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -562,6 +562,94 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+/*
+ * Tracepoint for runtime replenishment of deadline tasks:
+ */
+TRACE_EVENT(sched_deadline_replenish,
+
+	TP_PROTO(struct sched_dl_entity *dl_se),
+
+	TP_ARGS(dl_se),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	u64,	now			)
+		__field(	u64,	deadline		)
+		__field(	s64,	runtime			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, dl_task_of(dl_se)->comm, TASK_COMM_LEN);
+		__entry->now		= rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se)));
+		__entry->pid		= dl_task_of(dl_se)->pid;
+		__entry->deadline	= dl_se->deadline;
+		__entry->runtime	= dl_se->runtime;
+	),
+
+	TP_printk("comm=%s pid=%d now=%llu.%09u deadline=%llu.%09u runtime=%lld",
+		  __entry->comm,
+		  __entry->pid,
+		  __print_ns_to_secs(__entry->now),
+		  __print_ns_without_secs(__entry->now),
+		  __print_ns_to_secs(__entry->deadline),
+		  __print_ns_without_secs(__entry->deadline),
+		  __entry->runtime)
+);
+
+DECLARE_EVENT_CLASS(sched_deadline_template,
+
+	TP_PROTO(struct sched_dl_entity *dl_se),
+
+	TP_ARGS(dl_se),
+
+	TP_STRUCT__entry(
+		__field(	u64,	now			)
+		__field(	u64,	deadline		)
+		__field(	s64,	runtime			)
+	),
+
+	TP_fast_assign(
+		__entry->now		= rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se)));
+		__entry->deadline	= dl_se->deadline;
+		__entry->runtime	= dl_se->runtime;
+	),
+
+	TP_printk("now=%llu.%09u deadline=%llu.%09u remaining_runtime=%lld",
+		  __print_ns_to_secs(__entry->now),
+		  __print_ns_without_secs(__entry->now),
+		  __print_ns_to_secs(__entry->deadline),
+		  __print_ns_without_secs(__entry->deadline),
+		  __entry->runtime)
+);
+
+/*
+ * Tracepoint for sched_yield() of a deadline task (the task
+ * went to sleep waiting for the next period).
+ */
+DEFINE_EVENT_CONDITION(sched_deadline_template, sched_deadline_yield,
+	     TP_PROTO(struct sched_dl_entity *dl_se),
+	     TP_ARGS(dl_se),
+	     TP_CONDITION(dl_se->dl_yielded));
+
+/*
+ * Tracepoint for throttling of a deadline task that consumed all its
+ * runtime.
+ */
+DEFINE_EVENT_CONDITION(sched_deadline_template, sched_deadline_throttle,
+	     TP_PROTO(struct sched_dl_entity *dl_se),
+	     TP_ARGS(dl_se),
+	     TP_CONDITION(!dl_se->dl_yielded));
+
+/*
+ * Tracepoint for blocking of a deadline task. The deadline task was
+ * dequeued, but neither by being throttled nor yielding.
+ */
+DEFINE_EVENT_CONDITION(sched_deadline_template, sched_deadline_block,
+	     TP_PROTO(struct sched_dl_entity *dl_se),
+	     TP_ARGS(dl_se),
+	     TP_CONDITION(!dl_se->dl_yielded && !dl_se->dl_throttled));
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f6bfb0a..e8551fc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <trace/events/sched.h>
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -351,6 +352,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
 	dl_se->runtime = pi_se->dl_runtime;
+	trace_sched_deadline_replenish(dl_se);
 }
 
 /*
@@ -417,6 +419,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 		dl_se->runtime = pi_se->dl_runtime;
 	}
 
+	trace_sched_deadline_replenish(dl_se);
+
 	if (dl_se->dl_yielded)
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
@@ -496,6 +500,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se,
 	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
 		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
 		dl_se->runtime = pi_se->dl_runtime;
+		trace_sched_deadline_replenish(dl_se);
 	}
 }
 
@@ -733,7 +738,9 @@ static void update_curr_dl(struct rq *rq)
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_deadline_yield(&rq->curr->dl);
 		dl_se->dl_throttled = 1;
+		trace_sched_deadline_throttle(dl_se);
 		__dequeue_task_dl(rq, curr, 0);
 		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
@@ -910,6 +917,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	__dequeue_dl_entity(dl_se);
+	trace_sched_deadline_block(dl_se);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
-- 
2.5.0
