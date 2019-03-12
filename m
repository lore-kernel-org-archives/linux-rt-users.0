Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098BC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC4D20449
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCLKgh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:36:37 -0400
Received: from goliath.siemens.de ([192.35.17.28]:37131 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfCLKgh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 06:36:37 -0400
X-Greylist: delayed 1630 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 06:36:35 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x2CA9GRs016462
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 11:09:17 +0100
Received: from localhost ([139.25.69.33])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x2CA9Ghn023566;
        Tue, 12 Mar 2019 11:09:16 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [RFC PATCH] rt-tests: Add --runtime argument to tests
Date:   Tue, 12 Mar 2019 11:09:12 +0100
Message-Id: <20190312100912.19253-1-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <wagi@monom.org>

Many of the test programs have the --loop argument for automatic
stopping. The main problem with the --loop argument is how long is
--loop 1000? Also sometimes it depends how long a meassurement cycle
takes.

To simplify automated test setups introduce a --runtime argument which
allows to set the time how long a test should run. This allows the
test suite to define the executation time and also the timeout which a
normal human can understand.

For example run the test for 10 minutes and timeout at 11 minutes:

  # timeout 11m sigwaittest -r 10m

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---

Hi John,

I am working on intergrating some of the rt-test into the
test-definition for Lava. Now I want to specificy the runtime for the
tests and I find it a bit combersome to all the math to figure out how
long the test runs for setting the right timeout. I picked
-r/--runtime as option name. This seems not to be the idea.

Some of the test have already claimed the -r argument
(e.g. cyclictest) or are using --duration (e.g. pmqtest) which can't
be shortened to -d for all tests. This would collide with the exiting
usage of -d in cyclictest.

So, one option could be just introducing the long option version
--duration for all tests.

What do you think?

Thanks,
Daniel

 src/include/rt-utils.h        |  3 ++
 src/lib/rt-utils.c            | 60 +++++++++++++++++++++++++++++++++++
 src/pmqtest/pmqtest.c         | 14 +++++++-
 src/ptsematest/ptsematest.c   | 13 +++++++-
 src/signaltest/signaltest.c   | 13 +++++++-
 src/sigwaittest/sigwaittest.c | 14 +++++++-
 src/svsematest/svsematest.c   | 11 ++++++-
 7 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index ef0f6acf4ab5..866262685d62 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -24,4 +24,7 @@ uint32_t string_to_policy(const char *str);
 
 pid_t gettid(void);
 
+long int parse_num(const char *str, int base, size_t *len);
+long int parse_time(const char *str);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index ac6878ccacf1..438af228f9d9 100644
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
@@ -320,3 +321,62 @@ pid_t gettid(void)
 {
 	return syscall(SYS_gettid);
 }
+
+long int parse_num(const char *str, int base, size_t *len)
+{
+	long int ret;
+	char *endptr;
+
+	errno = 0;
+	ret = strtol(str, &endptr, base);
+	if (errno)
+		return -errno;
+	if (ret < 0)
+		return -ERANGE;
+
+	if (len)
+		*len = endptr - str;
+
+	return ret;
+}
+
+/*
+ * Return time in seconds
+ */
+long int parse_time(const char *str)
+{
+	long int time;
+	size_t len;
+	int factor = 1;
+	char c, *buf;
+
+	len = strlen(str);
+	if (len < 1)
+		return -EINVAL;
+
+	c = tolower(str[len-1]);
+	switch (c) {
+	case 'd': factor *= 60 * 60 * 24; break;
+	case 'h': factor *= 60 * 60; break;
+	case 'm': factor *= 60; break;
+	case 's': break;
+	default:
+		if (isalpha(c))
+			return -EINVAL;
+	}
+
+	buf = strdup(str);
+	if (!buf)
+		return -ENOMEM;
+
+	if (factor > 1)
+		buf[len - 1] = '\0';
+
+	time = parse_num(buf, 10, &len);
+	free(buf);
+
+	if (time < 0)
+		return time;
+
+	return time * factor;
+}
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 75d5ee8185a0..f36903983c4a 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -252,6 +252,7 @@ static void display_help(void)
 	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-r TIME  --runtime=TIME    execute the test for TIME\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -271,6 +272,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int runtime;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -293,6 +295,7 @@ static void process_options (int argc, char *argv[])
 			{"forcetimeout", required_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"runtime", required_argument, NULL, 'r'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
@@ -325,6 +328,7 @@ static void process_options (int argc, char *argv[])
 		case 'f': forcetimeout = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'r': runtime = parse_time(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -369,7 +373,10 @@ static void process_options (int argc, char *argv[])
 
 	if (forcetimeout && !timeout)
 		error = 1;
- 
+
+	if (runtime < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -418,10 +425,15 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	sigaddset(&sigset, SIGTERM);
 	sigaddset(&sigset, SIGINT);
+	sigaddset(&sigset, SIGALRM);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (runtime)
+		alarm(runtime);
 
 	receiver = calloc(num_threads, sizeof(struct params));
 	sender = calloc(num_threads, sizeof(struct params));
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a31c745ec928..74d20e2e5cbd 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -173,6 +173,7 @@ static void display_help(void)
 	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-r TIME  --runtime=TIME    execute test for TIME. Valid postfixes 's', 'm', 'h', 'd'\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -190,6 +191,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int runtime;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -209,13 +211,14 @@ static void process_options (int argc, char *argv[])
 			{"distance", required_argument, NULL, 'd'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"runtime", required_argument, NULL, 'r'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:i:l:r:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -239,6 +242,7 @@ static void process_options (int argc, char *argv[])
 		case 'd': distance = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'r': runtime = parse_time(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -280,6 +284,9 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
+	if (runtime < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -317,6 +324,10 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (runtime)
+		alarm(runtime);
 
 	receiver = calloc(num_threads, sizeof(struct params));
 	sender = calloc(num_threads, sizeof(struct params));
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 59f979ec5ad1..4d22a78eb84f 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -208,6 +208,7 @@ static void display_help(void)
 		"signaltest <options>\n\n"
 		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+		"-r TIME  --runtime=TIME    execute test for TIME. Valid postfixes 's', 'm', 'h', 'd'\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
@@ -221,6 +222,7 @@ static void display_help(void)
 static int priority;
 static int num_threads = 2;
 static int max_cycles;
+static int runtime;
 static int verbose;
 static int quiet;
 static int lockall = 0;
@@ -235,6 +237,7 @@ static void process_options (int argc, char *argv[])
 		static struct option long_options[] = {
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"loops", required_argument, NULL, 'l'},
+			{"runtime", required_argument, NULL, 'r'},
 			{"priority", required_argument, NULL, 'p'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"threads", required_argument, NULL, 't'},
@@ -243,13 +246,14 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrsmt:v",
+		int c = getopt_long (argc, argv, "b:c:d:i:l:r:np:qrsmt:v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'r': runtime = parse_time(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'q': quiet = 1; break;
 		case 't': num_threads = atoi(optarg); break;
@@ -265,6 +269,9 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 2)
 		error = 1;
 
+	if (runtime < 0)
+		error = 1;
+
 	if (error)
 		display_help ();
 }
@@ -340,6 +347,10 @@ int main(int argc, char **argv)
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (runtime)
+		alarm(runtime);
 
 	par = calloc(num_threads, sizeof(struct thread_param));
 	if (!par)
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 91fcdaa5f185..7f0aee6d7c99 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -222,6 +222,7 @@ static void display_help(void)
 	"-f       --fork            fork new processes instead of creating threads\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-r TIME  --runtime=TIME    execute test for TIME. Valid postfixes 's', 'm', 'h', 'd'\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-t       --threads         one thread per available processor\n"
 	"-t [NUM] --threads=NUM     number of threads:\n"
@@ -236,6 +237,7 @@ static int affinity;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int runtime;
 static int interval = 1000;
 static int distance = 500;
 
@@ -255,12 +257,13 @@ static void process_options (int argc, char *argv[])
 			{"fork", optional_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"runtime", required_argument, NULL, 'r'},
 			{"priority", required_argument, NULL, 'p'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:r:p:t::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -291,6 +294,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'r': runtime = parse_time(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 't':
 			if (optarg != NULL)
@@ -322,6 +326,9 @@ static void process_options (int argc, char *argv[])
 		if (priority < 0 || priority > 99)
 			error = 1;
 
+		if (runtime < 0)
+			error = 1;
+
 		tracelimit = thistracelimit;
 	}
 	if (error)
@@ -433,9 +440,13 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	if (runtime)
+		alarm(runtime);
+
 	if (!mustfork && !wasforked) {
 		receiver = calloc(num_threads, sizeof(struct params));
 		sender = calloc(num_threads, sizeof(struct params));
@@ -578,6 +589,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&sigset);
 		sigaddset(&sigset, SIGTERM);
 		sigaddset(&sigset, SIGINT);
+		sigaddset(&sigset, SIGALRM);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 		nanosleep(&maindelay, NULL);
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb82858720a..d87869c67e85 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -248,6 +248,7 @@ static void display_help(void)
 	"-f       --fork            fork new processes instead of creating threads\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-r TIME  --runtime=TIME    execute the test for TIME\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -264,6 +265,7 @@ static int affinity;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int runtime;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -285,13 +287,14 @@ static void process_options (int argc, char *argv[])
 			{"fork", optional_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"runtime", required_argument, NULL, 'r'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:r:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -326,6 +329,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'r': runtime = parse_time(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -486,10 +490,14 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
 
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	if (runtime)
+		alarm(runtime);
+
 	if (!mustfork && !wasforked) {
 		receiver = calloc(num_threads, sizeof(struct params));
 		sender = calloc(num_threads, sizeof(struct params));
@@ -663,6 +671,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&sigset);
 		sigaddset(&sigset, SIGTERM);
 		sigaddset(&sigset, SIGINT);
+		sigaddset(&sigset, SIGALRM);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
 		nanosleep(&maindelay, NULL);
-- 
2.20.1

