From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/9] tracing: Reverse the order of trace_types_lock and event_mutex
Date: Fri, 22 Sep 2017 14:58:16 -0500
Message-ID: <7d9febe58f3cd7ddb14dd3c0f19e36ee929bab26.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to make future changes where we need to call
tracing_set_clock() from within an event command, the order of
trace_types_lock and event_mutex must be reversed, as the event command
will hold event_mutex and the trace_types_lock is taken from within
tracing_set_clock().

Requested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  5 +++++
 kernel/trace/trace_events.c | 31 +++++++++++++++----------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5360b7a..b0ad927 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7674,6 +7674,7 @@ static int instance_mkdir(const char *name)
 	struct trace_array *tr;
 	int ret;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
@@ -7729,6 +7730,7 @@ static int instance_mkdir(const char *name)
 	list_add(&tr->list, &ftrace_trace_arrays);
 
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return 0;
 
@@ -7740,6 +7742,7 @@ static int instance_mkdir(const char *name)
 
  out_unlock:
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 
@@ -7752,6 +7755,7 @@ static int instance_rmdir(const char *name)
 	int ret;
 	int i;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
 	ret = -ENODEV;
@@ -7797,6 +7801,7 @@ static int instance_rmdir(const char *name)
 
  out_unlock:
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8746839..ec0f9aa 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1406,8 +1406,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 
 	/* Make sure the system still exists */
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		list_for_each_entry(dir, &tr->systems, list) {
 			if (dir == inode->i_private) {
@@ -1421,8 +1421,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 		}
 	}
  exit_loop:
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	if (!system)
 		return -ENODEV;
@@ -2294,15 +2294,15 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 int trace_add_event_call(struct trace_event_call *call)
 {
 	int ret;
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 
 	ret = __register_event(call, NULL);
 	if (ret >= 0)
 		__add_event_to_tracers(call);
 
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -2356,13 +2356,13 @@ int trace_remove_event_call(struct trace_event_call *call)
 {
 	int ret;
 
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	down_write(&trace_event_sem);
 	ret = probe_remove_event_call(call);
 	up_write(&trace_event_sem);
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
@@ -2424,8 +2424,8 @@ static int trace_module_notify(struct notifier_block *self,
 {
 	struct module *mod = data;
 
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_events(mod);
@@ -2434,8 +2434,8 @@ static int trace_module_notify(struct notifier_block *self,
 		trace_module_remove_events(mod);
 		break;
 	}
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return 0;
 }
@@ -2950,24 +2950,24 @@ static __init int setup_trace_event(char *str)
  * creates the event hierachry in the @parent/events directory.
  *
  * Returns 0 on success.
+ *
+ * Must be called with event_mutex held.
  */
 int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
 {
 	int ret;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
 
 	ret = create_event_toplevel_files(parent, tr);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	down_write(&trace_event_sem);
 	__trace_add_event_dirs(tr);
 	up_write(&trace_event_sem);
 
- out_unlock:
-	mutex_unlock(&event_mutex);
-
+ out:
 	return ret;
 }
 
@@ -2996,9 +2996,10 @@ int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
 	return ret;
 }
 
+/* Must be called with event_mutex held */
 int event_trace_del_tracer(struct trace_array *tr)
 {
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
 
 	/* Disable any event triggers and associated soft-disabled events */
 	clear_event_triggers(tr);
@@ -3019,8 +3020,6 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	tr->event_dir = NULL;
 
-	mutex_unlock(&event_mutex);
-
 	return 0;
 }
 
-- 
1.9.3
