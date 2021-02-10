Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E8FC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D797E64E77
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBJNhY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:37:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:50476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhBJNgl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:36:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 618DCB087;
        Wed, 10 Feb 2021 13:34:59 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 15/16] cyclictest: Remove unecessary local variable
Date:   Wed, 10 Feb 2021 14:34:49 +0100
Message-Id: <20210210133450.6991-16-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The return value is not used, thus we can avoid the unussed local
variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 8356786a80bb..f912bcf82def 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1713,18 +1713,13 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask) {
-		int res;
-
 		errno = 0;
-		res = numa_sched_setaffinity(getpid(), affinity_mask);
-		if (res != 0)
+		if (numa_sched_setaffinity(getpid(), affinity_mask) != 0)
 			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
 	}
 
 	if (trigger) {
-		int retval;
-		retval = trigger_init();
-		if (retval != 0) {
+		if (trigger_init() != 0) {
 			fprintf(stderr, "trigger_init() failed\n");
 			exit(EXIT_FAILURE);
 		}
-- 
2.30.0

