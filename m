From: Vedang Patel <vedang.patel@intel.com>
Subject: [PATCH] cyclictest: make clock_nanosleep as default and add option for POSIX timers.
Date: Mon, 13 Mar 2017 10:58:57 -0700
Message-ID: <1489427937-12583-1-git-send-email-vedang.patel@intel.com>
Cc: linux-rt-users@vger.kernel.org,
        Vedang Patel <vedang.patel@intel.com>
To: williams@redhat.com, jkacur@redhar.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64210 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbdCMR7H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Mar 2017 13:59:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

it is recommended that clock_nanosleep should be used for real-time
wherever available. So, make sure that cyclictest runs clock_nanosleep
by default. Added an option to run POSIX timers. The '-n' option is
redundant now. I did not remove it so that it does not break existing
scripts.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 src/cyclictest/cyclictest.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 00e5f3d59a5b..a185a8a99065 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1360,7 +1360,8 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n",
+	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
+	       "-x	 --posix_timers    use POSIX timers\n",
 	       tracers
 		);
 	if (error)
@@ -1368,7 +1369,7 @@ static void display_help(int error)
 	exit(EXIT_SUCCESS);
 }
 
-static int use_nanosleep;
+static int use_nanosleep = MODE_CLOCK_NANOSLEEP; /* use clock_nanosleep by default. */
 static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
@@ -1489,6 +1490,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
 	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI, OPT_TRACEMARK,
+	OPT_POSIX_TIMERS,
 };
 
 /* Process commandline options */
@@ -1553,9 +1555,10 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
+			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
+		int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:x",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1756,6 +1759,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'W':
 		case OPT_WAKEUPRT:
 			tracetype = WAKEUPRT; break;
+		case 'x':
+		case OPT_POSIX_TIMERS:
+			use_nanosleep = MODE_CYCLIC; break;
 		case '?':
 		case OPT_HELP:
 			display_help(0); break;
-- 
2.7.3

