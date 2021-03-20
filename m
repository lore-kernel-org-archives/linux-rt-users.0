Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF2C4345F
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E5F6192F
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCTSjO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:51926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhCTSim (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A81DAD9F;
        Sat, 20 Mar 2021 18:38:41 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 33/33] ssdd: Add JSON output feature
Date:   Sat, 20 Mar 2021 19:38:29 +0100
Message-Id: <20210320183829.1318-34-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ssdd/ssdd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 50bec824b2e8..3ead14d0127e 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -36,6 +36,8 @@
 #include <sys/wait.h>
 #include <sys/ptrace.h>
 
+#include "rt-utils.h"
+
 /* do_wait return values */
 #define STATE_EXITED	1
 #define STATE_STOPPED	2
@@ -65,10 +67,11 @@ static const char *get_state_name(int state)
 #define unused __attribute__((unused))
 
 static int quiet;
+static char outfile[MAX_PATH];
 
 static int got_sigchld;
 
-enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_QUIET };
+enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_OUTPUT, OPT_QUIET };
 
 static void usage(int error)
 {
@@ -77,6 +80,7 @@ static void usage(int error)
 	       "ssdd <options>\n\n"
 	       "-f       --forks=NUM       number of forks\n"
 	       "-h       --help            print this message\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-q       --quiet           suppress running output\n"
 	       "-i       --iters=NUM       number of iterations\n"
 	       );
@@ -295,12 +299,14 @@ int main(int argc, char **argv)
 
 	setbuf(stdout, NULL);
 
+	rt_init(argc, argv);
 	for (;;) {
 		int option_index = 0;
 
 		static struct option long_options[] = {
 			{"forks",		required_argument,	NULL, OPT_NFORKS},
 			{"help",		no_argument,		NULL, OPT_HELP},
+			{"output",		required_argument,	NULL, OPT_OUTPUT},
 			{"quiet",		no_argument,		NULL, OPT_QUIET},
 			{"iters",		required_argument,	NULL, OPT_NITERS},
 			{NULL, 0, NULL, 0},
@@ -317,6 +323,9 @@ int main(int argc, char **argv)
 		case OPT_HELP:
 			usage(0);
 			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_QUIET:
 		case 'q':
 			quiet = 1;
@@ -348,6 +357,7 @@ int main(int argc, char **argv)
 			forktests(i);
 	}
 
+	rt_test_start();
 	for (i = 0; i < nforks; i++) {
 		status = do_wait(&wait_pid, &ret_sig);
 		if (status != STATE_EXITED) {
@@ -363,5 +373,9 @@ int main(int argc, char **argv)
 	printf("%s.\n", error ?
 		"One or more tests FAILED" :
 		"All tests PASSED");
+
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, error, NULL, NULL);
+
 	exit(error);
 }
-- 
2.30.2

