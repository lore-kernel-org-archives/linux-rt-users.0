Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3519C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 16:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA01E2224C
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 16:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbhAZJZV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:25:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:59434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390133AbhAZJUb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:20:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5931DB28A;
        Tue, 26 Jan 2021 09:19:49 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v4 04/12] cyclictest: Add JSON output feature
Date:   Tue, 26 Jan 2021 10:19:38 +0100
Message-Id: <20210126091946.1241-5-dwagner@suse.de>
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
 src/cyclictest/cyclictest.c | 46 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7c45732c1553..3d0cf3f84b69 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <inttypes.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -217,6 +218,7 @@ static struct timespec globalt;
 
 static char fifopath[MAX_PATH];
 static char histfile[MAX_PATH];
+static char outfile[MAX_PATH];
 
 static struct thread_param **parameters;
 static struct thread_stat **statistics;
@@ -838,6 +840,7 @@ static void display_help(int error)
 	       "			   latency is hit. Useful for low bandwidth.\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
 	       "	 --policy=NAME     policy of measurement thread, where NAME may be one\n"
 	       "                           of: other, normal, batch, idle, fifo or rr.\n"
@@ -945,7 +948,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS,
+	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_OUTPUT
 };
 
 /* Process commandline options */
@@ -979,6 +982,7 @@ static void process_options(int argc, char *argv[])
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
 			{"oscope",           required_argument, NULL, OPT_OSCOPE },
+			{"output",           required_argument, NULL, OPT_OUTPUT },
 			{"priority",         required_argument, NULL, OPT_PRIORITY },
 			{"quiet",            no_argument,       NULL, OPT_QUIET },
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
@@ -1073,6 +1077,9 @@ static void process_options(int argc, char *argv[])
 		case 'o':
 		case OPT_OSCOPE:
 			oscope_reduction = atoi(optarg); break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case 'p':
 		case OPT_PRIORITY:
 			priority = atoi(optarg);
@@ -1690,6 +1697,40 @@ static void rstat_setup(void)
 	return;
 }
 
+static void write_stats(FILE *f, void *data)
+{
+	struct thread_param **par = parameters;
+	unsigned int i, j, comma;
+	struct thread_stat *s;
+
+	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
+	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
+	fprintf(f, "  \"thread\": {\n");
+	for (i = 0; i < num_threads; i++) {
+		fprintf(f, "    \"%u\": {\n", i);
+
+		fprintf(f, "      \"histogram\": {");
+		s = par[i]->stats;
+		for (j = 0, comma = 0; j < histogram; j++) {
+			if (s->hist_array[j] == 0)
+				continue;
+			fprintf(f, "%s", comma ? ",\n" : "\n");
+			fprintf(f, "        \"%u\": %" PRIu64,j, s->hist_array[j]);
+			comma = 1;
+		}
+		if (comma)
+			fprintf(f, "\n");
+		fprintf(f, "      },\n");
+		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
+		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
+		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
+		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
+		fprintf(f, "      \"node\": %d\n", par[i]->node);
+		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
+	}
+	fprintf(f, "  }\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -2035,6 +2076,9 @@ int main(int argc, char **argv)
 	if (!verbose && !quiet && refresh_on_max)
 		printf("\033[%dB", num_threads + 2);
 
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, argc, argv, write_stats, NULL);
+
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-- 
2.30.0

