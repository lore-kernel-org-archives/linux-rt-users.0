From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 25/32] tracing: Allow whitespace to surround hist trigger filter
Date: Mon, 26 Jun 2017 17:49:26 -0500
Message-ID: <f54ae580dd121f6d771b813aefe535514de4ece5.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44464 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbdFZWuq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:50:46 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The existing code only allows for one space before and after the 'if'
specifying the filter for a hist trigger.  Add code to make that more
permissive as far as whitespace goes.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d191f1a..53a0634 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4632,7 +4632,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
 	bool remove = false;
-	char *trigger;
+	char *trigger, *p;
 	int ret = 0;
 
 	if (!param)
@@ -4642,9 +4642,19 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		remove = true;
 
 	/* separate the trigger from the filter (k:v [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
-		return -EINVAL;
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
@@ -4694,6 +4704,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	}
 
 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+
 	/*
 	 * The above returns on success the # of triggers registered,
 	 * but if it didn't register any it returns zero.  Consider no
-- 
1.9.3

