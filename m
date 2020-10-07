Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34428C4363C
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B222083B
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgJGI5G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGI5F (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9665B2A5;
        Wed,  7 Oct 2020 08:57:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 18/18] hackbench: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:53 +0200
Message-Id: <20201007085653.11961-19-dwagner@suse.de>
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
 src/hackbench/hackbench.8 |  70 ++++++++++++++------------
 src/hackbench/hackbench.c | 102 ++++++++++++++++++--------------------
 2 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/src/hackbench/hackbench.8 b/src/hackbench/hackbench.8
index aaf572359704..4c2c8ad9cb1a 100644
--- a/src/hackbench/hackbench.8
+++ b/src/hackbench/hackbench.8
@@ -1,13 +1,17 @@
-.TH "hackbench" "8" "February  23, 2010" "" ""
+.TH "hackbench" "8" "September  19, 2020" "" ""
 .SH "NAME"
 hackbench \- scheduler benchmark/stress test
 .SH "SYNOPSIS"
 .B hackbench
-.RI "[\-p|\-\-pipe] [\-s|\-\-datasize " <bytes> "] " 
-.RI "[\-l|\-\-loops " <num\-loops> "] "
-.RI "[\-g|\-\-groups "<num\-groups> "] "
-.RI "[\-f|\-\-fds <num\-fds>] "
-.RI "[\-T|\-\-threads] [\-P|\-\-process] [\-F|\-\-fifo] [\-\-help]"
+.RI "[\-f|\-\-fds NUM] "
+.RI "[\-F|\-\-fifo] "
+.RI "[\-g|\-\-groups NUM] "
+.RI "[\-h|\-\-help] "
+.RI "[\-l|\-\-loops LOOPS] "
+.RI "[\-p|\-\-pipe] "
+.RI "[\-s|\-\-datasize SIZE] "
+.RI "[\-T|\-\-threads]"
+.RI "[\-P|\-\-process]"
 
 .SH "DESCRIPTION"
 Hackbench is both a benchmark and a stress test for the Linux kernel
@@ -19,45 +23,45 @@ each pair to send data back and forth.
 .SH "OPTIONS"
 These programs follow the usual GNU command line syntax, with long
 options starting with two dashes ("\-\-").
-.br 
+.br
 A summary of options is included below.
-.TP 
+.TP
+.B \-f, \-\-fds=NUM
+Defines how many file descriptors each child should use.
+Note that the effective number will be twice the amount you set here,
+as the sender and receiver children will each open the given amount of
+file descriptors.
+.TP
+.B \-F,\-\-fifo
+Change the main thread to SCHED_FIFO after creating workers.
+This allows the management thread to run after many workers are created.
+.TP
+.B \-g, \-\-groups=NUM
+Defines how many groups of senders and receivers should be started
+.TP
+.B \-h, \-\-help
+.TP
+.B \-l, \-\-loops=LOOPS
+How many messages each sender/receiver pair should send
+.TP
 .B \-p, \-\-pipe
 Sends the data via a pipe instead of the socket (default)
-.TP 
-.B \-s, \-\-datasize=<size in bytes>
+.TP
+.B \-s, \-\-datasize=SIZE
 Sets the amount of data to send in each message
-.TP 
-.B \-l, \-\-loops=<number of loops>
-How many messages each sender/receiver pair should send
-.TP 
-.B \-g, \-\-groups=<number of groups>
-Defines how many groups of senders and receivers should be started
-.TP 
-.B \-f, \-\-fds=<number of file descriptors>
-Defines how many file descriptors each child should use. 
-Note that the effective number will be twice the amount you set here,
-as the sender and receiver children will each open the given amount of 
-file descriptors.
-.TP 
+.TP
 .B \-T, \-\-threads
 Each sender/receiver child will be a POSIX thread of the parent.
-.TP 
+.TP
 .B \-P, \-\-process
 Hackbench will use fork() on all children (default behaviour)
-.TP
-.B \-F,\-\-fifo
-Change the main thread to SCHED_FIFO after creating workers.
-This allows the management thread to run after many workers are created.
-.TP 
-.B \-\-help
-.br 
+.br
 Shows a simple help screen
 .SH "EXAMPLES"
-.LP 
+.LP
 Running hackbench without any options will give default behaviour,
 using fork() and sending data between senders and receivers via sockets.
-.LP 
+.LP
 user@host: ~ $ hackbench
 .br 
 Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 2cddff654df6..268c23233004 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -88,12 +88,22 @@ static void barf(const char *msg)
 	exit(1);
 }
 
-static void print_usage_exit()
+static void print_usage_exit(int error)
 {
-	printf("Usage: hackbench [-p|--pipe] [-s|--datasize <bytes>] [-l|--loops <num loops>]\n"
-	       "\t\t [-g|--groups <num groups] [-f|--fds <num fds>]\n"
-	       "\t\t [-T|--threads] [-P|--process] [-F|--fifo] [--help]\n");
-	exit(1);
+	printf("hackbench V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "hackbench <options>\n\n"
+	       "-f       --fds=NUM         number of fds\n"
+	       "-F       --fifo            use SCHED_FIFO for main thread\n"
+	       "-g       --groups=NUM      number of groups to be used\n"
+	       "-h       --help            print this message\n"
+	       "-l       --loops=LOOPS     how many message should be send\n"
+	       "-p       --pipe            send data via a pipe\n"
+	       "-s       --datasize=SIZE   message size\n"
+	       "-T       --threads         use POSIX threads\n"
+	       "-P       --process         use fork (default)\n"
+	       );
+	exit(error);
 }
 
 static void fdpair(int fds[2])
@@ -342,86 +352,72 @@ static unsigned int group(childinfo_t *child,
 	return num_fds * 2;
 }
 
-static void process_options (int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
-	int error = 0;
-
-	while( 1 ) {
+	for(;;) {
 		int optind = 0;
 
 		static struct option longopts[] = {
-			{"pipe",      no_argument,	 NULL, 'p'},
-			{"datasize",  required_argument, NULL, 's'},
-			{"loops",     required_argument, NULL, 'l'},
-			{"groups",    required_argument, NULL, 'g'},
-			{"fds",	      required_argument, NULL, 'f'},
-			{"threads",   no_argument,	 NULL, 'T'},
-			{"processes", no_argument,	 NULL, 'P'},
-			{"fifo",      no_argument,       NULL, 'F'},
-			{"help",      no_argument,	 NULL, 'h'},
+			{"fds",		required_argument,	NULL, 'f'},
+			{"fifo",	no_argument,		NULL, 'F'},
+			{"groups",	required_argument,	NULL, 'g'},
+			{"help",	no_argument,		NULL, 'h'},
+			{"loops",	required_argument,	NULL, 'l'},
+			{"pipe",	no_argument,		NULL, 'p'},
+			{"datasize",	required_argument,	NULL, 's'},
+			{"threads",	no_argument,		NULL, 'T'},
+			{"processes",	no_argument,		NULL, 'P'},
 			{NULL, 0, NULL, 0}
 		};
 
-		int c = getopt_long(argc, argv, "ps:l:g:f:TPFh",
+		int c = getopt_long(argc, argv, "f:Fg:hl:ps:TP",
 				    longopts, &optind);
 		if (c == -1) {
 			break;
 		}
 		switch (c) {
-		case 'p':
-			use_pipes = 1;
+		case 'f':
+			if (!(argv[optind] && (num_fds = atoi(optarg)) > 0)) {
+				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
+				print_usage_exit(1);
+			}
 			break;
-
-		case 's':
-			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
-				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
-				error = 1;
+		case 'F':
+			fifo = 1;
+			break;
+		case 'g':
+			if (!(argv[optind] && (num_groups = atoi(optarg)) > 0)) {
+				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
+				print_usage_exit(1);
 			}
 			break;
-
+		case 'h':
+			print_usage_exit(0);
 		case 'l':
 			if (!(argv[optind] && (loops = atoi(optarg)) > 0)) {
 				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
-				error = 1;
+				print_usage_exit(1);
 			}
 			break;
-
-		case 'g':
-			if (!(argv[optind] && (num_groups = atoi(optarg)) > 0)) {
-				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
-				error = 1;
-			}
+		case 'p':
+			use_pipes = 1;
 			break;
-
-		case 'f':
-			if (!(argv[optind] && (num_fds = atoi(optarg)) > 0)) {
-				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
-				error = 1;
+		case 's':
+			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
+				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
+				print_usage_exit(1);
 			}
 			break;
-
 		case 'T':
 			process_mode = THREAD_MODE;
 			break;
 		case 'P':
 			process_mode = PROCESS_MODE;
 			break;
-
-		case 'F':
-			fifo = 1;
-			break;
-
-		case 'h':
-			print_usage_exit();
-
 		default:
-			error = 1;
+			print_usage_exit(1);
 		}
 	}
-
-	if( error ) {
-		exit(1);
-	}
 }
 
 void sigcatcher(int sig) {
-- 
2.28.0

