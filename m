Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97FC4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629F420856
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDBSe6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDBSe4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 14:34:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF072147A;
        Tue,  2 Apr 2019 18:34:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBOFJ-0008KX-OF; Tue, 02 Apr 2019 14:34:53 -0400
Message-Id: <20190402183453.637112620@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 02 Apr 2019 14:29:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC][PATCH 3/3] tracing: Have the error logs show up in the proper instances
References: <20190402182951.130809543@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As each instance has their own error_log file, it makes more sense that the
instances show the errors of their own instead of all error_logs having the
same data. Make it that the errors show up in the instance error_log file
that the error happens in. If no instance trace_array is available, then
NULL can be passed in which will create the error in the top level instance
(the one at the top of the tracefs directory).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c               | 55 ++++++++++++++++++++----------
 kernel/trace/trace.h               |  5 ++-
 kernel/trace/trace_events_filter.c |  4 +--
 kernel/trace/trace_events_hist.c   |  3 +-
 kernel/trace/trace_probe.c         |  2 +-
 5 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7978168f5041..3d55e9daae8c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6897,25 +6897,22 @@ struct tracing_log_err {
 	char			cmd[MAX_FILTER_STR_VAL]; /* what caused err */
 };
 
-static LIST_HEAD(tracing_err_log);
 static DEFINE_MUTEX(tracing_err_log_lock);
 
-static unsigned int n_tracing_err_log_entries;
-
-struct tracing_log_err *get_tracing_log_err(void)
+struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 {
 	struct tracing_log_err *err;
 
-	if (n_tracing_err_log_entries < TRACING_LOG_ERRS_MAX) {
+	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
 		err = kzalloc(sizeof(*err), GFP_KERNEL);
 		if (!err)
 			err = ERR_PTR(-ENOMEM);
-		n_tracing_err_log_entries++;
+		tr->n_err_log_entries++;
 
 		return err;
 	}
 
-	err = list_first_entry(&tracing_err_log, struct tracing_log_err, list);
+	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
 	list_del(&err->list);
 
 	return err;
@@ -6949,6 +6946,7 @@ unsigned int err_pos(char *cmd, const char *str)
 
 /**
  * tracing_log_err - write an error to the tracing error log
+ * @tr: The associated trace array for the error (NULL for top level array)
  * @loc: A string describing where the error occurred
  * @cmd: The tracing command that caused the error
  * @errs: The array of loc-specific static error strings
@@ -6973,13 +6971,17 @@ unsigned int err_pos(char *cmd, const char *str)
  * existing callers for examples of how static strings are typically
  * defined for use with tracing_log_err().
  */
-void tracing_log_err(const char *loc, const char *cmd,
+void tracing_log_err(struct trace_array *tr,
+		     const char *loc, const char *cmd,
 		     const char **errs, u8 type, u8 pos)
 {
 	struct tracing_log_err *err;
 
+	if (!tr)
+		tr = &global_trace;
+
 	mutex_lock(&tracing_err_log_lock);
-	err = get_tracing_log_err();
+	err = get_tracing_log_err(tr);
 	if (PTR_ERR(err) == -ENOMEM) {
 		mutex_unlock(&tracing_err_log_lock);
 		return;
@@ -6993,34 +6995,38 @@ void tracing_log_err(const char *loc, const char *cmd,
 	err->info.pos = pos;
 	err->info.ts = local_clock();
 
-	list_add_tail(&err->list, &tracing_err_log);
+	list_add_tail(&err->list, &tr->err_log);
 	mutex_unlock(&tracing_err_log_lock);
 }
 
-static void clear_tracing_err_log(void)
+static void clear_tracing_err_log(struct trace_array *tr)
 {
 	struct tracing_log_err *err, *next;
 
 	mutex_lock(&tracing_err_log_lock);
-	list_for_each_entry_safe(err, next, &tracing_err_log, list) {
+	list_for_each_entry_safe(err, next, &tr->err_log, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
 
-	n_tracing_err_log_entries = 0;
+	tr->n_err_log_entries = 0;
 	mutex_unlock(&tracing_err_log_lock);
 }
 
 static void *tracing_err_log_seq_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_array *tr = m->private;
+
 	mutex_lock(&tracing_err_log_lock);
 
-	return seq_list_start(&tracing_err_log, *pos);
+	return seq_list_start(&tr->err_log, *pos);
 }
 
 static void *tracing_err_log_seq_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	return seq_list_next(v, &tracing_err_log, pos);
+	struct trace_array *tr = m->private;
+
+	return seq_list_next(v, &tr->err_log, pos);
 }
 
 static void tracing_err_log_seq_stop(struct seq_file *m, void *v)
@@ -7067,15 +7073,25 @@ static const struct seq_operations tracing_err_log_seq_ops = {
 
 static int tracing_err_log_open(struct inode *inode, struct file *file)
 {
+	struct trace_array *tr = inode->i_private;
 	int ret = 0;
 
+	if (trace_array_get(tr) < 0)
+		return -ENODEV;
+
 	/* If this file was opened for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
-		clear_tracing_err_log();
+		clear_tracing_err_log(tr);
 
-	if (file->f_mode & FMODE_READ)
+	if (file->f_mode & FMODE_READ) {
 		ret = seq_open(file, &tracing_err_log_seq_ops);
-
+		if (!ret) {
+			struct seq_file *m = file->private_data;
+			m->private = tr;
+		} else {
+			trace_array_put(tr);
+		}
+	}
 	return ret;
 }
 
@@ -7091,6 +7107,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
+	.release	= tracing_release_generic_tr,
 };
 
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
@@ -8293,6 +8310,7 @@ struct trace_array *trace_array_create(const char *name)
 	INIT_LIST_HEAD(&tr->systems);
 	INIT_LIST_HEAD(&tr->events);
 	INIT_LIST_HEAD(&tr->hist_vars);
+	INIT_LIST_HEAD(&tr->err_log);
 
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
@@ -9087,6 +9105,7 @@ __init static int tracer_alloc_buffers(void)
 	INIT_LIST_HEAD(&global_trace.systems);
 	INIT_LIST_HEAD(&global_trace.events);
 	INIT_LIST_HEAD(&global_trace.hist_vars);
+	INIT_LIST_HEAD(&global_trace.err_log);
 	list_add(&global_trace.list, &ftrace_trace_arrays);
 
 	apply_trace_boot_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 809c5d7f0064..da00a3d508c1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -293,11 +293,13 @@ struct trace_array {
 	int			nr_topts;
 	bool			clear_trace;
 	int			buffer_percent;
+	unsigned int		n_err_log_entries;
 	struct tracer		*current_trace;
 	unsigned int		trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
+	struct list_head	err_log;
 	struct dentry		*dir;
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
@@ -1886,7 +1888,8 @@ extern ssize_t trace_parse_run_command(struct file *file,
 		int (*createfn)(int, char**));
 
 extern unsigned int err_pos(char *cmd, const char *str);
-extern void tracing_log_err(const char *loc, const char *cmd,
+extern void tracing_log_err(struct trace_array *tr,
+			    const char *loc, const char *cmd,
 			    const char **errs, u8 type, u8 pos);
 
 /*
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b1033638e499..d07bfa5c0ee5 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -949,12 +949,12 @@ static void append_filter_err(struct trace_array *tr,
 	if (pe->lasterr > 0) {
 		trace_seq_printf(s, "\n%*s", pos, "^");
 		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
-		tracing_log_err("event filter parse error",
+		tracing_log_err(tr, "event filter parse error",
 				filter->filter_string, err_text,
 				pe->lasterr, pe->lasterr_pos);
 	} else {
 		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
-		tracing_log_err("event filter parse error",
+		tracing_log_err(tr, "event filter parse error",
 				filter->filter_string, err_text,
 				FILT_ERR_ERRNO, 0);
 	}
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 49d373792721..a07a5b6ebd98 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -621,7 +621,8 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 
 static void hist_err(struct trace_array *tr, u8 err_type, u8 err_pos)
 {
-	tracing_log_err(last_cmd_loc, last_cmd, err_text, err_type, err_pos);
+	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
+			err_type, err_pos);
 }
 
 static void hist_err_clear(void)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e11f98c49d72..4cc2d467d34c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -186,7 +186,7 @@ void __trace_probe_log_err(int offset, int err_type)
 	}
 	*(p - 1) = '\0';
 
-	tracing_log_err(trace_probe_log.subsystem, command,
+	tracing_log_err(NULL, trace_probe_log.subsystem, command,
 			trace_probe_err_text, err_type, pos + offset);
 
 	kfree(command);
-- 
2.20.1


