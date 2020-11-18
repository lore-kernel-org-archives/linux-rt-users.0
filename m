Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA5DC64E75
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3534222228
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKRTGv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:50062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbgKRTGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64CCABB12;
        Wed, 18 Nov 2020 19:06:50 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 11/12] sigwaittest: Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:41 +0100
Message-Id: <20201118190642.16006-12-dwagner@suse.de>
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
 src/sigwaittest/sigwaittest.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index d3be2fd9508c..7e287bd2424f 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -221,6 +221,7 @@ static void display_help(int error)
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-p PRIO  --prio=PRIO       priority\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
@@ -238,6 +239,7 @@ static int max_cycles;
 static int duration;
 static int interval = 1000;
 static int distance = 500;
+static int quiet;
 
 static void process_options(int argc, char *argv[])
 {
@@ -258,10 +260,11 @@ static void process_options(int argc, char *argv[])
 			{"interval",		required_argument,	NULL, 'i'},
 			{"loops",		required_argument,	NULL, 'l'},
 			{"priority",		required_argument,	NULL, 'p'},
+			{"quiet",		no_argument,		NULL, 'q'},
 			{"threads",		optional_argument,	NULL, 't'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:t::",
+		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qt::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -298,6 +301,7 @@ static void process_options(int argc, char *argv[])
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
+		case 'q': quiet = 1; break;
 		case 't':
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
@@ -352,6 +356,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
 {
 	int i;
 
+	if (quiet)
+		return;
+
 	for (i = 0; i < num_threads; i++) {
 		int receiver_pid, sender_pid;
 		if (mustfork) {
@@ -577,8 +584,9 @@ int main(int argc, char *argv[])
 			    sender[i].shutdown;
 
 		if (receiver[0].samples > oldsamples || mustshutdown) {
-			print_stat(stdout, receiver, sender, 0, 0);
-			printf("\033[%dA", num_threads*2);
+			print_stat(stdout, receiver, sender, 0, quiet);
+			if (!quiet)
+				printf("\033[%dA", num_threads*2);
 		}
 
 		sigemptyset(&sigset);
@@ -593,7 +601,10 @@ int main(int argc, char *argv[])
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 	}
 
-	printf("\033[%dB", num_threads*2 + 2);
+	if (!quiet)
+		printf("\033[%dB", num_threads*2 + 2);
+	else
+		print_stat(stdout, receiver, sender, 0, 0);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
-- 
2.29.2

