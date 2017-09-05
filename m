From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 16/40] tracing: Add hist_data member to hist_field
Date: Tue,  5 Sep 2017 16:57:28 -0500
Message-ID: <237a3a416f4cbb9276ae495a192772a2b68423b0.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753850AbdIEV6n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 17:58:43 -0400
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Allow hist_data access via hist_field.  Some users of hist_fields
require or will require more access to the associated hist_data.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index dfaf07b..65aad07 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -39,6 +39,7 @@ struct hist_field {
 	unsigned int			offset;
 	unsigned int                    is_signed;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
+	struct hist_trigger_data	*hist_data;
 };
 
 static u64 hist_field_none(struct hist_field *field, void *event,
@@ -404,7 +405,8 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	kfree(hist_field);
 }
 
-static struct hist_field *create_hist_field(struct ftrace_event_field *field,
+static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
+					    struct ftrace_event_field *field,
 					    unsigned long flags)
 {
 	struct hist_field *hist_field;
@@ -416,6 +418,8 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->hist_data = hist_data;
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		goto out;
@@ -429,7 +433,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (flags & HIST_FIELD_FL_LOG2) {
 		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
-		hist_field->operands[0] = create_hist_field(field, fl);
+		hist_field->operands[0] = create_hist_field(hist_data, field, fl);
 		hist_field->size = hist_field->operands[0]->size;
 		goto out;
 	}
@@ -482,7 +486,7 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
-		create_hist_field(NULL, HIST_FIELD_FL_HITCOUNT);
+		create_hist_field(hist_data, NULL, HIST_FIELD_FL_HITCOUNT);
 	if (!hist_data->fields[HITCOUNT_IDX])
 		return -ENOMEM;
 
@@ -528,7 +532,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags);
+	hist_data->fields[val_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[val_idx]) {
 		ret = -ENOMEM;
 		goto out;
@@ -638,7 +642,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags);
+	hist_data->fields[key_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[key_idx]) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.9.3

