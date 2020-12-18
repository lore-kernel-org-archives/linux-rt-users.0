Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF47C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A6323B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgLRQUz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbgLRQUz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E6FDAFE2;
        Fri, 18 Dec 2020 16:19:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 20/20] cyclictest: Remove unecessary local variable
Date:   Fri, 18 Dec 2020 17:18:43 +0100
Message-Id: <20201218161843.1764-21-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The return value is not used, thus we can avoid the unussed local
variable.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 35c57c782f30..5c738005f778 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1718,18 +1718,13 @@ int main(int argc, char **argv)
 
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
2.29.2

