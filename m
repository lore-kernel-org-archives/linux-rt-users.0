From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 28/37] tracing: Allow whitespace to surround hist trigger filter
Date: Wed,  6 Dec 2017 16:38:09 -0600
Message-ID: <e16d9770f2b9f493a42b03a1b14830443b0001ed.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:42414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbdLFWk2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Dec 2017 17:40:28 -0500
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
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
index 03114fb..672992f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5175,7 +5175,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger;
+	char *trigger, *p;
 	int ret = 0;
 
 	if (!param)
@@ -5184,10 +5184,37 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
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

