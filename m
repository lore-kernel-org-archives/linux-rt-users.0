From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v8 28/37] tracing: Allow whitespace to surround hist trigger filter
Date: Thu, 21 Dec 2017 10:02:50 -0600
Message-ID: <677ebf8d3349721e1697d8e5de536ff38ff284f8.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1513802700.git.tom.zanussi@linux.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
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
 kernel/trace/trace_events_hist.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8d90513..7d25954 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5162,7 +5162,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger;
+	char *trigger, *p;
 	int ret = 0;
 
 	if (!param)
@@ -5171,10 +5171,37 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
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
+	p = trigger = param;
+	do {
+		p = strstr(p, "if");
+		if (!p)
+			break;
+		if (p == param)
+			return -EINVAL;
+		if (*(p - 1) != ' ' && *(p - 1) != '\t') {
+			p++;
+			continue;
+		}
+		if (p >= param + strlen(param) - strlen("if") - 1)
+			return -EINVAL;
+		if (*(p + strlen("if")) != ' ' && *(p + strlen("if")) != '\t') {
+			p++;
+			continue;
+		}
+		break;
+	} while (p);
+
+	if (!p)
+		param = NULL;
+	else {
+		*(p - 1) = '\0';
+		param = strstrip(p);
+		trigger = strstrip(trigger);
+	}
 
 	attrs = parse_hist_trigger_attrs(trigger);
 	if (IS_ERR(attrs))
-- 
1.9.3
