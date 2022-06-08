Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4120C43334
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jun 2022 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiFHJ0Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiFHJZr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:47 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 01:50:51 PDT
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85FD912E33D
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Jun 2022 01:50:51 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:46236.392699032
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.43 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id CDDB21002AD;
        Wed,  8 Jun 2022 16:43:54 +0800 (CST)
Received: from  ([123.150.8.43])
        by gateway-153622-dep-749df8664c-mvcg4 with ESMTP id 34d87c02f8c24ed299594c0eef8284a1 for linux-rt-users@vger.kernel.org;
        Wed, 08 Jun 2022 16:43:56 CST
X-Transaction-ID: 34d87c02f8c24ed299594c0eef8284a1
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.43
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     linux-rt-users@vger.kernel.org, jkacur@readhat.com
Cc:     williams@readhat.com, Song Chen <chensong@kylinos.cn>
Subject: [PATCH] sched_deadline/cyclicdeadline: add tracelimit
Date:   Wed,  8 Jun 2022 16:45:13 +0800
Message-Id: <1654677913-27549-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Song Chen <chensong@kylinos.cn>

cyclictest has tracelimit to stop running when max latency
is higher than threshold but cyclicdeadline doesn't.

Therefore, tracelimit is introduced to cyclicdeadline in
this commit, once max latency is over, test stops and log
prints at the bottom of the ftrace file.

Signed-off-by: Song Chen <chensong@kylinos.cn>
---
 src/sched_deadline/cyclicdeadline.c | 37 +++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index d865fa3..ae5021f 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -80,7 +80,10 @@ struct sched_data {
 };
 
 static int shutdown;
-
+static int tracelimit = 0;
+static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
+static pid_t break_thread_id = 0;
+static uint64_t break_thread_value = 0;
 static pthread_barrier_t barrier;
 
 static int cpu_count;
@@ -689,6 +692,7 @@ static void usage(int error)
 	       "                           (default 500us).\n"
 	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
 	       "-q       --quiet           print a summary only on exit\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       );
 	exit(error);
 }
@@ -825,6 +829,19 @@ void *run_deadline(void *data)
 
 	while (!shutdown) {
 		period = do_runtime(tid, sd, period);
+		if (tracelimit && (stat->max > tracelimit)) {
+			shutdown++;
+			pthread_mutex_lock(&break_thread_id_lock);
+			if (break_thread_id == 0) {
+				break_thread_id = stat->tid;
+				break_thread_value = stat->max;
+				ftrace_write(sd->buff,
+						 "hit latency threshold (%lld > %d)",
+						 (unsigned long long) stat->max, tracelimit);
+			}
+			pthread_mutex_unlock(&break_thread_id_lock);
+			break;
+		}
 		sched_yield();
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
@@ -1063,9 +1080,9 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
-enum options_valud {
+enum options_values {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
-	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
+	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET, OPT_BREAKTRACE,
 };
 
 int main(int argc, char **argv)
@@ -1104,9 +1121,10 @@ int main(int argc, char **argv)
 			{ "step",	required_argument,	NULL,	OPT_STEP },
 			{ "threads",	required_argument,	NULL,	OPT_THREADS },
 			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
+			{ "breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{ NULL,		0,			NULL,	0   },
 		};
-		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
+		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1141,6 +1159,10 @@ int main(int argc, char **argv)
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
@@ -1294,6 +1316,13 @@ int main(int argc, char **argv)
 
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

