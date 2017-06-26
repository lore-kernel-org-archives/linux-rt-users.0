From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 14/32] tracing: Add hist_data member to hist_field
Date: Mon, 26 Jun 2017 17:49:15 -0500
Message-ID: <e1fb4afc17fd6692755e233ba1052b0869c2e36f.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdFZWuQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:50:16 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Allow hist_data access via hist_field.  Some users of hist_fields
require or will require more access to the associated hist_data.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index aeae3b4..fb08a75 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -39,6 +39,7 @@ struct hist_field {
 	unsigned int			offset;
 	unsigned int                    is_signed;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
+	struct hist_trigger_data	*hist_data;
 };
 
 static u64 hist_field_none(struct hist_field *field, void *event,
@@ -415,7 +416,8 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	kfree(hist_field);
 }
 
-static struct hist_field *create_hist_field(struct ftrace_event_field *field,
+static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
+					    struct ftrace_event_field *field,
 					    unsigned long flags)
 {
 	struct hist_field *hist_field;
@@ -427,6 +429,8 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->hist_data = hist_data;
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		goto out;
@@ -440,7 +444,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (flags & HIST_FIELD_FL_LOG2) {
 		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
-		hist_field->operands[0] = create_hist_field(field, fl);
+		hist_field->operands[0] = create_hist_field(hist_data, field, fl);
 		hist_field->size = hist_field->operands[0]->size;
 		goto out;
 	}
@@ -493,7 +497,7 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
-		create_hist_field(NULL, HIST_FIELD_FL_HITCOUNT);
+		create_hist_field(hist_data, NULL, HIST_FIELD_FL_HITCOUNT);
 	if (!hist_data->fields[HITCOUNT_IDX])
 		return -ENOMEM;
 
@@ -539,7 +543,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags);
+	hist_data->fields[val_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[val_idx]) {
 		ret = -ENOMEM;
 		goto out;
@@ -649,7 +653,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags);
+	hist_data->fields[key_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[key_idx]) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.9.3

