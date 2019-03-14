Return-Path: <SRS0=rL3Y=RR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D65C10F06
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9A52186A
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552537831;
	bh=nVDC6HBbTpkAucOVBrqudMTFvG1DNgWHZvCUASH0ggE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdLliMF/lAnUeVBLUxhbn8mqSCK0WJTlWEznlba3QscTh4ENgTZQR/i9WD9FIyiuY
	 HVYxJKZvdB+5JAKx1bwMCmxuxBnsFzCyEKYHGodFSRu9R2dYRg8JxtzOmzD0z+8TXL
	 7xmo+bj3DdESQkuN+HT68d0SnSAdKL0mZHeGlgEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCNEaZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfCNEaZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Mar 2019 00:30:25 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B462184D;
        Thu, 14 Mar 2019 04:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552537824;
        bh=nVDC6HBbTpkAucOVBrqudMTFvG1DNgWHZvCUASH0ggE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQUGOwxkQns/5s44GbFIIxXjv+vnK6QuP29mNNTjB69w+pI47iV7YWtKADKHiGiHV
         zTNU6kcnx5weMBg/Ca8e+XkPHy63QXLfYw6HqQKBBZ9x8fCfC8qcEMeU5dadNE+sgX
         PvlJ/DcSdY3+ZXePo/jq46s45rhH56MfmeZGZic8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 2/7] tracing/probe: Check event name length correctly
Date:   Thu, 14 Mar 2019 13:30:20 +0900
Message-Id: <155253782046.14922.14724124823730168629.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155253778926.14922.14048967363017104338.stgit@devnote2>
References: <155253778926.14922.14048967363017104338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ensure given name of event is not too long when parsing it,
and fix to update event name offset correctly when the group
name is given. For example, this makes probe event to check
the "p:foo/" error case correctly.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 89da34b326e3..4cd50913cb5d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -159,6 +159,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf)
 {
 	const char *slash, *event = *pevent;
+	int len;
 
 	slash = strchr(event, '/');
 	if (slash) {
@@ -173,10 +174,15 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		strlcpy(buf, event, slash - event + 1);
 		*pgroup = buf;
 		*pevent = slash + 1;
+		event = *pevent;
 	}
-	if (strlen(event) == 0) {
+	len = strlen(event);
+	if (len == 0) {
 		pr_info("Event name is not specified\n");
 		return -EINVAL;
+	} else if (len > MAX_EVENT_NAME_LEN) {
+		pr_info("Event name is too long\n");
+		return -E2BIG;
 	}
 	return 0;
 }

