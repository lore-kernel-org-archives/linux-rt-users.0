Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D6C2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FA223B79
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgLRQTd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:19:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbgLRQTd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:19:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76656ADD9;
        Fri, 18 Dec 2020 16:18:51 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 03/20] cyclictest: Use affinity_mask for stearing thread placement
Date:   Fri, 18 Dec 2020 17:18:26 +0100
Message-Id: <20201218161843.1764-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We don't need an extra variable to track the state if a bitmask is
available or not. Check directly if the mask is usable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a5ca764da254..3dafef4e7e5a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -893,7 +893,6 @@ static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
 static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
-static int setaffinity = AFFINITY_UNSPECIFIED;
 
 static int clocksources[] = {
 	CLOCK_MONOTONIC,
@@ -1020,19 +1019,13 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				break;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
-				setaffinity = AFFINITY_SPECIFIED;
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
-				setaffinity = AFFINITY_SPECIFIED;
-			} else {
-				setaffinity = AFFINITY_USEALL;
 			}
 
-			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
-				display_help(1);
 			if (verbose)
 				printf("Using %u cpus.\n",
 					numa_bitmask_weight(affinity_mask));
@@ -1125,7 +1118,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case OPT_SMP: /* SMP testing */
 			smp = 1;
 			num_threads = -1; /* update after parsing */
-			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't':
 		case OPT_THREADS:
@@ -1194,23 +1186,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		use_nanosleep = MODE_CLOCK_NANOSLEEP;
 	}
 
-	/* if smp wasn't requested, test for numa automatically */
-	if (!smp) {
-		if (setaffinity == AFFINITY_UNSPECIFIED)
-			setaffinity = AFFINITY_USEALL;
-	}
-
 	if (option_affinity && smp) {
 		warn("-a ignored due to smp mode\n");
 		if (affinity_mask) {
 			numa_bitmask_free(affinity_mask);
 			affinity_mask = NULL;
 		}
-		setaffinity = AFFINITY_USEALL;
 	}
 
 	if (smi) {
-		if (setaffinity == AFFINITY_UNSPECIFIED)
+		if (affinity_mask)
 			fatal("SMI counter relies on thread affinity\n");
 
 		if (!has_smi_counter())
@@ -1756,7 +1741,7 @@ int main(int argc, char **argv)
 		printf("Max CPUs = %d\n", max_cpus);
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask != NULL) {
+	if (affinity_mask) {
 		int res;
 
 		errno = 0;
@@ -1915,18 +1900,13 @@ int main(int argc, char **argv)
 		if (status != 0)
 			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
 
-		switch (setaffinity) {
-		case AFFINITY_UNSPECIFIED: cpu = -1; break;
-		case AFFINITY_SPECIFIED:
+		if (affinity_mask)
 			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
-			if (verbose)
-				printf("Thread %d using cpu %d.\n", i, cpu);
-			break;
-		case AFFINITY_USEALL:
+		else
 			cpu = cpu_for_thread_ua(i, max_cpus);
-			break;
-		default: cpu = -1;
-		}
+
+		if (verbose)
+			printf("Thread %d using cpu %d.\n", i, cpu);
 
 		/* find the memory node associated with the cpu i */
 		node = numa_node_of_cpu(cpu);
-- 
2.29.2

