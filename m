Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C38C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22A064E77
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBJNhN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:37:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:50640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhBJNgX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:36:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14A99B07D;
        Wed, 10 Feb 2021 13:34:59 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 14/16] cyclictest: Remove max cpus used verbose information
Date:   Wed, 10 Feb 2021 14:34:48 +0100
Message-Id: <20210210133450.6991-15-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Since we always print the thread placement in verbose mode now, there
is no need to print the max_cpus anymore. With the last of max_cpus
gone, we can also remove the sysconf() call.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7a0501031857..8356786a80bb 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1697,8 +1697,6 @@ int main(int argc, char **argv)
 	int signum = SIGALRM;
 	int mode;
 	int cpu;
-	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
-	int online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
 	void *stack;
@@ -1713,11 +1711,6 @@ int main(int argc, char **argv)
 	if (check_privs())
 		exit(EXIT_FAILURE);
 
-	if (verbose) {
-		printf("Max CPUs = %d\n", max_cpus);
-		printf("Online CPUs = %d\n", online_cpus);
-	}
-
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask) {
 		int res;
@@ -1726,10 +1719,6 @@ int main(int argc, char **argv)
 		res = numa_sched_setaffinity(getpid(), affinity_mask);
 		if (res != 0)
 			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
-
-		if (verbose)
-			printf("Using %u cpus.\n",
-				numa_bitmask_weight(affinity_mask));
 	}
 
 	if (trigger) {
-- 
2.30.0

