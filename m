Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2BC33CB7
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62A42082E
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580507747;
	bh=2AGhUndaX9fzi5WMTVZAK/May452/IR0lTOmVJsL+4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=JC3kpCxz72nnGIXRReItvXA5ZNPTWeRPWFFUTACDHTl7CupIXVKZIbXWBS17d6iVF
	 WWZ7qh1sTjW+cjCCNTg+KbeEhJcveNNtekykNPUbPiOR382l91CUZEEq+/aS6HfzXf
	 viukqCVW2h5Avx3TYdP/ehTqfGSCBo362snfBSqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAaVzp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgAaVzo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:44 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A18215A4;
        Fri, 31 Jan 2020 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580507743;
        bh=2AGhUndaX9fzi5WMTVZAK/May452/IR0lTOmVJsL+4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Tgz7k5LLsE4815kXoBFWmjal/rhbxQkMpEfbUS4hyxh/U7tfxBcWQ20zWlq4OZVS7
         XoXGB06KfuwsMnjyVvsZJOYZVlIDlTHl8pjQEDj+gwze3oLMXqbgE4QWUFFNKJhCMI
         4VrtIe/xoLSYOc/eGthN8DeW7dUsSq53T5qWXVV8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 2/4] tracing: Remove check_arg() callbacks from dynevent args
Date:   Fri, 31 Jan 2020 15:55:32 -0600
Message-Id: <c7708d6f177fcbe1a36b6e4e8e150907df0fa5d2.1580506712.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It's kind of strange to have check_arg() callbacks as part of the arg
objects themselves; it makes more sense to just pass these in when the
args are added instead.

Remove the check_arg() callbacks from those objects which also means
removing the check_arg() args from the init functions, adding them to
the add functions and fixing up existing callers.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_dynevent.c    | 62 ++++++++++++++++++----------------------
 kernel/trace/trace_dynevent.h    | 11 ++++---
 kernel/trace/trace_events_hist.c | 16 +++++------
 kernel/trace/trace_kprobe.c      | 10 +++----
 4 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 6ffdbc4fda53..f9cfcdc9d1f3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -228,27 +228,30 @@ fs_initcall(init_dynamic_event);
  * dynevent_arg_add - Add an arg to a dynevent_cmd
  * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
  * @arg: The argument to append to the current cmd
+ * @check_arg: An (optional) pointer to a function checking arg sanity
  *
  * Append an argument to a dynevent_cmd.  The argument string will be
  * appended to the current cmd string, followed by a separator, if
- * applicable.  Before the argument is added, the check_arg()
- * function, if defined, is called.
+ * applicable.  Before the argument is added, the @check_arg function,
+ * if present, will be used to check the sanity of the current arg
+ * string.
  *
- * The cmd string, separator, and check_arg() function should be set
- * using the dynevent_arg_init() before any arguments are added using
- * this function.
+ * The cmd string and separator should be set using the
+ * dynevent_arg_init() before any arguments are added using this
+ * function.
  *
  * Return: 0 if successful, error otherwise.
  */
 int dynevent_arg_add(struct dynevent_cmd *cmd,
-		     struct dynevent_arg *arg)
+		     struct dynevent_arg *arg,
+		     dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
 	int delta;
 	char *q;
 
-	if (arg->check_arg) {
-		ret = arg->check_arg(arg);
+	if (check_arg) {
+		ret = check_arg(arg);
 		if (ret)
 			return ret;
 	}
@@ -269,6 +272,7 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
  * dynevent_arg_pair_add - Add an arg pair to a dynevent_cmd
  * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
  * @arg_pair: The argument pair to append to the current cmd
+ * @check_arg: An (optional) pointer to a function checking arg sanity
  *
  * Append an argument pair to a dynevent_cmd.  An argument pair
  * consists of a left-hand-side argument and a right-hand-side
@@ -278,24 +282,26 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
  *
  * The lhs argument string will be appended to the current cmd string,
  * followed by an operator, if applicable, followd by the rhs string,
- * followed finally by a separator, if applicable.  Before anything is
- * added, the check_arg() function, if defined, is called.
+ * followed finally by a separator, if applicable.  Before the
+ * argument is added, the @check_arg function, if present, will be
+ * used to check the sanity of the current arg strings.
  *
- * The cmd strings, operator, separator, and check_arg() function
- * should be set using the dynevent_arg_pair_init() before any arguments
- * are added using this function.
+ * The cmd strings, operator, and separator should be set using the
+ * dynevent_arg_pair_init() before any arguments are added using this
+ * function.
  *
  * Return: 0 if successful, error otherwise.
  */
 int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
-			  struct dynevent_arg_pair *arg_pair)
+			  struct dynevent_arg_pair *arg_pair,
+			  dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
 	int delta;
 	char *q;
 
-	if (arg_pair->check_arg) {
-		ret = arg_pair->check_arg(arg_pair);
+	if (check_arg) {
+		ret = check_arg(arg_pair);
 		if (ret)
 			return ret;
 	}
@@ -385,20 +391,16 @@ void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
 /**
  * dynevent_arg_init - Initialize a dynevent_arg object
  * @arg: A pointer to the dynevent_arg struct representing the arg
- * @check_arg: An (optional) pointer to a function checking arg sanity
  * @separator: An (optional) separator, appended after adding the arg
  *
  * Initialize a dynevent_arg object.  A dynevent_arg represents an
  * object used to append single arguments to the current command
- * string.  The @check_arg function, if present, will be used to check
- * the sanity of the current arg string (which is directly set by the
- * caller).  After the arg string is successfully appended to the
+ * string.  After the arg string is successfully appended to the
  * command string, the optional @separator is appended.  If no
  * separator was specified when initializing the arg, a space will be
  * appended.
  */
 void dynevent_arg_init(struct dynevent_arg *arg,
-		       dynevent_check_arg_fn_t check_arg,
 		       char separator)
 {
 	memset(arg, '\0', sizeof(*arg));
@@ -406,14 +408,11 @@ void dynevent_arg_init(struct dynevent_arg *arg,
 	if (!separator)
 		separator = ' ';
 	arg->separator = separator;
-
-	arg->check_arg = check_arg;
 }
 
 /**
  * dynevent_arg_pair_init - Initialize a dynevent_arg_pair object
  * @arg_pair: A pointer to the dynevent_arg_pair struct representing the arg
- * @check_arg: An (optional) pointer to a function checking arg sanity
  * @operator: An (optional) operator, appended after adding the first arg
  * @separator: An (optional) separator, appended after adding the second arg
  *
@@ -422,16 +421,13 @@ void dynevent_arg_init(struct dynevent_arg *arg,
  * variable_name;' or 'x+y' to the current command string.  An
  * argument pair consists of a left-hand-side argument and a
  * right-hand-side argument separated by an operator, which can be
- * whitespace, all followed by a separator, if applicable. The
- * @check_arg function, if present, will be used to check the sanity
- * of the current arg strings (which is directly set by the caller).
- * After the first arg string is successfully appended to the command
- * string, the optional @operator is appended, followed by the second
- * arg and and optional @separator.  If no separator was specified
- * when initializing the arg, a space will be appended.
+ * whitespace, all followed by a separator, if applicable.  After the
+ * first arg string is successfully appended to the command string,
+ * the optional @operator is appended, followed by the second arg and
+ * and optional @separator.  If no separator was specified when
+ * initializing the arg, a space will be appended.
  */
 void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
-			    dynevent_check_arg_fn_t check_arg,
 			    char operator, char separator)
 {
 	memset(arg_pair, '\0', sizeof(*arg_pair));
@@ -443,8 +439,6 @@ void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
 	if (!separator)
 		separator = ' ';
 	arg_pair->separator = separator;
-
-	arg_pair->check_arg = check_arg;
 }
 
 /**
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index b593fc34c5b1..d6857a254ede 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -126,28 +126,27 @@ typedef int (*dynevent_check_arg_fn_t)(void *data);
 struct dynevent_arg {
 	const char		*str;
 	char			separator; /* e.g. ';', ',', or nothing */
-	dynevent_check_arg_fn_t	check_arg;
 };
 
 extern void dynevent_arg_init(struct dynevent_arg *arg,
-			      dynevent_check_arg_fn_t check_arg,
 			      char separator);
 extern int dynevent_arg_add(struct dynevent_cmd *cmd,
-			    struct dynevent_arg *arg);
+			    struct dynevent_arg *arg,
+			    dynevent_check_arg_fn_t check_arg);
 
 struct dynevent_arg_pair {
 	const char		*lhs;
 	const char		*rhs;
 	char			operator; /* e.g. '=' or nothing */
 	char			separator; /* e.g. ';', ',', or nothing */
-	dynevent_check_arg_fn_t	check_arg;
 };
 
 extern void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
-				   dynevent_check_arg_fn_t check_arg,
 				   char operator, char separator);
+
 extern int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
-				 struct dynevent_arg_pair *arg_pair);
+				 struct dynevent_arg_pair *arg_pair,
+				 dynevent_check_arg_fn_t check_arg);
 extern int dynevent_str_add(struct dynevent_cmd *cmd, const char *str);
 
 #endif
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 772bd3d7c29f..a566f5d290c1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1334,12 +1334,12 @@ int synth_event_add_field(struct dynevent_cmd *cmd, const char *type,
 	if (!type || !name)
 		return -EINVAL;
 
-	dynevent_arg_pair_init(&arg_pair, synth_event_check_arg_fn, 0, ';');
+	dynevent_arg_pair_init(&arg_pair, 0, ';');
 
 	arg_pair.lhs = type;
 	arg_pair.rhs = name;
 
-	ret = dynevent_arg_pair_add(cmd, &arg_pair);
+	ret = dynevent_arg_pair_add(cmd, &arg_pair, synth_event_check_arg_fn);
 	if (ret)
 		return ret;
 
@@ -1377,11 +1377,11 @@ int synth_event_add_field_str(struct dynevent_cmd *cmd, const char *type_name)
 	if (!type_name)
 		return -EINVAL;
 
-	dynevent_arg_init(&arg, NULL, ';');
+	dynevent_arg_init(&arg, ';');
 
 	arg.str = type_name;
 
-	ret = dynevent_arg_add(cmd, &arg);
+	ret = dynevent_arg_add(cmd, &arg, NULL);
 	if (ret)
 		return ret;
 
@@ -1472,9 +1472,9 @@ int __synth_event_gen_cmd_start(struct dynevent_cmd *cmd, const char *name,
 	if (cmd->type != DYNEVENT_TYPE_SYNTH)
 		return -EINVAL;
 
-	dynevent_arg_init(&arg, NULL, 0);
+	dynevent_arg_init(&arg, 0);
 	arg.str = name;
-	ret = dynevent_arg_add(cmd, &arg);
+	ret = dynevent_arg_add(cmd, &arg, NULL);
 	if (ret)
 		return ret;
 
@@ -1546,9 +1546,9 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
 	if (n_fields > SYNTH_FIELDS_MAX)
 		return -EINVAL;
 
-	dynevent_arg_init(&arg, NULL, 0);
+	dynevent_arg_init(&arg, 0);
 	arg.str = name;
-	ret = dynevent_arg_add(cmd, &arg);
+	ret = dynevent_arg_add(cmd, &arg, NULL);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 307abb724a71..fe183d4045d2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -962,9 +962,9 @@ int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
 	if (ret)
 		return ret;
 
-	dynevent_arg_init(&arg, NULL, 0);
+	dynevent_arg_init(&arg, 0);
 	arg.str = loc;
-	ret = dynevent_arg_add(cmd, &arg);
+	ret = dynevent_arg_add(cmd, &arg, NULL);
 	if (ret)
 		return ret;
 
@@ -982,7 +982,7 @@ int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
 		}
 
 		arg.str = field;
-		ret = dynevent_arg_add(cmd, &arg);
+		ret = dynevent_arg_add(cmd, &arg, NULL);
 		if (ret)
 			break;
 	}
@@ -1017,7 +1017,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
 
-	dynevent_arg_init(&arg, NULL, 0);
+	dynevent_arg_init(&arg, 0);
 
 	va_start(args, cmd);
 	for (;;) {
@@ -1033,7 +1033,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
 		}
 
 		arg.str = field;
-		ret = dynevent_arg_add(cmd, &arg);
+		ret = dynevent_arg_add(cmd, &arg, NULL);
 		if (ret)
 			break;
 	}
-- 
2.14.1

