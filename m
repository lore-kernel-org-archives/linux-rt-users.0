Return-Path: <SRS0=KLW2=Z6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E0C43603
	for <linux-rt-users@archiver.kernel.org>; Sun,  8 Dec 2019 21:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A9A206D5
	for <linux-rt-users@archiver.kernel.org>; Sun,  8 Dec 2019 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfLHVG3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:06:29 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:42554 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfLHVG3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 8 Dec 2019 16:06:29 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id E85618694B0; Sun,  8 Dec 2019 22:06:27 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH rt-tests] queuelat: use ARM implementation of gettick also for all !x86 archs
Date:   Sun,  8 Dec 2019 22:06:25 +0100
Message-Id: <20191208210625.5999-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This fixes a build error on arm64, mips*, ppc and several others
---
 src/queuelat/queuelat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index cccb50ef0cc4..98346f346f82 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -283,7 +283,7 @@ static inline unsigned long long __rdtscll(void)
 
 #define gettick(val) do { (val) = __rdtscll(); } while (0)
 
-#elif defined __arm__
+#else
 
 static inline unsigned long long __clock_gettime(void)
 {
-- 
2.24.0

