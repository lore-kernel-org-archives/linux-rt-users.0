Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634FC43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBF4206CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682904;
	bh=Atjyd0VhLOfncfVpnTToXRLQMij7shELi5mE142B0vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=dKN/3hecONTEuJLzsNsYu/UETWDA+EJer8wYT6EB07dPVpWuAEw/YdPHT1gVtofJ9
	 O/pSJF13Ht4xwCFmsTxAXBazK17XkELj+UEqzUmdPslt4jenYTF9IQYrOwzoVmX8dP
	 H3MailTYaPVyD3gIxUDQ1586UeTm+mZwoOUC1E44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLRP14 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLRP1y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:54 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581D5218AC;
        Wed, 18 Dec 2019 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682872;
        bh=Atjyd0VhLOfncfVpnTToXRLQMij7shELi5mE142B0vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=S+WpfUcsQ6sto4b0+RxDhBs3uo0dCj1iEEvin93GOr6xhw6z53ZMtOfmKFRtwga+S
         2jBfAkzK50SviX2bkQJ9SyjlR6DM7h622xNE/SGUcBXGnn077wGcOfpL0NJJlorVVZ
         W/z6UebJJyTffYDFXOmyPUBJU/nztaTYeqmO0jzA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 2/7] tracing: Add get/put_event_file()
Date:   Wed, 18 Dec 2019 09:27:38 -0600
Message-Id: <8ee01da8f9a1aa7bbec4ea9492a464e43d31f70c.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a function to get an event file and prevent it from going away on
module or instance removal.

get_event_file() will find an event file in a given instance (if
instance is NULL, it assumes the top trace array) and return it,
pinning the instance's trace array as well as the event's module, if
applicable, so they won't go away while in use.

put_event_file() does the matching release.

Also included are _nolock() versions, which can be used if event_mutex
is already held.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h |  10 ++++
 kernel/trace/trace_events.c  | 130 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4c6e15605766..cf982c7d6636 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -348,6 +348,16 @@ enum {
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
 };
 
+extern struct trace_event_file *get_event_file(const char *instance,
+					       const char *system,
+					       const char *event);
+extern struct trace_event_file *get_event_file_nolock(const char *instance,
+						      const char *system,
+						      const char *event);
+
+extern void put_event_file(struct trace_event_file *file);
+extern void put_event_file_nolock(struct trace_event_file *file);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c6de3cebc127..2ee417d003eb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2535,6 +2535,136 @@ find_event_file(struct trace_array *tr, const char *system, const char *event)
 	return file;
 }
 
+static struct trace_event_file *__get_event_file(const char *instance,
+						 const char *system,
+						 const char *event,
+						 bool lock)
+{
+	struct trace_array *tr = top_trace_array();
+	struct trace_event_file *file = NULL;
+	int ret = -EINVAL;
+
+	if (instance) {
+		tr = trace_array_find(instance);
+		if (!tr)
+			return ERR_PTR(ret);
+	}
+
+	ret = trace_array_get(tr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (lock)
+		mutex_lock(&event_mutex);
+
+	file = find_event_file(tr, system, event);
+	if (!file) {
+		trace_array_put(tr);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Don't let event modules unload while in use */
+	ret = try_module_get(file->event_call->mod);
+	if (!ret) {
+		trace_array_put(tr);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = 0;
+ out:
+	if (lock)
+		mutex_unlock(&event_mutex);
+
+	if (ret)
+		file = ERR_PTR(ret);
+
+	return file;
+}
+
+/**
+ * get_event_file - Find and return a trace event file
+ * @instance: The name of the trace instance containing the event
+ * @system: The name of the system containing the event
+ * @event: The name of the event
+ *
+ * Return a trace event file given the trace instance name, trace
+ * system, and trace event name.  If the instance name is NULL, it
+ * refers to the top-level trace array.
+ *
+ * This function will look it up and return it if found, after calling
+ * trace_array_get() to prevent the instance from going away, and
+ * increment the event's module refcount to prevent it from being
+ * removed.
+ *
+ * To release the file, call put_event_file(), which will call
+ * trace_array_put() and decrement the event's module refcount.
+ *
+ * Return: The trace event on success, ERR_PTR otherwise.
+ */
+struct trace_event_file *get_event_file(const char *instance,
+					const char *system,
+					const char *event)
+{
+	return __get_event_file(instance, system, event, true);
+}
+EXPORT_SYMBOL_GPL(get_event_file);
+
+/**
+ * get_event_file_nolock - non-locking version of get_event_file
+ *
+ * Same as get_event_file() but doesn't take event_mutex.  See
+ * get_event_file() for details.
+ */
+struct trace_event_file *get_event_file_nolock(const char *instance,
+					       const char *system,
+					       const char *event)
+{
+	return __get_event_file(instance, system, event, false);
+}
+EXPORT_SYMBOL_GPL(get_event_file_nolock);
+
+/**
+ * put_event_file - Release a file from get_event_file()
+ * @file: The trace event file
+ *
+ * If a file was retrieved using get_event_file(), this should be
+ * called when it's no longer needed.  It will cancel the previous
+ * trace_array_get() called by that function, and decrement the
+ * event's module refcount.
+ */
+void __put_event_file(struct trace_event_file *file, bool lock)
+{
+	trace_array_put(file->tr);
+
+	if (lock)
+		mutex_lock(&event_mutex);
+
+	module_put(file->event_call->mod);
+
+	if (lock)
+		mutex_unlock(&event_mutex);
+}
+
+void put_event_file(struct trace_event_file *file)
+{
+	return __put_event_file(file, true);
+}
+EXPORT_SYMBOL_GPL(put_event_file);
+
+/**
+ * put_event_file_nolock - non-locking version of put_event_file
+ *
+ * Same as put_event_file() but doesn't take event_mutex.  See
+ * put_event_file() for details.
+ */
+void put_event_file_nolock(struct trace_event_file *file)
+{
+	return __put_event_file(file, false);
+}
+EXPORT_SYMBOL_GPL(put_event_file_nolock);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
-- 
2.14.1

