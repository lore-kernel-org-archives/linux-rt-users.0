From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 1/2] V2: cyclictest: clean up getopt_long() parameters
Date: Thu, 10 May 2012 17:59:40 -0700
Message-ID: <4FAC647C.4090609@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <dvhart@linux.intel.com>, <lclaudio@uudg.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:52933
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab2EKBA0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 21:00:26 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


cyclictest getopt_long() parameter clean up.
Clean up before following patch which will add a new option.

  Some elements of long_options were not in alphabetical order.

  Some elements of optstring were not in alphabetical order.

  '-e', '--latency' was missing help text

  short form of --duration ('D') was missing from optstring

  Change a few instances of leading spaces to tabs.

  Add white space to long_options to improve readability.

  Some cases of the switch processing the result of
    getopt_long() were not in alphabetical order.

  Did _not_ clean up option value parsing and processing.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |  143 	73 +	70 -	0 !
 1 file changed, 73 insertions(+), 70 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -923,10 +923,11 @@ static void display_help(int error)
 	       "-D       --duration=t      specify a length for the test run\n"
 	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
 	       "                           to modify value to minutes, hours or days\n"
+	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
-               "                           (with same priority about many threads)\n"
+	       "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
 	       "-H       --histofall=US    same as -h except with an additional summary column\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
@@ -944,6 +945,8 @@ static void display_help(int error)
 	       "-Q       --priospread       spread priority levels starting at specified value\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
+	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
+	       "                           same priority of all threads\n"
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
@@ -951,16 +954,14 @@ static void display_help(int error)
 	       "-T TRACE --tracer=TRACER   set tracing function\n"
 	       "    configured tracers: %s\n"
 	       "-u       --unbuffered      force unbuffered output for live processing\n"
+	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
+	       "                           thread data structures allocated from local node\n"
 	       "-v       --verbose         output values on stdout for statistics\n"
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
-               "-w       --wakeup          task wakeup tracing (used with -b)\n"
-               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-               "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
-               "                           format: --policy=fifo(default) or --policy=rr\n"
-	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
-               "                           same priority of all threads\n"
-	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
-               "                           thread data structures allocated from local node\n",
+	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
+	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
+	       "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
+	       "                           format: --policy=fifo(default) or --policy=rr\n",
 	       tracers
 		);
 	if (error)
@@ -1044,48 +1045,51 @@ static void process_options (int argc, c
 
 	for (;;) {
  		int option_index = 0;
-		/** Options for getopt */
+		/*
+		 * Options for getopt
+		 * Ordered alphabetically by single letter name
+		 */
 		static struct option long_options[] = {
-			{"affinity", optional_argument, NULL, 'a'},
-			{"breaktrace", required_argument, NULL, 'b'},
-			{"preemptirqs", no_argument, NULL, 'B'},
-			{"clock", required_argument, NULL, 'c'},
-			{"context", no_argument, NULL, 'C'},
-			{"distance", required_argument, NULL, 'd'},
-			{"event", no_argument, NULL, 'E'},
-			{"ftrace", no_argument, NULL, 'f'},
-			{"histogram", required_argument, NULL, 'h'},
-			{"histofall", required_argument, NULL, 'H'},
-			{"interval", required_argument, NULL, 'i'},
-			{"irqsoff", no_argument, NULL, 'I'},
-			{"loops", required_argument, NULL, 'l'},
-			{"mlockall", no_argument, NULL, 'm' },
-			{"refresh_on_max", no_argument, NULL, 'M' },
-			{"nanosleep", no_argument, NULL, 'n'},
-			{"nsecs", no_argument, NULL, 'N'},
-			{"oscope", required_argument, NULL, 'o'},
-			{"priority", required_argument, NULL, 'p'},
-                        {"policy", required_argument, NULL, 'y'},
-			{"preemptoff", no_argument, NULL, 'P'},
-			{"quiet", no_argument, NULL, 'q'},
-			{"relative", no_argument, NULL, 'r'},
-			{"system", no_argument, NULL, 's'},
-			{"threads", optional_argument, NULL, 't'},
-			{"unbuffered", no_argument, NULL, 'u'},
-			{"verbose", no_argument, NULL, 'v'},
-			{"duration",required_argument, NULL, 'D'},
-                        {"wakeup", no_argument, NULL, 'w'},
-                        {"wakeuprt", no_argument, NULL, 'W'},
-			{"help", no_argument, NULL, '?'},
-			{"tracer", required_argument, NULL, 'T'},
-			{"traceopt", required_argument, NULL, 'O'},
-			{"smp", no_argument, NULL, 'S'},
-			{"numa", no_argument, NULL, 'U'},
-			{"latency", required_argument, NULL, 'e'},
-			{"priospread", no_argument, NULL, 'Q'},
+			{"affinity",         optional_argument, NULL, 'a'},
+			{"breaktrace",       required_argument, NULL, 'b'},
+			{"preemptirqs",      no_argument,       NULL, 'B'},
+			{"clock",            required_argument, NULL, 'c'},
+			{"context",          no_argument,       NULL, 'C'},
+			{"distance",         required_argument, NULL, 'd'},
+			{"duration",         required_argument, NULL, 'D'},
+			{"latency",          required_argument, NULL, 'e'},
+			{"event",            no_argument,       NULL, 'E'},
+			{"ftrace",           no_argument,       NULL, 'f'},
+			{"histogram",        required_argument, NULL, 'h'},
+			{"histofall",        required_argument, NULL, 'H'},
+			{"interval",         required_argument, NULL, 'i'},
+			{"irqsoff",          no_argument,       NULL, 'I'},
+			{"loops",            required_argument, NULL, 'l'},
+			{"mlockall",         no_argument,       NULL, 'm'},
+			{"refresh_on_max",   no_argument,       NULL, 'M'},
+			{"nanosleep",        no_argument,       NULL, 'n'},
+			{"nsecs",            no_argument,       NULL, 'N'},
+			{"oscope",           required_argument, NULL, 'o'},
+			{"traceopt",         required_argument, NULL, 'O'},
+			{"priority",         required_argument, NULL, 'p'},
+			{"preemptoff",       no_argument,       NULL, 'P'},
+			{"quiet",            no_argument,       NULL, 'q'},
+			{"priospread",       no_argument,       NULL, 'Q'},
+			{"relative",         no_argument,       NULL, 'r'},
+			{"system",           no_argument,       NULL, 's'},
+			{"smp",              no_argument,       NULL, 'S'},
+			{"threads",          optional_argument, NULL, 't'},
+			{"tracer",           required_argument, NULL, 'T'},
+			{"unbuffered",       no_argument,       NULL, 'u'},
+			{"numa",             no_argument,       NULL, 'U'},
+			{"verbose",          no_argument,       NULL, 'v'},
+			{"wakeup",           no_argument,       NULL, 'w'},
+			{"wakeuprt",         no_argument,       NULL, 'W'},
+			{"policy",           required_argument, NULL, 'y'},
+			{"help",             no_argument,       NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1109,6 +1113,13 @@ static void process_options (int argc, c
 		case 'c': clocksel = atoi(optarg); break;
 		case 'C': tracetype = CTXTSWITCH; break;
 		case 'd': distance = atoi(optarg); break;
+		case 'D': duration = parse_time_string(optarg); break;
+		case 'e': /* power management latency target value */
+			  /* note: default is 0 (zero) */
+			latency_target_value = atoi(optarg);
+			if (latency_target_value < 0)
+				latency_target_value = 0;
+			break;
 		case 'E': enable_events = 1; break;
 		case 'f': tracetype = FUNCTION; ftrace = 1; break;
 		case 'H': histofall = 1; /* fall through */
@@ -1124,6 +1135,8 @@ static void process_options (int argc, c
 			}
 			break;
 		case 'l': max_cycles = atoi(optarg); break;
+		case 'm': lockall = 1; break;
+		case 'M': refresh_on_max = 1; break;
 		case 'n': use_nanosleep = MODE_CLOCK_NANOSLEEP; break;
 		case 'N': use_nsecs = 1; break;
 		case 'o': oscope_reduction = atoi(optarg); break;
@@ -1146,6 +1159,14 @@ static void process_options (int argc, c
 		case 'Q': priospread = 1; break;
 		case 'r': timermode = TIMER_RELTIME; break;
 		case 's': use_system = MODE_SYS_OFFSET; break;
+		case 'S':  /* SMP testing */
+			if (numa)
+				fatal("numa and smp options are mutually exclusive\n");
+			smp = 1;
+			num_threads = max_cpus;
+			setaffinity = AFFINITY_USEALL;
+			use_nanosleep = MODE_CLOCK_NANOSLEEP;
+			break;
 		case 't':
 			if (smp) {
 				warn("-t ignored due to --smp\n");
@@ -1163,22 +1184,6 @@ static void process_options (int argc, c
 			strncpy(tracer, optarg, sizeof(tracer)); 
 			break;
 		case 'u': setvbuf(stdout, NULL, _IONBF, 0); break;
-		case 'v': verbose = 1; break;
-		case 'm': lockall = 1; break;
-		case 'M': refresh_on_max = 1; break;
-		case 'D': duration = parse_time_string(optarg);
-			break;
-                case 'w': tracetype = WAKEUP; break;
-                case 'W': tracetype = WAKEUPRT; break;
-                case 'y': handlepolicy(optarg); break;
-		case 'S':  /* SMP testing */
-			if (numa)
-				fatal("numa and smp options are mutually exclusive\n");
-			smp = 1;
-			num_threads = max_cpus;
-			setaffinity = AFFINITY_USEALL;
-			use_nanosleep = MODE_CLOCK_NANOSLEEP;
-			break;
 		case 'U':  /* NUMA testing */
 			if (smp)
 				fatal("numa and smp options are mutually exclusive\n");
@@ -1194,12 +1199,10 @@ static void process_options (int argc, c
 			warn("ignoring --numa or -U\n");
 #endif
 			break;
-		case 'e': /* power management latency target value */
-			  /* note: default is 0 (zero) */
-			latency_target_value = atoi(optarg);
-			if (latency_target_value < 0)
-				latency_target_value = 0;
-			break;
+		case 'v': verbose = 1; break;
+		case 'w': tracetype = WAKEUP; break;
+		case 'W': tracetype = WAKEUPRT; break;
+		case 'y': handlepolicy(optarg); break;
 
 		case '?': display_help(0); break;
 		}

