From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 38/40] tracing: Make tracing_set_clock() non-static
Date: Tue,  5 Sep 2017 16:57:50 -0500
Message-ID: <b279a2707aaf0077577fa05596bb6d80628a7b52.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Allow tracing code outside of trace.c to access tracing_set_clock().

Some applications may require a particular clock in order to function
properly, such as latency calculations.

Also, add an accessor returning the current clock string.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d40839d..ecdf456 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6207,7 +6207,7 @@ static int tracing_clock_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
+int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 {
 	int i;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7b78762..1f3443a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -288,6 +288,7 @@ enum {
 extern void trace_array_put(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
-- 
1.9.3
