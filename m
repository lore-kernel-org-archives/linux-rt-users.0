Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ACC43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC512184E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480083;
	bh=nVDC6HBbTpkAucOVBrqudMTFvG1DNgWHZvCUASH0ggE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XewOF5Nqg7zGAhtxyJ34XoKVb2i+3TImy5oxlBwMpYSPT1Zv2HMArvUl+l8X9OBw2
	 glHUUJG6SNMcaJQnCIQi100gLwZ2cEEttvnsdF/Gp1UMjm/KapxcsILuMb6wsN2sZS
	 nm5wISjqOTffaLUjzQX6YecPZnd/JcrXTzrgAkgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCMM15 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfCMM15 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:27:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14322184D;
        Wed, 13 Mar 2019 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480077;
        bh=nVDC6HBbTpkAucOVBrqudMTFvG1DNgWHZvCUASH0ggE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcsw7eWmFWer23GNvTbakHxG4Pn9z7umKZ8AbYZrPzJ1YUTPiF0VtKrvHk0vxYQrF
         tevD24R/S/z9E5J3pWkaxQKHcBzipor/Ua1T8fRiNRjgNSAsFE5bKNVnkT7joQi6lE
         5lGKfhMXctd2DKmHw0Nlhmokmj3xlRhve657+wM8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 2/7] tracing/probe: Check event name length correctly
Date:   Wed, 13 Mar 2019 21:27:52 +0900
Message-Id: <155248007244.10815.13509556763357004928.stgit@devnote2>
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

