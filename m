Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74771C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429442184C
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480104;
	bh=aAD3prWRCv2RHNgXNW8/zw2jJtM+Z7CewFcZ+PgoWvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRjNgjZ4yhaHXlBs1vM8W3UrgCKg4LH2p+2DBq2FjFtZk0/DkUy+q0S453R1g7Fef
	 R4Lh6sYiOUQgZ6VdPTmM9yN/wUPHgGcIdDf3005hdKoeAdxm2MyGt28xYoh5xbpz+A
	 JKK3IC/Z7oPmgxRL5oZmH3ne9+5f/WkU47OAjD6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCMM2R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfCMM2R (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFC42183F;
        Wed, 13 Mar 2019 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480096;
        bh=aAD3prWRCv2RHNgXNW8/zw2jJtM+Z7CewFcZ+PgoWvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9AJ7bbTT01+BjBPHv58rMMhafQHNmG5Of1DA4RoTxDuk20YLrwbaV1S6JAX7pqRs
         2dTZxAmyTNNzI8s5JFonG1Mx7Pv2jYYsp2agXdB24133jxH5F5U48c8/4H+BgJPUjN
         ZTTlWJRLJFK/AGrmpd6ffQ6gWR8pDK5wuO+ymqMw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 4/7] tracing/probe: Check event/group naming rule at parsing
Date:   Wed, 13 Mar 2019 21:28:12 +0900
Message-Id: <155248009231.10815.12287201787254147977.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155248005229.10815.334731901778152247.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Check event and group naming rule at parsing it instead
of allocating probes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    7 +------
 kernel/trace/trace_probe.c  |    8 ++++++++
 kernel/trace/trace_uprobe.c |    5 +----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d47e12596f12..5222fd82e7e4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -221,7 +221,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
 	tk->rp.maxactive = maxactive;
 
-	if (!event || !is_good_name(event)) {
+	if (!event || !group) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -231,11 +231,6 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	if (!tk->tp.call.name)
 		goto error;
 
-	if (!group || !is_good_name(group)) {
-		ret = -EINVAL;
-		goto error;
-	}
-
 	tk->tp.class.system = kstrdup(group, GFP_KERNEL);
 	if (!tk->tp.class.system)
 		goto error;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index feae03056f0b..1f0cb4030c0b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -172,6 +172,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 			return -E2BIG;
 		}
 		strlcpy(buf, event, slash - event + 1);
+		if (!is_good_name(buf)) {
+			pr_info("Group name must follow the rule of C identifier\n");
+			return -EINVAL;
+		}
 		*pgroup = buf;
 		*pevent = slash + 1;
 		event = *pevent;
@@ -184,6 +188,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		pr_info("Event name is too long\n");
 		return -E2BIG;
 	}
+	if (!is_good_name(event)) {
+		pr_info("Event name must follow the rule of C identifier\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e335576b9411..52f033489377 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -266,10 +266,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 {
 	struct trace_uprobe *tu;
 
-	if (!event || !is_good_name(event))
-		return ERR_PTR(-EINVAL);
-
-	if (!group || !is_good_name(group))
+	if (!event || !group)
 		return ERR_PTR(-EINVAL);
 
 	tu = kzalloc(SIZEOF_TRACE_UPROBE(nargs), GFP_KERNEL);

