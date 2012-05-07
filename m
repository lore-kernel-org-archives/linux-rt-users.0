From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Mon, 7 May 2012 14:47:31 -0700
Message-ID: <4FA842F3.60204@am.sony.com>
References: <4FA841B4.20701@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:13592
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2EGVr7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 17:47:59 -0400
In-Reply-To: <4FA841B4.20701@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


cyclictest: ARM panda clock resolution will be ~30 usec unless
CONFIG_OMAP_32K_TIMER=n, resulting in a poor latency report.

This patch does _not_ fix the problem, it merely provides the
instrumentation to make it visible.  The value of measured
resolution is useful information for any system.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |   87 	86 +	1 -	0 !
 1 file changed, 86 insertions(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -171,6 +171,7 @@ static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
+static int check_clock_resolution_loops = 0;
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -854,6 +855,9 @@ static void display_help(int error)
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
+	       "-R LOOP  --resolution=LOOP check clock resolution, calling clock_gettime() LOOP\n"
+	       "                           times.  list of clock_gettime() values will be\n"
+	       "                           reported with -v\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
@@ -982,6 +986,7 @@ static void process_options (int argc, c
 			{"preemptoff", no_argument, NULL, 'P'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"relative", no_argument, NULL, 'r'},
+			{"resolution", required_argument, NULL, 'R'},
 			{"system", no_argument, NULL, 's'},
 			{"threads", optional_argument, NULL, 't'},
 			{"unbuffered", no_argument, NULL, 'u'},
@@ -996,7 +1001,7 @@ static void process_options (int argc, c
 			{"numa", no_argument, NULL, 'U'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:e:Efh:H:i:Il:MnNo:O:p:PmqrsSt::uUvD:wWT:y:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:e:Efh:H:i:Il:MnNo:O:p:PmqrR:sSt::uUvD:wWT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1061,6 +1066,14 @@ static void process_options (int argc, c
 			break;
 		case 'q': quiet = 1; break;
 		case 'r': timermode = TIMER_RELTIME; break;
+		case 'R':
+			{
+			char *endptr;
+			check_clock_resolution_loops = strtol(optarg, &endptr, 10);
+			if ((endptr == optarg) || !check_clock_resolution_loops)
+				check_clock_resolution_loops = -1;
+			}
+			break;
 		case 's': use_system = MODE_SYS_OFFSET; break;
 		case 't':
 			if (smp) {
@@ -1132,6 +1145,11 @@ static void process_options (int argc, c
 	} else if (tracelimit)
 		fileprefix = procfileprefix;
 
+	if (check_clock_resolution_loops == -1) {
+		warn("-R requires positive integer value for LOOP\n");
+		error = 1;
+	}
+
 	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
 		error = 1;
 
@@ -1391,6 +1409,73 @@ int main(int argc, char **argv)
 	if (check_timer())
 		warn("High resolution timers not available\n");
 
+	if (check_clock_resolution_loops) {
+		int clock;
+		uint64_t diff;
+		int k;
+		struct timespec *now;
+		struct timespec prev;
+		struct timespec res;
+		int zero_diff = 0;
+		uint64_t min_non_zero_diff = UINT64_MAX;
+		uint64_t reported_resolution = UINT64_MAX;
+
+		now = calloc(check_clock_resolution_loops, sizeof(*now));
+		clock = clocksources[clocksel];
+
+		if (clock_getres(clock, &res)) {
+			warn("clock_getres failed");
+		} else {
+			reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
+		}
+
+		clock_gettime(clock, &prev);
+
+		for (k=0; k < check_clock_resolution_loops; k++) {
+			clock_gettime(clock, &now[k]);
+		}
+
+		if (verbose) {
+			printf("\n\nFor consecutive calls to clock_gettime():\n\n");
+			printf("time, delta time (nsec)\n\n");
+		}
+
+		prev = now[0];
+		for (k=1; k < check_clock_resolution_loops; k++) {
+
+			/* always show delta in ns */
+			diff = calcdiff_ns(now[k], prev);
+
+			if (diff == 0) {
+				zero_diff = 1;
+			} else if (diff < min_non_zero_diff) {
+				min_non_zero_diff = diff;
+			}
+
+			if (verbose) {
+				printf("%ld.%06ld", now[k].tv_sec, now[k].tv_nsec);
+				printf("  %llu\n", diff);
+			}
+
+			prev = now[k];
+		}
+
+		if (verbose ||
+		    (min_non_zero_diff && (min_non_zero_diff > reported_resolution))) {
+		    	/*
+			 * Measured clock resolution includes the time to call
+			 * clock_gettime(), so it will be slightly larger than
+			 * actual resolution.
+			 */
+			fprintf(stderr, "reported clock resolution: %lld nsec\n",
+				reported_resolution);
+			fprintf(stderr, "measured clock resolution less than: %llu nsec\n",
+				min_non_zero_diff);
+		}
+
+		free(now);
+	}
+
 	mode = use_nanosleep + use_system;
 
 	sigemptyset(&sigset);

