From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v6 34/37] tracing: Add a clock attribute for hist triggers
Date: Fri, 17 Nov 2017 14:33:13 -0600
Message-ID: <53afb2793fc4fd5beb64144f941ca1bff9b72a35.1510948725.git.tom.zanussi@linux.intel.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6227 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422729AbdKQUf5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:35:57 -0500
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The default clock if timestamps are used in a histogram is "global".
If timestamps aren't used, the clock is irrelevant.

Use the "clock=" param only if you want to override the default
"global" clock for a histogram with timestamps.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
---
 Documentation/trace/histogram.txt | 11 ++++++++++-
 kernel/trace/trace_events_hist.c  | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index 0eea8b9..aa450bb 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1674,7 +1674,16 @@ features have been added to the hist trigger support:
     default it is in units of nanoseconds; appending '.usecs' to a
     common_timestamp field changes the units to microseconds.
 
-These features are decribed in more detail in the following sections.
+A note on inter-event timestamps: If $common_timestamp is used in a
+histogram, the trace buffer is automatically switched over to using
+absolute timestamps and the "global" trace clock, in order to avoid
+bogus timestamp differences with other clocks that aren't coherent
+across CPUs.  This can be overridden by specifying one of the other
+trace clocks instead, using the "clock=XXX" hist trigger attribute,
+where XXX is any of the clocks listed in the tracing/trace_clock
+pseudo-file.
+
+These features are described in more detail in the following sections.
 
 2.2.1 Histogram Variables
 -------------------------
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 174aef21..1ac0cda 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -242,6 +242,7 @@ struct hist_trigger_attrs {
 	char		*vals_str;
 	char		*sort_key_str;
 	char		*name;
+	char		*clock;
 	bool		pause;
 	bool		cont;
 	bool		clear;
@@ -1795,6 +1796,7 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	kfree(attrs->sort_key_str);
 	kfree(attrs->keys_str);
 	kfree(attrs->vals_str);
+	kfree(attrs->clock);
 	kfree(attrs);
 }
 
@@ -1850,6 +1852,19 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
+	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+		strsep(&str, "=");
+		if (!str) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		str = strstrip(str);
+		attrs->clock = kstrdup(str, GFP_KERNEL);
+		if (!attrs->clock) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
 		int map_bits = parse_map_size(str);
 
@@ -1914,6 +1929,14 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 		goto free;
 	}
 
+	if (!attrs->clock) {
+		attrs->clock = kstrdup("global", GFP_KERNEL);
+		if (!attrs->clock) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
 	return attrs;
  free:
 	destroy_hist_trigger_attrs(attrs);
@@ -4924,6 +4947,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, ".descending");
 	}
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
+	if (hist_data->enable_timestamps)
+		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
 
 	print_actions_spec(m, hist_data);
 
@@ -5186,10 +5211,19 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			goto out;
 	}
 
-	ret++;
+	if (hist_data->enable_timestamps) {
+		char *clock = hist_data->attrs->clock;
+
+		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
+		if (ret) {
+			hist_err("Couldn't set trace_clock: ", clock);
+			goto out;
+		}
 
-	if (hist_data->enable_timestamps)
 		tracing_set_time_stamp_abs(file->tr, true);
+	}
+
+	ret++;
  out:
 	return ret;
 }
-- 
1.9.3

