Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B9C4727F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24E2080A
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgJGI5J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgJGI5B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BD15B171;
        Wed,  7 Oct 2020 08:57:01 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 11/18] ptsematest: Streamline usage output and man page
Date:   Wed,  7 Oct 2020 10:56:46 +0200
Message-Id: <20201007085653.11961-12-dwagner@suse.de>
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
 src/ptsematest/ptsematest.8 |  5 ++-
 src/ptsematest/ptsematest.c | 76 +++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 5ee7d694d50d..05a0cdfd3657 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -4,7 +4,7 @@
 \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
 .SH "SYNOPSIS"
 .LP
-ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME][-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
+ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -26,6 +26,9 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
+.B \-h, \-\-help
+Print help message.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
 .TP
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index de8ea2fe1b0c..02919e3f5eef 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -141,29 +141,31 @@ void *semathread(void *param)
 }
 
 
-static void display_help(void)
+static void display_help(int error)
 {
 	printf("ptsematest V %1.2f\n", VERSION);
-	puts("Usage: ptsematest <options>");
-	puts("Function: test POSIX threads mutex latency");
-	puts(
-	"Options:\n"
-	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
-	"                           with NUM pin all threads to the processor NUM\n"
-	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
-	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
-	"-D       --duration=TIME   specify a length for the test run.\n"
-	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
-	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
-	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	"-p PRIO  --prio=PRIO       priority\n"
-	"-S       --smp             SMP testing: options -a -t and same priority\n"
-        "                           of all threads\n"
-	"-t       --threads         one thread per available processor\n"
-	"-t [NUM] --threads=NUM     number of threads:\n"
-	"                           without NUM, threads = max_cpus\n"
-	"                           without -t default = 1\n");
-	exit(1);
+	printf("Usage:\n"
+	       "ptsematest <options>\n\n"
+	       "Function: test POSIX threads mutex latency\n\n"
+	       "Available options:\n"
+	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	       "                           with NUM pin all threads to the processor NUM\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	       "-D       --duration=TIME   specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
+	       "                           days.\n"
+	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-S       --smp             SMP testing: options -a -t and same priority\n"
+	       "                           of all threads\n"
+	       "-t       --threads         one thread per available processor\n"
+	       "-t [NUM] --threads=NUM     number of threads:\n"
+	       "                           without NUM, threads = max_cpus\n"
+	       "                           without -t default = 1\n"
+	       );
+	exit(0);
 }
 
 
@@ -188,16 +190,16 @@ static void process_options (int argc, char *argv[])
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"affinity", optional_argument, NULL, 'a'},
-			{"breaktrace", required_argument, NULL, 'b'},
-			{"distance", required_argument, NULL, 'd'},
-			{"interval", required_argument, NULL, 'i'},
-			{"loops", required_argument, NULL, 'l'},
-			{"duration", required_argument, NULL, 'D'},
-			{"priority", required_argument, NULL, 'p'},
-			{"smp", no_argument, NULL, 'S'},
-			{"threads", optional_argument, NULL, 't'},
-			{"help", no_argument, NULL, '?'},
+			{"affinity",	optional_argument,	NULL, 'a'},
+			{"breaktrace",	required_argument,	NULL, 'b'},
+			{"distance",	required_argument,	NULL, 'd'},
+			{"duration",	required_argument,	NULL, 'D'},
+			{"help",	no_argument,		NULL, 'h'},
+			{"interval",	required_argument,	NULL, 'i'},
+			{"loops",	required_argument,	NULL, 'l'},
+			{"priority",	required_argument,	NULL, 'p'},
+			{"smp",		no_argument,		NULL, 'S'},
+			{"threads",	optional_argument,	NULL, 't'},
 			{NULL, 0, NULL, 0}
 		};
 		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::h",
@@ -222,9 +224,11 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'i': interval = atoi(optarg); break;
+		case '?':
+		case 'h': display_help(0); break;
 		case 'l': max_cycles = atoi(optarg); break;
-		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -243,9 +247,9 @@ static void process_options (int argc, char *argv[])
 			else
 				num_threads = max_cpus;
 			break;
-		case 'h':
-			display_help();
-		case '?': error = 1; break;
+		default:
+			display_help(1);
+			break;
 		}
 	}
 
@@ -275,7 +279,7 @@ static void process_options (int argc, char *argv[])
 		sameprio = 1;
 
 	if (error)
-		display_help();
+		display_help(error);
 }
 
 
-- 
2.28.0

