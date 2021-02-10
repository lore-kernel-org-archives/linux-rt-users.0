Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975E4C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CDA64E15
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBJNfq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:35:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:50122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhBJNfi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:35:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EECDEAFCE;
        Wed, 10 Feb 2021 13:34:55 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 04/16] signaltest: Use affinity_mask for steering thread placement
Date:   Wed, 10 Feb 2021 14:34:38 +0100
Message-Id: <20210210133450.6991-5-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We don't need an extra variable to track the state if a bitmask is
available or not. Check directly if the mask is usable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 44 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b3a82f8c4f65..e19fc9a740a9 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -205,15 +205,13 @@ static int verbose;
 static int quiet;
 static int lockall;
 static struct bitmask *affinity_mask = NULL;
-static int smp = 0;
-static int setaffinity = AFFINITY_UNSPECIFIED;
 
 /* Process commandline options */
 static void process_options(int argc, char *argv[], unsigned int max_cpus)
 {
-	int option_affinity = 0;
 	int error = 0;
 	int numa = 0;
+	int smp = 0;
 
 	for (;;) {
 		int option_index = 0;
@@ -238,26 +236,19 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			break;
 		switch (c) {
 		case 'a':
-			option_affinity = 1;
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
 			numa = 1;
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
@@ -275,7 +266,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
 			num_threads = -1; /* update after parsing */
-			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't': num_threads = atoi(optarg); break;
 		case 'v': verbose = 1; break;
@@ -294,16 +284,8 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 	if (num_threads < 2)
 		error = 1;
 
-	/* if smp wasn't requested, test for numa automatically */
-	if (!smp) {
-		if (setaffinity == AFFINITY_UNSPECIFIED)
-			setaffinity = AFFINITY_USEALL;
-	}
-
-	if (option_affinity) {
-		if (smp)
-			warn("-a ignored due to smp mode\n");
-	}
+	if (smp && affinity_mask)
+		warn("-a ignored due to smp mode\n");
 
 	if (error) {
 		if (affinity_mask)
@@ -365,7 +347,7 @@ int main(int argc, char **argv)
 		}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask != NULL) {
+	if (affinity_mask) {
 		int res;
 
 		errno = 0;
@@ -400,21 +382,13 @@ int main(int argc, char **argv)
 			par[i].bufmsk = VALBUF_SIZE - 1;
 		}
 
-		switch (setaffinity) {
-		case AFFINITY_UNSPECIFIED:
-			cpu = -1;
-			break;
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
-		default:
-			cpu = -1;
-		}
+
+		if (verbose)
+			printf("Thread %d using cpu %d.\n", i, cpu);
 
 		par[i].id = i;
 		par[i].prio = priority;
-- 
2.30.0

