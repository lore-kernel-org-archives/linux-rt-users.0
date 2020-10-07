Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2066FC41604
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C916C20870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgJGI5E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgJGI5D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C699BB182;
        Wed,  7 Oct 2020 08:57:01 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 13/18] rt-migrate-test: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:48 +0200
Message-Id: <20201007085653.11961-14-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/rt-migrate-test/rt-migrate-test.8 | 41 +++++++-------
 src/rt-migrate-test/rt-migrate-test.c | 82 +++++++++++++--------------
 2 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
index b9c07f1ed80a..5bbacb5333b8 100644
--- a/src/rt-migrate-test/rt-migrate-test.8
+++ b/src/rt-migrate-test/rt-migrate-test.8
@@ -1,11 +1,11 @@
 .\"
-.TH RT-MIGRATE-TEST 8 "April 21, 2016"
+.TH RT-MIGRATE-TEST 8 "September 18, 2020"
 .\" Please adjust this date whenever editing this manpage
 .SH NAME
 rt-migrate-test \- real-time task migration program
 .SH SYNOPSIS
-.B rt-migrate-test 
-.RI "[\-ceh] [\-p prio] [\-r time] [\-s time] [\-m time] [\-l loops] [nr_tasks]
+.LP
+rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
 .SH DESCRIPTION
 Test real-time multiprocessor scheduling of tasks to ensure the highest priority tasks are running on all available CPUs
 .SH OPTIONS
@@ -15,44 +15,43 @@ This program follows the usual GNU command line syntax, with long options starti
 In the summary of options, a value in brackets (), indicates a default value
 .br
 .TP
+.B \-c, \-\-check
+Stop if lower prio task is quicker than higher (off)
+.TP
 .B \-D, \-\-duration=TIME
 Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
-.B \-p, \-\-prio=prio
-base priority to start RT tasks with (2)
+.B \-e, \-\-equal
+Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
 .br
 .TP
-.B \-r, \-\-run\-time=time
-Run time (ms) to busy loop the threads (20)
+.B \-h, \-\-help
+Display usage
 .br
 .TP
-.B \-s, \-\-sleep\-time=time
-Sleep time (ms) between intervals (100)
+.B \-l \-\-loops=LOOPS
+Number of iterations to run (50)
 .br
 .TP
-.B \-m, \-\-maxerr=time
+.B \-m, \-\-maxerr=TIME
 Max allowed error (microsecs)
 .br
 .TP
-.B \-l \-\-loops=loops
-Number of iterations to run (50)
-.br
-.TP
-.B \-e
-Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
+.B \-p, \-\-prio=PRIO
+base priority to start RT tasks with (2)
 .br
 .TP
-.B \-c, \-\-check
-Stop if lower prio task is quicker than higher (off)
+.B \-r, \-\-run\-time=TIME
+Run time (ms) to busy loop the threads (20)
 .br
 .TP
-.B \-h, \-\-help
-Display usage
+.B \-s, \-\-sleep\-time=TIME
+Sleep time (ms) between intervals (100)
 .br
 .TP
-.B [nr\-tasks]
+.B [NR_TASKS]
 number of tasks to run (number of cpus + 1)
 .br
 .SH AUTHOR
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 4863238edeb4..68824606faf1 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -146,71 +146,67 @@ static void print_progress_bar(int percent)
 	fflush(stderr);
 }
 
-static void usage(char **argv)
+static void usage(int error)
 {
-	char *arg = argv[0];
-	char *p = arg+strlen(arg);
-
-	while (p >= arg && *p != '/')
-		p--;
-	p++;
-
-	printf("%s %1.2f\n", p, VERSION);
+	printf("rt-migrate-test %1.2f\n", VERSION);
 	printf("Usage:\n"
-	       "%s <options> nr_tasks\n\n"
-	       "-p prio --prio  prio        base priority to start RT tasks with (2)\n"
-	       "-r time --run-time time     Run time (ms) to busy loop the threads (20)\n"
-	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
-	       "-m time --maxerr time       Max allowed error (microsecs)\n"
-	       "-l loops --loops loops      Number of iterations to run (50)\n"
-	       "-D       --duration=TIME    specify a length for the test run.\n"
-	       "                            Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
-	       "-e                          Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
-	       "-c    --check               Stop if lower prio task is quicker than higher (off)\n"
-	       "-h    --help\n"
-	       "  () above are defaults \n",
-		p);
-	exit(0);
+	       "rt-migrate-test <options> [NR_TASKS]\n\n"
+	       "-c       --check           Stop if lower prio task is quicker than higher (off)\n"
+	       "-D TIME  --duration=TIME   Specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
+	       "                           days.\n"
+	       "-e       --equal           Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
+	       "-h       --help            Print this help message\n"
+	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
+	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
+	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
+	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
+	       "-s TIME  --sleep-time=TIME Sleep time (ms) between intervals (100)\n\n"
+	       "  () above are defaults \n"
+	       );
+	exit(error);
 }
 
-static void parse_options (int argc, char *argv[])
+static void parse_options(int argc, char *argv[])
 {
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"prio", required_argument, NULL, 'p'},
-			{"run-time", required_argument, NULL, 'r'},
-			{"sleep-time", required_argument, NULL, 's'},
-			{"maxerr", required_argument, NULL, 'm'},
-			{"loops", required_argument, NULL, 'l'},
-			{"duration", required_argument, NULL, 'D'},
-			{"check", no_argument, NULL, 'c'},
-			{"help", no_argument, NULL, '?'},
+			{"check",	no_argument,		NULL, 'c'},
+			{"duration",	required_argument,	NULL, 'D'},
+			{"equal",	no_argument,		NULL, 'e'},
+			{"help",	no_argument,		NULL, 'h'},
+			{"loops",	required_argument,	NULL, 'l'},
+			{"maxerr",	required_argument,	NULL, 'm'},
+			{"prio",	required_argument,	NULL, 'p'},
+			{"run-time",	required_argument,	NULL, 'r'},
+			{"sleep-time",	required_argument,	NULL, 's'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "p:r:s:m:l:D:ech",
+		int c = getopt_long(argc, argv, "cD:ehl:m:p:r:s:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
-		case 'p': prio_start = atoi(optarg); break;
-		case 'r':
-			run_interval = atoi(optarg);
-			break;
-		case 's': interval = atoi(optarg); break;
-		case 'l': nr_runs = atoi(optarg); break;
+		case 'c': check = 1; break;
 		case 'D': duration = parse_time_string(optarg); break;
-		case 'm': max_err = usec2nano(atoi(optarg)); break;
 		case 'e': equal = 1; break;
-		case 'c': check = 1; break;
 		case '?':
 		case 'h':
-			usage(argv);
+			usage(0);
 			break;
+		case 'l': nr_runs = atoi(optarg); break;
+		case 'm': max_err = usec2nano(atoi(optarg)); break;
+		case 'p': prio_start = atoi(optarg); break;
+		case 'r':
+			run_interval = atoi(optarg);
+			break;
+		case 's': interval = atoi(optarg); break;
+		default:
+			usage(1);
 		}
 	}
-
 }
 
 static unsigned long long get_time(void)
-- 
2.28.0

