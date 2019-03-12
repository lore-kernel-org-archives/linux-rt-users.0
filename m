Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEADC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90F520693
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCLPr6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:47:58 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58727 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfCLPr6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 11:47:58 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x2CFlnmI031796
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 16:47:49 +0100
Received: from localhost ([139.25.69.33])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x2CFlnvI020770;
        Tue, 12 Mar 2019 16:47:49 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH v1] rt-tests: Add --duration argument to tests
Date:   Tue, 12 Mar 2019 16:47:38 +0100
Message-Id: <20190312154738.10925-1-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Many of the test programs have the --loop argument for automatic
stopping. The main problem with the --loop argument is how long is
--loop 1000?

To simplify automated tests  introduce a --duration argument which
allows to set the time how long a test should run. This allows the
test suite to define the executation time and also the timeout which a
normal human can understand.

For example run the test for 10 minutes and timeout at 11 minutes:

  # timeout 11m sigwaittest --duration 10m

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
Hi,

I tried to patch all tests where possible. Not all tests need it,
e.g. pip_stress.

There are two memory corruption bugs in cyclicdeadline and
deadline_test. The setcpu_buf gets corrupted but I haven't figured
where it happens. valgrind doesn't help :(

Thanks,
Daniel

 src/cyclictest/cyclictest.c           | 33 --------------------------
 src/include/rt-utils.h                |  2 ++
 src/lib/rt-utils.c                    | 34 +++++++++++++++++++++++++++
 src/pi_tests/pi_stress.8              |  4 ++++
 src/pi_tests/pi_stress.c              |  9 +++----
 src/pmqtest/pmqtest.8                 |  5 ++++
 src/pmqtest/pmqtest.c                 | 17 ++++++++++++--
 src/ptsematest/ptsematest.8           |  5 ++++
 src/ptsematest/ptsematest.c           | 14 ++++++++++-
 src/rt-migrate-test/rt-migrate-test.8 |  5 ++++
 src/rt-migrate-test/rt-migrate-test.c | 12 +++++++++-
 src/sched_deadline/cyclicdeadline.c   | 12 +++++++++-
 src/signaltest/signaltest.8           |  5 ++++
 src/signaltest/signaltest.c           | 14 ++++++++++-
 src/sigwaittest/sigwaittest.8         |  5 ++++
 src/sigwaittest/sigwaittest.c         | 15 +++++++++++-
 src/svsematest/svsematest.8           |  5 ++++
 src/svsematest/svsematest.c           | 15 +++++++++++-
 18 files changed, 166 insertions(+), 45 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ed59edefbf97..03d56e4f520c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -406,39 +406,6 @@ static void enable_trace_mark(void)
 	open_tracemark_fd();
 }
 
-/*
- * parse an input value as a base10 value followed by an optional
- * suffix. The input value is presumed to be in seconds, unless
- * followed by a modifier suffix: m=minutes, h=hours, d=days
- *
- * the return value is a value in seconds
- */
-static int parse_time_string(char *val)
-{
-	char *end;
-	int t = strtol(val, &end, 10);
-	if (end) {
-		switch (*end) {
-		case 'm':
-		case 'M':
-			t *= 60;
-			break;
-
-		case 'h':
-		case 'H':
-			t *= 60*60;
-			break;
-
-		case 'd':
-		case 'D':
-			t *= 24*60*60;
-			break;
-
-		}
-	}
-	return t;
-}
-
 /*
  * Raise the soft priority limit up to prio, if that is less than or equal
  * to the hard limit
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index ef0f6acf4ab5..405fa7855346 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -24,4 +24,6 @@ uint32_t string_to_policy(const char *str);
 
 pid_t gettid(void);
 
+int parse_time_string(char *val);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index ac6878ccacf1..e1b166afcd6c 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -13,6 +13,7 @@
 #include <sched.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -320,3 +321,36 @@ pid_t gettid(void)
 {
 	return syscall(SYS_gettid);
 }
+
+/*
+ * parse an input value as a base10 value followed by an optional
+ * suffix. The input value is presumed to be in seconds, unless
+ * followed by a modifier suffix: m=minutes, h=hours, d=days
+ *
+ * the return value is a value in seconds
+ */
+int parse_time_string(char *val)
+{
+	char *end;
+	int t = strtol(val, &end, 10);
+	if (end) {
+		switch (*end) {
+		case 'm':
+		case 'M':
+			t *= 60;
+			break;
+
+		case 'h':
+		case 'H':
+			t *= 60*60;
+			break;
+
+		case 'd':
+		case 'D':
+			t *= 24*60*60;
+			break;
+
+		}
+	}
+	return t;
+}
diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index c92b4bdf5609..475d3c34f135 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -57,6 +57,10 @@ seconds and then terminate.
 The number of inversion groups to run. Defaults to 10.
 .IP \-d|\-\-debug
 Run in debug mode; lots of extra prints
+.IP "\-D, \-\-duration=TIME"
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .IP \-v|\-\-verbose
 Run with verbose messages
 .IP \-s|\-\-signal
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index ac7646cd2613..eac782a8d355 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -146,7 +146,7 @@ int lockall = 0;
 
 /* command line options */
 struct option options[] = {
-	{"duration", required_argument, NULL, 't'},
+	{"duration", required_argument, NULL, 'D'},
 	{"verbose", no_argument, NULL, 'v'},
 	{"quiet", no_argument, NULL, 'q'},
 	{"groups", required_argument, NULL, 'g'},
@@ -1027,7 +1027,8 @@ void usage(void)
 	printf("\t--verbose\t- lots of output\n");
 	printf("\t--quiet\t\t- suppress running output\n");
 	printf
-	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
+	    ("\t--duration=<n>\t- length of the test run in seconds [infinite]\n");
+	printf("\t\t\t  Append 'm', 'h', or 'd' to specify minutes, hours or days.\n");
 	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
 	       ngroups);
 	printf
@@ -1328,8 +1329,8 @@ void process_command_line(int argc, char **argv)
 		case 'h':
 			usage();
 			exit(0);
-		case 't':
-			duration = strtol(optarg, NULL, 10);
+		case 'D':
+			duration = parse_time_string(optarg);
 			break;
 		case 'v':
 			verbose = 1;
diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 05421e01e70b..9108a939b9f7 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When pmqtest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-f, \-\-forcetimeout=TO
 Set an artificial delay of the send function to force timeout of the receiver, requires the -T option
 .TP
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 75d5ee8185a0..054768d161a7 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -252,6 +252,8 @@ static void display_help(void)
 	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -271,6 +273,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -293,6 +296,7 @@ static void process_options (int argc, char *argv[])
 			{"forcetimeout", required_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
@@ -300,7 +304,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f:i:l:p:St::T:",
+		int c = getopt_long (argc, argv, "a::b:d:f:i:l:D:p:St::T:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -325,6 +329,7 @@ static void process_options (int argc, char *argv[])
 		case 'f': forcetimeout = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -369,7 +374,10 @@ static void process_options (int argc, char *argv[])
 
 	if (forcetimeout && !timeout)
 		error = 1;
- 
+
+	if (duration < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -418,10 +426,15 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	sigaddset(&sigset, SIGTERM);
 	sigaddset(&sigset, SIGINT);
+	sigaddset(&sigset, SIGALRM);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	receiver = calloc(num_threads, sizeof(struct params));
 	sender = calloc(num_threads, sizeof(struct params));
diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 9d835337ec27..289f3a1d7ae8 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When  cyclictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
 .TP
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a31c745ec928..6bedbc81b572 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -173,6 +173,8 @@ static void display_help(void)
 	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -190,6 +192,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -209,13 +212,14 @@ static void process_options (int argc, char *argv[])
 			{"distance", required_argument, NULL, 'd'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -239,6 +243,7 @@ static void process_options (int argc, char *argv[])
 		case 'd': distance = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -280,6 +285,9 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
+	if (duration < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -317,6 +325,10 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	receiver = calloc(num_threads, sizeof(struct params));
 	sender = calloc(num_threads, sizeof(struct params));
diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
index 8af50e54291d..b9c07f1ed80a 100644
--- a/src/rt-migrate-test/rt-migrate-test.8
+++ b/src/rt-migrate-test/rt-migrate-test.8
@@ -15,6 +15,11 @@ This program follows the usual GNU command line syntax, with long options starti
 In the summary of options, a value in brackets (), indicates a default value
 .br
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-p, \-\-prio=prio
 base priority to start RT tasks with (2)
 .br
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 0a0bb77ab661..8223d6669a37 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -41,6 +41,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
+#include "rt-utils.h"
 
 #define gettid() syscall(__NR_gettid)
 
@@ -115,6 +116,7 @@ static unsigned long long now;
 
 static int done;
 static int loop;
+static int duration;
 
 static pthread_barrier_t start_barrier;
 static pthread_barrier_t end_barrier;
@@ -180,6 +182,8 @@ static void usage(char **argv)
 	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
 	       "-m time --maxerr time       Max allowed error (microsecs)\n"
 	       "-l loops --loops loops      Number of iterations to run (50)\n"
+	       "-D       --duration=TIME    specify a length for the test run.\n"
+	       "                            Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	       "-e                          Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
 	       "-c    --check               Stop if lower prio task is quicker than higher (off)\n"
 	       "-h    --help\n"
@@ -199,11 +203,12 @@ static void parse_options (int argc, char *argv[])
 			{"sleep-time", required_argument, NULL, 's'},
 			{"maxerr", required_argument, NULL, 'm'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"check", no_argument, NULL, 'c'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "p:r:s:m:l:ech",
+		int c = getopt_long (argc, argv, "p:r:s:m:l:D:ech",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -214,6 +219,7 @@ static void parse_options (int argc, char *argv[])
 			break;
 		case 's': interval = atoi(optarg); break;
 		case 'l': nr_runs = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'm': max_err = usec2nano(atoi(optarg)); break;
 		case 'e': equal = 1; break;
 		case 'c': check = 1; break;
@@ -472,6 +478,10 @@ int main (int argc, char **argv)
 	parse_options(argc, argv);
 
 	signal(SIGINT, stop_log);
+	signal(SIGALRM, stop_log);
+
+	if (duration)
+		alarm(duration);
 
 	if (argc >= (optind + 1))
 		nr_tasks = atoi(argv[optind]);
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 761f8d7d7483..577ad95cfee1 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -21,6 +21,8 @@
 #include <linux/unistd.h>
 #include <linux/magic.h>
 
+#include <rt-utils.h>
+
 #ifdef __i386__
 #ifndef __NR_sched_setattr
 #define __NR_sched_setattr		351
@@ -1049,6 +1051,7 @@ int main (int argc, char **argv)
 	unsigned int interval = 1000;
 	unsigned int step = 500;
 	int percent = 60;
+	int duration = 0;
 	u64 runtime;
 	u64 start_period;
 	u64 end_period;
@@ -1062,7 +1065,7 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	while ((c = getopt(argc, argv, "+hac:t:")) >= 0) {
+	while ((c = getopt(argc, argv, "+hac:t:D:")) >= 0) {
 		switch (c) {
 		case 'a':
 			all_cpus = 1;
@@ -1081,6 +1084,9 @@ int main (int argc, char **argv)
 		case 't':
 			nr_threads = atoi(optarg);
 			break;
+		case 'D':
+			duration = parse_time_string(optarg);
+			break;
 		case 'h':
 		default:
 			usage(argv);
@@ -1246,6 +1252,10 @@ int main (int argc, char **argv)
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	if (!fail)
 		loop(sched_data, nr_threads);
diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index 634d392a6da5..bd6ffe5c7a36 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -13,6 +13,11 @@ starting with two dashes ('\-\-').
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-l, \-\-loops=LOOPS
 Number of loops: default=0 (endless)
 .TP
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 59f979ec5ad1..a168191b7573 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -208,6 +208,8 @@ static void display_help(void)
 		"signaltest <options>\n\n"
 		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+		"-D       --duration=TIME   specify a length for the test run.\n"
+		"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
@@ -221,6 +223,7 @@ static void display_help(void)
 static int priority;
 static int num_threads = 2;
 static int max_cycles;
+static int duration;
 static int verbose;
 static int quiet;
 static int lockall = 0;
@@ -235,6 +238,7 @@ static void process_options (int argc, char *argv[])
 		static struct option long_options[] = {
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"threads", required_argument, NULL, 't'},
@@ -243,13 +247,14 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrsmt:v",
+		int c = getopt_long (argc, argv, "b:c:d:i:l:D:np:qrsmt:v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'q': quiet = 1; break;
 		case 't': num_threads = atoi(optarg); break;
@@ -259,6 +264,9 @@ static void process_options (int argc, char *argv[])
 		}
 	}
 
+	if (duration < 0)
+		error = 1;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
@@ -340,6 +348,10 @@ int main(int argc, char **argv)
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	par = calloc(num_threads, sizeof(struct thread_param));
 	if (!par)
diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
index 2290ca2c76bc..5bedf2ced0dd 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When  cyclictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-f, \-\-fork
 Instead of creating threads (which is the default), fork new processes
 .TP
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 91fcdaa5f185..6e3c28330447 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -222,6 +222,8 @@ static void display_help(void)
 	"-f       --fork            fork new processes instead of creating threads\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-t       --threads         one thread per available processor\n"
 	"-t [NUM] --threads=NUM     number of threads:\n"
@@ -236,6 +238,7 @@ static int affinity;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 
@@ -255,12 +258,13 @@ static void process_options (int argc, char *argv[])
 			{"fork", optional_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:t::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -291,6 +295,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 't':
 			if (optarg != NULL)
@@ -316,6 +321,9 @@ static void process_options (int argc, char *argv[])
 			}
 		}
 
+		if (duration < 0)
+			error = 1;
+
 		if (num_threads < 1 || num_threads > 255)
 			error = 1;
 
@@ -433,9 +441,13 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	if (duration)
+		alarm(duration);
+
 	if (!mustfork && !wasforked) {
 		receiver = calloc(num_threads, sizeof(struct params));
 		sender = calloc(num_threads, sizeof(struct params));
@@ -578,6 +590,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&sigset);
 		sigaddset(&sigset, SIGTERM);
 		sigaddset(&sigset, SIGINT);
+		sigaddset(&sigset, SIGALRM);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 		nanosleep(&maindelay, NULL);
diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
index 0d4eaf3bb7ff..da64e9875d9f 100644
--- a/src/svsematest/svsematest.8
+++ b/src/svsematest/svsematest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When  cyclictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-f, \-\-fork
 Instead of creating threads (which is the default), fork new processes
 .TP
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb82858720a..dfa4660c0e43 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -248,6 +248,8 @@ static void display_help(void)
 	"-f       --fork            fork new processes instead of creating threads\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -264,6 +266,7 @@ static int affinity;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -285,13 +288,14 @@ static void process_options (int argc, char *argv[])
 			{"fork", optional_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -326,6 +330,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -360,6 +365,9 @@ static void process_options (int argc, char *argv[])
 			}
 		}
 
+		if (duration < 0)
+			error = 0;
+
 		if (num_threads < 1 || num_threads > 255)
 			error = 1;
 
@@ -486,10 +494,14 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
 
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	if (duration)
+		alarm(duration);
+
 	if (!mustfork && !wasforked) {
 		receiver = calloc(num_threads, sizeof(struct params));
 		sender = calloc(num_threads, sizeof(struct params));
@@ -663,6 +675,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&sigset);
 		sigaddset(&sigset, SIGTERM);
 		sigaddset(&sigset, SIGINT);
+		sigaddset(&sigset, SIGALRM);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 		nanosleep(&maindelay, NULL);
-- 
2.20.1

