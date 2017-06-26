From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 11/32] tracing: Add post-trigger flag to hist trigger command
Date: Mon, 26 Jun 2017 17:49:12 -0500
Message-ID: <33bd37aa80f98ef44abed819a3cd5858c0ee16ad.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdFZWuH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:50:07 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add EVENT_CMD_FL_POST_TRIGGER to the hist trigger cmd - it doesn't
affect the hist trigger results, and allows further events such as
synthetic events to be generated from a hist trigger.

Without this change, generating an event from a hist trigger will
cause the generated event to fail a ring buffer trace_recursive_lock()
check and return without actually logging the event.
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fccbffe..dab6ff6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1676,7 +1676,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
-	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.flags			= EVENT_CMD_FL_NEEDS_REC | EVENT_CMD_FL_POST_TRIGGER,
 	.func			= event_hist_trigger_func,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
-- 
1.9.3

