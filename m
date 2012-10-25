From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Thu, 25 Oct 2012 14:36:26 -0700
Message-ID: <5089B0DA.2010909@am.sony.com>
References: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:44192 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968Ab2JYVgg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2012 17:36:36 -0400
In-Reply-To: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/16/12 10:02, Bhavesh Davda wrote:
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Add feature to cyclictest histogram mode to track cycle counts every time a
> sample overflows the histogram limit. This should help identify if there is a
> timing pattern to jitters in cyclictest runs.
> 
> Example output (with -h 10):
>  ...
>  Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000 00001
>  Histogram Overflow at cycle number:
>  Thread 0: 09964
>  Thread 1: 00000 00004 00006 00008 00010 09962 11594
>  Thread 2:
>  Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
>  Thread 4: 11574 11580 11583 11586
>  Thread 5: 00020 09448 13954 14954 18954 20587 24973
>  Thread 6:
>  Thread 7: 18950
>  ...
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>

My comments up to "--" are not meant to be part of the header of the
following patch.

I am including the following patch as my review of the patch I am
replying to.  If the following patch is incorporated into the
reviewed patch, then you can add my:

  Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
  Tested-by: Frank Rowand <frank.rowand@am.sony.com>

to the combined patch.

The following patch fails checkpatch:

  total: 2 errors, 11 warnings, 148 lines checked

but the warnings and errors seem consistent with existing cyclictest
practice.

I did not fix any of the white space issues in the reviewed patch.
There are already some existing white space issues in cyclictest,
so after all these patches are applied I can submit a small patch
to finish cleaning up leading and trailing white space issues.

The single letter command line flags that seemed most intuitive
for the overflow cycle report are already taken.  I chose "g"
simply because it was adjacent to "h" in the -help report and
it is related to the histogram feature.  I chose "of_cycle"
as the long option name because a longer, more descriptive
name would change the formatting of the -help report.  Feel
free to bike shed and change to another name.

I picked an arbitrary value for OVERFLOW_CYCLE_MAX.  Feel free
to pick another value if needed.

--


Changed size of stats->outliers[] from histogram to hist_overflow.
histogram is the number of histogram buckets, which is not related
to the time dimension, which is the purpose of the histogram
overflow cycle report.

Added command line option to set the value of hist_overflow.  This
has the additional side effect of controlling whether the histogram
overflow cycle report is printed.

Add a line to the histogram overflow cycle report that merges all
threads into a single time line.  This is controlled by the -H
option which already serves a similar purpose for histograms.

Removed leading zeros from cycle values reported in the histogram
overflow cycle report to make the values more readable.

Removed extra blank line printed at end of Histogram output.



$ cyclictest -h 10 -a -t 8 -l 5000 -g 15
# /dev/cpu_dma_latency set to 0us
policy: other/other: loadavg: 0.03 0.02 0.00 1/374 29840          

T: 0 (29833) P: 0 I:1000 C:   5000 Min:      5 Act:    7 Avg:    6 Max:      45
T: 1 (29834) P: 0 I:1000 C:   5000 Min:      5 Act:    6 Avg:    6 Max:     121
T: 2 (29835) P: 0 I:1000 C:   5000 Min:      6 Act:    7 Avg:    8 Max:      13
T: 3 (29836) P: 0 I:1000 C:   5000 Min:      5 Act:    7 Avg:    6 Max:      89
T: 4 (29837) P: 0 I:1000 C:   5000 Min:      5 Act:    9 Avg:    6 Max:       9
T: 5 (29838) P: 0 I:1000 C:   5000 Min:      6 Act:    9 Avg:    6 Max:      23
T: 6 (29839) P: 0 I:1000 C:   5000 Min:      5 Act:    7 Avg:    6 Max:      81
T: 7 (29840) P: 0 I:1000 C:   5000 Min:      5 Act:    9 Avg:    6 Max:       9
# Histogram
000000 000000	000000	000000	000000	000000	000000	000000	000000
000001 000000	000000	000000	000000	000000	000000	000000	000000
000002 000000	000000	000000	000000	000000	000000	000000	000000
000003 000000	000000	000000	000000	000000	000000	000000	000000
000004 000000	000000	000000	000000	000000	000000	000000	000000
000005 001741	001034	000000	000012	000005	000000	000014	000002
000006 000587	001455	000053	000928	003540	000286	003018	002194
000007 002658	002410	000444	004045	001423	004705	001413	002799
000008 000006	000093	003353	000001	000030	000002	000527	000003
000009 000001	000005	000499	000011	000002	000006	000018	000002
# Total: 000004993 000004997 000004349 000004997 000005000 000004999 000004990 000005000
# Min Latencies: 00005 00005 00006 00005 00005 00006 00005 00005
# Avg Latencies: 00006 00006 00008 00006 00006 00006 00006 00006
# Max Latencies: 00045 00121 00013 00089 00009 00023 00081 00009
# Histogram Overflows: 00007 00003 00651 00003 00000 00001 00010 00000
# Histogram Overflow at cycle number:
# Thread 0:   161  2163  3014  3159  4015  4162  4924
# Thread 1:  3649  3940  4940
# Thread 2:     0     1    10    20    31    41    51    61    71    81    91    92   101   102   111 #   636 others
# Thread 3:     0   940  1161
# Thread 4:
# Thread 5:   824
# Thread 6:    70   212   283   415   486  1724  2201  2690  4170  4640
# Thread 7:


$ cyclictest -H 10 -a -t 8 -l 5000 -g 15
# /dev/cpu_dma_latency set to 0us
policy: other/other: loadavg: 0.05 0.02 0.00 1/374 29831          

T: 0 (29824) P: 0 I:1000 C:   5000 Min:      2 Act:    6 Avg:    5 Max:      51
T: 1 (29825) P: 0 I:1000 C:   5000 Min:      3 Act:    7 Avg:    7 Max:      74
T: 2 (29826) P: 0 I:1000 C:   5000 Min:      3 Act:    7 Avg:    7 Max:      29
T: 3 (29827) P: 0 I:1000 C:   5000 Min:      3 Act:    7 Avg:    7 Max:      91
T: 4 (29828) P: 0 I:1000 C:   5000 Min:      2 Act:    9 Avg:    6 Max:      25
T: 5 (29829) P: 0 I:1000 C:   5000 Min:      3 Act:   10 Avg:    6 Max:      44
T: 6 (29830) P: 0 I:1000 C:   5000 Min:      3 Act:    9 Avg:    7 Max:      22
T: 7 (29831) P: 0 I:1000 C:   5000 Min:      2 Act:    8 Avg:    6 Max:     156
# Histogram
000000 000000	000000	000000	000000	000000	000000	000000	000000	000000
000001 000000	000000	000000	000000	000000	000000	000000	000000	000000
000002 000002	000000	000000	000000	000003	000000	000000	000003	000008
000003 000001	000003	000002	000003	000001	000003	000003	000001	000017
000004 000001	000000	000001	000000	000000	000001	000001	000000	000004
000005 003537	000003	000034	000001	000004	000000	000000	001141	004720
000006 000834	000282	000540	000029	002797	000347	000201	002889	007919
000007 000610	004184	003629	004423	002160	004630	004019	000952	024607
000008 000005	000482	000228	000128	000031	000012	000721	000010	001617
000009 000001	000041	000068	000409	000003	000001	000051	000002	000576
# Total: 000004991 000004995 000004502 000004993 000004999 000004994 000004996 000004998 000039468
# Min Latencies: 00002 00003 00003 00003 00002 00003 00003 00002
# Avg Latencies: 00005 00007 00007 00007 00006 00006 00007 00006
# Max Latencies: 00051 00074 00029 00091 00025 00044 00022 00156 00156
# Histogram Overflows: 00009 00005 00498 00007 00001 00006 00004 00002 00532
# Histogram Overflow at cycle number:
# Thread all:     4    10    20    31    41    50    61    71    81    91   102   112   122   132   142   354   502   536  1172  1315  1355  1535  2029  2114  2318  2356  2537  2971  3276  3357  3541  3542  3997  4264  4358  4535  4537  4544  4551  4782  4999
# Thread 0:   354   536  1355  2356  2537  3357  4358  4537  4551
# Thread 1:     4  3276  3542  3997  4535
# Thread 2:     4    10    20    31    41    50    61    71    81    91   102   112   122   132   142 #   483 others
# Thread 3:     4  1315  1535  2114  4264  4535  4782
# Thread 4:   502
# Thread 5:     4  1172  3541  3997  4544  4999
# Thread 6:     4  2029  2971  4544
# Thread 7:  1535  2318



Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |   75 	61 +	14 -	0 !
 1 file changed, 61 insertions(+), 14 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -91,6 +91,7 @@ extern int clock_nanosleep(clockid_t __c
 #define NSEC_PER_SEC		1000000000
 
 #define HIST_MAX		1000000
+#define OVERFLOW_CYCLE_MAX	1000000
 
 #define MODE_CYCLIC		0
 #define MODE_CLOCK_NANOSLEEP	1
@@ -171,6 +172,7 @@ static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int histofall = 0;
+static int overflow_cycle = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
@@ -854,7 +856,7 @@ void *timerthread(void *param)
 		if (histogram) {
 			if (diff >= histogram) {
 				stat->hist_overflow++;
-                                if (stat->num_outliers < histogram)
+				if (stat->num_outliers < overflow_cycle)
 					stat->outliers[stat->num_outliers++] = stat->cycles;
 			}
 			else
@@ -930,6 +932,7 @@ static void display_help(int error)
 	       "                           to modify value to minutes, hours or days\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-g MAX   --of_cycle=MAX    Report the cycle of up to MAX histogram overflows\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
                "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
@@ -1059,6 +1062,7 @@ static void process_options (int argc, c
 			{"distance", required_argument, NULL, 'd'},
 			{"event", no_argument, NULL, 'E'},
 			{"ftrace", no_argument, NULL, 'f'},
+			{"overflow_cycle", required_argument, NULL, 'g'},
 			{"histogram", required_argument, NULL, 'h'},
 			{"histofall", required_argument, NULL, 'H'},
 			{"interval", required_argument, NULL, 'i'},
@@ -1090,7 +1094,7 @@ static void process_options (int argc, c
 			{"priospread", no_argument, NULL, 'Q'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efg:h:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1116,6 +1120,7 @@ static void process_options (int argc, c
 		case 'd': distance = atoi(optarg); break;
 		case 'E': enable_events = 1; break;
 		case 'f': tracetype = FUNCTION; ftrace = 1; break;
+		case 'g': overflow_cycle = atoi(optarg); break;
 		case 'H': histofall = 1; /* fall through */
 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
@@ -1240,6 +1245,12 @@ static void process_options (int argc, c
 		error = 1;
 	}
 
+	if (overflow_cycle < 0)
+		error = 1;
+
+	if (overflow_cycle > OVERFLOW_CYCLE_MAX)
+		overflow_cycle = OVERFLOW_CYCLE_MAX;
+
 	if (histogram < 0)
 		error = 1;
 
@@ -1407,16 +1418,51 @@ static void print_hist(struct thread_par
 		printf(" %05lu", alloverflows);
 	printf("\n");
 
-	printf("# Histogram Overflow at cycle number:\n");
-	for (i = 0; i < nthreads; i++) {
-		printf("# Thread %d:", i);
-		for (j = 0; j < par[i]->stats->num_outliers; j++)
-			printf(" %05lu", par[i]->stats->outliers[j]);
-		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
-			printf(" # %05lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
-		printf("\n");
+	if (overflow_cycle) {
+		printf("# Histogram Overflow at cycle number:\n");
+		if (histofall && nthreads > 1) {
+			long prev_time = -1;
+			int t_next[nthreads];
+			int thread;
+			long time;
+
+			memset(t_next, 0, sizeof(t_next));
+			printf("# Thread all:");
+			do {
+				thread = -1;
+				time = -1;
+				for (i = 0; i < nthreads; i++) {
+					/* do not report the same cycle multiple times */
+					if ((t_next[i] < par[i]->stats->num_outliers) &&
+					    (par[i]->stats->outliers[t_next[i]] <= prev_time)) {
+						t_next[i]++;
+					}
+					if ((t_next[i] < par[i]->stats->num_outliers) &&
+					    ((time == -1) ||
+					     (par[i]->stats->outliers[t_next[i]] < time))) {
+						thread = i;
+						time = par[i]->stats->outliers[t_next[i]];
+					}
+				}
+				if (time != -1) {
+					prev_time = par[thread]->stats->outliers[t_next[thread]];
+					printf(" %5lu", prev_time);
+					t_next[i]++;
+				}
+			} while (time != -1);
+
+			printf("\n");
+		}
+		for (i = 0; i < nthreads; i++) {
+			printf("# Thread %d:", i);
+			for (j = 0; j < par[i]->stats->num_outliers; j++)
+				printf(" %5lu", par[i]->stats->outliers[j]);
+			if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
+				printf(" # %5lu others",
+				       par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
+			printf("\n");
+		}
 	}
-	printf("\n");
 }
 
 static void print_stat(struct thread_param *par, int index, int verbose)
@@ -1563,14 +1609,15 @@ int main(int argc, char **argv)
 		/* allocate the histogram if requested */
 		if (histogram) {
 			int bufsize = histogram * sizeof(long);
+			int of_size = overflow_cycle * sizeof(long);
 
 			stat->hist_array = threadalloc(bufsize, node);
-			stat->outliers = threadalloc(bufsize, node);
+			stat->outliers = threadalloc(of_size, node);
 			if (stat->hist_array == NULL || stat->outliers == NULL)
 				fatal("failed to allocate histogram of size %d on node %d\n",
 				      histogram, i);
 			memset(stat->hist_array, 0, bufsize);
-			memset(stat->outliers, 0, bufsize);
+			memset(stat->outliers, 0, of_size);
 		}
 
 		if (verbose) {
@@ -1688,7 +1735,7 @@ int main(int argc, char **argv)
 		print_hist(parameters, num_threads);
 		for (i = 0; i < num_threads; i++) {
 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+			threadfree(statistics[i]->outliers, overflow_cycle*sizeof(long), parameters[i]->node);
 		}
 	}
 

