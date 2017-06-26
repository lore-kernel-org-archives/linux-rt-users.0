From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 10/32] tracing: Add NO_DISCARD event file flag
Date: Mon, 26 Jun 2017 17:49:11 -0500
Message-ID: <39effea57d7b72d262ed98f376bd1f722ca71559.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Whenever an event_command has a post-trigger that needs access to the
event record, the event record can't be discarded, or the post-trigger
will eventually see bogus data.

In order to allow the discard check to treat this case separately, add
an EVENT_FILE_FL_NO_DISCARD flag to the event file flags, along with
code in the discard check that checks the flag and avoids the discard
when the flag is set.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/trace_events.h        |  3 +++
 kernel/trace/trace.h                | 13 ++++++++++---
 kernel/trace/trace_events_trigger.c | 16 +++++++++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f333114..d7b230b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -297,6 +297,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE_BIT,
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
+	EVENT_FILE_FL_NO_DISCARD_BIT,
 };
 
 /*
@@ -311,6 +312,7 @@ enum {
  *  TRIGGER_MODE  - When set, invoke the triggers associated with the event
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
+ *  NO_DISCARD    - When set, do not discard events, something needs them later
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -322,6 +324,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE	= (1 << EVENT_FILE_FL_TRIGGER_MODE_BIT),
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
+	EVENT_FILE_FL_NO_DISCARD	= (1 << EVENT_FILE_FL_NO_DISCARD_BIT),
 };
 
 struct trace_event_file {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 78c7694..81b1d07 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1271,9 +1271,16 @@ static inline void trace_buffer_unlock_commit(struct trace_array *tr,
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
 		*tt = event_triggers_call(file, entry, event);
 
-	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	     !filter_match_preds(file->filter, entry))) {
+	if (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	    !filter_match_preds(file->filter, entry)) {
+		__trace_event_discard_commit(buffer, event);
+		return true;
+	}
+
+	if (test_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags))
+		return false;
+
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags)) {
 		__trace_event_discard_commit(buffer, event);
 		return true;
 	}
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 9b0fe31..d345820 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -505,20 +505,30 @@ int trace_event_trigger_enable_disable(struct trace_event_file *file,
 void update_cond_flag(struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
-	bool set_cond = false;
+	bool set_cond = false, set_no_discard = false;
 
 	list_for_each_entry_rcu(data, &file->triggers, list) {
 		if (data->filter || event_command_post_trigger(data->cmd_ops) ||
-		    event_command_needs_rec(data->cmd_ops)) {
+		    event_command_needs_rec(data->cmd_ops))
 			set_cond = true;
+
+		if (event_command_post_trigger(data->cmd_ops) &&
+		    event_command_needs_rec(data->cmd_ops))
+			set_no_discard = true;
+
+		if (set_cond && set_no_discard)
 			break;
-		}
 	}
 
 	if (set_cond)
 		set_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
 	else
 		clear_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
+
+	if (set_no_discard)
+		set_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
+	else
+		clear_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
 }
 
 /**
-- 
1.9.3
