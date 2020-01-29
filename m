Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAAC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB3207FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324467;
	bh=U1jhZlerZbTXWw8fvpMoFrkgIsIlaOTsaC2JcEKNqzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=SGyEF9zVbqDFk7ul+atuOMxeSIQVgh827B4a4frCVHvoMFpImLiWG7OzPcbmhMhxC
	 W+h7Hfi/knZa/eqYs2Rvb5vVwSLRfzyLUBeLAJ5IBwi5X7OJGQ9y7MsllyBO7ENjkH
	 vmPZO8+FpK9SVS7JPOHL+f9vBclTMjt7zwnaAPms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgA2S7m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgA2S7l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEE820716;
        Wed, 29 Jan 2020 18:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324381;
        bh=U1jhZlerZbTXWw8fvpMoFrkgIsIlaOTsaC2JcEKNqzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CZntsNYzj2Rd3qKI5KVucgdDgPrBKkFZAF9wJE7T7TlSKkIwkYj+KFlLEzIXLOGeS
         rGf08IY5p+UUV+CLliq4DRgl36+5UMzTwNgf5BVDDvUUeCmPeij+KrzU/soWqHSm6F
         hbVHmD+CSl6tIpA6cGO2lb6dy/UVCgoJUCjfHS2o=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 01/12] tracing: Add trace_array_find/_get() to find instance trace arrays
Date:   Wed, 29 Jan 2020 12:59:21 -0600
Message-Id: <cb68528c975eba95bee4561ac67dd1499423b2e5.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a new trace_array_find() function that can be used to find a trace
array given the instance name, and replace existing code that does the
same thing with it.  Also add trace_array_find_get() which does the
same but returns the trace array after upping its refcount.

Also make both available for use outside of trace.c.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c | 43 +++++++++++++++++++++++++++++++++----------
 kernel/trace/trace.h |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a28b1b9bf42..6e415057d373 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8501,6 +8501,34 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/* Must have trace_types_lock held */
+struct trace_array *trace_array_find(const char *instance)
+{
+	struct trace_array *tr, *found = NULL;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, instance) == 0) {
+			found = tr;
+			break;
+		}
+	}
+
+	return found;
+}
+
+struct trace_array *trace_array_find_get(const char *instance)
+{
+	struct trace_array *tr;
+
+	mutex_lock(&trace_types_lock);
+	tr = trace_array_find(instance);
+	if (tr)
+		tr->ref++;
+	mutex_unlock(&trace_types_lock);
+
+	return tr;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8577,10 +8605,8 @@ static int instance_mkdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
+	if (trace_array_find(name))
+		goto out_unlock;
 
 	tr = trace_array_create(name);
 
@@ -8708,12 +8734,9 @@ static int instance_rmdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -ENODEV;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0) {
-			ret = __remove_instance(tr);
-			break;
-		}
-	}
+	tr = trace_array_find(name);
+	if (tr)
+		ret = __remove_instance(tr);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6bb64d89c321..0db5341c113d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -358,6 +358,8 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
+extern struct trace_array *trace_array_find(const char *instance);
+extern struct trace_array *trace_array_find_get(const char *instance);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
-- 
2.14.1

