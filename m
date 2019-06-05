Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB97C28D1B
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34AB206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFEQGh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:37 -0400
Received: from mail.monom.org ([188.138.9.77]:35608 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbfFEQGg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 65DFF50093C;
        Wed,  5 Jun 2019 18:06:33 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 276675004BB;
        Wed,  5 Jun 2019 18:06:33 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 06/12] pmqtest: Add duration command line argument
Date:   Wed,  5 Jun 2019 18:06:11 +0200
Message-Id: <20190605160617.22987-7-wagi@monom.org>
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

  # timeout 11m pmqtest -D 10m

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/pmqtest/pmqtest.8 |  5 +++++
 src/pmqtest/pmqtest.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 05421e01e70b..9108a939b9f7 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When pmqtest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.TP
 .B \-f, \-\-forcetimeout=TO
 Set an artificial delay of the send function to force timeout of the receiver, requires the -T option
 .TP
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 75d5ee8185a0..054768d161a7 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -252,6 +252,8 @@ static void display_help(void)
 	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-D       --duration=TIME   specify a length for the test run.\n"
+	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -271,6 +273,7 @@ static int tracelimit;
 static int priority;
 static int num_threads = 1;
 static int max_cycles;
+static int duration;
 static int interval = 1000;
 static int distance = 500;
 static int smp;
@@ -293,6 +296,7 @@ static void process_options (int argc, char *argv[])
 			{"forcetimeout", required_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
+			{"duration", required_argument, NULL, 'D'},
 			{"priority", required_argument, NULL, 'p'},
 			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
@@ -300,7 +304,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f:i:l:p:St::T:",
+		int c = getopt_long (argc, argv, "a::b:d:f:i:l:D:p:St::T:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -325,6 +329,7 @@ static void process_options (int argc, char *argv[])
 		case 'f': forcetimeout = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'S':
 			smp = 1;
@@ -369,7 +374,10 @@ static void process_options (int argc, char *argv[])
 
 	if (forcetimeout && !timeout)
 		error = 1;
- 
+
+	if (duration < 0)
+		error = 1;
+
 	if (priority && smp)
 		sameprio = 1;
 
@@ -418,10 +426,15 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	sigaddset(&sigset, SIGTERM);
 	sigaddset(&sigset, SIGINT);
+	sigaddset(&sigset, SIGALRM);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
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
