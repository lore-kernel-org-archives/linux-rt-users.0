Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3AC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659CD206F0
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580507755;
	bh=52icI5wA+dx3epjTLo0tzUGFTDrGn7aMeyEMHANYtBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=qR6semqvFk51wF6ccgT9FXBSxfK0UzpoTOuSiZL1NP9alqhNxBsrYSpocP+i3lEkx
	 eE0wsvb0gZEg4RwrNsMNF+9+OYxI47NgAWibgzocyn75EcVeqMKtJUFAYyvObapabI
	 /Df8mWAKcdq+9u7uMJ9fbdJp67N7wKZLIAAPut/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAaVzr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgAaVzr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:47 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14A72464B;
        Fri, 31 Jan 2020 21:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580507746;
        bh=52icI5wA+dx3epjTLo0tzUGFTDrGn7aMeyEMHANYtBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JaEZ1eeOMdm/6wmhz6Le1l0QudbVT6rjPOK5oSZj8UBcLr/ISVt1WZX6VuwlcmcCh
         vj9KJmzatx+ChWv0GdtRcc6DnrfBry6Q0UnkRE5a1C23KYPzGZHh6EsAFSSB52Eayk
         J/rNLHJcEYubUFX1uCTtHkGoWiKFRXl1Q7C2YkoE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 4/4] tracing: Use seq_buf for building dynevent_cmd string
Date:   Fri, 31 Jan 2020 15:55:34 -0600
Message-Id: <eb8a6e835c964d0ab8a38cbf5ffa60746b54a465.1580506712.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The dynevent_cmd commands that build up the command string don't need
to do that themselves - there's a seq_buf facility that does pretty
much the same thing those command are doing manually, so use it
instead.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |  4 +---
 kernel/trace/trace_dynevent.c    | 48 +++++++++++-----------------------------
 kernel/trace/trace_events_hist.c |  2 +-
 kernel/trace/trace_kprobe.c      |  2 +-
 4 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c307a7c9c6a..67f528ecb9e5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -367,10 +367,8 @@ struct dynevent_cmd;
 typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
 
 struct dynevent_cmd {
-	char			*buf;
+	struct seq_buf		seq;
 	const char		*event_name;
-	int			maxlen;
-	int			remaining;
 	unsigned int		n_fields;
 	enum dynevent_type	type;
 	dynevent_create_fn_t	run_command;
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 204275ec8d71..9f2e8520b748 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -247,8 +247,6 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
 		     dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
-	int delta;
-	char *q;
 
 	if (check_arg) {
 		ret = check_arg(arg);
@@ -256,14 +254,11 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
 			return ret;
 	}
 
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
-
-	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
-	if (delta >= cmd->remaining) {
-		pr_err("String is too long: %s\n", arg->str);
+	ret = seq_buf_printf(&cmd->seq, " %s%c", arg->str, arg->separator);
+	if (ret) {
+		pr_err("String is too long: %s%c\n", arg->str, arg->separator);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -297,8 +292,6 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 			  dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
-	int delta;
-	char *q;
 
 	if (check_arg) {
 		ret = check_arg(arg_pair);
@@ -306,23 +299,15 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 			return ret;
 	}
 
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
-
-	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
-			 arg_pair->operator);
-	if (delta >= cmd->remaining) {
-		pr_err("field string is too long: %s\n", arg_pair->lhs);
-		return -E2BIG;
-	}
-	cmd->remaining -= delta; q += delta;
-
-	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
-			 arg_pair->separator);
-	if (delta >= cmd->remaining) {
-		pr_err("field string is too long: %s\n", arg_pair->rhs);
+	ret = seq_buf_printf(&cmd->seq, " %s%c%s%c", arg_pair->lhs,
+			     arg_pair->operator, arg_pair->rhs,
+			     arg_pair->separator);
+	if (ret) {
+		pr_err("field string is too long: %s%c%s%c\n", arg_pair->lhs,
+		       arg_pair->operator, arg_pair->rhs,
+		       arg_pair->separator);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -340,17 +325,12 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 int dynevent_str_add(struct dynevent_cmd *cmd, const char *str)
 {
 	int ret = 0;
-	int delta;
-	char *q;
-
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
 
-	delta = snprintf(q, cmd->remaining, "%s", str);
-	if (delta >= cmd->remaining) {
+	ret = seq_buf_puts(&cmd->seq, str);
+	if (ret) {
 		pr_err("String is too long: %s\n", str);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -381,9 +361,7 @@ void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
 {
 	memset(cmd, '\0', sizeof(*cmd));
 
-	cmd->buf = buf;
-	cmd->maxlen = maxlen;
-	cmd->remaining = cmd->maxlen;
+	seq_buf_init(&cmd->seq, buf, maxlen);
 	cmd->type = type;
 	cmd->run_command = run_command;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a566f5d290c1..6dc3078a6d02 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1762,7 +1762,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	struct synth_event *se;
 	int ret;
 
-	ret = trace_run_command(cmd->buf, create_or_delete_synth_event);
+	ret = trace_run_command(cmd->seq.buffer, create_or_delete_synth_event);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fe183d4045d2..51efc790aea8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -903,7 +903,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 
 static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
-	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
+	return trace_run_command(cmd->seq.buffer, create_or_delete_trace_kprobe);
 }
 
 /**
-- 
2.14.1

