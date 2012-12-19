From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH 1/3] cyclictest: new command line switch for histogram overflow instance tracking
Date: Wed, 19 Dec 2012 12:00:31 -0800
Message-ID: <1355947233-31451-2-git-send-email-bhavesh@vmware.com>
References: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Cc: frank.rowand@am.sony.com, jkacur@redhat.com,
	Bhavesh Davda <bhavesh@vmware.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:49506 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab2LSUA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 15:00:56 -0500
In-Reply-To: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a new command line option '-g' (long option '--of_max') to cap how many
outliers are tracked per thread.

$ sudo ./cyclictest -p 99 -m -n -a -h 5 -g 50 -t4 -D 30
  /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.14 0.15 0.09 1/396 11018

T: 0 (10978) P:99 I:1000 C:  29997 Min:      2 Act:    4 Avg:    3 Max:       7
T: 1 (10979) P:99 I:1000 C:  29995 Min:      2 Act:    4 Avg:    3 Max:      54
T: 2 (10980) P:99 I:1000 C:  29993 Min:      2 Act:    3 Avg:    3 Max:      10
T: 3 (10981) P:99 I:1000 C:  29991 Min:      2 Act:    3 Avg:    3 Max:       8
  Histogram
000000 000000	000000	000000	000000
000001 000000	000000	000000	000000
000002 000050	000031	000009	000037
000003 015205	016327	014673	018062
000004 014619	010466	012414	011863
  Total: 000029874 000026824 000027096 000029962
  Min Latencies: 00002 00002 00002 00002
  Avg Latencies: 00003 00003 00003 00003
  Max Latencies: 00007 00054 00010 00008
  Histogram Overflows: 00126 03174 02900 00032
  Histogram Overflow at time (ms):
  Thread 0: 1152 1653 3027 3152 3650 5152 5653 7027 7037 7047 7058 7068 7078 7088 7098 7108 7118 7128 7138 7148 7152 7158 7169 7179 7189 7199 7209 7219 7229 7239 7249 7259 7269 7279 7290 7300 7310 7320 7330 7340 7350 7360 7370 7380 7390 7401 7403 7404 7411 7412 # 76 others
  Thread 1: 0 1 2 4 14 24 34 45 55 56 65 75 85 95 105 115 125 126 135 145 153 155 166 176 186 196 206 216 226 236 246 256 266 277 287 297 307 317 327 337 347 357 367 377 388 398 408 418 428 438 # 3124 others
  Thread 2: 0 1 2 12 22 32 42 52 62 72 82 92 102 113 123 133 143 153 173 183 193 203 224 234 244 254 264 284 294 304 314 324 334 345 355 365 375 395 405 415 425 435 445 456 466 476 486 496 516 526 # 2850 others
  Thread 3: 0 1137 1149 3137 5137 7137 7405 8395 8396 8397 9137 11137 12643 12644 13137 15137 17137 17406 18395 18396 19137 21137 21227 21228 21229 23137 25137 27137 27406 28395 28396 29137

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index abf3e8b..141e79f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -91,6 +91,7 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 #define NSEC_PER_SEC		1000000000
 
 #define HIST_MAX		1000000
+#define OF_MAX                  1000000
 
 #define MODE_CYCLIC		0
 #define MODE_CLOCK_NANOSLEEP	1
@@ -171,6 +172,7 @@ static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int histofall = 0;
+static int of_max = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
@@ -887,7 +889,7 @@ void *timerthread(void *param)
 		if (histogram) {
 			if (diff >= histogram) {
 				stat->hist_overflow++;
-                                if (stat->num_outliers < histogram)
+				if (stat->num_outliers < of_max)
 					stat->outliers[stat->num_outliers++] = stat->cycles;
 			}
 			else
@@ -964,6 +966,7 @@ static void display_help(int error)
 	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-g MAX   --of_max=MAX      Report time in ms (up to MAX) for histogram overflows\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
 	       "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
@@ -1102,6 +1105,7 @@ static void process_options (int argc, char *argv[])
 			{"latency",          required_argument, NULL, 'e'},
 			{"event",            no_argument,       NULL, 'E'},
 			{"ftrace",           no_argument,       NULL, 'f'},
+			{"of_max",           required_argument, NULL, 'g'},
 			{"histogram",        required_argument, NULL, 'h'},
 			{"histofall",        required_argument, NULL, 'H'},
 			{"interval",         required_argument, NULL, 'i'},
@@ -1133,7 +1137,7 @@ static void process_options (int argc, char *argv[])
 			{"help",             no_argument,       NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efg:h:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1166,6 +1170,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'E': enable_events = 1; break;
 		case 'f': tracetype = FUNCTION; ftrace = 1; break;
+		case 'g': of_max = atoi(optarg); break;
 		case 'H': histofall = 1; /* fall through */
 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
@@ -1290,6 +1295,12 @@ static void process_options (int argc, char *argv[])
 	if (histogram > HIST_MAX)
 		histogram = HIST_MAX;
 
+	if (of_max < 0)
+		error = 1;
+
+	if (of_max > OF_MAX)
+		of_max = OF_MAX;
+
 	if (histogram && distance != -1)
 		warn("distance is ignored and set to 0, if histogram enabled\n");
 	if (distance == -1)
@@ -1451,16 +1462,15 @@ static void print_hist(struct thread_param *par[], int nthreads)
 		printf(" %05lu", alloverflows);
 	printf("\n");
 
-	printf("# Histogram Overflow at cycle number:\n");
+	printf("# Histogram Overflow at time (ms):\n");
 	for (i = 0; i < nthreads; i++) {
 		printf("# Thread %d:", i);
 		for (j = 0; j < par[i]->stats->num_outliers; j++)
-			printf(" %05lu", par[i]->stats->outliers[j]);
+			printf(" %lu", par[i]->stats->outliers[j] * par[i]->interval / 1000);
 		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
-			printf(" # %05lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
+			printf(" # %lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
 		printf("\n");
 	}
-	printf("\n");
 }
 
 static void print_stat(struct thread_param *par, int index, int verbose)
@@ -1706,11 +1716,17 @@ int main(int argc, char **argv)
 			int bufsize = histogram * sizeof(long);
 
 			stat->hist_array = threadalloc(bufsize, node);
-			stat->outliers = threadalloc(bufsize, node);
-			if (stat->hist_array == NULL || stat->outliers == NULL)
+			if (stat->hist_array == NULL)
 				fatal("failed to allocate histogram of size %d on node %d\n",
 				      histogram, i);
 			memset(stat->hist_array, 0, bufsize);
+		}
+		if (of_max) {
+			int bufsize = of_max * sizeof(long);
+			stat->outliers = threadalloc(bufsize, node);
+			if (stat->outliers == NULL)
+				fatal("failed to allocate outliers of size %d on node %d\n",
+				      histogram, i);
 			memset(stat->outliers, 0, bufsize);
 		}
 
@@ -1829,7 +1845,7 @@ int main(int argc, char **argv)
 		print_hist(parameters, num_threads);
 		for (i = 0; i < num_threads; i++) {
 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+			threadfree(statistics[i]->outliers, of_max*sizeof(long), parameters[i]->node);
 		}
 	}
 
-- 
1.7.4.1

