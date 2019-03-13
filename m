Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C8C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF862184E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480072;
	bh=p8QHokGfUN0dEUoC1u5w2h/05pXuzMCIlQ+v/4PbFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEMVbG2VL9+tR12/VzJgiIuE5G9ZewMmUqlbAJhiJCNC+ng6azCAdCvk1uhtaIMO3
	 4lVTR71jaoMgq/1QIAeg1ltHouow6OG87I7TcLXiScsBXWGga5dxmy99VbbwHnJmBA
	 C079XAV7UPetOtHQ7CErr2BXEk9b2ZQVLggoq37I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfCMM1r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCMM1r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:27:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379992183F;
        Wed, 13 Mar 2019 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480067;
        bh=p8QHokGfUN0dEUoC1u5w2h/05pXuzMCIlQ+v/4PbFN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLCSPnf5ptJKRCx9aJIrtp4K6WsbJCtyMHyvcrU6Gd2e3dZ50FyIc2pHagCZuCH59
         zGcapucb2A3pSCR96rWSTWyc7HhirXLFBgnadKRrVHBqA4xEFlR+ppbullxB8fhDe7
         3w5EYWgSMwEnNhe3gUEj7WKjUymVo8Z6B6xWVgGE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 1/7] tracing/probe: Check maxactive error cases
Date:   Wed, 13 Mar 2019 21:27:42 +0900
Message-Id: <155248006270.10815.14600382508884855084.stgit@devnote2>
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

Check maxactive on kprobe error case, because maxactive
is only for kretprobe, not for kprobe. Also, maxactive
should not be 0, it should be at least 1.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d5fb09ebba8b..d47e12596f12 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -624,7 +624,11 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	if (event)
 		event++;
 
-	if (is_return && isdigit(argv[0][1])) {
+	if (isdigit(argv[0][1])) {
+		if (!is_return) {
+			pr_info("Maxactive is not for kprobe");
+			return -EINVAL;
+		}
 		if (event)
 			len = event - &argv[0][1] - 1;
 		else
@@ -634,8 +638,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		memcpy(buf, &argv[0][1], len);
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
-		if (ret) {
-			pr_info("Failed to parse maxactive.\n");
+		if (ret || !maxactive) {
+			pr_info("Invalid maxactive number\n");
 			return ret;
 		}
 		/* kretprobes instances are iterated over via a list. The

