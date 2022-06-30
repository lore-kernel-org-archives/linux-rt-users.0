Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB1C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiF3H6Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiF3H6Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jun 2022 03:58:25 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FD1A17580
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 00:58:21 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:57664.28326552
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 16C1E100212;
        Thu, 30 Jun 2022 15:58:19 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-mvcg4 with ESMTP id f0697723663e4d699d8f3f4824c7de02 for wagi@monom.org;
        Thu, 30 Jun 2022 15:58:20 CST
X-Transaction-ID: f0697723663e4d699d8f3f4824c7de02
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     wagi@monom.org, jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3] sched_deadline/cyclicdeadline: add tracelimit
Date:   Thu, 30 Jun 2022 16:00:28 +0800
Message-Id: <1656576028-20474-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

cyclictest has tracelimit to stop running when max latency
is higher than threshold but cyclicdeadline doesn't.

Therefore, tracelimit is introduced to cyclicdeadline in
this commit, once max latency is over, test stops and log
prints at the bottom of the ftrace file.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reviewed-by:   Daniel Wagner <wagi@monom.org>

---
v2:
1, disable ftrace when hitting thresold

v3:
1, update man page
---
 src/sched_deadline/cyclicdeadline.8 |  6 ++++
 src/sched_deadline/cyclicdeadline.c | 49 ++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index 1a56ed0..fab301e 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -50,6 +50,12 @@ The number of threads to run as deadline (default 1)
 .B \-q, \-\-quiet
 Print a summary only on exit. Useful for automated tests, where only
 the summary output needs to be captured.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC
+.TP
+.B \-\-tracemark
+write a trace mark when \-b latency is exceeded.
 .br
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index d865fa3..a925d1c 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -80,7 +80,11 @@ struct sched_data {
 };
 
 static int shutdown;
-
+static int tracelimit = 0;
+static int trace_marker = 0;
+static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
+static pid_t break_thread_id = 0;
+static uint64_t break_thread_value = 0;
 static pthread_barrier_t barrier;
 
 static int cpu_count;
@@ -667,6 +671,10 @@ static void teardown(void)
 
 	destroy_cpuset(CPUSET_ALL, 0);
 	destroy_cpuset(CPUSET_LOCAL, 1);
+
+	/* close any tracer file descriptors */
+	disable_trace_mark();
+
 }
 
 static void usage(int error)
@@ -689,6 +697,8 @@ static void usage(int error)
 	       "                           (default 500us).\n"
 	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
 	       "-q       --quiet           print a summary only on exit\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
 	       );
 	exit(error);
 }
@@ -825,6 +835,18 @@ void *run_deadline(void *data)
 
 	while (!shutdown) {
 		period = do_runtime(tid, sd, period);
+		if (tracelimit && (stat->max > tracelimit)) {
+			shutdown++;
+			pthread_mutex_lock(&break_thread_id_lock);
+			if (break_thread_id == 0) {
+				break_thread_id = stat->tid;
+				break_thread_value = stat->max;
+				tracemark( "hit latency threshold (%lld > %d)",
+						 (unsigned long long) stat->max, tracelimit);
+			}
+			pthread_mutex_unlock(&break_thread_id_lock);
+			break;
+		}
 		sched_yield();
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
@@ -1063,9 +1085,10 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
-enum options_valud {
+enum options_values {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
-	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
+	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
+	OPT_BREAKTRACE, OPT_TRACEMARK,
 };
 
 int main(int argc, char **argv)
@@ -1104,9 +1127,11 @@ int main(int argc, char **argv)
 			{ "step",	required_argument,	NULL,	OPT_STEP },
 			{ "threads",	required_argument,	NULL,	OPT_THREADS },
 			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
+			{ "breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
+			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
 			{ NULL,		0,			NULL,	0   },
 		};
-		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
+		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1141,6 +1166,10 @@ int main(int argc, char **argv)
 		case 'D':
 			duration = parse_time_string(optarg);
 			break;
+		case 'b':
+		case OPT_BREAKTRACE:
+			tracelimit = atoi(optarg);
+			break;
 		case OPT_QUIET:
 		case 'q':
 			quiet = 1;
@@ -1149,6 +1178,9 @@ int main(int argc, char **argv)
 		case 'h':
 			usage(0);
 			break;
+		case OPT_TRACEMARK:
+			trace_marker = 1;
+			break;
 		default:
 			usage(1);
 		}
@@ -1186,6 +1218,8 @@ int main(int argc, char **argv)
 		warn("mlockall");
 
 	setup_ftrace_marker();
+	if (tracelimit && trace_marker)
+		enable_trace_mark();
 
 	thread = calloc(nr_threads, sizeof(*thread));
 	sched_data = calloc(nr_threads, sizeof(*sched_data));
@@ -1294,6 +1328,13 @@ int main(int argc, char **argv)
 
 	loop(sched_data, nr_threads);
 
+	if (tracelimit) {
+		if (break_thread_id) {
+			printf("# Break thread: %d\n", break_thread_id);
+			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+		}
+	}
+
 	for (i = 0; i < nr_threads; i++) {
 
 		sd = &sched_data[i];
-- 
2.25.1

