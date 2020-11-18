Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BCFC56201
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3341520B1F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKRTGu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbgKRTGt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F4017BB1A;
        Wed, 18 Nov 2020 19:06:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 03/12] cyclicdeadline: Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:33 +0100
Message-Id: <20201118190642.16006-4-dwagner@suse.de>
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
 src/sched_deadline/cyclicdeadline.8 |  6 +++++-
 src/sched_deadline/cyclicdeadline.c | 22 +++++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index def42f77044a..59b60ca7bd31 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
 .PP
 .SH SYNOPSIS
 .B cyclicdeadline
-.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM]"
+.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM] [-q]"
 .PP
 .SH DESCRIPTION
 .B cyclicdeadline
@@ -43,6 +43,10 @@ The amount to increase the deadline for each task in us. (default 500us)
 .TP
 .B \-t \-\-threads NUM
 The number of threads to run as deadline (default 1)
+.TP
+.B \-q, \-\-quiet
+Print a summary only on exit. Useful for automated tests, where only
+the summary output needs to be captured.
 .br
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 7adc91465f44..40b514c5e7e0 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -108,6 +108,8 @@ static int use_nsecs;
 
 static int mark_fd;
 
+static int quiet;
+
 static int find_mount(const char *mount, char *debugfs)
 {
 	char type[100];
@@ -627,6 +629,7 @@ static void usage(int error)
 	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
 	       "                           (default 500us).\n"
 	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
+	       "-q          --quiet        print a summary only on exit\n"
 	       );
 	exit(error);
 }
@@ -966,13 +969,18 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 
 	while (!shutdown) {
 		for (i = 0; i < nr_threads; i++)
-			print_stat(stdout, &sched_data[i], i, 0, 0);
+			print_stat(stdout, &sched_data[i], i, 0, quiet);
 		usleep(10000);
-		printf("\033[%dA", nr_threads);
+		if (!quiet)
+			printf("\033[%dA", nr_threads);
 	}
 	usleep(10000);
-	for (i = 0; i < nr_threads; i++)
-		printf("\n");
+	if (!quiet) {
+		printf("\033[%dB", nr_threads + 2);
+	} else {
+		for (i = 0; i < nr_threads; ++i)
+			print_stat(stdout, &sched_data[i], i, 0, 0);
+	}
 }
 
 int main(int argc, char **argv)
@@ -1006,9 +1014,10 @@ int main(int argc, char **argv)
 			{ "help",	no_argument,		NULL,	'h' },
 			{ "interval",	required_argument,	NULL,	'i' },
 			{ "threads",	required_argument,	NULL,	't' },
+			{ "quiet",	no_argument,		NULL,	'q' },
 			{ NULL,		0,			NULL,	0   },
 		};
-		c = getopt_long(argc, argv, "a::c:D:hi:t:", options, NULL);
+		c = getopt_long(argc, argv, "a::c:D:hi:t:q", options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1035,6 +1044,9 @@ int main(int argc, char **argv)
 		case 'D':
 			duration = parse_time_string(optarg);
 			break;
+		case 'q':
+			quiet = 1;
+			break;
 		case 'h':
 			usage(0);
 			break;
-- 
2.29.2

