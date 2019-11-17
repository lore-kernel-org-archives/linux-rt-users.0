Return-Path: <SRS0=g5oN=ZJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A05FC432C0
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 Nov 2019 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CACC2068D
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 Nov 2019 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfKQVkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 17 Nov 2019 16:40:46 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:55826 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfKQVkq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 17 Nov 2019 16:40:46 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5C7C983D6EC; Sun, 17 Nov 2019 22:40:44 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH rt-tests] cyclictest: fix typos
Date:   Sun, 17 Nov 2019 22:40:38 +0100
Message-Id: <20191117214038.28094-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The called function is called clock_gettime with "only" two t as can be
seen tree lines above. Also there was a wrong r in useful.
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 6be0525822ca..bca028fedffd 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -802,7 +802,7 @@ static void *timerthread(void *param)
 		ret = clock_gettime(par->clock, &now);
 		if (ret != 0) {
 			if (ret != EINTR)
-				warn("clock_getttime() failed. errno: %d\n",
+				warn("clock_gettime() failed. errno: %d\n",
 				     errno);
 			goto out;
 		}
@@ -964,7 +964,7 @@ static void display_help(int error)
 	       "			   but will not drain your battery so quickly\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
-	       "			   latency is hit. Userful for low bandwidth.\n"
+	       "			   latency is hit. Useful for low bandwidth.\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
-- 
2.24.0

