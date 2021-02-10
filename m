Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B57C4332D
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007F364E7A
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBJNfp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:35:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhBJNfi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:35:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3BB9AFC6;
        Wed, 10 Feb 2021 13:34:55 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 03/16] cyclictest: Simplify --smp vs --affinity vs --threads argument logic
Date:   Wed, 10 Feb 2021 14:34:37 +0100
Message-Id: <20210210133450.6991-4-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Allow each command line only to update one variable and do the final
decission at the end of the parsing step. With this the order
of the command line is not important.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4c02f067fbad..b5cca3ae166b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -880,14 +880,13 @@ static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
 static int policy = SCHED_OTHER;	/* default policy if not specified */
-static int num_threads = 1;
+static int num_threads = -1;
 static int max_cycles;
 static int clocksel = 0;
 static int quiet;
 static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
 static struct bitmask *affinity_mask = NULL;
-static int smp = 0;
 
 static int clocksources[] = {
 	CLOCK_MONOTONIC,
@@ -953,7 +952,7 @@ enum option_values {
 static void process_options(int argc, char *argv[], int max_cpus)
 {
 	int error = 0;
-	int option_affinity = 0;
+	int smp = 0;
 
 	for (;;) {
 		int option_index = 0;
@@ -1008,10 +1007,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		switch (c) {
 		case 'a':
 		case OPT_AFFINITY:
-			option_affinity = 1;
-			/* smp sets AFFINITY_USEALL in OPT_SMP */
-			if (smp)
-				break;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 			} else if (optind < argc &&
@@ -1019,8 +1014,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
-			} else {
-				num_threads = -1;
 			}
 			break;
 		case 'A':
@@ -1108,22 +1101,14 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
-		case OPT_SMP: /* SMP testing */
-			smp = 1;
-			num_threads = -1; /* update after parsing */
-			break;
+		case OPT_SMP:
+			smp = 1; break;
 		case 't':
 		case OPT_THREADS:
-			if (smp) {
-				warn("-t ignored due to smp mode\n");
-				break;
-			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
 			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
-			else
-				num_threads = -1; /* update after parsing */
 			break;
 		case OPT_TRIGGER:
 			trigger = atoi(optarg);
@@ -1179,13 +1164,10 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		use_nanosleep = MODE_CLOCK_NANOSLEEP;
 	}
 
-	if (option_affinity && smp) {
-		warn("-a ignored due to smp mode\n");
-		if (affinity_mask) {
-			numa_bitmask_free(affinity_mask);
-			affinity_mask = NULL;
-		}
-	}
+	if (smp && num_threads != -1)
+		warn("--threads overwrites smp mode\n");
+	if (smp && affinity_mask)
+		warn("--affinity overwrites smp mode\n");
 
 	if (smi) {
 		if (affinity_mask)
-- 
2.30.0

