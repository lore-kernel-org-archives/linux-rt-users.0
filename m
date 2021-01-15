Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A3CC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3385923A5E
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbhAOTLB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:11:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:43850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733203AbhAOTLB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jan 2021 14:11:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D756AE89;
        Fri, 15 Jan 2021 19:09:40 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 05/19] cyclictest: Remove libnuma API version 1 support
Date:   Fri, 15 Jan 2021 20:09:22 +0100
Message-Id: <20210115190936.26148-6-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115190936.26148-1-dwagner@suse.de>
References: <20210115190936.26148-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The code depends on libnuma API version 2 or higher. Remove the
leftover.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c0e7600b4740..245752dae2af 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -807,17 +807,12 @@ static void display_help(int error)
 	printf("cyclictest V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "cyclictest <options>\n\n"
-#if LIBNUMA_API_VERSION >= 2
 	       "-a [CPUSET] --affinity     Run thread #N on processor #N, if possible, or if CPUSET\n"
 	       "                           given, pin threads to that set of processors in round-\n"
 	       "                           robin order.  E.g. -a 2 pins all threads to CPU 2,\n"
 	       "                           but -a 3-5,0 -t 5 will run the first and fifth\n"
 	       "                           threads on CPU (0),thread #2 on CPU 3, thread #3\n"
 	       "                           on CPU 4, and thread #5 on CPU 5.\n"
-#else
-	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
-	       "                           with NUM pin all threads to the processor NUM\n"
-#endif
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
-- 
2.29.2

