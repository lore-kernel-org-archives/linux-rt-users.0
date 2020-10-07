Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A223C4727E
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF86C20870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgJGI5I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgJGI5C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D0A9B176;
        Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 10/18] pmqtest: Streamline usage output and man page
Date:   Wed,  7 Oct 2020 10:56:45 +0200
Message-Id: <20201007085653.11961-11-dwagner@suse.de>
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
 src/pmqtest/pmqtest.8 |  5 ++-
 src/pmqtest/pmqtest.c | 88 ++++++++++++++++++++++---------------------
 2 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 9108a939b9f7..e44411ce0ef3 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -4,7 +4,7 @@
 \fBpmqtest\fR \- Start pairs of threads and measure the latency of interprocess communication with POSIX messages queues
 .SH "SYNTAX"
 .LP
-pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-i INTV] [-l loops] [-p PRIO] [-S] [-t|-t NUM] [-T TO]
+pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-S] [-t|-t NUM]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -26,6 +26,9 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
+.B \-h, \-\-help
+Print help message
+.TP
 .B \-f, \-\-forcetimeout=TO
 Set an artificial delay of the send function to force timeout of the receiver, requires the -T option
 .TP
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 5db8d348cdf8..938dc8d93c3f 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -217,36 +217,36 @@ void *pmqthread(void *param)
 	return NULL;
 }
 
-
-static void display_help(void)
+static void display_help(int error)
 {
 	printf("pmqtest V %1.2f\n", VERSION);
-	puts("Usage: pmqtest <options>");
-	puts("Function: test POSIX message queue latency");
-	puts(
-	"Options:\n"
-	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
-	"                           with NUM pin all threads to the processor NUM\n"
-	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
-	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
-	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
-	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
-	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	"-D       --duration=TIME   specify a length for the test run.\n"
-	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
-	"-p PRIO  --prio=PRIO       priority\n"
-	"-S       --smp             SMP testing: options -a -t and same priority\n"
-        "                           of all threads\n"
-	"-t       --threads         one thread per available processor\n"
-	"-t [NUM] --threads=NUM     number of threads:\n"
-	"                           without NUM, threads = max_cpus\n"
-	"                           without -t default = 1\n"
-	"-T TO    --timeout=TO      use mq_timedreceive() instead of mq_receive()\n"
-	"                           with timeout TO in seconds\n");
-	exit(1);
+	printf("Usage:\n"
+	       "pmqtest <options>\n\n"
+	       "Function: test POSIX message queue latency\n\n"
+	       "Available options:\n\n"
+	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	       "                           with NUM pin all threads to the processor NUM\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	       "-D TIME  --duration=TIME   specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify\n"
+	       "                           minutes, hours or days.\n"
+	       "-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
+	       "-h       --help            print this help message\n"
+	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-S       --smp             SMP testing: options -a -t and same priority\n"
+	       "                           of all threads\n"
+	       "-t       --threads         one thread per available processor\n"
+	       "-t [NUM] --threads=NUM     number of threads:\n"
+	       "                           without NUM, threads = max_cpus\n"
+	       "                           without -t default = 1\n"
+	       "-T TO    --timeout=TO      use mq_timedreceive() instead of mq_receive()\n"
+	       "                           with timeout TO in seconds\n");
+	exit(error);
 }
 
-
 static int setaffinity = AFFINITY_UNSPECIFIED;
 static int affinity;
 static int tracelimit;
@@ -270,21 +270,21 @@ static void process_options (int argc, char *argv[])
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"affinity", optional_argument, NULL, 'a'},
-			{"breaktrace", required_argument, NULL, 'b'},
-			{"distance", required_argument, NULL, 'd'},
-			{"forcetimeout", required_argument, NULL, 'f'},
-			{"interval", required_argument, NULL, 'i'},
-			{"loops", required_argument, NULL, 'l'},
-			{"duration", required_argument, NULL, 'D'},
-			{"priority", required_argument, NULL, 'p'},
-			{"smp", no_argument, NULL, 'S'},
-			{"threads", optional_argument, NULL, 't'},
-			{"timeout", required_argument, NULL, 'T'},
-			{"help", no_argument, NULL, '?'},
+			{"affinity",		optional_argument,	NULL, 'a'},
+			{"breaktrace",		required_argument,	NULL, 'b'},
+			{"distance",		required_argument,	NULL, 'd'},
+			{"duration",		required_argument,	NULL, 'D'},
+			{"forcetimeout",	required_argument,	NULL, 'f'},
+			{"help",		no_argument,		NULL, 'h'},
+			{"interval",		required_argument,	NULL, 'i'},
+			{"loops",		required_argument,	NULL, 'l'},
+			{"priority",		required_argument,	NULL, 'p'},
+			{"smp",			no_argument,		NULL, 'S'},
+			{"threads",		optional_argument,	NULL, 't'},
+			{"timeout",		required_argument,	NULL, 'T'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f:i:l:D:p:St::T:",
+		int c = getopt_long (argc, argv, "a::b:d:D:f:i:l:p:St::T:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -306,10 +306,12 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'f': forcetimeout = atoi(optarg); break;
+		case '?':
+		case 'h': display_help(0); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
-		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -329,7 +331,9 @@ static void process_options (int argc, char *argv[])
 				num_threads = max_cpus;
 			break;
 		case 'T': timeout = atoi(optarg); break;
-		case '?': error = 1; break;
+		default:
+			display_help(1);
+			break;
 		}
 	}
 
@@ -362,7 +366,7 @@ static void process_options (int argc, char *argv[])
 		sameprio = 1;
 
 	if (error)
-		display_help ();
+		display_help (error);
 }
 
 
-- 
2.28.0

