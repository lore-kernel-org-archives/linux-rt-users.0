Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD27C10F06
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B23B20879
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076179;
	bh=5zBqu9Rjo9GqpYssPpNfEPo/VNhjQCEbkIgqoRJVjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=eFVCxJgGWKICFJbGNUvWbv6/Vp0D8xI7t6NGiiwsDzxIqDH4CaawMcfN46iLFizly
	 exneDtibzre8rHytEbFKvYP758CRWa+q+gSEMcx0JSwhY74Ko8WDv9JrRQ3QeNjGaf
	 ZJM271bDXuI5ITuBX9mwpdlf3ZtHfq2hfX8AjZ8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfCaXsg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfCaXsf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:35 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC6C20872;
        Sun, 31 Mar 2019 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076114;
        bh=5zBqu9Rjo9GqpYssPpNfEPo/VNhjQCEbkIgqoRJVjDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=xctqB0QrburKeZ0pSF5o0KKsGdB5439nhzc5MBztYp5K66a1dXq1NXMy32vJ5q7Vi
         O5CaoOjh7+F82vYyztl1OkRoOPdEzxGIMcc1rlQjfk24Cx/+OlJ8FliZ3O+B3qkieq
         iM4BG3KnAz5Mt9mGthXRAPN/O21RS/zaE+lbvJNU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 02/11] tracing: Save the last hist command's associated event name
Date:   Sun, 31 Mar 2019 18:48:16 -0500
Message-Id: <eb0fd1362be8f39facb86c83eecf441b7a5876f8.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

In preparation for making use of the new trace error log, save the
subsystem and event name associated with the last hist command - it
will be passed as the location param in the event_log_err() calls.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 795aa2038377..0de702bf148f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -535,15 +535,34 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 	return data;
 }
 
-static char last_hist_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd_loc[MAX_FILTER_STR_VAL];
+
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(struct trace_event_file *file, char *str)
 {
+	const char *system = NULL, *name = NULL;
+	struct trace_event_call *call;
+
 	if (!str)
 		return;
 
-	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+
+	if (file) {
+		call = file->event_call;
+
+		system = call->class->system;
+		if (system) {
+			name = trace_event_name(call);
+			if (!name)
+				system = NULL;
+		}
+	}
+
+	if (system)
+		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
 }
 
 static void hist_err(char *str, char *var)
@@ -583,6 +602,8 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 static void hist_err_clear(void)
 {
 	hist_err_str[0] = '\0';
+	last_cmd[0] = '\0';
+	last_cmd_loc[0] = '\0';
 }
 
 static bool have_hist_err(void)
@@ -5438,8 +5459,8 @@ static int hist_show(struct seq_file *m, void *v)
 	}
 
 	if (have_hist_err()) {
-		seq_printf(m, "\nERROR: %s\n", hist_err_str);
-		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
+		seq_printf(m, "\n%s: error: \n", hist_err_str);
+		seq_printf(m, "  Last command: %s\n", last_cmd);
 	}
 
  out_unlock:
@@ -6043,8 +6064,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	lockdep_assert_held(&event_mutex);
 
 	if (glob && strlen(glob)) {
-		last_cmd_set(param);
 		hist_err_clear();
+		last_cmd_set(file, param);
 	}
 
 	if (!param)
-- 
2.14.1

