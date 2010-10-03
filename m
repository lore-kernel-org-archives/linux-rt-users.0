From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] cyclictest-histogram-add-summary-column.patch
Date: Sun, 03 Oct 2010 15:56:52 +0200
Message-ID: <20101003140056.525580592@osadl.org>
References: <20101003135651.176127086@osadl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60629 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab0JCOgk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Oct 2010 10:36:40 -0400
Content-Disposition: inline; filename=cyclictest-histogram-add-summary-column.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To compare histograms of several SMP machines or to gain an
overview when cyclictest is running more than a single thread,
an overall histogram is required that contains a summary of
the individual thread latencies.

This patch adds this functionality and introduces the new
option -H/--histofall for this purpose.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 src/cyclictest/cyclictest.8 |    3 ++
 src/cyclictest/cyclictest.c |   50 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 8 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.8
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.8
+++ rt-tests/src/cyclictest/cyclictest.8
@@ -93,6 +93,9 @@ Enable function tracing using ftrace as 
 .B \-h, \-\-histogram=MAXLATENCYINUS
 Dump latency histogram to stdout. US means the max time to be be tracked in microseconds. When you use \-h option to get histogram data, Cyclictest runs many threads with same priority without priority\-\-.
 .TP
+.B \-H, \-\-histofall=MAXLATENCYINUS
+Same as -h except that an additional histogram column is displayed at the right that contains summary data of all thread histograms. If cyclictest runs a single thread only, the -H option is equivalent to -h.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
 .TP
Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -36,6 +36,9 @@
 
 #include "rt-utils.h"
 
+#define DEFAULT_INTERVAL 1000
+#define DEFAULT_DISTANCE 500
+
 #ifndef SCHED_IDLE
 #define SCHED_IDLE 5
 #endif
@@ -155,6 +158,7 @@ static int oscope_reduction = 1;
 static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
+static int histofall = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
@@ -782,6 +786,7 @@ static void display_help(int error)
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
                "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
+	       "-H       --histofall=US    same as -h except with an additional summary column\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
@@ -829,8 +834,8 @@ static int num_threads = 1;
 static int max_cycles;
 static int clocksel = 0;
 static int quiet;
-static int interval = 1000;
-static int distance = 500;
+static int interval = DEFAULT_INTERVAL;
+static int distance = -1;
 static int affinity = 0;
 static int smp = 0;
 
@@ -906,6 +911,7 @@ static void process_options (int argc, c
 			{"event", no_argument, NULL, 'E'},
 			{"ftrace", no_argument, NULL, 'f'},
 			{"histogram", required_argument, NULL, 'h'},
+			{"histofall", required_argument, NULL, 'H'},
 			{"interval", required_argument, NULL, 'i'},
 			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
@@ -933,7 +939,7 @@ static void process_options (int argc, c
 			{"numa", no_argument, NULL, 'U'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:i:Il:MnNo:O:p:PmqrsSt::uUvD:wWT:y:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqrsSt::uUvD:wWT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -960,6 +966,7 @@ static void process_options (int argc, c
 		case 'd': distance = atoi(optarg); break;
 		case 'E': tracetype = EVENTS; break;
 		case 'f': ftrace = 1; break;
+		case 'H': histofall = 1; /* fall through */
 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'I': tracetype = IRQSOFF; break;
@@ -1055,6 +1062,11 @@ static void process_options (int argc, c
 	if (histogram > HIST_MAX)
 		histogram = HIST_MAX;
 
+	if (histogram && distance != -1)
+		warn("distance is ignored and set to 0, if histogram enabled\n");
+	if (distance == -1)
+		distance = DEFAULT_DISTANCE;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
@@ -1140,33 +1152,55 @@ static void print_tids(struct thread_par
 static void print_hist(struct thread_param *par[], int nthreads)
 {
 	int i, j;
-	uint64_t log_entries[nthreads];
+	long long unsigned int log_entries[nthreads+1];
+	unsigned long maxmax, alloverflows;
 
 	bzero(log_entries, sizeof(log_entries));
 
 	printf("# Histogram\n");
 	for (i = 0; i < histogram; i++) {
+		long long unsigned int allthreads = 0;
 
 		printf("%06d ", i);
 
 		for (j = 0; j < nthreads; j++) {
 			unsigned long curr_latency=par[j]->stats->hist_array[i];
-			printf("%06lu\t", curr_latency);
+			printf("%06lu", curr_latency);
+			if (j < nthreads - 1)
+				printf("\t");
 			log_entries[j] += curr_latency;
+			allthreads += curr_latency;
+		}
+		if (histofall && nthreads > 1) {
+			printf("\t%06llu", allthreads);
+			log_entries[nthreads] += allthreads;
 		}
 		printf("\n");
 	}
 	printf("# Total:");
 	for (j = 0; j < nthreads; j++)
 		printf(" %09llu", log_entries[j]);
+	if (histofall && nthreads > 1)
+		printf(" %09llu", log_entries[nthreads]);
 	printf("\n");
-	printf("# Max Latencys:");
-	for (j = 0; j < nthreads; j++)
+	printf("# Max Latencies:");
+	maxmax = 0;
+	for (j = 0; j < nthreads; j++) {
 		printf(" %05lu", par[j]->stats->max);
+		if (par[j]->stats->max > maxmax)
+			maxmax = par[j]->stats->max;
+	}
+	if (histofall && nthreads > 1)
+		printf(" %05lu", maxmax);
 	printf("\n");
 	printf("# Histogram Overflows:");
-	for (j = 0; j < nthreads; j++)
+	alloverflows = 0;
+	for (j = 0; j < nthreads; j++) {
 		printf(" %05lu", par[j]->stats->hist_overflow);
+		alloverflows += par[j]->stats->hist_overflow;
+	}
+	if (histofall && nthreads > 1)
+		printf(" %05lu", alloverflows);
 	printf("\n");
 }
 

