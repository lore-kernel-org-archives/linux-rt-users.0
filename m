From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v4 19/37] tracing: Generalize per-element hist trigger data
Date: Mon, 30 Oct 2017 15:52:01 -0500
Message-ID: <ee9ccc5ef5d6a2d1127e5e82fdc6774ee193a273.1509395596.git.tom.zanussi@linux.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509395595.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1509395595.git.tom.zanussi@linux.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Up until now, hist triggers only needed per-element support for saving
'comm' data, which was saved directly as a private data pointer.

In anticipation of the need to save other data besides 'comm', add a
new hist_elt_data struct for the purpose, and switch the current
'comm'-related code over to that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 76 +++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0eec597..4055187 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -247,6 +247,10 @@ static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
 	return ts;
 }
 
+struct hist_elt_data {
+	char *comm;
+};
+
 static const char *hist_field_name(struct hist_field *field,
 				   unsigned int level)
 {
@@ -461,45 +465,61 @@ static inline void save_comm(char *comm, struct task_struct *task)
 	memcpy(comm, task->comm, TASK_COMM_LEN);
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
+static void hist_elt_data_free(struct hist_elt_data *elt_data)
+{
+	kfree(elt_data->comm);
+	kfree(elt_data);
+}
+
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
-	kfree((char *)elt->private_data);
+	struct hist_elt_data *elt_data = elt->private_data;
+
+	hist_elt_data_free(elt_data);
 }
 
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN + 1;
+	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
 	unsigned int i;
 
+	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
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
 				return -ENOMEM;
+			}
 			break;
 		}
 	}
 
+	elt->private_data = elt_data;
+
 	return 0;
 }
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
-	char *comm = elt->private_data;
+	struct hist_elt_data *elt_data = elt->private_data;
 
-	if (comm)
-		save_comm(comm, current);
+	if (elt_data->comm)
+		save_comm(elt_data->comm, current);
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
@@ -1507,21 +1527,6 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
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
@@ -1547,8 +1552,7 @@ static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -1736,7 +1740,13 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 			seq_printf(m, "%s: [%llx] %-55s", field_name,
 				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			char *comm = elt->private_data;
+			struct hist_elt_data *elt_data = elt->private_data;
+			char *comm;
+
+			if (WARN_ON_ONCE(!elt_data))
+				return;
+
+			comm = elt_data->comm;
 
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %-16s[%10llu]", field_name,
-- 
1.9.3
