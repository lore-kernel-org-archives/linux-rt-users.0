Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E4C11F65
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655D061CC7
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhF1UOi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:14:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44574 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhF1UOe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Jun 2021 16:14:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8B902252B;
        Mon, 28 Jun 2021 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rc/qNcNxNvDfyB9Opc/4Qx89B/Ar6WNS7W1HYkpOpx4=;
        b=KitMZHxhB7l6FarfXd9GWyJwhanBacn/bK3CfjGRSZ9cuyG5chcrVZNzPACDu6WbLkqZDo
        U77pk0G1NzCMKFF47EXXNeVPCO3onhBPTMLFw/5Zrz61jpWu5TG672teuljzx5PR+Xdc8E
        lhgWseHePYTERZgiG9X+oByFVdUd570=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rc/qNcNxNvDfyB9Opc/4Qx89B/Ar6WNS7W1HYkpOpx4=;
        b=7tGsXjeut0gcOL4SvaTz/t/lBNABQIlSxi/BrlBTv324rzl/sjuqm76FmgytGV5qnrgn+V
        9qOJ5XEjhaRPwCCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8C8B311906;
        Mon, 28 Jun 2021 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rc/qNcNxNvDfyB9Opc/4Qx89B/Ar6WNS7W1HYkpOpx4=;
        b=KitMZHxhB7l6FarfXd9GWyJwhanBacn/bK3CfjGRSZ9cuyG5chcrVZNzPACDu6WbLkqZDo
        U77pk0G1NzCMKFF47EXXNeVPCO3onhBPTMLFw/5Zrz61jpWu5TG672teuljzx5PR+Xdc8E
        lhgWseHePYTERZgiG9X+oByFVdUd570=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rc/qNcNxNvDfyB9Opc/4Qx89B/Ar6WNS7W1HYkpOpx4=;
        b=7tGsXjeut0gcOL4SvaTz/t/lBNABQIlSxi/BrlBTv324rzl/sjuqm76FmgytGV5qnrgn+V
        9qOJ5XEjhaRPwCCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gbJOIRct2mAJLwAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 28 Jun 2021 20:12:07 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 1/2] rt-utils: Call get_timestmap() in rt_init()
Date:   Mon, 28 Jun 2021 22:12:02 +0200
Message-Id: <20210628201203.30974-2-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628201203.30974-1-dwagner@suse.de>
References: <20210628201203.30974-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Move the get_timestamp() from rt_test_start() to rt_init(). The idea
of rt_test_start() was to get the start timestamp right before the
'main loop' for the test starts. At least for cyclictest the
rt_test_start() was placed wrongly so that the first test cycle could
hit the pagefault when strftime() wrote into the tsbuf.

We don't have an exact semantic description what start test timestamp
means, so the simplest thing to avoid any further problems with it, is
to take the timestamp right at the beginning when the program
starts. Most test programs have a very short setup phase anyway.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/lib/rt-utils.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index d264c348ad42..11f386098867 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -490,6 +490,19 @@ void disable_trace_mark(void)
 	close_tracemark_fd();
 }
 
+static void get_timestamp(char *tsbuf)
+{
+	struct timeval tv;
+	struct tm *tm;
+	time_t t;
+
+	gettimeofday(&tv, NULL);
+	t = tv.tv_sec;
+	tm = localtime(&t);
+	/* RFC 2822-compliant date format */
+	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
+}
+
 void rt_init(int argc, char *argv[])
 {
 	int offset = 0;
@@ -514,24 +527,12 @@ void rt_init(int argc, char *argv[])
 
 		offset += len + 1;
 	}
-}
 
-static void get_timestamp(char *tsbuf)
-{
-	struct timeval tv;
-	struct tm *tm;
-	time_t t;
-
-	gettimeofday(&tv, NULL);
-	t = tv.tv_sec;
-	tm = localtime(&t);
-	/* RFC 2822-compliant date format */
-	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
+	get_timestamp(ts_start);
 }
 
 void rt_test_start(void)
 {
-	get_timestamp(ts_start);
 }
 
 void rt_write_json(const char *filename, int return_code,
-- 
2.32.0

