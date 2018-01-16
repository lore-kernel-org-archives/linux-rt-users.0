From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 17/37] tracing: Move get_hist_field_flags()
Date: Mon, 15 Jan 2018 20:51:51 -0600
Message-ID: <32470f0a7047ec7a6e84ba5ec89d6142cc6ede7d.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Move get_hist_field_flags() to make it more easily accessible for new
code (and keep the move separate from new functionality).

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba32626..a81a709 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -497,6 +497,28 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
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
@@ -1495,28 +1517,6 @@ static int event_hist_open(struct inode *inode, struct file *file)
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
