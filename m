From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 2/2] V3: cyclictest: report large measured clock latency
Date: Tue, 15 May 2012 16:39:58 -0700
Message-ID: <4FB2E94E.6080008@am.sony.com>
References: <4FB2E868.4070802@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:10380
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967065Ab2EOXkj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 19:40:39 -0400
In-Reply-To: <4FB2E868.4070802@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


V3: Use src/lib/error.c functions instead of fprintf.
    Fix printf format warnings for 32 bit vs 64 bit systems with cast.
    Fix bad continuation line white space prefix.
    Remove unused variable zero_diff.

cyclictest: ARM panda clock resolution will be ~30 usec unless
CONFIG_OMAP_32K_TIMER=n, resulting in a poor latency report.

This patch does _not_ fix the problem, it merely provides the
instrumentation to make it visible.  The value of measured
resolution is useful information for any system.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |  109 	108 +	1 -	0 !
 1 file changed, 108 insertions(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -174,6 +174,8 @@ static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
 static int priospread = 0;
+static int check_clock_resolution;
+static int ct_debug;
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -944,6 +946,9 @@ static void display_help(int error)
 	       "-q       --quiet           print only a summary on exit\n"
 	       "-Q       --priospread       spread priority levels starting at specified value\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
+	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
+	       "                           times.  list of clock_gettime() values will be\n"
+	       "                           reported with -X\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
 	       "                           same priority of all threads\n"
@@ -960,6 +965,7 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
+	       "-X       --dbg_cyclictest  print info useful for debugging cyclictest\n"
 	       "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
 	       "                           format: --policy=fifo(default) or --policy=rr\n",
 	       tracers
@@ -1076,6 +1082,7 @@ static void process_options (int argc, c
 			{"quiet",            no_argument,       NULL, 'q'},
 			{"priospread",       no_argument,       NULL, 'Q'},
 			{"relative",         no_argument,       NULL, 'r'},
+			{"resolution",       no_argument,       NULL, 'R'},
 			{"system",           no_argument,       NULL, 's'},
 			{"smp",              no_argument,       NULL, 'S'},
 			{"threads",          optional_argument, NULL, 't'},
@@ -1085,11 +1092,12 @@ static void process_options (int argc, c
 			{"verbose",          no_argument,       NULL, 'v'},
 			{"wakeup",           no_argument,       NULL, 'w'},
 			{"wakeuprt",         no_argument,       NULL, 'W'},
+			{"dbg_cyclictest",   no_argument,       NULL, 'X'},
 			{"policy",           required_argument, NULL, 'y'},
 			{"help",             no_argument,       NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1158,6 +1166,7 @@ static void process_options (int argc, c
 		case 'q': quiet = 1; break;
 		case 'Q': priospread = 1; break;
 		case 'r': timermode = TIMER_RELTIME; break;
+		case 'R': check_clock_resolution = 1; break;
 		case 's': use_system = MODE_SYS_OFFSET; break;
 		case 'S':  /* SMP testing */
 			if (numa)
@@ -1202,6 +1211,7 @@ static void process_options (int argc, c
 		case 'v': verbose = 1; break;
 		case 'w': tracetype = WAKEUP; break;
 		case 'W': tracetype = WAKEUPRT; break;
+		case 'X': ct_debug = 1; break;
 		case 'y': handlepolicy(optarg); break;
 
 		case '?': display_help(0); break;
@@ -1483,6 +1493,103 @@ int main(int argc, char **argv)
 	if (check_timer())
 		warn("High resolution timers not available\n");
 
+	if (check_clock_resolution) {
+		int clock;
+		uint64_t diff;
+		int k;
+		uint64_t min_non_zero_diff = UINT64_MAX;
+		struct timespec now;
+		struct timespec prev;
+		uint64_t reported_resolution = UINT64_MAX;
+		struct timespec res;
+		struct timespec *time;
+		int times;
+
+		clock = clocksources[clocksel];
+
+		if (clock_getres(clock, &res)) {
+			warn("clock_getres failed");
+		} else {
+			reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
+		}
+
+
+		/*
+		 * Calculate how many calls to clock_gettime are needed.
+		 * Then call it that many times.
+		 * Goal is to collect timestamps for ~ 0.001 sec.
+		 * This will reliably capture resolution <= 500 usec.
+		 */
+		times = 1000;
+		clock_gettime(clock, &prev);
+		for (k=0; k < times; k++) {
+			clock_gettime(clock, &now);
+		}
+
+		diff = calcdiff_ns(now, prev);
+		if (diff == 0) {
+			/*
+			 * No clock rollover occurred.
+			 * Use the default value for times.
+			 */
+			times = -1;
+		} else {
+			int call_time;
+			call_time = diff / times;         /* duration 1 call */
+			times = NSEC_PER_SEC / call_time; /* calls per second */
+			times /= 1000;                    /* calls per msec */
+			if (times < 1000)
+				times = 1000;
+		}
+		/* sanity check */
+		if ((times <= 0) || (times > 100000))
+			times = 100000;
+
+		time = calloc(times, sizeof(*time));
+
+		for (k=0; k < times; k++) {
+			clock_gettime(clock, &time[k]);
+		}
+
+		if (ct_debug) {
+			info("For %d consecutive calls to clock_gettime():\n", times);
+			info("time, delta time (nsec)\n");
+		}
+
+		prev = time[0];
+		for (k=1; k < times; k++) {
+
+			diff = calcdiff_ns(time[k], prev);
+			prev = time[k];
+
+			if (diff && (diff < min_non_zero_diff)) {
+				min_non_zero_diff = diff;
+			}
+
+			if (ct_debug)
+				info("%ld.%06ld  %5llu\n",
+				     time[k].tv_sec, time[k].tv_nsec,
+				     (unsigned long long)diff);
+		}
+
+		free(time);
+
+
+		if (verbose ||
+		    (min_non_zero_diff && (min_non_zero_diff > reported_resolution))) {
+		    	/*
+			 * Measured clock resolution includes the time to call
+			 * clock_gettime(), so it will be slightly larger than
+			 * actual resolution.
+			 */
+			warn("reported clock resolution: %llu nsec\n",
+			     (unsigned long long)reported_resolution);
+			warn("measured clock resolution approximately: %llu nsec\n",
+			     (unsigned long long)min_non_zero_diff);
+		}
+
+	}
+
 	mode = use_nanosleep + use_system;
 
 	sigemptyset(&sigset);

