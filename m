Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A1C433E9
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E2F2311A
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 09:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbhAZJYe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:24:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:59504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390195AbhAZJUc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:20:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 222ECB8F3;
        Tue, 26 Jan 2021 09:19:51 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v4 10/12] svsematest: Add JSON output feature
Date:   Tue, 26 Jan 2021 10:19:44 +0100
Message-Id: <20210126091946.1241-11-dwagner@suse.de>
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
 src/svsematest/svsematest.c | 124 ++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 20 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7a298e0dea8c..23f84bcbd3dc 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <time.h>
 #include <utmpx.h>
+#include <inttypes.h>
 
 #include <linux/unistd.h>
 
@@ -233,6 +234,7 @@ static void display_help(int error)
 	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
 	       "-S       --smp             SMP testing: options -a -t and same priority\n"
 	       "                           of all threads\n"
@@ -255,6 +257,13 @@ static int distance = 500;
 static int smp;
 static int sameprio;
 static int quiet;
+static char outfile[MAX_PATH];
+
+enum option_value {
+	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
+	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT,
+	OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS
+};
 
 static void process_options(int argc, char *argv[])
 {
@@ -266,18 +275,19 @@ static void process_options(int argc, char *argv[])
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"affinity",		optional_argument,	NULL, 'a'},
-			{"breaktrace",		required_argument,	NULL, 'b'},
-			{"distance",		required_argument,	NULL, 'd'},
-			{"duration",		required_argument,	NULL, 'D'},
-			{"fork",		optional_argument,	NULL, 'f'},
-			{"help",		no_argument,		NULL, 'h'},
-			{"interval",		required_argument,	NULL, 'i'},
-			{"loops",		required_argument,	NULL, 'l'},
-			{"priority",		required_argument,	NULL, 'p'},
-			{"quiet",		no_argument,		NULL, 'q'},
-			{"smp",			no_argument,		NULL, 'S'},
-			{"threads",		optional_argument,	NULL, 't'},
+			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
+			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
+			{"distance",	required_argument,	NULL, OPT_DISTANCE},
+			{"duration",	required_argument,	NULL, OPT_DURATION},
+			{"fork",	optional_argument,	NULL, OPT_FORK},
+			{"help",	no_argument,		NULL, OPT_HELP},
+			{"interval",	required_argument,	NULL, OPT_INTERVAL},
+			{"loops",	required_argument,	NULL, OPT_LOOPS},
+			{"output",	required_argument,      NULL, OPT_OUTPUT},
+			{"priority",	required_argument,	NULL, OPT_PRIORITY},
+			{"quiet",	no_argument,		NULL, OPT_QUIET},
+			{"smp",		no_argument,		NULL, OPT_SMP},
+			{"threads",	optional_argument,	NULL, OPT_THREADS},
 			{NULL, 0, NULL, 0}
 		};
 		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qSt::",
@@ -285,6 +295,7 @@ static void process_options(int argc, char *argv[])
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_AFFINITY:
 		case 'a':
 			if (smp) {
 				warn("-a ignored due to --smp\n");
@@ -300,9 +311,19 @@ static void process_options(int argc, char *argv[])
 				setaffinity = AFFINITY_USEALL;
 			}
 			break;
-		case 'b': thistracelimit = atoi(optarg); break;
-		case 'd': distance = atoi(optarg); break;
-		case 'D': duration = parse_time_string(optarg); break;
+		case OPT_BREAKTRACE:
+		case 'b':
+			thistracelimit = atoi(optarg);
+			break;
+		case OPT_DISTANCE:
+		case 'd':
+			distance = atoi(optarg);
+			break;
+		case OPT_DURATION:
+		case 'D':
+			duration = parse_time_string(optarg);
+			break;
+		case OPT_FORK:
 		case 'f':
 			if (optarg != NULL) {
 				wasforked = 1;
@@ -314,16 +335,36 @@ static void process_options(int argc, char *argv[])
 			} else
 				mustfork = 1;
 			break;
-		case 'h': display_help(0); break;
-		case 'i': interval = atoi(optarg); break;
-		case 'l': max_cycles = atoi(optarg); break;
-		case 'p': priority = atoi(optarg); break;
-		case 'q': quiet = 1; break;
+		case OPT_HELP:
+		case 'h':
+			display_help(0);
+			break;
+		case OPT_INTERVAL:
+		case 'i':
+			interval = atoi(optarg);
+			break;
+		case OPT_LOOPS:
+		case 'l':
+			max_cycles = atoi(optarg);
+			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
+		case OPT_PRIORITY:
+		case 'p':
+			priority = atoi(optarg);
+			break;
+		case OPT_QUIET:
+		case 'q':
+			quiet = 1;
+			break;
+		case OPT_SMP:
 		case 'S':
 			smp = 1;
 			num_threads = max_cpus;
 			setaffinity = AFFINITY_USEALL;
 			break;
+		case OPT_THREADS:
 		case 't':
 			if (smp) {
 				warn("-t ignored due to --smp\n");
@@ -380,6 +421,41 @@ static void sighand(int sig)
 	mustshutdown = 1;
 }
 
+struct params_stats {
+	struct params *receiver;
+	struct params *sender;
+};
+
+static void write_stats(FILE *f, void *data)
+{
+	struct params_stats *ps = data;
+	struct params *s, *r;
+	unsigned int i;
+
+	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
+	fprintf(f, "  \"thread\": {\n");
+	for (i = 0; i < num_threads; i++) {
+		s = &ps->sender[i];
+		r = &ps->receiver[i];
+		fprintf(f, "    \"%u\": {\n", i);
+		fprintf(f, "      \"sender\": {\n");
+		fprintf(f, "        \"cpu\": %d,\n", s->cpu);
+		fprintf(f, "        \"priority\": %d,\n", s->priority);
+		fprintf(f, "        \"samples\": %d,\n", s->samples);
+		fprintf(f, "        \"interval\": %ld\n", r->delay.tv_nsec/1000);
+		fprintf(f, "      },\n");
+		fprintf(f, "      \"receiver\": {\n");
+		fprintf(f, "        \"cpu\": %d,\n", r->cpu);
+		fprintf(f, "        \"priority\": %d,\n", r->priority);
+		fprintf(f, "        \"min\": %d,\n", r->mindiff);
+		fprintf(f, "        \"avg\": %.2f,\n", r->sumdiff/r->samples);
+		fprintf(f, "        \"max\": %d\n", r->maxdiff);
+		fprintf(f, "      }\n");
+		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
+	}
+	fprintf(f, "  }\n");
+}
+
 static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
 		       int verbose, int quiet)
 {
@@ -696,6 +772,14 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (strlen(outfile) != 0) {
+		struct params_stats ps = {
+			.receiver = receiver,
+			.sender = sender,
+		};
+		rt_write_json(outfile, argc, argv, write_stats, &ps);
+	}
+
 nosem:
 	for (i = 0; i < num_threads; i++)
 		semctl(receiver[i].semid, -1, IPC_RMID);
-- 
2.30.0

