From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v3 14/33] tracing: Move get_hist_field_flags()
Date: Fri, 22 Sep 2017 14:59:54 -0500
Message-ID: <f02388641ba7de187e2fa794a9f0c19a37aae3a4.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Move get_hist_field_flags() to make it more easily accessible for new
code (and keep the move separate from new functionality).

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1ee0950..549109d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -457,6 +457,28 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
 	.elt_init	= hist_trigger_elt_comm_init,
 };
 
+static const char *get_hist_field_flags(struct hist_field *hist_field)
+{
+	const char *flags_str = NULL;
+
+	if (hist_field->flags & HIST_FIELD_FL_HEX)
+		flags_str = "hex";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM)
+		flags_str = "sym";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
+		flags_str = "sym-offset";
+	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
+		flags_str = "execname";
+	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
+		flags_str = "syscall";
+	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
+		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
+
+	return flags_str;
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -1499,28 +1521,6 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	.release = single_release,
 };
 
-static const char *get_hist_field_flags(struct hist_field *hist_field)
-{
-	const char *flags_str = NULL;
-
-	if (hist_field->flags & HIST_FIELD_FL_HEX)
-		flags_str = "hex";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM)
-		flags_str = "sym";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
-		flags_str = "sym-offset";
-	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
-		flags_str = "execname";
-	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
-		flags_str = "syscall";
-	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
-		flags_str = "log2";
-	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
-		flags_str = "usecs";
-
-	return flags_str;
-}
-
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
 	const char *field_name = hist_field_name(hist_field, 0);
-- 
1.9.3
