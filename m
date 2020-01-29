Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E4C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3DA207FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324392;
	bh=qQPhuzc9WfeYKg29MVRCz6bjbM+bxTY3ghhDtThX/ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=lS/KZtrRjXAOJiu94fK5yGD+gAlXZzulIh1om7skgqtSltI4laBL+tdbUe5kFP5Zs
	 eWtiVqALQ3l8p85rTjLJlsgWwbLgIfuFnxP53IbZowC/q+u37dO+8WKgeLWKLxTr4W
	 e8NWZN24h5/FPr6ehzjOn7x7RjvqcH/Y5XAIWlSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgA2S7u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgA2S7t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:49 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F35420732;
        Wed, 29 Jan 2020 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324388;
        bh=qQPhuzc9WfeYKg29MVRCz6bjbM+bxTY3ghhDtThX/ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YQxsew/LuY8G4mSi9ookrxA3YwOwBAPxP1cn0CiPaaWTr4FtB5Gjd9heDwRbCLp6d
         /+Px5PDOp8j8AlcYe6x7Rq2NHUtD+7MULkKwcYi8GRrcA6pMZfx67cewNiCipRPdb+
         yDqPwQBxRDuXAEMQFiwFbh10CySSyzPM+DL9gqnQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 07/12] tracing: Add synth_event_trace() and related functions
Date:   Wed, 29 Jan 2020 12:59:27 -0600
Message-Id: <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an exported function named synth_event_trace(), allowing modules
or other kernel code to trace synthetic events.

Also added are several functions that allow the same functionality to
be broken out in a piecewise fashion, which are useful in situations
where tracing an event from a full array of values would be
cumbersome.  Those functions are synth_event_trace_start/end() and
synth_event_add_(next)_val().

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/trace_events.h     |  26 +++
 kernel/trace/trace_events_hist.c | 463 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 489 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 07b83532a3c6..bf03d12efb28 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -416,6 +416,32 @@ extern int synth_event_add_fields(struct dynevent_cmd *cmd,
 #define synth_event_gen_cmd_end(cmd)	\
 	dynevent_create(cmd)
 
+struct synth_event;
+
+struct synth_event_trace_state {
+	struct trace_event_buffer fbuffer;
+	struct synth_trace_event *entry;
+	struct trace_buffer *buffer;
+	struct synth_event *event;
+	unsigned int cur_field;
+	unsigned int n_u64;
+	bool enabled;
+	bool add_next;
+	bool add_name;
+};
+
+extern int synth_event_trace(struct trace_event_file *file,
+			     unsigned int n_vals, ...);
+extern int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
+				   unsigned int n_vals);
+extern int synth_event_trace_start(struct trace_event_file *file,
+				   struct synth_event_trace_state *trace_state);
+extern int synth_event_add_next_val(u64 val,
+				    struct synth_event_trace_state *trace_state);
+extern int synth_event_add_val(const char *field_name, u64 val,
+			       struct synth_event_trace_state *trace_state);
+extern int synth_event_trace_end(struct synth_event_trace_state *trace_state);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 22cd7ecdfb92..2e88c9805f4b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -398,6 +398,7 @@ struct synth_field {
 	char *type;
 	char *name;
 	size_t size;
+	unsigned int offset;
 	bool is_signed;
 	bool is_string;
 };
@@ -668,6 +669,8 @@ static int synth_event_define_fields(struct trace_event_call *call)
 		if (ret)
 			break;
 
+		event->fields[i]->offset = n_u64;
+
 		if (event->fields[i]->is_string) {
 			offset += STR_VAR_LEN_MAX;
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
@@ -1786,6 +1789,466 @@ void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 }
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
+/**
+ * synth_event_trace - Trace a synthetic event
+ * @file: The trace_event_file representing the synthetic event
+ * @n_vals: The number of values in vals
+ * @args: Variable number of args containing the event values
+ *
+ * Trace a synthetic event using the values passed in the variable
+ * argument list.
+ *
+ * The argument list should be a list 'n_vals' u64 values.  The number
+ * of vals must match the number of field in the synthetic event, and
+ * must be in the same order as the synthetic event fields.
+ *
+ * All vals should be cast to u64, and string vals are just pointers
+ * to strings, cast to u64.  Strings will be copied into space
+ * reserved in the event for the string, using these pointers.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
+{
+	struct trace_event_buffer fbuffer;
+	struct synth_trace_event *entry;
+	struct trace_buffer *buffer;
+	struct synth_event *event;
+	unsigned int i, n_u64;
+	int fields_size = 0;
+	va_list args;
+	int ret = 0;
+
+	/*
+	 * Normal event generation doesn't get called at all unless
+	 * the ENABLED bit is set (which attaches the probe thus
+	 * allowing this code to be called, etc).  Because this is
+	 * called directly by the user, we don't have that but we
+	 * still need to honor not logging when disabled.
+	 */
+	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+		return 0;
+
+	event = file->event_call->data;
+
+	if (n_vals != event->n_fields)
+		return -EINVAL;
+
+	if (trace_trigger_soft_disabled(file))
+		return -EINVAL;
+
+	fields_size = event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = file->tr->array_buffer.buffer;
+	ring_buffer_nest_start(buffer);
+
+	entry = trace_event_buffer_reserve(&fbuffer, file,
+					   sizeof(*entry) + fields_size);
+	if (!entry) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	va_start(args, n_vals);
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		u64 val;
+
+		val = va_arg(args, u64);
+
+		if (event->fields[i]->is_string) {
+			char *str_val = (char *)(long)val;
+			char *str_field = (char *)&entry->fields[n_u64];
+
+			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			entry->fields[n_u64] = val;
+			n_u64++;
+		}
+	}
+	va_end(args);
+
+	trace_event_buffer_commit(&fbuffer);
+out:
+	ring_buffer_nest_end(buffer);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_trace);
+
+/**
+ * synth_event_trace_array - Trace a synthetic event from an array
+ * @file: The trace_event_file representing the synthetic event
+ * @vals: Array of values
+ * @n_vals: The number of values in vals
+ *
+ * Trace a synthetic event using the values passed in as 'vals'.
+ *
+ * The 'vals' array is just an array of 'n_vals' u64.  The number of
+ * vals must match the number of field in the synthetic event, and
+ * must be in the same order as the synthetic event fields.
+ *
+ * All vals should be cast to u64, and string vals are just pointers
+ * to strings, cast to u64.  Strings will be copied into space
+ * reserved in the event for the string, using these pointers.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
+			    unsigned int n_vals)
+{
+	struct trace_event_buffer fbuffer;
+	struct synth_trace_event *entry;
+	struct trace_buffer *buffer;
+	struct synth_event *event;
+	unsigned int i, n_u64;
+	int fields_size = 0;
+	int ret = 0;
+
+	/*
+	 * Normal event generation doesn't get called at all unless
+	 * the ENABLED bit is set (which attaches the probe thus
+	 * allowing this code to be called, etc).  Because this is
+	 * called directly by the user, we don't have that but we
+	 * still need to honor not logging when disabled.
+	 */
+	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+		return 0;
+
+	event = file->event_call->data;
+
+	if (n_vals != event->n_fields)
+		return -EINVAL;
+
+	if (trace_trigger_soft_disabled(file))
+		return -EINVAL;
+
+	fields_size = event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = file->tr->array_buffer.buffer;
+	ring_buffer_nest_start(buffer);
+
+	entry = trace_event_buffer_reserve(&fbuffer, file,
+					   sizeof(*entry) + fields_size);
+	if (!entry) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		if (event->fields[i]->is_string) {
+			char *str_val = (char *)(long)vals[i];
+			char *str_field = (char *)&entry->fields[n_u64];
+
+			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			entry->fields[n_u64] = vals[i];
+			n_u64++;
+		}
+	}
+
+	trace_event_buffer_commit(&fbuffer);
+out:
+	ring_buffer_nest_end(buffer);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_trace_array);
+
+/**
+ * synth_event_trace_start - Start piecewise synthetic event trace
+ * @file: The trace_event_file representing the synthetic event
+ * @trace_state: A pointer to object tracking the piecewise trace state
+ *
+ * Start the trace of a synthetic event field-by-field rather than all
+ * at once.
+ *
+ * This function 'opens' an event trace, which means space is reserved
+ * for the event in the trace buffer, after which the event's
+ * individual field values can be set through either
+ * synth_event_add_next_val() or synth_event_add_val().
+ *
+ * A pointer to a trace_state object is passed in, which will keep
+ * track of the current event trace state until the event trace is
+ * closed (and the event finally traced) using
+ * synth_event_trace_end().
+ *
+ * Note that synth_event_trace_end() must be called after all values
+ * have been added for each event trace, regardless of whether adding
+ * all field values succeeded or not.
+ *
+ * Note also that for a given event trace, all fields must be added
+ * using either synth_event_add_next_val() or synth_event_add_val()
+ * but not both together or interleaved.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_trace_start(struct trace_event_file *file,
+			    struct synth_event_trace_state *trace_state)
+{
+	struct synth_trace_event *entry;
+	int fields_size = 0;
+	int ret = 0;
+
+	if (!trace_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memset(trace_state, '\0', sizeof(*trace_state));
+
+	/*
+	 * Normal event tracing doesn't get called at all unless the
+	 * ENABLED bit is set (which attaches the probe thus allowing
+	 * this code to be called, etc).  Because this is called
+	 * directly by the user, we don't have that but we still need
+	 * to honor not logging when disabled.  For the the iterated
+	 * trace case, we save the enabed state upon start and just
+	 * ignore the following data calls.
+	 */
+	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
+		trace_state->enabled = false;
+		goto out;
+	}
+
+	trace_state->enabled = true;
+
+	trace_state->event = file->event_call->data;
+
+	if (trace_trigger_soft_disabled(file)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fields_size = trace_state->event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	trace_state->buffer = file->tr->array_buffer.buffer;
+	ring_buffer_nest_start(trace_state->buffer);
+
+	entry = trace_event_buffer_reserve(&trace_state->fbuffer, file,
+					   sizeof(*entry) + fields_size);
+	if (!entry) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	trace_state->entry = entry;
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_trace_start);
+
+static int save_synth_val(struct synth_field *field, u64 val,
+			  struct synth_event_trace_state *trace_state)
+{
+	struct synth_trace_event *entry = trace_state->entry;
+
+	if (field->is_string) {
+		char *str_val = (char *)(long)val;
+		char *str_field;
+
+		if (!str_val)
+			return -EINVAL;
+
+		str_field = (char *)&entry->fields[field->offset];
+		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+	} else
+		entry->fields[field->offset] = val;
+
+	return 0;
+}
+
+/**
+ * synth_event_add_next_val - Add the next field's value to an open synth trace
+ * @val: The value to set the next field to
+ * @trace_state: A pointer to object tracking the piecewise trace state
+ *
+ * Set the value of the next field in an event that's been opened by
+ * synth_event_trace_start().
+ *
+ * The val param should be the value cast to u64.  If the value points
+ * to a string, the val param should be a char * cast to u64.
+ *
+ * This function assumes all the fields in an event are to be set one
+ * after another - successive calls to this function are made, one for
+ * each field, in the order of the fields in the event, until all
+ * fields have been set.  If you'd rather set each field individually
+ * without regard to ordering, synth_event_add_val() can be used
+ * instead.
+ *
+ * Note however that synth_event_add_next_val() and
+ * synth_event_add_val() can't be intermixed for a given event trace -
+ * one or the other but not both can be used at the same time.
+ *
+ * Note also that synth_event_trace_end() must be called after all
+ * values have been added for each event trace, regardless of whether
+ * adding all field values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_add_next_val(u64 val,
+			     struct synth_event_trace_state *trace_state)
+{
+	struct synth_field *field;
+	struct synth_event *event;
+	int ret = 0;
+
+	if (!trace_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (trace_state->add_name) {
+		ret = -EINVAL;
+		goto out;
+	}
+	trace_state->add_next = true;
+
+	if (!trace_state->enabled)
+		goto out;
+
+	event = trace_state->event;
+
+	if (trace_state->cur_field >= event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	field = event->fields[trace_state->cur_field++];
+	ret = save_synth_val(field, val, trace_state);
+ out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_add_next_val);
+
+static struct synth_field *find_synth_field(struct synth_event *event,
+					    const char *field_name)
+{
+	struct synth_field *field = NULL;
+	unsigned int i;
+
+	for (i = 0; i < event->n_fields; i++) {
+		field = event->fields[i];
+		if (strcmp(field->name, field_name) == 0)
+			return field;
+	}
+
+	return NULL;
+}
+
+/**
+ * synth_event_add_val - Add a named field's value to an open synth trace
+ * @field_name: The name of the synthetic event field value to set
+ * @val: The value to set the next field to
+ * @trace_state: A pointer to object tracking the piecewise trace state
+ *
+ * Set the value of the named field in an event that's been opened by
+ * synth_event_trace_start().
+ *
+ * The val param should be the value cast to u64.  If the value points
+ * to a string, the val param should be a char * cast to u64.
+ *
+ * This function looks up the field name, and if found, sets the field
+ * to the specified value.  This lookup makes this function more
+ * expensive than synth_event_add_next_val(), so use that or the
+ * none-piecewise synth_event_trace() instead if efficiency is more
+ * important.
+ *
+ * Note however that synth_event_add_next_val() and
+ * synth_event_add_val() can't be intermixed for a given event trace -
+ * one or the other but not both can be used at the same time.
+ *
+ * Note also that synth_event_trace_end() must be called after all
+ * values have been added for each event trace, regardless of whether
+ * adding all field values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_add_val(const char *field_name, u64 val,
+			struct synth_event_trace_state *trace_state)
+{
+	struct synth_trace_event *entry;
+	struct synth_event *event;
+	struct synth_field *field;
+	int ret = 0;
+
+	if (!trace_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (trace_state->add_next) {
+		ret = -EINVAL;
+		goto out;
+	}
+	trace_state->add_name = true;
+
+	if (!trace_state->enabled)
+		goto out;
+
+	event = trace_state->event;
+	entry = trace_state->entry;
+
+	field = find_synth_field(event, field_name);
+	if (!field) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = save_synth_val(field, val, trace_state);
+ out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_add_val);
+
+/**
+ * synth_event_trace_end - End piecewise synthetic event trace
+ * @trace_state: A pointer to object tracking the piecewise trace state
+ *
+ * End the trace of a synthetic event opened by
+ * synth_event_trace__start().
+ *
+ * This function 'closes' an event trace, which basically means that
+ * it commits the reserved event and cleans up other loose ends.
+ *
+ * A pointer to a trace_state object is passed in, which will keep
+ * track of the current event trace state opened with
+ * synth_event_trace_start().
+ *
+ * Note that this function must be called after all values have been
+ * added for each event trace, regardless of whether adding all field
+ * values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int synth_event_trace_end(struct synth_event_trace_state *trace_state)
+{
+	if (!trace_state)
+		return -EINVAL;
+
+	trace_event_buffer_commit(&trace_state->fbuffer);
+
+	ring_buffer_nest_end(trace_state->buffer);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(synth_event_trace_end);
+
 static int create_synth_event(int argc, const char **argv)
 {
 	const char *name = argv[0];
-- 
2.14.1

