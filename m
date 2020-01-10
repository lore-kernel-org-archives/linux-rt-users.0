Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5BC282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2874205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688572;
	bh=2ZlmO3eb6NzuzPyNn6Ibl5hGJyH7xmjo/T5rwsq2n1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=tZa2PyFAvsbSjUL0fKzIZT0FNzWZ2N3dHLGKDwS4gV6d8pBo0bOdA5wcYLojnc1a7
	 m89Q2+UCaSqI17X7Bc2cPpF0oodhmY8asMvdzrUZ3fHqQkNGVcU7UB5yq7ZnpZlvku
	 HM3ZX5gVzwdviDWSsRuLA6pAgDFew4/rB9kJJDkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgAJUfe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgAJUfb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:31 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A37920880;
        Fri, 10 Jan 2020 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688530;
        bh=2ZlmO3eb6NzuzPyNn6Ibl5hGJyH7xmjo/T5rwsq2n1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=o3efRCpl6Nsn5LSG6z0ci57pFufzDxPuvtfbaLp+BkUQlCE5hNfpRPXnQ2YMkamKg
         pDfKjJIbiRx2fqo0g1Ia61V/vTNNh2YAmeY92TcqeSumfcmO/4co7MfFazqvdw0mDH
         ZK1sZKF5j7MrF3lM3tdVlP+fQrFPUtC1GTH1b0D4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 03/12] tracing: Add delete_synth_event()
Date:   Fri, 10 Jan 2020 14:35:09 -0600
Message-Id: <78679b3fe8e3094a40fd060c048a067a19e1185c.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

create_or_delete_synth_event() contains code to delete a synthetic
event, which would be useful on its own - specifically, it would be
useful to allow event-creating modules to call it separately.

Separate out the delete code from that function and create an exported
function named delete_synth_event().

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  2 ++
 kernel/trace/trace_events_hist.c | 57 +++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index bc634f4e0158..c8038d1a1a48 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -353,6 +353,8 @@ extern struct trace_event_file *get_event_file(const char *instance,
 					       const char *event);
 extern void put_event_file(struct trace_event_file *file);
 
+extern int delete_synth_event(const char *name);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f49d1a36d3ae..8c9894681100 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1335,29 +1335,54 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	goto out;
 }
 
+static int destroy_synth_event(struct synth_event *se)
+{
+	int ret;
+
+	if (se->ref)
+		ret = -EBUSY;
+	else {
+		ret = unregister_synth_event(se);
+		if (!ret) {
+			dyn_event_remove(&se->devent);
+			free_synth_event(se);
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * delete_synth_event - Delete a synthetic event
+ * @event_name: The name of the new sythetic event
+ *
+ * Delete a synthetic event that was created with create_synth_event().
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int delete_synth_event(const char *event_name)
+{
+	struct synth_event *se = NULL;
+	int ret = -ENOENT;
+
+	mutex_lock(&event_mutex);
+	se = find_synth_event(event_name);
+	if (se)
+		ret = destroy_synth_event(se);
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(delete_synth_event);
+
 static int create_or_delete_synth_event(int argc, char **argv)
 {
 	const char *name = argv[0];
-	struct synth_event *event = NULL;
 	int ret;
 
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
-		mutex_lock(&event_mutex);
-		event = find_synth_event(name + 1);
-		if (event) {
-			if (event->ref)
-				ret = -EBUSY;
-			else {
-				ret = unregister_synth_event(event);
-				if (!ret) {
-					dyn_event_remove(&event->devent);
-					free_synth_event(event);
-				}
-			}
-		} else
-			ret = -ENOENT;
-		mutex_unlock(&event_mutex);
+		ret = delete_synth_event(name + 1);
 		return ret;
 	}
 
-- 
2.14.1

