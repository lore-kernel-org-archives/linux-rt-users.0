Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB4BC43600
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D788A610CC
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbhESRLP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347475AbhESRLP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69980B1A7;
        Wed, 19 May 2021 17:09:54 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 08/23] cyclicdeadline: Rename command line option --output to --json
Date:   Wed, 19 May 2021 19:09:30 +0200
Message-Id: <20210519170945.21941-9-dwagner@suse.de>
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
 src/sched_deadline/cyclicdeadline.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index b81fb3a2091d..4c81891bbe63 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -89,7 +89,7 @@ static int nr_threads;
 static int use_nsecs;
 static int mark_fd;
 static int quiet;
-static char outfile[MAX_PATH];
+static char jsonfile[MAX_PATH];
 
 static int find_mount(const char *mount, char *debugfs)
 {
@@ -605,7 +605,7 @@ static void usage(int error)
 	       "-h       --help            Show this help menu.\n"
 	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
 	       "                           (default 1000us).\n"
-	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
+	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-s STEP  --step            The amount to increase the deadline for each task in us\n"
 	       "                           (default 500us).\n"
 	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
@@ -986,7 +986,7 @@ static void write_stats(FILE *f, void *data)
 
 enum options_valud {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
-	OPT_OUTPUT, OPT_STEP, OPT_THREADS, OPT_QUIET
+	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
 };
 
 int main(int argc, char **argv)
@@ -1021,7 +1021,7 @@ int main(int argc, char **argv)
 			{ "duration",	required_argument,	NULL,	OPT_DURATION },
 			{ "help",	no_argument,		NULL,	OPT_HELP },
 			{ "interval",	required_argument,	NULL,	OPT_INTERVAL },
-			{ "output",	required_argument,	NULL,	OPT_OUTPUT },
+			{ "json",	required_argument,	NULL,	OPT_JSON },
 			{ "step",	required_argument,	NULL,	OPT_STEP },
 			{ "threads",	required_argument,	NULL,	OPT_THREADS },
 			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
@@ -1047,8 +1047,8 @@ int main(int argc, char **argv)
 		case 'i':
 			interval = atoi(optarg);
 			break;
-		case OPT_OUTPUT:
-			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+		case OPT_JSON:
+			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case OPT_STEP:
 		case 's':
@@ -1227,8 +1227,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (strlen(outfile) != 0)
-		rt_write_json(outfile, 0, write_stats, sched_data);
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, 0, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
-- 
2.31.1

