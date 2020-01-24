Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14852C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0C62071E
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906646;
	bh=Gppq/OgdKWDrK9B39fQzgB6mbvFtgkgHVMSqV4oKDTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ozYbN6cv/FOSJvVAMxaIDHEk8ht3b6j8mCzYVEI61MW8u/4jxRFJWIKG9LoZBcmRU
	 q3XgKvFlE6rf7M8iQP4GpyGJ61XhX8ilxB9dhPOCb3FxZaiq+W71XhRIVkoah5TKxK
	 6ccZVUw9LzE/zdjArlZPI5grtRrL0nNbJspv8hm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgAXW4f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgAXW4f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:35 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A172075D;
        Fri, 24 Jan 2020 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906593;
        bh=Gppq/OgdKWDrK9B39fQzgB6mbvFtgkgHVMSqV4oKDTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OBrRVxXTIPfOkqjg4BjKvNDzRT7DaaVpJR7UhD9KyGSW3cjPHQZaamrZ9UVwIFWOP
         A/wQ38OcqHHsf1Q3I5BCv0YAeIhFrpkO8tVRzcWVUAq20rPPzrn9H8jQwffpSqYfsC
         h25BfpramN/JMTvLI33oooYVPPgdwmUxh20/tr4o=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 02/12] tracing: Add trace_get/put_event_file()
Date:   Fri, 24 Jan 2020 16:56:13 -0600
Message-Id: <ec82da7de7689bdebbb447c83d9182c05efb0ba6.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a function to get an event file and prevent it from going away on
module or instance removal.

trace_get_event_file() will find an event file in a given instance (if
instance is NULL, it assumes the top trace array) and return it,
pinning the instance's trace array as well as the event's module, if
applicable, so they won't go away while in use.

trace_put_event_file() does the matching release.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h |  5 +++
 kernel/trace/trace_events.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20948ee56f8c..8d621a73c97e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -349,6 +349,11 @@ enum {
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
 };
 
+extern struct trace_event_file *trace_get_event_file(const char *instance,
+						     const char *system,
+						     const char *event);
+extern void trace_put_event_file(struct trace_event_file *file);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index dfb736a964d6..402426a82cfb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2536,6 +2536,91 @@ find_event_file(struct trace_array *tr, const char *system, const char *event)
 	return file;
 }
 
+/**
+ * trace_get_event_file - Find and return a trace event file
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
+ * To release the file, call trace_put_event_file(), which will call
+ * trace_array_put() and decrement the event's module refcount.
+ *
+ * Return: The trace event on success, ERR_PTR otherwise.
+ */
+struct trace_event_file *trace_get_event_file(const char *instance,
+					      const char *system,
+					      const char *event)
+{
+	struct trace_array *tr = top_trace_array();
+	struct trace_event_file *file = NULL;
+	int ret = -EINVAL;
+
+	if (instance) {
+		tr = trace_array_find_get(instance);
+		if (!tr)
+			return ERR_PTR(-ENOENT);
+	} else {
+		ret = trace_array_get(tr);
+		if (ret)
+			return ERR_PTR(ret);
+	}
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
+EXPORT_SYMBOL_GPL(trace_get_event_file);
+
+/**
+ * trace_put_event_file - Release a file from trace_get_event_file()
+ * @file: The trace event file
+ *
+ * If a file was retrieved using trace_get_event_file(), this should
+ * be called when it's no longer needed.  It will cancel the previous
+ * trace_array_get() called by that function, and decrement the
+ * event's module refcount.
+ */
+void trace_put_event_file(struct trace_event_file *file)
+{
+	trace_array_put(file->tr);
+
+	mutex_lock(&event_mutex);
+	module_put(file->event_call->mod);
+	mutex_unlock(&event_mutex);
+}
+EXPORT_SYMBOL_GPL(trace_put_event_file);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
-- 
2.14.1

