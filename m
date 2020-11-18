Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8B9C6379D
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CD522227
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKRTGv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:50144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbgKRTGu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33990BB23;
        Wed, 18 Nov 2020 19:06:49 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 07/12] ptsematest: Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:37 +0100
Message-Id: <20201118190642.16006-8-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The quiet option is useful for automated test setups where
only the final result of the run is interesting. This avoids
to fill up the logs.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ptsematest/ptsematest.8 |  5 ++++-
 src/ptsematest/ptsematest.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 05a0cdfd3657..a435e7a6221c 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -4,7 +4,7 @@
 \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
 .SH "SYNOPSIS"
 .LP
-ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
+ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -38,6 +38,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-p, \-\-prio=PRIO
 Set the priority of the process.
 .TP
+.B \-q, \-\-quiet
+Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
+.TP
 .B \-S, \-\-smp
 SMP testing: options -a -t and same priority
 .TP
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 69b4e1221361..2e392299fdc4 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -156,6 +156,7 @@ static void display_help(int error)
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       "-S       --smp             SMP testing: options -a -t and same priority\n"
 	       "                           of all threads\n"
 	       "-t       --threads         one thread per available processor\n"
@@ -178,6 +179,7 @@ static int interval = 1000;
 static int distance = 500;
 static int smp;
 static int sameprio;
+static int quiet;
 
 static void process_options(int argc, char *argv[])
 {
@@ -196,11 +198,12 @@ static void process_options(int argc, char *argv[])
 			{"interval",	required_argument,	NULL, 'i'},
 			{"loops",	required_argument,	NULL, 'l'},
 			{"priority",	required_argument,	NULL, 'p'},
+			{"quiet",	no_argument	,	NULL, 'q'},
 			{"smp",		no_argument,		NULL, 'S'},
 			{"threads",	optional_argument,	NULL, 't'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::h",
+		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:qSt::h",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -228,6 +231,7 @@ static void process_options(int argc, char *argv[])
 		case 'h': display_help(0); break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
+		case 'q': quiet = 1; break;
 		case 'S':
 			smp = 1;
 			num_threads = max_cpus;
@@ -293,6 +297,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
 {
 	int i;
 
+	if (quiet)
+		return;
+
 	for (i = 0; i < num_threads; i++) {
 		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
 			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
@@ -391,8 +398,9 @@ int main(int argc, char *argv[])
 			shutdown |= receiver[i].shutdown | sender[i].shutdown;
 
 		if (receiver[0].samples > oldsamples || shutdown) {
-			print_stat(stdout, receiver, sender, 0, 0);
-			printf("\033[%dA", num_threads*2);
+			print_stat(stdout, receiver, sender, 0, quiet);
+			if (!quiet)
+				printf("\033[%dA", num_threads*2);
 		}
 
 		sigemptyset(&sigset);
@@ -405,7 +413,11 @@ int main(int argc, char *argv[])
 		sigemptyset(&sigset);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 	}
-	printf("\033[%dB", num_threads*2 + 2);
+
+	if (!quiet)
+		printf("\033[%dB", num_threads*2 + 2);
+	else
+		print_stat(stdout, receiver, sender, 0, 0);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
-- 
2.29.2

