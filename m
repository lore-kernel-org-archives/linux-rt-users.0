Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE926C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36482183E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600776;
	bh=IWqxIGOpvoDkp+YCOfAum5ChAyoOiZ4eMgAcrQ5rbPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=FQUjAldKhvEvWimZ8MP2D/wy6xLsDwqoeWNnqH09xO08/Dj8ZiG5n8NMSShUCF6Tx
	 6EhoO8vYFQybDOC1Xva29UBHwKQOJB4hH3HQY9Tra/e7JKxl2HwNyFJW3BIoKMCpnc
	 amlGnsG7cgjldQR+naXlkntxu0bsOIdubAuLix08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfDRPTU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389520AbfDRPTT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 11:19:19 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C2820821;
        Thu, 18 Apr 2019 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600759;
        bh=IWqxIGOpvoDkp+YCOfAum5ChAyoOiZ4eMgAcrQ5rbPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gI2Sd37f3E/6xBxblak5gFRPIzKhjvpIzeJ0/C7nV3yXJ35B+xX7xFVgdldC9RI4i
         Cxe9UkPMkYo2mFpyNT5vQTcXtodVLemtWaOtnUQwe2tXHWPwa3vuzE6adVohu0HtGN
         J+5g0mmIXTra0ngYABHnI4LaFoy8D/knYOEybqhM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: Check keys for variable references in expressions too
Date:   Thu, 18 Apr 2019 10:18:51 -0500
Message-Id: <e8c3d3d53db5ca90ceea5a46e5413103a6902fc7.1555597045.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

There's an existing check for variable references in keys, but it
doesn't go far enough.  It checks whether a key field is a variable
reference but doesn't check whether it's an expression containing
variable references, which can cause the same problems for callers.

Use the existing field_has_hist_vars() function rather than a direct
top-level flag check to catch all possible variable references.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Vincent Bernat <vincent@bernat.ch>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 453f51ef83ca..cb56c7c456fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -59,7 +59,7 @@
 	C(NO_CLOSING_PAREN,	"No closing paren found"),		\
 	C(SUBSYS_NOT_FOUND,	"Missing subsystem"),			\
 	C(INVALID_SUBSYS_EVENT,	"Invalid subsystem or event name"),	\
-	C(INVALID_REF_KEY,	"Using variable references as keys not supported"), \
+	C(INVALID_REF_KEY,	"Using variable references in keys not supported"), \
 	C(VAR_NOT_FOUND,	"Couldn't find variable"),		\
 	C(FIELD_NOT_FOUND,	"Couldn't find field"),
 
@@ -4506,7 +4506,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			goto out;
 		}
 
-		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (field_has_hist_vars(hist_field, 0))	{
 			hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field_str));
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
-- 
2.14.1

