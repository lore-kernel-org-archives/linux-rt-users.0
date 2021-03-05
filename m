Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61D6C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AE864FE6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEHfL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:43764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCEHfI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C47A6AE85;
        Fri,  5 Mar 2021 07:35:07 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 11/14] pi_stress: Prepare command line parser for long options only
Date:   Fri,  5 Mar 2021 08:34:57 +0100
Message-Id: <20210305073500.17926-12-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Introduce option value enums in order to be able to parse long options
only.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pi_stress.c | 45 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 49f89b7b0136..73f0e6a402e3 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1274,23 +1274,29 @@ int process_sched_line(const char *arg)
 	return retval;
 }
 
+enum option_values {
+	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
+	OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
+	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
+};
+
 void process_command_line(int argc, char **argv)
 {
 	for (;;) {
 		struct option options[] = {
-			{"debug",		no_argument,		NULL, 'd'},
-			{"duration",		required_argument,	NULL, 'D'},
-			{"groups",		required_argument,	NULL, 'g'},
-			{"help",		no_argument,		NULL, 'h'},
-			{"inversions",		required_argument,	NULL, 'i'},
-			{"mlockall",		no_argument,		NULL, 'm'},
-			{"prompt",		no_argument,		NULL, 'p'},
-			{"quiet",		no_argument,		NULL, 'q'},
-			{"rr",			no_argument,		NULL, 'r'},
-			{"sched",		required_argument,	NULL, 's'},
-			{"uniprocessor",	no_argument,		NULL, 'u'},
-			{"verbose",		no_argument,		NULL, 'v'},
-			{"version",		no_argument,		NULL, 'V'},
+			{"debug",		no_argument,		NULL, OPT_DEBUG},
+			{"duration",		required_argument,	NULL, OPT_DURATION},
+			{"groups",		required_argument,	NULL, OPT_GROUPS},
+			{"help",		no_argument,		NULL, OPT_HELP},
+			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
+			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
+			{"prompt",		no_argument,		NULL, OPT_PROMPT},
+			{"quiet",		no_argument,		NULL, OPT_QUIET},
+			{"rr",			no_argument,		NULL, OPT_RR},
+			{"sched",		required_argument,	NULL, OPT_SCHED},
+			{"uniprocessor",	no_argument,		NULL, OPT_UNIPROCESSOR},
+			{"verbose",		no_argument,		NULL, OPT_VERBOSE},
+			{"version",		no_argument,		NULL, OPT_VERSION},
 			{NULL, 0, NULL, 0},
 		};
 
@@ -1298,12 +1304,15 @@ void process_command_line(int argc, char **argv)
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_DEBUG:
 		case 'd':
 			debugging = 1;
 			break;
+		case OPT_DURATION:
 		case 'D':
 			duration = parse_time_string(optarg);
 			break;
+		case OPT_GROUPS:
 		case 'g':
 			ngroups = strtol(optarg, NULL, 10);
 			if (ngroups > num_processors) {
@@ -1314,37 +1323,47 @@ void process_command_line(int argc, char **argv)
 			}
 			pi_info("number of groups set to %d\n", ngroups);
 			break;
+		case OPT_HELP:
 		case 'h':
 			usage(0);
 			break;
+		case OPT_INVERSIONS:
 		case 'i':
 			inversions = strtol(optarg, NULL, 10);
 			pi_info("doing %d inversion per group\n", inversions);
 			break;
+		case OPT_MLOCKALL:
 		case 'm':
 			lockall = 1;
 			break;
+		case OPT_PROMPT:
 		case 'p':
 			prompt = 1;
 			break;
+		case OPT_QUIET:
 		case 'q':
 			verbose = 0;
 			quiet = 1;
 			break;
+		case OPT_RR:
 		case 'r':
 			policy = SCHED_RR;
 			break;
+		case OPT_SCHED:
 		case 's':
 			if (process_sched_line(optarg))
 				pi_error("ignoring invalid options '%s'\n", optarg);
 			break;
+		case OPT_UNIPROCESSOR:
 		case 'u':
 			uniprocessor = 1;
 			break;
+		case OPT_VERBOSE:
 		case 'v':
 			verbose = 1;
 			quiet = 0;
 			break;
+		case OPT_VERSION:
 		case 'V':
 			printf("pi_stress v%1.2f ", VERSION);
 			exit(0);
-- 
2.30.1

