From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v3 25/33] tracing: Allow whitespace to surround hist trigger filter
Date: Fri, 22 Sep 2017 15:00:05 -0500
Message-ID: <68a176facc91c86e90862f3e719c6bf57f505340.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The existing code only allows for one space before and after the 'if'
specifying the filter for a hist trigger.  Add code to make that more
permissive as far as whitespace goes.  Specifically, we want to allow
spaces in the trigger itself now that we have additional syntax
(onmatch/onmax) where spaces are more natural e.g. spaces after commas
in param lists.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba42fe2..431f2b2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4857,7 +4857,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger;
+	char *trigger, *p;
 	int ret = 0;
 
 	if (!param)
@@ -4866,10 +4866,23 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (glob[0] == '!')
 		remove = true;
 
-	/* separate the trigger from the filter (k:v [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
-		return -EINVAL;
+	/*
+	 * separate the trigger from the filter (k:v [if filter])
+	 * allowing for whitespace in the trigger
+	 */
+	trigger = param;
+	p = strstr(param, " if");
+	if (!p)
+		p = strstr(param, "\tif");
+	if (p) {
+		if (p == trigger)
+			return -EINVAL;
+		param = p + 1;
+		param = strstrip(param);
+		*p = '\0';
+		trigger = strstrip(trigger);
+	} else
+		param = NULL;
 
 	attrs = parse_hist_trigger_attrs(trigger);
 	if (IS_ERR(attrs))
@@ -4927,6 +4940,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	}
 
 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+
 	/*
 	 * The above returns on success the # of triggers registered,
 	 * but if it didn't register any it returns zero.  Consider no
-- 
1.9.3
