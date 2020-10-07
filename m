Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722EC4741F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F9420797
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgJGI5A (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgJGI47 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C183B15F;
        Wed,  7 Oct 2020 08:56:58 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 04/18] cyclicdeadline: Add long command line options
Date:   Wed,  7 Oct 2020 10:56:39 +0200
Message-Id: <20201007085653.11961-5-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use getopt_long to parse long version of the commands.

Change the 'a/affinity' option to handle all cases including what '-c'
did. We still keep '-c' silently supported to avoid breaking existing
users.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.8 | 17 +++++-------
 src/sched_deadline/cyclicdeadline.c | 42 ++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index 6df7faf445f9..def42f77044a 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
 .PP
 .SH SYNOPSIS
 .B cyclicdeadline
-.RI "[-ha] [-c CPUSET] [-D TIME] [-i INTV] [-s STEP] [-t NUM]"
+.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM]"
 .PP
 .SH DESCRIPTION
 .B cyclicdeadline
@@ -25,26 +25,23 @@ is a cyclictest style program for testing the deadline scheduler
 .PP
 .SH OPTIONS
 .TP
-.B \-a
-Use all CPUs
-.TP
-.B \-c CPUSET
+.B \-a \-\-affinity [CPUSET]
 Comma / hypen separated list of CPUs to run deadline tasks on
 .TP
-.B \-D TIME
+.B \-D \-\-duration TIME
 Specify a length for the test to run
 Append 'm', 'h', or 'd' to specify minutes, hours, or days
 .TP
-.B \-h
+.B \-h \-\-help
 Show this help menu
 .TP
-.B \-i INTV
+.B \-i \-\-interval INTV
 The shortest deadline for the tasks in us. (default 1000us)
 .TP
-.B \-s STEP
+.B \-s \-\-step STEP
 The amount to increase the deadline for each task in us. (default 500us)
 .TP
-.B \-t NUM
+.B \-t \-\-threads NUM
 The number of threads to run as deadline (default 1)
 .br
 .SH AUTHOR
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 310880805553..5f5cdfa08f14 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -17,6 +17,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <signal.h>
+#include <getopt.h>
 
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -635,18 +636,19 @@ static void usage(int error)
 	printf("cyclicdeadline V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "cyclicdeadline <options>\n\n"
-	       "-a                         Use all CPUs\n"
-	       "-c CPUSET                  Comma/hyphen separated list of CPUs to run deadline\n"
-	       "                           tasks on.\n"
-	       "-D TIME                    Specify a length for the test run.\n"
+	       "-a [CPUSET] --affinity     Comma/hyphen separated list of CPUs to run deadline\n"
+	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
+	       "                           task.\n"
+	       "                           on CPU 4, and thread #5 on CPU 5.\n"
+	       "-D TIME     --duration     Specify a length for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
-	       "-h                         Show this help menu.\n"
-	       "-i INTV                    The shortest deadline for the tasks in us\n"
+	       "-h          --help         Show this help menu.\n"
+	       "-i INTV     --interval     The shortest deadline for the tasks in us\n"
 	       "                           (default 1000us).\n"
-	       "-s STEP                    The amount to increase the deadline for each task in us\n"
+	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
 	       "                           (default 500us).\n"
-	       "-t NUM                     The number of threads to run as deadline (default 1).\n"
+	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
 	       );
 	exit(error);
 }
@@ -1033,15 +1035,29 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	while ((c = getopt(argc, argv, "+hac:i:s:t:D:")) >= 0) {
+	for (;;) {
+		static struct option options[] = {
+			{ "affinity",	optional_argument,	NULL,	'a' },
+			{ "duration",	required_argument,	NULL,	'D' },
+			{ "help",	no_argument,		NULL,	'h' },
+			{ "interval",	required_argument,	NULL,	'i' },
+			{ "threads",	required_argument,	NULL,	't' },
+			{ NULL,		0,			NULL,	0   },
+		};
+		c = getopt_long(argc, argv, "a::c:D:hi:t:", options, NULL);
+		if (c == -1)
+			break;
 		switch (c) {
 		case 'a':
-			all_cpus = 1;
+		case 'c':
 			if (!nr_threads)
 				nr_threads = cpu_count;
-			break;
-		case 'c':
-			setcpu = optarg;
+			if (optarg)
+				setcpu = optarg;
+			else if (optind < argc)
+				setcpu = argv[optind];
+			else
+				all_cpus = 1;
 			break;
 		case 'i':
 			interval = atoi(optarg);
-- 
2.28.0

