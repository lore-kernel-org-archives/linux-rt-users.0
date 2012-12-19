From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH 2/3] cyclictest: Report histogram overflow instances in seconds since start
Date: Wed, 19 Dec 2012 12:00:32 -0800
Message-ID: <1355947233-31451-3-git-send-email-bhavesh@vmware.com>
References: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Cc: frank.rowand@am.sony.com, jkacur@redhat.com,
	Bhavesh Davda <bhavesh@vmware.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:49510 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258Ab2LSUA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 15:00:56 -0500
In-Reply-To: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This enhancement comes courtesy of Frank Rowand. It simplifies post-processing
of the outliers output. Note that the time reported is the "expected" wake-up
time for the outlier, not the "actual" wake-up time.

$ sudo ./cyclictest -p 99 -m -n -a -h 5 -g 50 -t4 -D 30
  /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.14 0.07 0.02 1/392 17548

T: 0 (17514) P:99 I:1000 C:  29994 Min:      2 Act:    4 Avg:    3 Max:      25
T: 1 (17515) P:99 I:1000 C:  29992 Min:      2 Act:    4 Avg:  158 Max:   53753
T: 2 (17516) P:99 I:1000 C:  29990 Min:      2 Act:    3 Avg:    3 Max:       8
T: 3 (17517) P:99 I:1000 C:  29988 Min:      2 Act:    3 Avg:    4 Max:    5217
  Histogram
000000 000000	000000	000000	000000
000001 000000	000000	000000	000000
000002 000270	000026	000059	001742
000003 018558	002344	010656	007578
000004 011044	023196	019209	018014
  Total: 000029872 000025566 000029924 000027334
  Min Latencies: 00002 00002 00002 00002
  Avg Latencies: 00003 00158 00003 00004
  Max Latencies: 00025 53753 00008 05217
  Histogram Overflows: 00128 04432 00072 02660
  Histogram Overflow: time (sec), thread
0.003019264 0
0.004019264 0
...
0.005076667 1
0.006076667 1
...
0.007151408 2
0.008151408 2
...
0.009228138 3
0.019228138 3
...

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   42 ++++++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 141e79f..b27f7dc 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -110,6 +110,8 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 
 int enable_events;
 
+struct timespec test_start;
+
 static char *policyname(int policy);
 
 enum {
@@ -151,7 +153,7 @@ struct thread_stat {
 	double avg;
 	long *values;
 	long *hist_array;
-        long *outliers;
+	struct timespec *outliers;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
@@ -337,6 +339,18 @@ static inline void tsnorm(struct timespec *ts)
 	}
 }
 
+static inline void tsnorm2(struct timespec *ts)
+{
+	while (ts->tv_nsec < 0) {
+		ts->tv_nsec += NSEC_PER_SEC;
+		ts->tv_sec--;
+	}
+	while (ts->tv_nsec >= NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
 static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
 {
 	int64_t diff;
@@ -890,7 +904,7 @@ void *timerthread(void *param)
 			if (diff >= histogram) {
 				stat->hist_overflow++;
 				if (stat->num_outliers < of_max)
-					stat->outliers[stat->num_outliers++] = stat->cycles;
+					stat->outliers[stat->num_outliers++] = next;
 			}
 			else
 				stat->hist_array[diff]++;
@@ -1462,14 +1476,15 @@ static void print_hist(struct thread_param *par[], int nthreads)
 		printf(" %05lu", alloverflows);
 	printf("\n");
 
-	printf("# Histogram Overflow at time (ms):\n");
+	printf("# Histogram Overflow: time (sec), thread\n");
 	for (i = 0; i < nthreads; i++) {
-		printf("# Thread %d:", i);
-		for (j = 0; j < par[i]->stats->num_outliers; j++)
-			printf(" %lu", par[i]->stats->outliers[j] * par[i]->interval / 1000);
-		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
-			printf(" # %lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
-		printf("\n");
+		for (j = 0; j < par[i]->stats->num_outliers; j++) {
+			struct timespec diff;
+			diff.tv_sec  = par[i]->stats->outliers[j].tv_sec  - test_start.tv_sec;
+			diff.tv_nsec = par[i]->stats->outliers[j].tv_nsec - test_start.tv_nsec;
+			tsnorm2(&diff);
+			printf("%ld.%09ld %d\n", diff.tv_sec, diff.tv_nsec, i);
+		}
 	}
 }
 
@@ -1663,6 +1678,13 @@ int main(int argc, char **argv)
 	if (!statistics)
 		goto outpar;
 
+	/*
+	 * test_start does not need to be precise.  For some types of output,
+	 * it will be subtracted from a time value so that the result is
+	 * relative to the start of test.
+	 */
+	clock_gettime(clocksources[clocksel], &test_start);
+
 	for (i = 0; i < num_threads; i++) {
 		pthread_attr_t attr;
 		int node;
@@ -1722,7 +1744,7 @@ int main(int argc, char **argv)
 			memset(stat->hist_array, 0, bufsize);
 		}
 		if (of_max) {
-			int bufsize = of_max * sizeof(long);
+			int bufsize = of_max * sizeof(*stat->outliers);
 			stat->outliers = threadalloc(bufsize, node);
 			if (stat->outliers == NULL)
 				fatal("failed to allocate outliers of size %d on node %d\n",
-- 
1.7.4.1

