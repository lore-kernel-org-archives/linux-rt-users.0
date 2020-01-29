Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF32C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A14214D8
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324388;
	bh=9x8HslRhrYX0L5Q5kEzGJBw8ZkNjvyJl79nqwmrU1Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=d3vKxycYRJksFo8yScz/krXxnYwqvhilLXLj7XnUiWdbNfBxD80iD1eoYSpmVw1d/
	 dFMHtqRhiAOKiPRY2e9Ab+GwyYFv6MX7Qmsws3e6yFD7P5e1rVG/KlFY8gC+m7Et5F
	 aQ0ylaJtS4huGF1OfxbxQdzjdy/cEwfqpZRCTzM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgA2S7s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgA2S7r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:47 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBDC20CC7;
        Wed, 29 Jan 2020 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324386;
        bh=9x8HslRhrYX0L5Q5kEzGJBw8ZkNjvyJl79nqwmrU1Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=l0C55nBEoM+MdIWgDRpbwYD6yL2pCQqV82+7XerZTeIeMUNql5jiJjki1O0V1LdHX
         Vx45fQ3paPgWocQWhLhvREeHff60NOmkGzKDSyCUbhJ/9dHAE+zpvMnKNbOyFHfZIM
         8wBvP0bnGHegz3PMbQaehDIUtsdtatYR2cqfFlQQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 05/12] tracing: Add synthetic event command generation functions
Date:   Wed, 29 Jan 2020 12:59:25 -0600
Message-Id: <38fef702fad5ef208009f459552f34a94befd860.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add functions used to generate synthetic event commands, built on top
of the dynevent_cmd interface.

synth_event_gen_cmd_start() is used to create a synthetic event
command using a variable arg list and
synth_event_gen_cmd_array_start() does the same thing but using an
array of field descriptors.  synth_event_add_field(),
synth_event_add_field_str() and synth_event_add_fields() can be used
to add single fields one by one or as a group.  Once all desired
fields are added, synth_event_gen_cmd_end() is used to actually
execute the command and create the event.

synth_event_create() does everything, including creating the event, in
a single call.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/trace_events.h     |  37 ++++
 kernel/trace/trace_events_hist.c | 379 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 412 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 651b03d5e272..07b83532a3c6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -357,6 +357,7 @@ extern void trace_put_event_file(struct trace_event_file *file);
 #define MAX_DYNEVENT_CMD_LEN	(2048)
 
 enum dynevent_type {
+	DYNEVENT_TYPE_SYNTH = 1,
 	DYNEVENT_TYPE_NONE,
 };
 
@@ -379,6 +380,42 @@ extern int dynevent_create(struct dynevent_cmd *cmd);
 
 extern int synth_event_delete(const char *name);
 
+extern void synth_event_cmd_init(struct dynevent_cmd *cmd,
+				 char *buf, int maxlen);
+
+extern int __synth_event_gen_cmd_start(struct dynevent_cmd *cmd,
+				       const char *name,
+				       struct module *mod, ...);
+
+#define synth_event_gen_cmd_start(cmd, name, mod, ...)	\
+	__synth_event_gen_cmd_start(cmd, name, mod, ## __VA_ARGS__, NULL)
+
+struct synth_field_desc {
+	const char *type;
+	const char *name;
+};
+
+extern int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd,
+					   const char *name,
+					   struct module *mod,
+					   struct synth_field_desc *fields,
+					   unsigned int n_fields);
+extern int synth_event_create(const char *name,
+			      struct synth_field_desc *fields,
+			      unsigned int n_fields, struct module *mod);
+
+extern int synth_event_add_field(struct dynevent_cmd *cmd,
+				 const char *type,
+				 const char *name);
+extern int synth_event_add_field_str(struct dynevent_cmd *cmd,
+				     const char *type_name);
+extern int synth_event_add_fields(struct dynevent_cmd *cmd,
+				  struct synth_field_desc *fields,
+				  unsigned int n_fields);
+
+#define synth_event_gen_cmd_end(cmd)	\
+	dynevent_create(cmd)
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 21e316732700..5a910bb193e9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -379,7 +379,7 @@ struct hist_trigger_data {
 	unsigned int			n_save_var_str;
 };
 
-static int synth_event_create(int argc, const char **argv);
+static int create_synth_event(int argc, const char **argv);
 static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
 static int synth_event_release(struct dyn_event *ev);
 static bool synth_event_is_busy(struct dyn_event *ev);
@@ -387,7 +387,7 @@ static bool synth_event_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev);
 
 static struct dyn_event_operations synth_event_ops = {
-	.create = synth_event_create,
+	.create = create_synth_event,
 	.show = synth_event_show,
 	.is_busy = synth_event_is_busy,
 	.free = synth_event_release,
@@ -412,6 +412,7 @@ struct synth_event {
 	struct trace_event_class		class;
 	struct trace_event_call			call;
 	struct tracepoint			*tp;
+	struct module				*mod;
 };
 
 static bool is_synth_event(struct dyn_event *ev)
@@ -1292,6 +1293,273 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
+static int synth_event_check_arg_fn(void *data)
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
+ * synth_event_add_field - Add a new field to a synthetic event cmd
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
+int synth_event_add_field(struct dynevent_cmd *cmd, const char *type,
+			  const char *name)
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
+	dynevent_arg_pair_init(&arg_pair, synth_event_check_arg_fn, 0, ';');
+
+	arg_pair.lhs = type;
+	arg_pair.rhs = name;
+
+	ret = dynevent_arg_pair_add(cmd, &arg_pair);
+	if (ret)
+		return ret;
+
+	if (++cmd->n_fields > SYNTH_FIELDS_MAX)
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_add_field);
+
+/**
+ * synth_event_add_field_str - Add a new field to a synthetic event cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @type_name: The type and name of the new field to add, as a single string
+ *
+ * Add a new field to a synthetic event cmd object, as a single
+ * string.  The @type_name string is expected to be of the form 'type
+ * name', which will be appended by ';'.  No sanity checking is done -
+ * what's passed in is assumed to already be well-formed.  Field
+ * ordering is in the same order the fields are added.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int synth_event_add_field_str(struct dynevent_cmd *cmd, const char *type_name)
+{
+	struct dynevent_arg arg;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_SYNTH)
+		return -EINVAL;
+
+	if (!type_name)
+		return -EINVAL;
+
+	dynevent_arg_init(&arg, NULL, ';');
+
+	arg.str = type_name;
+
+	ret = dynevent_arg_add(cmd, &arg);
+	if (ret)
+		return ret;
+
+	if (++cmd->n_fields > SYNTH_FIELDS_MAX)
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_add_field_str);
+
+/**
+ * synth_event_add_fields - Add multiple fields to a synthetic event cmd
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
+int synth_event_add_fields(struct dynevent_cmd *cmd,
+			   struct synth_field_desc *fields,
+			   unsigned int n_fields)
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
+		ret = synth_event_add_field(cmd, fields[i].type, fields[i].name);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_add_fields);
+
+/**
+ * __synth_event_gen_cmd_start - Start a synthetic event command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the synthetic event
+ * @mod: The module creating the event, NULL if not created from a module
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the synth_event_gen_cmd_start() wrapper, which
+ * automatically adds a NULL to the end of the arg list.  If this
+ * function is used directly, make sure the last arg in the variable
+ * arg list is NULL.
+ *
+ * Generate a synthetic event command to be executed by
+ * synth_event_gen_cmd_end().  This function can be used to generate
+ * the complete command or only the first part of it; in the latter
+ * case, synth_event_add_field(), synth_event_add_field_str(), or
+ * synth_event_add_fields() can be used to add more fields following
+ * this.
+ *
+ * There should be an even number variable args, each pair consisting
+ * of a type followed by a field name.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __synth_event_gen_cmd_start(struct dynevent_cmd *cmd, const char *name,
+				struct module *mod, ...)
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
+	ret = dynevent_arg_add(cmd, &arg);
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
+		ret = synth_event_add_field(cmd, type, name);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__synth_event_gen_cmd_start);
+
+/**
+ * synth_event_gen_cmd_array_start - Start synthetic event command from an array
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the synthetic event
+ * @fields: An array of type/name field descriptions
+ * @n_fields: The number of field descriptions contained in the fields array
+ *
+ * Generate a synthetic event command to be executed by
+ * synth_event_gen_cmd_end().  This function can be used to generate
+ * the complete command or only the first part of it; in the latter
+ * case, synth_event_add_field(), synth_event_add_field_str(), or
+ * synth_event_add_fields() can be used to add more fields following
+ * this.
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
+int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
+				    struct module *mod,
+				    struct synth_field_desc *fields,
+				    unsigned int n_fields)
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
+	ret = dynevent_arg_add(cmd, &arg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < n_fields; i++) {
+		if (fields[i].type == NULL || fields[i].name == NULL)
+			return -EINVAL;
+
+		ret = synth_event_add_field(cmd, fields[i].type, fields[i].name);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_gen_cmd_array_start);
+
 static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
@@ -1360,6 +1628,56 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	goto out;
 }
 
+/**
+ * synth_event_create - Create a new synthetic event
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
+ * The new synth event should be deleted using synth_event_delete()
+ * function.  The new synthetic event can be generated from modules or
+ * other kernel code using trace_synth_event() and related functions.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int synth_event_create(const char *name, struct synth_field_desc *fields,
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
+	synth_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	ret = synth_event_gen_cmd_array_start(&cmd, name, mod,
+					      fields, n_fields);
+	if (ret)
+		goto out;
+
+	ret = synth_event_gen_cmd_end(&cmd);
+ out:
+	kfree(buf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_create);
+
 static int destroy_synth_event(struct synth_event *se)
 {
 	int ret;
@@ -1388,14 +1706,33 @@ static int destroy_synth_event(struct synth_event *se)
 int synth_event_delete(const char *event_name)
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
 EXPORT_SYMBOL_GPL(synth_event_delete);
@@ -1420,7 +1757,41 @@ int synth_event_run_command(const char *command)
 	return trace_run_command(command, create_or_delete_synth_event);
 }
 
-static int synth_event_create(int argc, const char **argv)
+static int synth_event_run_cmd(struct dynevent_cmd *cmd)
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
+ * synth_event_cmd_init - Initialize a synthetic event command object
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @buf: A pointer to the buffer used to build the command
+ * @maxlen: The length of the buffer passed in @buf
+ *
+ * Initialize a synthetic event command object.  Use this before
+ * calling any of the other dyenvent_cmd functions.
+ */
+void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
+{
+	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
+			  synth_event_run_cmd);
+}
+EXPORT_SYMBOL_GPL(synth_event_cmd_init);
+
+static int create_synth_event(int argc, const char **argv)
 {
 	const char *name = argv[0];
 	int len;
-- 
2.14.1

