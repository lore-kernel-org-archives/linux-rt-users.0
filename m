From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 09/14] tracing: Allow histogram triggers to access ftrace internal events
Date: Mon, 14 May 2018 16:58:54 -0400
Message-ID: <20180514205958.632175645@goodmis.org>
References: <20180514205845.017925650@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-tracing-Allow-histogram-triggers-to-access-ftrace-in.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that trace_marker can have triggers, including a histogram triggers, the
onmatch() and onmax() access the trace event. To do so, the search routine
to find the event file needs to use the raw __find_event_file() that does
not filter out ftrace events.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b9061ed59bbd..046c716a6536 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2865,7 +2865,7 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 {
 	struct trace_event_file *file;
 
-	file = find_event_file(tr, system, event_name);
+	file = __find_event_file(tr, system, event_name);
 	if (!file)
 		return ERR_PTR(-EINVAL);
 
-- 
2.17.0
