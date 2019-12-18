Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0962CC43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7852467F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682890;
	bh=0dD+Vv151FfLfgaBTQgl7bPziumhNsMCdpgVCj+k8pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=n/zvVfzD/0YZEk0xZnK3vA9vX/ADxuDD5pxkZxcWkilHTH94SjZLhAg8LzDLsvgMR
	 lr4gl1UpkOGMnkbAweg4mkMyiAHWTxtnTTUA62ZwDlAWCC8L8+m+8KoMW4dncZrqXz
	 hx5vT8EjZ0tFAfYMYBatUvZ94oO9ATpJRffAY6tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLRP16 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfLRP16 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:58 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AF424679;
        Wed, 18 Dec 2019 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682877;
        bh=0dD+Vv151FfLfgaBTQgl7bPziumhNsMCdpgVCj+k8pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=K1ZuvonHyxPoA9FbcPFTLlPeuQJ0wLNkdBcOEFVc12S93AM+7fGt1lTrcQh5hOV0j
         cUBI8eIxm5hDDNT3ISwmBIbuf7wXt9QPLvuhlGI5q1QABZvKaM8qPkn+cD8ReFshae
         0+1MOdGVW+mHsUPmObAOkbeZWUjyrt7I0NSqdwoU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 5/7] tracing: Add generate_synth_event() and related functions
Date:   Wed, 18 Dec 2019 09:27:41 -0600
Message-Id: <7968762ed65ff937391978f1c804d186cdfa88f7.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an exported function named generate_synth_event(), allowing
modules or other kernel code to generate synthetic events.

Also added are several functions that allow the same functionality to
be broken out in a piecewise fashion, which are useful in situations
where generating an event from a full array of values would be
cumbersome.  Those functions are generate_synth_event_start/end() and
add_(next)_synth_val().

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  20 +++
 kernel/trace/trace_events_hist.c | 370 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 390 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8b385778b2db..8a413b9cff40 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -365,6 +365,18 @@ struct synth_field_desc {
 
 struct synth_event;
 
+struct synth_gen_state {
+	struct trace_event_buffer fbuffer;
+	struct synth_trace_event *entry;
+	struct ring_buffer *buffer;
+	struct synth_event *event;
+	unsigned int cur_field;
+	unsigned int n_u64;
+	bool enabled;
+	bool add_next;
+	bool add_name;
+};
+
 extern int create_synth_event(const char *name,
 			      struct synth_field_desc *fields,
 			      unsigned int n_fields,
@@ -380,6 +392,14 @@ extern int add_synth_fields(struct synth_event *event,
 			    struct synth_field_desc *fields,
 			    unsigned int n_fields);
 extern int finalize_synth_event(struct synth_event *event);
+extern int generate_synth_event(struct trace_event_file *file, u64 *vals,
+				unsigned int n_vals);
+extern int generate_synth_event_start(struct trace_event_file *file,
+				      struct synth_gen_state *gen_state);
+extern int add_next_synth_val(u64 val, struct synth_gen_state *gen_state);
+extern int add_synth_val(const char *field_name, u64 val,
+			 struct synth_gen_state *gen_state);
+extern int generate_synth_event_end(struct synth_gen_state *gen_state);
 
 /*
  * Event file flags:
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4b8d7a4bac2d..426c385f941f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -393,6 +393,7 @@ struct synth_field {
 	char *type;
 	char *name;
 	size_t size;
+	unsigned int offset;
 	bool is_signed;
 	bool is_string;
 };
@@ -662,6 +663,8 @@ static int synth_event_define_fields(struct trace_event_call *call)
 		if (ret)
 			break;
 
+		event->fields[i]->offset = n_u64;
+
 		if (event->fields[i]->is_string) {
 			offset += STR_VAR_LEN_MAX;
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
@@ -1269,6 +1272,90 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
+/**
+ * generate_synth_event - Generate a synthetic event
+ * @file: The trace_event_file representing the synthetic event
+ * @vals: Array of values
+ * @n_vals: The number of values in vals
+ *
+ * Generate a synthetic event using the values passed in as 'vals'.
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
+int generate_synth_event(struct trace_event_file *file, u64 *vals,
+			 unsigned int n_vals)
+{
+	struct trace_event_buffer fbuffer;
+	struct synth_trace_event *entry;
+	struct ring_buffer *buffer;
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
+	buffer = file->tr->trace_buffer.buffer;
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
+EXPORT_SYMBOL_GPL(generate_synth_event);
+
 /**
  * finalize_synth_event - Finalize and register a new synth event
  * @event: A pointer to the synth_event struct representing the new event
@@ -1299,6 +1386,289 @@ int finalize_synth_event(struct synth_event *event)
 }
 EXPORT_SYMBOL_GPL(finalize_synth_event);
 
+/**
+ * generate_synth_event_start - Start piecewise synthetic event generation
+ * @file: The trace_event_file representing the synthetic event
+ * @gen_state: A pointer to object tracking the piecewise generation state
+ *
+ * Start the generation of a synthetic event field-by-field rather
+ * than all at once.
+ *
+ * This function 'opens' an event generation, which means space is
+ * reserved for the event in the trace buffer, after which the event's
+ * individual field values can be set through either
+ * add_next_synth_val() or add_synth_val().
+ *
+ * A pointer to a gen_state object is passed in, which will keep track
+ * of the current event generation state until the event generation is
+ * closed (and the event finally generated) using
+ * generate_synth_event_end().
+ *
+ * Note that generate_synth_event_end() must be called after all
+ * values have been added for each event generation, regardless of
+ * whether adding all field values succeeded or not.
+ *
+ * Note also that for a given event generation, all fields must be
+ * added using either add_next_synth_val() or add_synth_val() but not
+ * both together or interleaved.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int generate_synth_event_start(struct trace_event_file *file,
+			       struct synth_gen_state *gen_state)
+{
+	struct synth_trace_event *entry;
+	int fields_size = 0;
+	int ret = 0;
+
+	if (!gen_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memset(gen_state, '\0', sizeof(*gen_state));
+
+	/*
+	 * Normal event generation doesn't get called at all unless
+	 * the ENABLED bit is set (which attaches the probe thus
+	 * allowing this code to be called, etc).  Because this is
+	 * called directly by the user, we don't have that but we
+	 * still need to honor not logging when disabled.  For the the
+	 * iterated gen case, we save the enabed state upon start and
+	 * just ignore the following data calls.
+	 */
+	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
+		gen_state->enabled = false;
+		goto out;
+	}
+
+	gen_state->enabled = true;
+
+	gen_state->event = file->event_call->data;
+
+	if (trace_trigger_soft_disabled(file)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fields_size = gen_state->event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	gen_state->buffer = file->tr->trace_buffer.buffer;
+	ring_buffer_nest_start(gen_state->buffer);
+
+	entry = trace_event_buffer_reserve(&gen_state->fbuffer, file,
+					   sizeof(*entry) + fields_size);
+	if (!entry) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	gen_state->entry = entry;
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generate_synth_event_start);
+
+static int save_synth_val(struct synth_field *field, u64 val,
+			  struct synth_gen_state *gen_state)
+{
+	struct synth_trace_event *entry = gen_state->entry;
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
+ * add_next_synth_val - Add the next field's value to an open synth generation
+ * @val: The value to set the next field to
+ * @gen_state: A pointer to object tracking the piecewise generation state
+ *
+ * Set the value of the next field in an event that's been opened by
+ * generate_synth_event_start().
+ *
+ * The val param should be the value cast to u64.  If the value points
+ * to a string, the val param should be a char * cast to u64.
+ *
+ * This function assumes all the fields in an event are to be set one
+ * after another - successive calls to this function are made, one for
+ * each field, in the order of the fields in the event, until all
+ * fields have been set.  If you'd rather set each field individually
+ * without regard to ordering, add_synth_val() can be used instead.
+ *
+ * Note however that add_next_synth_val() and add_synth_val() can't be
+ * intermixed for a given event generation - one or the other but not
+ * both can be used at the same time.
+ *
+ * Note also that generate_synth_event_end() must be called after all
+ * values have been added for each event generation, regardless of
+ * whether adding all field values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int add_next_synth_val(u64 val, struct synth_gen_state *gen_state)
+{
+	struct synth_field *field;
+	struct synth_event *event;
+	int ret = 0;
+
+	if (!gen_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (gen_state->add_name) {
+		ret = -EINVAL;
+		goto out;
+	}
+	gen_state->add_next = true;
+
+	if (!gen_state->enabled)
+		goto out;
+
+	event = gen_state->event;
+
+	if (gen_state->cur_field >= event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	field = event->fields[gen_state->cur_field++];
+	ret = save_synth_val(field, val, gen_state);
+ out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_next_synth_val);
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
+ * add_synth_val - Add a named field's value to an open synth generation
+ * @field_name: The name of the synthetic event field value to set
+ * @val: The value to set the next field to
+ * @gen_state: A pointer to object tracking the piecewise generation state
+ *
+ * Set the value of the named field in an event that's been opened by
+ * generate_synth_event_start().
+ *
+ * The val param should be the value cast to u64.  If the value points
+ * to a string, the val param should be a char * cast to u64.
+ *
+ * This function looks up the field name, and if found, sets the field
+ * to the specified value.  This lookup makes this function more
+ * expensive than add_next_synth_val(), so use that or the
+ * none-piecewise generate_synth_event() instead if efficiency is more
+ * important.
+ *
+ * Note however that add_next_synth_val() and add_synth_val() can't be
+ * intermixed for a given event generation - one or the other but not
+ * both can be used at the same time.
+ *
+ * Note also that generate_synth_event_end() must be called after all
+ * values have been added for each event generation, regardless of
+ * whether adding all field values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int add_synth_val(const char *field_name, u64 val,
+		  struct synth_gen_state *gen_state)
+{
+	struct synth_trace_event *entry;
+	struct synth_event *event;
+	struct synth_field *field;
+	int ret = 0;
+
+	if (!gen_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (gen_state->add_next) {
+		ret = -EINVAL;
+		goto out;
+	}
+	gen_state->add_name = true;
+
+	if (!gen_state->enabled)
+		goto out;
+
+	event = gen_state->event;
+	entry = gen_state->entry;
+
+	field = find_synth_field(event, field_name);
+	if (!field) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = save_synth_val(field, val, gen_state);
+ out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_synth_val);
+
+/**
+ * generate_synth_event_end - End piecewise synthetic event generation
+ * @gen_state: A pointer to object tracking the piecewise generation state
+ *
+ * End the generation of a synthetic event opened by
+ * generate_synth_event_start().
+ *
+ * This function 'closes' an event generation, which basically means
+ * that it commits the reserved event and cleans up other loose ends.
+ *
+ * A pointer to a gen_state object is passed in, which will keep track
+ * of the current event generation state opened with
+ * generate_synth_event_start().
+ *
+ * Note that this function must be called after all values have been
+ * added for each event generation, regardless of whether adding all
+ * field values succeeded or not.
+ *
+ * Return: 0 on success, err otherwise.
+ */
+int generate_synth_event_end(struct synth_gen_state *gen_state)
+{
+	if (!gen_state)
+		return -EINVAL;
+
+	trace_event_buffer_commit(&gen_state->fbuffer);
+
+	ring_buffer_nest_end(gen_state->buffer);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(generate_synth_event_end);
+
 static int update_fields(struct synth_event *event, struct synth_field *field)
 {
 	struct synth_field **old_fields;
-- 
2.14.1

