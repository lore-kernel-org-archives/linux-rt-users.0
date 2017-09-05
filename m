From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 21/40] tracing: Generalize per-element hist trigger data
Date: Tue,  5 Sep 2017 16:57:33 -0500
Message-ID: <e37b733ce4a80b1b92873b95e035b44044bfcfe2.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753759AbdIEV6z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 17:58:55 -0400
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Up until now, hist triggers only needed per-element support for saving
'comm' data, which was saved directly as a private data pointer.

In anticipation of the need to save other data besides 'comm', add a
new hist_elt_data struct for the purpose, and switch the current
'comm'-related code over to that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 65 ++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bbca6d3..f17d394 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -249,6 +249,10 @@ static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
 	return ts;
 }
 
+struct hist_elt_data {
+	char *comm;
+};
+
 static const char *hist_field_name(struct hist_field *field,
 				   unsigned int level)
 {
@@ -447,26 +451,36 @@ static inline void save_comm(char *comm, struct task_struct *task)
 	memcpy(comm, task->comm, TASK_COMM_LEN);
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
-	kfree((char *)elt->private_data);
+	struct hist_elt_data *private_data = elt->private_data;
+
+	kfree(private_data->comm);
+	kfree(private_data);
 }
 
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN + 1;
+	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
 	unsigned int i;
 
+	elt->private_data = elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data)
+		return -ENOMEM;
+
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			unsigned int size = TASK_COMM_LEN + 1;
-
-			elt->private_data = kzalloc(size, GFP_KERNEL);
-			if (!elt->private_data)
+			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			if (!elt_data->comm) {
+				kfree(elt_data);
+				elt->private_data = NULL;
 				return -ENOMEM;
+			}
 			break;
 		}
 	}
@@ -474,18 +488,18 @@ static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
 	return 0;
 }
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
-	char *comm = elt->private_data;
+	struct hist_elt_data *private_data = elt->private_data;
 
-	if (comm)
-		save_comm(comm, current);
+	if (private_data->comm)
+		save_comm(private_data->comm, current);
 }
 
-static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
-	.elt_alloc	= hist_trigger_elt_comm_alloc,
-	.elt_free	= hist_trigger_elt_comm_free,
-	.elt_init	= hist_trigger_elt_comm_init,
+static const struct tracing_map_ops hist_trigger_elt_data_ops = {
+	.elt_alloc	= hist_trigger_elt_data_alloc,
+	.elt_free	= hist_trigger_elt_data_free,
+	.elt_init	= hist_trigger_elt_data_init,
 };
 
 static const char *get_hist_field_flags(struct hist_field *hist_field)
@@ -1494,21 +1508,6 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
-static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
-{
-	struct hist_field *key_field;
-	unsigned int i;
-
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
-
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME)
-			return true;
-	}
-
-	return false;
-}
-
 static struct hist_trigger_data *
 create_hist_data(unsigned int map_bits,
 		 struct hist_trigger_attrs *attrs,
@@ -1534,8 +1533,7 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -1724,7 +1722,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 			seq_printf(m, "%s: [%llx] %-55s", field_name,
 				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			char *comm = elt->private_data;
+			struct hist_elt_data *elt_data = elt->private_data;
+			char *comm = elt_data->comm;
 
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %-16s[%10llu]", field_name,
-- 
1.9.3

