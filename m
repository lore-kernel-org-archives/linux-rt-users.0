Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33886C41604
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF1620870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgJGI5E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgJGI5D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 338E7B17A;
        Wed,  7 Oct 2020 08:57:02 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 14/18] signaltest: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:49 +0200
Message-Id: <20201007085653.11961-15-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.8 | 13 +++++-----
 src/signaltest/signaltest.c | 47 ++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index bd6ffe5c7a36..dc3eaab2293a 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -1,11 +1,11 @@
 .\"
-.TH SIGNALTEST 8 "October 1, 2015"
+.TH SIGNALTEST 8 "September 18, 2020"
 .\" Please adjust this date whenever updating this manpage
 .SH NAME
 signaltest \- signal roundtrip test software
 .SH SYNOPSIS
-.B signaltest
-.RI "[ \-b USEC ] [ \-l LOOPS ] [ \-p PRIO] [ \-q ] [ \-t NUM ] [ \-m ] [ \-v ] [ \-\-help ]"
+.LP
+signaltest [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long options
 starting with two dashes ('\-\-').
@@ -18,6 +18,10 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
+.B \-\-help
+.br
+display usage information
+.TP
 .B \-l, \-\-loops=LOOPS
 Number of loops: default=0 (endless)
 .TP
@@ -37,9 +41,6 @@ lock current and future memory allocations
 output values on stdout for statistics
 .br
 format: n:c:v n=tasknum c=count v=value in us
-.TP
-.B \-\-help
-display usage information
 .SH AUTHOR
 signaltest was written by Thomas Gleixner <tglx@linuxtronix.de>.
 .PP
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index a67eddaf8420..c718f8676b9f 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -180,23 +180,25 @@ void *signalthread(void *param)
 
 
 /* Print usage information */
-static void display_help(void)
+static void display_help(int error)
 {
 	printf("signaltest V %1.2f\n", VERSION);
 	printf("Usage:\n"
 		"signaltest <options>\n\n"
 		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
-		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 		"-D       --duration=TIME   specify a length for the test run.\n"
-		"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
+		"                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
+		"                           days.\n"
+		"-h       --help            display usage information\n"
+		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+		"-m       --mlockall        lock current and future memory allocations\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
-		"-m       --mlockall        lock current and future memory allocations\n"
 		"-v       --verbose         output values on stdout for statistics\n"
 		"                           format: n:c:v n=tasknum c=count v=value in us\n"
-		"--help			    display usage information\n");
-	exit(0);
+		);
+	exit(error);
 }
 
 static int priority;
@@ -208,38 +210,39 @@ static int quiet;
 static int lockall = 0;
 
 /* Process commandline options */
-static void process_options (int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
 	int error = 0;
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"breaktrace", required_argument, NULL, 'b'},
-			{"loops", required_argument, NULL, 'l'},
-			{"duration", required_argument, NULL, 'D'},
-			{"priority", required_argument, NULL, 'p'},
-			{"quiet", no_argument, NULL, 'q'},
-			{"threads", required_argument, NULL, 't'},
-			{"verbose", no_argument, NULL, 'v'},
-			{"mlockall", no_argument, NULL, 'm'},
-			{"help", no_argument, NULL, '?'},
+			{"breaktrace",		required_argument,	NULL, 'b'},
+			{"duration",		required_argument,	NULL, 'D'},
+			{"help",		no_argument,		NULL, 'h'},
+			{"loops",		required_argument,	NULL, 'l'},
+			{"mlockall",		no_argument,		NULL, 'm'},
+			{"priority",		required_argument,	NULL, 'p'},
+			{"quiet",		no_argument,		NULL, 'q'},
+			{"threads",		required_argument,	NULL, 't'},
+			{"verbose",		no_argument,		NULL, 'v'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:D:np:qrsmt:v",
-			long_options, &option_index);
+		int c = getopt_long(argc, argv, "b:D:hl:mp:qt:v",
+				long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'b': tracelimit = atoi(optarg); break;
-		case 'l': max_cycles = atoi(optarg); break;
 		case 'D': duration = parse_time_string(optarg); break;
+		case '?':
+		case 'h': display_help(0); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'm': lockall = 1; break;
 		case 'p': priority = atoi(optarg); break;
 		case 'q': quiet = 1; break;
 		case 't': num_threads = atoi(optarg); break;
-		case 'm': lockall = 1; break;
 		case 'v': verbose = 1; break;
-		case '?': error = 1; break;
 		}
 	}
 
@@ -253,7 +256,7 @@ static void process_options (int argc, char *argv[])
 		error = 1;
 
 	if (error)
-		display_help ();
+		display_help(error);
 }
 
 static void check_kernel(void)
-- 
2.28.0

