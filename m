From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] cyclictest: add command line option for unbuffered output
Date: Fri, 25 Dec 2009 13:01:59 +0100
Message-ID: <1261742519-7507-1-git-send-email-w.sang@pengutronix.de>
Cc: Michael Olbrich <m.olbrich@pengutronix.de>,
	Wolfram Sang <w.sang@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZLYMCS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Dec 2009 07:02:18 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Michael Olbrich <m.olbrich@pengutronix.de>

Wenn reading the output from cyclictest with another program, the data is
buffered by default. This prevents nice 'live' display.
This patch adds an command line option to force the output to always be
unbuffered.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 src/cyclictest/cyclictest.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a15cf57..eee7e73 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -772,6 +772,7 @@ static void display_help(int error)
 	       "                           without -t default = 1\n"
 	       "-T TRACE --tracer=TRACER   set tracing function\n"
 	       "    configured tracers: %s\n"
+	       "-u       --unbuffered      force unbuffered output for live processing\n"
 	       "-v       --verbose         output values on stdout for statistics\n"
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
@@ -890,6 +891,7 @@ static void process_options (int argc, char *argv[])
 			{"relative", no_argument, NULL, 'r'},
 			{"system", no_argument, NULL, 's'},
 			{"threads", optional_argument, NULL, 't'},
+			{"unbuffered", no_argument, NULL, 'u'},
 			{"verbose", no_argument, NULL, 'v'},
 			{"duration",required_argument, NULL, 'D'},
                         {"wakeup", no_argument, NULL, 'w'},
@@ -899,7 +901,7 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:i:Il:MnNo:O:p:Pmqrst::vD:wWTy:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:i:Il:MnNo:O:p:Pmqrst::uvD:wWTy:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -948,6 +950,7 @@ static void process_options (int argc, char *argv[])
 				num_threads = max_cpus;
 			break;
 		case 'T': strncpy(tracer, optarg, sizeof(tracer)); break;
+		case 'u': setvbuf(stdout, NULL, _IONBF, 0); break;
 		case 'v': verbose = 1; break;
 		case 'm': lockall = 1; break;
 		case 'M': refresh_on_max = 1; break;
-- 
1.6.5

