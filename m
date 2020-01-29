Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CE0C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370420716
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324441;
	bh=te+WB6D1FGQJXNVahZlEA/QjMeLrm7OpUZRpPcaxYlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Ceny9IymEf1LFGsS+ACL/arusT6PtCwuQDgyWqSsmwh2tnZvSS72caWjprKFKjReP
	 alsDpj7QePbDB+MtsiS8vDwvfMwDiP1VStLx1HPtYGEgY4YqrMqlrWB93CbToXVDUu
	 9hZUkClBYJEClyab3Vfg9+T0DELUc+J8G2M4tbMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgA2TAg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgA2S7y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:54 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AA1207FF;
        Wed, 29 Jan 2020 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324393;
        bh=te+WB6D1FGQJXNVahZlEA/QjMeLrm7OpUZRpPcaxYlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JIwg/dCtvIfaFEVOBwr9WAkBvARFxkH7LCkBOCeFl+Oxl4HKq+iNQTG33MG6IsZH+
         ChncA3NsuTDr58ipHH4O+63lmz5KuZx0B2j5n+c1U+40tY9v6rnunNi4if/ckJR5vV
         ievSHCTsIUyp84FqKLeNknT2WwJTzO9DoSRCBUa8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 10/12] tracing: Change trace_boot to use kprobe_event interface
Date:   Wed, 29 Jan 2020 12:59:30 -0600
Message-Id: <af5429d11291ab1e9a85a0ff944af3b2bcf193c7.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
In-Reply-To: <cover.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Have trace_boot_add_kprobe_event() use the kprobe_event interface.

Also, rename kprobe_event_run_cmd() to kprobe_event_run_command() now
that trace_boot's version is gone.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c   | 35 +++++++++++++++--------------------
 kernel/trace/trace_kprobe.c |  9 ++-------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 8f40de349db1..352924477e8f 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -91,37 +91,32 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 }
 
 #ifdef CONFIG_KPROBE_EVENTS
-extern int trace_kprobe_run_command(const char *command);
-
 static int __init
 trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 {
+	struct dynevent_cmd cmd;
 	struct xbc_node *anode;
 	char buf[MAX_BUF_LEN];
 	const char *val;
-	char *p;
-	int len;
+	int ret;
 
-	len = snprintf(buf, ARRAY_SIZE(buf) - 1, "p:kprobes/%s ", event);
-	if (len >= ARRAY_SIZE(buf)) {
-		pr_err("Event name is too long: %s\n", event);
-		return -E2BIG;
-	}
-	p = buf + len;
-	len = ARRAY_SIZE(buf) - len;
+	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+
+	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
+	if (ret)
+		return ret;
 
 	xbc_node_for_each_array_value(node, "probes", anode, val) {
-		if (strlcpy(p, val, len) >= len) {
-			pr_err("Probe definition is too long: %s\n", val);
-			return -E2BIG;
-		}
-		if (trace_kprobe_run_command(buf) < 0) {
-			pr_err("Failed to add probe: %s\n", buf);
-			return -EINVAL;
-		}
+		ret = kprobe_event_add_field(&cmd, val);
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	ret = kprobe_event_gen_cmd_end(&cmd);
+	if (ret)
+		pr_err("Failed to add probe: %s\n", buf);
+
+	return ret;
 }
 #else
 static inline int __init
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f43548b466d0..307abb724a71 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -901,12 +901,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int trace_kprobe_run_command(const char *command)
-{
-	return trace_run_command(command, create_or_delete_trace_kprobe);
-}
-
-static int trace_kprobe_run_cmd(struct dynevent_cmd *cmd)
+static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
 	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
 }
@@ -923,7 +918,7 @@ static int trace_kprobe_run_cmd(struct dynevent_cmd *cmd)
 void kprobe_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
 	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_KPROBE,
-			  trace_kprobe_run_cmd);
+			  trace_kprobe_run_command);
 }
 EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
 
-- 
2.14.1

