From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH] cyclictest histogram overflow instance tracking
Date: Thu, 11 Oct 2012 11:42:58 -0700
Message-ID: <21A665E0-66F4-4C7E-BDB2-820DDC5398C8@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Garrett Smith <garrett@vmware.com>,
	Lenin Singaravelu <lsingara@vmware.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:60136 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756551Ab2JKSnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 14:43:00 -0400
Received: from sc9-mailhost1.vmware.com (sc9-mailhost1.vmware.com [10.113.161.71])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id A53CF28276
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Oct 2012 11:42:59 -0700 (PDT)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Bhavesh Davda <bhavesh@vmware.com>

Add feature to cyclictest histogram mode to track cycle counts every time a
sample overflows the histogram limit. This should help identify if there is a
timing pattern to jitters in cyclictest runs.

Example output (with -h 10):
  ...
  Histogram Overflows: 00278
  Histogram Overflow instances:
    09373 09374 09375 09376 09377 09378 09379 09380 09381 09382 # 00268 others

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 731b4bd..31131ad 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -147,6 +147,7 @@ struct thread_stat {
 	double avg;
 	long *values;
 	long *hist_array;
+        unsigned long *outliers;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
@@ -154,6 +155,8 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	long hist_overflow;
+        long num_outliers;
+        long outliers_overflow;
 };
 
 static int shutdown;
@@ -756,8 +759,13 @@ void *timerthread(void *param)
 
 		/* Update the histogram */
 		if (histogram) {
-			if (diff >= histogram)
+			if (diff >= histogram) {
 				stat->hist_overflow++;
+				if (stat->num_outliers < histogram)
+					stat->outliers[stat->num_outliers++] = stat->cycles - 1;
+				else
+					stat->outliers_overflow++;
+			}
 			else
 				stat->hist_array[diff]++;
 		}
@@ -1226,7 +1234,7 @@ static void print_tids(struct thread_param *par[], int nthreads)
 
 static void print_hist(struct thread_param *par[], int nthreads)
 {
-	int i, j;
+	int i, j, k;
 	unsigned long long int log_entries[nthreads+1];
 	unsigned long maxmax, alloverflows;
 
@@ -1280,9 +1288,19 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	printf("# Histogram Overflows:");
 	alloverflows = 0;
 	for (j = 0; j < nthreads; j++) {
- 		printf(" %05lu", par[j]->stats->hist_overflow);
+		printf(" %05lu", par[j]->stats->hist_overflow);
 		alloverflows += par[j]->stats->hist_overflow;
 	}
+	printf("\n");
+	printf("# Histogram Overflow instances:\n");
+	for (j = 0; j < nthreads; j++) {
+		for (k = 0; k < par[j]->stats->num_outliers; k++)
+			printf(" %05lu", par[j]->stats->outliers[k]);
+		if (par[j]->stats->outliers_overflow > 0)
+			printf(" # %05lu others", par[j]->stats->outliers_overflow);
+                printf("\n");
+        }
+
 	if (histofall && nthreads > 1)
 		printf(" %05lu", alloverflows);
 	printf("\n");
@@ -1434,10 +1452,12 @@ int main(int argc, char **argv)
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
@@ -1553,8 +1573,10 @@ int main(int argc, char **argv)
 
 	if (histogram) {
 		print_hist(parameters, num_threads);
-		for (i = 0; i < num_threads; i++)
+		for (i = 0; i < num_threads; i++) {
 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
+			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+                }
 	}
 
 	if (tracelimit) {
-- 
1.7.1


