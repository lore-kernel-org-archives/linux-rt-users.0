Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F4C433E9
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22D464FE6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCEHfJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:43734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCEHfH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E879AEB3;
        Fri,  5 Mar 2021 07:35:06 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 05/14] rt-util: Add start time of test execution for JSON output
Date:   Fri,  5 Mar 2021 08:34:51 +0100
Message-Id: <20210305073500.17926-6-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Store the start time when the test starts to execute in the JSON
output.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c           |  1 +
 src/include/rt-utils.h                |  2 ++
 src/lib/rt-utils.c                    | 34 +++++++++++++++++++--------
 src/oslat/oslat.c                     |  1 +
 src/pmqtest/pmqtest.c                 |  1 +
 src/ptsematest/ptsematest.c           |  1 +
 src/rt-migrate-test/rt-migrate-test.c |  1 +
 src/sched_deadline/cyclicdeadline.c   |  1 +
 src/signaltest/signaltest.c           |  1 +
 src/sigwaittest/sigwaittest.c         |  1 +
 src/svsematest/svsematest.c           |  1 +
 11 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3f3b91bab53b..033b95a3a19a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -615,6 +615,7 @@ static void *timerthread(void *param)
 		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
+	rt_test_start();
 	stat->threadstarted++;
 
 	while (!shutdown) {
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 11d69ea7e49a..d83f11930998 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -82,6 +82,8 @@ static inline int64_t calctime(struct timespec t)
 
 void rt_init(int argc, char *argv[]);
 
+void rt_test_start(void);
+
 void rt_write_json(const char *filename,
 		   void (*cb)(FILE *, void *), void *data);
 
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 9c9d0dee3255..09d79170c371 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -30,6 +30,7 @@
 
 #define  TRACEBUFSIZ  1024
 #define  MAX_COMMAND_LINE 4096
+#define  MAX_TS_SIZE 64
 
 static char debugfileprefix[MAX_PATH];
 static char *fileprefix;
@@ -37,6 +38,7 @@ static int trace_fd = -1;
 static int tracemark_fd = -1;
 static __thread char tracebuf[TRACEBUFSIZ];
 static char cmdline[MAX_COMMAND_LINE];
+static char ts_start[MAX_TS_SIZE];
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -514,16 +516,31 @@ void rt_init(int argc, char *argv[])
 	}
 }
 
+static void get_timestamp(char *tsbuf)
+{
+	struct timeval tv;
+	struct tm *tm;
+	time_t t;
+
+	gettimeofday(&tv, NULL);
+	t = tv.tv_sec;
+	tm = localtime(&t);
+	/* RFC 2822-compliant date format */
+	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
+}
+
+void rt_test_start(void)
+{
+	get_timestamp(ts_start);
+}
+
 void rt_write_json(const char *filename,
 		   void (*cb)(FILE *, void *), void *data)
 {
 	unsigned char buf[1];
 	struct utsname uts;
-	struct timeval tv;
-	char tsbuf[64];
-	struct tm *tm;
+	char ts_end[MAX_TS_SIZE];
 	FILE *f, *s;
-	time_t t;
 	size_t n;
 	int rt = 0;
 
@@ -535,11 +552,7 @@ void rt_write_json(const char *filename,
 			err_exit(errno, "Failed to open '%s'\n", filename);
 	}
 
-	gettimeofday(&tv, NULL);
-	t = tv.tv_sec;
-	tm = localtime(&t);
-	/* RFC 2822-compliant date format */
-	strftime(tsbuf, sizeof(tsbuf), "%a, %d %b %Y %T %z", tm);
+	get_timestamp(ts_end);
 
 	s = fopen("/sys/kernel/realtime", "r");
 	if (s) {
@@ -556,7 +569,8 @@ void rt_write_json(const char *filename,
 	fprintf(f, "  \"file_version\": 1,\n");
 	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
 	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
-	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
+	fprintf(f, "  \"start_time\": \"%s\",\n", ts_start);
+	fprintf(f, "  \"end_time\": \"%s\",\n", ts_end);
 	fprintf(f, "  \"sysinfo\": {\n");
 	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
 	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index ac54d05697ef..2f02f5399405 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -854,6 +854,7 @@ int main(int argc, char *argv[])
 		printf("Test starts...\n");
 	/* Reset n_threads to always run on all the cores */
 	g.n_threads = g.n_threads_total;
+	rt_test_start();
 	run_expt(threads, g.runtime);
 
 	if (!g.quiet)
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index f96b3d0bf400..adf72c10ce83 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -583,6 +583,7 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	rt_test_start();
 	do {
 		int newsamples = 0, newtimeoutcount = 0;
 		int minsamples = INT_MAX;
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a32bfc1698f0..471f1b307c14 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -468,6 +468,7 @@ int main(int argc, char *argv[])
 	maindelay.tv_sec = 0;
 	maindelay.tv_nsec = 50000000; /* 50 ms */
 
+	rt_test_start();
 	while (!shutdown) {
 		for (i = 0; i < num_threads; i++)
 			shutdown |= receiver[i].shutdown | sender[i].shutdown;
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index cdfbfafb200b..8f628d347a23 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -621,6 +621,7 @@ int main (int argc, char **argv)
 
 	setup_ftrace_marker();
 
+	rt_test_start();
 	for (loop=0; loop < nr_runs; loop++) {
 		unsigned long long end;
 
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index e6811838b62d..a649e5a0fe5e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1213,6 +1213,7 @@ int main(int argc, char **argv)
 	if (duration)
 		alarm(duration);
 
+	rt_test_start();
 	loop(sched_data, nr_threads);
 
 	for (i = 0; i < nr_threads; i++) {
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 6abf38b7821c..7327d0d0144d 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -500,6 +500,7 @@ int main(int argc, char **argv)
 			      strerror(status));
 	}
 
+	rt_test_start();
 	while (!shutdown) {
 		int allstarted = 1;
 
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 142419f9e315..6e8bc7b50d5f 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -652,6 +652,7 @@ int main(int argc, char *argv[])
 			    &sender[i]);
 	}
 
+	rt_test_start();
 	while (!mustshutdown) {
 		for (i = 0; i < num_threads; i++)
 			mustshutdown |= receiver[i].shutdown |
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7c9d21edbab2..7533b1b569cc 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -724,6 +724,7 @@ int main(int argc, char *argv[])
 			    &sender[i]);
 	}
 
+	rt_test_start();
 	while (!mustshutdown) {
 		for (i = 0; i < num_threads; i++)
 			mustshutdown |= receiver[i].shutdown |
-- 
2.30.1

