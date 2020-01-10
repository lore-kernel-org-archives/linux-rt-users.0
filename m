Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39EC282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2C420882
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688535;
	bh=xKSXu/DgrgAngVtOCSfaBQaKiNx+vMEFoxwMd2Mh4WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=PFQRlU1gtWWZ9SM4yuasQiqLAg99s0jTtfwYBXLLIP69juHneMubFGuQkHj0CSizW
	 92eFBPbEDjsUdjub9Ccl/YUxxv/hCaCVwTPidisgJsgSmoShLsJlGakxVg/Pi+ZYat
	 DxEzurN+bBxz955+9DrNF/9Br+czny1uHFAoykRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAJUfe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgAJUfd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:33 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CA820848;
        Fri, 10 Jan 2020 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688532;
        bh=xKSXu/DgrgAngVtOCSfaBQaKiNx+vMEFoxwMd2Mh4WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ejzNBfWVCd7q9f3vfNi2JWpZbZ6LqsUEBi08JXRFyGrsf8C6IbUhYnjdqLwo0def0
         y8rgvIIDM05Dc3DiBl68FAerhn0I3EoXVYVKVo02oKbVJDQNd6sfa8VCP4vYGvUpQA
         rzBiQr7mVXAw+U8PaG9z3vX9IeprUNRwo9DRfaJw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 04/12] tracing: Add dynamic event command creation interface
Date:   Fri, 10 Jan 2020 14:35:10 -0600
Message-Id: <b10d5656847c54c51b1496319e0da2764e660458.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an interface used to build up dynamic event creation commands,
such as synthetic and kprobe events.  Interfaces specific to those
particular types of events and others can be built on top of this
interface.

Command creation is started by first using the dynevent_cmd_init()
function to initialize the dynevent_cmd object.  Following that, args
are appended and optionally checked by the add_dynevent_arg() and
add_dynevent_arg_pair() functions, which use objects representing
arguments and pairs of arguments, initialized respectively by
dynevent_arg_init() and dynevent_arg_pair_init().  Finally, once all
args have been successfully added, the command is finalized and
actually created using create_dynevent().

The code here for actually printing into the dyn_event->cmd buffer
using snprintf() etc was adapted from v4 of Masami's 'tracing/boot:
Add synthetic event support' patch.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/trace_events.h |  54 +++++++++++
 kernel/trace/trace_events.c  | 217 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index c8038d1a1a48..bf4cc2e56125 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -353,6 +353,60 @@ extern struct trace_event_file *get_event_file(const char *instance,
 					       const char *event);
 extern void put_event_file(struct trace_event_file *file);
 
+struct dynevent_cmd;
+
+typedef int (*dynevent_check_arg_fn_t)(void *data);
+typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
+
+struct dynevent_arg {
+	const char		*str;
+	char			separator; /* e.g. ';', ',', or nothing */
+	dynevent_check_arg_fn_t	check_arg;
+};
+
+extern void dynevent_arg_init(struct dynevent_arg *arg,
+			      dynevent_check_arg_fn_t check_arg,
+			      char separator);
+extern int add_dynevent_arg(struct dynevent_cmd *cmd,
+			    struct dynevent_arg *arg);
+
+struct dynevent_arg_pair {
+	const char		*lhs;
+	const char		*rhs;
+	char			operator; /* e.g. '=' or nothing */
+	char			separator; /* e.g. ';', ',', or nothing */
+	dynevent_check_arg_fn_t	check_arg;
+};
+
+extern void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
+				   dynevent_check_arg_fn_t check_arg,
+				   char operator, char separator);
+extern int add_dynevent_arg_pair(struct dynevent_cmd *cmd,
+				 struct dynevent_arg_pair *arg_pair);
+
+#define MAX_DYNEVENT_CMD_LEN	(2048)
+
+enum dynevent_type {
+	DYNEVENT_TYPE_SYNTH,
+	DYNEVENT_TYPE_KPROBE,
+};
+
+struct dynevent_cmd {
+	char			*buf;
+	const char		*event_name;
+	int			maxlen;
+	int			remaining;
+	unsigned int		n_fields;
+	enum dynevent_type	type;
+	dynevent_create_fn_t	run_command;
+	void			*private_data;
+};
+
+extern void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
+			      enum dynevent_type type,
+			      dynevent_create_fn_t run_command);
+extern int create_dynevent(struct dynevent_cmd *cmd);
+
 extern int delete_synth_event(const char *name);
 
 /*
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 184e10d3772d..751a2c887953 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3301,6 +3301,223 @@ void __init trace_event_init(void)
 	event_trace_enable();
 }
 
+/**
+ * add_dynevent_arg - Add an arg to a dynevent_cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
+ * @arg: The argument to append to the current cmd
+ *
+ * Append an argument to a dynevent_cmd.  The argument string will be
+ * appended to the current cmd string, followed by a separator, if
+ * applicable.  Before the argument is added, the check_arg()
+ * function, if defined, is called.
+ *
+ * The cmd string, separator, and check_arg() function should be set
+ * using the dynevent_arg_init() before any arguments are added using
+ * this function.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int add_dynevent_arg(struct dynevent_cmd *cmd,
+		     struct dynevent_arg *arg)
+{
+	int ret = 0;
+	int delta;
+	char *q;
+
+	if (arg->check_arg) {
+		ret = arg->check_arg(arg);
+		if (ret)
+			return ret;
+	}
+
+	q = cmd->buf + (cmd->maxlen - cmd->remaining);
+
+	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
+	if (delta >= cmd->remaining) {
+		pr_err("String is too long: %s\n", arg->str);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_dynevent_arg);
+
+/**
+ * add_dynevent_arg_pair - Add an arg pair to a dynevent_cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
+ * @arg_pair: The argument pair to append to the current cmd
+ *
+ * Append an argument pair to a dynevent_cmd.  An argument pair
+ * consists of a left-hand-side argument and a right-hand-side
+ * argument separated by an operator, which can be whitespace, all
+ * followed by a separator, if applicable.  This can be used to add
+ * arguments of the form 'type variable_name;' or 'x+y'.
+ *
+ * The lhs argument string will be appended to the current cmd string,
+ * followed by an operator, if applicable, followd by the rhs string,
+ * followed finally by a separator, if applicable.  Before anything is
+ * added, the check_arg() function, if defined, is called.
+ *
+ * The cmd strings, operator, separator, and check_arg() function
+ * should be set using the dynevent_arg_init() before any arguments
+ * are added using this function.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int add_dynevent_arg_pair(struct dynevent_cmd *cmd,
+			  struct dynevent_arg_pair *arg_pair)
+{
+	int ret = 0;
+	int delta;
+	char *q;
+
+	if (arg_pair->check_arg) {
+		ret = arg_pair->check_arg(arg_pair);
+		if (ret)
+			return ret;
+	}
+
+	q = cmd->buf + (cmd->maxlen - cmd->remaining);
+
+	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
+			 arg_pair->operator);
+	if (delta >= cmd->remaining) {
+		pr_err("field string is too long: %s\n", arg_pair->lhs);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta; q += delta;
+
+	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
+			 arg_pair->separator);
+	if (delta >= cmd->remaining) {
+		pr_err("field string is too long: %s\n", arg_pair->rhs);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta; q += delta;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_dynevent_arg_pair);
+
+/**
+ * dynevent_cmd_init - Initialize a dynevent_cmd object
+ * @cmd: A pointer to the dynevent_cmd struct representing the cmd
+ * @buf: A pointer to the buffer to generate the command into
+ * @maxlen: The length of the buffer the command will be generated into
+ * @type: The type of the cmd, checked against further operations
+ * @run_command: The type-specific function that will actually run the command
+ *
+ * Initialize a dynevent_cmd.  A dynevent_cmd is used to build up and
+ * run dynamic event creation commands, such as commands for creating
+ * synthetic and kprobe events.  Before calling any of the functions
+ * used to build the command, a dynevent_cmd object should be
+ * instantiated and initialized using this function.
+ *
+ * The initialization sets things up by saving a pointer to the
+ * user-supplied buffer and its length via the @buf and @maxlen
+ * params, and by saving the cmd-specific @type and @run_command
+ * params which are used to check subsequent dynevent_cmd operations
+ * and actually run the command when complete.
+ */
+void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
+		       enum dynevent_type type,
+		       dynevent_create_fn_t run_command)
+{
+	memset(cmd, '\0', sizeof(*cmd));
+
+	cmd->buf = buf;
+	cmd->maxlen = maxlen;
+	cmd->remaining = cmd->maxlen;
+	cmd->type = type;
+	cmd->run_command = run_command;
+}
+EXPORT_SYMBOL_GPL(dynevent_cmd_init);
+
+/**
+ * dynevent_arg_init - Initialize a dynevent_arg object
+ * @arg: A pointer to the dynevent_arg struct representing the arg
+ * @check_arg: An (optional) pointer to a function checking arg sanity
+ * @separator: An (optional) separator, appended after adding the arg
+ *
+ * Initialize a dynevent_arg object.  A dynevent_arg represents an
+ * object used to append single arguments to the current command
+ * string.  The @check_arg function, if present, will be used to check
+ * the sanity of the current arg string (which is directly set by the
+ * caller).  After the arg string is successfully appended to the
+ * command string, the optional @separator is appended.  If no
+ * separator was specified when initializing the arg, a space will be
+ * appended.
+ */
+void dynevent_arg_init(struct dynevent_arg *arg,
+		       dynevent_check_arg_fn_t check_arg,
+		       char separator)
+{
+	memset(arg, '\0', sizeof(*arg));
+
+	if (!separator)
+		separator = ' ';
+	arg->separator = separator;
+
+	arg->check_arg = check_arg;
+}
+EXPORT_SYMBOL_GPL(dynevent_arg_init);
+
+/**
+ * dynevent_arg_pair_init - Initialize a dynevent_arg_pair object
+ * @arg_pair: A pointer to the dynevent_arg_pair struct representing the arg
+ * @check_arg: An (optional) pointer to a function checking arg sanity
+ * @operator: An (optional) operator, appended after adding the first arg
+ * @separator: An (optional) separator, appended after adding the second arg
+ *
+ * Initialize a dynevent_arg_pair object.  A dynevent_arg_pair
+ * represents an object used to append argument pairs such as 'type
+ * variable_name;' or 'x+y' to the current command string.  An
+ * argument pair consists of a left-hand-side argument and a
+ * right-hand-side argument separated by an operator, which can be
+ * whitespace, all followed by a separator, if applicable. The
+ * @check_arg function, if present, will be used to check the sanity
+ * of the current arg strings (which is directly set by the caller).
+ * After the first arg string is successfully appended to the command
+ * string, the optional @operator is appended, followed by the second
+ * arg and and optional @separator.  If no separator was specified
+ * when initializing the arg, a space will be appended.
+ */
+void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
+			    dynevent_check_arg_fn_t check_arg,
+			    char operator, char separator)
+{
+	memset(arg_pair, '\0', sizeof(*arg_pair));
+
+	if (!operator)
+		operator = ' ';
+	arg_pair->operator = operator;
+
+	if (!separator)
+		separator = ' ';
+	arg_pair->separator = separator;
+
+	arg_pair->check_arg = check_arg;
+}
+EXPORT_SYMBOL_GPL(dynevent_arg_pair_init);
+
+/**
+ * create_dynevent - Create the dynamic event contained in dynevent_cmd
+ * @cmd: The dynevent_cmd object containing the dynamic event creation command
+ *
+ * Once a dynevent_cmd object has been successfully built up via the
+ * dynevent_cmd_init(), add_dynevent_arg() and add_dynevent_arg_pair()
+ * functions, this function runs the final command to actually create
+ * the event.
+ *
+ * Return: 0 if the event was successfully created, error otherwise.
+ */
+int create_dynevent(struct dynevent_cmd *cmd)
+{
+	return cmd->run_command(cmd);
+}
+EXPORT_SYMBOL_GPL(create_dynevent);
+
 #ifdef CONFIG_EVENT_TRACE_STARTUP_TEST
 
 static DEFINE_SPINLOCK(test_spinlock);
-- 
2.14.1

