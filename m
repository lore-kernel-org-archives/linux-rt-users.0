Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF3C55ABD
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023A022255
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKMVJW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgKMVJW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD5A0B01C;
        Fri, 13 Nov 2020 21:09:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 5/6] cyclictest: Use parse_cpumask() from rt-numa.h
Date:   Fri, 13 Nov 2020 22:09:09 +0100
Message-Id: <20201113210910.21807-6-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use the helper funtion from rt-numa.h to parse the cpumask from the
command line.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 70 ++++++++-----------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 46d88ed155c5..f10f064f7a8e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -36,6 +36,7 @@
 #include "rt_numa.h"
 
 #include "rt-utils.h"
+#include "rt-numa.h"
 
 #include <bionic.h>
 
@@ -905,11 +906,6 @@ static int clocksources[] = {
 	CLOCK_REALTIME,
 };
 
-static unsigned int is_cpumask_zero(const struct bitmask *mask)
-{
-	return (rt_numa_bitmask_count(mask) == 0);
-}
-
 /* Get available cpus according to getaffinity or according to the
  * intersection of getaffinity and the user specified affinity
  * in the case of AFFINITY_SPECIFIED, the function has to be called
@@ -976,53 +972,6 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
-
-/* After this function is called, affinity_mask is the intersection of the user
- * supplied affinity mask and the affinity mask from the run time environment
- */
-static void use_current_cpuset(const int max_cpus)
-{
-	int i;
-	pid_t pid;
-	struct bitmask *curmask;
-
-	pid = getpid();
-
-	curmask = numa_allocate_cpumask();
-	numa_sched_getaffinity(pid, curmask);
-
-	/* Clear bits that are not set in both the cpuset from the environment,
-	 * and in the user specified affinity for cyclictest
-	 */
-	for (i=0; i < max_cpus; i++) {
-		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i)))
-			numa_bitmask_clearbit(affinity_mask, i);
-	}
-
-	numa_bitmask_free(curmask);
-}
-
-static void parse_cpumask(const char *option, const int max_cpus)
-{
-	affinity_mask = rt_numa_parse_cpustring(option, max_cpus);
-	if (affinity_mask) {
-		if (is_cpumask_zero(affinity_mask)) {
-			rt_bitmask_free(affinity_mask);
-			affinity_mask = NULL;
-		} else {
-			use_current_cpuset(max_cpus);
-		}
-
-	}
-	if (!affinity_mask)
-		display_help(1);
-
-	if (verbose) {
-		printf("%s: Using %u cpus.\n", __func__,
-			rt_numa_bitmask_count(affinity_mask));
-	}
-}
-
 static void handlepolicy(char *polname)
 {
 	if (strncasecmp(polname, "other", 5) == 0)
@@ -1156,15 +1105,24 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			if (smp)
 				break;
 			numa_initialize();
-			if (optarg != NULL) {
-				parse_cpumask(optarg, max_cpus);
+			if (optarg) {
+				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind < argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
-				parse_cpumask(argv[optind], max_cpus);
+			} else if (optind < argc &&
+				   (atoi(argv[optind]) ||
+				    argv[optind][0] == '0' ||
+				    argv[optind][0] == '!')) {
+				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
 				setaffinity = AFFINITY_USEALL;
 			}
+
+			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
+				display_help(1);
+			if (verbose)
+				printf("Using %u cpus.\n",
+					numa_bitmask_weight(affinity_mask));
 			break;
 		case 'A':
 		case OPT_ALIGNED:
-- 
2.29.2

