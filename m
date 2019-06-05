Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D38C28CC5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251A8206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFEQGh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:37 -0400
Received: from mail.monom.org ([188.138.9.77]:35618 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfFEQGg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 36E395004BB;
        Wed,  5 Jun 2019 18:06:34 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id EE2F250094D;
        Wed,  5 Jun 2019 18:06:33 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 07/12] ptsematest: Add duration command line argument
Date:   Wed,  5 Jun 2019 18:06:12 +0200
Message-Id: <20190605160617.22987-8-wagi@monom.org>
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

  # timeout 11m ptsematest -D 10m

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/ptsematest/ptsematest.8 |  5 +++++
 src/ptsematest/ptsematest.c | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 9d835337ec27..289f3a1d7ae8 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When  cyclictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
 .TP
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a31c745ec928..6bedbc81b572 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -173,6 +173,8 @@ static void display_help(void)
 	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -190,6 +192,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -209,13 +212,14 @@ static void process_options (int argc, char *argv[])
 			{"distance", required_argument, NULL, 'd'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -239,6 +243,7 @@ static void process_options (int argc, char *argv[])
 		case 'd': distance = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -280,6 +285,9 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
+	if (duration < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -317,6 +325,10 @@ int main(int argc, char *argv[])
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGALRM, sighand);
+
+	if (duration)
+		alarm(duration);
 
 	receiver = calloc(num_threads, sizeof(struct params));
 	sender = calloc(num_threads, sizeof(struct params));
-- 
2.20.1
