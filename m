Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861BC43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6920879
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076178;
	bh=JXo4ObwjljV5NrC88guHjKdgt714JeGEtSEfMQmwCfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=xnbwlQ7Fequnz/sK6E2o7Q3bk7MFbR9F5hd/ZT5/qeW6Pi3EmunI+pdEG09NNPARX
	 KTl2qmR1XEjkXaIsKya6g7RV8MQ2CX6/l0yqJwqC2s5Q0M7PodmCfSokq1yRk/HoCd
	 sDUAo9fvKjyylDKeJqTLdU/w8AD/JomQ6b5ZJMBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfCaXsh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbfCaXse (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:34 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17B2520870;
        Sun, 31 Mar 2019 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076112;
        bh=JXo4ObwjljV5NrC88guHjKdgt714JeGEtSEfMQmwCfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LxXsNNUlq8XmbyfFheC3pEgtX4Px0mo3FgQIK4pnI6fTdWpdaBVoa7ZJMjpi8yR3U
         QhHwAJCItAqoQYk3fC6Auo+2wLYTxZdZNEFsM6mracJ2l5fJ33G14t3ext2YK67nzx
         drXakUnuYHCJRTNFt7Wg8/AMyY01qLwKP64YzOz8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 01/11] tracing: Add tracing error log
Date:   Sun, 31 Mar 2019 18:48:15 -0500
Message-Id: <0c2c82571fd38c5f3a88ca823627edff250e9416.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Introduce a new ftrace file, tracing/error_log, for ftrace commands to
log errors.  This is useful for allowing more complex commands such as
hist trigger and kprobe_event commands to point out specifically where
something may have gone wrong without forcing them to resort to more
ad hoc methods such as tacking error messages onto existing output
files.

To log a tracing error, call the event_log_err() function, passing it
a location string describing where it came from e.g. kprobe_events or
system:event, the command that caused the error, an array of static
error strings describing errors and an index within that array which
describes the specific error, along with the position to place the
error caret.

Reading the log displays the last (currently) 8 errors logged in the
following format:

  [timestamp] <loc>: error: <static error text>
    Command: <command that caused the error>
                      ^

Memory for the error log isn't allocated unless there has been a trace
event error, and the error log can be cleared and have its memory
freed by writing the empty string in truncation mode to it:

  # echo > tracing/error_log.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Improvements-suggested-by: Steve Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace.c | 218 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h |   4 +
 2 files changed, 222 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 21153e64bf1c..f9f9e7e2f0d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6876,6 +6876,221 @@ static const struct file_operations snapshot_raw_fops = {
 
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
+#define TRACING_LOG_ERRS_MAX	8
+#define TRACING_LOG_LOC_MAX	128
+
+#define CMD_PREFIX "  Command: "
+
+struct err_info {
+	const char	**errs;	/* ptr to loc-specific array of err strings */
+	u8		type;	/* index into errs -> specific err string */
+	u8		pos;	/* MAX_FILTER_STR_VAL = 256 */
+	u64		ts;
+};
+
+struct tracing_log_err {
+	struct list_head	list;
+	struct err_info		info;
+	char			loc[TRACING_LOG_LOC_MAX]; /* err location */
+	char			cmd[MAX_FILTER_STR_VAL]; /* what caused err */
+};
+
+static LIST_HEAD(tracing_err_log);
+static DEFINE_MUTEX(tracing_err_log_lock);
+
+static unsigned int n_tracing_err_log_entries;
+
+struct tracing_log_err *get_tracing_log_err(void)
+{
+	struct tracing_log_err *err;
+
+	if (n_tracing_err_log_entries < TRACING_LOG_ERRS_MAX) {
+		err = kzalloc(sizeof(*err), GFP_KERNEL);
+		if (!err)
+			err = ERR_PTR(-ENOMEM);
+		n_tracing_err_log_entries++;
+
+		return err;
+	}
+
+	err = list_first_entry(&tracing_err_log, struct tracing_log_err, list);
+	list_del(&err->list);
+
+	return err;
+}
+
+/**
+ * err_pos - find the position of a string within a command for error careting
+ * @cmd: The tracing command that caused the error
+ * @str: The string to position the caret at within @cmd
+ *
+ * Finds the position of the first occurence of @str within @cmd.  The
+ * return value can be passed to tracing_log_err() for caret placement
+ * within @cmd.
+ *
+ * Returns the index within @cmd of the first occurence of @str or 0
+ * if @str was not found.
+ */
+unsigned int err_pos(char *cmd, const char *str)
+{
+	char *found;
+
+	if (WARN_ON(!strlen(cmd)))
+		return 0;
+
+	found = strstr(cmd, str);
+	if (found)
+		return found - cmd;
+
+	return 0;
+}
+
+/**
+ * tracing_log_err - write an error to the tracing error log
+ * @loc: A string describing where the error occurred
+ * @cmd: The tracing command that caused the error
+ * @errs: The array of loc-specific static error strings
+ * @type: The index into errs[], which produces the specific static err string
+ * @pos: The position the caret should be placed in the cmd
+ *
+ * Writes an error into tracing/error_log of the form:
+ *
+ * <loc>: error: <text>
+ *   Command: <cmd>
+ *              ^
+ *
+ * tracing/error_log is a small log file containing the last
+ * TRACING_LOG_ERRS_MAX errors (8).  Memory for errors isn't allocated
+ * unless there has been a tracing error, and the error log can be
+ * cleared and have its memory freed by writing the empty string in
+ * truncation mode to it i.e. echo > tracing/error_log.
+ *
+ * NOTE: the @errs array along with the @type param are used to
+ * produce a static error string - this string is not copied and saved
+ * when the error is logged - only a pointer to it is saved.  See
+ * existing callers for examples of how static strings are typically
+ * defined for use with tracing_log_err().
+ */
+void tracing_log_err(const char *loc, const char *cmd,
+		     const char **errs, u8 type, u8 pos)
+{
+	struct tracing_log_err *err;
+
+	mutex_lock(&tracing_err_log_lock);
+	err = get_tracing_log_err();
+	if (PTR_ERR(err) == -ENOMEM) {
+		mutex_unlock(&tracing_err_log_lock);
+		return;
+	}
+
+	snprintf(err->loc, TRACING_LOG_LOC_MAX, "%s: error: ", loc);
+	snprintf(err->cmd, MAX_FILTER_STR_VAL,"\n" CMD_PREFIX "%s\n", cmd);
+
+	err->info.errs = errs;
+	err->info.type = type;
+	err->info.pos = pos;
+	err->info.ts = local_clock();
+
+	list_add_tail(&err->list, &tracing_err_log);
+	mutex_unlock(&tracing_err_log_lock);
+}
+
+static void clear_tracing_err_log(void)
+{
+	struct tracing_log_err *err, *next;
+
+	mutex_lock(&tracing_err_log_lock);
+	list_for_each_entry_safe(err, next, &tracing_err_log, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+
+	n_tracing_err_log_entries = 0;
+	mutex_unlock(&tracing_err_log_lock);
+}
+
+static void *tracing_err_log_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&tracing_err_log_lock);
+
+	return seq_list_start(&tracing_err_log, *pos);
+}
+
+static void *tracing_err_log_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &tracing_err_log, pos);
+}
+
+static void tracing_err_log_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&tracing_err_log_lock);
+}
+
+static void tracing_err_log_show_pos(struct seq_file *m, u8 pos)
+{
+	u8 i;
+
+	for (i = 0; i < sizeof(CMD_PREFIX) - 1; i++)
+		seq_putc(m, ' ');
+	for (i = 0; i < pos; i++)
+		seq_putc(m, ' ');
+	seq_puts(m, "^\n");
+}
+
+static int tracing_err_log_seq_show(struct seq_file *m, void *v)
+{
+	struct tracing_log_err *err = v;
+
+	if (err) {
+		const char *err_text = err->info.errs[err->info.type];
+		u64 sec = err->info.ts;
+		u32 nsec;
+
+		nsec = do_div(sec, NSEC_PER_SEC);
+		seq_printf(m, "[%5llu.%06u] %s%s", sec, nsec / 1000,
+			   err->loc, err_text);
+		seq_printf(m, "%s", err->cmd);
+		tracing_err_log_show_pos(m, err->info.pos);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tracing_err_log_seq_ops = {
+	.start  = tracing_err_log_seq_start,
+	.next   = tracing_err_log_seq_next,
+	.stop   = tracing_err_log_seq_stop,
+	.show   = tracing_err_log_seq_show
+};
+
+static int tracing_err_log_open(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+
+	/* If this file was opened for write, then erase contents */
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
+		clear_tracing_err_log();
+
+	if (file->f_mode & FMODE_READ)
+		ret = seq_open(file, &tracing_err_log_seq_ops);
+
+	return ret;
+}
+
+static ssize_t tracing_err_log_write(struct file *file,
+				     const char __user *buffer,
+				     size_t count, loff_t *ppos)
+{
+	return count;
+}
+
+static const struct file_operations tracing_err_log_fops = {
+	.open           = tracing_err_log_open,
+	.write		= tracing_err_log_write,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+};
+
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
@@ -8258,6 +8473,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 			  tr, &snapshot_fops);
 #endif
 
+	trace_create_file("error_log", 0644, d_tracer,
+			  tr, &tracing_err_log_fops);
+
 	for_each_tracing_cpu(cpu)
 		tracing_init_tracefs_percpu(tr, cpu);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..b711edbef7e7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1884,6 +1884,10 @@ extern ssize_t trace_parse_run_command(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
 		int (*createfn)(int, char**));
 
+extern unsigned int err_pos(char *cmd, const char *str);
+extern void tracing_log_err(const char *loc, const char *cmd,
+			    const char **errs, u8 type, u8 pos);
+
 /*
  * Normal trace_printk() and friends allocates special buffers
  * to do the manipulation, as well as saves the print formats
-- 
2.14.1

