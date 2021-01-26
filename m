Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFAC4332E
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCED022795
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390796AbhAZRUR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbhAZJRZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:17:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7145CB81E;
        Tue, 26 Jan 2021 09:15:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v3 06/16] rt-numa: Remove unused definitions and numa_initialize()
Date:   Tue, 26 Jan 2021 10:14:50 +0100
Message-Id: <20210126091500.31735-7-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126091500.31735-1-dwagner@suse.de>
References: <20210126091500.31735-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no user left of the AFFINITY_* enum. Remove them.

Also there is no need for numa_initialize() to prodect from being
called several times. We can safely initialize libnuma at the begin of
each program.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c |  2 +-
 src/include/rt-numa.h       |  8 --------
 src/lib/rt-numa.c           | 15 ---------------
 src/signaltest/signaltest.c |  2 +-
 4 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b5cca3ae166b..3c6773c1dbb5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1705,7 +1705,7 @@ int main(int argc, char **argv)
 	void *currstk;
 	size_t stksize;
 
-	if (numa_initialize())
+	if (numa_available() == -1)
 		fatal("Couldn't initialize libnuma");
 
 	process_options(argc, argv, max_cpus);
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index ca86a45dab3a..54f5c3a240e9 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -4,14 +4,6 @@
 
 #include <numa.h>
 
-enum {
-	AFFINITY_UNSPECIFIED,
-	AFFINITY_SPECIFIED,
-	AFFINITY_USEALL
-};
-
-int numa_initialize(void);
-
 int get_available_cpus(struct bitmask *cpumask);
 int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask);
 int cpu_for_thread_ua(int thread_num, int max_cpus);
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 33fddba4358e..fa83eae61084 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -13,21 +13,6 @@
 #include "error.h"
 #include "rt-numa.h"
 
-/* numa_available() must be called before any other calls to the numa library */
-int numa_initialize(void)
-{
-	static int is_initialized;
-
-	if (is_initialized == 1)
-		return 0;
-
-	if (numa_available() == -1)
-		return -1;
-
-	is_initialized = 1;
-	return 0;
-}
-
 int get_available_cpus(struct bitmask *cpumask)
 {
 	if (cpumask)
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 61420fa13347..41ebb2c87a2f 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 	int status, cpu;
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if (numa_initialize())
+	if (numa_available() == -1)
 		fatal("Couldn't initialize libnuma");
 
 	process_options(argc, argv, max_cpus);
-- 
2.30.0

