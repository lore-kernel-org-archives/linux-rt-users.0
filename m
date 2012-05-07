From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Mon, 7 May 2012 14:42:12 -0700
Message-ID: <4FA841B4.20701@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:23421
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755028Ab2EGVmh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 17:42:37 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


cyclictest option '-e', '--latency' was added out of alphabetic
order and was not added to the help text.  Clean up before
following patch which will add a new option.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |   17 	9 +	8 -	0 !
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -834,6 +834,7 @@ static void display_help(int error)
 	       "-D       --duration=t      specify a length for the test run\n"
 	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
 	       "                           to modify value to minutes, hours or days\n"
+	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
@@ -963,6 +964,7 @@ static void process_options (int argc, c
 			{"clock", required_argument, NULL, 'c'},
 			{"context", no_argument, NULL, 'C'},
 			{"distance", required_argument, NULL, 'd'},
+			{"latency", required_argument, NULL, 'e'},
 			{"event", no_argument, NULL, 'E'},
 			{"ftrace", no_argument, NULL, 'f'},
 			{"histogram", required_argument, NULL, 'h'},
@@ -992,10 +994,9 @@ static void process_options (int argc, c
 			{"traceopt", required_argument, NULL, 'O'},
 			{"smp", no_argument, NULL, 'S'},
 			{"numa", no_argument, NULL, 'U'},
-			{"latency", required_argument, NULL, 'e'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqrsSt::uUvD:wWT:y:e:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:e:Efh:H:i:Il:MnNo:O:p:PmqrsSt::uUvD:wWT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1019,6 +1020,12 @@ static void process_options (int argc, c
 		case 'c': clocksel = atoi(optarg); break;
 		case 'C': tracetype = CTXTSWITCH; break;
 		case 'd': distance = atoi(optarg); break;
+		case 'e': /* power management latency target value */
+			  /* note: default is 0 (zero) */
+			latency_target_value = atoi(optarg);
+			if (latency_target_value < 0)
+				latency_target_value = 0;
+			break;
 		case 'E': enable_events = 1; break;
 		case 'f': tracetype = FUNCTION; ftrace = 1; break;
 		case 'H': histofall = 1; /* fall through */
@@ -1101,12 +1108,6 @@ static void process_options (int argc, c
 			warn("ignoring --numa or -U\n");
 #endif
 			break;
-		case 'e': /* power management latency target value */
-			  /* note: default is 0 (zero) */
-			latency_target_value = atoi(optarg);
-			if (latency_target_value < 0)
-				latency_target_value = 0;
-			break;
 
 		case '?': display_help(0); break;
 		}

