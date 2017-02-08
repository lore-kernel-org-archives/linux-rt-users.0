From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 16/21] tracing: Add support for dynamic tracepoints
Date: Wed,  8 Feb 2017 11:25:12 -0600
Message-ID: <2f17b25a1719608bc2f87b321db969eeba9d70b1.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The tracepoint infrastructure assumes statically-defined tracepoints
and uses static_keys for tracepoint enablement.  In order to define
tracepoints on the fly, we need to have a dynamic counterpart.

Add a dynamic_tracepoint_probe_register() and a dynamic param onto
tracepoint_probe_unregister() for this purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/tracepoint.h  | 11 +++++++----
 kernel/trace/trace_events.c |  4 ++--
 kernel/tracepoint.c         | 42 ++++++++++++++++++++++++++++++------------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index f72fcfe..72438cb 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -37,9 +37,12 @@ struct trace_enum_map {
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
-			       int prio);
+			       int prio, bool dynamic);
+extern int dynamic_tracepoint_probe_register(struct tracepoint *tp,
+					     void *probe, void *data);
 extern int
-tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
+tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
+			    bool dynamic);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
@@ -206,13 +209,13 @@ static inline void tracepoint_synchronize_unregister(void)
 				   int prio)				\
 	{								\
 		return tracepoint_probe_register_prio(&__tracepoint_##name, \
-					      (void *)probe, data, prio); \
+				      (void *)probe, data, prio, false); \
 	}								\
 	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
-						(void *)probe, data);	\
+					   (void *)probe, data, false); \
 	}								\
 	static inline void						\
 	check_trace_callback_type_##name(void (*cb)(data_proto))	\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9311654..abba9ac 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -297,7 +297,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
-					    file);
+					    file, false);
 		return 0;
 
 #ifdef CONFIG_PERF_EVENTS
@@ -308,7 +308,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-					    call);
+					    call, false);
 		return 0;
 	case TRACE_REG_PERF_OPEN:
 	case TRACE_REG_PERF_CLOSE:
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1f9a31f..6c55edd 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -191,12 +191,15 @@ static void *func_remove(struct tracepoint_func **funcs,
  * Add the probe function to a tracepoint.
  */
 static int tracepoint_add_func(struct tracepoint *tp,
-			       struct tracepoint_func *func, int prio)
+			       struct tracepoint_func *func, int prio,
+			       bool dynamic)
 {
 	struct tracepoint_func *old, *tp_funcs;
 	int ret;
 
-	if (tp->regfunc && !static_key_enabled(&tp->key)) {
+	if (tp->regfunc &&
+	    ((dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
+	     !static_key_enabled(&tp->key))) {
 		ret = tp->regfunc();
 		if (ret < 0)
 			return ret;
@@ -218,7 +221,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * is used.
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	if (!static_key_enabled(&tp->key))
+	if (dynamic && !(atomic_read(&tp->key.enabled) > 0))
+		atomic_inc(&tp->key.enabled);
+	else if (!dynamic && !static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
 	release_probes(old);
 	return 0;
@@ -231,7 +236,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
  * by preempt_disable around the call site.
  */
 static int tracepoint_remove_func(struct tracepoint *tp,
-		struct tracepoint_func *func)
+				  struct tracepoint_func *func, bool dynamic)
 {
 	struct tracepoint_func *old, *tp_funcs;
 
@@ -245,10 +250,14 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 
 	if (!tp_funcs) {
 		/* Removed last function */
-		if (tp->unregfunc && static_key_enabled(&tp->key))
+		if (tp->unregfunc &&
+		    ((dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
+		     static_key_enabled(&tp->key)))
 			tp->unregfunc();
 
-		if (static_key_enabled(&tp->key))
+		if (dynamic && (atomic_read(&tp->key.enabled) > 0))
+			atomic_dec(&tp->key.enabled);
+		else if (!dynamic && static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
 	rcu_assign_pointer(tp->funcs, tp_funcs);
@@ -257,7 +266,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register -  Connect a probe to a tracepoint
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
@@ -270,7 +279,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
  * within module exit functions.
  */
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
-				   void *data, int prio)
+				   void *data, int prio, bool dynamic)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -279,7 +288,7 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 	tp_func.func = probe;
 	tp_func.data = data;
 	tp_func.prio = prio;
-	ret = tracepoint_add_func(tp, &tp_func, prio);
+	ret = tracepoint_add_func(tp, &tp_func, prio, dynamic);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
@@ -300,10 +309,18 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
  */
 int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
 {
-	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
+	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO, false);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 
+int dynamic_tracepoint_probe_register(struct tracepoint *tp, void *probe,
+				      void *data)
+{
+	return tracepoint_probe_register_prio(tp, probe, data,
+					      TRACEPOINT_DEFAULT_PRIO, true);
+}
+EXPORT_SYMBOL_GPL(dynamic_tracepoint_probe_register);
+
 /**
  * tracepoint_probe_unregister -  Disconnect a probe from a tracepoint
  * @tp: tracepoint
@@ -312,7 +329,8 @@ int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
  *
  * Returns 0 if ok, error value on error.
  */
-int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
+int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
+				bool dynamic)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -320,7 +338,7 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
-	ret = tracepoint_remove_func(tp, &tp_func);
+	ret = tracepoint_remove_func(tp, &tp_func, dynamic);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
-- 
1.9.3
