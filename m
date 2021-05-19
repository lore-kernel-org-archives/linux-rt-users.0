Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B4C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38D9611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347527AbhESRLP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347431AbhESRLO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EF8AB1A1;
        Wed, 19 May 2021 17:09:53 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 05/23] pmqtest: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:27 +0200
Message-Id: <20210519170945.21941-6-dwagner@suse.de>
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
 src/pmqtest/pmqtest.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index af10b416600c..edda7c69652e 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -231,8 +231,8 @@ static void display_help(int error)
 	       "-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
 	       "-h       --help            print this help message\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-S       --smp             SMP testing: options -a -t and same priority\n"
@@ -260,13 +260,12 @@ static int sameprio;
 static int timeout;
 static int forcetimeout;
 static int quiet;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 enum option_value {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
-	OPT_FORCETIMEOUT, OPT_HELP, OPT_INTERVAL, OPT_LOOPS,
-	OPT_OUTPUT, OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS,
-	OPT_TIMEOUT
+	OPT_FORCETIMEOUT, OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS,
+	OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_TIMEOUT
 };
 
 static void process_options(int argc, char *argv[])
@@ -285,8 +284,8 @@ static void process_options(int argc, char *argv[])
 			{"forcetimeout",required_argument,	NULL, OPT_FORCETIMEOUT},
 			{"help",	no_argument,		NULL, OPT_HELP},
 			{"interval",	required_argument,	NULL, OPT_INTERVAL},
+			{"json",	required_argument,      NULL, OPT_JSON },
 			{"loops",	required_argument,	NULL, OPT_LOOPS},
-			{"output",	required_argument,      NULL, OPT_OUTPUT },
 			{"priority",	required_argument,	NULL, OPT_PRIORITY},
 			{"quiet",	no_argument,		NULL, OPT_QUIET},
 			{"smp",		no_argument,		NULL, OPT_SMP},
@@ -340,13 +339,13 @@ static void process_options(int argc, char *argv[])
 		case 'i':
 			interval = atoi(optarg);
 			break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_LOOPS:
 		case 'l':
 			max_cycles = atoi(optarg);
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case OPT_PRIORITY:
 		case 'p':
 			priority = atoi(optarg);
@@ -647,12 +646,12 @@ int main(int argc, char *argv[])
 		mq_unlink(mqname);
 	}
 
-	if (strlen(outfile) != 0) {
+	if (strlen(jsonfile) != 0) {
 		struct params_stats ps = {
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, 0, write_stats, &ps);
+		rt_write_json(jsonfile, 0, write_stats, &ps);
 	}
 
 nomem:
-- 
2.31.1

