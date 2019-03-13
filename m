Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E9C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A202184D
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480112;
	bh=rJr9CO2gbIo3u4eMVEbCUuFTuhvs3gvXoiMeQ1MSEtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9JIHAsWi/uCWZWYLjs4+G+lodlZLLfkYMay68Nanvm4pAQEN8fFmrHU9sXFBVOGj
	 zSg57l6JHAxWHcJrJDXBMzuY9X9YK0/1l0n/DZXZtkIFtdSrrxyj3z3i87Apgtu/5B
	 Rf1+OKFSy/W3dsahNcmN6FMRZlgcTiPderkkI1Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCMM21 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfCMM20 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AFE214AE;
        Wed, 13 Mar 2019 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480106;
        bh=rJr9CO2gbIo3u4eMVEbCUuFTuhvs3gvXoiMeQ1MSEtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXrpdOLprvD3VNHtbbCb0ZRWfCz0ToTBTsAuXRcePi68Hi+oPq41yqQVeRLLpEvY2
         w9KU+8piSaSV74WoAaDezFZmWeu7A3+Hm4/7BYmZpEHINnh89cmCVdcdb2qaHFgT0N
         JuwDfmDc2zZoJhF2tZ/nw5vdJqMnN8ubnWvup3Ok=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 5/7] tracing/probe: Verify alloc_trace_*probe() result
Date:   Wed, 13 Mar 2019 21:28:22 +0900
Message-Id: <155248010204.10815.5677211009139835081.stgit@devnote2>
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

Since alloc_trace_*probe() returns -EINVAL only if !event && !group,
it should not happen in trace_*probe_create(). If we catch that case
there is a bug. So use WARN_ON_ONCE() instead of pr_info().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_uprobe.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5222fd82e7e4..56324c231688 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -693,9 +693,9 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
 			       argc, is_return);
 	if (IS_ERR(tk)) {
-		pr_info("Failed to allocate trace_probe.(%d)\n",
-			(int)PTR_ERR(tk));
 		ret = PTR_ERR(tk);
+		/* This must return -ENOMEM otherwise there is a bug */
+		WARN_ON_ONCE(ret != -ENOMEM);
 		goto out;
 	}
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 52f033489377..b54137ec7810 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -514,8 +514,9 @@ static int trace_uprobe_create(int argc, const char **argv)
 
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
 	if (IS_ERR(tu)) {
-		pr_info("Failed to allocate trace_uprobe.(%d)\n", (int)PTR_ERR(tu));
 		ret = PTR_ERR(tu);
+		/* This must return -ENOMEM otherwise there is a bug */
+		WARN_ON_ONCE(ret != -ENOMEM);
 		goto fail_address_parse;
 	}
 	tu->offset = offset;

