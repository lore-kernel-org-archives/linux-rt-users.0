Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC89C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABBC64DCF
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBQI4z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Feb 2021 03:56:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231803AbhBQI4y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Feb 2021 03:56:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1D48B0B8;
        Wed, 17 Feb 2021 08:56:12 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v6 1/2] signaltest: Add JSON output feature
Date:   Wed, 17 Feb 2021 09:56:09 +0100
Message-Id: <20210217085610.10874-2-dwagner@suse.de>
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
 src/signaltest/signaltest.c | 106 +++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 20 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index d2b90d93ceca..1d1b070cf12b 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <inttypes.h>
 
 #include <linux/unistd.h>
 
@@ -207,6 +208,14 @@ static int lockall;
 static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
+static char outfile[MAX_PATH];
+
+enum option_values {
+	OPT_AFFINITY=1, OPT_BREAKTRACE,
+	OPT_DURATION, OPT_HELP, OPT_LOOPS,
+	OPT_MLOCKALL, OPT_OUTPUT, OPT_PRIORITY,
+	OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_VERBOSE
+};
 
 /* Process commandline options */
 static void process_options(int argc, char *argv[], unsigned int max_cpus)
@@ -219,17 +228,18 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"affinity",		optional_argument,	NULL, 'a'},
-			{"breaktrace",		required_argument,	NULL, 'b'},
-			{"duration",		required_argument,	NULL, 'D'},
-			{"help",		no_argument,		NULL, 'h'},
-			{"loops",		required_argument,	NULL, 'l'},
-			{"mlockall",		no_argument,		NULL, 'm'},
-			{"priority",		required_argument,	NULL, 'p'},
-			{"quiet",		no_argument,		NULL, 'q'},
-			{"smp",			no_argument,		NULL, 'S'},
-			{"threads",		required_argument,	NULL, 't'},
-			{"verbose",		no_argument,		NULL, 'v'},
+			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
+			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
+			{"duration",	required_argument,	NULL, OPT_DURATION},
+			{"help",	no_argument,		NULL, OPT_HELP},
+			{"loops",	required_argument,	NULL, OPT_LOOPS},
+			{"mlockall",	no_argument,		NULL, OPT_MLOCKALL},
+			{"output",	required_argument,	NULL, OPT_OUTPUT},
+			{"priority",	required_argument,	NULL, OPT_PRIORITY},
+			{"quiet",	no_argument,		NULL, OPT_QUIET},
+			{"smp",		no_argument,		NULL, OPT_SMP},
+			{"threads",	required_argument,	NULL, OPT_THREADS},
+			{"verbose",	no_argument,		NULL, OPT_VERBOSE},
 			{NULL, 0, NULL, 0}
 		};
 		int c = getopt_long(argc, argv, "a::b:D:hl:mp:qSt:v",
@@ -237,6 +247,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_AFFINITY:
 		case 'a':
 			option_affinity = 1;
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
@@ -262,14 +273,39 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 				printf("Using %u cpus.\n",
 					numa_bitmask_weight(affinity_mask));
 			break;
-		case 'b': tracelimit = atoi(optarg); break;
-		case 'D': duration = parse_time_string(optarg); break;
+		case OPT_BREAKTRACE:
+		case 'b':
+			tracelimit = atoi(optarg);
+			break;
+		case OPT_DURATION:
+		case 'D':
+			duration = parse_time_string(optarg);
+			break;
+		case OPT_HELP:
 		case '?':
-		case 'h': display_help(0); break;
-		case 'l': max_cycles = atoi(optarg); break;
-		case 'm': lockall = 1; break;
-		case 'p': priority = atoi(optarg); break;
-		case 'q': quiet = 1; break;
+		case 'h':
+			display_help(0);
+			break;
+		case OPT_LOOPS:
+		case 'l':
+			max_cycles = atoi(optarg);
+			break;
+		case OPT_MLOCKALL:
+		case 'm':
+			lockall = 1;
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
 			if (numa)
 				fatal("numa and smp options are mutually exclusive\n");
@@ -277,8 +313,13 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			num_threads = -1; /* update after parsing */
 			setaffinity = AFFINITY_USEALL;
 			break;
-		case 't': num_threads = atoi(optarg); break;
-		case 'v': verbose = 1; break;
+		case OPT_THREADS:
+		case 't':
+			num_threads = atoi(optarg);
+			break;
+		case OPT_VERBOSE:
+		case 'v': verbose = 1;
+			break;
 		}
 	}
 
@@ -339,6 +380,28 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	}
 }
 
+static void write_stats(FILE *f, void *data)
+{
+	struct thread_param *par = data;
+	struct thread_stat *s;
+	unsigned int i;
+
+	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
+	fprintf(f, "  \"thread\": {\n");
+	for (i = 0; i < num_threads; i++) {
+		fprintf(f, "    \"%u\": {\n", i);
+		s = &par->stats[i];
+		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
+		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
+		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
+		fprintf(f, "      \"cpu\": %d\n", par->cpu);
+		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
+
+	}
+	fprintf(f, "  }\n");
+}
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -494,6 +557,9 @@ int main(int argc, char **argv)
 		if (stat[i].values)
 			free(stat[i].values);
 	}
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, argc, argv, write_stats, par);
+
 	free(stat);
  outpar:
 	free(par);
-- 
2.30.0

