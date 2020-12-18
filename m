Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37388C3526D
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F38B23B75
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLRTge (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:36:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:35006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgLRTge (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 14:36:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45033ADCA;
        Fri, 18 Dec 2020 19:35:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC rt-tests v1 4/4] cyclictest: Add JSON output feature
Date:   Fri, 18 Dec 2020 20:35:40 +0100
Message-Id: <20201218193540.6168-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218193540.6168-1-dwagner@suse.de>
References: <20201218193540.6168-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add --output command line opttion which will store the results into a
JSON file.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 146 +++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c0e7600b4740..a93e9ee2426d 100644
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
@@ -950,7 +952,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS,
+	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_OUTPUT
 };
 
 /* Process commandline options */
@@ -1003,6 +1005,7 @@ static void process_options(int argc, char *argv[])
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
 			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
+			{"output",           required_argument, NULL, OPT_OUTPUT },
 			{NULL, 0, NULL, 0 },
 		};
 		int c = getopt_long(argc, argv, "a::A::b:c:d:D:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
@@ -1059,6 +1062,7 @@ static void process_options(int argc, char *argv[])
 		case OPT_HISTFILE:
 			use_histfile = 1;
 			strncpy(histfile, optarg, strnlen(optarg, MAX_PATH-1));
+			histfile[MAX_PATH-1] = '\0';
 			break;
 		case 'i':
 		case OPT_INTERVAL:
@@ -1078,6 +1082,10 @@ static void process_options(int argc, char *argv[])
 		case 'o':
 		case OPT_OSCOPE:
 			oscope_reduction = atoi(optarg); break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			outfile[MAX_PATH-1] = '\0';
+			break;
 		case 'p':
 		case OPT_PRIORITY:
 			priority = atoi(optarg);
@@ -1695,6 +1703,124 @@ static void rstat_setup(void)
 	return;
 }
 
+struct system_info {
+	char *sysname;
+	char *nodename;
+	char *release;
+	char *version;
+	char *machine;
+};
+
+struct system_info *collect_system_info(void)
+{
+	struct system_info *si;
+	struct utsname buf;
+	int err;
+
+	si = malloc(sizeof(struct system_info));
+	if (!si)
+		err_exit(ENOMEM, "malloc()");
+
+	err = uname(&buf);
+	if (err)
+		err_exit(errno, "Could not retrieve system information");
+
+	si->sysname = strdup(buf.sysname);
+	si->nodename = strdup(buf.nodename);
+	si->release = strdup(buf.release);
+	si->version = strdup(buf.version);
+	si->machine = strdup(buf.machine);
+
+	if (!si->sysname ||
+            !si->nodename ||
+	    !si->release ||
+	    !si->version ||
+	    !si->machine)
+		err_exit(ENOMEM, "Could not copy system information");
+
+	return si;
+}
+
+static char *get_cmdline(int argc, char *argv[])
+{
+	char *cmdline;
+	int len, i;
+
+	len = 0;
+	for (i = 0; i < argc; i++)
+		len += strlen(argv[i]) + 1;
+
+	cmdline = malloc(len);
+	if (!cmdline)
+		err_exit(ENOMEM, "Could not copy cmdline");
+
+	cmdline[0] = '\0';
+	for (i = 0; i < argc;) {
+		cmdline = strcat(cmdline, argv[i]);
+		i++;
+		if (i < argc)
+			cmdline = strcat(cmdline, " ");
+	}
+
+	return cmdline;
+}
+
+void free_system_info(struct system_info *sysinfo)
+{
+	free(sysinfo->sysname);
+	free(sysinfo->nodename);
+	free(sysinfo->release);
+	free(sysinfo->version);
+	free(sysinfo->machine);
+	free(sysinfo);
+}
+
+static void dump_stats(FILE *f, struct system_info *sysinfo,
+		char *cmdline, struct thread_param **par)
+{
+	unsigned int i, j, comma;
+	struct thread_stat *s;
+
+	fprintf(f, "{\n");
+	fprintf(f, "  \"file_version\": 1,\n");
+	fprintf(f, "  \"version:\": \"cyclictest V %1.2f\",\n", VERSION);
+	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
+	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
+	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
+	fprintf(f, "  \"sysinfo\": {\n");
+	fprintf(f, "    \"sysname\": \"%s\",\n", sysinfo->sysname);
+	fprintf(f, "    \"nodename\": \"%s\",\n", sysinfo->nodename);
+	fprintf(f, "    \"release\": \"%s\",\n", sysinfo->release);
+	fprintf(f, "    \"version\": \"%s\",\n", sysinfo->version);
+	fprintf(f, "    \"machine\": \"%s\"\n", sysinfo->machine);
+	fprintf(f, "  },\n");
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
+	fprintf(f, "}\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -2038,6 +2164,24 @@ int main(int argc, char **argv)
 	if (!verbose && !quiet && refresh_on_max)
 		printf("\033[%dB", num_threads + 2);
 
+	if (strlen(outfile) != 0) {
+		FILE *f = fopen(outfile, "w");
+		struct system_info *sysinfo;
+		char *cmdline;
+
+		if (!f)
+			err_exit(errno, "Failed to open output file '%s'", outfile);
+
+		sysinfo = collect_system_info();
+		cmdline = get_cmdline(argc, argv);
+
+		dump_stats(f, sysinfo, cmdline, parameters);
+
+		free(cmdline);
+		free_system_info(sysinfo);
+		fclose(f);
+	}
+
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-- 
2.29.2

