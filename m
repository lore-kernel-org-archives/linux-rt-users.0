Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141BC33CA4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BC8205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688576;
	bh=iQP65jHxdSPmcJlKucps0p58OmBuXPfz5cNA+ZhYWmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=AylaYCAcJBt/YCBJtb3YicAD3j+Ax3zyMUsbixg0BqkHBShbp6YwjzF8FXl7ZSrcx
	 l/WWaWMG3eSJU1lyze2+LqKPnVI7cwRKfpY8acqAHXfMgLruE0FJu50NvbqabcN0m+
	 LpmbZgsUUy+yG5TV8kNo7eEpPNqXumq4upfU/GcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgAJUfa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgAJUfa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:30 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BE820842;
        Fri, 10 Jan 2020 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688529;
        bh=iQP65jHxdSPmcJlKucps0p58OmBuXPfz5cNA+ZhYWmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SODMDsRSSN+/sjKTlbXZeyOxSHqYimSJwrpvk9rjICFc8qFqaNI+Kd3n0iHk3rlV7
         WZryBOuSXsvrLn6ws0ptlRyFLXV0fd50VJuLDnyke92kmFv277E3ghFCnAZ5tgK3O3
         Os4qDB/jTIJ9JICvRO8Q7zLKLDtsxw0CQjiXnCmY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 02/12] tracing: Add get/put_event_file()
Date:   Fri, 10 Jan 2020 14:35:08 -0600
Message-Id: <579e368b01dccadb0dff24f985535f0fcea0a7c2.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h |  5 +++
 kernel/trace/trace_events.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4c6e15605766..bc634f4e0158 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -348,6 +348,11 @@ enum {
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
 };
 
+extern struct trace_event_file *get_event_file(const char *instance,
+					       const char *system,
+					       const char *event);
+extern void put_event_file(struct trace_event_file *file);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c6de3cebc127..184e10d3772d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2535,6 +2535,93 @@ find_event_file(struct trace_array *tr, const char *system, const char *event)
 	return file;
 }
 
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
+	struct trace_array *tr = top_trace_array();
+	struct trace_event_file *file = NULL;
+	int ret = -EINVAL;
+
+	if (instance) {
+		mutex_lock(&trace_types_lock);
+		tr = trace_array_find(instance);
+		mutex_unlock(&trace_types_lock);
+		if (!tr)
+			return ERR_PTR(ret);
+	}
+
+	ret = trace_array_get(tr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&event_mutex);
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
+	mutex_unlock(&event_mutex);
+
+	if (ret)
+		file = ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(get_event_file);
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
+void put_event_file(struct trace_event_file *file)
+{
+	trace_array_put(file->tr);
+
+	mutex_lock(&event_mutex);
+	module_put(file->event_call->mod);
+	mutex_unlock(&event_mutex);
+}
+EXPORT_SYMBOL_GPL(put_event_file);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
-- 
2.14.1

