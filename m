Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9974C4363C
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EA92080A
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJGI5D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGI5C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44284B174;
        Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 09/18] pi_stress: Streamline usage output and man page
Date:   Wed,  7 Oct 2020 10:56:44 +0200
Message-Id: <20201007085653.11961-10-dwagner@suse.de>
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
 src/pi_tests/pi_stress.8 |  79 +++++++++++----------
 src/pi_tests/pi_stress.c | 144 +++++++++++++++++++++------------------
 2 files changed, 122 insertions(+), 101 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index ed03ad6187e7..c3d7889a5cd5 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -10,25 +10,26 @@
 pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .\"}}}
 .\"{{{ Synopsis
-.\" Usage:  pi_stress [-i n ] [-g n] [-v] [-d] [-s] [-r] [-p] [-u] [-m]
+.\" Usage:  pi_stress [-d] [-D TIME] [-g N] [-h] [-i N ] [-m] [-p] [-q] [-r] [-s OPTS] [-u] [-v] [-V]
 .SH SYNOPSIS
 .B pi_stress
-.RB [ \-i|\-\-inversions
-.IR inversions ]
+.RB [ \-d|\-\-debug]
+.RB [ \-D|\-\-duration
+.iR TIME ]
 .RB [ \-g|\-\-groups
-.IR groups
-.RB [ \-d|\-\-debug ]
-.RB [ \-v|\-\-verbose ]
-.RB [ \-s|\-\-sched
-.IR sched_opts ]
-.RB [ \-r|\-\-rr ]
-.RB [ \-p|\-\-prompt ]
+.IR N ]
+.RB [ \-i|\-\-inversions
+.IR INV ]
 .RB [ \-m|\-\-mlockall ]
+.RB [ \-p|\-\-prompt ]
+.RB [ \-q|\-\-quiet ]
+.RB [ \-r|\-\-rr ]
+.RB [ \-s|\-\-sched
+.IR OPTS ]
 .RB [ \-u|\-\-uniprocessor ]
+.RB [ \-v|\-\-verbose ]
+.RB [ \-V|\-\-version ]
 .br
-.\" help
-.B pi_stress
-.RB \-h|\-\-help
 .SH DESCRIPTION
 .B pi_stress
 is a program used to stress the
@@ -43,38 +44,46 @@ condition that will deadlock if
 doesn't work.
 
 .SH OPTIONS
-.IP "\-i n|\-\-inversions=n"
-Run for
-.I n
-number of inversion conditions. This is the total number of inversions
-for all inversion groups. Default is \-1 for infinite.
-.IP "\-g n|\-\-groups=n"
-The number of inversion groups to run. Defaults to 10.
-.IP \-d|\-\-debug
+.IP "\-d|\-\-debug"
 Run in debug mode; lots of extra prints
-.IP "\-D, \-\-duration=TIME"
+.IP "\-D TIME, \-\-duration=TIME"
 Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
-.IP \-v|\-\-verbose
-Run with verbose messages
-.IP \-r|\-\-rr
+.IP "\-g N|\-\-groups=N"
+The number of inversion groups to run. Defaults to 10.
+.IP "\-h|\-\-help"
+Display a short help message and options.
+.IP "\-i N|\-\-inversions=N"
+.I N
+number of inversion conditions. This is the total number of inversions
+for all inversion groups. Default is \-1 for infinite.
+.IP "\-m|\-\-mlockall"
+Call mlockall to lock current and future memory allocations and
+prevent being paged out
+.IP "\-p|\-\-prompt"
+Prompt before actually starting the stress test
+.IP "\-q|\-\-quiet"
+Suppress running output
+.IP "\-r|\-\-rr"
 Run inversion group threads as SCHED_RR (round-robin). The default is
 to run the inversion threads as SCHED_FIFO.
-.IP \-s|\-\-sched
+.IP "\-s OPTS|\-\-sched OPTS"
 scheduling options per thread type:
-id=[high|med|low],policy=[fifo,rr],priority=<n>,policy=deadline,runtime=<n>,deadline=<n>,period=<n>
-.IP \-p|\-\-prompt
-Prompt before actually starting the stress test
-.IP \-u|\-\-uniprocessor
+.br
+id=[high|med|low],
+.br
+policy=[fifo,rr],priority=N,
+.br
+policy=deadline,runtime=N,deadline=N,period=N
+.IP "\-u|\-\-uniprocessor"
 Run all threads on one processor. The default is to run all inversion
 group threads on one processor and the admin threads (reporting
 thread, keyboard reader, etc.) on a different processor.
-.IP \-m|\-\-mlockall
-Call mlockall to lock current and future memory allocations and
-prevent being paged out
-.IP \-h|\-\-help
-Display a short help message and options.
+.IP "\-v|\-\-verbose"
+Run with verbose messages
+.IP "\-V|\-\-version"
+Print version number
 .SH CAVEATS
 The pi_stress test threads run as SCHED_FIFO or SCHED_RR threads,
 which means that they can starve critical system threads. It is
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index e03cca25b933..84da241098af 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -121,24 +121,6 @@ int uniprocessor = 0;
 /* lock all memory */
 int lockall = 0;
 
-/* command line options */
-struct option options[] = {
-	{"duration", required_argument, NULL, 'D'},
-	{"verbose", no_argument, NULL, 'v'},
-	{"quiet", no_argument, NULL, 'q'},
-	{"groups", required_argument, NULL, 'g'},
-	{"inversions", required_argument, NULL, 'i'},
-	{"rr", no_argument, NULL, 'r'},
-	{"sched", required_argument, NULL, 's'},
-	{"uniprocessor", no_argument, NULL, 'u'},
-	{"prompt", no_argument, NULL, 'p'},
-	{"debug", no_argument, NULL, 'd'},
-	{"version", no_argument, NULL, 'V'},
-	{"mlockall", no_argument, NULL, 'm'},
-	{"help", no_argument, NULL, 'h'},
-	{NULL, 0, NULL, 0},
-};
-
 #define NUM_TEST_THREADS 3
 #define NUM_ADMIN_THREADS 1
 
@@ -219,7 +201,7 @@ int setup_thread_attr(pthread_attr_t * attr, struct sched_attr * sa,
 		      cpu_set_t * mask);
 int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask);
 void process_command_line(int argc, char **argv);
-void usage(void);
+void usage(int error);
 int block_signals(void);
 int allow_sigterm(void);
 void set_shutdown_flag(void);
@@ -989,27 +971,35 @@ void *high_priority(void *arg)
 	return NULL;
 }
 
-void usage(void)
+void usage(int error)
 {
-	printf("usage: pi_stress <options>\n\n");
-	printf("-v\t--verbose\t- lots of output\n");
-	printf("-q\t--quiet\t\t- suppress running output\n");
-	printf ("-D TIME\t--duration=TIME\n\t\t\t- length of test run in seconds (default is infinite)\n");
-	printf("\t\t\t  Append 'm', 'h', or 'd'\n\t\t\t  to specify minutes, hours or days.\n");
-	printf("-g\t--groups=<n>\t- set the number of inversion groups [%d]\n",
-	       ngroups);
-	printf ("-i INVERSIONS\t\t--inversions=INVERSIONS\n\t\t\t  number of inversions per group (default is infinite)\n");
-	printf("-r\t--rr\t\t- use SCHED_RR for test threads [SCHED_FIFO]\n");
-	printf("-s SCHED_OPTS\t--sched\t\t- scheduling options per thread type:\n");
-	printf("\t\tid=[high|med|low]\t\t\t- select thread\n");
-	printf("\t\t,policy=[fifo,rr],priority=<n>\t\t- SCHED_FIFO or SCHED_RR\n");
-	printf("\t\t,policy=deadline,runtime=<n>,deadline=<n>,period=<n>\t- SCHED_DEADLINE\n");
-	printf("-p\t--prompt\t- prompt before starting the test\n");
-	printf ("-u\t--uniprocessor\t- force all threads to run on one processor\n");
-	printf("-m\t--mlockall\t- lock current and future memory\n");
-	printf("-d\t--debug\t\t- turn on debug prints\n");
-	printf("-V\t--version\t- print version number on output\n");
-	printf("-h\t--help\t\t- print this message\n");
+	printf("pi_stress V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "pi_stress <options>\n\n"
+	       "-d       --debug           turn on debug prints\n"
+	       "-D TIME  --duration=TIME   length of test run in seconds (default is infinite)\n"
+	       "                           Append 'm', 'h', or 'd'\n"
+	       "                           to specify minutes, hours or days.\n"
+	       "-g N     --groups=N        set the number of inversion groups\n"
+	       "-h       --help            print this message\n"
+	       "-i INV   --inversions=INV  number of inversions per group (default is infinite)\n"
+	       "-m       --mlockall        lock current and future memory\n"
+	       "-p       --prompt          prompt before starting the test\n"
+	       "-q       --quiet           suppress running output\n"
+	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
+	       "-s OPTS  --sched OPTS      scheduling options per thread type:\n"
+	       "   tid=[high|med|low]      select thread\n"
+	       "   ,policy=[fifo,rr]       scheduling class [SCHED_FIFO, SCHED_RR]\n"
+	       "     ,priority=N           scheduling priority\n"
+	       "   ,policy=[deadline]      scheduling class [DEADLINE]\n"
+               "     ,runtime=N\n"
+	       "     ,deadline=N\n"
+	       "     ,period=N\n"
+	       "-u       --uniprocessor    force all threads to run on one processor\n"
+	       "-v       --verbose         lots of output\n"
+	       "-V       --version         print version number on output\n"
+	       );
+	exit(error);
 }
 
 /* block all signals (called from main) */
@@ -1287,26 +1277,33 @@ int process_sched_line(const char *arg)
 
 void process_command_line(int argc, char **argv)
 {
-	int opt;
-	while ((opt = getopt_long(argc, argv, "+hD:vqi:g:rs:pdVum", options, NULL)) != -1) {
-		switch (opt) {
-		case 'h':
-			usage();
-			exit(0);
-		case 'D':
-			duration = parse_time_string(optarg);
-			break;
-		case 'v':
-			verbose = 1;
-			quiet = 0;
+	for (;;) {
+		struct option options[] = {
+			{"debug",		no_argument,		NULL, 'd'},
+			{"duration",		required_argument,	NULL, 'D'},
+			{"groups",		required_argument,	NULL, 'g'},
+			{"help",		no_argument,		NULL, 'h'},
+			{"inversions",		required_argument,	NULL, 'i'},
+			{"mlockall",		no_argument,		NULL, 'm'},
+			{"prompt",		no_argument,		NULL, 'p'},
+			{"quiet",		no_argument,		NULL, 'q'},
+			{"rr",			no_argument,		NULL, 'r'},
+			{"sched",		required_argument,	NULL, 's'},
+			{"uniprocessor",	no_argument,		NULL, 'u'},
+			{"verbose",		no_argument,		NULL, 'v'},
+			{"version",		no_argument,		NULL, 'V'},
+			{NULL, 0, NULL, 0},
+		};
+
+		int c = getopt_long(argc, argv, "+hD:vqi:g:rs:pdVum", options, NULL);
+		if (c == -1)
 			break;
-		case 'q':
-			verbose = 0;
-			quiet = 1;
+		switch (c) {
+		case 'd':
+			debugging = 1;
 			break;
-		case 'i':
-			inversions = strtol(optarg, NULL, 10);
-			pi_info("doing %d inversion per group\n", inversions);
+		case 'D':
+			duration = parse_time_string(optarg);
 			break;
 		case 'g':
 			ngroups = strtol(optarg, NULL, 10);
@@ -1318,6 +1315,23 @@ void process_command_line(int argc, char **argv)
 			}
 			pi_info("number of groups set to %d\n", ngroups);
 			break;
+		case 'h':
+			usage(0);
+			break;
+		case 'i':
+			inversions = strtol(optarg, NULL, 10);
+			pi_info("doing %d inversion per group\n", inversions);
+			break;
+		case 'm':
+			lockall = 1;
+			break;
+		case 'p':
+			prompt = 1;
+			break;
+		case 'q':
+			verbose = 0;
+			quiet = 1;
+			break;
 		case 'r':
 			policy = SCHED_RR;
 			break;
@@ -1325,20 +1339,18 @@ void process_command_line(int argc, char **argv)
 			if (process_sched_line(optarg))
 				pi_error("ignoring invalid options '%s'\n", optarg);
 			break;
-		case 'p':
-			prompt = 1;
+		case 'u':
+			uniprocessor = 1;
 			break;
-		case 'd':
-			debugging = 1;
+		case 'v':
+			verbose = 1;
+			quiet = 0;
 			break;
 		case 'V':
 			printf("pi_stress v%1.2f ", VERSION);
 			exit(0);
-		case 'u':
-			uniprocessor = 1;
-			break;
-		case 'm':
-			lockall = 1;
+		default:
+			usage(1);
 			break;
 		}
 	}
-- 
2.28.0

