Return-Path: <SRS0=rL3Y=RR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0BC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9827E2184D
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552537816;
	bh=p8QHokGfUN0dEUoC1u5w2h/05pXuzMCIlQ+v/4PbFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flXSMRXzkm1IiyPE3Z1joCB7LBlnDyl6teaEVhUu2ScGAZ4pesIJbjBDeGNfn3O5I
	 PTsty2tB5p2o6/Q4G3vZutcfNuJcn07B5859vMQHNWtzXtfXT9ZztyNOpRDCNmB+3O
	 zE+ajuyuC30W8YaEKFFKlekfOfU/C6ayJMiY6Zyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCNEaQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfCNEaP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Mar 2019 00:30:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C734E2184C;
        Thu, 14 Mar 2019 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552537815;
        bh=p8QHokGfUN0dEUoC1u5w2h/05pXuzMCIlQ+v/4PbFN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFyjwmYisZSw08wD9HPEE2C4O5G0uVRSVdz6lYvYddhe6g3pI2EP27ouArs42sugi
         SyPsd218FWKskTXmchglQi+bytGOl4k+dAQtmnShfJvdN6B20J1bGOdoW01B/OiAJN
         DplIrMBhzCtMfOVSue6DUpvNsIDkq3G9PjlFJCiY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 1/7] tracing/probe: Check maxactive error cases
Date:   Thu, 14 Mar 2019 13:30:09 +0900
Message-Id: <155253780952.14922.15784129810238750331.stgit@devnote2>
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

