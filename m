Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D693C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jun 2022 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379864AbiFQGjl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQGjk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jun 2022 02:39:40 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A80F856F9E
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jun 2022 23:39:38 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:37028.625941142
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.43 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 3A6571002DC;
        Fri, 17 Jun 2022 14:39:36 +0800 (CST)
Received: from  ([123.150.8.43])
        by gateway-153622-dep-749df8664c-nmrf6 with ESMTP id ede3d5b9c4b14f5ab68e6719e17b1dd0 for linux-rt-users@vger.kernel.org;
        Fri, 17 Jun 2022 14:39:37 CST
X-Transaction-ID: ede3d5b9c4b14f5ab68e6719e17b1dd0
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.43
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     linux-rt-users@vger.kernel.org, jkacur@redhat.com
Cc:     williams@redhat.com, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
Date:   Fri, 17 Jun 2022 14:40:52 +0800
Message-Id: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
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

---
v2:
1, disable ftrace when hitting thresold
---
 src/sched_deadline/cyclicdeadline.c | 48 ++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index d865fa3..f0f4008 100644
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
@@ -689,6 +697,7 @@ static void usage(int error)
 	       "                           (default 500us).\n"
 	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
 	       "-q       --quiet           print a summary only on exit\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       );
 	exit(error);
 }
@@ -825,6 +834,18 @@ void *run_deadline(void *data)
 
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
@@ -1063,9 +1084,10 @@ static void write_stats(FILE *f, void *data)
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
@@ -1104,9 +1126,11 @@ int main(int argc, char **argv)
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
@@ -1141,6 +1165,10 @@ int main(int argc, char **argv)
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
@@ -1149,6 +1177,9 @@ int main(int argc, char **argv)
 		case 'h':
 			usage(0);
 			break;
+		case OPT_TRACEMARK:
+			trace_marker = 1;
+			break;
 		default:
 			usage(1);
 		}
@@ -1186,6 +1217,8 @@ int main(int argc, char **argv)
 		warn("mlockall");
 
 	setup_ftrace_marker();
+	if (tracelimit && trace_marker)
+		enable_trace_mark();
 
 	thread = calloc(nr_threads, sizeof(*thread));
 	sched_data = calloc(nr_threads, sizeof(*sched_data));
@@ -1294,6 +1327,13 @@ int main(int argc, char **argv)
 
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

