Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D5C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3964F59
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEHfK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:43814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhCEHfI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7856AAE72;
        Fri,  5 Mar 2021 07:35:07 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 10/14] pip_stress: Add JSON output feature
Date:   Fri,  5 Mar 2021 08:34:56 +0100
Message-Id: <20210305073500.17926-11-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pip_stress.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 0831f698ff1d..f6096a2de273 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -67,18 +67,21 @@ struct State *statep;
 const int policy = SCHED_FIFO;
 static int prio_min;	/* Initialized for the minimum priority of policy */
 
+static char outfile[MAX_PATH];
+
 static void usage(int error)
 {
 	printf("pip_stress V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "pip_stress <options>\n"\
-	       "-h	--help                  Show this help menu.\n"
+	       "-h	 --help            Show this help menu.\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       );
 	exit(error);
 }
 
 enum option_values {
-	OPT_HELP=1
+	OPT_HELP=1, OPT_OUTPUT,
 };
 
 int main(int argc, char *argv[])
@@ -89,9 +92,11 @@ int main(int argc, char *argv[])
 	int res;
 	int *minimum_priority = (int*)&prio_min;
 
+	rt_init(argc, argv);
 	for (;;) {
 		struct option long_options[] = {
 			{"help",	no_argument,		NULL, OPT_HELP},
+			{"output",	required_argument,	NULL, OPT_OUTPUT },
 			{NULL,		0,			NULL, 0}
 		};
 
@@ -103,6 +108,9 @@ int main(int argc, char *argv[])
 		case 'h':
 			usage(0);
 			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		default:
 			usage(1);
 			break;
@@ -145,6 +153,7 @@ int main(int argc, char *argv[])
 		err_exit(err, NULL);
 	}
 
+	rt_test_start();
 	pid1 = fork();
 	if (pid1 == -1) {
 		perror("fork");
@@ -165,6 +174,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, !statep->inversion, NULL, NULL);
+
 	if (!statep->inversion) {
 		printf("No inversion incurred\n");
 		exit(1);
-- 
2.30.1

