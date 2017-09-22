From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 7/9] tracing: Clean up hist_field_flags enum
Date: Fri, 22 Sep 2017 14:58:21 -0500
Message-ID: <e644e4fb7665aec015f4a2d84a2f990d3dd5b8a1.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

As we add more flags, specifying explicit integers for the flag values
becomes more unwieldy and error-prone - switch them over to left-shift
values.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7eb975a..4f6b640 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -110,16 +110,16 @@ static u64 hist_field_log2(struct hist_field *hist_field, void *event)
 #define HIST_KEY_SIZE_MAX	(MAX_FILTER_STR_VAL + HIST_STACKTRACE_SIZE)
 
 enum hist_field_flags {
-	HIST_FIELD_FL_HITCOUNT		= 1,
-	HIST_FIELD_FL_KEY		= 2,
-	HIST_FIELD_FL_STRING		= 4,
-	HIST_FIELD_FL_HEX		= 8,
-	HIST_FIELD_FL_SYM		= 16,
-	HIST_FIELD_FL_SYM_OFFSET	= 32,
-	HIST_FIELD_FL_EXECNAME		= 64,
-	HIST_FIELD_FL_SYSCALL		= 128,
-	HIST_FIELD_FL_STACKTRACE	= 256,
-	HIST_FIELD_FL_LOG2		= 512,
+	HIST_FIELD_FL_HITCOUNT		= 1 << 0,
+	HIST_FIELD_FL_KEY		= 1 << 1,
+	HIST_FIELD_FL_STRING		= 1 << 2,
+	HIST_FIELD_FL_HEX		= 1 << 3,
+	HIST_FIELD_FL_SYM		= 1 << 4,
+	HIST_FIELD_FL_SYM_OFFSET	= 1 << 5,
+	HIST_FIELD_FL_EXECNAME		= 1 << 6,
+	HIST_FIELD_FL_SYSCALL		= 1 << 7,
+	HIST_FIELD_FL_STACKTRACE	= 1 << 8,
+	HIST_FIELD_FL_LOG2		= 1 << 9,
 };
 
 struct hist_trigger_attrs {
-- 
1.9.3
