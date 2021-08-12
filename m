Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A359C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189526109F
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhHLWoA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 18:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238341AbhHLWn6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 18:43:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AB576109D;
        Thu, 12 Aug 2021 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628808211;
        bh=gJlotV3bMlIwfphJrI2ypHFs4KA6tjN5Zl2A+VhCv0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=enAbKhlK4/qzw8aOSEJIka6bWxPO+y0F5rISvLtv7XQyZwWhIZYEf2ear5N1WlEW1
         TZrCQq3Mg9Ypcma/u5a1Ic6zd3hxDebrpfOasrYdmeAH9/gWe7x9ZI17YB3Jn8svfk
         A8Szs8xmI5OTpTVgos4GnCgopcCj49Gb7vSZfFwec3OKgIftX7GzV6/U5jmcyirvUH
         OotP9N+igZTow2FhZKMLdnjH1ORjd9xpUtAVbBiGog+PtLBp6iwy0PZ7pc0exuul+E
         FXZPE2NRJaYti8auR/wn8Jm+buEmI9U+OW7dBFWAhqPtzTvQIV5b3mgfLZqlQpgo63
         0HjE3hOfNqetg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, bristot@kernel.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 1/1] tracing: Add hist_json event file
Date:   Thu, 12 Aug 2021 17:43:24 -0500
Message-Id: <9fa88971ea0da487b1712ee0349036273700d324.1628807056.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1628807056.git.zanussi@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
In-Reply-To: <cover.1628807056.git.zanussi@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a file named hist_json for each trace event.  Reading it will dump
the contents of all current histogram(s) defined on the event in json
format.

The file contents include not only the histogram bucket contents but
also related data associated with the histogram such as histogram
info, totals, and the values of any action variables that may be
associated with it.

If there are multiple histograms associated with an event, each
histogram is dumped in its entirety before the next starts.

The same functions that print the histogram to the 'hist' file are
used to print the 'hist_json' contents.  Other formats can easily be
added by adding a new show_format in addition to the TEXT and JSON
formats implemented here.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_events.c      |   2 +
 kernel/trace/trace_events_hist.c | 532 ++++++++++++++++++++++++++-----
 3 files changed, 463 insertions(+), 72 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a180abf76d4e..c212c379a172 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1526,6 +1526,7 @@ extern struct list_head ftrace_events;
 
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
+extern const struct file_operations event_hist_json_fops;
 extern const struct file_operations event_hist_debug_fops;
 extern const struct file_operations event_inject_fops;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 80e96989770e..e5e8ec1cb5d0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2432,6 +2432,8 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 #ifdef CONFIG_HIST_TRIGGERS
 	trace_create_file("hist", 0444, file->dir, file,
 			  &event_hist_fops);
+	trace_create_file("hist_json", 0444, file->dir, file,
+			  &event_hist_json_fops);
 #endif
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
 	trace_create_file("hist_debug", 0444, file->dir, file,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d91b1c06957..5221522d9a3d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2903,6 +2903,176 @@ static bool check_track_val(struct tracing_map_elt *elt,
 	return data->track_data.check_val(track_val, var_val);
 }
 
+enum show_format {
+	TEXT,
+	JSON,
+};
+
+static void indent(struct seq_file *m, int *level)
+{
+#define JSON_INDENT	2
+
+	int indent_spaces = *level * JSON_INDENT;
+
+	seq_printf(m, "%*c", indent_spaces, ' ');
+}
+
+static void __print_obj_name(struct seq_file *m, const char *name,
+			     enum show_format format)
+{
+	if (!name)
+		return;
+
+	if (format == JSON)
+		seq_printf(m, "\"%s\":", name);
+	else if (format == TEXT)
+		seq_printf(m, "%s:", name);
+}
+
+static void __start_json_obj(struct seq_file *m, const char *name, int *level,
+			     const char *bracket)
+{
+	indent(m, level);
+	__print_obj_name(m, name, JSON);
+	seq_puts(m, bracket);
+	(*level)++;
+}
+
+static void __end_json_obj(struct seq_file *m, int *level, const char *bracket)
+{
+	(*level)--;
+	indent(m, level);
+	seq_puts(m, bracket);
+}
+
+static void print_json_obj_start(struct seq_file *m,
+				 const char *name, int *level)
+{
+	__start_json_obj(m, name, level, "{\n");
+}
+
+static void print_json_obj_end(struct seq_file *m, int *level)
+{
+	__end_json_obj(m, level, "},\n");
+}
+
+static void __start_obj(struct seq_file *m, const char *name,
+			enum show_format format, int *level)
+{
+	if (format == JSON)
+		print_json_obj_start(m, name, level);
+}
+
+static void __end_obj(struct seq_file *m, enum show_format format, int *level)
+{
+	if (format == JSON)
+		print_json_obj_end(m, level);
+}
+
+static void __start_json_array(struct seq_file *m, const char *name,
+			       int *level)
+{
+	__start_json_obj(m, name, level, "[\n");
+}
+
+static void __end_json_array(struct seq_file *m, int *level)
+{
+	__end_json_obj(m, level, "],\n");
+}
+
+static void print_hist_start(struct seq_file *m, int nth_hist,
+			     enum show_format format, int *level)
+{
+	if (nth_hist > 0 && format == TEXT)
+		seq_puts(m, "\n\n");
+
+	__start_obj(m, "hist", format, level);
+}
+
+#define print_hist_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_map_start(m, format, level) \
+	__start_obj(m, "map", format, level)
+#define print_map_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_entry_start(m, format, level) \
+	__start_obj(m, "entry", format, level)
+#define print_entry_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_action_start(m, format, level) \
+	__start_obj(m, "action", format, level)
+#define print_action_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_snapshot_action_start(m, format, level) \
+	__start_obj(m, "snapshot", format, level)
+#define print_snapshot_action_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_key_start(m, format, level) \
+	__start_obj(m, NULL, format, level)
+#define print_key_end(m, format, level) \
+	__end_obj(m, format, level)
+#define print_val_end(m, format, level) \
+	__end_obj(m, format, level)
+
+static void print_val_start(struct seq_file *m,
+			    enum show_format format, int *level)
+{
+	if (format == JSON)
+		print_json_obj_start(m, NULL, level);
+	else if (format == TEXT)
+		seq_putc(m, ' ');
+}
+
+static void print_keys_start(struct seq_file *m,
+			     enum show_format format, int *level)
+{
+	if (format == JSON)
+		__start_json_array(m, "keys", level);
+	else if (format == TEXT)
+		seq_puts(m, "{ ");
+}
+
+static void print_keys_end(struct seq_file *m,
+			   enum show_format format, int *level)
+{
+	if (format == JSON)
+		__end_json_array(m, level);
+	else if (format == TEXT)
+		seq_puts(m, "}");
+}
+
+static void print_vals_start(struct seq_file *m,
+			     enum show_format format, int *level)
+{
+	if (format == JSON)
+		__start_json_array(m, "vals", level);
+}
+
+static void print_vals_end(struct seq_file *m,
+			   enum show_format format, int *level)
+{
+	if (format == JSON)
+		__end_json_array(m, level);
+}
+
+static void print_pair_start(struct seq_file *m, const char *name,
+			     enum show_format format, int *level)
+{
+	if (format == JSON)
+		indent(m, level);
+
+	__print_obj_name(m, name, format);
+}
+
+static void print_pair_end(struct seq_file *m, const char *val,
+			   enum show_format format)
+{
+	if (format == JSON)
+		seq_printf(m, "\"%s\",\n", val);
+	else if (format == TEXT)
+		seq_puts(m, val);
+}
+
 #ifdef CONFIG_TRACER_SNAPSHOT
 static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 {
@@ -2956,7 +3126,8 @@ static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
 static void hist_trigger_print_key(struct seq_file *m,
 				   struct hist_trigger_data *hist_data,
 				   void *key,
-				   struct tracing_map_elt *elt);
+				   struct tracing_map_elt *elt,
+				   enum show_format format, int *level);
 
 static struct action_data *snapshot_action(struct hist_trigger_data *hist_data)
 {
@@ -2976,11 +3147,13 @@ static struct action_data *snapshot_action(struct hist_trigger_data *hist_data)
 }
 
 static void track_data_snapshot_print(struct seq_file *m,
-				      struct hist_trigger_data *hist_data)
+				      struct hist_trigger_data *hist_data,
+				      enum show_format format, int *level)
 {
 	struct trace_event_file *file = hist_data->event_file;
 	struct track_data *track_data;
 	struct action_data *action;
+	char str[MAX_FILTER_STR_VAL];
 
 	track_data = tracing_cond_snapshot_data(file->tr);
 	if (!track_data)
@@ -2993,14 +3166,32 @@ static void track_data_snapshot_print(struct seq_file *m,
 	if (!action)
 		return;
 
-	seq_puts(m, "\nSnapshot taken (see tracing/snapshot).  Details:\n");
-	seq_printf(m, "\ttriggering value { %s(%s) }: %10llu",
-		   action->handler == HANDLER_ONMAX ? "onmax" : "onchange",
-		   action->track_data.var_str, track_data->track_val);
+	if (format == JSON) {
+		print_snapshot_action_start(m, format, level);
+		print_pair_start(m, "handler", format, level);
+		if (action->handler == HANDLER_ONMAX)
+			print_pair_end(m, "onmax", format);
+		else
+			print_pair_end(m, "onchange", format);
 
-	seq_puts(m, "\ttriggered by event with key: ");
-	hist_trigger_print_key(m, hist_data, track_data->key, &track_data->elt);
-	seq_putc(m, '\n');
+		print_pair_start(m, action->track_data.var_str, format, level);
+		snprintf(str, sizeof(str), "%10llu", track_data->track_val);
+		print_pair_end(m, strim(str), format);
+	} else if (format == TEXT) {
+		seq_puts(m, "\nSnapshot taken (see tracing/snapshot).  Details:\n");
+		seq_printf(m, "\ttriggering value { %s(%s) }: %10llu",
+			   action->handler == HANDLER_ONMAX ? "onmax" : "onchange",
+			   action->track_data.var_str, track_data->track_val);
+
+		seq_puts(m, "\ttriggered by event with key: ");
+	}
+
+	hist_trigger_print_key(m, hist_data, track_data->key, &track_data->elt,
+			       format, level);
+	if (format == JSON)
+		print_snapshot_action_end(m, format, level);
+	else
+		seq_putc(m, '\n');
 }
 #else
 static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
@@ -3014,24 +3205,71 @@ static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
 				     struct action_data *data,
 				     u64 *var_ref_vals) {}
 static void track_data_snapshot_print(struct seq_file *m,
-				      struct hist_trigger_data *hist_data) {}
+				      struct hist_trigger_data *hist_data,
+				      enum show_format format, int *level) {}
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
+static void print_track_val(struct seq_file *m, const char *handler,
+			    u64 track_val, enum show_format format, int *level)
+{
+	char str[MAX_FILTER_STR_VAL];
+
+	if (format == JSON) {
+		print_pair_start(m, handler, format, level);
+		snprintf(str, sizeof(str), "%10llu", track_val);
+		print_pair_end(m, strim(str), format);
+	} else if (format == TEXT) {
+		seq_printf(m, "\n\t%s: %10llu", handler, track_val);
+	}
+}
+
+static void print_variable(struct seq_file *m, const char *var_name, u64 val,
+			   bool is_string, enum show_format format, int *level)
+{
+	char str[MAX_FILTER_STR_VAL];
+
+	if (is_string) {
+		if (format == JSON) {
+			snprintf(str, sizeof(str), "%s", var_name);
+			print_pair_start(m, str, format, level);
+			snprintf(str, sizeof(str), "%-32s", (char *)(uintptr_t)(val));
+			print_pair_end(m, strim(str), format);
+		} else if (format == TEXT) {
+			seq_printf(m, "  %s: %-32s", var_name,
+				   (char *)(uintptr_t)(val));
+		}
+	} else {
+		if (format == JSON) {
+			snprintf(str, sizeof(str), "%s", var_name);
+			print_pair_start(m, str, format, level);
+			snprintf(str, sizeof(str), "%10llu", val);
+			print_pair_end(m, strim(str), format);
+		} else {
+			seq_printf(m, "  %s: %10llu", var_name, val);
+		}
+	}
+}
+
 static void track_data_print(struct seq_file *m,
 			     struct hist_trigger_data *hist_data,
 			     struct tracing_map_elt *elt,
-			     struct action_data *data)
+			     struct action_data *data,
+			     enum show_format format, int *level)
 {
 	u64 track_val = get_track_val(hist_data, elt, data);
 	unsigned int i, save_var_idx;
 
+	print_action_start(m, format, level);
+
 	if (data->handler == HANDLER_ONMAX)
-		seq_printf(m, "\n\tmax: %10llu", track_val);
+		print_track_val(m, "max", track_val, format, level);
 	else if (data->handler == HANDLER_ONCHANGE)
-		seq_printf(m, "\n\tchanged: %10llu", track_val);
+		print_track_val(m, "changed", track_val, format, level);
 
-	if (data->action == ACTION_SNAPSHOT)
+	if (data->action == ACTION_SNAPSHOT) {
+		print_action_end(m, format, level);
 		return;
+	}
 
 	for (i = 0; i < hist_data->n_save_vars; i++) {
 		struct hist_field *save_val = hist_data->save_vars[i]->val;
@@ -3042,12 +3280,12 @@ static void track_data_print(struct seq_file *m,
 
 		val = tracing_map_read_var(elt, save_var_idx);
 
-		if (save_val->flags & HIST_FIELD_FL_STRING) {
-			seq_printf(m, "  %s: %-32s", save_var->var.name,
-				   (char *)(uintptr_t)(val));
-		} else
-			seq_printf(m, "  %s: %10llu", save_var->var.name, val);
+		print_variable(m, save_var->var.name, val,
+			       save_val->flags & HIST_FIELD_FL_STRING,
+			       format, level);
 	}
+
+	print_action_end(m, format, level);
 }
 
 static void ontrack_action(struct hist_trigger_data *hist_data,
@@ -4276,7 +4514,8 @@ static int create_actions(struct hist_trigger_data *hist_data)
 
 static void print_actions(struct seq_file *m,
 			  struct hist_trigger_data *hist_data,
-			  struct tracing_map_elt *elt)
+			  struct tracing_map_elt *elt,
+			  enum show_format format, int *level)
 {
 	unsigned int i;
 
@@ -4288,7 +4527,7 @@ static void print_actions(struct seq_file *m,
 
 		if (data->handler == HANDLER_ONMAX ||
 		    data->handler == HANDLER_ONCHANGE)
-			track_data_print(m, hist_data, elt, data);
+			track_data_print(m, hist_data, elt, data, format, level);
 	}
 }
 
@@ -4694,7 +4933,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
 					  unsigned long *stacktrace_entries,
-					  unsigned int max_entries)
+					  unsigned int max_entries,
+					  enum show_format format, int *level)
 {
 	char str[KSYM_SYMBOL_LEN];
 	unsigned int spaces = 8;
@@ -4704,7 +4944,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 		if (!stacktrace_entries[i])
 			return;
 
-		seq_printf(m, "%*c", 1 + spaces, ' ');
+		if (format == JSON)
+			indent(m, level);
+		else if (format == TEXT)
+			seq_printf(m, "%*c", 1 + spaces, ' ');
 		sprint_symbol(str, stacktrace_entries[i]);
 		seq_printf(m, "%s\n", str);
 	}
@@ -4713,8 +4956,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 static void hist_trigger_print_key(struct seq_file *m,
 				   struct hist_trigger_data *hist_data,
 				   void *key,
-				   struct tracing_map_elt *elt)
+				   struct tracing_map_elt *elt,
+				   enum show_format format, int *level)
 {
+	char key_str[MAX_FILTER_STR_VAL];
 	struct hist_field *key_field;
 	char str[KSYM_SYMBOL_LEN];
 	bool multiline = false;
@@ -4722,29 +4967,36 @@ static void hist_trigger_print_key(struct seq_file *m,
 	unsigned int i;
 	u64 uval;
 
-	seq_puts(m, "{ ");
+	print_keys_start(m, format, level);
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
-		if (i > hist_data->n_vals)
+		if (i > hist_data->n_vals && format == TEXT)
 			seq_puts(m, ", ");
 
-		field_name = hist_field_name(key_field, 0);
+		print_key_start(m, format, level);
+
+		if (key_field->flags & HIST_FIELD_FL_STACKTRACE)
+			field_name = "stacktrace";
+		else
+			field_name = hist_field_name(key_field, 0);
+
+		print_pair_start(m, field_name, format, level);
 
 		if (key_field->flags & HIST_FIELD_FL_HEX) {
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %llx", field_name, uval);
+			snprintf(key_str, sizeof(key_str), "%llx", uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol_no_offset(str, uval);
-			seq_printf(m, "%s: [%llx] %-45s", field_name,
-				   uval, str);
+			snprintf(key_str, sizeof(key_str), "[%llx] %-45s",
+				 uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol(str, uval);
-			seq_printf(m, "%s: [%llx] %-55s", field_name,
-				   uval, str);
+			snprintf(key_str, sizeof(key_str), "[%llx] %-55s",
+				 uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
 			struct hist_elt_data *elt_data = elt->private_data;
 			char *comm;
@@ -4755,8 +5007,8 @@ static void hist_trigger_print_key(struct seq_file *m,
 			comm = elt_data->comm;
 
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %-16s[%10llu]", field_name,
-				   comm, uval);
+			snprintf(key_str, sizeof(key_str), "%-16s[%10llu]",
+				 comm, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYSCALL) {
 			const char *syscall_name;
 
@@ -4765,49 +5017,72 @@ static void hist_trigger_print_key(struct seq_file *m,
 			if (!syscall_name)
 				syscall_name = "unknown_syscall";
 
-			seq_printf(m, "%s: %-30s[%3llu]", field_name,
-				   syscall_name, uval);
+			snprintf(key_str, sizeof(key_str), "%-30s[%3llu]",
+				 syscall_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			seq_puts(m, "stacktrace:\n");
+			if (format == JSON)
+				seq_puts(m, "\"\n");
+			else if (format == TEXT)
+				seq_puts(m, "\n");
 			hist_trigger_stacktrace_print(m,
 						      key + key_field->offset,
-						      HIST_STACKTRACE_DEPTH);
+						      HIST_STACKTRACE_DEPTH,
+						      format, level);
 			multiline = true;
 		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
-			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
-				   *(u64 *)(key + key_field->offset));
+			snprintf(key_str, sizeof(key_str), "~ 2^%-2llu",
+				 *(u64 *)(key + key_field->offset));
 		} else if (key_field->flags & HIST_FIELD_FL_BUCKET) {
 			unsigned long buckets = key_field->buckets;
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: ~ %llu-%llu", field_name,
-				   uval, uval + buckets -1);
+			snprintf(key_str, sizeof(key_str), "~ %llu-%llu",
+				 uval, uval + buckets - 1);
 		} else if (key_field->flags & HIST_FIELD_FL_STRING) {
-			seq_printf(m, "%s: %-50s", field_name,
-				   (char *)(key + key_field->offset));
+			snprintf(key_str, sizeof(key_str), "%-50s",
+				 (char *)(key + key_field->offset));
 		} else {
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %10llu", field_name, uval);
+			snprintf(key_str, sizeof(key_str), "%10llu", uval);
 		}
+		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
+			if (format == JSON) {
+				indent(m, level);
+				seq_puts(m, "\"\n");
+			}
+		} else {
+			print_pair_end(m, strim(key_str), format);
+		}
+		print_key_end(m, format, level);
 	}
 
-	if (!multiline)
+	if (!multiline && format == TEXT)
 		seq_puts(m, " ");
 
-	seq_puts(m, "}");
+	print_keys_end(m, format, level);
 }
 
 static void hist_trigger_entry_print(struct seq_file *m,
 				     struct hist_trigger_data *hist_data,
 				     void *key,
-				     struct tracing_map_elt *elt)
+				     struct tracing_map_elt *elt,
+				     enum show_format format, int *level)
 {
+	char val_str[MAX_FILTER_STR_VAL];
 	const char *field_name;
 	unsigned int i;
 
-	hist_trigger_print_key(m, hist_data, key, elt);
+	print_entry_start(m, format, level);
+
+	hist_trigger_print_key(m, hist_data, key, elt, format, level);
 
-	seq_printf(m, " hitcount: %10llu",
-		   tracing_map_read_sum(elt, HITCOUNT_IDX));
+	print_vals_start(m, format, level);
+
+	print_val_start(m, format, level);
+	print_pair_start(m, "hitcount", format, level);
+	snprintf(val_str, sizeof(val_str), "%10llu",
+		 tracing_map_read_sum(elt, HITCOUNT_IDX));
+	print_pair_end(m, strim(val_str), format);
+	print_val_end(m, format, level);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
@@ -4816,22 +5091,34 @@ static void hist_trigger_entry_print(struct seq_file *m,
 		    hist_data->fields[i]->flags & HIST_FIELD_FL_EXPR)
 			continue;
 
+		print_val_start(m, format, level);
+		print_pair_start(m, field_name, format, level);
+
 		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
-			seq_printf(m, "  %s: %10llx", field_name,
-				   tracing_map_read_sum(elt, i));
+			snprintf(val_str, sizeof(val_str), "%10llx",
+				 tracing_map_read_sum(elt, i));
 		} else {
-			seq_printf(m, "  %s: %10llu", field_name,
-				   tracing_map_read_sum(elt, i));
+			snprintf(val_str, sizeof(val_str), "%10llu",
+				 tracing_map_read_sum(elt, i));
 		}
+
+		print_pair_end(m, strim(val_str), format);
+		print_val_end(m, format, level);
 	}
 
-	print_actions(m, hist_data, elt);
+	print_vals_end(m, format, level);
+
+	print_actions(m, hist_data, elt, format, level);
+
+	print_entry_end(m, format, level);
 
-	seq_puts(m, "\n");
+	if (format != JSON)
+		seq_puts(m, "\n");
 }
 
 static int print_entries(struct seq_file *m,
-			 struct hist_trigger_data *hist_data)
+			 struct hist_trigger_data *hist_data,
+			 enum show_format format, int *level)
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
@@ -4846,43 +5133,97 @@ static int print_entries(struct seq_file *m,
 	for (i = 0; i < n_entries; i++)
 		hist_trigger_entry_print(m, hist_data,
 					 sort_entries[i]->key,
-					 sort_entries[i]->elt);
+					 sort_entries[i]->elt, format, level);
 
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
 	return n_entries;
 }
 
+static void show_hist_info(struct seq_file *m, struct event_trigger_data *data,
+			   enum show_format format, int *level)
+{
+	if (format == JSON) {
+		print_json_obj_start(m, "info", level);
+		print_pair_start(m, "trigger", format, level);
+		seq_puts(m, "\"");
+	} else if (format == TEXT) {
+		seq_puts(m, "# event histogram\n#\n# trigger info: ");
+	}
+
+	data->ops->print(m, data->ops, data);
+
+	if (format == JSON) {
+		seq_puts(m, "\"\n");
+		print_json_obj_end(m, level);
+	} else {
+		seq_puts(m, "#\n\n");
+	}
+}
+
+static void print_hist_totals(struct seq_file *m,
+			      struct hist_trigger_data *hist_data, int n_entries,
+			      enum show_format format, int *level)
+{
+	char str[MAX_FILTER_STR_VAL];
+
+	if (format == JSON) {
+		print_json_obj_start(m, "totals", level);
+
+		print_pair_start(m, "hits", format, level);
+		snprintf(str, sizeof(str), "%llu",
+			 (u64)atomic64_read(&hist_data->map->hits));
+		print_pair_end(m, strim(str), format);
+
+		print_pair_start(m, "entries", format, level);
+		snprintf(str, sizeof(str), "%u", n_entries);
+		print_pair_end(m, strim(str), format);
+
+		print_pair_start(m, "dropped", format, level);
+		snprintf(str, sizeof(str), "%llu",
+			 (u64)atomic64_read(&hist_data->map->drops));
+		print_pair_end(m, strim(str), format);
+
+		print_json_obj_end(m, level);
+	} else if (format == TEXT) {
+		seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
+			   (u64)atomic64_read(&hist_data->map->hits),
+			   n_entries, (u64)atomic64_read(&hist_data->map->drops));
+	}
+}
+
 static void hist_trigger_show(struct seq_file *m,
-			      struct event_trigger_data *data, int n)
+			      struct event_trigger_data *data, int n,
+			      enum show_format format, int *level)
 {
 	struct hist_trigger_data *hist_data;
 	int n_entries;
 
-	if (n > 0)
-		seq_puts(m, "\n\n");
+	print_hist_start(m, n, format, level);
 
-	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
-	seq_puts(m, "#\n\n");
+	show_hist_info(m, data, format, level);
+
+	print_map_start(m, format, level);
 
 	hist_data = data->private_data;
-	n_entries = print_entries(m, hist_data);
+	n_entries = print_entries(m, hist_data, format, level);
 	if (n_entries < 0)
 		n_entries = 0;
 
-	track_data_snapshot_print(m, hist_data);
+	print_map_end(m, format, level);
 
-	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
-		   (u64)atomic64_read(&hist_data->map->hits),
-		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
+	track_data_snapshot_print(m, hist_data, format, level);
+
+	print_hist_totals(m, hist_data, n_entries, format, level);
+
+	print_hist_end(m, format, level);
 }
 
 static int hist_show(struct seq_file *m, void *v)
 {
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
-	int n = 0, ret = 0;
+	int n = 0, ret = 0, level = 1;
 
 	mutex_lock(&event_mutex);
 
@@ -4894,7 +5235,7 @@ static int hist_show(struct seq_file *m, void *v)
 
 	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
-			hist_trigger_show(m, data, n++);
+			hist_trigger_show(m, data, n++, TEXT, &level);
 	}
 
  out_unlock:
@@ -4921,6 +5262,53 @@ const struct file_operations event_hist_fops = {
 	.release = single_release,
 };
 
+static int hist_json_show(struct seq_file *m, void *v)
+{
+	struct event_trigger_data *data;
+	struct trace_event_file *event_file;
+	int n = 0, ret = 0, level = 1;
+
+	mutex_lock(&event_mutex);
+
+	event_file = event_file_data(m->private);
+	if (unlikely(!event_file)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	seq_puts(m, "[\n");
+
+	list_for_each_entry(data, &event_file->triggers, list) {
+		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
+			hist_trigger_show(m, data, n++, JSON, &level);
+	}
+
+	seq_puts(m, "]\n");
+
+out_unlock:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int event_hist_json_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	return single_open(file, hist_json_show, file);
+}
+
+const struct file_operations event_hist_json_fops = {
+	.open = event_hist_json_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
 static void hist_field_debug_show_flags(struct seq_file *m,
 					unsigned long flags)
-- 
2.17.1

