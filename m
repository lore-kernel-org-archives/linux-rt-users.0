Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB7C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942A42071E
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906640;
	bh=gKS74XNSJ0ZIzUPEXVieFZQBl37c0+/sacrIo/yI9Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=opvF93BalY627IIJ8TW5tYFMXzsF3QQp/zsKNzMGsb+dttK+JCoXUh0ajJ+MDMpZh
	 MamBFcD3fTH7YkiXLbVOzJ3LPMrXtw5zkHOAy3gDCkF9hFVO+5NgR1wTSIcxOKa9dM
	 HUGjGrvITA3NG2x5wz2NFeVbZAmKmCsFfOpgWwyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAXW4h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgAXW4g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:36 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FA52081E;
        Fri, 24 Jan 2020 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906595;
        bh=gKS74XNSJ0ZIzUPEXVieFZQBl37c0+/sacrIo/yI9Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ysjamxK2Id8j1JQyk2usCSknr2J98/6c2rn4/N7YGZlc/S7ipG4/srHzjIf0WsSXn
         0ukQdAs1UBwz6gfx1IVVKa6YXY2HFPraeOE8zEIbY8NoosrgHSvp1GXRc4yEQ2gMFB
         omwK7pBZ/GcpiwcDeb+Z2J1zNwE/FC7jYqdJrWCg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 03/12] tracing: Add synth_event_delete()
Date:   Fri, 24 Jan 2020 16:56:14 -0600
Message-Id: <fb1828de7e276c5589071fe34f509a6cfba83cf7.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

create_or_delete_synth_event() contains code to delete a synthetic
event, which would be useful on its own - specifically, it would be
useful to allow event-creating modules to call it separately.

Separate out the delete code from that function and create an exported
function named synth_event_delete().

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  2 ++
 kernel/trace/trace_events_hist.c | 57 +++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8d621a73c97e..25fe743bcbaf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -354,6 +354,8 @@ extern struct trace_event_file *trace_get_event_file(const char *instance,
 						     const char *event);
 extern void trace_put_event_file(struct trace_event_file *file);
 
+extern int synth_event_delete(const char *name);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 117a1202a6b9..94ee1e576a1e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1354,29 +1354,54 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
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
+ * synth_event_delete - Delete a synthetic event
+ * @event_name: The name of the new sythetic event
+ *
+ * Delete a synthetic event that was created with synth_event_create().
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int synth_event_delete(const char *event_name)
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
+EXPORT_SYMBOL_GPL(synth_event_delete);
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
+		ret = synth_event_delete(name + 1);
 		return ret;
 	}
 
-- 
2.14.1

