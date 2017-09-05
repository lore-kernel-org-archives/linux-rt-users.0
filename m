From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 07/40] tracing: Apply absolute timestamps to instance max buffer
Date: Tue,  5 Sep 2017 16:57:19 -0500
Message-ID: <ebdb168d0be042dcdf51f81e696b17fabe3609c1.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Baohong Liu <baohong.liu@intel.com>

Currently absolute timestamps are applied to both regular and max
buffers only for global trace. For instance trace, absolute
timestamps are applied only to regular buffer. But, regular and max
buffers can be swapped, for example, following a snapshot. So, for
instance trace, bad timestamps can be seen following a snapshot.
Let's apply absolute timestamps to instance max buffer as well.

Similarly, buffer clock change is applied to instance max buffer
as well.

Signed-off-by: Baohong Liu <baohong.liu@intel.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 66d465e..719e4c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6223,7 +6223,7 @@ static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->trace_buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+	if (tr->max_buffer.buffer)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
@@ -6307,7 +6307,7 @@ int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
 	tracing_reset_online_cpus(&tr->trace_buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+	if (tr->max_buffer.buffer)
 		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
-- 
1.9.3
