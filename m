From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 5/9] function graph add option to calculate graph time off
Date: Tue, 19 May 2009 11:55:46 -0300
Message-ID: <20090519145546.GM27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:47020 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZESOzv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 10:55:51 -0400
Received: by pxi29 with SMTP id 29so2458276pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 07:55:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

function graph add option to calculate graph time off

Backport to 2.6.29.3-rt14.

| From: Steven Rostedt <srostedt@redhat.com>
| 
| graph time is the time that a function is executing another function.
| Thus if function A calls B, if graph-time is set, then the time for
| A includes B. This is the default behavior. But if graph-time is off,
| then the time spent executing B is subtracted from A.
| 
| Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 include/linux/ftrace.h               |    3 +--
 kernel/trace/ftrace.c                |   21 ++++++++++++++++++++-
 kernel/trace/trace.c                 |    4 +++-
 kernel/trace/trace.h                 |    1 +
 kernel/trace/trace_functions_graph.c |    8 ++++----
 5 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 015a3d2..9e0a8d2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -365,6 +365,7 @@ struct ftrace_ret_stack {
 	unsigned long ret;
 	unsigned long func;
 	unsigned long long calltime;
+	unsigned long long subtime;
 };
 
 /*
@@ -376,8 +377,6 @@ extern void return_to_handler(void);
 
 extern int
 ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth);
-extern void
-ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret);
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ed1fc50..71e5fae 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -604,6 +604,7 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace)
 static void profile_graph_return(struct ftrace_graph_ret *trace)
 {
 	struct ftrace_profile_stat *stat;
+	unsigned long long calltime;
 	struct ftrace_profile *rec;
 	unsigned long flags;
 
@@ -612,9 +613,27 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	if (!stat->hash)
 		goto out;
 
+	calltime = trace->rettime - trace->calltime;
+
+	if (!(trace_flags & TRACE_ITER_GRAPH_TIME)) {
+		int index;
+
+		index = trace->depth;
+
+		/* Append this call time to the parent time to subtract */
+		if (index)
+			current->ret_stack[index - 1].subtime += calltime;
+
+		if (current->ret_stack[index].subtime < calltime)
+			calltime -= current->ret_stack[index].subtime;
+		else
+			calltime = 0;
+	}
+
 	rec = ftrace_find_profiled_func(stat, trace->func);
 	if (rec)
-		rec->time += trace->rettime - trace->calltime;
+		rec->time += calltime;
+
  out:
 	local_irq_restore(flags);
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 821bf49..5d1a16c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -255,7 +255,8 @@ static DECLARE_WAIT_QUEUE_HEAD(trace_wait);
 
 /* trace_flags holds trace_options default values */
 unsigned long trace_flags = TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |
-	TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO | TRACE_ITER_SLEEP_TIME;
+	TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO | TRACE_ITER_SLEEP_TIME |
+	TRACE_ITER_GRAPH_TIME;
 
 /**
  * trace_wake_up - wake up tasks waiting for trace input
@@ -321,6 +322,7 @@ static const char *trace_options[] = {
 	"latency-format",
 	"global-clock",
 	"sleep-time",
+	"graph-time",
 	NULL
 };
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c66ca3b..e3429a8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -693,6 +693,7 @@ enum trace_iterator_flags {
 	TRACE_ITER_LATENCY_FMT		= 0x40000,
 	TRACE_ITER_GLOBAL_CLK		= 0x80000,
 	TRACE_ITER_SLEEP_TIME		= 0x100000,
+	TRACE_ITER_GRAPH_TIME		= 0x200000,
 };
 
 /*
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 85bba0f..10f6ad7 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -78,13 +78,14 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth)
 	current->ret_stack[index].ret = ret;
 	current->ret_stack[index].func = func;
 	current->ret_stack[index].calltime = calltime;
+	current->ret_stack[index].subtime = 0;
 	*depth = index;
 
 	return 0;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-void
+static void
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret)
 {
 	int index;
@@ -104,9 +105,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret)
 	trace->calltime = current->ret_stack[index].calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = index;
-	barrier();
-	current->curr_ret_stack--;
-
 }
 
 /*
@@ -121,6 +119,8 @@ unsigned long ftrace_return_to_handler(void)
 	ftrace_pop_return_trace(&trace, &ret);
 	trace.rettime = trace_clock_local();
 	ftrace_graph_return(&trace);
+	barrier();
+	current->curr_ret_stack--;
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
-- 
1.6.2

-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

