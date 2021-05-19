Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3088DC4360C
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EF3611BD
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbhESRLP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347458AbhESRLO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D670DB1A4;
        Wed, 19 May 2021 17:09:53 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 06/23] ptsematest: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:28 +0200
Message-Id: <20210519170945.21941-7-dwagner@suse.de>
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
 src/ptsematest/ptsematest.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 70eb79e89635..5822164386de 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -155,8 +155,8 @@ static void display_help(int error)
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days.\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-S       --smp             SMP testing: options -a -t and same priority\n"
@@ -182,11 +182,11 @@ static int distance = 500;
 static int smp;
 static int sameprio;
 static int quiet;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 enum option_value {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
-	OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT, OPT_PRIORITY,
+	OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS, OPT_PRIORITY,
 	OPT_QUIET, OPT_SMP, OPT_THREADS
 };
 
@@ -205,8 +205,8 @@ static void process_options(int argc, char *argv[])
 			{"duration",	required_argument,	NULL, OPT_DURATION},
 			{"help",	no_argument,		NULL, OPT_HELP},
 			{"interval",	required_argument,	NULL, OPT_INTERVAL},
+			{"json",	required_argument,      NULL, OPT_JSON },
 			{"loops",	required_argument,	NULL, OPT_LOOPS},
-			{"output",	required_argument,      NULL, OPT_OUTPUT },
 			{"priority",	required_argument,	NULL, OPT_PRIORITY},
 			{"quiet",	no_argument	,	NULL, OPT_QUIET},
 			{"smp",		no_argument,		NULL, OPT_SMP},
@@ -250,6 +250,9 @@ static void process_options(int argc, char *argv[])
 		case 'i':
 			interval = atoi(optarg);
 			break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_HELP:
 		case '?':
 		case 'h':
@@ -259,9 +262,6 @@ static void process_options(int argc, char *argv[])
 		case 'l':
 			max_cycles = atoi(optarg);
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case OPT_PRIORITY:
 		case 'p':
 			priority = atoi(optarg);
@@ -515,12 +515,12 @@ int main(int argc, char *argv[])
 		pthread_mutex_destroy(&syncmutex[i]);
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

