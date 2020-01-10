Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E2C282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC6205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688571;
	bh=2M0l6EcrOoNApQmmv0kHCU9iidXjUeHWt1V2uU528uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=t+AQ4RdlM+xDVrMQgk51I+jH9Tc9LH2KIGXLICkWcVQj13mkGnX7ZkmhrVEnHarmS
	 vo/m8I5nFyvMBGYtVyHWDVXE1ibITsLUVhtxKDSz7OpFb+ISmrdE8vTrjD6CwAYhSa
	 Ia8ILS6tT+H1MyrCHrpc+VgN3gbyVY3NsmpzfX9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgAJUgF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgAJUfg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:36 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DFF2087F;
        Fri, 10 Jan 2020 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688534;
        bh=2M0l6EcrOoNApQmmv0kHCU9iidXjUeHWt1V2uU528uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=2auCeUb4lNV1IttwH1hDGPoBGrjs0Y0DzzoohzAj7krq6pE+/EvtzL1Vc7utwqqn9
         sXER3svmGqFfjNlrjqXD99IFUpz2U2itzFIxrXXzprzemusj3oUKA9eLB63ws2JSpE
         NchVX+yWOHOsnEr3jvrAppXqliXwo+erinfjSSL0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 06/12] tracing: Add synthetic event command generation functions
Date:   Fri, 10 Jan 2020 14:35:12 -0600
Message-Id: <c731007e4b528f8bcd40d2864979597bd5d91183.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add functions used to generate synthetic event commands, built on top
of the dynevent_cmd interface.

gen_synth_cmd() is used to create a synthetic event command using a
variable arg list and gen_synth_cmd_array() does the same thing but
using an array of field descriptors.  add_synth_field() and
add_synth_fields() can be used to add single fields one by one or as a
group.  Once all desired fields are added, create_dynevent() is used
to actually execute the command and create the event.

create_synth_event() does everything, including creating the event, in
a single call.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  30 ++++
 kernel/trace/trace_events_hist.c | 325 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 352 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index bf4cc2e56125..4228407d4736 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -409,6 +409,36 @@ extern int create_dynevent(struct dynevent_cmd *cmd);
 
 extern int delete_synth_event(const char *name);
 
+extern void synth_dynevent_cmd_init(struct dynevent_cmd *cmd,
+				    char *buf, int maxlen);
+
+extern int __gen_synth_cmd(struct dynevent_cmd *cmd, const char *name,
+			   struct module *mod, ...);
+
+#define gen_synth_cmd(cmd, name, mod, ...)	\
+	__gen_synth_cmd(cmd, name, mod, ## __VA_ARGS__, NULL)
+
+struct synth_field_desc {
+	const char *type;
+	const char *name;
+};
+
+extern int gen_synth_cmd_array(struct dynevent_cmd *cmd, const char *name,
+			       struct module *mod,
+			       struct synth_field_desc *fields,
+			       unsigned int n_fields);
+extern int create_synth_event(const char *name,
+			      struct synth_field_desc *fields,
+			      unsigned int n_fields, struct module *mod);
+
+
+extern int add_synth_field(struct dynevent_cmd *cmd,
+			   const char *type,
+			   const char *name);
+extern int add_synth_fields(struct dynevent_cmd *cmd,
+			    struct synth_field_desc *fields,
+			    unsigned int n_fields);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0886ca6da255..7cf6ba0631c6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -407,6 +407,7 @@ struct synth_event {
 	struct trace_event_class		class;
 	struct trace_event_call			call;
 	struct tracepoint			*tp;
+	struct module				*mod;
 };
 
 static bool is_synth_event(struct dyn_event *ev)
@@ -1267,6 +1268,227 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
+static int dynevent_synth_check_arg_fn(void *data)
+{
+	struct dynevent_arg_pair *arg_pair = data;
+	int size;
+
+	size = synth_field_size((char *)arg_pair->lhs);
+
+	return size ? 0 : -EINVAL;
+}
+
+/**
+ * add_synth_field - Add a new field to a synthetic event cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @type: The type of the new field to add
+ * @name: The name of the new field to add
+ *
+ * Add a new field to a synthetic event cmd object.  Field ordering is in
+ * the same order the fields are added.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int add_synth_field(struct dynevent_cmd *cmd, const char *type,
+		    const char *name)
+{
+	struct dynevent_arg_pair arg_pair;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_SYNTH)
+		return -EINVAL;
+
+	if (!type || !name)
+		return -EINVAL;
+
+	dynevent_arg_pair_init(&arg_pair, dynevent_synth_check_arg_fn, 0, ';');
+
+	arg_pair.lhs = type;
+	arg_pair.rhs = name;
+
+	ret = add_dynevent_arg_pair(cmd, &arg_pair);
+	if (ret)
+		return ret;
+
+	if (++cmd->n_fields > SYNTH_FIELDS_MAX)
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_synth_field);
+
+/**
+ * add_synth_fields - Add multiple fields to a synthetic event cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @fields: An array of type/name field descriptions
+ * @n_fields: The number of field descriptions contained in the fields array
+ *
+ * Add a new set of fields to a synthetic event cmd object.  The event
+ * fields that will be defined for the event should be passed in as an
+ * array of struct synth_field_desc, and the number of elements in the
+ * array passed in as n_fields.  Field ordering will retain the
+ * ordering given in the fields array.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int add_synth_fields(struct dynevent_cmd *cmd,
+		     struct synth_field_desc *fields, unsigned int n_fields)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < n_fields; i++) {
+		if (fields[i].type == NULL || fields[i].name == NULL) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = add_synth_field(cmd, fields[i].type, fields[i].name);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_synth_fields);
+
+/**
+ * __gen_synth_cmd - Generate a synthetic event command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the synthetic event
+ * @mod: The module creating the event, NULL if not created from a module
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the gen_synth_cmd() wrapper, which automatically adds a
+ * NULL to the end of the arg list.  If this function is used
+ * directly, make suer he last arg in the variable arg list is NULL.
+ *
+ * Generate a synthetic event command to be executed by
+ * create_dynevent().  This function can be used to generate the
+ * complete command or only the first part of it; in the latter case,
+ * add_synth_field() or add_synth_fields() can be used to add more
+ * fields following this.
+ *
+ * There should be an even number variable args, each pair consisting
+ * of a type followed by a field name.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __gen_synth_cmd(struct dynevent_cmd *cmd, const char *name,
+		    struct module *mod, ...)
+{
+	struct dynevent_arg arg;
+	va_list args;
+	int ret;
+
+	cmd->event_name = name;
+	cmd->private_data = mod;
+
+	if (cmd->type != DYNEVENT_TYPE_SYNTH)
+		return -EINVAL;
+
+	dynevent_arg_init(&arg, NULL, 0);
+	arg.str = name;
+	ret = add_dynevent_arg(cmd, &arg);
+	if (ret)
+		return ret;
+
+	va_start(args, mod);
+	for (;;) {
+		const char *type, *name;
+
+		type = va_arg(args, const char *);
+		if (!type)
+			break;
+		name = va_arg(args, const char *);
+		if (!name)
+			break;
+
+		if (++cmd->n_fields > SYNTH_FIELDS_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = add_synth_field(cmd, type, name);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__gen_synth_cmd);
+
+/**
+ * gen_synth_cmd_array - Generate a synthetic event command from an array
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the synthetic event
+ * @fields: An array of type/name field descriptions
+ * @n_fields: The number of field descriptions contained in the fields array
+ *
+ * Generate a synthetic event command to be executed by
+ * create_dynevent().  This function can be used to generate the
+ * complete command or only the first part of it; in the latter case,
+ * add_synth_field() or add_synth_fields() can be used to add more
+ * fields following this.
+ *
+ * The event fields that will be defined for the event should be
+ * passed in as an array of struct synth_field_desc, and the number of
+ * elements in the array passed in as n_fields.  Field ordering will
+ * retain the ordering given in the fields array.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int gen_synth_cmd_array(struct dynevent_cmd *cmd, const char *name,
+			struct module *mod,
+			struct synth_field_desc *fields,
+			unsigned int n_fields)
+{
+	struct dynevent_arg arg;
+	unsigned int i;
+	int ret = 0;
+
+	cmd->event_name = name;
+	cmd->private_data = mod;
+
+	if (cmd->type != DYNEVENT_TYPE_SYNTH)
+		return -EINVAL;
+
+	if (n_fields > SYNTH_FIELDS_MAX)
+		return -EINVAL;
+
+	dynevent_arg_init(&arg, NULL, 0);
+	arg.str = name;
+	ret = add_dynevent_arg(cmd, &arg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < n_fields; i++) {
+		if (fields[i].type == NULL || fields[i].name == NULL)
+			return -EINVAL;
+
+		ret = add_synth_field(cmd, fields[i].type, fields[i].name);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gen_synth_cmd_array);
+
 static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
@@ -1335,6 +1557,55 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	goto out;
 }
 
+/**
+ * create_synth_event - Create a new synthetic event
+ * @name: The name of the new sythetic event
+ * @fields: An array of type/name field descriptions
+ * @n_fields: The number of field descriptions contained in the fields array
+ * @mod: The module creating the event, NULL if not created from a module
+ *
+ * Create a new synthetic event with the given name under the
+ * trace/events/synthetic/ directory.  The event fields that will be
+ * defined for the event should be passed in as an array of struct
+ * synth_field_desc, and the number elements in the array passed in as
+ * n_fields. Field ordering will retain the ordering given in the
+ * fields array.
+ *
+ * If the new synthetic event is being created from a module, the mod
+ * param must be non-NULL.  This will ensure that the trace buffer
+ * won't contain unreadable events.
+ *
+ * The new synth event should be deleted using delete_synth_event()
+ * function.  The new synthetic event can be generated from modules or
+ * other kernel code using trace_synth_event() and related functions.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int create_synth_event(const char *name, struct synth_field_desc *fields,
+		       unsigned int n_fields, struct module *mod)
+{
+	struct dynevent_cmd cmd;
+	char *buf;
+	int ret;
+
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	synth_dynevent_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	ret = gen_synth_cmd_array(&cmd, name, mod, fields, n_fields);
+	if (ret)
+		goto out;
+
+	ret = create_dynevent(&cmd);
+ out:
+	kfree(buf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(create_synth_event);
+
 static int destroy_synth_event(struct synth_event *se)
 {
 	int ret;
@@ -1363,14 +1634,33 @@ static int destroy_synth_event(struct synth_event *se)
 int delete_synth_event(const char *event_name)
 {
 	struct synth_event *se = NULL;
+	struct module *mod = NULL;
 	int ret = -ENOENT;
 
 	mutex_lock(&event_mutex);
 	se = find_synth_event(event_name);
-	if (se)
+	if (se) {
+		mod = se->mod;
 		ret = destroy_synth_event(se);
+	}
 	mutex_unlock(&event_mutex);
 
+	if (mod) {
+		mutex_lock(&trace_types_lock);
+		/*
+		 * It is safest to reset the ring buffer if the module
+		 * being unloaded registered any events that were
+		 * used. The only worry is if a new module gets
+		 * loaded, and takes on the same id as the events of
+		 * this module. When printing out the buffer, traced
+		 * events left over from this module may be passed to
+		 * the new module events and unexpected results may
+		 * occur.
+		 */
+		tracing_reset_all_online_cpus();
+		mutex_unlock(&trace_types_lock);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(delete_synth_event);
@@ -1390,10 +1680,39 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int synth_event_run_command(const char *command)
+static int synth_event_run_command(struct dynevent_cmd *cmd)
+{
+	struct synth_event *se;
+	int ret;
+
+	ret = trace_run_command(cmd->buf, create_or_delete_synth_event);
+	if (ret)
+		return ret;
+
+	se = find_synth_event(cmd->event_name);
+	if (WARN_ON(!se))
+		return -ENOENT;
+
+	se->mod = cmd->private_data;
+
+	return ret;
+}
+
+/**
+ * synth_dynevent_cmd_init - Initialize a synthetic event command object
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @buf: A pointer to the buffer used to build the command
+ * @maxlen: The length of the buffer passed in @buf
+ *
+ * Initialize a synthetic event command object.  Use this before
+ * calling any of the other dyenvent_cmd functions.
+ */
+void synth_dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
-	return trace_run_command(command, create_or_delete_synth_event);
+	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
+			  synth_event_run_command);
 }
+EXPORT_SYMBOL_GPL(synth_dynevent_cmd_init);
 
 static int synth_event_create(int argc, const char **argv)
 {
-- 
2.14.1

