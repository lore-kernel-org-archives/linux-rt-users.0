Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB10C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C9F60C40
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhBQI44 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Feb 2021 03:56:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhBQI4z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Feb 2021 03:56:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47F14B0C6;
        Wed, 17 Feb 2021 08:56:13 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v6 2/2] sigwaittest: Add JSON output feature
Date:   Wed, 17 Feb 2021 09:56:10 +0100
Message-Id: <20210217085610.10874-3-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217085610.10874-1-dwagner@suse.de>
References: <20210217085610.10874-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sigwaittest/sigwaittest.c | 117 ++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 18 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index f10c24914d4a..0cdf30a6a769 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -39,6 +39,7 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include <pthread.h>
+#include <inttypes.h>
 
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
@@ -220,6 +221,7 @@ static void display_help(int error)
 	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-t       --threads         one thread per available processor\n"
@@ -240,6 +242,13 @@ static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int quiet;
+static char outfile[MAX_PATH];
+
+enum option_value {
+	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
+	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT,
+	OPT_PRIORITY, OPT_QUIET, OPT_THREADS
+};
 
 static void process_options(int argc, char *argv[])
 {
@@ -251,17 +260,18 @@ static void process_options(int argc, char *argv[])
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
-			{"threads",		optional_argument,	NULL, 't'},
+			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
+			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
+			{"distance",	required_argument,	NULL, OPT_DISTANCE},
+			{"duration",	required_argument,	NULL, OPT_DURATION},
+			{"fork",	optional_argument,	NULL, OPT_FORK},
+			{"help",	no_argument,		NULL, OPT_HELP},
+			{"interval",	required_argument,	NULL, OPT_INTERVAL},
+			{"loops",	required_argument,	NULL, OPT_LOOPS},
+			{"output",	required_argument,      NULL, OPT_OUTPUT },
+			{"priority",	required_argument,	NULL, OPT_PRIORITY},
+			{"quiet",	no_argument,		NULL, OPT_QUIET},
+			{"threads",	optional_argument,	NULL, OPT_THREADS},
 			{NULL, 0, NULL, 0}
 		};
 		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qt::",
@@ -269,6 +279,7 @@ static void process_options(int argc, char *argv[])
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_AFFINITY:
 		case 'a':
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
@@ -280,9 +291,19 @@ static void process_options(int argc, char *argv[])
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
@@ -294,14 +315,31 @@ static void process_options(int argc, char *argv[])
 			} else
 				mustfork = 1;
 			break;
+		case OPT_HELP:
 		case '?':
 		case 'h':
 			display_help(0);
 			break;
-		case 'i': interval = atoi(optarg); break;
-		case 'l': max_cycles = atoi(optarg); break;
-		case 'p': priority = atoi(optarg); break;
-		case 'q': quiet = 1; break;
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
+		case OPT_THREADS:
 		case 't':
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
@@ -388,6 +426,41 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
 	}
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
 int main(int argc, char *argv[])
 {
 	int i, totalsize = 0;
@@ -627,6 +700,14 @@ int main(int argc, char *argv[])
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
 nomem:
 	if (mustfork) {
 		munmap(param, totalsize);
-- 
2.30.0

