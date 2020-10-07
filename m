Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D400C4727E
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED6520870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgJGI5H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgJGI5E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE3C4B2A3;
        Wed,  7 Oct 2020 08:57:02 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 16/18] ssdd: Streamline usage and man page
Date:   Wed,  7 Oct 2020 10:56:51 +0200
Message-Id: <20201007085653.11961-17-dwagner@suse.de>
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
 src/ssdd/ssdd.8 | 35 +++++++++++++++++-----------------
 src/ssdd/ssdd.c | 50 +++++++++++++++++++++++++++----------------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
index 99f30145d079..5c29d0abb732 100644
--- a/src/ssdd/ssdd.8
+++ b/src/ssdd/ssdd.8
@@ -1,31 +1,30 @@
-.TH SSDD 8 "June 13, 2019"
+.TH SSDD 8 "September 19, 2020"
 .SH NAME
 ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
 .SH SYNOPSIS
-.B ssdd
-.RI "<options>"
+.LP
+ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM]
 .SH DESCRIPTION
-Have a tracer do a bunch of PTRACE_SINGLESTEPs against
-a tracee as fast as possible.  Create several of these
-tracer/tracee pairs and see if they can be made to
-interfere with each other.
-The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
-and checks that waitpid's return values for correctness.
+Have a tracer do a bunch of PTRACE_SINGLESTEPs against a tracee as
+fast as possible. Create several of these tracer/tracee pairs and
+see if they can be made to interfere with each other. The tracer
+waits on each PTRACE_SINGLESTEP with a waitpid(2) and checks that
+waitpid's return values for correctness.
 .SH OPTIONS
-.B \-f, \-\-forks
-number of tracer/tracee pairs to fork off.
-Default is 10.
-.br
 .TP
-.B \-i, \-\-iters
-number of PTRACE_SINGLESTEP iterations to
-do before declaring success, for each tracer/
-tracee pair set up. Default is 10,000.
+.B \-f, \-\-forks=NUM
+number of tracer/tracee pairs to fork off.
 .br
+Default is 10.
 .TP
 .B \-h, \-\-help
 Display usage
-
+.TP
+.B \-i, \-\-iters=NUM
+number of PTRACE_SINGLESTEP iterations to do before declaring
+success, for each tracer tracee pair set up.
+.br
+Default is 10,000.
 .SH AUTHOR
 ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
 .PP
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index f165da96e23a..66d6009dc572 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -68,13 +68,16 @@ static int got_sigchld;
 
 enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP };
 
-static void usage()
+static void usage(int error)
 {
-	printf("ssdd <options>\n");
-	printf("\t-f --forks=<number of forks>\n");
-	printf("\t-i --iters=<number of iterations>\n");
-	printf("\t-h --help\n");
-	exit(0);
+	printf("ssdd V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "ssdd <options>\n\n"
+	       "-f       --forks=NUM       number of forks\n"
+	       "-h       --help            print this message\n"
+	       "-i       --iters=NUM       number of iterations\n"
+	       );
+	exit(error);
 }
 
 static int do_wait(pid_t *wait_pid, int *ret_sig)
@@ -292,27 +295,30 @@ int main(int argc, char **argv)
 		int option_index = 0;
 
 		static struct option long_options[] = {
-			{"forks", required_argument, NULL, OPT_NFORKS},
-			{"iters", required_argument, NULL, OPT_NITERS},
-			{"help", no_argument, NULL, OPT_HELP},
+			{"forks",		required_argument,	NULL, OPT_NFORKS},
+			{"help",		no_argument,		NULL, OPT_HELP},
+			{"iters",		required_argument,	NULL, OPT_NITERS},
 			{NULL, 0, NULL, 0},
 		};
-		int c = getopt_long(argc, argv, "f:i:h", long_options, &option_index);
+		int c = getopt_long(argc, argv, "f:hi:", long_options, &option_index);
 		if (c == -1)
 			break;
 		switch(c) {
-			case 'f':
-			case OPT_NFORKS:
-				nforks = atoi(optarg);
-				break;
-			case 'i':
-			case OPT_NITERS:
-				nsteps = atoi(optarg);
-				break;
-			case 'h':
-			case OPT_HELP:
-				usage();
-				break;
+		case 'f':
+		case OPT_NFORKS:
+			nforks = atoi(optarg);
+			break;
+		case 'h':
+		case OPT_HELP:
+			usage(0);
+			break;
+		case 'i':
+		case OPT_NITERS:
+			nsteps = atoi(optarg);
+			break;
+		default:
+			usage(1);
+			break;
 		}
 	}
 
-- 
2.28.0

