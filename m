From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Wed, 14 Nov 2012 14:18:31 -0800 (PST)
Message-ID: <391220951.54186924.1352931511228.JavaMail.root@vmware.com>
References: <943398371.54180912.1352931103535.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: frank rowand <frank.rowand@am.sony.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:56820 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933152Ab2KNWSc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2012 17:18:32 -0500
In-Reply-To: <943398371.54180912.1352931103535.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Bhavesh Davda <bhavesh@vmware.com>

Add a new command line option '-g' (long option '--of_max') to cap how many
outliers are tracked per thread. 

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
Here's my attempt at addressing Frank's suggestions. Please correct me if I've misunderstood what you were suggesting.

checkpatch.pl reported:

total: 2 errors, 5 warnings, 76 lines checked

but the warnings and errors seem consistent with existing cyclictest practice.
---
 src/cyclictest/cyclictest.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 824544f..a728c14 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -171,6 +171,7 @@ static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int histofall = 0;
+static int of_max = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
@@ -854,7 +855,7 @@ void *timerthread(void *param)
 		if (histogram) {
 			if (diff >= histogram) {
 				stat->hist_overflow++;
-                                if (stat->num_outliers < histogram)
+				if (stat->num_outliers < of_max)
 					stat->outliers[stat->num_outliers++] = stat->cycles;
 			}
 			else
@@ -930,6 +931,7 @@ static void display_help(int error)
 	       "                           to modify value to minutes, hours or days\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-g MAX   --of_max=MAX      Report cycle instances (up to MAX) for histogram overflows\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
                "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
@@ -1059,6 +1061,8 @@ static void process_options (int argc, char *argv[])
 			{"distance", required_argument, NULL, 'd'},
 			{"event", no_argument, NULL, 'E'},
 			{"ftrace", no_argument, NULL, 'f'},
+			{"ftrace", no_argument, NULL, 'f'},
+			{"of_max", required_argument, NULL, 'g'},
 			{"histogram", required_argument, NULL, 'h'},
 			{"histofall", required_argument, NULL, 'H'},
 			{"interval", required_argument, NULL, 'i'},
@@ -1090,8 +1094,8 @@ static void process_options (int argc, char *argv[])
 			{"priospread", no_argument, NULL, 'Q'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
-				    long_options, &option_index);
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efg:h:H:i:Il:MnNo:O:p:PmqQrsS"
+				    "t::uUvD:wWT:y:e:", long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1116,6 +1120,7 @@ static void process_options (int argc, char *argv[])
 		case 'd': distance = atoi(optarg); break;
 		case 'E': enable_events = 1; break;
 		case 'f': tracetype = FUNCTION; ftrace = 1; break;
+		case 'g': of_max = atoi(optarg); break;
 		case 'H': histofall = 1; /* fall through */
 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
@@ -1563,13 +1568,18 @@ int main(int argc, char **argv)
 		/* allocate the histogram if requested */
 		if (histogram) {
 			int bufsize = histogram * sizeof(long);
-
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
 
@@ -1688,7 +1698,7 @@ int main(int argc, char **argv)
 		print_hist(parameters, num_threads);
 		for (i = 0; i < num_threads; i++) {
 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+			threadfree(statistics[i]->outliers, of_max*sizeof(long), parameters[i]->node);
 		}
 	}
 
-- 
1.7.1

