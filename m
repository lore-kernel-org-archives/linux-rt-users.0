From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH RT-TESTS] cyclictest: whitespace cleanup
Date: Tue, 16 Oct 2012 09:39:56 -0700
Message-ID: <F285BDD9-9A4A-4B58-B69F-90F18B9D7B4D@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:43954 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754742Ab2JPQj5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 12:39:57 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Bhavesh Davda <bhavesh@vmware.com>

Cosmetic whitespace cleanup

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 11b6cea..418538f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -200,12 +200,12 @@ static int32_t latency_target_value = 0;
 
 /* Latency trick
  * if the file /dev/cpu_dma_latency exists,
- * open it and write a zero into it. This will tell 
- * the power management system not to transition to 
+ * open it and write a zero into it. This will tell
+ * the power management system not to transition to
  * a high cstate (in fact, the system acts like idle=poll)
  * When the fd to /dev/cpu_dma_latency is closed, the behavior
  * goes back to the system default.
- * 
+ *
  * Documentation/power/pm_qos_interface.txt
  */
 static void set_latency_target(void)
@@ -380,7 +380,7 @@ void tracing(int on)
 		switch (kernelversion) {
 		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
 		case KV_26_LT24: prctl(0, 1); break;
-		case KV_26_33: 
+		case KV_26_33:
 		case KV_30:
 			write(trace_fd, "1", 1);
 			break;
@@ -390,7 +390,7 @@ void tracing(int on)
 		switch (kernelversion) {
 		case KV_26_LT18: gettimeofday(0,0); break;
 		case KV_26_LT24: prctl(0, 0); break;
-		case KV_26_33: 
+		case KV_26_33:
 		case KV_30:
 			write(trace_fd, "0", 1);
 			break;
@@ -720,7 +720,7 @@ void *timerthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	if (setscheduler(0, par->policy, &schedp)) 
+	if (setscheduler(0, par->policy, &schedp))
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
 	/* Get current time */
@@ -907,7 +907,7 @@ static void display_help(int error)
 		if (kernvar(O_RDONLY, "available_tracers", tracers, sizeof(tracers)))
 			strcpy(tracers, "none");
 	}
-		
+
 	printf("cyclictest V %1.2f\n", VERSION_STRING);
 	printf("Usage:\n"
 	       "cyclictest <options>\n\n"
@@ -933,7 +933,7 @@ static void display_help(int error)
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
-	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n" 
+	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
@@ -1043,7 +1043,7 @@ static void process_options (int argc, char *argv[])
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (;;) {
- 		int option_index = 0;
+		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
@@ -1128,8 +1128,8 @@ static void process_options (int argc, char *argv[])
 		case 'N': use_nsecs = 1; break;
 		case 'o': oscope_reduction = atoi(optarg); break;
 		case 'O': traceopt(optarg); break;
-		case 'p': 
-			priority = atoi(optarg); 
+		case 'p':
+			priority = atoi(optarg);
 			if (policy != SCHED_FIFO && policy != SCHED_RR)
 				policy = SCHED_FIFO;
 			break;
@@ -1158,9 +1158,9 @@ static void process_options (int argc, char *argv[])
 			else
 				num_threads = max_cpus;
 			break;
-		case 'T': 
+		case 'T':
 			tracetype = CUSTOM;
-			strncpy(tracer, optarg, sizeof(tracer)); 
+			strncpy(tracer, optarg, sizeof(tracer));
 			break;
 		case 'u': setvbuf(stdout, NULL, _IONBF, 0); break;
 		case 'v': verbose = 1; break;
@@ -1250,7 +1250,7 @@ static void process_options (int argc, char *argv[])
 		error = 1;
 
 	if (priospread && priority == 0) {
-		fprintf(stderr, "defaulting realtime priority to %d\n", 
+		fprintf(stderr, "defaulting realtime priority to %d\n",
 			num_threads+1);
 		priority = num_threads+1;
 	}
@@ -1261,7 +1261,7 @@ static void process_options (int argc, char *argv[])
 	}
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) && priority == 0) {
-		fprintf(stderr, "defaulting realtime priority to %d\n", 
+		fprintf(stderr, "defaulting realtime priority to %d\n",
 			num_threads+1);
 		priority = num_threads+1;
 	}
@@ -1303,7 +1303,7 @@ static int check_kernel(void)
 		kv = KV_30;
 		strcpy(functiontracer, "function");
 		strcpy(traceroptions, "trace_options");
-		
+
 	} else
 		kv = KV_NOT_SUPPORTED;
 
@@ -1385,7 +1385,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	printf("# Max Latencies:");
 	maxmax = 0;
 	for (j = 0; j < nthreads; j++) {
- 		printf(" %05lu", par[j]->stats->max);
+		printf(" %05lu", par[j]->stats->max);
 		if (par[j]->stats->max > maxmax)
 			maxmax = par[j]->stats->max;
 	}
@@ -1395,7 +1395,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	printf("# Histogram Overflows:");
 	alloverflows = 0;
 	for (j = 0; j < nthreads; j++) {
- 		printf(" %05lu", par[j]->stats->hist_overflow);
+		printf(" %05lu", par[j]->stats->hist_overflow);
 		alloverflows += par[j]->stats->hist_overflow;
 	}
 	if (histofall && nthreads > 1)
@@ -1416,7 +1416,7 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 			else
                                 fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-                        printf(fmt, index, stat->tid, par->prio, 
+                        printf(fmt, index, stat->tid, par->prio,
                                par->interval, stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
@@ -1679,7 +1679,7 @@ int main(int argc, char **argv)
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
 		}
 	}
-	
+
 
 	for (i=0; i < num_threads; i++) {
 		if (!statistics[i])
-- 
1.7.1


