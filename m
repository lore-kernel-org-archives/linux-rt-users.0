Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4EEC64E90
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E122228
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgKRTGu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgKRTGt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8AE3EBB1C;
        Wed, 18 Nov 2020 19:06:48 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 05/12] pmqtest: Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:35 +0100
Message-Id: <20201118190642.16006-6-dwagner@suse.de>
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
 src/pmqtest/pmqtest.8 |  5 ++++-
 src/pmqtest/pmqtest.c | 19 +++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index e44411ce0ef3..36678d0c5026 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -4,7 +4,7 @@
 \fBpmqtest\fR \- Start pairs of threads and measure the latency of interprocess communication with POSIX messages queues
 .SH "SYNTAX"
 .LP
-pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-S] [-t|-t NUM]
+pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-q] [-S] [-t|-t NUM]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -41,6 +41,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-p, \-\-prio=PRIO
 Set the priority of the process.
 .TP
+.B \-q, \-\-quiet
+Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
+.TP
 .B \-S, \-\-smp
 Test mode for symmetric multi-processing, implies -a and -t and uses the same priority on all threads.
 .TP
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index b0a2cbede4a0..5f7a24d55db6 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -232,6 +232,7 @@ static void display_help(int error)
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       "-S       --smp             SMP testing: options -a -t and same priority\n"
 	       "                           of all threads\n"
 	       "-t       --threads         one thread per available processor\n"
@@ -256,6 +257,7 @@ static int smp;
 static int sameprio;
 static int timeout;
 static int forcetimeout;
+static int quiet;
 
 static void process_options(int argc, char *argv[])
 {
@@ -275,12 +277,13 @@ static void process_options(int argc, char *argv[])
 			{"interval",		required_argument,	NULL, 'i'},
 			{"loops",		required_argument,	NULL, 'l'},
 			{"priority",		required_argument,	NULL, 'p'},
+			{"quiet",		no_argument,		NULL, 'q'},
 			{"smp",			no_argument,		NULL, 'S'},
 			{"threads",		optional_argument,	NULL, 't'},
 			{"timeout",		required_argument,	NULL, 'T'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:D:f:i:l:p:St::T:",
+		int c = getopt_long (argc, argv, "a::b:d:D:f:i:l:p:qSt::T:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -309,6 +312,7 @@ static void process_options(int argc, char *argv[])
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
+		case 'q': quiet = 1; break;
 		case 'S':
 			smp = 1;
 			num_threads = max_cpus;
@@ -378,6 +382,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
 {
 	int i;
 
+	if (quiet)
+		return;
+
 	for (i = 0; i < num_threads; i++) {
 		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d\n",
 			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
@@ -505,8 +512,9 @@ int main(int argc, char *argv[])
 
 		if (minsamples > 1 && (shutdown || newsamples > oldsamples ||
 			newtimeoutcount > oldtimeoutcount)) {
-			print_stat(stdout, receiver, sender, 0, 0);
-			printf("\033[%dA", num_threads*2);
+			print_stat(stdout, receiver, sender, 0, quiet);
+			if (!quiet)
+				printf("\033[%dA", num_threads*2);
 		}
 
 		fflush(NULL);
@@ -525,7 +533,10 @@ int main(int argc, char *argv[])
 
 	} while (!shutdown);
 
-	printf("\033[%dB", num_threads*2 + 2);
+	if (!quiet)
+		printf("\033[%dB", num_threads*2 + 2);
+	else
+		print_stat(stdout, receiver, sender, 0, 0);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
-- 
2.29.2

