Return-Path: <SRS0=5+M/=CL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6CC43461
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDE420709
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBI1g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBI1f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Sep 2020 04:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67C0FB1DD;
        Wed,  2 Sep 2020 08:27:34 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 1/4] cyclicdeadline: Streamline usage output and man page
Date:   Wed,  2 Sep 2020 10:27:22 +0200
Message-Id: <20200902082725.20037-2-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902082725.20037-1-dwagner@suse.de>
References: <20200902082725.20037-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.8 | 24 ++++++++---------
 src/sched_deadline/cyclicdeadline.c | 41 +++++++++++++++--------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index 91766fb391c4..6df7faf445f9 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
 .PP
 .SH SYNOPSIS
 .B cyclicdeadline
-.RI "[-ha] [-c cpulist] [-i interval] [-s step] [-t nr_threads] [-D duration]
+.RI "[-ha] [-c CPUSET] [-D TIME] [-i INTV] [-s STEP] [-t NUM]"
 .PP
 .SH DESCRIPTION
 .B cyclicdeadline
@@ -25,28 +25,28 @@ is a cyclictest style program for testing the deadline scheduler
 .PP
 .SH OPTIONS
 .TP
-.B \-h
-Show this help menu
-.TP
 .B \-a
 Use all CPUs
 .TP
-.B \-c cpulist
+.B \-c CPUSET
 Comma / hypen separated list of CPUs to run deadline tasks on
 .TP
-.B \-i interval
+.B \-D TIME
+Specify a length for the test to run
+Append 'm', 'h', or 'd' to specify minutes, hours, or days
+.TP
+.B \-h
+Show this help menu
+.TP
+.B \-i INTV
 The shortest deadline for the tasks in us. (default 1000us)
 .TP
-.B \-s step
+.B \-s STEP
 The amount to increase the deadline for each task in us. (default 500us)
 .TP
-.B \-t nr_threads
+.B \-t NUM
 The number of threads to run as deadline (default 1)
-.TP
-.B \-D time
-Specify a length for the test to run
 .br
-Append 'm', 'h', or 'd' to specify minutes, hours, or days
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
 .PP
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index a08e28e73c42..310880805553 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -630,26 +630,25 @@ static void teardown(void)
 	destroy_cpuset(CPUSET_LOCAL, 1);
 }
 
-static void usage(char **argv)
+static void usage(int error)
 {
-	char *arg = argv[0];
-	char *p = arg+strlen(arg);
-
-	while (p >= arg && *p != '/')
-		p--;
-	p++;
-
-	printf("usage: %s [options]\n"
-	       " -h - Show this help menu\n"
-	       " -a - Use all CPUs\n"
-	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
-	       " -i interval(us) - The shortest deadline for the tasks (default 1000us)\n"
-	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
-	       " -t threads - The number of threads to run as deadline (default 1)\n"
-	       " -D time - Specify a length for the test run\n"
-	       "           Append 'm', 'h', or 'd' to specify minutes, hours or days\n"
-	       "\n", p);
-	exit(-1);
+	printf("cyclicdeadline V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "cyclicdeadline <options>\n\n"
+	       "-a                         Use all CPUs\n"
+	       "-c CPUSET                  Comma/hyphen separated list of CPUs to run deadline\n"
+	       "                           tasks on.\n"
+	       "-D TIME                    Specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
+	       "                           days\n"
+	       "-h                         Show this help menu.\n"
+	       "-i INTV                    The shortest deadline for the tasks in us\n"
+	       "                           (default 1000us).\n"
+	       "-s STEP                    The amount to increase the deadline for each task in us\n"
+	       "                           (default 500us).\n"
+	       "-t NUM                     The number of threads to run as deadline (default 1).\n"
+	       );
+	exit(error);
 }
 
 static int fail;
@@ -1057,8 +1056,10 @@ int main (int argc, char **argv)
 			duration = parse_time_string(optarg);
 			break;
 		case 'h':
+			usage(0);
+			break;
 		default:
-			usage(argv);
+			usage(1);
 		}
 	}
 
-- 
2.28.0

