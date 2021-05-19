Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C4C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6395C611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347642AbhESRLP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244642AbhESRLP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 241E5B1A5;
        Wed, 19 May 2021 17:09:54 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 07/23] rt-migrate-test: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:29 +0200
Message-Id: <20210519170945.21941-8-dwagner@suse.de>
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
 src/rt-migrate-test/rt-migrate-test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 1e0abdd6c0fa..0c4dabeee249 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -102,7 +102,7 @@ static int done;
 static int loop;
 static int duration;
 static int quiet;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 static pthread_barrier_t start_barrier;
 static pthread_barrier_t end_barrier;
@@ -162,9 +162,9 @@ static void usage(int error)
 	       "                           days.\n"
 	       "-e       --equal           Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
 	       "-h       --help            Print this help message\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
 	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
@@ -175,8 +175,8 @@ static void usage(int error)
 }
 
 enum option_value {
-	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_LOOPS,
-	OPT_MAXERR, OPT_OUTPUT, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
+	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_JSON,
+	OPT_LOOPS, OPT_MAXERR, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
 	OPT_SLEEP_TIME
 };
 
@@ -190,9 +190,9 @@ static void parse_options(int argc, char *argv[])
 			{"duration",	required_argument,	NULL, OPT_DURATION},
 			{"equal",	no_argument,		NULL, OPT_EQUAL},
 			{"help",	no_argument,		NULL, OPT_HELP},
+			{"json",	required_argument,      NULL, OPT_JSON},
 			{"loops",	required_argument,	NULL, OPT_LOOPS},
 			{"maxerr",	required_argument,	NULL, OPT_MAXERR},
-			{"output",	required_argument,      NULL, OPT_OUTPUT },
 			{"prio",	required_argument,	NULL, OPT_PRIO},
 			{"quiet",	no_argument,		NULL, OPT_QUIET},
 			{"run-time",	required_argument,	NULL, OPT_RUN_TIME},
@@ -221,6 +221,9 @@ static void parse_options(int argc, char *argv[])
 		case 'h':
 			usage(0);
 			break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_LOOPS:
 		case 'l':
 			nr_runs = atoi(optarg);
@@ -229,9 +232,6 @@ static void parse_options(int argc, char *argv[])
 		case 'm':
 			max_err = usec2nano(atoi(optarg));
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case OPT_PRIO:
 		case 'p':
 			prio_start = atoi(optarg);
@@ -663,8 +663,8 @@ int main (int argc, char **argv)
 
 	print_results();
 
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, check < 0, write_stats, NULL);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, check < 0, write_stats, NULL);
 
 	if (stop) {
 		/*
-- 
2.31.1

