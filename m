From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 20/20 v2] tracing: Add argument error message too many args for function based
 events
Date: Wed, 07 Feb 2018 15:24:22 -0500
Message-ID: <20180207202817.672743925@goodmis.org>
References: <20180207202402.253089656@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0020-tracing-Add-argument-error-message-too-many-args-for.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If too many arguments are added to the function_events, have the error
message state that instead of saying the type of argument that passed the
allowed amount is incorrect.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_ftrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 314d025dc676..e612b1c4fc40 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -1380,8 +1380,14 @@ static void add_failure(struct func_event *func_event, char *token,
 
 	trace_seq_printf(s, "\n%*s\n", len, "^");
 
-	trace_seq_printf(s, "Unexpected token '%s' for %s state",
-			 save_token, func_state_names[state]);
+	/* for COMMA or PARAM state, the error could be too many args */
+	if ((state == FUNC_STATE_COMMA || state == FUNC_STATE_PARAM) &&
+	    func_event->arg_cnt >= max_args)
+		trace_seq_printf(s, "Error: Too many arguments (max of %d)",
+				 max_args);
+	else
+		trace_seq_printf(s, "Unexpected token '%s' for %s state",
+				 save_token, func_state_names[state]);
 
  finish:
 	len = min(ERR_SIZE-1, s->seq.len);
-- 
2.15.1
