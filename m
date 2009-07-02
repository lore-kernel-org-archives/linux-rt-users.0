From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH] cyclictest: handle latencies which exceed the histogram
 limit; handle oom.
Date: Wed, 01 Jul 2009 19:16:29 -0700
Message-ID: <1246500989.32598.27.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Daniel Gollub <gollub@b1-systems.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41714 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZGBCQh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 22:16:37 -0400
Received: by ewy6 with SMTP id 6so1712427ewy.37
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 19:16:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Subject: [PATCH] Subject: Handle doomsday latency for cyclictest in histogram mode
From: Daniel Gollub <dgollub@suse.de>
Don't miss latency which exceed the histogram limit - 
instead sample limit exceeding latency in the last bucket.

This is a leftover from cyclictest_histogram.patch:
-> Todo: Currently cyclictest does not report the number of samples
-> that exceeded the histogram max latency.

Handle OOM.

Signed-off-by: Daniel Gollub <dgollub@suse.de>
Reviewed-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
--
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3e2d500..be4cc52 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -72,6 +72,8 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
 
+#define HIST_MAX		1000000
+
 #define MODE_CYCLIC		0
 #define MODE_CLOCK_NANOSLEEP	1
 #define MODE_SYS_ITIMER		2
@@ -98,8 +100,6 @@ enum {
 	WAKEUPRT,
 };
 
-#define HIST_MAX		1000000
-
 /* Struct to transfer parameters to the thread */
 struct thread_param {
 	int prio;
@@ -141,6 +141,7 @@ static int oscope_reduction = 1;
 static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
+static int histogram_limit_exceeded = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 
@@ -688,7 +689,16 @@ void *timerthread(void *param)
 		if (par->bufmsk)
 			stat->values[stat->cycles & par->bufmsk] = diff;
 
-		if (histogram && (diff < histogram))
+		/* When histogram limit got exceed, mark limit as exceeded,
+		 * and use last bucket to recored samples of, exceeding 
+		 * latency spikes.
+		 */
+		if (histogram && diff >= histogram) {
+			histogram_limit_exceeded = 1;
+			diff = histogram - 1;
+		}
+
+		if (histogram)
 			stat->hist_array[diff] += 1;
 
 		next.tv_sec += interval.tv_sec;
@@ -926,6 +936,9 @@ static void process_options (int argc, char *argv[])
 	if (histogram < 0)
 		error = 1;
 
+	if (histogram > HIST_MAX)
+		histogram = HIST_MAX;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
@@ -1128,9 +1141,12 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < num_threads; i++) {
 		if (histogram) {
-			if (histogram > HIST_MAX)
-				histogram = HIST_MAX;
 			stat[i].hist_array = calloc(histogram, sizeof(long));
+			if (!stat[i].hist_array) {
+				fprintf(stderr, "Cannot allocate enough memory for histogram limit %d: %s",
+						histogram, strerror(errno));
+				exit(EXIT_FAILURE);
+			}
 		}
 
 		if (verbose) {
@@ -1191,7 +1207,8 @@ int main(int argc, char **argv)
 		if (!verbose && !quiet)
 			printf("\033[%dA", num_threads + 2);
 	}
-	ret = 0;
+	ret = EXIT_SUCCESS;
+
  outall:
 	shutdown = 1;
 	usleep(50000);
@@ -1232,5 +1249,12 @@ int main(int argc, char **argv)
 	if (kernelversion != KV_26_CURR)
 		restorekernvars();
 
+	if (histogram && histogram_limit_exceeded) {
+		ret = EXIT_FAILURE;
+		fprintf(stderr, "ERROR: Histogram limit got exceeded at least once!\n"
+				"Limit exceeding got sampled in last bucket.\n");
+
+	}
+
 	exit(ret);
 }


