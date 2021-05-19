Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC250C43460
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E26611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbhESRLN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242807AbhESRLN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC532B195;
        Wed, 19 May 2021 17:09:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 02/23] cyclictest: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:24 +0200
Message-Id: <20210519170945.21941-3-dwagner@suse.de>
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
 src/cyclictest/cyclictest.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 59dda1973b1a..a561443fa67b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -218,7 +218,7 @@ static struct timespec globalt;
 
 static char fifopath[MAX_PATH];
 static char histfile[MAX_PATH];
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 static struct thread_param **parameters;
 static struct thread_stat **statistics;
@@ -832,6 +832,7 @@ static void display_help(int error)
 	       "-H       --histofall=US    same as -h except with an additional summary column\n"
 	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "	 --laptop	   Save battery when running cyclictest\n"
 	       "			   This will give you poorer realtime results\n"
@@ -841,7 +842,6 @@ static void display_help(int error)
 	       "			   latency is hit. Useful for low bandwidth.\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
 	       "	 --policy=NAME     policy of measurement thread, where NAME may be one\n"
 	       "                           of: other, normal, batch, idle, fifo or rr.\n"
@@ -944,14 +944,14 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
+	OPT_INTERVAL, OPT_JSON, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
 	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_OUTPUT
+	OPT_TRACEMARK, OPT_POSIX_TIMERS,
 };
 
 /* Process commandline options */
@@ -979,13 +979,13 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"histofall",        required_argument, NULL, OPT_HISTOFALL },
 			{"histfile",	     required_argument, NULL, OPT_HISTFILE },
 			{"interval",         required_argument, NULL, OPT_INTERVAL },
+			{"json",             required_argument, NULL, OPT_JSON },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
 			{"oscope",           required_argument, NULL, OPT_OSCOPE },
-			{"output",           required_argument, NULL, OPT_OUTPUT },
 			{"priority",         required_argument, NULL, OPT_PRIORITY },
 			{"quiet",            no_argument,       NULL, OPT_QUIET },
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
@@ -1080,6 +1080,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'i':
 		case OPT_INTERVAL:
 			interval = atoi(optarg); break;
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case 'l':
 		case OPT_LOOPS:
 			max_cycles = atoi(optarg); break;
@@ -1095,9 +1098,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'o':
 		case OPT_OSCOPE:
 			oscope_reduction = atoi(optarg); break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
-			break;
 		case 'p':
 		case OPT_PRIORITY:
 			priority = atoi(optarg);
@@ -2134,8 +2134,8 @@ int main(int argc, char **argv)
 	if (!verbose && !quiet && refresh_on_max)
 		printf("\033[%dB", num_threads + 2);
 
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, ret, write_stats, NULL);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, ret, write_stats, NULL);
 
 	if (quiet)
 		quiet = 2;
-- 
2.31.1

