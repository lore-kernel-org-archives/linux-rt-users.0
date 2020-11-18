Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B77C64E7B
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613172222C
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgKRTGw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgKRTGw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4CFDBB2D;
        Wed, 18 Nov 2020 19:06:50 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 12/12] rt-migrate-test: Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:42 +0100
Message-Id: <20201118190642.16006-13-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The quiet option is useful for automated test setups where
only the final result of the run is interesting. This avoids
to fill up the logs.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/rt-migrate-test/rt-migrate-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index f1b7e5e4fe8c..9bf716c9178c 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -98,6 +98,7 @@ static unsigned long long now;
 static int done;
 static int loop;
 static int duration;
+static int quiet;
 
 static pthread_barrier_t start_barrier;
 static pthread_barrier_t end_barrier;
@@ -160,6 +161,7 @@ static void usage(int error)
 	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
 	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
 	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
 	       "-s TIME  --sleep-time=TIME Sleep time (ms) between intervals (100)\n\n"
 	       "  () above are defaults \n"
@@ -180,11 +182,12 @@ static void parse_options(int argc, char *argv[])
 			{"loops",	required_argument,	NULL, 'l'},
 			{"maxerr",	required_argument,	NULL, 'm'},
 			{"prio",	required_argument,	NULL, 'p'},
+			{"quiet",	no_argument,		NULL, 'q'},
 			{"run-time",	required_argument,	NULL, 'r'},
 			{"sleep-time",	required_argument,	NULL, 's'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "cD:ehl:m:p:r:s:",
+		int c = getopt_long(argc, argv, "cD:ehl:m:p:qr:s:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -199,6 +202,7 @@ static void parse_options(int argc, char *argv[])
 		case 'l': nr_runs = atoi(optarg); break;
 		case 'm': max_err = usec2nano(atoi(optarg)); break;
 		case 'p': prio_start = atoi(optarg); break;
+		case 'q': quiet = 1; break;
 		case 'r':
 			run_interval = atoi(optarg);
 			break;
@@ -532,7 +536,8 @@ int main (int argc, char **argv)
 	intv.tv_sec = nano2sec(INTERVAL);
 	intv.tv_nsec = INTERVAL % sec2nano(1);
 
-	print_progress_bar(0);
+	if (!quiet)
+		print_progress_bar(0);
 
 	setup_ftrace_marker();
 
@@ -552,7 +557,8 @@ int main (int argc, char **argv)
 
 		nanosleep(&intv, NULL);
 
-		print_progress_bar((loop * 100)/nr_runs);
+		if (!quiet)
+			print_progress_bar((loop * 100)/nr_runs);
 
 		end = get_time();
 		ftrace_write("Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
-- 
2.29.2

