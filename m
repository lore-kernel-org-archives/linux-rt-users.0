From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v8 09/37] tracing: Add ring buffer event param to hist field functions
Date: Thu, 21 Dec 2017 10:02:31 -0600
Message-ID: <5b5aa5765f91791be382b347faab348f83ef147a.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753361AbdLUQDa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Dec 2017 11:03:30 -0500
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Some events such as timestamps require access to a ring_buffer_event
struct; add a param so that hist field functions can access that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 63a1912..37f5ace 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -26,7 +26,8 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
+				struct ring_buffer_event *rbe);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 
@@ -40,24 +41,28 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event)
+static u64 hist_field_none(struct hist_field *field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event)
+static u64 hist_field_counter(struct hist_field *field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event)
+static u64 hist_field_string(struct hist_field *hist_field, void *event,
+			     struct ring_buffer_event *rbe)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
+				struct ring_buffer_event *rbe)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -66,24 +71,28 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event)
+static u64 hist_field_log2(struct hist_field *hist_field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event);
+	u64 val = operand->fn(operand, event, rbe);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
 #define DEFINE_HIST_FIELD_FN(type)					\
-static u64 hist_field_##type(struct hist_field *hist_field, void *event)\
+	static u64 hist_field_##type(struct hist_field *hist_field,	\
+				     void *event,			\
+				     struct ring_buffer_event *rbe)	\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -871,8 +880,8 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt,
-				    void *rec)
+				    struct tracing_map_elt *elt, void *rec,
+				    struct ring_buffer_event *rbe)
 {
 	struct hist_field *hist_field;
 	unsigned int i;
@@ -880,7 +889,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec);
+		hist_val = hist_field->fn(hist_field, rec, rbe);
 		tracing_map_update_sum(elt, i, hist_val);
 	}
 }
@@ -910,7 +919,7 @@ static inline void add_to_key(char *compound_key, void *key,
 }
 
 static void event_hist_trigger(struct event_trigger_data *data, void *rec,
-			       struct ring_buffer_event *event)
+			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
@@ -939,7 +948,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec);
+			field_contents = key_field->fn(key_field, rec, rbe);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -956,7 +965,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 	elt = tracing_map_insert(hist_data->map, key);
 	if (elt)
-		hist_trigger_elt_update(hist_data, elt, rec);
+		hist_trigger_elt_update(hist_data, elt, rec, rbe);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
-- 
1.9.3

