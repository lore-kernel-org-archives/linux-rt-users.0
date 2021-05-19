Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9760C43462
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940B7611BF
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347514AbhESRLO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347430AbhESRLO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45F23B19F;
        Wed, 19 May 2021 17:09:53 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 04/23] pi_stress: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:26 +0200
Message-Id: <20210519170945.21941-5-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519170945.21941-1-dwagner@suse.de>
References: <20210519170945.21941-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The initial idea was to have several different output format
supported but it turns out everyone is happy with JSON, so
there is no need to add another format.

Thus let's make the command line option more specific and
rename it to --json.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pi_stress.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 3f93d4aadd53..7782ea717c55 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -100,7 +100,7 @@ int debugging = 0;
 int quiet = 0;	/* turn off all prints, default = 0 (off) */
 
 /* filename for JSON output */
-char outfile[MAX_PATH];
+char jsonfile[MAX_PATH];
 
 /* prompt to start test */
 int prompt = 0;
@@ -342,8 +342,8 @@ int main(int argc, char **argv)
 	finish = time(NULL);
 	summary();
 
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, retval, write_stats, NULL);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, retval, write_stats, NULL);
 
 	if (lockall)
 		munlockall();
@@ -992,8 +992,8 @@ void usage(int error)
 	       "-g N     --groups=N        set the number of inversion groups\n"
 	       "-h       --help            print this message\n"
 	       "-i INV   --inversions=INV  number of inversions per group (default is infinite)\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-m       --mlockall        lock current and future memory\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p       --prompt          prompt before starting the test\n"
 	       "-q       --quiet           suppress running output\n"
 	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
@@ -1287,7 +1287,7 @@ int process_sched_line(const char *arg)
 
 enum option_values {
 	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
-	OPT_MLOCKALL, OPT_OUTPUT, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
+	OPT_JSON, OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
 	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
 };
 
@@ -1300,8 +1300,8 @@ void process_command_line(int argc, char **argv)
 			{"groups",		required_argument,	NULL, OPT_GROUPS},
 			{"help",		no_argument,		NULL, OPT_HELP},
 			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
+			{"json",		required_argument,	NULL, OPT_JSON},
 			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
-			{"output",		required_argument,	NULL, OPT_OUTPUT},
 			{"prompt",		no_argument,		NULL, OPT_PROMPT},
 			{"quiet",		no_argument,		NULL, OPT_QUIET},
 			{"rr",			no_argument,		NULL, OPT_RR},
@@ -1344,13 +1344,13 @@ void process_command_line(int argc, char **argv)
 			inversions = strtol(optarg, NULL, 10);
 			pi_info("doing %d inversion per group\n", inversions);
 			break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_MLOCKALL:
 		case 'm':
 			lockall = 1;
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case OPT_PROMPT:
 		case 'p':
 			prompt = 1;
-- 
2.31.1

