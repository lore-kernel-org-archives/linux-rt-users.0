Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410BDC43611
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211886135C
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355509AbhESRLQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347430AbhESRLP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2FE9B1B1;
        Wed, 19 May 2021 17:09:54 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 09/23] signaltest: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:31 +0200
Message-Id: <20210519170945.21941-10-dwagner@suse.de>
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
 src/signaltest/signaltest.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index f43920e1a853..2dd22070cb5d 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -187,9 +187,9 @@ static void display_help(int error)
 		"                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 		"                           days.\n"
 		"-h       --help            display usage information\n"
+		"         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 		"-m       --mlockall        lock current and future memory allocations\n"
-		"         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
@@ -210,12 +210,12 @@ static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
 static int numa = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE,
-	OPT_DURATION, OPT_HELP, OPT_LOOPS,
-	OPT_MLOCKALL, OPT_OUTPUT, OPT_PRIORITY,
+	OPT_DURATION, OPT_HELP, OPT_JSON,
+	OPT_LOOPS, OPT_MLOCKALL, OPT_PRIORITY,
 	OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_VERBOSE
 };
 
@@ -233,9 +233,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
 			{"duration",	required_argument,	NULL, OPT_DURATION},
 			{"help",	no_argument,		NULL, OPT_HELP},
+			{"json",	required_argument,	NULL, OPT_JSON},
 			{"loops",	required_argument,	NULL, OPT_LOOPS},
 			{"mlockall",	no_argument,		NULL, OPT_MLOCKALL},
-			{"output",	required_argument,	NULL, OPT_OUTPUT},
 			{"priority",	required_argument,	NULL, OPT_PRIORITY},
 			{"quiet",	no_argument,		NULL, OPT_QUIET},
 			{"smp",		no_argument,		NULL, OPT_SMP},
@@ -287,6 +287,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		case 'h':
 			display_help(0);
 			break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_LOOPS:
 		case 'l':
 			max_cycles = atoi(optarg);
@@ -295,9 +298,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		case 'm':
 			lockall = 1;
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case OPT_PRIORITY:
 		case 'p':
 			priority = atoi(optarg);
@@ -558,8 +558,8 @@ int main(int argc, char **argv)
 		if (stat[i].values)
 			free(stat[i].values);
 	}
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, ret, write_stats, par);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, ret, write_stats, par);
 
 	free(stat);
  outpar:
-- 
2.31.1

