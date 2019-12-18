Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC0C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D88524676
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682876;
	bh=XW8sgdFNRlYNJyYJl0YWqko7kyc0qa3z1odcYDIWORs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=1w/Laqvn8nZKWGXzIDfynVhgPhzCXQHcIj6pspBVPXLgs7JX/KE2CbNLf8o7/jDQ1
	 cTOo0Gl+DB5U2itSkruswXv9c5Y6J4bXukZxtA8ycXtU2n2Hc7MgPVZlvbUAKZFMpu
	 pkUkL3T02IyYflWNH+Vg/GcGcCiJtsC5PfTATU70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLRP1w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLRP1v (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:51 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A390B2176D;
        Wed, 18 Dec 2019 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682871;
        bh=XW8sgdFNRlYNJyYJl0YWqko7kyc0qa3z1odcYDIWORs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GDYxdjj0EGrZMoSdd4ccAMF6CcFsf7egc7Vfz+en5YdhQNF7c5PsMpaHePlkVqvCi
         RfquyL8umhGOH5T3+lqhD+NMaCczsqZooHqBcoDhzC6pZgbykLaqos+GEIt/Fg0Pjq
         PV3dVurUtblgINRLr8D5sQ4Kaq723in1PreLYlYs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 1/7] tracing: Add trace_array_find() to find instance trace arrays
Date:   Wed, 18 Dec 2019 09:27:37 -0600
Message-Id: <ae87b48837528e5dba7e6cff962a2c431754862d.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a new trace_array_find() function that can be used to find a trace
array given the instance name, and replace existing code that does the
same thing with it.

Also make it available for use outside of trace.c.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 30 ++++++++++++++++++++----------
 kernel/trace/trace.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23459d53d576..5483b50a11ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8455,6 +8455,21 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/* Must have event_mutex and trace_types_lock held */
+struct trace_array *trace_array_find(const char *name)
+{
+	struct trace_array *tr, *found = NULL;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0) {
+			found = tr;
+			break;
+		}
+	}
+
+	return found;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8531,10 +8546,8 @@ static int instance_mkdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
+	if (trace_array_find(name))
+		goto out_unlock;
 
 	tr = trace_array_create(name);
 
@@ -8658,12 +8671,9 @@ static int instance_rmdir(const char *name)
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
index 63bf60f79398..f37ef6524821 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -346,6 +346,7 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
+extern struct trace_array *trace_array_find(const char *name);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
-- 
2.14.1

