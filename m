Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8BAC43461
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4630161353
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbhESRLO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347119AbhESRLN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3C51B19A;
        Wed, 19 May 2021 17:09:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 03/23] oslat: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:25 +0200
Message-Id: <20210519170945.21941-4-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519170945.21941-1-dwagner@suse.de>
References: <20210519170945.21941-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The initial idea was to have several different output format
supported but it turns out everyone is happy with JSON, so
there is no need to add another format.

Thus let's make the command line option more specific and
rename it to --json.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 37d528f0f7ff..32de951f27c0 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -174,7 +174,7 @@ struct global {
 	int                   quiet;
 	int                   single_preheat_thread;
 	int                   output_omit_zero_buckets;
-	char                  outfile[MAX_PATH];
+	char                  jsonfile[MAX_PATH];
 
 	/* Mutable state. */
 	volatile enum command cmd;
@@ -560,6 +560,7 @@ static void usage(int error)
 	       "-C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
 	       "-D, --duration         Specify test duration, e.g., 60, 20m, 2H\n"
 	       "                       (m/M: minutes, h/H: hours, d/D: days)\n"
+	       "    --json=FILENAME    write final results into FILENAME, JSON formatted\n"
 	       "-f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
 	       "-m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
 	       "                       Total memory usage will be this value multiplies 2*N,\n"
@@ -570,7 +571,6 @@ static void usage(int error)
 	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
 	       "                       are locked before using this parmater.  If you don't know how\n"
 	       "                       to lock the freq then please don't use this parameter.\n"
-	       "    --output=FILENAME  write final results into FILENAME, JSON formatted\n"
 	       "-T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
 	       "                       print a marker in ftrace and stop ftrace too.\n"
 	       "-v, --version          Display the version of the software.\n"
@@ -597,8 +597,8 @@ static int workload_select(char *name)
 
 enum option_value {
 	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
-	OPT_DURATION, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
-	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS, OPT_OUTPUT,
+	OPT_DURATION, OPT_JSON, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
+	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS,
 	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
 	OPT_VERSION
 };
@@ -613,6 +613,7 @@ static void parse_options(int argc, char *argv[])
 			{ "cpu-list",	required_argument,	NULL, OPT_CPU_LIST },
 			{ "cpu-main-thread", required_argument, NULL, OPT_CPU_MAIN_THREAD},
 			{ "duration",	required_argument,	NULL, OPT_DURATION },
+			{ "json",	required_argument,      NULL, OPT_JSON },
 			{ "rtprio",	required_argument,	NULL, OPT_RT_PRIO },
 			{ "help",	no_argument,		NULL, OPT_HELP },
 			{ "trace-threshold", required_argument,	NULL, OPT_TRACE_TH },
@@ -621,7 +622,6 @@ static void parse_options(int argc, char *argv[])
 			{ "bias",	no_argument,		NULL, OPT_BIAS },
 			{ "quiet",	no_argument,		NULL, OPT_QUIET },
 			{ "single-preheat", no_argument,	NULL, OPT_SINGLE_PREHEAT },
-			{ "output",	required_argument,      NULL, OPT_OUTPUT },
 			{ "zero-omit",	no_argument,		NULL, OPT_ZERO_OMIT },
 			{ "version",	no_argument,		NULL, OPT_VERSION },
 			{ NULL, 0, NULL, 0 },
@@ -677,8 +677,8 @@ static void parse_options(int argc, char *argv[])
 				exit(1);
 			}
 			break;
-		case OPT_OUTPUT:
-			strncpy(g.outfile, optarg, strnlen(optarg, MAX_PATH-1));
+		case OPT_JSON:
+			strncpy(g.jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case OPT_TRACE_TH:
 		case 'T':
@@ -862,8 +862,8 @@ int main(int argc, char *argv[])
 
 	write_summary(threads);
 
-	if (strlen(g.outfile) != 0)
-		rt_write_json(g.outfile, 0, write_summary_json, threads);
+	if (strlen(g.jsonfile) != 0)
+		rt_write_json(g.jsonfile, 0, write_summary_json, threads);
 
 	if (g.cpu_list) {
 		free(g.cpu_list);
-- 
2.31.1

