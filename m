Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47972C2D0CD
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09458206CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682902;
	bh=4664yG6muyqppWncLAof3hvZ9Ov1i/cNsuqobc+j2yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=a3irpR6A55KCbjraRGKVPpGgnEmx7Yi6AR7OibjrSO1WBkosSBbl/a6j1Wq9TJGWG
	 lEVa+jzGCV6aji1Y3/5ytcEvj9/wPFENuQnqgvG6t79IQAIemiE17pVEHziJTIlpoT
	 0lAEPUNiJUit9mdqvjN00sfSgxxIvvvT2TkemwCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLRP2N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfLRP14 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:56 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D74E24672;
        Wed, 18 Dec 2019 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682875;
        bh=4664yG6muyqppWncLAof3hvZ9Ov1i/cNsuqobc+j2yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZjP2k6tMj6hZWY9mGNQd0n9sIt4FD8AVQJEn8qsAy5ai7T05Sox3wzP+C4a+nrYua
         vGUOWzWo9etnp82zRNaWiXSLEI5Yjko+UAG0fgVNRNH+70dWWoIhLUOaneZmXFQQ/j
         Rmuy3Jqu2XdJPmZXmOBTTnDol0Jqq7sSDwzgxFAc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 4/7] tracing: Add create_synth_event()
Date:   Wed, 18 Dec 2019 09:27:40 -0600
Message-Id: <72c12eebfad4b7b09786a98a48102773b6f4309b.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an exported function named create_synth_event(), allowing modules
or other kernel code to create a synthetic event.

create_synth_event() is actually a higher-level function composed of
the subfunctions create_empty_synth_event(), finalize_synth_event(),
and add_synth_field().  These functions and the related
add_synth_fields() are also exported so that users who want to
dynamically create an event can do so.

If the event passed to delete_synth_event() is associated with a
module, it also resets the trace buffer as similar functionality that
removes trace events does elsewhere.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  21 +++
 kernel/trace/trace_events_hist.c | 297 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 316 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0c36a58cea43..8b385778b2db 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -358,8 +358,29 @@ extern struct trace_event_file *get_event_file_nolock(const char *instance,
 extern void put_event_file(struct trace_event_file *file);
 extern void put_event_file_nolock(struct trace_event_file *file);
 
+struct synth_field_desc {
+	const char *type;
+	const char *name;
+};
+
+struct synth_event;
+
+extern int create_synth_event(const char *name,
+			      struct synth_field_desc *fields,
+			      unsigned int n_fields,
+			      struct module *mod);
+extern void free_synth_event(struct synth_event *event);
 extern int delete_synth_event(const char *name);
 
+extern struct synth_event *create_empty_synth_event(const char *name,
+						    struct module *mod);
+extern int add_synth_field(struct synth_event *event, const char *field_type,
+			   const char *field_name);
+extern int add_synth_fields(struct synth_event *event,
+			    struct synth_field_desc *fields,
+			    unsigned int n_fields);
+extern int finalize_synth_event(struct synth_event *event);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8c9894681100..4b8d7a4bac2d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -407,6 +407,7 @@ struct synth_event {
 	struct trace_event_class		class;
 	struct trace_event_call			call;
 	struct tracepoint			*tp;
+	struct module				*mod;
 };
 
 static bool is_synth_event(struct dyn_event *ev)
@@ -1198,7 +1199,7 @@ static int unregister_synth_event(struct synth_event *event)
 	return ret;
 }
 
-static void free_synth_event(struct synth_event *event)
+void free_synth_event(struct synth_event *event)
 {
 	unsigned int i;
 
@@ -1215,6 +1216,7 @@ static void free_synth_event(struct synth_event *event)
 	free_synth_event_print_fmt(&event->call);
 	kfree(event);
 }
+EXPORT_SYMBOL(free_synth_event);
 
 static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
@@ -1267,6 +1269,278 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
+/**
+ * finalize_synth_event - Finalize and register a new synth event
+ * @event: A pointer to the synth_event struct representing the new event
+ *
+ * Register a new synth event only if an event with the same name
+ * doesn't already exist.
+ *
+ * Return: 0 on success, ERR otherwise.
+ */
+int finalize_synth_event(struct synth_event *event)
+{
+	int ret;
+
+	mutex_lock(&event_mutex);
+
+	if (find_synth_event(event->name)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	ret = register_synth_event(event);
+	if (!ret)
+		ret = dyn_event_add(&event->devent);
+ out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(finalize_synth_event);
+
+static int update_fields(struct synth_event *event, struct synth_field *field)
+{
+	struct synth_field **old_fields;
+	unsigned int i, n_fields;
+
+	old_fields = event->fields;
+
+	n_fields = event->n_fields + 1;
+
+	event->fields = kcalloc(n_fields, sizeof(*event->fields), GFP_KERNEL);
+	if (!event->fields)
+		return -ENOMEM;
+
+	/* if field_name contains [n] it's an array */
+	for (i = 0; i < n_fields - 1; i++)
+		event->fields[i] = old_fields[i];
+
+	event->fields[n_fields - 1] = field;
+
+	event->n_fields = n_fields;
+
+	return 0;
+}
+
+/**
+ * add_synth_field - Add a new field to a synthetic event
+ * @event: A pointer to the synth_event struct representing the new event
+ * @field_type: The type of the new field to add
+ * @field_name: The name of the new field to add
+ *
+ * Add a new field to a synthetic event object.  Field ordering is in
+ * the same order the fields are added.
+ *
+ * See synth_field_size() for available types. If field_name contains
+ * [n] the field is considered to be an array.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int add_synth_field(struct synth_event *event, const char *field_type,
+		    const char *field_name)
+{
+	struct synth_field *field;
+	const char *array;
+	int len, ret = 0;
+
+	field = kzalloc(sizeof(*field), GFP_KERNEL);
+	if (!field)
+		return -ENOMEM;
+
+	len = strlen(field_name);
+	array = strchr(field_name, '[');
+	if (array)
+		len -= strlen(array);
+
+	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	len = strlen(field_type) + 1;
+	if (array)
+		len += strlen(array);
+
+	field->type = kzalloc(len, GFP_KERNEL);
+	if (!field->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	strcat(field->type, field_type);
+	if (array)
+		strcat(field->type, array);
+
+	field->size = synth_field_size(field->type);
+	if (!field->size) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (synth_field_is_string(field->type))
+		field->is_string = true;
+
+	field->is_signed = synth_field_signed(field->type);
+
+	ret = update_fields(event, field);
+ out:
+	return ret;
+ free:
+	free_synth_field(field);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(add_synth_field);
+
+/**
+ * add_synth_fields - Add a new field to a synthetic event
+ * @event: A pointer to the synth_event struct representing the new event
+ * @fields: An array of type/name field descriptions
+ * @n_fields: The number of field descriptions contained in the fields array
+ *
+ * Add a new set of fields to a synthetic event object.  The event
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
+int add_synth_fields(struct synth_event *event,
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
+		ret = add_synth_field(event, fields[i].type, fields[i].name);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_synth_fields);
+
+/**
+ * create_empty_synth_event - Create a synth event to be populated with fields
+ * @name: The name of the synthetic event to create
+ * @mod: The module creating the event, NULL if not created from a module
+ *
+ * Allocate and initialize a new synth_event struct for a new
+ * synthetic event.
+ *
+ * The new synthetic event should be populated with fields using one
+ * or more calls to add_synth_field() or add_synth_fields() and then
+ * finalized and registered using finalize_synth_event().
+ *
+ * If the new synthetic event is being created from a module, the mod
+ * param must be non-NULL.  This will ensure that the trace buffer
+ * won't contain unreadable events.
+ *
+ * The new synth event should be deleted using delete_synth_event() if
+ * registration was successful using finalize_synth_event().  If not,
+ * free_synth_event() should be used.
+ *
+ * Return: A pointer to the synth_event struct representing the new
+ *         synth event, ERR_PTR otherwise.
+ */
+struct synth_event *create_empty_synth_event(const char *name,
+					     struct module *mod)
+{
+	struct synth_event *event;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event) {
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->name = kstrdup(name, GFP_KERNEL);
+	if (!event->name) {
+		kfree(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->mod = mod;
+
+	dyn_event_init(&event->devent, &synth_event_ops);
+ out:
+	return event;
+}
+EXPORT_SYMBOL_GPL(create_empty_synth_event);
+
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
+ * other kernel code using generate_synth_event().
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int create_synth_event(const char *name, struct synth_field_desc *fields,
+		       unsigned int n_fields, struct module *mod)
+{
+	struct synth_event *se;
+	int ret = -EINVAL;
+	unsigned int i;
+
+	if (n_fields > SYNTH_FIELDS_MAX)
+		return ret;
+
+	se = create_empty_synth_event(name, mod);
+	if (IS_ERR(se))
+		return PTR_ERR(se);
+
+	for (i = 0; i < n_fields; i++) {
+		if (fields[i].type == NULL || fields[i].name == NULL) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		ret = add_synth_field(se, fields[i].type, fields[i].name);
+		if (ret)
+			goto free;
+	}
+
+	ret = finalize_synth_event(se);
+	if (ret)
+		goto free;
+ out:
+	return ret;
+ free:
+	free_synth_event(se);
+
+	goto out;
+}
+EXPORT_SYMBOL_GPL(create_synth_event);
+
 static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
@@ -1363,14 +1637,33 @@ static int destroy_synth_event(struct synth_event *se)
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
-- 
2.14.1

