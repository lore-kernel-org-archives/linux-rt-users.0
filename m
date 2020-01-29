Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7464C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923C320720
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324454;
	bh=Eo4hZsdyPYovwuOZ0l7QBOAg+3vM5SZSn7oRFPPuxqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=L2p6H/qJ5M9PQtmnvHCKp5XUJa2Ev1Xp8Ku3v0apDC/XdI8hdztDv7R0XOJzqfLK0
	 TXfxS/yp8S2MrftdIzaobkWf4dMIo/rSuN51Sba79Ow9UlOtgx4yJYYEdvGHjqEXKx
	 1n08M7C+tWbHjK8xEM/aOQxGd2cmmw/bvGtvTs/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgA2S7s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgA2S7s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:48 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA06521734;
        Wed, 29 Jan 2020 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324387;
        bh=Eo4hZsdyPYovwuOZ0l7QBOAg+3vM5SZSn7oRFPPuxqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=C0MUB5cJLKmvwqnIOsvaXMJpcacbP4lFEZv9mDlUduY7Y48pkEJoXcLOzeMYo6/uz
         0+z4wiyY0rny+GpTiIIPynNRtuGl+r6N8G4HCoK5GUD816Sce4IwVdQtdF2pa/nCtF
         ihMZ6gPovVsp95/glt90gSdokDH8ATPqzgx+SOeE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 06/12] tracing: Change trace_boot to use synth_event interface
Date:   Wed, 29 Jan 2020 12:59:26 -0600
Message-Id: <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Have trace_boot_add_synth_event() use the synth_event interface.

Also, rename synth_event_run_cmd() to synth_event_run_command() now
that trace_boot's version is gone.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c        | 31 ++++++++++++-------------------
 kernel/trace/trace_events_hist.c |  9 ++-------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2f616cd926b0..8f40de349db1 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -133,38 +133,31 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 #endif
 
 #ifdef CONFIG_HIST_TRIGGERS
-extern int synth_event_run_command(const char *command);
-
 static int __init
 trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 {
+	struct dynevent_cmd cmd;
 	struct xbc_node *anode;
-	char buf[MAX_BUF_LEN], *q;
+	char buf[MAX_BUF_LEN];
 	const char *p;
-	int len, delta, ret;
+	int ret;
 
-	len = ARRAY_SIZE(buf);
-	delta = snprintf(buf, len, "%s", event);
-	if (delta >= len) {
-		pr_err("Event name is too long: %s\n", event);
-		return -E2BIG;
-	}
-	len -= delta; q = buf + delta;
+	synth_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+
+	ret = synth_event_gen_cmd_start(&cmd, event, NULL);
+	if (ret)
+		return ret;
 
 	xbc_node_for_each_array_value(node, "fields", anode, p) {
-		delta = snprintf(q, len, " %s;", p);
-		if (delta >= len) {
-			pr_err("fields string is too long: %s\n", p);
-			return -E2BIG;
-		}
-		len -= delta; q += delta;
+		ret = synth_event_add_field_str(&cmd, p);
+		if (ret)
+			return ret;
 	}
 
-	ret = synth_event_run_command(buf);
+	ret = synth_event_gen_cmd_end(&cmd);
 	if (ret < 0)
 		pr_err("Failed to add synthetic event: %s\n", buf);
 
-
 	return ret;
 }
 #else
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5a910bb193e9..22cd7ecdfb92 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1752,12 +1752,7 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int synth_event_run_command(const char *command)
-{
-	return trace_run_command(command, create_or_delete_synth_event);
-}
-
-static int synth_event_run_cmd(struct dynevent_cmd *cmd)
+static int synth_event_run_command(struct dynevent_cmd *cmd)
 {
 	struct synth_event *se;
 	int ret;
@@ -1787,7 +1782,7 @@ static int synth_event_run_cmd(struct dynevent_cmd *cmd)
 void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
 	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
-			  synth_event_run_cmd);
+			  synth_event_run_command);
 }
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
-- 
2.14.1

