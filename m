Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91472C2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E9723B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgLRQUa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:37366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbgLRQUa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C805AAE4B;
        Fri, 18 Dec 2020 16:19:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 19/20] cyclictest: Remove max cpus used verbose information
Date:   Fri, 18 Dec 2020 17:18:42 +0100
Message-Id: <20201218161843.1764-20-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Since we always print the thread placement in verbose mode now, there
is no need to print the max_cpus anymore. With the last of max_cpus
gone, we can also remove the sysconf() call.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5d1c08e8b8e0..35c57c782f30 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1702,7 +1702,6 @@ int main(int argc, char **argv)
 	int signum = SIGALRM;
 	int mode;
 	int cpu;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
 	void *stack;
@@ -1717,9 +1716,6 @@ int main(int argc, char **argv)
 	if (check_privs())
 		exit(EXIT_FAILURE);
 
-	if (verbose)
-		printf("Max CPUs = %d\n", max_cpus);
-
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask) {
 		int res;
@@ -1728,10 +1724,6 @@ int main(int argc, char **argv)
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
2.29.2

