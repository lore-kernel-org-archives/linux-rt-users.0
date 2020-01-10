Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40FC282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A17205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688561;
	bh=h4xCvmR78yqL0Sj8LoPOPpDk7eVBux2tAlFTY9eqGhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=yaOnQAHRb6L8ZF07vHARHVKW/IWznPRQ3mFNUZG59mw5SixkFJPcvx64Dn0NcDlhw
	 WjF5p9XRnGdD+DB1H2M43morGTqcGLepbE7BVitu5xxOw7vMvxM/11sAmKXjV2a2VR
	 igJEWa8LhUCXxvHbJLbov8ljXZaWr+4Xjl3oNo1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgAJUfl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgAJUfk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:40 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB9D22314;
        Fri, 10 Jan 2020 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688539;
        bh=h4xCvmR78yqL0Sj8LoPOPpDk7eVBux2tAlFTY9eqGhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XXdxj1gmIpF3vOw1XCJlLzDSTuX4PCXGWkGyf/LABIUVgWMlC7+ZUHXP7R8PGY8KR
         pTTM2CrKuQoNq0pM+RtHnSn0YG+KPII/7QSK2tEtJkMMZnPVfModjsUjhsXorSefTa
         iErfc3qKHES2Hgpbda5TAJXbYcCV0HenOhscPZrA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 10/12] tracing: Add kprobe event command generation functions
Date:   Fri, 10 Jan 2020 14:35:16 -0600
Message-Id: <5f052546541d6cc5ad00e28aca6376c221db5c7e.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add functions used to generate kprobe event commands, built on top of
the dynevent_cmd interface.

gen_kprobe_cmd() is used to create a kprobe event command using a
variable arg list.  add_probe_fields() can be used to add single
fields one by one or as a group.  Once all desired fields are added,
create_dynevent() is used to actually execute the command and create
the event.

gen_kprobe_cmd() can be used to create kretprobe commands as well.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h |  18 +++++
 kernel/trace/trace_kprobe.c  | 161 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index c25b18db84eb..7ae9ad182b0e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -464,6 +464,24 @@ extern int add_synth_val(const char *field_name, u64 val,
 			 struct synth_gen_state *gen_state);
 extern int trace_synth_event_end(struct synth_gen_state *gen_state);
 
+extern void kprobe_dynevent_cmd_init(struct dynevent_cmd *cmd,
+				     char *buf, int maxlen);
+
+#define gen_kprobe_cmd(cmd, name, loc, ...)		\
+	__gen_kprobe_cmd(cmd, name, loc, false, ## __VA_ARGS__, NULL)
+
+#define gen_kretprobe_cmd(cmd, name, loc, ...)		\
+	__gen_kprobe_cmd(cmd, name, loc, true, ## __VA_ARGS__, NULL)
+
+extern int __gen_kprobe_cmd(struct dynevent_cmd *cmd, const char *name,
+			    const char *loc, bool kretprobe, ...);
+
+#define add_probe_fields(cmd, ...)	\
+	__add_probe_fields(cmd, ## __VA_ARGS__, NULL)
+
+extern int __add_probe_fields(struct dynevent_cmd *cmd, ...);
+extern int delete_kprobe_event(const char *name);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 25dac3745afb..f911b3d74b46 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -902,11 +902,168 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int trace_kprobe_run_command(const char *command)
+static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
-	return trace_run_command(command, create_or_delete_trace_kprobe);
+	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
 }
 
+/**
+ * kprobe_dynevent_cmd_init - Initialize a kprobe event command object
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @buf: A pointer to the buffer used to build the command
+ * @maxlen: The length of the buffer passed in @buf
+ *
+ * Initialize a synthetic event command object.  Use this before
+ * calling any of the other dyenvent_cmd functions.
+ */
+void kprobe_dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
+{
+	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_KPROBE,
+			  trace_kprobe_run_command);
+}
+EXPORT_SYMBOL_GPL(kprobe_dynevent_cmd_init);
+
+/**
+ * __gen_kprobe_cmd - Generate a synthetic event command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the kprobe event
+ * @loc: The location of the kprobe event
+ * @kretprobe: Is this a return probe?
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the gen_kprobe_cmd() wrapper, which automatically adds a
+ * NULL to the end of the arg list.  If this function is used
+ * directly, make suer he last arg in the variable arg list is NULL.
+ *
+ * Generate a kprobe event command to be executed by
+ * create_dynevent().  This function can be used to generate the
+ * complete command or only the first part of it; in the latter case,
+ * add_probe_fields() can be used to add more fields following this.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __gen_kprobe_cmd(struct dynevent_cmd *cmd, const char *name,
+		     const char *loc, bool kretprobe, ...)
+{
+	char buf[MAX_EVENT_NAME_LEN];
+	struct dynevent_arg arg;
+	va_list args;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_KPROBE)
+		return -EINVAL;
+
+	if (kretprobe)
+		snprintf(buf, MAX_EVENT_NAME_LEN, "r:%s", name);
+	else
+		snprintf(buf, MAX_EVENT_NAME_LEN, "p:%s", name);
+
+	dynevent_arg_init(&arg, NULL, 0);
+	arg.str = buf;
+	ret = add_dynevent_arg(cmd, &arg);
+	if (ret)
+		return ret;
+
+	dynevent_arg_init(&arg, NULL, 0);
+	arg.str = loc;
+	ret = add_dynevent_arg(cmd, &arg);
+	if (ret)
+		return ret;
+
+	va_start(args, kretprobe);
+	for (;;) {
+		const char *field;
+
+		field = va_arg(args, const char *);
+		if (!field)
+			break;
+
+		if (++cmd->n_fields > MAX_TRACE_ARGS) {
+			ret = -EINVAL;
+			break;
+		}
+
+		dynevent_arg_init(&arg, NULL, 0);
+		arg.str = field;
+		ret = add_dynevent_arg(cmd, &arg);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__gen_kprobe_cmd);
+
+/**
+ * __add_probe_fields - Add probe fields to a kprobe command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the add_probe_fields() wrapper, which automatically adds a
+ * NULL to the end of the arg list.  If this function is used
+ * directly, make suer he last arg in the variable arg list is NULL.
+ *
+ * Add probe fields to an existing kprobe command using a variable
+ * list of args.  Fields are added in the same order they're listed.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __add_probe_fields(struct dynevent_cmd *cmd, ...)
+{
+	struct dynevent_arg arg;
+	va_list args;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_KPROBE)
+		return -EINVAL;
+
+	va_start(args, cmd);
+	for (;;) {
+		const char *field;
+
+		field = va_arg(args, const char *);
+		if (!field)
+			break;
+
+		if (++cmd->n_fields > MAX_TRACE_ARGS) {
+			ret = -EINVAL;
+			break;
+		}
+
+		dynevent_arg_init(&arg, NULL, 0);
+		arg.str = field;
+		ret = add_dynevent_arg(cmd, &arg);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__add_probe_fields);
+
+/**
+ * delete_kprobe_event - Delete a kprobe event
+ * @name: The name of the kprobe event to delete
+ *
+ * Delete a kprobe event with the give @name from kernel code rather
+ * than directly from the command line.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int delete_kprobe_event(const char *name)
+{
+	char buf[MAX_EVENT_NAME_LEN];
+
+	snprintf(buf, MAX_EVENT_NAME_LEN, "-:%s", name);
+
+	return trace_run_command(buf, create_or_delete_trace_kprobe);
+}
+EXPORT_SYMBOL_GPL(delete_kprobe_event);
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
-- 
2.14.1

