From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 5/6] tracing: Add field parsing trace event errors for hist triggers
Date: Thu, 12 Apr 2018 10:13:20 -0500
Message-ID: <6182020d231aa51485e7fc12441527d3709cad06.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Log errors to the tracing/events/error_log for nonexistent fields and
modifiers specified in hist triggers.

Also screen out variable references, which shouldn't be looked up as
fields.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 08424ff..d223fd6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2461,6 +2461,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
+			log_err("Invalid field modifier: %s", modifier);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2476,6 +2477,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			log_err("Couldn't find field: %s", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2553,6 +2555,11 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	} else
 		str = s;
 
+	if (is_var_ref(str)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	field = parse_field(hist_data, file, str, flags);
 	if (IS_ERR(field)) {
 		ret = PTR_ERR(field);
-- 
1.9.3
