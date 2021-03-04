Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECBC4332E
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC42864F72
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhCDTYG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235470AbhCDTXs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 14:23:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 684C9AF77;
        Thu,  4 Mar 2021 19:22:28 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 12/13] ssdd: Add quiet command line option
Date:   Thu,  4 Mar 2021 20:22:19 +0100
Message-Id: <20210304192220.11272-13-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304192220.11272-1-dwagner@suse.de>
References: <20210304192220.11272-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The quiet option is useful for automated test setups where
only the final result of the run is interesting.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ssdd/ssdd.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 9fa61f39f6e3..50bec824b2e8 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -64,9 +64,11 @@ static const char *get_state_name(int state)
 
 #define unused __attribute__((unused))
 
+static int quiet;
+
 static int got_sigchld;
 
-enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP };
+enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_QUIET };
 
 static void usage(int error)
 {
@@ -75,6 +77,7 @@ static void usage(int error)
 	       "ssdd <options>\n\n"
 	       "-f       --forks=NUM       number of forks\n"
 	       "-h       --help            print this message\n"
+	       "-q       --quiet           suppress running output\n"
 	       "-i       --iters=NUM       number of iterations\n"
 	       );
 	exit(error);
@@ -176,7 +179,8 @@ static int forktests(int testid)
 	if (!child)
 		child_process();
 
-	printf("forktest#%d/%d/%d: STARTING\n", testid, parent, child);
+	if (!quiet)
+		printf("forktest#%d/%d/%d: STARTING\n", testid, parent, child);
 
 	act.sa_sigaction = sigchld;
 	sigemptyset(&act.sa_mask);
@@ -278,8 +282,8 @@ static int forktests(int testid)
 	/* There is no need for the tracer to kill the tracee. It will
 	 * automatically exit when its owner, ie, us, exits.
 	 */
-
-	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
+	if (!quiet)
+		printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
 	exit(0);
 }
 
@@ -297,10 +301,11 @@ int main(int argc, char **argv)
 		static struct option long_options[] = {
 			{"forks",		required_argument,	NULL, OPT_NFORKS},
 			{"help",		no_argument,		NULL, OPT_HELP},
+			{"quiet",		no_argument,		NULL, OPT_QUIET},
 			{"iters",		required_argument,	NULL, OPT_NITERS},
 			{NULL, 0, NULL, 0},
 		};
-		int c = getopt_long(argc, argv, "f:hi:", long_options, &option_index);
+		int c = getopt_long(argc, argv, "f:hqi:", long_options, &option_index);
 		if (c == -1)
 			break;
 		switch(c) {
@@ -312,6 +317,10 @@ int main(int argc, char **argv)
 		case OPT_HELP:
 			usage(0);
 			break;
+		case OPT_QUIET:
+		case 'q':
+			quiet = 1;
+			break;
 		case 'i':
 		case OPT_NITERS:
 			nsteps = atoi(optarg);
@@ -322,10 +331,12 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("#main : %d\n", getpid());
-	printf("#forks: %d\n", nforks);
-	printf("#steps: %d\n", nsteps);
-	printf("\n");
+	if (!quiet) {
+		printf("#main : %d\n", getpid());
+		printf("#forks: %d\n", nforks);
+		printf("#steps: %d\n", nsteps);
+		printf("\n");
+	}
 
 	for (i = 0; i < nforks; i++) {
 		child = fork();
-- 
2.30.1

