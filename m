Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92931C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8E61353
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355523AbhESRLQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347431AbhESRLP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AA15B1C2;
        Wed, 19 May 2021 17:09:55 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 11/23] ssdd: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:33 +0200
Message-Id: <20210519170945.21941-12-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519170945.21941-1-dwagner@suse.de>
References: <20210519170945.21941-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The initial idea was to have several different output format
supported but it turns out everyone is happy with JSON, so
there is no need to add another format.

Thus let's make the command line option more specific and
rename it to --json.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ssdd/ssdd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 3ead14d0127e..421688c7f47c 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -67,11 +67,11 @@ static const char *get_state_name(int state)
 #define unused __attribute__((unused))
 
 static int quiet;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 static int got_sigchld;
 
-enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_OUTPUT, OPT_QUIET };
+enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_JSON, OPT_QUIET };
 
 static void usage(int error)
 {
@@ -80,7 +80,7 @@ static void usage(int error)
 	       "ssdd <options>\n\n"
 	       "-f       --forks=NUM       number of forks\n"
 	       "-h       --help            print this message\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-q       --quiet           suppress running output\n"
 	       "-i       --iters=NUM       number of iterations\n"
 	       );
@@ -306,7 +306,7 @@ int main(int argc, char **argv)
 		static struct option long_options[] = {
 			{"forks",		required_argument,	NULL, OPT_NFORKS},
 			{"help",		no_argument,		NULL, OPT_HELP},
-			{"output",		required_argument,	NULL, OPT_OUTPUT},
+			{"json",		required_argument,	NULL, OPT_JSON},
 			{"quiet",		no_argument,		NULL, OPT_QUIET},
 			{"iters",		required_argument,	NULL, OPT_NITERS},
 			{NULL, 0, NULL, 0},
@@ -323,8 +323,8 @@ int main(int argc, char **argv)
 		case OPT_HELP:
 			usage(0);
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case OPT_QUIET:
 		case 'q':
@@ -374,8 +374,8 @@ int main(int argc, char **argv)
 		"One or more tests FAILED" :
 		"All tests PASSED");
 
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, error, NULL, NULL);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, error, NULL, NULL);
 
 	exit(error);
 }
-- 
2.31.1

