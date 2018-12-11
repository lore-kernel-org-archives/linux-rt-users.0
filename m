From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v8 17/22] tracing: Remove unnecessary hist trigger struct fields
Date: Mon, 10 Dec 2018 18:01:31 -0600
Message-ID: <725804f4cd0e90ee3f19048e195e0bff08a189a8.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

track_data->var_ref->var_ref_idx can be used instead of
track_data.var_ref_idx, so remove it.

Also, hist_field.var_idx is completely unused, so remove it too.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9c19932a5321..130ac2cf6893 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -61,7 +61,6 @@ struct hist_field {
 	char				*system;
 	char				*event_name;
 	char				*name;
-	unsigned int			var_idx;
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -419,7 +418,6 @@ struct action_data {
 			 * tracked e.g onmax($var).
 			 */
 			struct hist_field	*var_ref;
-			unsigned int		var_ref_idx;
 
 			/*
 			 * track_var contains the 'invisible' tracking
@@ -3637,7 +3635,7 @@ static void ontrack_action(struct hist_trigger_data *hist_data,
 			   struct ring_buffer_event *rbe,
 			   struct action_data *data, u64 *var_ref_vals)
 {
-	u64 var_val = var_ref_vals[data->track_data.var_ref_idx];
+	u64 var_val = var_ref_vals[data->track_data.var_ref->var_ref_idx];
 
 	if (check_track_val(elt, data, var_val)) {
 		save_track_val(hist_data, elt, data, var_val);
@@ -3694,7 +3692,6 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 {
 	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
-	unsigned int var_ref_idx = hist_data->n_var_refs;
 	char *track_data_var_str;
 	unsigned long flags;
 	int ret = 0;
@@ -3726,8 +3723,6 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->track_data.var_ref = ref_field;
 
-	data->track_data.var_ref_idx = var_ref_idx;
-
 	if (data->handler == HANDLER_ONMAX)
 		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-- 
2.14.1
