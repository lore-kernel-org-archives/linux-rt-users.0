Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D25C4361A
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6308123118
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbhAZJYG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390167AbhAZJUb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:20:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4BCDAC4F;
        Tue, 26 Jan 2021 09:19:49 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v4 06/12] cyclicdeadline: Add JSON output feature
Date:   Tue, 26 Jan 2021 10:19:40 +0100
Message-Id: <20210126091946.1241-7-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126091946.1241-1-dwagner@suse.de>
References: <20210126091946.1241-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 72 ++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 71cde5781499..ed3c960d9916 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <getopt.h>
+#include <inttypes.h>
 
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -85,13 +86,11 @@ static pthread_barrier_t barrier;
 
 static int cpu_count;
 static int all_cpus;
-
 static int nr_threads;
 static int use_nsecs;
-
 static int mark_fd;
-
 static int quiet;
+static char outfile[MAX_PATH];
 
 static int find_mount(const char *mount, char *debugfs)
 {
@@ -603,16 +602,17 @@ static void usage(int error)
 	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
 	       "                           task.\n"
 	       "                           on CPU 4, and thread #5 on CPU 5.\n"
-	       "-D TIME     --duration     Specify a length for the test run.\n"
+	       "-D TIME  --duration        Specify a length for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
-	       "-h          --help         Show this help menu.\n"
-	       "-i INTV     --interval     The shortest deadline for the tasks in us\n"
+	       "-h       --help            Show this help menu.\n"
+	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
 	       "                           (default 1000us).\n"
-	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
+	       "-s STEP  --step            The amount to increase the deadline for each task in us\n"
 	       "                           (default 500us).\n"
-	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
-	       "-q          --quiet        print a summary only on exit\n"
+	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       );
 	exit(error);
 }
@@ -966,6 +966,32 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 	}
 }
 
+static void write_stats(FILE *f, void *data)
+{
+	struct sched_data *sd = data;
+	struct thread_stat *s;
+	unsigned int i;
+
+	fprintf(f, "  \"num_threads\": %d,\n", nr_threads);
+	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
+	fprintf(f, "  \"thread\": {\n");
+	for (i = 0; i < nr_threads; i++) {
+		s = &sd[i].stat;
+		fprintf(f, "    \"%u\": {\n", i);
+		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
+		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
+		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
+		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
+	}
+	fprintf(f, "  }\n");
+}
+
+enum options_valud {
+	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
+	OPT_OUTPUT, OPT_STEP, OPT_THREADS, OPT_QUIET
+};
+
 int main(int argc, char **argv)
 {
 	struct sched_data *sched_data;
@@ -992,19 +1018,21 @@ int main(int argc, char **argv)
 
 	for (;;) {
 		static struct option options[] = {
-			{ "affinity",	optional_argument,	NULL,	'a' },
-			{ "duration",	required_argument,	NULL,	'D' },
-			{ "help",	no_argument,		NULL,	'h' },
-			{ "interval",	required_argument,	NULL,	'i' },
-			{ "step",	required_argument,	NULL,	's' },
-			{ "threads",	required_argument,	NULL,	't' },
-			{ "quiet",	no_argument,		NULL,	'q' },
+			{ "affinity",	optional_argument,	NULL,	OPT_AFFINITY },
+			{ "duration",	required_argument,	NULL,	OPT_DURATION },
+			{ "help",	no_argument,		NULL,	OPT_HELP },
+			{ "interval",	required_argument,	NULL,	OPT_INTERVAL },
+			{ "output",	required_argument,	NULL,	OPT_OUTPUT },
+			{ "step",	required_argument,	NULL,	OPT_STEP },
+			{ "threads",	required_argument,	NULL,	OPT_THREADS },
+			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
 			{ NULL,		0,			NULL,	0   },
 		};
 		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_AFFINITY:
 		case 'a':
 		case 'c':
 			if (!nr_threads)
@@ -1016,21 +1044,30 @@ int main(int argc, char **argv)
 			else
 				all_cpus = 1;
 			break;
+		case OPT_INTERVAL:
 		case 'i':
 			interval = atoi(optarg);
 			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
+		case OPT_STEP:
 		case 's':
 			step = atoi(optarg);
 			break;
+		case OPT_THREADS:
 		case 't':
 			nr_threads = atoi(optarg);
 			break;
+		case OPT_DURATION:
 		case 'D':
 			duration = parse_time_string(optarg);
 			break;
+		case OPT_QUIET:
 		case 'q':
 			quiet = 1;
 			break;
+		case OPT_HELP:
 		case 'h':
 			usage(0);
 			break;
@@ -1190,6 +1227,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, argc, argv, write_stats, sched_data);
+
 	if (setcpu_buf)
 		free(setcpu_buf);
 	free(thread);
-- 
2.30.0

