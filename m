From: Vedang Patel <vedang.patel@intel.com>
Subject: [PATCH] cyclictest: make clock_nanosleep as default and add option for POSIX timers.
Date: Tue, 14 Mar 2017 12:43:48 -0700
Message-ID: <1489520628-9288-1-git-send-email-vedang.patel@intel.com>
References: <alpine.LFD.2.20.1703141646001.10659@riemann.fritz.box>
Cc: linux-rt-users@vger.kernel.org,
        Vedang Patel <vedang.patel@intel.com>
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbdCNTnx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Mar 2017 15:43:53 -0400
In-Reply-To: <alpine.LFD.2.20.1703141646001.10659@riemann.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

it is recommended that clock_nanosleep should be used for real-time
wherever available. So, make sure that cyclictest runs clock_nanosleep
by default. Added an option to run POSIX timers. Removing the '-n'
option because it is redundant now.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 src/cyclictest/cyclictest.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3f1bef1ffca9..cf82f8e1deaa 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1321,7 +1321,6 @@ static void display_help(int error)
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
 	       "			   latency is hit. Userful for low bandwidth.\n"
-	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "	 --notrace	   suppress tracing\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
@@ -1364,7 +1363,8 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n",
+	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
+	       "-x	 --posix_timers    use POSIX timers\n",
 	       tracers
 		);
 	if (error)
@@ -1372,7 +1372,7 @@ static void display_help(int error)
 	exit(EXIT_SUCCESS);
 }
 
-static int use_nanosleep;
+static int use_nanosleep = MODE_CLOCK_NANOSLEEP; /* use clock_nanosleep by default. */
 static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
@@ -1493,6 +1493,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
 	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI, OPT_TRACEMARK,
+	OPT_POSIX_TIMERS,
 };
 
 /* Process commandline options */
@@ -1530,7 +1531,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"loops",            required_argument, NULL, OPT_LOOPS },
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
-			{"nanosleep",        no_argument,       NULL, OPT_NANOSLEEP },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
 			{"oscope",           required_argument, NULL, OPT_OSCOPE },
 			{"traceopt",         required_argument, NULL, OPT_TRACEOPT },
@@ -1557,9 +1557,10 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
+			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
+		int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MNo:O:p:PmqrRsSt::uUvD:wWT:x",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1651,9 +1652,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'M':
 		case OPT_REFRESH:
 			refresh_on_max = 1; break;
-		case 'n':
-		case OPT_NANOSLEEP:
-			use_nanosleep = MODE_CLOCK_NANOSLEEP; break;
 		case 'N':
 		case OPT_NSECS:
 			use_nsecs = 1; break;
@@ -1760,6 +1758,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
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

