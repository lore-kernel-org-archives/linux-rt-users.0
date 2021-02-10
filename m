Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB953C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBBA64EDB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhBJRyR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:54:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhBJRxU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:53:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05248AE72;
        Wed, 10 Feb 2021 17:51:25 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v5 13/13] oslat: Add quiet command line option
Date:   Wed, 10 Feb 2021 18:51:18 +0100
Message-Id: <20210210175118.19709-14-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210175118.19709-1-dwagner@suse.de>
References: <20210210175118.19709-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The quiet option is useful for automated test setups where
only the final result of the run is interesting.

Furthermore, this makes oslat accept rt-tests standard options.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 987f2002985d..0d9afedbdc82 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -171,6 +171,7 @@ struct global {
 	uint64_t              workload_mem_size;
 	int                   enable_bias;
 	uint64_t              bias;
+	int                   quiet;
 	int                   single_preheat_thread;
 	int                   output_omit_zero_buckets;
 	char                  outfile[MAX_PATH];
@@ -565,6 +566,7 @@ static void usage(int error)
 	       "                       Total memory usage will be this value multiplies 2*N,\n"
 	       "                       because there will be src/dst buffers for each thread, and\n"
 	       "                       N is the number of processors for testing.\n"
+	       "-q  --quiet            print a summary only on exit\n"
 	       "-s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
 	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
 	       "                       are locked before using this parmater.  If you don't know how\n"
@@ -598,8 +600,8 @@ enum option_value {
 	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
 	OPT_DURATION, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
 	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS, OPT_OUTPUT,
-	OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT, OPT_VERSION
-
+	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
+	OPT_VERSION
 };
 
 /* Process commandline options */
@@ -618,13 +620,14 @@ static void parse_options(int argc, char *argv[])
 			{ "workload",	required_argument,	NULL, OPT_WORKLOAD },
 			{ "workload-mem", required_argument,	NULL, OPT_WORKLOAD_MEM },
 			{ "bias",	no_argument,		NULL, OPT_BIAS },
+			{ "quiet",	no_argument,		NULL, OPT_QUIET },
 			{ "single-preheat", no_argument,	NULL, OPT_SINGLE_PREHEAT },
 			{ "output",	required_argument,      NULL, OPT_OUTPUT },
 			{ "zero-omit",	no_argument,		NULL, OPT_ZERO_OMIT },
 			{ "version",	no_argument,		NULL, OPT_VERSION },
 			{ NULL, 0, NULL, 0 },
 		};
-		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:sw:T:vz",
+		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:T:vz",
 				       options, &option_index);
 		long ncores;
 
@@ -707,6 +710,10 @@ static void parse_options(int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case OPT_QUIET:
+		case 'q':
+			g.quiet = 1;
+			break;
 		case OPT_SINGLE_PREHEAT:
 		case 's':
 			/*
@@ -825,9 +832,11 @@ int main(int argc, char *argv[])
 	signal(SIGINT, handle_alarm);
 	signal(SIGTERM, handle_alarm);
 
-	dump_globals();
+	if (!g.quiet)
+		dump_globals();
 
-	printf("Pre-heat for 1 seconds...\n");
+	if (!g.quiet)
+		printf("Pre-heat for 1 seconds...\n");
 	if (g.single_preheat_thread)
 		g.n_threads = 1;
 	else
@@ -835,12 +844,14 @@ int main(int argc, char *argv[])
 	run_expt(threads, 1);
 	record_bias(threads);
 
-	printf("Test starts...\n");
+	if (!g.quiet)
+		printf("Test starts...\n");
 	/* Reset n_threads to always run on all the cores */
 	g.n_threads = g.n_threads_total;
 	run_expt(threads, g.runtime);
 
-	printf("Test completed.\n\n");
+	if (!g.quiet)
+		printf("Test completed.\n\n");
 
 	write_summary(threads);
 
-- 
2.30.0

