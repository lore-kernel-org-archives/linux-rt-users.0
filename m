Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6EC43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D7364E65
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhBJRxk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:53:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhBJRxR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:53:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD2D7AE6E;
        Wed, 10 Feb 2021 17:51:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v5 12/13] rt-migrate-test: Add JSON output feature
Date:   Wed, 10 Feb 2021 18:51:17 +0100
Message-Id: <20210210175118.19709-13-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210175118.19709-1-dwagner@suse.de>
References: <20210210175118.19709-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/rt-migrate-test/rt-migrate-test.c | 120 ++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 19 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 9bf716c9178c..56b7b66ccdf4 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -19,11 +19,14 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <sys/time.h>
-#include <linux/unistd.h>
 #include <sys/syscall.h>
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
+#include <inttypes.h>
+
+#include <linux/unistd.h>
+
 #include "rt-utils.h"
 
 int nr_tasks;
@@ -99,6 +102,7 @@ static int done;
 static int loop;
 static int duration;
 static int quiet;
+static char outfile[MAX_PATH];
 
 static pthread_barrier_t start_barrier;
 static pthread_barrier_t end_barrier;
@@ -160,6 +164,7 @@ static void usage(int error)
 	       "-h       --help            Print this help message\n"
 	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
 	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
@@ -169,22 +174,29 @@ static void usage(int error)
 	exit(error);
 }
 
+enum option_value {
+	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_LOOPS,
+	OPT_MAXERR, OPT_OUTPUT, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
+	OPT_SLEEP_TIME
+};
+
 static void parse_options(int argc, char *argv[])
 {
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"check",	no_argument,		NULL, 'c'},
-			{"duration",	required_argument,	NULL, 'D'},
-			{"equal",	no_argument,		NULL, 'e'},
-			{"help",	no_argument,		NULL, 'h'},
-			{"loops",	required_argument,	NULL, 'l'},
-			{"maxerr",	required_argument,	NULL, 'm'},
-			{"prio",	required_argument,	NULL, 'p'},
-			{"quiet",	no_argument,		NULL, 'q'},
-			{"run-time",	required_argument,	NULL, 'r'},
-			{"sleep-time",	required_argument,	NULL, 's'},
+			{"check",	no_argument,		NULL, OPT_CHECK},
+			{"duration",	required_argument,	NULL, OPT_DURATION},
+			{"equal",	no_argument,		NULL, OPT_EQUAL},
+			{"help",	no_argument,		NULL, OPT_HELP},
+			{"loops",	required_argument,	NULL, OPT_LOOPS},
+			{"maxerr",	required_argument,	NULL, OPT_MAXERR},
+			{"output",	required_argument,      NULL, OPT_OUTPUT },
+			{"prio",	required_argument,	NULL, OPT_PRIO},
+			{"quiet",	no_argument,		NULL, OPT_QUIET},
+			{"run-time",	required_argument,	NULL, OPT_RUN_TIME},
+			{"sleep-time",	required_argument,	NULL, OPT_SLEEP_TIME},
 			{NULL, 0, NULL, 0}
 		};
 		int c = getopt_long(argc, argv, "cD:ehl:m:p:qr:s:",
@@ -192,21 +204,50 @@ static void parse_options(int argc, char *argv[])
 		if (c == -1)
 			break;
 		switch (c) {
-		case 'c': check = 1; break;
-		case 'D': duration = parse_time_string(optarg); break;
-		case 'e': equal = 1; break;
+		case OPT_CHECK:
+		case 'c':
+			check = 1;
+			break;
+		case OPT_DURATION:
+		case 'D':
+			duration = parse_time_string(optarg);
+			break;
+		case OPT_EQUAL:
+		case 'e':
+			equal = 1;
+			break;
+		case OPT_HELP:
 		case '?':
 		case 'h':
 			usage(0);
 			break;
-		case 'l': nr_runs = atoi(optarg); break;
-		case 'm': max_err = usec2nano(atoi(optarg)); break;
-		case 'p': prio_start = atoi(optarg); break;
-		case 'q': quiet = 1; break;
+		case OPT_LOOPS:
+		case 'l':
+			nr_runs = atoi(optarg);
+			break;
+		case OPT_MAXERR:
+		case 'm':
+			max_err = usec2nano(atoi(optarg));
+			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
+		case OPT_PRIO:
+		case 'p':
+			prio_start = atoi(optarg);
+			break;
+		case OPT_QUIET:
+		case 'q':
+			quiet = 1;
+			break;
+		case OPT_RUN_TIME:
 		case 'r':
 			run_interval = atoi(optarg);
 			break;
-		case 's': interval = atoi(optarg); break;
+		case OPT_SLEEP_TIME:
+		case 's':
+			interval = atoi(optarg);
+			break;
 		default:
 			usage(1);
 		}
@@ -313,6 +354,44 @@ static void print_results(void)
 	}
 }
 
+static void write_stats(FILE *f, void *data)
+{
+	int i;
+	int t;
+	unsigned long long tasks_max[nr_tasks];
+	unsigned long long tasks_min[nr_tasks];
+	unsigned long long tasks_avg[nr_tasks];
+
+	memset(tasks_max, 0, sizeof(tasks_max[0])*nr_tasks);
+	memset(tasks_min, 0xff, sizeof(tasks_min[0])*nr_tasks);
+	memset(tasks_avg, 0, sizeof(tasks_avg[0])*nr_tasks);
+
+	for (i=0; i < nr_runs; i++) {
+		for (t=0; t < nr_tasks; t++) {
+			unsigned long long itv = intervals[i][t];
+
+			if (tasks_max[t] < itv)
+				tasks_max[t] = itv;
+			if (tasks_min[t] > itv)
+				tasks_min[t] = itv;
+			tasks_avg[t] += itv;
+		}
+	}
+
+	fprintf(f, "  \"num_threads\": %d,\n", nr_tasks);
+	fprintf(f, "  \"thread\": {\n");
+	for (i = 0; i < nr_tasks; i++) {
+		fprintf(f, "    \"%u\": {\n", i);
+		fprintf(f, "      \"prio\": %d,\n", calc_prio(i));
+		fprintf(f, "      \"min\": %lld,\n", nano2usec(tasks_min[i]));
+		fprintf(f, "      \"avg\": %lld,\n", nano2usec(tasks_avg[i]) / nr_runs);
+		fprintf(f, "      \"max\": %lld,\n", nano2usec(tasks_max[i]));
+		fprintf(f, "      \"total\": %lld\n", nano2usec(tasks_avg[i]));
+		fprintf(f, "    }%s\n", i == nr_tasks - 1 ? "" : ",");
+	}
+	fprintf(f, "  }\n");
+}
+
 static unsigned long busy_loop(unsigned long long start_time)
 {
 	unsigned long long time;
@@ -582,6 +661,9 @@ int main (int argc, char **argv)
 
 	print_results();
 
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, argc, argv, write_stats, NULL);
+
 	if (stop) {
 		/*
 		 * We use this test in bash while loops
-- 
2.30.0

