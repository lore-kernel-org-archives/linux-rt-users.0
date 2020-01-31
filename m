Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC856C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981272173E
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580507744;
	bh=SxsEIQ7QuqbOUZ6oGE/BAIrX4UyDsevlqKTG97gIbag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=mMdzfeOQB2erhWZNSFQJTqqFeMLkB6PTJnEjMI6kWh0BYUz1bz7+rhxry9MeQg4av
	 Ikckgr++nGiKcJXQhV0ZK6kcEHOXw88wwlgXy0aJe/PnvfyFiTATIL7JhwSoboR/IE
	 wO3+JJFz3svOdA8aza9wdCUl/ddBvQpAJaEMUMdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgAaVzo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:55:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgAaVzn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:43 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB950214D8;
        Fri, 31 Jan 2020 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580507742;
        bh=SxsEIQ7QuqbOUZ6oGE/BAIrX4UyDsevlqKTG97gIbag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=D9NsTUF0WWuTZ7vQjnbkzmFStP034y1beGx261dpAoT7J1bQvuo5zO1eXyc7JDf9e
         wDIIxI4sVxwZHZPo1f8LIMmK4afVv7iVk2EdOMWaNMUjHlhLTIT4+piO82MHIqGfAd
         A2QUMyJ4L38b9vLwp9/Rx7L2yKlwsWZ0fBDW0ZcI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 1/4] tracing: Consolidate some synth_event_trace code
Date:   Fri, 31 Jan 2020 15:55:31 -0600
Message-Id: <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The synth_event trace code contains some almost identical functions
and some small functions that are called only once - consolidate the
common code into single functions and fold in the small functions to
simplify the code overall.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 139 ++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 83 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5b4e04780411..772bd3d7c29f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2053,24 +2053,72 @@ int synth_event_trace_start(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_start);
 
-static int save_synth_val(struct synth_field *field, u64 val,
+int __synth_event_add_val(const char *field_name, u64 val,
 			  struct synth_event_trace_state *trace_state)
 {
-	struct synth_trace_event *entry = trace_state->entry;
+	struct synth_field *field = NULL;
+	struct synth_trace_event *entry;
+	struct synth_event *event;
+	int i, ret = 0;
+
+	if (!trace_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (field_name) {
+		if (trace_state->add_next) {
+			ret = -EINVAL;
+			goto out;
+		}
+		trace_state->add_name = true;
+	} else {
+		if (trace_state->add_name) {
+			ret = -EINVAL;
+			goto out;
+		}
+		trace_state->add_next = true;
+	}
+
+	if (!trace_state->enabled)
+		goto out;
+
+	event = trace_state->event;
+	if (trace_state->add_name) {
+		for (i = 0; i < event->n_fields; i++) {
+			field = event->fields[i];
+			if (strcmp(field->name, field_name) == 0)
+				break;
+		}
+		if (!field) {
+			ret = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (trace_state->cur_field >= event->n_fields) {
+			ret = -EINVAL;
+			goto out;
+		}
+		field = event->fields[trace_state->cur_field++];
+	}
 
+	entry = trace_state->entry;
 	if (field->is_string) {
 		char *str_val = (char *)(long)val;
 		char *str_field;
 
-		if (!str_val)
-			return -EINVAL;
+		if (!str_val) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		str_field = (char *)&entry->fields[field->offset];
 		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 	} else
 		entry->fields[field->offset] = val;
-
-	return 0;
+ out:
+	return ret;
 }
 
 /**
@@ -2104,54 +2152,10 @@ static int save_synth_val(struct synth_field *field, u64 val,
 int synth_event_add_next_val(u64 val,
 			     struct synth_event_trace_state *trace_state)
 {
-	struct synth_field *field;
-	struct synth_event *event;
-	int ret = 0;
-
-	if (!trace_state) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* can't mix add_next_synth_val() with add_synth_val() */
-	if (trace_state->add_name) {
-		ret = -EINVAL;
-		goto out;
-	}
-	trace_state->add_next = true;
-
-	if (!trace_state->enabled)
-		goto out;
-
-	event = trace_state->event;
-
-	if (trace_state->cur_field >= event->n_fields) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	field = event->fields[trace_state->cur_field++];
-	ret = save_synth_val(field, val, trace_state);
- out:
-	return ret;
+	return __synth_event_add_val(NULL, val, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_add_next_val);
 
-static struct synth_field *find_synth_field(struct synth_event *event,
-					    const char *field_name)
-{
-	struct synth_field *field = NULL;
-	unsigned int i;
-
-	for (i = 0; i < event->n_fields; i++) {
-		field = event->fields[i];
-		if (strcmp(field->name, field_name) == 0)
-			return field;
-	}
-
-	return NULL;
-}
-
 /**
  * synth_event_add_val - Add a named field's value to an open synth trace
  * @field_name: The name of the synthetic event field value to set
@@ -2183,38 +2187,7 @@ static struct synth_field *find_synth_field(struct synth_event *event,
 int synth_event_add_val(const char *field_name, u64 val,
 			struct synth_event_trace_state *trace_state)
 {
-	struct synth_trace_event *entry;
-	struct synth_event *event;
-	struct synth_field *field;
-	int ret = 0;
-
-	if (!trace_state) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* can't mix add_next_synth_val() with add_synth_val() */
-	if (trace_state->add_next) {
-		ret = -EINVAL;
-		goto out;
-	}
-	trace_state->add_name = true;
-
-	if (!trace_state->enabled)
-		goto out;
-
-	event = trace_state->event;
-	entry = trace_state->entry;
-
-	field = find_synth_field(event, field_name);
-	if (!field) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = save_synth_val(field, val, trace_state);
- out:
-	return ret;
+	return __synth_event_add_val(field_name, val, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_add_val);
 
-- 
2.14.1

