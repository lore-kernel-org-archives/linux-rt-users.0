Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A28C35242
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D462071E
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906633;
	bh=ODBbuiZjSW43nINXTys/F+HKMTJnnF8cY98ISo7dXk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Zt7fTlWyoBaARmV03IizX5y0IcFYGyk2QY0tgd4fpdvPvEzgizOs+SJI7CN0EDR4T
	 oFp47trkxHq02HsA8pIZTDFQdpQNUwrQhEMqZROLFt6aSGnOYSoo6X5C00dc7ex277
	 BK7xEVJi90yut6KihnXv3Q9o+7CPWxBZnMNs5uHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgAXW4m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgAXW4k (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:40 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30474208C4;
        Fri, 24 Jan 2020 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906599;
        bh=ODBbuiZjSW43nINXTys/F+HKMTJnnF8cY98ISo7dXk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=s7WdgTYATEHW2T3HrFxDZ/vK8XKrMpHWfYNwPvgxO51oa9Wen9mrouIFMv1DVZrLz
         Y//fTywjh7n5fMVyd92dES82wApfj/FLjt9Jgzt6OFbrSgwC8uPzPDC5ZX3cQ1gW1F
         0BfiXh+220Y7dCAjya0MCLoB07IM7GnZibf9CQYk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 06/12] tracing: Change trace_boot to use synth_event interface
Date:   Fri, 24 Jan 2020 16:56:17 -0600
Message-Id: <1b02a8871950a8c1be35a12ac27b8babd2461123.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Have trace_boot_add_synth_event() use the synth_event interface.

Also, rename synth_event_run_cmd() to synth_event_run_command() now
that trace_boot's version is gone.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_boot.c        | 31 ++++++++++++-------------------
 kernel/trace/trace_events_hist.c |  9 ++-------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index cd541ac1cbc1..33665718008c 100644
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
index 2e7181ce51aa..41a82f5c5be5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1746,12 +1746,7 @@ static int create_or_delete_synth_event(int argc, char **argv)
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
@@ -1781,7 +1776,7 @@ static int synth_event_run_cmd(struct dynevent_cmd *cmd)
 void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
 	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
-			  synth_event_run_cmd);
+			  synth_event_run_command);
 }
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
-- 
2.14.1

