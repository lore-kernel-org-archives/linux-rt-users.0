From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 25/40] tracing: Add support for dynamic tracepoints
Date: Tue,  5 Sep 2017 16:57:37 -0500
Message-ID: <9f89af4588c84850a58edcf72d2591ba78906c30.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The tracepoint infrastructure assumes statically-defined tracepoints
and uses static_keys for tracepoint enablement.  In order to define
tracepoints on the fly, we need to have a dynamic counterpart.

Add a 'dynamic' flag to struct tracepoint along with accompanying
logic for this purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/tracepoint-defs.h |  1 +
 kernel/tracepoint.c             | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index a031920..bc22d54 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -32,6 +32,7 @@ struct tracepoint {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	bool dynamic;
 };
 
 #endif
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 685c50a..1c5957f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -197,7 +197,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	struct tracepoint_func *old, *tp_funcs;
 	int ret;
 
-	if (tp->regfunc && !static_key_enabled(&tp->key)) {
+	if (tp->regfunc &&
+	    ((tp->dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
+	     !static_key_enabled(&tp->key))) {
 		ret = tp->regfunc();
 		if (ret < 0)
 			return ret;
@@ -219,7 +221,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * is used.
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	if (!static_key_enabled(&tp->key))
+	if (tp->dynamic && !(atomic_read(&tp->key.enabled) > 0))
+		atomic_inc(&tp->key.enabled);
+	else if (!tp->dynamic && !static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
 	release_probes(old);
 	return 0;
@@ -246,10 +250,14 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 
 	if (!tp_funcs) {
 		/* Removed last function */
-		if (tp->unregfunc && static_key_enabled(&tp->key))
+		if (tp->unregfunc &&
+		    ((tp->dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
+		     static_key_enabled(&tp->key)))
 			tp->unregfunc();
 
-		if (static_key_enabled(&tp->key))
+		if (tp->dynamic && (atomic_read(&tp->key.enabled) > 0))
+			atomic_dec(&tp->key.enabled);
+		else if (!tp->dynamic && static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
 	rcu_assign_pointer(tp->funcs, tp_funcs);
@@ -258,7 +266,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register -  Connect a probe to a tracepoint
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
-- 
1.9.3
