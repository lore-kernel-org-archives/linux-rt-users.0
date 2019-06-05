Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B09C28D19
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CA8206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFEQGj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:39 -0400
Received: from mail.monom.org ([188.138.9.77]:35618 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfFEQGi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:38 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D375F5009AE;
        Wed,  5 Jun 2019 18:06:35 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 95A95500959;
        Wed,  5 Jun 2019 18:06:35 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 09/12] signaltest: Add duration command line argument
Date:   Wed,  5 Jun 2019 18:06:14 +0200
Message-Id: <20190605160617.22987-10-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Many of the test programs have the --loop argument for automatic
stopping. The main problem with the --loop argument is how long is
--loop 1000?

To simplify automated tests introduce a --duration argument which
allows to set the time how long a test should run. This allows the
test suite to define the execution time and also the timeout which a
normal human can understand.

For example run the test for 10 minutes and timeout at 11 minutes:

  # timeout 11m signaltest -D 10m

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/signaltest/signaltest.8 |  5 +++++
 src/signaltest/signaltest.c | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index 634d392a6da5..bd6ffe5c7a36 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -13,6 +13,11 @@ starting with two dashes ('\-\-').
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-l, \-\-loops=LOOPS
 Number of loops: default=0 (endless)
 .TP
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 59f979ec5ad1..a168191b7573 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -208,6 +208,8 @@ static void display_help(void)
 		"signaltest <options>\n\n"
 		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+		"-D       --duration=TIME   specify a length for the test run.\n"
+		"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
@@ -221,6 +223,7 @@ static void display_help(void)
 static int priority;
 static int num_threads = 2;
 static int max_cycles;
+static int duration;
 static int verbose;
 static int quiet;
 static int lockall = 0;
@@ -235,6 +238,7 @@ static void process_options (int argc, char *argv[])
 		static struct option long_options[] = {
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"threads", required_argument, NULL, 't'},
@@ -243,13 +247,14 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrsmt:v",
+		int c = getopt_long (argc, argv, "b:c:d:i:l:D:np:qrsmt:v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'q': quiet = 1; break;
 		case 't': num_threads = atoi(optarg); break;
@@ -259,6 +264,9 @@ static void process_options (int argc, char *argv[])
 		}
 	}
 
+	if (duration < 0)
+		error = 1;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
@@ -340,6 +348,10 @@ int main(int argc, char **argv)
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	par = calloc(num_threads, sizeof(struct thread_param));
 	if (!par)
-- 
2.20.1
