Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E43C4727F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2972420870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgJGI5F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgJGI5E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94AD1B28E;
        Wed,  7 Oct 2020 08:57:02 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 15/18] sigwaittest: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:50 +0200
Message-Id: <20201007085653.11961-16-dwagner@suse.de>
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
 src/sigwaittest/sigwaittest.8 |  4 +-
 src/sigwaittest/sigwaittest.c | 76 +++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
index 2be9c03d05ca..a2dc1bc080a3 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -4,7 +4,7 @@
 \fBsigwaittest\fR \- Start two threads or fork two processes and measure the latency between sending and receiving a signal
 .SH "SYNTAX"
 .LP
-sigwaittest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
+sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -26,7 +26,7 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
-.B \-f, \-\-fork
+.B \-f, \-\-fork[=OPT]
 Instead of creating threads (which is the default), fork new processes
 .TP
 .B \-i, \-\-interval=INTV
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index e7393f791519..12b55e901ce5 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -206,28 +206,30 @@ void *semathread(void *param)
 }
 
 
-static void display_help(void)
+static void display_help(int error)
 {
 	printf("sigwaittest V %1.2f\n", VERSION);
-	puts("Usage: sigwaittest <options>");
-	puts("Function: test sigwait() latency");
-	puts(
-	"Options:\n"
-	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
-	"                           with NUM pin all threads to the processor NUM\n"
-	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
-	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
-	"-f       --fork            fork new processes instead of creating threads\n"
-	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
-	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	"-D       --duration=TIME   specify a length for the test run.\n"
-	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
-	"-p PRIO  --prio=PRIO       priority\n"
-	"-t       --threads         one thread per available processor\n"
-	"-t [NUM] --threads=NUM     number of threads:\n"
-	"                           without NUM, threads = max_cpus\n"
-	"                           without -t default = 1\n");
-	exit(1);
+	printf("Usage:\n"
+	       "sigwaittest <options>\n\n"
+	       "Function: test sigwait() latency\n\n"
+	       "Available options:\n"
+	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	       "                           with NUM pin all threads to the processor NUM\n"
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	       "-D       --duration=TIME   specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
+	       "                           days.\n"
+	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
+	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-t       --threads         one thread per available processor\n"
+	       "-t [NUM] --threads=NUM     number of threads:\n"
+	       "                           without NUM, threads = max_cpus\n"
+	       "                           without -t default = 1\n"
+	       );
+	exit(error);
 }
 
 
@@ -250,19 +252,19 @@ static void process_options (int argc, char *argv[])
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
-			{"affinity", optional_argument, NULL, 'a'},
-			{"breaktrace", required_argument, NULL, 'b'},
-			{"distance", required_argument, NULL, 'd'},
-			{"fork", optional_argument, NULL, 'f'},
-			{"interval", required_argument, NULL, 'i'},
-			{"loops", required_argument, NULL, 'l'},
-			{"duration", required_argument, NULL, 'D'},
-			{"priority", required_argument, NULL, 'p'},
-			{"threads", optional_argument, NULL, 't'},
-			{"help", no_argument, NULL, '?'},
+			{"affinity",		optional_argument,	NULL, 'a'},
+			{"breaktrace",		required_argument,	NULL, 'b'},
+			{"distance",		required_argument,	NULL, 'd'},
+			{"duration",		required_argument,	NULL, 'D'},
+			{"fork",		optional_argument,	NULL, 'f'},
+			{"help",		no_argument,		NULL, 'h'},
+			{"interval",		required_argument,	NULL, 'i'},
+			{"loops",		required_argument,	NULL, 'l'},
+			{"priority",		required_argument,	NULL, 'p'},
+			{"threads",		optional_argument,	NULL, 't'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:t::",
+		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:t::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -280,6 +282,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'b': thistracelimit = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'f':
 			if (optarg != NULL) {
 				wasforked = 1;
@@ -291,9 +294,12 @@ static void process_options (int argc, char *argv[])
 			} else
 				mustfork = 1;
 			break;
+		case '?':
+		case 'h':
+			display_help(0);
+			break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
-		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 't':
 			if (optarg != NULL)
@@ -303,7 +309,9 @@ static void process_options (int argc, char *argv[])
 			else
 				num_threads = max_cpus;
 			break;
-		case '?': error = 1; break;
+		default:
+			display_help(1);
+			break;
 		}
 	}
 
@@ -331,7 +339,7 @@ static void process_options (int argc, char *argv[])
 		tracelimit = thistracelimit;
 	}
 	if (error)
-		display_help ();
+		display_help (error);
 }
 
 
-- 
2.28.0

