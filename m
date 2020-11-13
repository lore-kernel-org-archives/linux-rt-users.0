Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F045FC63697
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972C022255
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMVJV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKMVJU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64C03B016;
        Fri, 13 Nov 2020 21:09:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 3/6] cyclictest: Remove deadcode checking for NUMA
Date:   Fri, 13 Nov 2020 22:09:07 +0100
Message-Id: <20201113210910.21807-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The NUMA library is always present for cyclictest, thus NUMA config is
always defined. Remove deadcode.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3282ab1b856b..46d88ed155c5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1327,14 +1327,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
-#ifdef NUMA
 		numa_initialize();
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
-#else
-		warn("cyclictest was not built with the numa option\n");
-		numa = 0;
-#endif
 	}
 
 	if (option_affinity) {
-- 
2.29.2

