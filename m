Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EDC28D18
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5452C20870
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfFEQGg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org ([188.138.9.77]:35598 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfFEQGe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:34 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 941B45008FD;
        Wed,  5 Jun 2019 18:06:32 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 572B55004BB;
        Wed,  5 Jun 2019 18:06:32 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 05/12] pi_stress: Rename -t command line option to -D
Date:   Wed,  5 Jun 2019 18:06:10 +0200
Message-Id: <20190605160617.22987-6-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Streamline the duration command line argument for all rt-tests. While
at it also add man page.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/pi_tests/pi_stress.8 |  4 ++++
 src/pi_tests/pi_stress.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index c92b4bdf5609..475d3c34f135 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -57,6 +57,10 @@ seconds and then terminate.
 The number of inversion groups to run. Defaults to 10.
 .IP \-d|\-\-debug
 Run in debug mode; lots of extra prints
+.IP "\-D, \-\-duration=TIME"
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .IP \-v|\-\-verbose
 Run with verbose messages
 .IP \-s|\-\-signal
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 543106be8e18..1286370c474b 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -146,7 +146,7 @@ int lockall = 0;
 
 /* command line options */
 struct option options[] = {
-	{"duration", required_argument, NULL, 't'},
+	{"duration", required_argument, NULL, 'D'},
 	{"verbose", no_argument, NULL, 'v'},
 	{"quiet", no_argument, NULL, 'q'},
 	{"groups", required_argument, NULL, 'g'},
@@ -1027,7 +1027,8 @@ void usage(void)
 	printf("\t--verbose\t- lots of output\n");
 	printf("\t--quiet\t\t- suppress running output\n");
 	printf
-	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
+	    ("\t--duration=<n>\t- length of the test run in seconds [infinite]\n");
+	printf("\t\t\t  Append 'm', 'h', or 'd' to specify minutes, hours or days.\n");
 	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
 	       ngroups);
 	printf
@@ -1322,13 +1323,13 @@ int process_sched_line(const char *arg)
 void process_command_line(int argc, char **argv)
 {
 	int opt;
-	while ((opt = getopt_long(argc, argv, "+ht:vqi:g:rs:pdVum", options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+hD:vqi:g:rs:pdVum", options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			usage();
 			exit(0);
-		case 't':
-			duration = strtol(optarg, NULL, 10);
+		case 'D':
+			duration = parse_time_string(optarg);
 			break;
 		case 'v':
 			verbose = 1;
-- 
2.20.1
