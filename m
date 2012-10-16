From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Tue, 16 Oct 2012 10:02:53 -0700
Message-ID: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:54000 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753912Ab2JPRCy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 13:02:54 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Bhavesh Davda <bhavesh@vmware.com>

Add feature to cyclictest histogram mode to track cycle counts every time a
sample overflows the histogram limit. This should help identify if there is a
timing pattern to jitters in cyclictest runs.

Example output (with -h 10):
 ...
 Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000 00001
 Histogram Overflow at cycle number:
 Thread 0: 09964
 Thread 1: 00000 00004 00006 00008 00010 09962 11594
 Thread 2:
 Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
 Thread 4: 11574 11580 11583 11586
 Thread 5: 00020 09448 13954 14954 18954 20587 24973
 Thread 6:
 Thread 7: 18950
 ...

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 418538f..824544f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -150,6 +150,7 @@ struct thread_stat {
 	double avg;
 	long *values;
 	long *hist_array;
+        long *outliers;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
@@ -157,6 +158,7 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	long hist_overflow;
+        long num_outliers;
 };
 
 static int shutdown;
@@ -850,8 +852,11 @@ void *timerthread(void *param)
 
 		/* Update the histogram */
 		if (histogram) {
-			if (diff >= histogram)
+			if (diff >= histogram) {
 				stat->hist_overflow++;
+                                if (stat->num_outliers < histogram)
+					stat->outliers[stat->num_outliers++] = stat->cycles;
+			}
 			else
 				stat->hist_array[diff]++;
 		}
@@ -1401,6 +1406,17 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	if (histofall && nthreads > 1)
 		printf(" %05lu", alloverflows);
 	printf("\n");
+
+	printf("# Histogram Overflow at cycle number:\n");
+	for (i = 0; i < nthreads; i++) {
+		printf("# Thread %d:", i);
+		for (j = 0; j < par[i]->stats->num_outliers; j++)
+			printf(" %05lu", par[i]->stats->outliers[j]);
+		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
+			printf(" # %05lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
+		printf("\n");
+	}
+	printf("\n");
 }
 
 static void print_stat(struct thread_param *par, int index, int verbose)
@@ -1549,10 +1565,12 @@ int main(int argc, char **argv)
 			int bufsize = histogram * sizeof(long);
 
 			stat->hist_array = threadalloc(bufsize, node);
-			if (stat->hist_array == NULL)
+			stat->outliers = threadalloc(bufsize, node);
+			if (stat->hist_array == NULL || stat->outliers == NULL)
 				fatal("failed to allocate histogram of size %d on node %d\n",
 				      histogram, i);
 			memset(stat->hist_array, 0, bufsize);
+			memset(stat->outliers, 0, bufsize);
 		}
 
 		if (verbose) {
@@ -1668,8 +1686,10 @@ int main(int argc, char **argv)
 
 	if (histogram) {
 		print_hist(parameters, num_threads);
-		for (i = 0; i < num_threads; i++)
+		for (i = 0; i < num_threads; i++) {
 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
+			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+		}
 	}
 
 	if (tracelimit) {
-- 
1.7.1


