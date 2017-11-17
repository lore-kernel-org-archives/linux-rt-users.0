From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v6 28/37] tracing: Allow whitespace to surround hist trigger filter
Date: Fri, 17 Nov 2017 14:33:07 -0600
Message-ID: <7c2299377db3d14f8b3fa3e3060674e637fec9db.1510948725.git.tom.zanussi@linux.intel.com>
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
Received: from mga05.intel.com ([192.55.52.43]:3967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936041AbdKQUfg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:35:36 -0500
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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
index 7d24c37..121f7ef 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5155,7 +5155,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger;
+	char *trigger, *p;
 	int ret = 0;
 
 	if (!param)
@@ -5164,10 +5164,37 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
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

