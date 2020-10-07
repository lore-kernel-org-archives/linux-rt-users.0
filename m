Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D512C47420
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2654020B1F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgJGI5I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgJGI5C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66160B17D;
        Wed,  7 Oct 2020 08:57:01 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 12/18] queuelat: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:47 +0200
Message-Id: <20201007085653.11961-13-dwagner@suse.de>
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
 src/queuelat/queuelat.8 | 41 +++++++----------
 src/queuelat/queuelat.c | 99 +++++++++++++++++++----------------------
 2 files changed, 62 insertions(+), 78 deletions(-)

diff --git a/src/queuelat/queuelat.8 b/src/queuelat/queuelat.8
index f67a0bb7556e..2f99e703c990 100644
--- a/src/queuelat/queuelat.8
+++ b/src/queuelat/queuelat.8
@@ -15,9 +15,8 @@
 .SH NAME
 queuelat \- Queue latency test program
 .SH SYNOPSIS
-.B queuelat
-.RI "[\-h] [\-m " max-queue-len "] [\-c " cycles-per-packet "] [\-p " mpps "] [\-f " tsc-freq "] [\-t " timeout "] \
-
+.LP
+queuelat [-c|--cycles N] [-f|--freq F] [-h|--help] [-m|--max-len LEN] [-p|--packets F] [-q|--queue-len N] [-t|--timeout TIME]
 .SH DESCRIPTION
 queuelat simulates a network queue checking for latency
 violations in packet processing.
@@ -25,36 +24,26 @@ violations in packet processing.
 .SH OPTIONS
 A summary of options is included below.
 .TP
-.B \-h
-Show help
-.br
+.B \-c, \-\-cycles=N
+Estimated number of cycles it takes to process one packet. This value should come from the envisioned packet forwarding application being simulated.
 .TP
-.B \-m max-queue-len
-Maximum allowed latency, in nanoseconds. If latency to process
-.br
-any packet exceeds this value, the program quits,
-writing
-.br
-a message to the trace buffer.
+.B \-f, \-\-freq=F
+TSC frequency in MHz.
 .TP
-.B \-c cycles-per-packet
-Estimated number of cycles it takes to process one packet.
-.br
-This value should come from the envisioned packet
-.br
-forwarding application being simulated.
+.B \-h, \-\-help
+Show help
 .TP
-.B \-p mpps
+.B \-m, \-\-max-len=N
+Maximum allowed latency, in nanoseconds. If latency to process any packet exceeds this value, the program quits, writing a message to the trace buffer.
+.TP
+.B \-p, \-\-packets=F
 Million packets per second that arrive for processing.
 .TP
-.B \-f tsc-freq-mhz
-TSC frequency in MHz.
+.B \-q, \-\-queue-len=N
+Minimum queue length to print in the trace
 .TP
-.B \-t timeout
+.B \-t, \-\-timeout=TIME
 Timeout in seconds to quit the program.
-.TP
-.B \-q min_queue_len_to_print_trace
-Minimum queue length to print in the trace
 
 .SH AUTHOR
 queuelat was written by Marcelo Tosatti <mtosatti@redhat.com>
diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 2b9118d8a8a5..661e48db88ac 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <signal.h>
 #include <time.h>
+#include <getopt.h>
 
 #include "rt-utils.h"
 
@@ -560,17 +561,20 @@ int calculate_nr_packets_drain_per_block(void)
 	return nr_packets_drain_per_block;
 }
 
-
-void print_help(void)
+static void print_help(int error)
 {
-	printf("usage: queuelat [options]\n");
-	printf("-h show this help menu\n");
-	printf("-m max-queue-len (maximum latency allowed, in nanoseconds) (int)\n");
-	printf("-c cycles-per-packet (number of cycles to process one packet (int)\n");
-	printf("-p million-packet-per-sec (million packets per second) (float)\n");
-	printf("-f tsc-freq-mhz (TSC frequency in MHz) (float)\n");
-	printf("-t timeout (timeout, in seconds) (int)\n");
-	printf("-q min_queue_len_to_print_trace (int)\n");
+	printf("queuelat V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "queuelat <options>\n\n"
+	       "-c N     --cycles N        number of cycles to process one packet (int)\n"
+	       "-f F     --freq F          TSC frequency in MHz (float)\n"
+	       "-h       --help            show this help menu\n"
+	       "-m LEN   --max-len LEN     maximum latency allowed, in nanoseconds (int)\n"
+	       "-p F     --packets F       million packets per second (float)\n"
+	       "-q N     --queue-len N     minimum queue len to print trace (int)\n"
+	       "-t TIME  --timeout TIME    timeout, in seconds (int)\n"
+	       );
+	exit(error);
 }
 
 int main(int argc, char **argv)
@@ -584,61 +588,59 @@ int main(int argc, char **argv)
 	char *tvalue = NULL;
 	char *qvalue = NULL;
 	int index;
-	int c;
-
-	install_signals();
 
 	opterr = 0;
 
-	while ((c = getopt (argc, argv, "m:c:p:f:t:q:h")) != -1)
-		switch (c)
-		{
-		case 'm':
-			mvalue = optarg;
+	for (;;) {
+		static struct option options[] = {
+			{"cycles",	required_argument,	NULL, 'c'},
+			{"freq",	required_argument,	NULL, 'f'},
+			{"help",	no_argument,		NULL, 'h'},
+			{"max-len",	required_argument,	NULL, 'm'},
+			{"packets",	required_argument,	NULL, 'p'},
+			{"queue-len",	required_argument,	NULL, 'q'},
+			{"timeout",	required_argument,	NULL, 't'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long(argc, argv, "c:f:hm:p:q:t:", options, NULL);
+		if (c == -1)
 			break;
+		switch (c) {
 		case 'c':
 			cvalue = optarg;
 			break;
-		case 'p':
-			pvalue = optarg;
-			break;
 		case 'f':
 			fvalue = optarg;
 			break;
-		case 't':
-			tvalue = optarg;
+		case '?':
+		case 'h':
+			print_help(0);
+			break;
+		case 'm':
+			mvalue = optarg;
+			break;
+		case 'p':
+			pvalue = optarg;
 			break;
 		case 'q':
 			qvalue = optarg;
 			break;
-		case 'h':
-			print_help();
-			return 0;
-		case '?':
-			if (optopt == 'm' || optopt == 'c' || optopt == 'p' ||
-			    optopt == 'f' || optopt == 't' || optopt == 'q') {
-				printf ("Option -%c requires an argument.\n", optopt);
-			} else if (isprint (optopt)) {
-				printf ("Unknown option `-%c'.\n", optopt);
-				print_help();
-				return 1;
-			} else {
-				printf ( "Unknown option character `\\x%x'.\n", optopt);
-				print_help();
-				return 1;
-			}
+		case 't':
+			tvalue = optarg;
 			break;
 		default:
-			abort ();
+			print_help(1);
+			break;
 		}
+	}
 
-	if (mvalue == NULL || cvalue == NULL || pvalue == NULL ||
-	    fvalue == NULL) {
-		printf("options -m, -c, -p and -f are required.\n");
-		printf("usage: %s -m maxlatency -c cycles_per_packet -p mpps(million-packet-per-sec) -f tsc_freq_mhz [-t timeout (in secs)] [-q min_queue_len_to_print_trace]\n", argv[0]);
-		return 1;
+	if (mvalue == NULL || cvalue == NULL || pvalue == NULL || fvalue == NULL) {
+		printf("options -m, -c, -p and -f are required\n");
+		exit(1);
 	}
 
+	install_signals();
+
 	maxlatency = atoi(mvalue);
         cycles_per_packet = atoi(cvalue);
         mpps = atof(pvalue);
@@ -654,13 +656,6 @@ int main(int argc, char **argv)
 		min_queue_size_to_print = atoi(qvalue);
 	}
 
-	if (optind != argc) {
-		for (index = optind; index < argc; index++) {
-			printf ("Error, non-option argument %s\n", argv[index]);
-		}
-		return 1;
-	}
-
 	convert_to_ghz(tsc_freq_mhz);
 
 	max_queue_len_f = maxlatency / (cycles_per_packet*cycles_to_ns);
-- 
2.28.0

