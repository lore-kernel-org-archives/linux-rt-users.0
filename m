From: Tom Zanussi <zanussi@kernel.org>
Subject: [RFC PATCH v2 5/5] tracing: Use tracing error_log with trace event filters
Date: Wed, 13 Feb 2019 12:17:56 -0600
Message-ID: <df938f8158788fdb81628052c003c0d4e760aebb.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Use tracing_log_err() from the new tracing error_log mechanism to send
filter parse errors to tracing/error_log.

With this change, users will be able to see filter errors by looking
at tracing/error_log.

The same errors will also be available in the filter file, as
expected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_filter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 84a65173b1e9..139c3c976d83 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -66,7 +66,8 @@ static const char * ops[] = { OPS };
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
-	C(NO_FILTER,		"No filter found"),
+	C(ERRNO,		"Error"),				\
+	C(NO_FILTER,		"No filter found")
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -76,7 +77,7 @@ enum { ERRORS };
 #undef C
 #define C(a, b)		b
 
-static char *err_text[] = { ERRORS };
+static const char *err_text[] = { ERRORS };
 
 /* Called after a '!' character but "!=" and "!~" are not "not"s */
 static bool is_not(const char *str)
@@ -938,8 +939,10 @@ static void append_filter_err(struct filter_parse_error *pe,
 	if (pe->lasterr > 0) {
 		trace_seq_printf(s, "\n%*s", pos, "^");
 		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+		tracing_log_err("event filter parse error", filter->filter_string, err_text, pe->lasterr, pe->lasterr_pos);
 	} else {
 		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+		tracing_log_err("event filter parse error", filter->filter_string, err_text, FILT_ERR_ERRNO, 0);
 	}
 	trace_seq_putc(s, 0);
 	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
-- 
2.14.1
