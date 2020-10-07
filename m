Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BCCC4741F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153BE212CC
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgJGI5D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgJGI5A (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAA26B163;
        Wed,  7 Oct 2020 08:56:58 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 05/18] deadline_test: Streamline usage output and man page
Date:   Wed,  7 Oct 2020 10:56:40 +0200
Message-Id: <20201007085653.11961-6-dwagner@suse.de>
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
 src/sched_deadline/deadline_test.8 | 37 ++++++++++++-----------
 src/sched_deadline/deadline_test.c | 47 +++++++++++++++---------------
 2 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/src/sched_deadline/deadline_test.8 b/src/sched_deadline/deadline_test.8
index 5dc99c0bfc63..8f32c5b6feb6 100644
--- a/src/sched_deadline/deadline_test.8
+++ b/src/sched_deadline/deadline_test.8
@@ -19,45 +19,44 @@ deadline_test \- High resolution test program
 This program is used to test the deadline scheduler (SCHED_DEADLINE tasks)
 .SH SYNOPSIS
 .B deadline_test
-.RI "[ \-hb ] [ \-r prio ] [ \-c cpulist ] [ \-i interval ] [ \-p percent ] [ \-P percent ] [ \-t threads ] [ \-s step[us) ]"
-
+.RI "[ \-hb ] [ \-c CPUSET ] [ \-i INTV ] [ \-p PERCENT ] [ \-P PERCENT ] \
+[ \-r PRIO ]  [ \-s STEP ] [ \-t NUM ]"
 .SH OPTIONS
 .TP
-.B \-h
-Show this help menu
-.br
-.TP
 .B \-b
 Bind on the last cpu. (shortcut for -c <lastcpu>)
 .br
 .TP
-.B \-r prio
-Add an RT task with given prio to stress system
+.B \-c CPUSET
+Comma/hyphen separated list of CPUs to run deadline tasks on
 .br
 .TP
-.B \-c cpulist
-Comma/hyphen separated list of CPUs to run deadline tasks on
+.B \-h
+Show this help menu
 .br
 .TP
-.B \-i interval
+.B \-i INTV
 The shortest deadline for the tasks
 .br
 .TP
-.B \-p percent
+.B \-p PERCENT
 The percent of bandwidth to use (1-90%)
 .br
 .TP
-.B \-P percent
-The percent of runtime for execution completion
-              (Default 100%)
+.B \-P PERCENT
+The percent of runtime for execution completion (default 100%)
 .br
 .TP
-.B \-t threads
-The number of threads to run as deadline (default 1)
+.B \-r PRIO
+Add an RT task with given prio to stress system
 .br
 .TP
-.B \-s step(us)
-The amount to increase the deadline for each task (default 500us)
+.B \-s STEP
+The amount to increase the deadline for each task in us (default 500us)
+.br
+.TP
+.B \-t NUM
+The number of threads to run as deadline (default 1)
 .br
 .SH AUTHOR
 Deadline test was written by Steven Rostedt <rostedt@goodmis.org>
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 4cef2609912e..060ac896aef2 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -46,33 +46,30 @@
 
 /**
  * usage - show the usage of the program and exit.
- * @argv: The program passed in args
+ * @error: Exit error code to be used
  *
- * This is defined here to show people looking at this code how
+ * This is defined here to show peoplde looking at this code how
  * to use this program as well. 
  */
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
-	       " -b - Bind on the last cpu. (shortcut for -c <lastcpu>)\n"
-	       " -r prio - Add an RT task with given prio to stress system\n"
-	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
-	       " -i interval - The shortest deadline for the tasks\n"
-	       " -p percent - The percent of bandwidth to use (1-90%%)\n"
-	       " -P percent - The percent of runtime for execution completion\n"
-	       "              (Default 100%%)\n"
-	       " -t threads - The number of threads to run as deadline (default 1)\n"
-	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
-	       "\n", p);
-	exit(-1);
+	printf("deadline_test V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "deadline_test <options>\n"
+	       "-b                         Bind on the last cpu. (shortcut for -c <lastcpu>)\n"
+	       "-c CPUSET                  Comma/hyphen separated list of CPUs to run deadline\n"
+	       "                           tasks on\n"
+	       "-h                         Show this help menu\n"
+	       "-i INTV                    The shortest deadline for the tasks\n"
+	       "-p PERCENT                 The percent of bandwidth to use (1-90%%)\n"
+	       "-P PERCENT                 The percent of runtime for execution completion\n"
+	       "                           (default 100%%)\n"
+	       "-r PRIO                    Add an RT task with given prio to stress system\n"
+	       "-s STEP                    The amount to increase the deadline for each task in us\n"
+	       "                           (default 500us)\n"
+	       "-t NUM                     The number of threads to run as deadline (default 1)\n"
+	       );
+	exit(error);
 }
 
 #define _STR(x) #x
@@ -1753,8 +1750,10 @@ int main (int argc, char **argv)
 			rt_task = atoi(optarg);
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

